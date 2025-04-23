Return-Path: <netdev+bounces-185203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7955A99379
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC1D16760B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AD728935F;
	Wed, 23 Apr 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwYSt05D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89627CCD7
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422664; cv=none; b=Tl26hBpxUATRdQRCmQVhpbWT44HQDNCh/KfgWqYIQFZoiARW8Ej4avbq73eSSNdaxg5mlDylq4wYly6Vzyd3LlIWNrpdpfOlPwdFcL6msVZLv/pkjsNp6CJGTU0XqH7I47fq/B48HamosFhQ3oGxkmcISxadbV+KEmSS5fjV3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422664; c=relaxed/simple;
	bh=i1t4MtOeBkndzV6tGZJ14GFFEfYjU3c8AmBgDkPJDv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qpBy0/D+rEAMUZslLqOVhQ2brJVNkGHUSxmlpVl886TpVXzLV6crrDeYqk5bIOTA8jpTOH0kPp6SdDs+ncSU3jqVF9fBFx9nkZuk3ofw90/bI+RXZeaAIR6I8T7GPcsEGDSWC9q3Qa8ck9ab1U/QpNezdBXCwLvGgrvfRgIILuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwYSt05D; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso8872423b3a.2
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745422662; x=1746027462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2m0y1NfrzoaPO/6OZVS2FJc8mqAAthXkAk6s5KLYXZU=;
        b=GwYSt05D/91KgOPpNlm9sTIaPT26rc8MPnPN//p5CsZdUfXJW9LOh6p1gx8GP1wAx4
         27IiTliye0QqMRKiEdZIycrDV+TbMjgkFoVguvKXPsrN4PKId3NwjwMkRvEfTrCn+zFL
         zrp1vE9C+uW59fRag7rhbGJBwwBiE4kBRmfZTgT3aDUM1b9dUIjD9j4qVBUsAfkvUfyd
         LBvb2vTRvrd2cmLfew2VaW+KxcbUdagZf2H6c1pJvwHkO0aTjrL3nWkZ12PeVBD4f6m7
         OtK5H2AVOAB7WO5tPrcdrrgW1eUTdRlBsx0hTOPqSqWKgTWpZnQ9zqZnoFcS81+eUYdD
         yb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745422662; x=1746027462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2m0y1NfrzoaPO/6OZVS2FJc8mqAAthXkAk6s5KLYXZU=;
        b=N5szac5DMiV5UqEfvqRCj+TqtW9bgPpgu3TZwlYzlmGK73zWAET1Gus1FNL33/CmCU
         J1nuYV6JUrC7KLOpvnoYH/iB5ric5riMy481CdPSyRwTu2Mi6B53p3CIoHdLUdbCnPpf
         AgvgGcjmPARRk42C7W2KLEipeXU3EEVL77IfbKdqTGKluw+mYekTHX/1c6sZEI5xZw+C
         +LqrOL0Eq7AG9MqGBC3q2I8f7WLAomBJKHcWMwa/d5zCKnXQyp57nFQR9JvIS6eV9tTl
         94SwZzrbduP2nfsiZf8tn2HmZ6UT7d2gVwEjeOk2O6CIX1MHfJ0tfKdKWNlsiXgTUydE
         wINA==
X-Gm-Message-State: AOJu0YwvJiTA5aGJS+wb6r1l0fL3CEXXolQUASFHzS8qbSLJdnijOrmQ
	GJEvdA912TM1sE+2GWPzO5K8/OmrDbNzJL9icE/FSIKcFSPPZhkBTTLPmITw
X-Gm-Gg: ASbGnctFiqy+l0GGi4f8aQH/QMyvLE6H3ZYMvxYCIrp/uQfefu7/g6LqlPgKC0AeI+d
	T/YQE7MDvPEj6zgedSSLes9O8Hj4hmlpqwDivZBS1U/4WYeKpZ0RasOrIbY2IDP+Hf2uerHbqz+
	9hPKsUqnvjb1+u8hlh3DNCCZDyfzrilbcOKsYu5o5+52+0mUa+uoXFHInNrjEKVdmQ/5Y7Q+vhj
	FSF6jwZ86JgdB4v10CjrYhZ+QjVCw3/O2ILzEGTFfkZ9vTxRRn/v8Qzzmj7OwxH12e/o7D51kAq
	yQXfSqD1/qGGLXbk9z0yE+7TC1onRIrA02GNXe41mcHnDVUhq4TdSkP3Ow==
X-Google-Smtp-Source: AGHT+IG6k2rE0uwx4QStWHYp5tvZGBHiPtlgDxI3s8UOMlEKV9dSjbLdcOjvOaJEfBWjpD1URu977g==
X-Received: by 2002:a05:6a00:10d2:b0:736:4cde:5c0e with SMTP id d2e1a72fcca58-73dc14abb4bmr23024952b3a.10.1745422662004;
        Wed, 23 Apr 2025 08:37:42 -0700 (PDT)
Received: from shankari-IdeaPad.. ([49.128.169.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf90c45bsm10723814b3a.78.2025.04.23.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:37:41 -0700 (PDT)
From: Shankari02 <shankari.ak0208@gmail.com>
To: netdev@vger.kernel.org
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	skhan@linuxfoundation.org,
	Shankari02 <shankari.ak0208@gmail.com>
Subject: [PATCH] net: rds: Replace strncpy with strscpy in connection setup
Date: Wed, 23 Apr 2025 21:07:30 +0530
Message-Id: <20250423153730.69812-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces strncpy() with strscpy(), which is the
preferred, safer alternative. strscpy() guarantees null-termination
as long as the destination buffer is non-zero in size, and also
provides a return value that can be used to detect truncation.

This change is made in accordance with the Linux kernel
documentation which marks strncpy() as deprecated for bounded
string copying:

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


