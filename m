Return-Path: <netdev+bounces-179853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04737A7EBEA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA36189B26B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576B22172D;
	Mon,  7 Apr 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caqttTO6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C4253B61
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050670; cv=none; b=IG8nKrqVKBqYZ7dIEoRmJFfNakL+KPP/h4D1CM4VMxymNilepZ3V11QaxDuQMaHkiXtdZ+MzXTKoYPeSuODbvOz2VatVJTKEAGBRWlMMilyACL22Mv2rMawdO5+cSr9/wQkfGRHjpV6DNJzx9vHxjsMA7dLV5qmZ5J4RrL+TNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050670; c=relaxed/simple;
	bh=CxC8lM6vEnJ81VYdUD7FZJLMDi6KW5OylQzkmiEQeg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lyat6ee2qQL40erorRayegSk4csJxU3fNaAMwh5mFcivbpN2wYB8d3wWmAo2KrPuCqGOFO4cMS41IV72VFgGN7+zWIZ2jtcu4BMJOIL2uzsLiB4lvWGlW7jg4bBtkMFHEI21+pv04SeUvb2Fzvv6gq4SPdp0aaKYmt5aCYVRJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caqttTO6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edb40f357so23033615e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744050667; x=1744655467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/2q9Qpv6P3mzb6KZLuIOqkm3rWI7ZxLFwbSGgZgMMc=;
        b=caqttTO6nRNpf2wwhz80zVvm8Sdhgk03E87ynYUQRA+jj1SSHDUrrDX3t11GoZDMiF
         fvVX9JF5yig19OT/x8asdLuboRP5R6V3qE44OX9qRGIZw7J0cHi8rERnJDQYFH76XSvE
         O1MJPg85TU9g59PInnPogNQpVzKBur6WsnV50l4zQfezaP9oo0Ks4/LiJWULYNMYjv4a
         f8g7VNgQj+nbkuZIWP08Yohv55Jsgmsbw93nJmcY8JHHrtsqcbP41otWdjzO4d63Ndfn
         X044ql2IPLBxLJWN0Ll0vaTagomuYkWwOZjD+l0avqBtaPf6ErT/GD1pQ2pFUZdeUht5
         Dkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744050667; x=1744655467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/2q9Qpv6P3mzb6KZLuIOqkm3rWI7ZxLFwbSGgZgMMc=;
        b=A0oH7iC4KdI4eldsXHV/0tBBXCPwxY8X+9lajOBY1L1fd4GbpQwRxrYWXD3b86uAfX
         XDm9qhS2zANHm7CHpp8xddlCijyOUdgaURknwJ7uq4BopkJWnMHk3qX0cOmsc3iuC29u
         YAdkwrO0F54rcdDCsQrdf1XHnxyX2rWHJasAkDv3k/WfeOKoxXQ4WU/DNIVSvfLmym8/
         F6Q8V77t7QrHZeMA+qqTtiT0HrTnfKqP6og73MA2FI4r2fNPsPryokK5GGDqS3WX+k1T
         e009YBKDkaVuU9rhTkIcBDuCQek8sNYQ4Rq5z1ZGq9ZQ1FkGPlde19+teTITyOXC7IIZ
         RkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuvFtgJiW4ft0ASQwaEiwYK9HkoiOZhv9t+x5oI/z9oxvdJZJg+yBD1ifCvOpr1FQDMBm+MXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0mPQXB3SUfuUu4A39ALCSRDYS9vsdKk11M/ZzHm/rHYVOkd9
	HUoTh/4CXCkSAF9Plk6d8Tq3XHqCBDnIOF6sKJzUkul5OF/1AW6L
X-Gm-Gg: ASbGncuGjvM4/u0sLilq9POmYW4lBlwaXaJhGTcEYbkCHa/B3/vROVtWS0yjFKPJ+q2
	sA0cMJxro9fhxLoHOzSYFntvTl2O4x7EW6D+BLnhixHPPQuAQG+tbLcpgITn63/0FfLYmVp6/0w
	raaNDLEFyfGBZaC5T4X0YD8nK3qJ7Jinz/ziofVN7XXZ9JC2kgF3Om0dHbWCCotqKFLTmIuwLv2
	F/hfsMIeAjc5Lnopsq05o+zSMVx97Uo4Xp2QwJnEEE+rP7q/njQ4JlJBdlr9ZGzK2dkpsytnfMt
	mnYMEmTsU2IuAaENpVNpNiDwE3btihZUso2epEuMh/0yzvBXMQAZyHQKulE=
X-Google-Smtp-Source: AGHT+IEBQBTUZukT8NQNYa8jEn6F/ieubLZi1PrX5Xx7e2NajFdd9fBfpRy5XzgmC5J8ZUNxSX16Ug==
X-Received: by 2002:a5d:6d8a:0:b0:39a:cc34:2f9b with SMTP id ffacd0b85a97d-39d6fc291b3mr7896942f8f.16.1744050667157;
        Mon, 07 Apr 2025 11:31:07 -0700 (PDT)
Received: from localhost.localdomain ([78.170.183.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364ec90sm137729995e9.27.2025.04.07.11.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:31:06 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	allison.henderson@oracle.com,
	skhan@linuxfoundation.org,
	Baris Can Goral <goralbaris@gmail.com>
Subject: [PATCH] net: rds transform strncpy to strscpy
Date: Mon,  7 Apr 2025 21:30:53 +0300
Message-Id: <20250407183052.8763-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
The strncpy() function is actively dangerous to use since it may not
NULL-terminate the destination string,resulting in potential memory
content exposures, unbounded reads, or crashes.
Link:https://github.com/KSPP/linux/issues/90

Signed-off-by: Baris Can Goral <goralbaris@gmail.com>
---
 net/rds/connection.c | 4 ++--
 net/rds/stats.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..fb2f14a1279a 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -749,7 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo->laddr = conn->c_laddr.s6_addr32[3];
 	cinfo->faddr = conn->c_faddr.s6_addr32[3];
 	cinfo->tos = conn->c_tos;
-	strncpy(cinfo->transport, conn->c_trans->t_name,
+	strscpy(cinfo->transport, conn->c_trans->t_name,
 		sizeof(cinfo->transport));
 	cinfo->flags = 0;
 
@@ -775,7 +775,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
 	cinfo6->laddr = conn->c_laddr;
 	cinfo6->faddr = conn->c_faddr;
-	strncpy(cinfo6->transport, conn->c_trans->t_name,
+	strscpy(cinfo6->transport, conn->c_trans->t_name,
 		sizeof(cinfo6->transport));
 	cinfo6->flags = 0;
 
diff --git a/net/rds/stats.c b/net/rds/stats.c
index 9e87da43c004..63c34dbdf97f 100644
--- a/net/rds/stats.c
+++ b/net/rds/stats.c
@@ -89,7 +89,7 @@ void rds_stats_info_copy(struct rds_info_iterator *iter,
 
 	for (i = 0; i < nr; i++) {
 		BUG_ON(strlen(names[i]) >= sizeof(ctr.name));
-		strncpy(ctr.name, names[i], sizeof(ctr.name) - 1);
+		strscpy(ctr.name, names[i], sizeof(ctr.name) - 1);
 		ctr.name[sizeof(ctr.name) - 1] = '\0';
 		ctr.value = values[i];
 
-- 
2.34.1


