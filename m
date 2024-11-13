Return-Path: <netdev+bounces-144440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B3C9C773C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 356C2B30539
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61A171D2;
	Wed, 13 Nov 2024 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Na09W/dH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F164823A0
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509193; cv=none; b=mwCt7FIr7ZOdliR1cFE6/syV+/IHiREd97HihnHXDw4O0qGoWdBh1slaCHwKv9vT4Jmx0tnKbU0y/v+ctM3pKcupym+HVlE6dYShlk2pe+F8y9VRCZtaQCiUNLRrb9gBfWN4pBNnANLDywIgri7ZSDsthsTMdmoX8E/XkviE55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509193; c=relaxed/simple;
	bh=zIXoZhWC4DXAOrpWgsSnilXYYSorX84AMg9nuLvObNo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YxRRgFYs7ghxRhHKDKqxNrpX2xa6D2rN/NnhmV19qu6bJFzkHtP2+xX56cgfMION7+D1kE9RjTjLbr1V7WaGrvjbUpn5OynWPTfCUNgmiTcRtYz/pp8LvOvva/dHRCDmxkAZ6tq7NAJpSTjcA9s8q9W1aLHPcIHP5PJ31PKPg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Na09W/dH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AYArTO1recV8g5TrTKd5zKTwX65IEI5Ux7w4h2yREEU=; b=Na09W/dHXSAS5mlvQ/kCpil37r
	XUAdasMvajymADlGGNFInHm21rNJm6fsGo40C2x0bTZhLlbGl86gdN0f2vnh5bn4ql5zyFOdkKTXE
	FK3tSISV31JVSXN/MPHUE6lD3aQ2lLJoGbiCWAEyNgX5wmPxVfyVmo+xTRjin8anLl2hlq9/VQFuf
	LcnSDQ+jK17PjjE0hlmmCaJbCG3FnZWDbtp+ShtPPZdDbzbloPY7zO6VXRrc96RRLop97kgm5w9kd
	0Ow1wkAEyX0zo3vbMAP0AaqA54AFIQIa6NkwRcL0qhB7Dm6Uk2JxiUimX0nnilPc0HJzkO8tpF0FQ
	b7n7IRPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48182)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBEdX-0006P3-0c;
	Wed, 13 Nov 2024 14:46:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBEdV-00007K-1u;
	Wed, 13 Nov 2024 14:46:25 +0000
Date: Wed, 13 Nov 2024 14:46:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Testing selectable timestamping - where are the tools for this
 feature?
Message-ID: <ZzS7wWx4lREiOgL3@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi Kory,

I've finally found some cycles (and time when I'm next to the platform)
to test the selectable timestamping feature. However, I'm struggling to
get it to work.

In your email
https://lore.kernel.org/20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com/
you state that "You can test it with the ethtool source on branch
feature_ptp of: https://github.com/kmaincent/ethtool". I cloned this
repository, checked out the feature_ptp branch, and while building
I get the following warnings:

netlink/desc-ethtool.c:241:37: warning: ‘__ts_desc’ defined but not used [-Wunus
ed-const-variable=]
  241 | static const struct pretty_nla_desc __ts_desc[] = {
      |                                     ^~~~~~~~~
netlink/ts.c: In function ‘ts_get_reply_cb’:
netlink/ts.c:23:14: warning: unused variable ‘str’ [-Wunused-variable]
   23 |         char str[10] = {'\0'};
      |              ^~~
ethtool.c:4865:12: warning: ‘do_set_ptp’ defined but not used [-Wunused-functio ]
 4865 | static int do_set_ptp(struct cmd_context *ctx)
      |            ^~~~~~~~~~
ethtool.c:4839:12: warning: ‘do_get_ptp’ defined but not used [-Wunused-functio ]
 4839 | static int do_get_ptp(struct cmd_context *ctx)
      |            ^~~~~~~~~~
ethtool.c:4817:12: warning: ‘do_list_ptp’ defined but not used [-Wunused-function]
 4817 | static int do_list_ptp(struct cmd_context *ctx)
      |            ^~~~~~~~~~~

My conclusion is... your ethtool sources for testing this feature are
broken, or this is no longer the place to test this feature.

Presumably there _is_ something somewhere that allows one to exercise
this new code that Jakub merged on July 15th (commit 30b356005048)?
Please could you point me in the appropriate direction ASAP - time is
very short if I'm going to give this a test on the setup where both
the MAC and PHY support PTP. Essentially, this afternoon - or its
going to be at least a month before the next opportunity.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

