Return-Path: <netdev+bounces-253792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MByfI02OeGmqqwEAu9opvQ
	(envelope-from <netdev+bounces-253792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:07:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2D926CE
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB53C3013ECB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54DD2E7621;
	Tue, 27 Jan 2026 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="RNEPDd56"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871312E7166;
	Tue, 27 Jan 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508424; cv=none; b=EsnRoXaAATv3EgOWT7DOh9gdVO1clpBfKrV/+ygRSg19Mce3BtP73Gizhj6JdbN6AYV6YCvB9nXkOqmgxSRuZ5VXWNRupMZM5qIPNNUJbRWalCUxk6QyIxsbiGGHe4ZYg3u26wTHsqqGhQyHz2PeYV2bP1HAOhoAxknEq4UIXbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508424; c=relaxed/simple;
	bh=vvrMhJs0YBove3hTWVczx/F0E1j64fXCbcJxZA41GM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q395xGr9R3Qt1ToKZ5TFi2j4raBd6A0RVH9VkOPqVqM08MbH8t/r/b/HU5aJQCauYLaeO5VnyPo+P4zLpOqeB62+xXVWgUbo0QUMeYPRSf/bCRS08oSKVWAoLpx57nZpRvGmzJ5s5oM3g8gykwY6LD48aZ1dArrKUL3PUgk916o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=RNEPDd56; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3220d013d;
	Tue, 27 Jan 2026 18:06:50 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jianhao.xu@seu.edu.cn,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	marco.crivellari@suse.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	zilin@seu.edu.cn
Subject: Re: [net,v2,1/2] net: liquidio: Fix off-by-one error in setup_nic_devices() cleanup
Date: Tue, 27 Jan 2026 10:06:48 +0000
Message-Id: <20260127100648.957628-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aXeOl5D7BR-xnEgm@horms.kernel.org>
References: <aXeOl5D7BR-xnEgm@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bfeeb947a03a1kunm7811029b48abc
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT09CVkMYTx4aSUkeSUhDGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RNEPDd56RNS41rjPCYzVNIdgynzEP2uVvkyMIP2JNpUr/KX9IElKVueH50q8dHCkjniEVcMCOujBgmv3xdRXEIxAuxElWZOXM+0txetg/DZOieUdew9S8L6RKkOk6IuRM/Ycksv2ara7m1oOE7qIDhbaXZyEbZ5hYF2SctLBwWQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=j6Y2k0clA9t998gV4fxQT8R9+5/RvLiHvl7iV4bCcbo=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253792-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Queue-Id: D0F2D926CE
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 03:56:07PM +0000, Simon Horman wrote:
> On Mon, Jan 26, 2026 at 03:50:39PM +0000, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> > ---
> > net: liquidio: Fix off-by-one error in setup_nic_devices() cleanup
> > 
> > This patch changes the cleanup loop from while(i--) to do{}while(i--)
> > to ensure that when a device fails to initialize, it gets cleaned up
> > along with all previously initialized devices.
> > 
> > > diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > > index 0732440eeacd..3ba2806f5d1e 100644
> > > --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > > +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > > @@ -3765,11 +3765,11 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
> > >
> > >  setup_nic_dev_free:
> > >
> > > -	while (i--) {
> > > +	do {
> > >  		dev_err(&octeon_dev->pci_dev->dev,
> > >  			"NIC ifidx:%d Setup failed\n", i);
> > >  		liquidio_destroy_nic_device(octeon_dev, i);
> > > -	}
> > > +	} while (i--);
> > 
> > In lio_main.c, setup_nic_devices() can also reach setup_nic_dev_free from
> > the devlink_alloc() failure path after the main for loop completes. At that
> > point i equals ifcount (the loop counter has been incremented past the last
> > valid device).
> > 
> > With the do-while change, the first iteration will call
> > liquidio_destroy_nic_device(octeon_dev, ifcount) for a device index that
> > was never initialized. The function has a guard for NULL netdev so it will
> > not crash, but it will print a spurious error message about a device that
> > never existed.
> > 
> > The fix works correctly for failures within the loop (which is the case
> > described in the commit message), but is there a way to handle the
> > post-loop devlink_alloc() failure case without printing the spurious
> > error message?
> 
> Sorry for not realising this when I made this suggestion in
> my review of v1.
> 
> Also, I would suggest splitting this patch in two: one patch
> per driver.

Hi Simon,

Apologies from my side as well; I overlooked the devlink_alloc failure 
path myself.

As noted, the loop index i is indeed invalid at that point. I will fix
this by decrementing i in the error path to ensure it points to the last
successfully initialized device before cleanup.

I will also split this patch into two separate patches in v3 as requested.

Regards,
Zilin

