Return-Path: <netdev+bounces-201585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A2BAE9FD9
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902401899FB4
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E413B58B;
	Thu, 26 Jun 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rFRez6b7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263C2580F3
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946571; cv=none; b=siExTLVWSrP5F2TCS7mGiHBpX4XFmWXUlOgPdGPb/OmBTeuDBaOqm1RJsNYSU2awPB3Db7pDBwffP1FIPYNZHqAt0R/mtWKGTrkyLmf9lfjRNQJiKpjVrw212IsWWD/MZVuJ7KGDBLPnRosgH0uZHFHpPtS9/TMnrXNwXRlTptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946571; c=relaxed/simple;
	bh=H4r6CdYZiRNtI4xu+VI8tFgLBodMV1zRrO0yuNwl61s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHfwvffKpw1etmRMPTWCrg5StsZJqUMx+crvaes3daI09ZSfu32RN7zg1I2NthezS7wxXtMvaCAFKsixiGjPZdR6AVhIJHDH2gjHYLbfOKAtVOp0JVWNnbRhyMrStZL9hUdzV760dIiGCZuxSbTJOs29R+8eTfmBJwoG5eJ+iHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rFRez6b7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a43972dcd7so13738091cf.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750946568; x=1751551368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/ppp2CjZ/QXIq6P577Z8qwmhMJFKLaWb7lNCIcSnEA=;
        b=rFRez6b7gVkIbt+H994Iop/5p95u/hBt4YIS4Qeoxfhu9ygPlMAspTd8EcEShEGcp+
         2fBdIY0hhEUvgVuVrPbdcugAk+D1wlJWgqmhffatbyTLIkpz0EK8YVwHj94o6Esk0cSZ
         PG/nITxos+2/anTC1nzSSgY0YcRxSZUUMFQPOPdfD9/GkS30zhjmoEVkhlimldqHbe7s
         Kw06v+bYjyan6IeSSOKcJj6CiYtjpIZIV7pU5+YBr4liO/jWsYd0Unvajl85ypZGZlOl
         jaR72+8wHxuhzq7i6tA8NGX91oI08b+b2PwgntRRaOaQM85ZTwgSKZs1cPvmnGQbrY9d
         nmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750946568; x=1751551368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/ppp2CjZ/QXIq6P577Z8qwmhMJFKLaWb7lNCIcSnEA=;
        b=qLi/0IdfnSMpwVASaxrMqrg+AV4EESLw09+JoBRKqNtrLRbTFtN9dXikYDoRy2zBWz
         JRSGlASfOyOL7pZt2c35OrVcD5oYLAKwTpi2PPv7hXnsPFjEw9YT21tUgURemWiyVxQg
         /DL8IbivPrDjHPtXXOiAow4UuUIm4RUpkFhkDu+hLSMfkzISuhr6ti+zQUAackBfNMe4
         eEU/QlruVviF5kRdGicpr/Ic3GCgvz9JSChBz9kf3A9d559fKGAZCUk4U6+YWFtDID7N
         5ki3HgPJsebYx0onxfM8b5lZ7cBQZtTN0mg6NkBOQvK9cC1q279Te27MbcF543QoTFrl
         9mcA==
X-Gm-Message-State: AOJu0Yx58Pyb7zaMSzfccbP4kcFVWQT0RXQFhprRJBBFm1yBoo6ovMzB
	BePvoeOc2RJKpl9ylkqehp2Ku/FvGcsFLqMBlIqpvo0Ff7AKmEl5s7M9idZdMYh3shBF/9l12sN
	FHlBF
X-Gm-Gg: ASbGncsAWjFnG8rpUHyvvn8L7bzgxTI4Dbja623fAejhPze69gB2fatqbh613dNfKRD
	Pa2LmulnkNio40xF/7MD4jWNiqWLFe7BOv7CvggL/91J29irNicDqI7trGEzWbvUih4cIPkrDLP
	meoJhrIT1EiAMI79WdT/KUoOB7ehcNmLfLCuq7/jvajhrZMVlP/lTdlk1oNZBGgc4Cat6fikRtS
	WyBBeA888zqw7NLkfkkel5C/W3GqdqXBO2wya3xopXuzz9is7pzwAu2x5Rou3qNvtVAju8VgA8C
	g5d09XcriOd0QvFMiXcXY+zKO7KBBKvO58ifMywBcdnLctcw1gGiGGzbNCngMU0hLLhVq6mpza+
	x/lLMvx/Yq3/CCdqIIDvlcvxWoGXKbXxRl5fS
X-Google-Smtp-Source: AGHT+IEnGziqoGnBEWmJse2jCrOGq8kfZqcQ+1tkWZanx9NXuQlZ6IAmYb+ZI7XTZq8+Tpl01EbG+A==
X-Received: by 2002:a05:622a:2293:b0:476:add4:d2a9 with SMTP id d75a77b69052e-4a7c07d3e6emr114607741cf.30.1750946567795;
        Thu, 26 Jun 2025 07:02:47 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e5d077sm70399001cf.52.2025.06.26.07.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 07:02:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	z30015464 <zhongxuan2@huawei.com>,
	nikolay@cumulusnetworks.com
Subject: [PATCH iproute2] bond: fix stack smash in xstats
Date: Thu, 26 Jun 2025 07:01:25 -0700
Message-ID: <20250626140124.39522-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building with stack smashing detection finds an off by one
in the bond xstats attribute parsing.

$ ip link xstats type bond dev bond0
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
bond0
                    LACPDU Rx 0
                    LACPDU Tx 0
                    LACPDU Unknown type Rx 0
                    LACPDU Illegal Rx 0
                    Marker Rx 0
                    Marker Tx 0
                    Marker response Rx 0
                    Marker response Tx 0
                    Marker unknown type Rx 0
*** stack smashing detected ***: terminated

Program received signal SIGABRT, Aborted.

Reported-by: z30015464 <zhongxuan2@huawei.com>
Fixes: 440c5075d662 ("ip: bond: add xstats support")
Cc: nikolay@cumulusnetworks.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/iplink_bond.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 19af67d0..62dd907c 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -852,7 +852,7 @@ static void bond_print_stats_attr(struct rtattr *attr, int ifindex)
 	const char *ifname = "";
 	int rem;
 
-	parse_rtattr(bondtb, LINK_XSTATS_TYPE_MAX+1, RTA_DATA(attr),
+	parse_rtattr(bondtb, LINK_XSTATS_TYPE_MAX, RTA_DATA(attr),
 	RTA_PAYLOAD(attr));
 	if (!bondtb[LINK_XSTATS_TYPE_BOND])
 		return;
-- 
2.47.2


