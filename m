Return-Path: <netdev+bounces-144714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 858A09C83D8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49813287734
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1E1EF95D;
	Thu, 14 Nov 2024 07:13:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266621EBA17
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568394; cv=none; b=SEejG//AIVdR1lwXTqcuhn4W4fWJGeYTcMrzNBHtBrR73FwNo0g3EiBDo4OxO8NAuvvEwHlvUwZn1CXrKqHQpPQvNWA3IVbWotDNrt1+TYRC2p0+o1Qt710sl9VojuJCiaTxVlc1/5Gmp4pgo2DFkIideOQF+0IAPo75G7x3XXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568394; c=relaxed/simple;
	bh=cs5FwVbfG3y1i8CIGwBk01J+7DPDZQO+k9vVkhonCL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrRrvGYR8f2k909HjKNyCQKnu/LtI0cX3L/SWBk4atxArdPg8ISQky0o2P5kRO5WUNfL4JSqowKywuYOai7wTNk1ZfmOh1iMmqFKKf3pvdbQojcXQeenMWvsHwvD9uBkNKeXcc4hcmiXrTznOY0w5JwAUZLRV6u8veApJrmKQtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 022267D11A;
	Thu, 14 Nov 2024 07:07:29 +0000 (UTC)
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
Subject: [PATCH ipsec-next v14 02/15] include: uapi: protocol number and packet structs for AGGFRAG in ESP
Date: Thu, 14 Nov 2024 02:06:59 -0500
Message-ID: <20241114070713.3718740-3-chopps@chopps.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114070713.3718740-1-chopps@chopps.org>
References: <20241114070713.3718740-1-chopps@chopps.org>
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


