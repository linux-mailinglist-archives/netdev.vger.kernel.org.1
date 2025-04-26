Return-Path: <netdev+bounces-186273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C071CA9DCE5
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 21:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108715A2C68
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 19:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DAA1D63CD;
	Sat, 26 Apr 2025 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9An+gSX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D22F24
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745695303; cv=none; b=kMzpHSUsi7C+ixGEW2Q8CmsGinZbpKUXHYdByNdeRKWmlxSy/V2jEm8K31IAmElcvCxedbKELYV2tHAIKWj75nSZTmjZiI6Nes1yzGsqFFSXTaJ0jIS28szdYdABb7eIHJuuaacLKVPgIB8WikQ+xx1Ze5vWIi8jrovwbHBBO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745695303; c=relaxed/simple;
	bh=ne8SMAAKCBaUp6u1vcjbMFD7DYJguWUi8SuVKnI+OY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5zezjQ9/r6SMUWK3fQlXfMH0m0d6OkPuFs8yVDhGSzazOFHvnulYaEvvPLXP9CKeOG/UVghrMU9iK8SIO0joEaHgSxcqAzBUpYCrSrMIylAolCl2/uwLBlWMHu7s82hoQ8GWuTHClYHqDvLlcdXDlT3IiD0AogyBxJZAeXFIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9An+gSX; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7396f13b750so3826724b3a.1
        for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745695300; x=1746300100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEL5MbtdxImeuMWMnzL3ySCD1MD8wsYL5/mtkpYZyWQ=;
        b=V9An+gSXa4H18Un2853xUKP44xW67NjAmUa+JqPnFXuy9S9ijy2hOX+MM6QbIRvpJi
         6/g+2d3eenWZ0FMRX/AgZmVJugqxdhta1eoijtqe4ptGEP+6sNqjWaHPNrzkWwJPHoYw
         AZpy9gj8B3O3WpUUlJAADPnwg/MDdHFNmdJATLYG3O5S8bBk9J8J48v2WxP0vOJOcG4I
         hoTzI+ebC3OIK8gx9smuMew9JtLUTQEPQIK9bHKuwGkmMW5Z7u1QNszwy2QMzC6ehc4v
         +yQSwhNnWtKFZeRjNJyUwUQnsbswZx3K9ATUEqVqdKRWb5t6b+ijlpJWmBnkxc9PBmdf
         YItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745695300; x=1746300100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEL5MbtdxImeuMWMnzL3ySCD1MD8wsYL5/mtkpYZyWQ=;
        b=m6wfa4atoq5+cCOfNXo3rQTsqHjUH43apnpvRe/qr+d0Trs+jy3GCSlOOg3pG4pnfr
         j7wE3hMkT4T0KgvoEEvpjB71jsruwnFlMkOAUoUOBWM0ZfDx71xoYDD7xrWm8x2hKt3Z
         5w/TjqOuZkQOiBX+73me43i3zAa6t7XGJsrmWa5rT6+RuscTkXIof0MitbhMlfaCdOhn
         sesHdBXbVqksOZ6UADys2D4SMQUNQkcRoI6/y9FlC6mb8FFdurOd2knjUe+9uR/Aj8tv
         XIl763/lw9KOlJHGvMa3ol1tUDKA+SzqpcfJ4fsxhOfCczrPgfNROKozSQp/4/0kCKMV
         XEIg==
X-Gm-Message-State: AOJu0YwjKXh2Ii/OeuUKO/C1BAv/BclliS4gi8l5JfKrTWCVcvG2HOCE
	qczD4OydQ8xpijXI8S2hh71dSkFYDuGqwCTzgPmfQd1ZoB8PaQj9TWRe6OcG
X-Gm-Gg: ASbGncvdYGMEjJyM2vs6q4LNID3XUMZ0lKVs0Z1v0+D1+LlKetBdy8K6R1XTWlVq7LM
	gFIXhgqxruWtuF0W0lwKxo4W1REbs/AT5GT6kpSGMGGJOVTtPzcHUPNHMjAlPH8yHnwkSU6b6Xg
	NbRRu7djnpZI9eRQPQ6IKlncjc+gv2LuaXq38Iq2uQcFoqTy5uR9zAWmwVZzt/cWb/JuzPtZkfu
	gx1lWieUx+6WDeohVwechC+0BOYncGI0jMao3nyXn55zqumtDPS3pXyp5oFKaZP0RdT3/+oxMEH
	x6Y4PZXrf8zuxex5ldXp35p2HZ+R9jHubBI8mQOobRORMIrRuRn2uHOX
X-Google-Smtp-Source: AGHT+IEkHJPQn9DAqkXt4CuSfyuujFLbfVrNlxhJ9RBQI+YtqcHIFAJgBr/QjdFUAD6hG75/+hr+7w==
X-Received: by 2002:a05:6a20:c88f:b0:1ee:e33d:f477 with SMTP id adf61e73a8af0-2045b6ee688mr10028173637.15.1745695300522;
        Sat, 26 Apr 2025 12:21:40 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f76f45bcsm4713207a12.13.2025.04.26.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 12:21:40 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: netdev@vger.kernel.org
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Shankari02 <shankari.ak0208@gmail.com>
Subject: [PATCH v2] net: rds: Replace strncpy with strscpy in connection setup
Date: Sun, 27 Apr 2025 00:51:13 +0530
Message-Id: <20250426192113.47012-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424183634.02c51156@kernel.org>
References: <20250424183634.02c51156@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shankari02 <shankari.ak0208@gmail.com>

This patch replaces strncpy() with strscpy(), which is the preferred, safer
alternative for bounded string copying in the Linux kernel. strscpy() guarantees
null-termination as long as the destination buffer is non-zero in size and provides
a return value to detect truncation.

Padding of the 'transport' field is not necessary because it is treated purely
as a null-terminated string and is not used for binary comparisons or direct
memory operations that would rely on padding. Therefore, switching to strscpy()
is safe and appropriate here.

This change is made in accordance with the Linux kernel documentation, which
marks strncpy() as deprecated for bounded string operations:
https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 net/rds/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
 
-- 
2.34.1


