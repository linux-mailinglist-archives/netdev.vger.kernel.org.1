Return-Path: <netdev+bounces-211286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F074B178BA
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 00:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737903BE5B6
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663625CC52;
	Thu, 31 Jul 2025 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20230601.gappssmtp.com header.i=@wkennington-com.20230601.gappssmtp.com header.b="R36VtzYo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48A27144B
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999173; cv=none; b=tAO9yTV4V2dFR3eExL/4GmYGkeDeolqN5OaeIV7KQgNz7ZxcKR1wnaW+sX8MLEzmImfa8U/9EDEn7kh5j51h+BSCeZjlWZoPeNlORKOG/DoiRpjQe0TiUviYQJA8CJEoMtgCcfUiRy+B250T9VlQ2q1Yhc3YeIkWeaxOk9esIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999173; c=relaxed/simple;
	bh=9V6rW63ARqbfmydjM/Tm+7hXZzF5AWBKQYB2xvuevVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjdn2wG88r2M5CTA68iwEk3f9ga2oSNH0Zpzt5NJDAMg89oQcTll78wkR460GEp3ZFBxMP1SDgf3rt9y384m3lzBLO83WY30udN9XoKIScDA2agSt/Xu6KaBqm797U3JWnm75CRAMADXvEzzMGGh3H9ZgLAjBpvf4ARHhzeHE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20230601.gappssmtp.com header.i=@wkennington-com.20230601.gappssmtp.com header.b=R36VtzYo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2401248e4aaso18498685ad.0
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1753999170; x=1754603970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjOpiuHEGh+oOf4K6HcfROSNKOwu/C9DgO4MBo+Jjn8=;
        b=R36VtzYoOrVqh8Cw2jj/Aa+8KwWIQIdfaolimw62ziA82NnJy23LZErovQAEjrLIcd
         jBHk2Ux41eAGjj584pGPso4C2YS1bl+N+ldWWJt9Myn30tFPs1xMBRCJts6LCS5lWGzU
         6s0c4bKw2QX5Yu9QUufivJ/wtB8O5aIL0vGCMdMguZ8Ve/1XQE47Yj8RAXmDCibYIpxV
         OJ1NoBmRfaXGW14KbrmDC/N482lemS6thLSWTvWvX7vZpb4kfoWEWJk8Ptq9CsrKjHj8
         ug907NwYYwPmd0Rd8Ep06sGEA/B1xJ34XU4OhCHphJt9RxJUsGkRYTGLScXfJdKYqBPL
         u63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999170; x=1754603970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjOpiuHEGh+oOf4K6HcfROSNKOwu/C9DgO4MBo+Jjn8=;
        b=iQgHo12f7S1EQuAwuYBtVxgRnYdhvT5aZHdNkNoc2oCyiH1Ngpf7N8R0F7V+20c4Y1
         TL4B3LklPPWZN7DW4WbVIJaUaiD16kh1m2B/khbB8CifpSa5xHsPn8aEsdHkoIJ8yFBl
         ABVKxFQwLdx/+/0stww4+YmEnEdEXU4mrW2XJ33kevJ9RXGiZm0k3oepvffRinsREWy9
         BziigmDWXJyA/kV9ReOLZeKpW7YEhsFLz5PzJ+WIo3btAfTuQ/BR5ja39p6ka0u8QwEE
         vjOwwGxGV/Zrn0ceR/MKC9e2ST0bm8Xf9RVhQ5sKkXO+mLeTJ0fWWNifMaGvjdQmOtr8
         uiiw==
X-Gm-Message-State: AOJu0Yw6YnZD8T8B1rmN9oLqOEKIpqN6Cjt2nhLdBVhsxrkqfri70c3n
	SqNXf/wy8KfcwLp+9s7yD0BCEuCH6xtxxZi2dUU/zwIytTOt3oc3D2z7e4Kvx9/rGbiHRAirprx
	JtYLT
X-Gm-Gg: ASbGnctgEnc0DUCBqr1qHDmNTFoRVIFUAtN0LIQTaXQP6qICjNwPXFJMlclEQyPoPZ2
	VN5GliZjd1NcBKZxyou8NkmpDJLv6lsiL7WBP/jUVdhyuetSHRSDxr/gr2lIJiTtaroUpDMIGdo
	GKUy0nwbyQGMflK4KpDS53nbb6TFn8ocTvib7iygH5mBacWSWxgw5XZbaZczmIWrVCrsFMPYZp6
	W5XvMbdSoF8s3A0MUCjJj0cbHWLl+AzY/F9iKlrsu2yWVMeD2UgoQJaltUJX20OdtznGs9YBXgO
	vyKMsDjjbtUJCnVI9iPhprFlVQbU3RR0t/Nal/dFzDFqOm6njZyVZHeV78wy+na2pfp3FeJwQyg
	gKoF2xUmZdef7XL5IcuUtu0dXsbCBRgR2JEnmXe3mlyudPLC/of2PtzZNVsAHOnSCSmPj8M0yYb
	dKZkMZ3Ep9Ew==
X-Google-Smtp-Source: AGHT+IEr6FP7xOwIkvDCQXjBC3zPnHWxrFUqgvLdaWjsTOGldG+TyM3KZJ8Xkv+4X7Bgxwznnnqzmg==
X-Received: by 2002:a17:903:3c26:b0:240:52c8:255a with SMTP id d9443c01a7336-24096b0cf5emr168331405ad.38.1753999170261;
        Thu, 31 Jul 2025 14:59:30 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2a00:79e0:2e5b:9:1387:de4c:755c:9edb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a06sm26705495ad.81.2025.07.31.14.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:59:29 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
To: netdev@vger.kernel.org
Cc: "William A. Kennington III" <william@wkennington.com>
Subject: [PATCH iproute2-next 2/2] ip-monitor: Always monitor links
Date: Thu, 31 Jul 2025 14:59:20 -0700
Message-ID: <20250731215920.3675217-2-william@wkennington.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250731215920.3675217-1-william@wkennington.com>
References: <20250731215920.3675217-1-william@wkennington.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to watch link changes even if we don't actively print them.
Otherwise, route changes will not print the correct link name.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 ip/ipmonitor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ip/ipmonitor.c b/ip/ipmonitor.c
index 1f4e860f..14aba1f1 100644
--- a/ip/ipmonitor.c
+++ b/ip/ipmonitor.c
@@ -25,6 +25,7 @@ static int prefix_banner;
 int listen_all_nsid;
 struct rtnl_ctrl_data *ctrl_data;
 int do_monitor;
+int print_link;
 
 static void usage(void)
 {
@@ -100,7 +101,8 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
 	case RTM_NEWLINK:
 	case RTM_DELLINK:
 		ll_remember_index(n, NULL);
-		print_linkinfo(n, arg);
+		if (print_link)
+			print_linkinfo(n, arg);
 		return 0;
 
 	case RTM_NEWADDR:
@@ -263,8 +265,10 @@ int do_ipmonitor(int argc, char **argv)
 	if (!lmask)
 		lmask = IPMON_L_ALL;
 
+	/* Always monitor links for renaming */
+	groups |= nl_mgrp(RTNLGRP_LINK);
 	if (lmask & IPMON_LLINK)
-		groups |= nl_mgrp(RTNLGRP_LINK);
+		print_link = true;
 	if (lmask & IPMON_LADDR) {
 		if (!preferred_family || preferred_family == AF_INET)
 			groups |= nl_mgrp(RTNLGRP_IPV4_IFADDR);
-- 
2.50.1.565.gc32cd1483b-goog


