Return-Path: <netdev+bounces-177970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29763A73496
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 15:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C82C188D1E2
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2880217F34;
	Thu, 27 Mar 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCfux8kh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7720FAAD;
	Thu, 27 Mar 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086261; cv=none; b=P2YW9W8E3uucW1zTA5yebdhILG744bns8YttXqivaHIwzb6QiqYx/AnlQUv645OlXe72rtepWSxe7+r72VCn92/BXYycDb7B07CAEbiIlQcXNdjBIwlqiwu+RGQ23EWcxwya2IM21pkV6yePBwAOYHoV262L8SZPzj2v2z6WC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086261; c=relaxed/simple;
	bh=GLo2U48XggqMZYrVKO9tyrinnEnhVGCFvICD1241EVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kn8d/mxGVyhk3jnzdKV00kDaIT2MA9Dlo0YQT1b/GyZWG1pwq3gmlYVo3TrOjHlvl8Rc+hG6XvwtGJLOtHaUWUlaUG+r3fD3EqI+GLnBajUNm/R/JSw2IeKKSKfa8PRJ9hLAAa1ylm456x7/DbssGejFtvQifH4MufOA/TSbb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCfux8kh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223a7065ff8so34304545ad.0;
        Thu, 27 Mar 2025 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743086259; x=1743691059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EP3Q4yIAaOw0EZrUQx4cjM2Dze7YJXchCM6sEBsoiCM=;
        b=kCfux8kht0ariV9cGoj6Qy5qV4wuHIumWWjNNzazsxhdbFyVX8XlLY1RWzSwcd27KA
         liuD7162/R1MjFnvW8v7f2QbHLlDf3BvHj4b8n6sAGCGjk7ohgu8/W0gcd5oeFa4t5UW
         XuVHQBfF5p8/2mnF3NutReUs1lS0RVRVFx3lJ+4P/fZpdlEj5BJGgGNbZcgliK+0E01r
         O8gpxnv9jfjQXkUhtIRsE3Bnw5AgOLGgCqfjdGaB6Me9AO3izC2Lh3HRmoJlSsCINspQ
         xWI0xSuI0XNn47KSaYGJn4/JyXO7GIR8oppTCuBpgyJhnQWEaa5c8t77aUZn0xut62Y+
         Cbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743086259; x=1743691059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EP3Q4yIAaOw0EZrUQx4cjM2Dze7YJXchCM6sEBsoiCM=;
        b=LOYNEDX965WRCTlVca9yP2awNat2/4kD99bPn9zMgkVol1bpqE+Gdf1tFBzFCQDRtX
         VO+wDzXlJ43Mr3hosF2r9M1tMd2pSI87ISzUPqKxFNDGxriM4Y7dISdRdA3jgrEow9lT
         b/2gEIeMHMBtp+bcy9hVwG6RY062WE5s6a7iqztKY6bC3SwoL+mr6oZzFZU8CHYUxxlp
         2R5A2mrrr3GQHtJnCwMpybUOFUOjc6WK5aIzsYAP3QEvxfp/yP+mJYX5V/FxSBO+Oyta
         wraDPwiOacc0NjNMq87iuTopQfurjWSHDtnIQuYh2WaNKC4Gm4bxKBaJ/KGWstL5CbG7
         WEUA==
X-Forwarded-Encrypted: i=1; AJvYcCUPrGfLDMoIHhnbW+1PEH5SSqKTfe31HTULFZJIv4RDR5WdTZ0TEfoQoNgCRxVlb2x6DxO+F3WQ3mUWTHY=@vger.kernel.org, AJvYcCW1dmYa4f4l2aVNBsV7xfYt862GynuDGakIb3e0oAfxcJW1+AtTdXLqTxLBA1ASvRFXohFhHkgu@vger.kernel.org
X-Gm-Message-State: AOJu0YzabZvHg51fm1s5EwS80PdYZAT7qiOPkvmLRpxm0KbmQiSIpV0c
	N3Y4PX3vIka6Prk3JrvNrcP9kJawQyhSSTYg0PNuq4GlN/FCELkZ
X-Gm-Gg: ASbGncs2zlM3WM0N+YnSoWQTgpB0tcXCH7jmujF2GjZ1DIw3em4lxg0yL3VDy8lR5lb
	WVND0m0o1WKWajOI+sjeLKUEUoqt0w4dTai2K8J3MMc5rJaJOjXneqWDC8IVkV/Doo8gHRuyKuG
	cYJa2T0Gjv4ImLNGmeuOpciMj7I78GYS/2EHTFDBIj/rjqK2dzczShzIO+LuI11cRW6NQ+mwxQe
	nRm65Cg5JSMkCD99X2ti+8Hz6syVsAPXFrbZscQptSYhVKe5S7GMF8njUGkQf5xEO64uroLiHd+
	WGZwGDNZ5u668WSl0JETpV58HviZ6GnqZJ1CGEW0f2uE9EHBZ5hYDiHp5KkmOIQXe0o0ZqFE3PJ
	hygMPuLqNVA==
X-Google-Smtp-Source: AGHT+IFLTjrLe6L1WJYlCp+rrPhU2EXLSBQqKf1OtGjGvATncHbkdAgpXIe7hZsv1NhBtdcnD/XVOQ==
X-Received: by 2002:a17:902:ebc3:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-22804958326mr69992435ad.46.1743086259171;
        Thu, 27 Mar 2025 07:37:39 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:5351:77c7:8428:7286])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b80b7sm129205185ad.110.2025.03.27.07.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:37:38 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: jhs@mojatatu.com
Cc: xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RFC PATCH] net: sched: em_text: Replace strncpy() with strscpy_pad()
Date: Thu, 27 Mar 2025 22:37:33 +0800
Message-ID: <20250327143733.187438-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The content within "conf.algo" should be a valid NULL-terminated string,
however "strncpy()" doesn't guarantee that. Use strscpy_pad() to replace
it to make sure "conf.algo" is NULL-terminated. ( trailing NULL-padding
if source buffer is shorter. )

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 net/sched/em_text.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 420c66203b17..c78b82931dc4 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -108,7 +108,7 @@ static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
 	struct text_match *tm = EM_TEXT_PRIV(m);
 	struct tcf_em_text conf;
 
-	strncpy(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);
+	strscpy_pad(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);
 	conf.from_offset = tm->from_offset;
 	conf.to_offset = tm->to_offset;
 	conf.from_layer = tm->from_layer;
-- 
2.43.0


