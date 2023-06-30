Return-Path: <netdev+bounces-14843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80F7440E2
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 19:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0707128103A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23499171AF;
	Fri, 30 Jun 2023 17:08:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336C168DA
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 17:08:50 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5994D35B6
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JKbZAJo+Gsc90i9iVK6YnrqT3QsBEPyAupa061obTYg=; b=MQwJg5YclFPstdYVmNIU+l2PAt
	J5ooiOuLK14cB8u4xgexYmR7w88OSdIat0CnGYxA9qX5rM/sd4DPNqPnzLiVWwTJRf3uYOBTCHZxm
	bLGp3m4CrjvP2C3WDM5h5jqUcF8okkkBj+HKu28mHFQyqaHcjCy+SJpX9EDOr8j5wD/o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qFHbz-000KCG-9U; Fri, 30 Jun 2023 19:08:47 +0200
Date: Fri, 30 Jun 2023 19:08:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Disable TX path on eth I/F from driver?
Message-ID: <56dac46c-37f8-431b-82b2-bfa75e9e63a2@lunn.ch>
References: <e267c94aad6f2a7f0427832d13afc60e6bcd5c6e.camel@infinera.com>
 <abb946fd-3acd-4353-8cda-72773914455d@lunn.ch>
 <377d93c3816a3c63269b894e3d865baace175966.camel@infinera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377d93c3816a3c63269b894e3d865baace175966.camel@infinera.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 04:57:31PM +0000, Joakim Tjernlund wrote:
> On Fri, 2023-06-30 at 18:50 +0200, Andrew Lunn wrote:
> > On Fri, Jun 30, 2023 at 03:48:15PM +0000, Joakim Tjernlund wrote:
> > > We have a few eth I/F that is for monitoring only, if any TX one gets:
> > > NETDEV WATCHDOG: trap0 (xr-ccip): transmit queue 0 timed out
> > > [   55.903074] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:477 dev_watchdog+0x138/0x160
> > > [   55.911380] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.109-00161-g1268ae25c302-dirty #7
> > > <long trace snipped>
> > > 
> > > I would like to, from within the driver, disable the TX path so the IP stack cannot TX any
> > > pkgs but cannot find a way to do so.
> > > Is there a way(to at least avid the NETDEV WATCHDOG msg) disable TX?
> > > On kernel 5.15
> > 
> > Have you tried using TC or iptables to just unconditionally drop all
> > packets?
> > 
> 
> No, this is an embedded target with no iptables/TC
> Would be much nicer if I could do this in driver.

I would argue it is much uglier. You need to hack the kernel driver to
throw away packets, vs just installing a couple extra packages and us
a supported mechanism to throw packets away.

Anyway, if you want to hack the driver, simply replace its
.ndo_start_xmit with

https://elixir.bootlin.com/linux/v6.4/source/drivers/net/dummy.c#L59

static netdev_tx_t dummy_xmit(struct sk_buff *skb, struct net_device *dev)
{
	dev_lstats_add(dev, skb->len);

	skb_tx_timestamp(skb);
	dev_kfree_skb(skb);
	return NETDEV_TX_OK;
}

	Andrew

