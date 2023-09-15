Return-Path: <netdev+bounces-34065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E65E7A1EE7
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB57F2826AE
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839A610794;
	Fri, 15 Sep 2023 12:41:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B82CA70
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:41:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFA2B8
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/K5i2IsXgbEDKlCuOomRbYpzH/HWfq3W48itS0NfOh0=; b=lFT9iC2u5i2t06+z5yhbo4C0gb
	i0xTM5LEv1L8+9uj0D8TgbgNoLOCjjpQ3kDMqcW89HhkBl+qlVXWSfpvNwfkhQnpoEvE33qPP9zRz
	4WYfD2L7A8XY4lJEZ+IftOu3/r6lGmT3/03LJ3whCykU5Ok2p5YwrdyicawiHpULDooE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qh88G-006Xak-N1; Fri, 15 Sep 2023 14:41:12 +0200
Date: Fri, 15 Sep 2023 14:41:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net] amd-xgbe: read STAT1 register twice to get correct
 value
Message-ID: <4f54056f-dac4-4ad8-8f87-0837334d1b01@lunn.ch>
References: <20230914041944.450751-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914041944.450751-1-Raju.Rangoju@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 09:49:44AM +0530, Raju Rangoju wrote:
> Link status is latched low, so read once to clear
> and then read again to get current state.

I don't know about your PHY implementation, but within phylib and
Linux PHY drivers, this is considered wrong. You loose out on being
notified of the link going down and then back up again. Or up and then
down again.

But since this is not a Linux PHY driver, you are free to do whatever
you want...

Also, i believe it is latched, not latched low. So i think your commit
message is wrong. You should probably check with IEEE 802.3 clause 22.

    Andrew

