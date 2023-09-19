Return-Path: <netdev+bounces-34962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3294E7A631C
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A971C20D63
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE09E1381;
	Tue, 19 Sep 2023 12:37:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE6180
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 12:37:01 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B75B8;
	Tue, 19 Sep 2023 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=inDk8N2T125IGZw+Hvw9eF0VsCxTLPPSLhsQjE3UgpY=; b=nL2uvseSs2yqXWXhKPqR78UOq0
	esDuwFxeHYnNEplu9VCpGpq9hHvusQFo0bx9moXbrq6jE6m3v5TL1LzHh/M2Ahsm9MLXnansfQFt7
	hksjP/eSBLlbcdwPGIiyTbGUsdrg0feCi4ji6a8PCgU9hA9tvOV1qVaOrF56W7WnRUQ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qiZyM-006uRA-4Z; Tue, 19 Sep 2023 14:36:58 +0200
Date: Tue, 19 Sep 2023 14:36:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: netif_carrier_on() race
Message-ID: <a0734a8e-5681-4fd1-8cf0-bcb63a43f897@lunn.ch>
References: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> All of this makes sense since you need to hold RTNL for all those state
> changes/notifier chains, but it does lead to the first race/consistency
> problem: if you query at just the right time you can see carrier being
> on, however, if the carrier is actually removed again and the linkwatch
> work didn't run yet, there might never be an event for the carrier on,
> iow, you might have:
> 
>  netif_carrier_on()
>  query from userspace and see carrier on
>  netif_carrier_off()
>  linkwatch work runs and sends only carrier off event
> 
> This is at least a bit confusing, but not really my main problem here,
> though it did in fact happen to me as well, in a fashion.

That is interesting. Copper Ethernet PHYs might have the opposite
problem. The status bit about link is latching low. This means that if
the link is lost and then very quickly comes back again, you always
get to see the lost and then restored link. So maybe we have:

  netif_carrier_off()
  query from userspace and see carrier off
  netif_carrier_oon()
  linkwatch work runs and sends only carrier on event

???

Maybe we want linkwatch to keep the old and the new state. If there is
a change reported while there is still work queued, which flips a bit
back to its old state, it needs to block until the work is actually
done?

> Possible solution #2:
> ---------------------
> Another - more feasible - option might be to say OK, so the associated
> event (and a few friends) are the problem, so we can queue those events
> in cfg80211, and only release them on NETDEV_CHANGE notifier call.
> That's from netdev_state_change() after dev_activate() in linkwatch
> work. We'd want to pair it with netif_carrier_on() so we actually expect
> the event to come, and maybe give netif_carrier_on() a return value
> indicating that it scheduled - or else check using carrier_up_count
> perhaps?

Probably not an issue with 802.11, but sometimes drivers do odd things
with the carrier because of the BMC. The BMC can have a side channel
into the hosts NIC, which allows it to share the hosts PHY and RJ45
socket. So that the BMC can send/receive frames while the host NIC is
admin down, the carrier might actually be up. And requests to down the
carrier are ignored.

As i said, probably irrelevant to 802.11, but if you try to make a
generic solution, you might need to watch out for this.

	Andrew

