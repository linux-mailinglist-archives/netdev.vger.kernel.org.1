Return-Path: <netdev+bounces-193551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2C1AC46A5
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 05:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACC33B3D53
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A308516FF44;
	Tue, 27 May 2025 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="V7/tn9Vk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107282CCDE
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748315071; cv=none; b=EUjloZO6HUwEEEP0bF8LtkseUjxOly7XpuCU2uR9PujMLE19Pepi8YRHPXbsUqDG5dMpSNt2LCdAJQ2j2+jcCI4AzvXfokQf8JwrhslWgldkt0tDAlrThKOyv2HWqfKkvZHcbNnrSuxyDrFZtVxHvR0kjL9NLRDhmeh/X30evn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748315071; c=relaxed/simple;
	bh=mrmFu/XjnQS7ROhx1vC5ciEwR90UhyBUP8N+TYUVJYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pxA10X26MBbPwXmwLnPV/V6IvxrUQIVizwu8S853dYBYBIhaMiTmQux8d1t8FGp1TrjlpnyUH02wENpK6U4DM0F0w8dCSDDK4xe1pp9mM1yoGD7P9goE+VqTp2u191GKpwqayOKmwRpxp/4i0+sGK1tD1Z+o2IqyXqqU17gQOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=V7/tn9Vk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73972a54919so2107293b3a.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 20:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748315069; x=1748919869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mhoTuXohMe0y1UcfXiHpq9sDKMzNzKjem7Gt6sJ7UEI=;
        b=V7/tn9VkdkkNCtpEVs/kanXyWq3IbPBkySQuXVtietmcuKaLfFoa4cf0zCyJj4wFb6
         WhNPQoLq0XK3f02Q5grUpAFyPgk0UVoGKESS/uCVJN/nto2QY2puxpbJJYxdpg43XFbG
         WY2oYyAwbqJz0X8dumtRdpqHijQR7OwbmWEDzF+JMdOPXF39+io9S50KmKHf3RS3CJ5q
         I8+63CuZNWsRtYNBX6GwVjQTLpeeLKJZqgX+iKlWdeQgqASAs6TouWUlBOLMcCvhUTrP
         ntqjv/Yc6xBc7tQ59wTNuXNwUuRlxV8wyJj/YX5Tm2zOzuHEaoDlFAz6xPLgmEtRYaUx
         mxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748315069; x=1748919869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhoTuXohMe0y1UcfXiHpq9sDKMzNzKjem7Gt6sJ7UEI=;
        b=p2sm31DgBH27ftPRmXRNZNuFDg0S7YFanXPmS9rTM8Wl6fr0H2kKDHlpCX+VuelQlO
         T/zRq8sRejykPINPdB26a8+iACwscGLQHuCXjfsIaLOlZU1NOFnl7+MlLTHTFxclfX2M
         c9XXdRYBF4VLSeQMkJYgsM41W4daycEcE0iDpsQas1xMm2HGPvmarbFAZTxQeV8Sg3lc
         tzGFp1EbgrDDXXdr9XXRN/Bp4PAHo9m3cpP/EksQYMNzUSx7sOAV1/fiBW7V8rmz27tQ
         tgdPiSRnkLkbHGQmzpb3OPNSQNQ//oGQ2AqUcpKQXv19EBORUq7fognmvi89cR0y2fby
         90RA==
X-Gm-Message-State: AOJu0YyNRd9730sLbiuL8QSsc8eBr7uNdVKBl0z7YEdJnD18x7u+e1Yy
	Trozk8sk19pjPSfPpXrzoWzl3LPfjIHmRbEi3a59jtrtgH/LqGBFWFiCPYOQrPtjCkE=
X-Gm-Gg: ASbGncubDUDzbNNEvolzfDB/V9SORwRISSp4tB2O9W4oBZgmhSe8ZnXeBW7Wj47lfID
	8xWcGHNlhl7sGxTkRMJ1uwfDe7RN/QWBWwuZEuh8dTe9xXYF2wW6aOi3jY9efQZgG1vlRO+tevy
	n8iWpwQ/pyvf3bS3qWmKAcyNrpKoKnt40GgAljW5hsESuPklFT7W6nrScpv1FaRZIey7ePb6u2Y
	1ouM7SALAw5bwmCX5a2a4ASwHbyjkCGz5xYtJs/vL3MarQ8sBB44P67cRieBw5p0zio76Se9++M
	1LWNz5moOYvE7no7ec/uAoI/7N625UIo63uCHBNn+bU3DZiBDqHVg/mSdZjRhMH7DCsq/1NZ5Cu
	o1JXw3QnC7dA=
X-Google-Smtp-Source: AGHT+IGIxPmpGCU3g33+ttLIcANNS4fOgMwbgZTRWOf8icAGIF+GBx4LwE/HNPr6msMMXDMDjr8Zsw==
X-Received: by 2002:a05:6a00:114c:b0:740:596b:4a7f with SMTP id d2e1a72fcca58-745fe035e92mr16313897b3a.16.1748315069270;
        Mon, 26 May 2025 20:04:29 -0700 (PDT)
Received: from G9X75MXGL4.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74621ba1875sm996933b3a.80.2025.05.26.20.04.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 May 2025 20:04:28 -0700 (PDT)
From: <yangtengteng@bytedance.com>
To: edumazet@google.com,
	kuniyu@amazon.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	wuyun.abel@bytedance.com,
	shakeel.butt@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhoufeng.zf@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhangrui.rod@bytedance.com,
	yangzhenze@bytedance.com,
	yangtengteng@bytedance.com
Subject: [PATCH net-next v2] Fix sock_exceed_buf_limit not being triggered in __sk_mem_raise_allocated
Date: Tue, 27 May 2025 11:04:19 +0800
Message-Id: <20250527030419.67693-1-yangtengteng@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tengteng Yang <yangtengteng@bytedance.com>

When a process under memory pressure is not part of any cgroup and
the charged flag is false, trace_sock_exceed_buf_limit was not called
as expected.

This regression was introduced by commit 2def8ff3fdb6 ("sock:
Code cleanup on __sk_mem_raise_allocated()"). The fix changes the
default value of charged to true while preserving existing logic.

Fixes: 2def8ff3fdb6 ("sock: Code cleanup on __sk_mem_raise_allocated()")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Tengteng Yang <yangtengteng@bytedance.com>
---
v1:
- Fix compilation error caused by mismatched parentheses
---
 net/core/sock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 347ce75482f5..9cfed4635d81 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3235,16 +3235,16 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
 	struct proto *prot = sk->sk_prot;
-	bool charged = false;
+	bool charged = true;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
 	if (memcg) {
-		if (!mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge()))
+		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
+		if (!charged)
 			goto suppress_allocation;
-		charged = true;
 	}
 
 	/* Under limit. */
@@ -3329,7 +3329,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (charged)
+	if (memcg && charged)
 		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
-- 
2.20.1


