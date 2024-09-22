Return-Path: <netdev+bounces-129173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39A97E20E
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 16:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1251C20E89
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871FBA50;
	Sun, 22 Sep 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qdRRtqTU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311EC2CA7
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727016391; cv=none; b=PFm1UJ6FW+JZsythjRC9iFMNgQSBMHudhs8P8IVK4YiZ/lL0WTO3yyIK0p1XSAmCKPdPXnPyYmJi8XZ6Dc+Ql9hmQWH1I+XsHIgQ1eyf4L7eXGOGlfSoPc4j9zm9SRmnDqxRJNW1h0D/Vwjs4koF1V3MmRlrEmL/wigv8xsUCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727016391; c=relaxed/simple;
	bh=PHPevfpJk+NzNSKAui3Hgt7JUYg7sSL+k7we0NX6b2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9FEj9rKm2PJ1ACU093yqE0cHPUbLsH3CnJG2pq1J1G3SnwDP4PDfNxe8fZVp8FCArrqW97qHFW+WyU6N+dO7CTBYhSkCrF1/YHU5GXvv6vLlgXygufSJX/JZRx7JVm1LXbesQLUCpIVxeVhGe/ULGI0WNsLGPutHn7gSayq+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=qdRRtqTU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so517444066b.1
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 07:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727016388; x=1727621188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXKyj9QfU6TS4dahNlEkSbG4SpYUyfzDDNO0f4/oKhE=;
        b=qdRRtqTUZqhCfaUN1EWtFvWcUYSaCNyzi1srRPuv355VVl7AevXgsjzmU6PGMy8e13
         syly86aPycoV8CrWahavPGKxXk7FgLpseX+z2S8DC0LIC9c/UDckmwoKLICr+MwsfSZ2
         ofOvaCt0qbm+axbE1T8ZiTOfMWxAcpa7JNdqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727016388; x=1727621188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXKyj9QfU6TS4dahNlEkSbG4SpYUyfzDDNO0f4/oKhE=;
        b=E7TymlFGdict0/1ikuofC0L1QY/GULl9FH30wy8cipFI2uMBmpOEaB7/+PizZgfxYX
         OZL7kbi87BZZQtYGYkUiEUUAf59rYVP8klRckn6Dq8HmEDWLTPFOD6yW+68t5uOgswR4
         Jstlr2Xv1Lef6oL4WMgqpUu/Yyus7o7/z1wIOQDdwKdqYr2uTadoquVnWjavY6QHoo8f
         b3ZiFqbAAJ7v7/5w6WhtI4AGKP2LCDfpPTVuI0/VQhm2UmVASWiGxE7zdnhbWchvS7r5
         wzryZKUm8thTlp5QOo96OsCtkUgNlDGLydqQzLhRZLGtExsYf+xgZUzgF2GrUc9F26nj
         Jy7g==
X-Gm-Message-State: AOJu0YxbuPV1kyOSWErddzodI1lsOQs5UF/wAhOpK0gP+tgFZtCcC9aZ
	96h9cExQpZ+gq2IoWBxk0WEvvUZSSVDEbsdAJruhNf5BJEHtwq+DDkG+zzEHPd7NnBMcuOlkSzR
	KaZc=
X-Google-Smtp-Source: AGHT+IEl8BPjowrfof8Mt/8/MKO9Ct+wXWvvu8sSuLNO3UVgkUc77iiusYV9VAEjxAMqfbsFS/ohWw==
X-Received: by 2002:a17:907:d599:b0:a8d:5e1a:8d80 with SMTP id a640c23a62f3a-a90d5779864mr897982566b.40.1727016388245;
        Sun, 22 Sep 2024 07:46:28 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-102-52.retail.telecomitalia.it. [79.20.102.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061331694sm1088425766b.210.2024.09.22.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 07:46:27 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [iproute2, RESEND PATCH 2/2] arpd: drop useless initializers
Date: Sun, 22 Sep 2024 16:46:13 +0200
Message-ID: <20240922144613.2103760-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922144613.2103760-1-dario.binacchi@amarulasolutions.com>
References: <20240922144613.2103760-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is useless to initialize the fields of a structure to their default
values. This patch keeps the initialization only for those fields that
are not set to their default values.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
 misc/arpd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/misc/arpd.c b/misc/arpd.c
index b4935c23eebb..a2ae76a41f8d 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -439,8 +439,6 @@ static void get_kern_msg(void)
 	struct msghdr msg = {
 		.msg_name = &nladdr, .msg_namelen = sizeof(nladdr),
 		.msg_iov = &iov, .msg_iovlen = 1,
-		.msg_control = (void *)NULL, .msg_controllen = 0,
-		.msg_flags = 0
 	};
 
 	iov.iov_base = buf;
-- 
2.43.0


