Return-Path: <netdev+bounces-298221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RAGoA4nmKmo9zAMAu9opvQ
	(envelope-from <netdev+bounces-298221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:47:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BCF673AC3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:47:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xs6XbelL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298221-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298221-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3963A34105E4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F42E42B75A;
	Thu, 11 Jun 2026 16:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073BD42189D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:27:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195247; cv=none; b=qo1KcNSVgr8E8QOB8RP1gXlH5syxta04/V5S08C15koF+PIfNp7HoikfXlMnBdj+xQ1lZ3EzC/FVrIuNNFEAIQeIpGCemtIMAxcYGEPsTexbtbELhhq5W5jtUmhj5ErzJhl2s0stB9ahWvy6vap7ivduj3FhvC2xsLJ47lg6AtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195247; c=relaxed/simple;
	bh=A8tMHRZ+jlwjkwTJ703+ZnI5YYR5LiNC6BgBVzaV7sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgqD/j+LVqGDC7OeMT/3sPp8jJYYGaYjznveX+5MJj6A4HVf7pWp4BsTrmyoYTS2E6qXG4sHgoIB2lfW5MUdFLutU48Zpx0A/eESJCLOd4kfGII8wFZf80hJkg+g/JAy4hXRDhMQTlPEFNVDb1aB6W/fR8EDfisWkJsCXL3RVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs6XbelL; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b1aefe1cso7753695e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195241; x=1781800041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KkKnjsGGzb7NsTQucsijuq+HFGUV8ktC3DxrHhupXYA=;
        b=Xs6XbelLYzLmrFvcTwifisxbRuBjCQ7pRQIv+EPghzMn2A89yjtTOgVvRYLPhS68/M
         d2oQyM+jq0fG57XtmGW0NvZI9nLgjtOPSl5owZGTN4jPzE5AF56X4YMDxBut0qRPl2Au
         M/Yl1mgAipKzyLsAoYd4wkYbh6H2d3sxnjJJkmXR3YPQQghgVESjxzYLwq7E59EmnHDB
         uPcMZmojOG239FdbDjYqt9OpyzakTT4y8ktyumXZPAMe/TLqvghEpF/wZHpuLhUiJooY
         1SYOWjmVQwfVj7mzWge67L7nOo2lVq6ThosyhEyif6GjAfXiGLVCQEMtTgWVtyWUciFA
         Q2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195241; x=1781800041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkKnjsGGzb7NsTQucsijuq+HFGUV8ktC3DxrHhupXYA=;
        b=qPmBMfszR/VQDCxfGfePu9n59k1taXE4g4zWSKHsfXfITQ/PSuqNhV7t6cycqmcavO
         QJ6aGcWVGlnlnK0xQkfplygHMJdfJg9EraxxLk1xK0R+wcdtxjDa3oRAQaop7SHjVtdM
         P6kAAHt9Ufvja4p+IUBqkUf6x/NUXFfUCflXgx/n0O8P8gMxQV3O50VamogCAXSApt+C
         Y6bVZLY/q9PH6mii47UpWz+gpoTStln6dP7d9BVoaBhEJkSgnMveeSfNo5Y3jOFZiSkI
         y0N9H0gvzxEvj4pmpFiaM6uahgZP/aT3HVNipMOcOR0INe3GGesFZjlK7Bn1YwC1xdLF
         zYTA==
X-Forwarded-Encrypted: i=1; AFNElJ991bu78Cx4g0KXJq9+hqhL1PJ5ubiC+Vr1BKMgoFhDt6uTyv/VcEd1h5VVtNrRUHtI1onDugg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySFDyHWml23PJc4kKxXy9qFLdPkJMTCh+jQMRTf61lgdvY0YIG
	laoog4D0TzixzdkfMCmW8UU/n956Gn6IClCUFUFE0tX+wgIkJ/QWvw4R
X-Gm-Gg: Acq92OHeYl7KCG1cwE2C7kexevkocvVO7ri41Juyy4RJmyOIJCEjl0ukUmUzd8jfpyT
	gFrBQilN3W2ERVzyQC9U8Htm7r5D3Qt4kUrzAAFhDVmlcj3Br0L+Q8IeHIPKkyrlRy3quKb69tk
	4REgEiYtvijWSoPubAPQ3w8zsGbJ0KXKwRA5qC4dWx747vCgMDWiMs3ILE/JnRuejXAuZH1GOKJ
	aNth3D9FI/Zoo/uMGTYIkTmX4R8eJVn0GkO8sLPr+qKKbJPLlzJE4qKveRNyjAwVJ4txcrkQhGx
	39WhIaGv4T4KoJf6LbomYxAvGdUkjbtuGtMCi8iyxLXvyz3aL2bGZn/fBI3smG124CNhFQcN9w3
	aQuV8djjjueAHxE6wNk+MkcvzGrTgPnJt73j1kpGpvjvP1UePBGqoYehzfxzdE8+LFPno9gsbTU
	Lcwzm8JmO1cbHHVFH2EPzN3/SUdcxr71hiUJq5AFnL8jersAozQX8wBRx9WCzL5T39nyfeSMfj7
	HATAcQ=
X-Received: by 2002:a05:600c:4443:b0:490:e190:39b1 with SMTP id 5b1f17b1804b1-490e564075dmr23542205e9.7.1781195241107;
        Thu, 11 Jun 2026 09:27:21 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52ac9aasm64984155e9.4.2026.06.11.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 09:27:20 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: David Heidelberg <david+nfc@ixit.cz>
Cc: Zijing Yin <yzjaurora@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: nci: validate packet length when parsing NCI 2.x RF interfaces
Date: Thu, 11 Jun 2026 09:27:16 -0700
Message-ID: <20260611162718.2301552-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298221-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david+nfc@ixit.cz,m:yzjaurora@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:david@ixit.cz,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61BCF673AC3

nci_core_init_rsp_packet_v2() parses the variable-length list of
supported RF interfaces carried in an NCI 2.x CORE_INIT_RSP without ever
validating the controller-supplied lengths against the size of the
received packet.

Each list entry is a (RF interface, RF extension count, RF extensions[])
tuple. The loop walks the list using the per-entry extension count
(rf_extension_cnt, up to 255) taken straight from the packet, so a
malformed CORE_INIT_RSP can advance the read pointer far past the end of
the skb data buffer. The stored interface count is clamped to
NCI_MAX_SUPPORTED_RF_INTERFACES so the write side is bounded, but the
read side runs off the end of the buffer.

A malformed CORE_INIT_RSP from the controller, also reachable from user
space through the virtual NCI device (CONFIG_NFC_VIRTUAL_NCI) once the
device has entered NCI 2.x mode, therefore makes the parser read past the
end of the response buffer while walking the interface list, copying the
out-of-bounds bytes into ndev->supported_rf_interfaces[].

Reject responses shorter than the fixed part of the structure, and make
sure each interface entry and its extension bytes lie within the received
packet before dereferencing them. A truncated or malformed list is
treated as a syntax error, which fails the CORE_INIT request instead of
reading out of bounds.

Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
 net/nfc/nci/rsp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb86282..152b5f57e 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -87,7 +87,8 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
 	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
-	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
+	const u8 *skb_end = skb->data + skb->len;
+	const u8 *supported_rf_interface;
 	u8 rf_interface_idx = 0;
 	u8 rf_extension_cnt = 0;
 
@@ -96,6 +97,11 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 	if (rsp->status != NCI_STATUS_OK)
 		return rsp->status;
 
+	if (skb->len < sizeof(*rsp))
+		return NCI_STATUS_SYNTAX_ERROR;
+
+	supported_rf_interface = rsp->supported_rf_interfaces;
+
 	ndev->nfcc_features = __le32_to_cpu(rsp->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp->num_supported_rf_interfaces;
 
@@ -104,10 +110,20 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
 	while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
+		/* The supported RF interfaces are a variable-length list of
+		 * (interface, extension count, extensions[]) tuples supplied by
+		 * the NFCC; bail out if its lengths would take us past the end
+		 * of the received packet.
+		 */
+		if (skb_end - supported_rf_interface < 2)
+			return NCI_STATUS_SYNTAX_ERROR;
+
 		ndev->supported_rf_interfaces[rf_interface_idx++] = *supported_rf_interface++;
 
 		/* skip rf extension parameters */
 		rf_extension_cnt = *supported_rf_interface++;
+		if (skb_end - supported_rf_interface < rf_extension_cnt)
+			return NCI_STATUS_SYNTAX_ERROR;
 		supported_rf_interface += rf_extension_cnt;
 	}
 
-- 
2.43.0


