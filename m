Return-Path: <netdev+bounces-115118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA4E94539A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 22:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFCD1F234FC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A00E14A0A7;
	Thu,  1 Aug 2024 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtnquESx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F713D62C
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542416; cv=none; b=pE+Dple5ryogSzOyyeGgr0SoRtw27c1chZI986OzVkpCpve/NqDlVDjVYyCO0lDyHX2Hzspemn055EfFrCWVz8sF9vrinv437vHFIcdKfDHPMsA6PZ/BjQYAUZQlccaKWAD4dDaNWL51ojHJ5I8Rhwpn0YTGMFfyvONU++DBkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542416; c=relaxed/simple;
	bh=24qNAo0J6PSO6H4KIQelE5TEN2rI1PEozqwN7C4cRKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OQX/UpqRNNQtchqcjzWhp7ezS7hNklVHrBAPVCz+o/AtyYuszj4RTgnVUw8yH+plK0DupqUfluKGVDjxNE56KezA8H7QkjmXqMdYJIXNEj19xgUajy10NOLwzczik4YWr0wuXfLO/UThI5zcpoQ8rVnhKMM74SR2o+SPZChMz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtnquESx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E425C32786;
	Thu,  1 Aug 2024 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722542416;
	bh=24qNAo0J6PSO6H4KIQelE5TEN2rI1PEozqwN7C4cRKs=;
	h=From:Date:Subject:To:Cc:From;
	b=mtnquESx9Jdnw3N/HBFi+tZrP/k9mclJNz8L5K5Aa676c5HlBFWsVHYCavVcOZkiI
	 NHXXNCMqCtluTRCS7lFmwYOeIk691FwABfLUTrwSToPRg8ZSQrMXJpBqWeTigVaQYJ
	 K5RNa2Hi14BX0JGcKQkL0koKpyKZfvBanQ53Ef680asn1UZKw0F3dxnJxfAaNEVLQK
	 f/XcpPBNX4EnBQ6gy3T1KzH0uvBVCsADob7l550ool/GpD/wP2uAsXYRG1+1D3jzai
	 Qw/exIy+j3DzGAur50KDFClmHlS8pLdo15UHGmRMYyZB8lqEWqTkrOTQAU5chhunPJ
	 6xEHfFuT7CDxg==
From: Simon Horman <horms@kernel.org>
Date: Thu, 01 Aug 2024 21:00:03 +0100
Subject: [PATCH net-next] linkmode: Change return type of linkmode_andnot
 to bool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-linkfield-bowl-v1-1-d58f68967802@kernel.org>
X-B4-Tracking: v=1; b=H4sIAELpq2YC/x3MywqDMBBG4VeRWXcg8UJsX6V04eWPDg1jSaQK4
 rsbXH6Lcw5KiIJEr+KgiL8kWTTDPgoa5k4nsIzZVJqyNq2xHES/XhBG7pctMLx3zjo09llRjn4
 RXvZ7+CbFyop9pc95XnA6e2xqAAAA
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.0

linkmode_andnot() simply returns the result of bitmap_andnot().
And the return type of bitmap_andnot() is bool.
So it makes sense for the return type of linkmode_andnot()
to also be bool.

I checked all call-sites and they either ignore the return
value or treat it as a bool.

Compile tested only.

Link: https://lore.kernel.org/netdev/68088998-4486-4930-90a4-96a32f08c490@lunn.ch/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/linux/linkmode.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index d94bfd9ac8cc..3b9de09871f6 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -37,8 +37,9 @@ static inline bool linkmode_empty(const unsigned long *src)
 	return bitmap_empty(src, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
-static inline int linkmode_andnot(unsigned long *dst, const unsigned long *src1,
-				  const unsigned long *src2)
+static inline bool linkmode_andnot(unsigned long *dst,
+				   const unsigned long *src1,
+				   const unsigned long *src2)
 {
 	return bitmap_andnot(dst, src1, src2,  __ETHTOOL_LINK_MODE_MASK_NBITS);
 }


