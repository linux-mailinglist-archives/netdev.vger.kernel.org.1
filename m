Return-Path: <netdev+bounces-159622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C70A1620E
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 14:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BE21885492
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47BD1DE3CE;
	Sun, 19 Jan 2025 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1d+Llp/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B21CEE90;
	Sun, 19 Jan 2025 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737294230; cv=none; b=j1lbgIl9W/Ca/RUj8abiCddCJFwL3fNoRAyLLG9aqZGNaTLPBiRB353dcEVYy5I/ZBR3LDTGFWGrGhUbFa/Oawf8B4BWXoHK3TNImjtGLcuqJB0C6MedRsNxjKCHrP+lMOlMw/uqA2Zm4nauj8rVY58qwU/iMVECE7+Gt+21Qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737294230; c=relaxed/simple;
	bh=hsyg5PxvrQfXrTU3x+H+2KmmiXuCRGJbxRYhQOugc2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWnb8DghCSQGTsgCN61yYC89Eu4wWk8v9qIzhnxXGTb0AZsJVf3P0Dh2skMHpI27uVDoyIkd2OpEi18ElvgIB7c2pqS/HGfp14KoBdS8WnB8mxzDrnEqXfw2iMN131vEz6qVdQRYtRRNGgWCZBc7HOCyMM2zGWXiO/77KTkcJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1d+Llp/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-305d840926fso28018731fa.2;
        Sun, 19 Jan 2025 05:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737294226; x=1737899026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gWNi/IypbbNa7pbuablMjSeHo0lB0qQ1x7eVFjSs6I=;
        b=d1d+Llp/YjGpDPY/3BW36xo58O2KCKB4VLvskGtee8oK4Mk1nnQM49lLxIOxNHrMm5
         wB2oaWBaQ29B0DW7sTUWw+Sxg442yixdH8s6zPsNJWkZ+E4qUBF72Gld+11RgYA3N2qW
         rWGSFkB2n3J/O2bD8dJ8sydoxwOsMv7ji3PtakJ4V52TxRzlqqHA22zrmZV83GpkW2lk
         JulyeQv/uALH0eiszgZZ4a8jIKlxqAR1I8eWLjZEGFWssctJsONwikro/A+vS7M+sDY9
         yf7XeAGe7tNrOd6YZ8AceHYr/h5nE+isBQyYj82EGz/effQ4Fl8vAuiIp35KHJxG0FT0
         e6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737294226; x=1737899026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gWNi/IypbbNa7pbuablMjSeHo0lB0qQ1x7eVFjSs6I=;
        b=v1uBR3qKVmJnDd6nhyHSr9pyg8xxvhlxxhXhgFftGoa7t5s/kj7+PDfuVtVD6Su4A4
         ZrS2UhIhjPCfDGMhirmb7YCVDxthOun/LSFkzrdeVttaZkzdNOrH3FnswmzgyJYf+rk5
         jIVktYJ7NqhiaoTay9DRCFpkqFEsv8jy9yDwUvOi3HLB+RMHGsD6YF5Wc+s59g+HjocY
         9dSkZD0uw+kuHcIASdJkGF6FuxJ/AwoELzemD98ggg0o2jIwE/RvQPL7VxnGwDnZu0Bh
         /0CrIA8VfEvuBeIsw2B7YNkSMB4sAwJocStSgggrK+v3ZC7q9DClyNYnI7F4RH0IyCDE
         kpFw==
X-Forwarded-Encrypted: i=1; AJvYcCWzs1/WaCUUUmjolDSIwBksbnTAYBLJWq7mWUw+J0M1MUDuyuzahztL1xV3H6eYtUrjE+V3Qnp7OEP2MZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmljFW+VOEFiDsohlDCfPiecI9W0Su+1cVBDYQIHINK4Lvfqwn
	YYji1rAzxkJeCEH7B+3DHKavdDeHZ8YqMxPjfPho5Ys9K07ExsICN6RuMMzIl28=
X-Gm-Gg: ASbGncth0SN8tNK6H1Jy+R/wSjovcaAxFjWfTl8Rl+oMXy3U+eGZjlO/rqZ9i5HIeV/
	z/RV/DYLFsLXyN4gJ3sc4HMljW6uJdZiVeJROLhSjw200mB2YTOBmo1tddrY+CvVDwtUxFp4L2T
	sYLv74xOcZPBJ8hPF4WSx5fSkt25CDuZVlsfyT4K9Wqr5Ixn1Wmuow4ZhR3UHyK3ZUc68gWdlCf
	373Oc+WLKkpgv4ds5J84Etykwtq71Hu+Sp06M1vkD0z9W37Zv2zyPyb5f1y1yp8g6dqiw==
X-Google-Smtp-Source: AGHT+IFD1n5RtEB+MVPMtBggP1RCJlrcXB24p+GJ61EeJv2QrtTgfD1yfPjJyH+PPe+5oMwwgO3z8A==
X-Received: by 2002:a2e:b80b:0:b0:300:2c9f:ac51 with SMTP id 38308e7fff4ca-3072ca60dd0mr25158601fa.2.1737294225774;
        Sun, 19 Jan 2025 05:43:45 -0800 (PST)
Received: from X220-Tablet.. ([83.217.202.104])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a502c93sm11942831fa.101.2025.01.19.05.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 05:43:44 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Denis Kirjanov <kirjanov@gmail.com>
Subject: [PATCH v2 net-next] sysctl net: Remove macro checks for CONFIG_SYSCTL
Date: Sun, 19 Jan 2025 16:42:53 +0300
Message-ID: <20250119134254.19250-1-kirjanov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since dccp and llc makefiles already check sysctl code
compilation with xxx-$(CONFIG_SYSCTL)
we can drop the checks

Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
---
changelog:
v2: fix the spelling mistake "witn" -> "with" 

 net/dccp/sysctl.c        | 4 ----
 net/llc/sysctl_net_llc.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/net/dccp/sysctl.c b/net/dccp/sysctl.c
index 3fc474d6e57d..b15845fd6300 100644
--- a/net/dccp/sysctl.c
+++ b/net/dccp/sysctl.c
@@ -11,10 +11,6 @@
 #include "dccp.h"
 #include "feat.h"
 
-#ifndef CONFIG_SYSCTL
-#error This file should not be compiled without CONFIG_SYSCTL defined
-#endif
-
 /* Boundary values */
 static int		u8_max   = 0xFF;
 static unsigned long	seqw_min = DCCPF_SEQ_WMIN,
diff --git a/net/llc/sysctl_net_llc.c b/net/llc/sysctl_net_llc.c
index 72e101135f8c..c8d88e2508fc 100644
--- a/net/llc/sysctl_net_llc.c
+++ b/net/llc/sysctl_net_llc.c
@@ -11,10 +11,6 @@
 #include <net/net_namespace.h>
 #include <net/llc.h>
 
-#ifndef CONFIG_SYSCTL
-#error This file should not be compiled without CONFIG_SYSCTL defined
-#endif
-
 static struct ctl_table llc2_timeout_table[] = {
 	{
 		.procname	= "ack",
-- 
2.43.0


