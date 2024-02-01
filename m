Return-Path: <netdev+bounces-67807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 081AC844FE9
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 04:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4C2B28D2A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4693B282;
	Thu,  1 Feb 2024 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="e1SYLNTg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146C3B190
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759228; cv=none; b=uxjVBID9D111ep4XEIhK5BWZO0uLL4I0VdXLNkHntXlKs8ykjqhgqCDoqxb9fBerRrcqaEpIVLd5CDzX3oG1wrZVFnb3oMlcIFsLJxW/eN+eyeLYWbaPY0Lb1wNeN0SHjPOk3tfOKopVhoGbyDaInIOSml02cCcPHWjLPBKjLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759228; c=relaxed/simple;
	bh=Cdg2Z0nRIAyTnylZI+TfBjUEzmhuAzZ++hbJBvHHHRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYkwPnhgUwiBxKJ9Gw7bdf8oSxb2gP2ghjFc2blatOAHUGZwko/MMie/sK5KI8t1BOpo7DjeuzfNXuSdQ88BKO491kvLWbjSq8HZc3jRIZhXFybTdoXezm756W5mpj/8do/N4Nw+jFe5OwpDRFxZG3PI8+3HEaygQZ4fqbOHiu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=e1SYLNTg; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd5c4cffefso547785b6e.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706759225; x=1707364025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdafAvOAWXCQr4lgpJpxZOhHmavMiYYo2HMC8CTdob4=;
        b=e1SYLNTgT7Z5nAn5JI5z/QCt8w/5Zi/oqpZCd6pikEZH8o5jWeU47WNTZZb/7K6NPH
         bnFB3VL6GScPSwODSXS3BsQ2AwNtKK3/YBYERPOb7T2GD/B7o9vGbSgcm4Liu6TbbLHr
         VBGRUtxkyfPfC8+q2RB6UowX1jMhDJ2wkei7F5c7744UQ55wyh8WXoKf5WWAfBBawMfr
         hL5MZ0nuD2KZS7rDnDM/erFTVqTwCxI0ijGrkE/o6jQ/coh+b+L6/zXF087UtRPgPRBj
         o4pmn/elwut/WNaW1wMWL7y9te7SY64iDnGgAV3rLRxs/gvPVqzkXy3NFLhPQj50F+mW
         PQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759225; x=1707364025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdafAvOAWXCQr4lgpJpxZOhHmavMiYYo2HMC8CTdob4=;
        b=E87YwyQn/bfTh5HMqVE9y1TNqAHGSh1YTlKyURVRmPBRX3InZlL1nA8cIpzJGP2h4T
         nJNPGcboyL+OGkKbNhhWsu0TuxuDtKrCqgF3Joaxz6hDVr9SbM1s474D0fXlgEkdjpON
         ciV8vGf+54z+F6DiYgW3PYkJGpMnogFvwimlw76X7JKaOpFbcYl1YdWWpkhGfrhj5H8+
         hwTYmqIMZ7VmU729X9sq8tzRrmGfZrjdsCm4p6BfAllE1KfOQok+kbRqgoCTwEYA6ksB
         j0aFCzFfOp+IXeM8ftVa/kdZHngb49PqYA6SM8T9pSQ7OodqJ+f+sLhBxzqR/P9ViXhO
         ybRw==
X-Gm-Message-State: AOJu0YySTkGnoXj5Bv8TnY8hpnNJTziXEO8Kj6PMxjP91jd4VCsa8X8W
	iErWOEgup1IFYM7giOLHLIIIm73ZgbSYLOz0boYUVy9is15YdABgM/BWp3LIPO7VfBU3O7wV6qf
	wPnI=
X-Google-Smtp-Source: AGHT+IHO1EzYyJPe5kRXe73Qcex14HqRToLJB81QT1lzSAmcogcRxShZNxr7URIWwGeh33iaJ35J3g==
X-Received: by 2002:a05:6358:71c:b0:178:a7de:2e17 with SMTP id e28-20020a056358071c00b00178a7de2e17mr1317196rwj.7.1706759225268;
        Wed, 31 Jan 2024 19:47:05 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id hq24-20020a056a00681800b006dbdbe7f71csm11052857pfb.98.2024.01.31.19.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:47:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 2/3] net/sched: netem: get rid of unnecesary version message
Date: Wed, 31 Jan 2024 19:45:59 -0800
Message-ID: <20240201034653.450138-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201034653.450138-1-stephen@networkplumber.org>
References: <20240201034653.450138-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The version of netem module is irrelevant and was never useful.
Remove it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 7c37a69aba0e..f712d03ad854 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -26,8 +26,6 @@
 #include <net/pkt_sched.h>
 #include <net/inet_ecn.h>
 
-#define VERSION "1.3"
-
 /*	Network Emulation Queuing algorithm.
 	====================================
 
@@ -1300,13 +1298,14 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 
 static int __init netem_module_init(void)
 {
-	pr_info("netem: version " VERSION "\n");
 	return register_qdisc(&netem_qdisc_ops);
 }
+
 static void __exit netem_module_exit(void)
 {
 	unregister_qdisc(&netem_qdisc_ops);
 }
+
 module_init(netem_module_init)
 module_exit(netem_module_exit)
 MODULE_LICENSE("GPL");
-- 
2.43.0


