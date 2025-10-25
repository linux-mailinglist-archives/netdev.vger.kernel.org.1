Return-Path: <netdev+bounces-232807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD41BC09002
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 14:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CCC3A674E
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F080C2F99B8;
	Sat, 25 Oct 2025 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0BMnNZp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689964438B
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761393929; cv=none; b=l6FpII/XIA53noBAtpQLvbgMj/wSURTYyuHKhba7ssij++f4OJzIdI0JCiEjmufb8VSZ+6G/EcX4Xe/lLS1hLckxMkxbZiG5A9ACAKFcs6yYFqLE0d4vducJxHQ9TkKS8yiVjbrOr7ZbYhu2cK+IlKqBDC7RKWMAIMGZYjfKHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761393929; c=relaxed/simple;
	bh=69y9OitDsvZG+ygITGh4xZyW20ZYYBCYMz7R434uZKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=txnB0BrSqCJ9nz4LWPa+8l+g7OHbR62HTcGPJagw7AT1qNSTUz6swG50DCkYH9LwhXFM1kfg1qItaBVzsSTBb4vzBB1pamcb3zFcV+QYGDX8jAcN6c5gi5BH/CDkm8Wuh3tTzN5owjfiFHd70XtDgCJQvLWvie73M1+SGL7ysHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0BMnNZp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so3621317a91.2
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761393928; x=1761998728; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcJ3/FBKK2ajxzIkHMY6ixiVILAkehDzwnS491Vgj6k=;
        b=Y0BMnNZpfTBwABFCVZIAHh3td9Z7lLwIgQyaUc3ZUkYsaroN3L24Juyzynbgp9anyB
         7wTmZLv2XZB51rlipw8hM3Pg2k6DUYhktOy4qKX94lW5V4bJ4J2mnzQittGVcpo16omp
         rlWvs3fkLMRnTcTY5aveZrD94JYaGrSSbXoezvjSp34Vd+awO8NYENgFaZVPla51vWgG
         oUWgZJxBD2FQ/fUDT3ky1HWfgle15M8S8kpy7tehKII6MiDYsUE85tJlgIQEHCVUlhdj
         M4S+R/BZESbFvNGrFufTVrRqmSea+DoL7cTn8tosugPYk1cmW800n0SkeYbAG27t6cg9
         h7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761393928; x=1761998728;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcJ3/FBKK2ajxzIkHMY6ixiVILAkehDzwnS491Vgj6k=;
        b=XYQCDRxqxtSNIJF2aKZC65b3koGt9GK4cdgIc7ZqnyFyCjA8ZUWJexav4kU0+Ibx+Y
         ljdMB85xRnU7am1LJERv8d4BpAScqu0ogSLjQYN+UanhBErARP072l6vD97CmreEWOHS
         d+BbDrFqWhtVD8UrZQBXvZM7ERskHXIBUir4ZpJ2x6AIsGe7OVC6Vmo0HoKZQzdASoTV
         DZ3fmfi78Z3SwAXoHT4JiUN1jneXDMaS6t3AJGhsXVpeJFMxxWV/RnBscw1e5qRr8HjC
         yvbwM0HCk4VKKkuzumVYgQyyyRy8C9yp6LXYf4dHR3Vxt4hNJPceXZuB9XOzlWJhdwTl
         my4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXR76YC3atsVG/9/I43wmd5LKan+s8QlZ4KdGb8PqSMHmtYpvPICCIh0d6DmWWlda1BSedznHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDmv/KbzDgId1CMQMd8ez9xDzS4VgL9GhjXEPqa3PVgCdD7cF
	rfHBj5WH3VpVNuO5//1gdizI36gR2h8MLeDUmkqCoy6CNiVsD8NWtQCX
X-Gm-Gg: ASbGncvgtmq1t5gU8bglDxroHVmYKYzz02SKp7x7Ff91/dmMqXsE573VdlVQg16WTLs
	OeImZ0oqXum2saGL8GMKsl7QMrFcb10fCz5W+3nBRm4Ky6/ljGnuiINmB10XKpLQNi2wxvw0koJ
	LC1PoklFkl2zx3aBjxMMxk5gSM5OeIbUpGEMQO7/0AxejuVXO7m1MRBrMLCrQQ4DEyjXvsT/4AP
	FDOjrmO5Lepr/mssy13p99oOLP3gICWKmup6X5qJcZ57gPAe2jhBN1u3hAwtMkoIVEejIAfpwRy
	QeQ478E1tXBEO5xe9skQAYErb+hUsna30mk6pACZo5IYrljo9uHovlRP8lV4dNAi1JJmoJ5N8Bc
	XlVnvkT35zJwtc1TaIqN/vMV2AlYYpB7xeTDB3sLLFGgAKkY0SQZhznAS5tXGkYjxGYQ8iQKhlU
	j5Ym2a4XEP
X-Google-Smtp-Source: AGHT+IEAK6eZag+MykEYgdavvPIK4g5Vlvg7NxyVKqzEv2FUkmjPRZH82E6BoaQ/fCmgKrW+V4J2Xg==
X-Received: by 2002:a17:90b:2690:b0:32e:d16c:a8c6 with SMTP id 98e67ed59e1d1-33bcf87d120mr44521355a91.16.1761393927422;
        Sat, 25 Oct 2025 05:05:27 -0700 (PDT)
Received: from [10.248.7.103] ([2409:40f4:2141:a037:1f2b:7d61:3375:68bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81ca93sm2150038a91.19.2025.10.25.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 05:05:27 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
Date: Sat, 25 Oct 2025 17:35:18 +0530
Subject: [PATCH] net: tcp_lp: fix kernel-doc warnings and update outdated
 reference links
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251025-net_ipv4_tcp_lp_c-v1-1-058cc221499e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP28/GgC/x2MQQqAIBAAvxJ7TkhRir4SIaZrLYSJRgTi35MOc
 5jDTIGMiTDD3BVI+FCmKzThfQf2MGFHRq45iEEo3mABb03xkfq2UZ9RW8b9uEnj5GAnBa2LCT2
 9/3NZa/0A7hvaPWMAAAA=
X-Change-ID: 20251025-net_ipv4_tcp_lp_c-1f7b4ad40c85
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, hswong3i@gmail.com, hlhung3i@gmail.com
Cc: khalid@kernel.org, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, 
 linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rakuram Eswaran <rakuram.e96@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761393921; l=2374;
 i=rakuram.e96@gmail.com; s=20251022; h=from:subject:message-id;
 bh=69y9OitDsvZG+ygITGh4xZyW20ZYYBCYMz7R434uZKM=;
 b=vWllaOOPUAH011DH/rlqhrvEcN8BOlGs5axrtJOP4Np2NxeVKvLN5ZCf0g8ypP6Mbq4t5lARr
 82IzpOkh3KjB8IKHqMHiKEAiY4dUTZicm9Bh/powGQO3u0qVtENBo7A
X-Developer-Key: i=rakuram.e96@gmail.com; a=ed25519;
 pk=swrXGNLB3jH+d6pqdVOCwq0slsYH5rn9IkMak1fIfgA=

Fix kernel-doc warnings in tcp_lp.c by adding missing parameter
descriptions for tcp_lp_cong_avoid() and tcp_lp_pkts_acked() when
building with W=1.

Also replace invalid URLs in the file header comment with the currently
valid links to the TCP-LP paper and implementation page.

No functional changes.

Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
Below W=1 build warnings:
net/ipv4/tcp_lp.c:121 function parameter 'ack' not described in 'tcp_lp_cong_avoid'
net/ipv4/tcp_lp.c:121 function parameter 'acked' not described in 'tcp_lp_cong_avoid'
net/ipv4/tcp_lp.c:271 function parameter 'sample' not described in 'tcp_lp_pkts_acked'

The new URLs were verified through archive.org to confirm they match
the content of the original references.
---
 net/ipv4/tcp_lp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_lp.c b/net/ipv4/tcp_lp.c
index 52fe17167460fc433ec84434795f7cbef8144767..976b56644a8a746946e5028dcb054e4c3e249680 100644
--- a/net/ipv4/tcp_lp.c
+++ b/net/ipv4/tcp_lp.c
@@ -23,9 +23,9 @@
  * Original Author:
  *   Aleksandar Kuzmanovic <akuzma@northwestern.edu>
  * Available from:
- *   http://www.ece.rice.edu/~akuzma/Doc/akuzma/TCP-LP.pdf
+ *   https://users.cs.northwestern.edu/~akuzma/doc/TCP-LP-ToN.pdf
  * Original implementation for 2.4.19:
- *   http://www-ece.rice.edu/networks/TCP-LP/
+ *   https://users.cs.northwestern.edu/~akuzma/rice/TCP-LP/linux/tcp-lp-linux.htm
  *
  * 2.6.x module Authors:
  *   Wong Hoi Sing, Edison <hswong3i@gmail.com>
@@ -113,6 +113,8 @@ static void tcp_lp_init(struct sock *sk)
 /**
  * tcp_lp_cong_avoid
  * @sk: socket to avoid congesting
+ * @ack: current ack sequence number
+ * @acked: number of ACKed packets
  *
  * Implementation of cong_avoid.
  * Will only call newReno CA when away from inference.
@@ -261,6 +263,7 @@ static void tcp_lp_rtt_sample(struct sock *sk, u32 rtt)
 /**
  * tcp_lp_pkts_acked
  * @sk: socket requiring congestion avoidance calculations
+ * @sample: ACK sample containing timing and rate information
  *
  * Implementation of pkts_acked.
  * Deal with active drop under Early Congestion Indication.

---
base-commit: 566771afc7a81e343da9939f0bd848d3622e2501
change-id: 20251025-net_ipv4_tcp_lp_c-1f7b4ad40c85

Best regards,
-- 
Rakuram Eswaran <rakuram.e96@gmail.com>


