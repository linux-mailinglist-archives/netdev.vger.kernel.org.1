Return-Path: <netdev+bounces-164492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBC5A2DFFC
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E091646FA
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617941DFDAB;
	Sun,  9 Feb 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFK/nxwr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989B1D90C5;
	Sun,  9 Feb 2025 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739126668; cv=none; b=UprAhhrEayG/8IZs2UYEfcmWpOU8+Fh+HLyLfBl1jXEgOmFQmYYnqpXLxpjH959soK/gwYO2IuOO5q0VIiZtpswnl4D0DEo3BMBmd9f7lqsD2aPJBMlRKveyrB0B2SpLLZQK+A0Sd4L/xXQq9CWLbWDjwtfrLiFIWYHxj3GPJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739126668; c=relaxed/simple;
	bh=xdJpzMwN69SX5A49+eaIxt6rJRzUQdhu2DalB1RLN98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ms2+5l6Ca+Ca/W6GAjTCxoIJDN36gTHXtii2B5korJTCgw8U1euRIvgpRbXepDrnzxFm4AFfypRjdPWdD7zrfy7L9KAiQlZ4j1IuUW6ta6qlqqFzfQGFJe08f2rp2+JwVx2tq4XWXh92x5K8x5IcB3hxhQLccTlXIR3MD7/vrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFK/nxwr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f50895565so32287585ad.2;
        Sun, 09 Feb 2025 10:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739126666; x=1739731466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajkWu1Bx6iXQcpDtMyUqwYe+QP2yL6WGw45K6q0WsQk=;
        b=XFK/nxwr/8JITH12HuE356tlrvIYrSn8K63zhJb3TVCz0Fy5I63Cby68VZ58pnhu8q
         NJrH4xwsHfoYa1JRopAtXSnrOBdHEwCfNqW/o3YN8HsGy75pwGbnCe2WJ6Mz+SEd7TZX
         krxGlyRUK8rZbe06FlvEg5fdn0ljL4gZK02aFO7FHN081BYQGvr0cVnI4oQdT5SGJqcH
         MFXoatU1mGHEgdyW/GoS+BTPIvxxwF3hzVGSugVGzjAXvacDaKToU/aH8E/9OAkGIcFd
         fIN3LyN25QYnhNvO1jqfS/j+jsHcIK1MiSScL6QKPqLmjhpSffRFaNh9f6J+d3ZWKnWw
         GHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739126666; x=1739731466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajkWu1Bx6iXQcpDtMyUqwYe+QP2yL6WGw45K6q0WsQk=;
        b=lidi1qdJiP72Xx+Yk4JfFf9KA+QsSyJmLt3O610B0wTNBjfmyYCsdFNKVZbI+QWLEv
         e6AYVLzSSDyuztb1aYaENMEylxZSSRmhSI7aM/Jr+fdEtiBWdrIo2AJicVvpE7CSwq9U
         idWWqsIZ3c8zs1zIYA8GQKZCAN6zcc/CGu7o1hWuf3w3SuZCiMB4mlSAX3iMcH1yDCiH
         f8+RNuZ5RaTv/O8AbkiIngZh8YJNTj6bgTK5qYzfULktS5toZW8o9skrnK0DuKspAUAi
         mDA/nn8KGqrigctqL5/+FJunC0Q6yWG0DIikz5zUyQN7PWcmf3e+JRKSdP+eN2bpaED1
         mhXw==
X-Forwarded-Encrypted: i=1; AJvYcCVikLZHq4Iftt4ls7O9gSJvvHCvTwMZF8UHb4sEqKIq/t9WOph9WQ8GXN6mI1tqV5OK2Rtjz+j+FoSzErk=@vger.kernel.org, AJvYcCVy0j8ZpKH7gKv4EwCgm8nTg4R2QjX+5Ny3r+Di9ZQEJTeEEORt8LwRe+tZpE09Mre5EK6hn+GW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyow0+/xlTK6DFFwO2fXWMsEUrh67y63pqic32eteyvSMWDkbc1
	JMgetImNk6Pw8nUJrXPBKAnWdAXtZoFPBQ1LWUBOdr4BoXcFUdg82av/oeP/
X-Gm-Gg: ASbGncvRl/WExNwAJAFctPl7CvBn8a5IGiVph90A4wSFR3FYf5fA53ouFF4+pD8YyMB
	JCwIGn1HikqUomyt9J8tTeH0W5u6nobi9XAxctSaexIwASGNRaD9EKQSpwJr42YMBmqQNdNJ2yl
	CAzkIUW420BFw/+DjiHzcCrZfEjtLlOB+RqK3CG52l20xbUcDym4o1d7EL2zv81nMHA4l1XnjUq
	sFgKvGpzbpOxK9V2CDruURRa8ge594Ia21B7llxPnsin/N/kk2ov2kOCPf4DHasWlh59M4U9X9+
	u5CbVOE5aygjB8VkChqJSQKN61qgL9NQqSA98nEn27/FUNV0Nw==
X-Google-Smtp-Source: AGHT+IGdXqDEsQ3wl/SgDgEu7zQuvEjgri4w7IBh2/3FdUaxqctxIhNSngJjXblcV+laA6aNXUPiwA==
X-Received: by 2002:a17:902:d4c5:b0:21f:6be1:97c4 with SMTP id d9443c01a7336-21f6be19893mr114642315ad.26.1739126666097;
        Sun, 09 Feb 2025 10:44:26 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40c0:101c:99b7:ab17:cf9d:f4e4:5a6b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d55esm62982355ad.152.2025.02.09.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 10:44:25 -0800 (PST)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: skhan@linuxfoundation.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	purvayeshi550@gmail.com
Subject: [PATCH] net: unix: Fix undefined 'other' error
Date: Mon, 10 Feb 2025 00:13:55 +0530
Message-Id: <20250209184355.16257-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issue detected by smatch tool:
An "undefined 'other'" error occur in __releases() annotation.

The issue occurs because __releases(&unix_sk(other)->lock) is placed
at the function signature level, where other is not yet in scope.

Fix this by replacing it with __releases(&u->lock), using u, a local
variable, which is properly defined inside the function.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 net/unix/af_unix.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 34945de1f..37b01605a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1508,7 +1508,10 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 }
 
 static long unix_wait_for_peer(struct sock *other, long timeo)
-	__releases(&unix_sk(other)->lock)
+	/*
+	 * Use local variable instead of function parameter
+	 */
+	__releases(&u->lock)
 {
 	struct unix_sock *u = unix_sk(other);
 	int sched;
-- 
2.34.1


