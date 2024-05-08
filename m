Return-Path: <netdev+bounces-94470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F48BF931
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011351F2382A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F201E71742;
	Wed,  8 May 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DURQmnno"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23172537F2;
	Wed,  8 May 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158908; cv=none; b=eXfcuGQf6BIy1k1QcZ+3ccddVu26qtNmbdtriXZApQf+2qKDytVER5yv+s45ZSA90O3RRB07eUB1zY6XbDZmqvSf6TTem7B2h0OSSDRpzBOPkmQXDC2A8QidRXO64wldxev3P9bogR2eulHnUAyJ/rcpmTx+gGsDaXG5XL+zDE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158908; c=relaxed/simple;
	bh=wAUIHDwJWti/Qtu1rVeMco4tYKMnZhzWFK1YVr5s2h4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLld4yBq+cu3dmlwC0dyHjaBIPTHff8Cg3qx/n1Bjyc7Jb5sH1TtzA/0Uc5mVgtXxWczZwzptyPkY3dcI+PWE9DG6cBRZPpLt83rwv2crFyJjY/f6J2KaO54kYZKiV8f7oHbwCjPwFNwR7ttiI6px4Y+p0BjAXeU7iqOx7gOfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DURQmnno; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VZ89X13K6z9sRx;
	Wed,  8 May 2024 10:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1715158512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgTa174CN4twtJVuodBezk0b2vWnBKWssMs5UWGeMhE=;
	b=DURQmnnoX8sm4mSH2+Wiww+tChze7TvUiyZS+n2y2rVSOBoJXb5ppk/y7HqkmmEuUINXx7
	EyqnuylnRlAwf77RwpnGTSJILDfxnX1FUVI8ZrehNhEtcaTHHZTy6M+wNwOVOUPO2RbMaM
	UeHRH9PSgD31eUfIWwtRjUC/3qvwxu3Wd5ImjKpbczOWgcSw868cjExUJn6axBs7pLtUSf
	nI2PknUfuA92H5l8KI5gdBfriQCCrsWW+pFz+l1KMguYCBTTE+ZgV/G68jGwXcFJCrtmdz
	PGmwcn2syJUh1ivzuEfbD8bo8CB4EguP0f8b+x1MoMyYrt0ovmllRs6JmNQdLA==
Date: Wed, 8 May 2024 10:55:05 +0200
From: Erhard Furtner <erhard_f@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 1 at net/core/netpoll.c:370
 netpoll_send_skb+0x1fc/0x20c at boot when netconsole is enabled (kernel
 v6.9-rc5, v6.8.7, sungem, PowerMac G4 DP)
Message-ID: <20240508105505.098efd6c@yea>
In-Reply-To: <20240506181020.292b25f0@kernel.org>
References: <20240428125306.2c3080ef@legion>
	<20240429183630.399859e2@kernel.org>
	<20240505232713.46c03b30@yea>
	<20240506072645.448bc49f@kernel.org>
	<20240507024258.07980f55@yea>
	<20240506181020.292b25f0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oi1ksroanrx3buqynk4yf9m64a7ii418
X-MBO-RS-ID: 34bc1399a180a3c52e3

On Mon, 6 May 2024 18:10:20 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Excellent! Do you want to submit that as an official patch?
> The explanation is that we can't call disable_irq() from atomic
> context (which which netpoll runs). But the callback is no longer
> necessary as we can depend on NAPI to do the polling these days.

I could do that with the explanation you stated. But should any further questions arise in this process I would also lack the technical background to deal with them. ;)

I also noticed a similar #ifdef CONFIG_NET_POLL_CONTROLLER logic shows up in
many network drivers, e.g. net/ethernet/realtek/8139too.c:

#ifdef CONFIG_NET_POLL_CONTROLLER
static void rtl8139_poll_controller(struct net_device *dev);
#endif
[...]
#ifdef CONFIG_NET_POLL_CONTROLLER
/*
 * Polling receive - used by netconsole and other diagnostic tools
 * to allow network i/o with interrupts disabled.
 */
static void rtl8139_poll_controller(struct net_device *dev)
{
        struct rtl8139_private *tp = netdev_priv(dev);
       	const int irq = tp->pci_dev->irq;

       	disable_irq_nosync(irq);
       	rtl8139_interrupt(irq, dev);
       	enable_irq(irq);
}
#endif
[...]
#ifdef CONFIG_NET_POLL_CONTROLLER
       	.ndo_poll_controller    = rtl8139_poll_controller,
#endif


Should it be removed here too? This would be more cards I can test. So far I only see this on my G4 and I think something similar on an old Pentium4 box I no longer have. 
 
> > What I still get with 'modprobe -v dev_addr_lists_test', even with gem_poll_controller() removed is:
> > 
> > [...]
> > KTAP version 1
> > 1..1
> >     KTAP version 1
> >     # Subtest: dev-addr-list-test
> >     # module: dev_addr_lists_test
> >     1..6
> > 
> > ====================================
> > WARNING: kunit_try_catch/1770 still has locks held!
> > 6.9.0-rc6-PMacG4-dirty #5 Tainted: G        W        N
> > ------------------------------------
> > 1 lock held by kunit_try_catch/1770:
> >  #0: c0dbfce4 (rtnl_mutex){....}-{3:3}, at: dev_addr_test_init+0xbc/0xc8 [dev_addr_lists_test]  
> 
> I think that's fixed in net-next.

Ah, good to hear!

Regards,
Erhard F.

