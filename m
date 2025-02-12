Return-Path: <netdev+bounces-165358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE4A31BBF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA4A1889A2E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E11CAA7F;
	Wed, 12 Feb 2025 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6Q1NPcK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39DD192B74
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326312; cv=none; b=PLJlVwVj04O6l7Aj3N4/Qq3Km1BKf6tBCLnFaaUVospJcbVjZNZY3YBSIlq8ehIyxIQR91Um8J42Kd1uCbgsdBy7dBor/WXIApj5b3Y802PpIlB+I1QcgfSIYpneHjRjCuWGmaIl0aLF20xXLLCe7YUYZ9C4s4pkefMPlyYa7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326312; c=relaxed/simple;
	bh=CBxGCPW4+yvar/wF401UTO44GTJBd0WBDE+y6QfJYf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHFKdhoZk1QUaVWWxOfKIexhpFlQae0Wf53pvE32tkhbkJoLUKR+mm0zqO+JfBFsJMXLRMiVfzXs3aGlrE8yo3fcHEYQhlhx8lkWcis30xgbA8VxvaHyP8YD/HSbcC6VB+9KUt+Mivk8EUSxpG7hgpL5kHTuAqYYkM1TxnwoLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6Q1NPcK; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8e8445219so50380906d6.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739326310; x=1739931110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve+mcTbttDFJtOFy5NeJamyMZhH67HVi6U3zxdpocD8=;
        b=V6Q1NPcKeYgzjw8kFh+SL5GbMtK+XbtZNJyU/6nsgPZRA/Fij/DErWmfccWv6ls5aD
         NAvMR+LRnHVx6QI0ct00SiwgTaZ00a220pkc5ulmRF1ZNKfK5kxQZclb5fgVfhK50l4T
         +aLDdHJUME/3+nlXh+qTwDzDL3sF/syq9cmlVRgM4/R4mD/1zuYrij1b/1RFWLDJn3xj
         iFs5BqH/XbcRx9Upr3KhIGCsNCjNpL3cI5UM9JKdo8cXSOj7EHM4NF6tMbDDyr+XIdYa
         zinJH76xmEp1kVKMDDzq0/zUcnaq5q57R7N4O32jWb1/bhfogmuYhc2C+z1/CkH7TKtr
         Rj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739326310; x=1739931110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve+mcTbttDFJtOFy5NeJamyMZhH67HVi6U3zxdpocD8=;
        b=N3EuA/GxfRSRyiFJpqNhW5nrazeuI/leOf/D77WLFfCLVilLMiZkoxDBTwHC9aeGZ+
         IArfQtDzx4bKzZq+2kc30up5JNGorpRHSx7u7t0mBT9+p5j+XzD50Ltl3pGZP9aO8mI/
         eAgGIU0MbgAuaPb8Epc8P4D/UqWJedd6+O33InBHkI5SlL5knMdFlWPz7vPZ+3XIrvHH
         XB26tcrUCd+6Sl6U6kZx55WScQbMphb1cxt56MDqZP+GTIvtc8lfEwuHztQLBENXr0Qy
         vFXsmsA29wkiHxpOfDCoX+I7rQtxVP7OJTTYeLDdJ+4l91JFWRItCSIo/AiO3bgHG229
         gdcw==
X-Gm-Message-State: AOJu0Ywzy01Nd6iKd3cvtSPdsmD906IERWAUOHf3VLG4bMc15O42HTtP
	vNEXsfVU27Cco34eC3640petDzJhxe6mFKHYPCAtdH7RYXiMSeRy4HksYw==
X-Gm-Gg: ASbGncsyCMNcvYSJm9ueK3F1jVknMu9RMN0Mk9WpcqUZcTp36IA4W3Y5vb23X4YeIag
	TiJ9O46fJPJbWIfToROcGFOJfsFHCHaHYYPSmuHCjkBI/jxh/ywYyS47h+pjEViKyudnS3KbVzV
	DHLgIAfPBt0Id+fXCs5MI0KkmfFZy8Bbos2X2zMHPPSXAWLLOpX+65l1f9yZkbY6AtJa4o7J1Rx
	Z8q6LSJzqfu9/XbYGsFLr9RSahEajE/6bWttrHDjkuVRvk5E5OYlxQ0rVcG0/XIFLO8/SfMQ/Kc
	hey9eCrMHt5jl/oVt7iEF66JDm08EO8DoQE28+fSKfwrc69eohSi5F5ork+Fuyt1xEK2tMw4s4d
	OhmhP5tVtSA==
X-Google-Smtp-Source: AGHT+IFsQPxjxZkxCrkvMrOzMyvFbqbnz1TkQx21sl9acx/LhK0PxWg/Hr9OHYksNiy6syOfkHKlng==
X-Received: by 2002:a05:6214:d46:b0:6dd:d3b:de27 with SMTP id 6a1803df08f44-6e46ed828c9mr27651946d6.18.1739326309987;
        Tue, 11 Feb 2025 18:11:49 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44a9a524esm58256126d6.5.2025.02.11.18.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:11:49 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 5/7] icmp: reflect tos through ip cookie rather than updating inet_sk
Date: Tue, 11 Feb 2025 21:09:51 -0500
Message-ID: <20250212021142.1497449-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Do not modify socket fields if it can be avoided.

The current code predates the introduction of ip cookies in commit
aa6615814533 ("ipv4: processing ancillary IP_TOS or IP_TTL"). Now that
cookies exist and support tos, update that field directly.

v1->v2:
  - remove no longer used local variable inet

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/icmp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 094084b61bff..c42030fb4ff6 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -405,7 +405,6 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	bool apply_ratelimit = false;
 	struct flowi4 fl4;
 	struct sock *sk;
-	struct inet_sock *inet;
 	__be32 daddr, saddr;
 	u32 mark = IP4_REPLY_MARK(net, skb->mark);
 	int type = icmp_param->data.icmph.type;
@@ -424,12 +423,11 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	sk = icmp_xmit_lock(net);
 	if (!sk)
 		goto out_bh_enable;
-	inet = inet_sk(sk);
 
 	icmp_param->data.icmph.checksum = 0;
 
 	ipcm_init(&ipc);
-	inet->tos = ip_hdr(skb)->tos;
+	ipc.tos = ip_hdr(skb)->tos;
 	ipc.sockc.mark = mark;
 	daddr = ipc.addr = ip_hdr(skb)->saddr;
 	saddr = fib_compute_spec_dst(skb);
@@ -735,8 +733,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	icmp_param.data.icmph.checksum	 = 0;
 	icmp_param.skb	  = skb_in;
 	icmp_param.offset = skb_network_offset(skb_in);
-	inet_sk(sk)->tos = tos;
 	ipcm_init(&ipc);
+	ipc.tos = tos;
 	ipc.addr = iph->saddr;
 	ipc.opt = &icmp_param.replyopts.opt;
 	ipc.sockc.mark = mark;
-- 
2.48.1.502.g6dc24dfdaf-goog


