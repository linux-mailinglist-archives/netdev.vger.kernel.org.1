Return-Path: <netdev+bounces-132725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CAE992E7B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759621F23459
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D8D1D54D4;
	Mon,  7 Oct 2024 14:11:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876A81D47C0
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310290; cv=none; b=Sfw6MdpGDc4NWoqPaX7miAxDvkowAWwvcWjzMmLkfC/Do2klSdcmtB5HfyibgdOSzNVcmDJcN1nYykspiC5Oxh13IeygDSP4ipOAe+DfqmKHVgRKG+I84gYXJsLigRcfMMTAb4k7yTIdHh9ewsvOZ3mz2Y7apxGHN/+fJl9ewSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310290; c=relaxed/simple;
	bh=M3FGpVMu+DygdYpxjdg5lka12lFxFxFDQshb+/WVfnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyQQuXO+uCBY25xJb41P/eQG1W4zWq6U8+4F19ROA5Cq9IOQg4BWYZb4gay23UBoHubShUUVTxrh1QKnD4LBX8tmghD+e4QGVO51c9WcZV4+SCRO5a/r/iJJvN0jgW97pyqtqGmO2AP940y4HLDrIDKBBy3tBUZ5wt8DtRjN/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 55CFF7D12B;
	Mon,  7 Oct 2024 13:59:47 +0000 (UTC)
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
Subject: [PATCH ipsec-next v12 02/16] include: uapi: add ip_tfs_*_hdr packet formats
Date: Mon,  7 Oct 2024 09:59:14 -0400
Message-ID: <20241007135928.1218955-3-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241007135928.1218955-1-chopps@chopps.org>
References: <20241007135928.1218955-1-chopps@chopps.org>
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


