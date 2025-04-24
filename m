Return-Path: <netdev+bounces-185341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130EA99CF8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFFB5A102E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036F278F2D;
	Thu, 24 Apr 2025 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xQgtT0G3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2B8C1F
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454497; cv=none; b=HIt7QVImpjO83SeYyailHIkEKnZur2u78GkXc2SwmBKdlRBnzPey/NxBge78HewTw9ntYYwfPxls8fPUx56jKumfhol8qOPPcGLNmU7L/LicIFiSWsMcH4BfxNIRPK6hSu0VZAsgk1w/8er4CGmOMKTfKRZFJI9MrWYbDQN3fGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454497; c=relaxed/simple;
	bh=peXZjv91qcnXAES8N8mnCKfga6OZjhML/WpesH4NfKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9lQgji3CYd8zh/4Mw6dZAa1C//bNi1mcbNi9xEiT4RiNEFHtgpfSifN6Lu1TjGBh8UJ3S7vVfxkSilbLmb1SUinnF7VXlxi/5847mkj3wHguXyE9M+6KN1yMghudLFDNKYspZSZAUcqKIo69mY7n4ucqxhuiiLeHD77xOxH+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xQgtT0G3; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af52a624283so424364a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745454494; x=1746059294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6JaAma8wr++LnPs79mPGowXaCOiBb9Nd8NFNngwV7o=;
        b=xQgtT0G3NgMoiY22v5qnfKORQEPyZFI0xQvj1+Yb0/4GrQeC8E6hWf9J6Uy7ItYp+B
         RIf3ooMxiJd5DxsBQjexhd+nNJBCbYD0olRn4PRQKPizkzTe68G8YgTVIrxEVa2TuPZK
         wANm0tfGrxEFZGCi/9SoVDZcaN+pGJA4GBs2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745454494; x=1746059294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6JaAma8wr++LnPs79mPGowXaCOiBb9Nd8NFNngwV7o=;
        b=cR0xbYKHuHYUgSbRzhl17J1fzmjH7k/a0Ca06xaScfr6q74UnGhu2n2+p6zmsfy79G
         5lnqUlPwmC9d6xVKrHM7hLyHseN4llGxJj08PgPTjr6Vc8Fs00h66WKlR6HAXYzYuCnb
         eG8I6aHSgdY4+kNX4EN6Td7fdOe4ksX+0HIvU4qoSqyZc94gElxiMZLNpodCvtVtCjkx
         pXaHhyMO7Xk5Wcf3L/bWqBa6aXG1NTLchfRobbZFQl7CkdnMsSUrKNsum+iwJ5ddBBnj
         KzhvyZQ/lwqYca0FsUmLjWlyhPHHjkQu0mqvau3TL5SNu5E+XzbkWJVynSj6LwGxwIUb
         ocKw==
X-Gm-Message-State: AOJu0YxgPYJsE6Y0x68SOktIDnKm9BvQy7lbxouMdkAKZKASw6yxctnv
	sM2umRbLEFhcfuRLsLp6/xcrUfcRabaH/g1uz2AYdIms3Hy18EcGFDTDVRQPydCrwZf/B/4TbgE
	8mBI4UAOQUHzDOUVuPs9wv6o6Y+1gaqZJjBFigFTLX6tEHUYxoaZoZUSxfAXzh2uo5aMdGutLKs
	eLQpxbY+uhQKPV9yuA36SV7hg+Y3IqkRU48w0=
X-Gm-Gg: ASbGncvwH75O6cU8eD0HOYk36ZsDuJG1X6jDzRNJI57MgpADTycQodFYzqSnkWq/WTM
	W95sQH7ahp9kEM+8ZBtAs9O3GrcHkDsEJa9snv+wtnxThPtvpiHa3Vk7mkqDfz48rdVbOykbsec
	kGWMAuoDnU3vUI7MHTFTK9T6yVasY1Tqb17TpjmycSq7ufR9WiN6T4nS+5Ylxa6Z+9+K93sT6Qr
	RUWyn8D8RN44tMfDQ3Ew4Gkr3zFnRF3Tzo/MONFsI6u1Irw5v16ph7F1xWocrZ0VeUYwIIjGBP6
	tk8ZyeY/VAj4Kshuvm7Ebs3hwWP/mVmrf772v0Yn1oXu3smt
X-Google-Smtp-Source: AGHT+IFKCZWDrLDyEBVkIjzd2enJ/SHv5mfApzf31oQfNyqhNgFukwVTxCJOUx6z4xW3g53RKeEzNQ==
X-Received: by 2002:a17:90a:d603:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-309ee37cae3mr551102a91.8.1745454494054;
        Wed, 23 Apr 2025 17:28:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ee7c4054sm83013a91.23.2025.04.23.17.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:28:13 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	shaw.leon@gmail.com,
	pabeni@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 1/3] netdevsim: Mark NAPI ID on skb in nsim_rcv
Date: Thu, 24 Apr 2025 00:27:31 +0000
Message-ID: <20250424002746.16891-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424002746.16891-1-jdamato@fastly.com>
References: <20250424002746.16891-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, nsim_rcv was not marking the NAPI ID on the skb, leading to
applications seeing a napi ID of 0 when using SO_INCOMING_NAPI_ID.

To add to the userland confusion, netlink appears to correctly report
the NAPI IDs for netdevsim queues but the resulting file descriptor from
a call to accept() was reporting a NAPI ID of 0.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/netdevsim/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 0e0321a7ddd7..2aa999345fe1 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,6 +29,7 @@
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
+#include <net/busy_poll.h>
 
 #include "netdevsim.h"
 
@@ -357,6 +358,7 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
 			break;
 
 		skb = skb_dequeue(&rq->skb_queue);
+		skb_mark_napi_id(skb, &rq->napi);
 		netif_receive_skb(skb);
 	}
 
-- 
2.43.0


