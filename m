Return-Path: <netdev+bounces-146246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D03C9D26D6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F12280624
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADBF1CC8AE;
	Tue, 19 Nov 2024 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hl02erM0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17212B93
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022959; cv=none; b=kDSk+Igc84ZmCH7K+vK2rGmofwklMol7xcdzbtFSBVMgknnQPkx9mcL533KrsTylJzjGQ22lzVtTFyGC/GxNBWsYxwfuQwzo5lp/Q3+cMMvgmpEjtDCdHohMNmw9ESuZeLseVCWMDqklVRUc73TuBgwOpPxJ9avpxc++T3CxNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022959; c=relaxed/simple;
	bh=OFMtQQGkYNSogaygt0GGLKqqJMELOnRHLhJE/uoLrcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/IB035DslfLngI+RtzEvt1EKZc1eZofRSxmruRDKPapg35R36tV50Ne/GXAYqp9rixAzgf7JazRlb1lX4bqRdrO7ZcSXkM0EJ9gDkPLb8ltSfHqycvmaECF5D4Pau9v4gM7f76B/AbD2NeudBVnLDihOAYhrNZOhLH9tZWhbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hl02erM0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vn2P3uTBsRzvIZ/3XFhSCNNfBKVD7HxBRa4ItsoU5N0=; b=hl02erM0p9DX9taBwi8MCFbwXj
	ybI8z4xKO7OXzr1UBQb2j/EdVowSA6jCt3YCGA1KWrzvj6VEf2Rw3Hh+cFZkQfGfvYV/UrBFYKZnc
	oDjgSFMsiBQHJIg23nVxp2Sw681DJNVaooN53GU8E/SuH40B394yFF34L+kZY76dCbC4fyMrY+FHI
	W02SN980bcQC4ARyvrouTsF5ZRlPW9yUR1fGVGNKsF7KFbAUyqi6oZJO2tZS0TSpjMxzV3ILzjRw7
	xPkogNncjQJE0Rixyuf/9OzPi7uNgyrKuOO865f5gOqVJZqO+ceOhRs6l9XREjj1Pss4lTs7sVUuN
	wLGRR80Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36252)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tDOI3-0003b7-0C;
	Tue, 19 Nov 2024 13:29:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tDOHz-00065Y-1X;
	Tue, 19 Nov 2024 13:29:07 +0000
Date: Tue, 19 Nov 2024 13:29:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: net vs net-next conflicts while cross merging
Message-ID: <ZzySo2clykoS7-5a@shell.armlinux.org.uk>
References: <f769256c-d51c-4983-b7a5-015add42ca35@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f769256c-d51c-4983-b7a5-015add42ca35@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 19, 2024 at 02:15:07PM +0100, Paolo Abeni wrote:
> @Russel, @Jiawen: could you please double check that the resolution is
> correct?

Will do, but... Linus has recently been ranting to Andrew about latin-1
vs UTF-8 messing up the spelling of people's names. I find this
somewhat hypocritical. Each time I see this kind of thing, it makes me
sick.

As someone who's name regularly gets mis-spelled (for god knows what
reason...)

Either we care about correct spelling of people's names, or we don't.
If we do, then more effort needs to be made to spell my name correctly.
If we don't, then I'll stop complaining. However, we can't have "we
must spell non-latin-1 names correctly" but then go and consistently mis-
spell other people's names and not bat an eye.

I'm asking for equality please.

(And yes, my name does and has been mis-spelled in commits merged into
the kernel.)

> I solved the phy.h conflict as reported here:
> https://lore.kernel.org/all/20241118135512.1039208b@canb.auug.org.au/

Looks fine to me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

