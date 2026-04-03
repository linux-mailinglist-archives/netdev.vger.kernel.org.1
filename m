Return-Path: <netdev+bounces-275200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPr4N+Ud0Gk/3gYAu9opvQ
	(envelope-from <netdev+bounces-275200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:07:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47D39810A
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D13A304FFA7
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C53D5662;
	Fri,  3 Apr 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOiluptj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8631E856
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775246607; cv=none; b=hgayINfltbG12QJHjE6boP7du6PAA3VXLtpyYNLEanXUgYOK1/mFYOy1dGqFb7dxyYnn8nmgyhDrCpC2kyvWZuzGpvYcclLlah/dX89pwrvGkhpZ4fJWwPiQWSz0+qtyXLpwSAhKxvdpaSGkTNh1gVLho87y/PCSWQJF4xE6H5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775246607; c=relaxed/simple;
	bh=wADCUDHqv3AIFQTlK0LzdVUglw2571qUMkTdVWFvIxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cBVpqFDEuaNeJodGM0YWPPt0xkE8tX/JyhfH7+TNOhSY1/3O0abqiKyapD9yD88AMj3o/dz7NkusiNnRc97pJDyOVAwR2HGVSPUQmjoFyVwZ6TLoReNtRUwSiEq4ksjxz2Zhvh1SqB0qSPT5mScN/j3uxFFp9IJcYR2bHqr9VOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOiluptj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so22279335e9.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775246604; x=1775851404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xE2VFOzNRG0wByucdsL3FPChPaVcDUKG/JIrmw8PamQ=;
        b=aOiluptjCA/ZuUk28yb+vu+KXgUVQcrEcTmITTmklUfzU7D9DiikISVepgca2lmm0l
         I3JfWMG1Zi+WkI8ZZAy/DXsuGo3s0TtfkgyVSS6390T/ZowHrHXx1CJMtDNwhy0e7sC0
         ccnW1Hu0f7Ej2rzsH3QgiL0zWbVr/KTMgouHx808x9HytlV5KE1hUGzVeZ62k+DFG8a0
         3ar+Krzt3UbkeyavIAhoTKjck4rZkYIHHtL/spA63/9JiKBSAVLv32lzF2NkxgllSF1K
         +D4/gWfyJdV+Rn204SI8X2JW6yiBORGV/r2XIW9UCRubhrYA0ilDag23CPFBmMhYMC6Y
         zAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775246604; x=1775851404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE2VFOzNRG0wByucdsL3FPChPaVcDUKG/JIrmw8PamQ=;
        b=lfSvTuZ7ZfYeoqFO6vpshPVuY974loo/sBIA9EqTZvFOiVowkS8sD7pIIzupqoQBMD
         7TnzVmGz0VhES16CFk0ECVICbBzl96XfW0yXn1LlE1iRWq/44iO2VWdnO06OfGpRUYVM
         rG+kXcJM89Klb14k82XfF/0dxvbRLEks2KIuh6BoEKHO7WqehRfvBRSMyllxl+IOcPKx
         mCj2Hd3tYW+ShQINrHMDmHd6WohZC87UAz/Ngq4vBgeXxcknCev2xnGga6BOi7yPzRum
         0LJtA8C6ZITj3nNpVfi8V7nHJ4YA8ZWXaCle5qd2IND4gs5L1/IgE2UqB/itA14Nv7jT
         hc/g==
X-Forwarded-Encrypted: i=1; AJvYcCUMxVflZoCOvgbDHiOvD4JjuOISMYFE4Ua0i07ccnY1CGnzcu4NqLDc693+Bhd49MaWDRsSYkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTWt6rTBpFAzoZa8uusMeDJrwQPFCrQvTcyZEmCRGy9tx5BDO
	OXJLnQLKsXmUMn7NG6jUMbm+WxeFsBdmw+oQDNOTFlqg4y1omyzE4Mxu
X-Gm-Gg: ATEYQzw51s7kotPOmej8/+kwXvGAiMGhz4daYF5gwC78shsr6TfZb7gNXA282U6NUWR
	TVOW74eVJnbvqIV6/olu7+2uq9N87nu7RKAHUC/SlvZ+ytp9UjjN9uKuvuLmPtNQqWrqZ3fafgS
	S3K848zsXwqNtdS3131Hl/9AGSiuXxWtiwOAy+fD3nWVem55wbFVtVP7X4XLoU/IDgbkGUe9oJk
	Q0L6jL9blLqlI9a5XzbpCBmbh1UQp1jvFkavA8S6/lcLXMjK/Rk4dtRAiHbXmndhG/XlkeXupBT
	G6CZEPOgPya9yM0fooeakcuJFpAz1A7xY0Zp+pVIOWDV+hIGQtINuECRncijMejpxba3oNrzTuT
	RTzuXhYHm4LSYG/vuP5BqboLgQzwfU+6SPyEMBH1QFW5ZrgybBrIRjrGNk5ZjRDPPGnTQ+k4Gr7
	zisWAzsq5HfvaRz69Uu5WUO+X0WMcGVuHDmOHuQhXmuz+eXyy+7b24cxy13MFtwdaw+oIe7MES0
	sXkSdlme3ziz+R55D9oXGURh2A+i8slpMst/xBdkvxZKMtKgpk=
X-Received: by 2002:a05:600c:1d1d:b0:488:7ebd:78 with SMTP id 5b1f17b1804b1-4889977cbb7mr65937275e9.14.1775246604026;
        Fri, 03 Apr 2026 13:03:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-188-129-81-72.dynamic.amis.hr. [188.129.81.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm95627995e9.8.2026.04.03.13.03.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Apr 2026 13:03:23 -0700 (PDT)
From: Marino Dzalto <marino.dzalto@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marino Dzalto <marino.dzalto@gmail.com>
Subject: [PATCH v2] netfilter: xt_HL: add pr_fmt, drop NULL checks, add checkentry validation
Date: Fri,  3 Apr 2026 22:03:20 +0200
Message-ID: <20260403200320.90449-1-marino.dzalto@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275200-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marinodzalto@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toxicfilms.tv:email]
X-Rspamd-Queue-Id: 8F47D39810A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add pr_fmt for module-prefixed log messages. Remove unnecessary NULL
checks for skb, as netfilter core guarantees skb is non-NULL. Add
checkentry functions to validate match mode at rule registration time.

Signed-off-by: Marino Dzalto <marino.dzalto@gmail.com>
---
 net/netfilter/xt_hl.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/netfilter/xt_hl.c b/net/netfilter/xt_hl.c
index c1a70f8f0..4a12a757e 100644
--- a/net/netfilter/xt_hl.c
+++ b/net/netfilter/xt_hl.c
@@ -6,6 +6,7 @@
  * Hop Limit matching module
  * (C) 2001-2002 Maciej Soltysiak <solt@dns.toxicfilms.tv>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/ip.h>
 #include <linux/ipv6.h>
@@ -22,6 +23,18 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS("ipt_ttl");
 MODULE_ALIAS("ip6t_hl");
 
+static int ttl_mt_check(const struct xt_mtchk_param *par)
+{
+	const struct ipt_ttl_info *info = par->matchinfo;
+
+	if (info->mode > IPT_TTL_GT) {
+		pr_err("Unknown TTL match mode: %d\n", info->mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool ttl_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct ipt_ttl_info *info = par->matchinfo;
@@ -41,6 +54,18 @@ static bool ttl_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	return false;
 }
 
+static int hl_mt6_check(const struct xt_mtchk_param *par)
+{
+	const struct ip6t_hl_info *info = par->matchinfo;
+
+	if (info->mode > IP6T_HL_GT) {
+		pr_err("Unknown Hop Limit match mode: %d\n", info->mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool hl_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct ip6t_hl_info *info = par->matchinfo;
@@ -65,6 +90,7 @@ static struct xt_match hl_mt_reg[] __read_mostly = {
 		.name       = "ttl",
 		.revision   = 0,
 		.family     = NFPROTO_IPV4,
+		.checkentry = ttl_mt_check,
 		.match      = ttl_mt,
 		.matchsize  = sizeof(struct ipt_ttl_info),
 		.me         = THIS_MODULE,
@@ -73,6 +99,7 @@ static struct xt_match hl_mt_reg[] __read_mostly = {
 		.name       = "hl",
 		.revision   = 0,
 		.family     = NFPROTO_IPV6,
+		.checkentry = hl_mt6_check,
 		.match      = hl_mt6,
 		.matchsize  = sizeof(struct ip6t_hl_info),
 		.me         = THIS_MODULE,
-- 
2.50.1 (Apple Git-155)


