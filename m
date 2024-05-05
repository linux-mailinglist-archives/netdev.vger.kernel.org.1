Return-Path: <netdev+bounces-93538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650C78BC327
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 20:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDC91F21217
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFC46BB30;
	Sun,  5 May 2024 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="keVq7skp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4942D60A
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714935366; cv=none; b=cawMb99cCHXcKey1P63AcP2Je+2LWBVZMzyZhIy6b9+TDdanYFee1niHY0BHkTBgEuD70VyEIck/5Q7p8Mpsf+H2oZusq5rTRdmt9W0bKdUrMx2+E7WygL/Loc7VeZYL3VWoKniNXPkge7Lcx4XjIaZc1lpCe8WDSaVx/cnO+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714935366; c=relaxed/simple;
	bh=G/EZZEHmWaKOH0u2C3Q7UQjnllgpzj/YyEiNSVBGDRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=acl4XijGDmEoNZbQ+94o9VQeA6c10ew8D/DQPH65sRnPCHI6/nQ739lyQF3y/4vU7jOa26+exQQsHv8oOfPfwmbmT4afZtwDm+lGk3lirFNLKK5NDL/otxF4pOl847dcqGl/fODrvul2+NzTGsiXi+me8KMmey22L5T+oesJWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=keVq7skp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b432d0252cso364553a91.2
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1714935363; x=1715540163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NCwX6PAcpsnDL2AqCpHHQ9pMMdOoL1VMXjLgSqdmAI=;
        b=keVq7skp6zRkehaFQgzbtb6OQzquVWzbtdECcr1XvXnQrbhJfrmLmwJago7DPF6zBy
         e6vhAuarqZl5XZa5Z4Nx+vOLZhvlRW5hthrMx2MIj82QtZQX/NK7pBRLThfELmEw2h4/
         j5emP4cfdXJS5gayvoJ4afyO27IBZDYsDPPuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714935363; x=1715540163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NCwX6PAcpsnDL2AqCpHHQ9pMMdOoL1VMXjLgSqdmAI=;
        b=fMcyEDhVMiuufApEz71KHgbxlDjiqErmQKgv1JIncUW/mXI/U9vApo5Wft48dOYtxO
         EhwTrwijOCIZr9NGpLkCItIZm9NRH0zcURixrHdxRKMvs298Ki+nnH8Xk6/XboBEJb1I
         LfRe3SGgCTyYSbBxXrps2TSjgbjTgEZfvY6ZWr4Bd3WhN67DYYZMw5E3X+P1kJgv60MM
         ZMON3HkZM5iS0NhptXsRMr4vf229tqj96lzMMdFI5zUWfVX+Ljb0AK45xc65ekfOy5SG
         2wdfb8CikYM/J4sB7Xcl6ngsOgRKncmnzP/C0s8qtZdekASJdUwsh6B9ufF28mpc0D2Q
         26MQ==
X-Gm-Message-State: AOJu0Yy7TLLuXYsh1cYjIuswDxIjNax0muBaI37TJKOUcleWsCUbANMC
	tC9O57HoGvkpNGK+C/6rtr9aCb3bzrAtByHUwZMFgRHC4Z7xtOBO6Ati2jm38TA=
X-Google-Smtp-Source: AGHT+IH7d40u0aF28NtQPen+4CXK6mbWq6tPhH9rvSoi0/UgNgZLTJIiiH2I2CsxuuelwVkiSKpMzw==
X-Received: by 2002:a05:6a20:841e:b0:1a7:91b0:9ba3 with SMTP id c30-20020a056a20841e00b001a791b09ba3mr11154251pzd.4.1714935361920;
        Sun, 05 May 2024 11:56:01 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.206.39])
        by smtp.gmail.com with ESMTPSA id n8-20020a635c48000000b005e83b64021fsm6554449pgm.25.2024.05.05.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 11:56:01 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Vincent Duvert <vincent.ldev@duvert.net>,
	Doug Brown <doug@schmorgal.com>
Subject: [PATCH net] appletalk: Improve handling of broadcast packets
Date: Sun,  5 May 2024 11:54:57 -0700
Message-Id: <20240505185456.214677-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Duvert <vincent.ldev@duvert.net>

When a broadcast AppleTalk packet is received, prefer queuing it on the
socket whose address matches the address of the interface that received
the packet (and is listening on the correct port). Userspace
applications that handle such packets will usually send a response on
the same socket that received the packet; this fix allows the response
to be sent on the correct interface.

If a socket matching the interface's address is not found, an arbitrary
socket listening on the correct port will be used, if any. This matches
the implementation's previous behavior.

Fixes atalkd's responses to network information requests when multiple
network interfaces are configured to use AppleTalk.

Link: https://lore.kernel.org/netdev/20200722113752.1218-2-vincent.ldev@duvert.net/
Link: https://gist.github.com/VinDuv/4db433b6dce39d51a5b7847ee749b2a4
Signed-off-by: Vincent Duvert <vincent.ldev@duvert.net>
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 net/appletalk/ddp.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 198f5ba2feae..b068651984fe 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -88,6 +88,7 @@ static inline void atalk_remove_socket(struct sock *sk)
 static struct sock *atalk_search_socket(struct sockaddr_at *to,
 					struct atalk_iface *atif)
 {
+	struct sock *def_socket = NULL;
 	struct sock *s;
 
 	read_lock_bh(&atalk_sockets_lock);
@@ -98,8 +99,20 @@ static struct sock *atalk_search_socket(struct sockaddr_at *to,
 			continue;
 
 		if (to->sat_addr.s_net == ATADDR_ANYNET &&
-		    to->sat_addr.s_node == ATADDR_BCAST)
-			goto found;
+		    to->sat_addr.s_node == ATADDR_BCAST) {
+			if (atif->address.s_node == at->src_node &&
+			    atif->address.s_net == at->src_net) {
+				/* This socket's address matches the address of the interface
+				 * that received the packet -- use it
+				 */
+				goto found;
+			}
+
+			/* Continue searching for a socket matching the interface address,
+			 * but use this socket by default if no other one is found
+			 */
+			def_socket = s;
+		}
 
 		if (to->sat_addr.s_net == at->src_net &&
 		    (to->sat_addr.s_node == at->src_node ||
@@ -116,7 +129,7 @@ static struct sock *atalk_search_socket(struct sockaddr_at *to,
 			goto found;
 		}
 	}
-	s = NULL;
+	s = def_socket;
 found:
 	read_unlock_bh(&atalk_sockets_lock);
 	return s;
-- 
2.34.1


