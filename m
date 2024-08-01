Return-Path: <netdev+bounces-114842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C88944618
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E6C1C2239F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45957166313;
	Thu,  1 Aug 2024 08:03:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93414F9FA
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499414; cv=none; b=BirgyoBq+/ld57lGuAwj4jjgMICfGwxrqFF7kdfcW5HRGWXs7zTOQXgCspOtd1aqMW7sN6QSFgK9q9FVk4j74z1+qgq6JbFePx4A7Dgy2VXuL6kaWKUq5smS0iL0q9/ZzCq0Bn6LseXGa9hnzD5IflNxk/6VxxYo/4qaiKEVz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499414; c=relaxed/simple;
	bh=M3FGpVMu+DygdYpxjdg5lka12lFxFxFDQshb+/WVfnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYupowCZPfLyX2jUI3fRiUhlmuC1rkQDdbNpNwRojV4Z89wgFvVRvRuiOcElo+JFl86HMeOpDV+0LC5B0LZzHVKHIt4PXlmOdAiTrfoaYx47ZfD8Sn5A5lyRnVJrazIas4KdPvNmmko6puf/cNulbVNMKF5mX+krxUgEEXyXweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 083A57D120;
	Thu,  1 Aug 2024 08:03:31 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v7 02/16] include: uapi: add ip_tfs_*_hdr packet formats
Date: Thu,  1 Aug 2024 04:03:00 -0400
Message-ID: <20240801080314.169715-3-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240801080314.169715-1-chopps@chopps.org>
References: <20240801080314.169715-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add the on-wire basic and congestion-control IP-TFS packet headers.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 include/uapi/linux/ip.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/ip.h b/include/uapi/linux/ip.h
index 283dec7e3645..5bd7ce934d74 100644
--- a/include/uapi/linux/ip.h
+++ b/include/uapi/linux/ip.h
@@ -137,6 +137,22 @@ struct ip_beet_phdr {
 	__u8 reserved;
 };
 
+struct ip_iptfs_hdr {
+	__u8 subtype;		/* 0*: basic, 1: CC */
+	__u8 flags;
+	__be16 block_offset;
+};
+
+struct ip_iptfs_cc_hdr {
+	__u8 subtype;		/* 0: basic, 1*: CC */
+	__u8 flags;
+	__be16 block_offset;
+	__be32 loss_rate;
+	__be64 rtt_adelay_xdelay;
+	__be32 tval;
+	__be32 techo;
+};
+
 /* index values for the variables in ipv4_devconf */
 enum
 {
-- 
2.46.0


