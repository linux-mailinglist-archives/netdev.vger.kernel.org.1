Return-Path: <netdev+bounces-126156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D655A96FF31
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 04:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1353A1C22620
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 02:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496B11B949;
	Sat,  7 Sep 2024 02:24:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392518C08
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725675884; cv=none; b=A5Yvac2928Gd3H0cwjxB+6A4yNmjLfcoK2SVlKPgFNLp3JWWfsVA0lpP8UQSzERRbfkJ80c1pcyVg42KIJkVgL6ZMU6m7UK8cUAXYJSY5NE4dpAfqnR3IO+UJQg+IJbUK326DaIZoXMFqllqreWbmk9gWMYA9Z0K1LS5OITA2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725675884; c=relaxed/simple;
	bh=M3FGpVMu+DygdYpxjdg5lka12lFxFxFDQshb+/WVfnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3BrLh9gJVeBMAqnREigva29YZ2kvq9QL8RqcJbsRs6OOVki6lHFz6u2YlRYrLOOiMF/tkjkIsyA5sCDZBXh3U+BT+yXsq/sTaWUJb7oNiuLJvnD8O7RV3/vb4SYIgYGystgZfmLE+LfX3GOdewlTEW3W80gwyTv0lrTXuv2C90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id ED8207D12F;
	Sat,  7 Sep 2024 02:24:41 +0000 (UTC)
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
Subject: [PATCH ipsec-next v11 02/16] include: uapi: add ip_tfs_*_hdr packet formats
Date: Fri,  6 Sep 2024 22:23:58 -0400
Message-ID: <20240907022412.1032284-3-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907022412.1032284-1-chopps@chopps.org>
References: <20240907022412.1032284-1-chopps@chopps.org>
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


