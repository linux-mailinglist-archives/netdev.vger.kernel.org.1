Return-Path: <netdev+bounces-227277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B88BABA55
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A831C2CFD
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 06:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974B428504D;
	Tue, 30 Sep 2025 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="XmN0k7TC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-108-mta196.mxroute.com (mail-108-mta196.mxroute.com [136.175.108.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF7216E32
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213083; cv=none; b=az8Xv0MpvfFRH0Ivc328A1bg3Ik5CSz8+EsoV5K3tIHY44mSH+ZhsVTxGDUX5UETbNKdvVFbGyEwF50j2SL/DYX0J3MKKK161c6OLOMhuY7EFw34grkXM7Hn/7MV3TEccFu5yeMcDR0kd9byuT/Lbh4QdzVnEXPBKb34P13U2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213083; c=relaxed/simple;
	bh=b5DWgboimi+Z9IOjMt/S61PYPrKVOLaxU4eF70I8Q/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMDT77pJBk2lOANe2GibhNfFQq/8PLDzgoh/WQWC5xXPBC6blVYnasJi1ZdRArCMKmAtly+MbSVJDtAXQnsOZvtXP6BiPALd5SAzGS0m/7FXcZApKcmdB1FrR7Ose8iL5CvAKOpWz46U27eD2RjPdilDMIfDWExePiOFUzOGhyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=XmN0k7TC; arc=none smtp.client-ip=136.175.108.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta196.mxroute.com (ZoneMTA) with ESMTPSA id 1999940a21d000c244.00e
 for <netdev@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 30 Sep 2025 06:12:53 +0000
X-Zone-Loop: 00adc8df9a83dce2c94f9daf328d873c3f622cfbb1a5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=ggyaZpFvuFFen4mjD46MTVdtGASkVmZ5LRYKR76W8pA=; b=X
	mN0k7TCymPClVf/7PgCtBL9oyaQ/mw3NHDDc907E8tkFV6OYA7tLvj7E4HxB+5Pv2mf0jyRNFlJRe
	LITZwyP73sdmLlBdROT7kcDiDTjf4AjKdDZ81CmIYBrVgXcwBqcwsuuJHwF92WnpXZcwy1x07q6hQ
	lsPvf29u75xl9fcue0+nffDzAq6oiT7OUMrbUaRbz/NrSxQKF0Na4lZ0Htsny9WjIOaGzPjrAQ8z6
	/X2bqFUSOMY/HKmAMu7BpxcjMwkkhHKQQFN6n6wHimibwrasenR/Pt/wgxyM70Z/YQ9+wnsCMqmLv
	ogVBVk0nLJ9F0khbeuZlO4/tvcK4FvRng==;
From: Bo Sun <bo@mboxify.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: sbhatta@marvell.com,
	hkelam@marvell.com,
	horms@kernel.org,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	sumang@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>
Subject: [PATCH net v2 0/2] octeontx2: fix bitmap leaks in PF and VF
Date: Tue, 30 Sep 2025 14:12:34 +0800
Message-ID: <20250930061236.31359-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com

Two small patches that free the AF_XDP bitmap in the PF and VF
remove paths.  Both carry the same Fixes tag and should go to
stable.

Changes in v2:
- Add correct [PATCH net v2] subject prefix
- CC the sign-off authors that introduced the leak and everyone
  returned by scripts/get_maintainer.pl

Bo Sun (2):
  octeontx2-vf: fix bitmap leak
  octeontx2-pf: fix bitmap leak

 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.50.1 (Apple Git-155)


