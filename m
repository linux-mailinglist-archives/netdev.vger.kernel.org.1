Return-Path: <netdev+bounces-141834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE189BC81F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC3A1C2244A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C747C1CEE90;
	Tue,  5 Nov 2024 08:38:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC1C1C1738
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795910; cv=none; b=br4yDx3D52y1Wgryb2HW69ju/gsccdB8BUxdZP0kCl0zajJxFY/rn8oVnqlIQrp3RjgwG4gWih12sRNgFlbMKF3UhlLOUTAgwxEmCFM8TX3z4Zaobv9FPNYolPjqfokTUAbIDQcBVltZLVjKQd/+amLosSWZkaxJH8lgZoT5OIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795910; c=relaxed/simple;
	bh=cs5FwVbfG3y1i8CIGwBk01J+7DPDZQO+k9vVkhonCL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9CFC0Dv2qIaG/cI0QfTMp71chvZp+eLa+td43OXtTLMl5ts+Fznco4V1sKOsMu76FGRAzkCRpdkhhdcedXwvNN7vajWKKhCPoGf9QeFRPfIb0jdaJuG1nD1grs3rgIDxagSdXAefHr2F/UwEuBBs4eecW9PqBOMNGULTSi0Ig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 4130C7D121;
	Tue,  5 Nov 2024 08:38:28 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v13 02/15] include: uapi: protocol number and packet structs for AGGFRAG in ESP
Date: Tue,  5 Nov 2024 03:37:46 -0500
Message-ID: <20241105083759.2172771-3-chopps@chopps.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105083759.2172771-1-chopps@chopps.org>
References: <20241105083759.2172771-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add the RFC assigned IP protocol number for AGGFRAG.
Add the on-wire basic and congestion-control IP-TFS packet headers.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 include/uapi/linux/in.h |  2 ++
 include/uapi/linux/ip.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index 5d32d53508d9..ced0fc3c3aa5 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -79,6 +79,8 @@ enum {
 #define IPPROTO_MPLS		IPPROTO_MPLS
   IPPROTO_ETHERNET = 143,	/* Ethernet-within-IPv6 Encapsulation	*/
 #define IPPROTO_ETHERNET	IPPROTO_ETHERNET
+  IPPROTO_AGGFRAG = 144,	/* AGGFRAG in ESP (RFC 9347)		*/
+#define IPPROTO_AGGFRAG		IPPROTO_AGGFRAG
   IPPROTO_RAW = 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
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
2.47.0


