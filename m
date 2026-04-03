Return-Path: <netdev+bounces-275175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPJ9CUQY0GmV3AYAu9opvQ
	(envelope-from <netdev+bounces-275175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:43:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA0397CD1
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4F4F300AB0F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB23CA4B2;
	Fri,  3 Apr 2026 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWHgNov1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEBC337BB5
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245179; cv=none; b=Bq21uwrO2nshhRIrDyCjHduXe4X5B2k5dSsSEWeANXmh/Nz6IwanF6CCcEyZdhFs97P5dhjMlU3+772EQgZhJ2L1mf6Cop69/S/s/jRGELKPM3hbxZpFCPVDQ1eXqqXkPB71decFfEelzCj5vkdbbEeZAVQM+h/ok98n/nCUhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245179; c=relaxed/simple;
	bh=mEnsa1m82X7Qbw/mh295eQAICuszh3WNwBTYCp116Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INwnfCC8WlYNQCJOzHltoOXSNHgVlcJWMxEJIy7bkghBamZxKeFj2h5qHXzzVnU/2cT+ppnNk97dLJMZAagDpL/O9Jq2WeCP7P2xL3PS9dubCxZKtvXtZGvE3GJBodrrk2TAhwO6NrgjlH3x+EI9SIKfTbhrk4Bk6+lcCvAi+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWHgNov1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso2161089f8f.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775245177; x=1775849977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Qc95GC1vro/oOb+qTX+I6jitOjuvKVTkSWpRWYkOI=;
        b=pWHgNov1gP6Kuti2jYPj1FVYjV004ovjnStARHQGNKJlGqrCCrbsii7QjizcoXWpa6
         TrIsPYc2SX0Luih/Q7tQ/XtboeLwNiF5DQMM7cLbhe7aa8R7dqnEg0thKQd8zQhMXiJh
         Cw6WIaFT9Btulf20dRsCLZgOuz42hCAXhpIh+IGwt3/zHlfJiJQVMC18vAwUETC0OpYm
         5KmhA1RxVbg5dGzv6m17wKKms85foIX7wU+qRaKqSCB/dCdFAB2Fsuh0txo/IDy0xaTF
         KJ/HbjUOqNM9eSkGGKr3FPyN9Zh5B9Tp+br3qY/aQx42jAQa332WTeGGVRKVEyozw2m6
         kWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245177; x=1775849977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6Qc95GC1vro/oOb+qTX+I6jitOjuvKVTkSWpRWYkOI=;
        b=XR2LXV4WVbzKulOdZhRiJmmq+OaDtpce3IwStZESLc3/4JHtKKD96GFV7KuT7VOxsu
         rv3m8Ul6g2EpomZSSSfa1RBjzE5i7rNv1JWSpGbpJfc/BYWVOOg7SToHrf1VGhTBq6pM
         OGMcSpjuzvanW6Hwy3FPZCx+OD3EK0i3cDfHURpmE1XmSaVyZzFhmjLHjKuVoTcBWSG+
         y1hHAHkwAKq4D+fte7vIbqAKQMhta35tZ5LWEGtKtAY5lZhKiUWX1dAQWyG4QSf76r+j
         KaY+WH0skwQ5UHoa5p8eNhEFce+/HKT3+6CaGBe7KpyvUKq1YkXXteFWa73Qz2hMX7/n
         teLw==
X-Forwarded-Encrypted: i=1; AJvYcCUydPBLvx+rbtnryUkvERwJijjjAoNjxzooGau2UFxD0yriV3BhDOHd7/wK4AFwE0ZVTCl3rQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygqCMQVMg6KLKUqOxHKpxr0TaiZu/i+Aqd3q5Yyr5FtpQdusXD
	JObY+rYJ0Kx82ttBd0QmxyARDCIjOwrykwtTadU0gTfQuZVHQxrQpnPypTSEgzM/
X-Gm-Gg: AeBDiet3+kGd/S9gDxJEHlmSzouUtvU8Y/XRsopl9bIF/JoJ9iGxRLvSVXp6qrtt1P6
	kQX3oFgBes8LKbV/j1QXhV6N86eGZXnM2iFL75kfE9YyBFBcw3p7LqQbSbWYLdwMDrQH3UJ7VCG
	aiNWbQOMlkkCck1ns9gyg90M3C2ZTwWQW5SjpozLMNg1bxGzXqdu9yE9pa68sPmIbQtpscuneGU
	Qj9/2RZYVW2F4fYAWpVPTBkY+omLju+rvAZzYAwbOw7WxAMTQLZa4Tbye7eFpzmHmGhsv/oHGoy
	gWPTqqJj/bQpD4PP4w5JwR8za79HDUbTLkMPTe929UoCjzfR8pb0gFBTbtgnX7bKAIPrZMHsM5V
	LloaJZ34UAcxl4QYTmrFufAtAvN+U3svhtWvrLEWJvYNTRDbtpp5GzeU9h6eTb8R+bMnCzFzWQy
	6wnefCr2GzsdC5MxHk5S/MYhvZe4ghgDSwNYSud2xY1Ny0/x4aqyJRnyFVmJXvOakwEX/jbmkCs
	EXMILC/GhThroKuA/VDc/FyT7iEJw9sWh2bXmnYud+JtYwu1BI=
X-Received: by 2002:a05:6000:40da:b0:439:be67:a038 with SMTP id ffacd0b85a97d-43d292ec691mr7007250f8f.41.1775245176453;
        Fri, 03 Apr 2026 12:39:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-188-129-81-72.dynamic.amis.hr. [188.129.81.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm18429186f8f.4.2026.04.03.12.39.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Apr 2026 12:39:35 -0700 (PDT)
From: Marino Dzalto <marino.dzalto@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marino Dzalto <marino.dzalto@gmail.com>
Subject: [PATCH] netfilter: xt_HL: add pr_fmt, default case and NULL checks
Date: Fri,  3 Apr 2026 21:39:29 +0200
Message-ID: <20260403193929.89449-1-marino.dzalto@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275175-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marinodzalto@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2DA0397CD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Marino Dzalto <marino.dzalto@gmail.com>
---
 net/netfilter/xt_hl.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/xt_hl.c b/net/netfilter/xt_hl.c
index c1a70f8f0..9434d5ca8 100644
--- a/net/netfilter/xt_hl.c
+++ b/net/netfilter/xt_hl.c
@@ -6,6 +6,7 @@
  * Hop Limit matching module
  * (C) 2001-2002 Maciej Soltysiak <solt@dns.toxicfilms.tv>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/ip.h>
 #include <linux/ipv6.h>
@@ -25,7 +26,12 @@ MODULE_ALIAS("ip6t_hl");
 static bool ttl_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct ipt_ttl_info *info = par->matchinfo;
-	const u8 ttl = ip_hdr(skb)->ttl;
+	const u8 ttl;
+
+	if (!skb)
+		return false;
+
+	ttl = ip_hdr(skb)->ttl;
 
 	switch (info->mode) {
 	case IPT_TTL_EQ:
@@ -36,15 +42,21 @@ static bool ttl_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		return ttl < info->ttl;
 	case IPT_TTL_GT:
 		return ttl > info->ttl;
+	default:
+		pr_warn("Unknown TTL match mode: %d\n", info->mode);
+		return false;
 	}
-
-	return false;
 }
 
 static bool hl_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct ip6t_hl_info *info = par->matchinfo;
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	const struct ipv6hdr *ip6h;
+
+	if (!skb)
+		return false;
+
+	ip6h = ipv6_hdr(skb);
 
 	switch (info->mode) {
 	case IP6T_HL_EQ:
@@ -55,9 +67,10 @@ static bool hl_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 		return ip6h->hop_limit < info->hop_limit;
 	case IP6T_HL_GT:
 		return ip6h->hop_limit > info->hop_limit;
+	default:
+		pr_warn("Unknown Hop Limit match mode: %d\n", info->mode);
+		return false;
 	}
-
-	return false;
 }
 
 static struct xt_match hl_mt_reg[] __read_mostly = {
-- 
2.50.1 (Apple Git-155)


