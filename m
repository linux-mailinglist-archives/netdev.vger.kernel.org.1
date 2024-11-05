Return-Path: <netdev+bounces-142078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B327A9BD5C2
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 20:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F0A1C20F31
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151CC1E7C35;
	Tue,  5 Nov 2024 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuNX9/R7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1001E7C27;
	Tue,  5 Nov 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834409; cv=none; b=nFiQQ4cx8V6bHMZ6hWoU79eosiGMvYSMhgB7XaC/aRfc43WLXNo4AYrdLwpFC6bJ2cuxTf5LICn6p1wFcxh6bD6PqQwxbOEjb2vfTQudY003bKt5gXjoZxoAY+5Qn914Jzm4IN+FoXezUp0vpJmlG7EBfESsjP9sYt4fkHfyGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834409; c=relaxed/simple;
	bh=xiscwbTQJTQiTE8ft0L8rsFtWNA96DS5JnH3vPLVUmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzwcmXiDOSCuWhJNNFzGjlcjTK/WHYTH3xr2Ck2QFiqw7HQrfYEZCrxtAG9Hnd5HIPDPioYtpLyWAqb2IQVD8oSpyvdRkgtI5ASY5bHwEd0lfJbXHycLZEgCr87EBTfSah4haMvTCvh+pxwSInvhgCyRaHXW+OFj1kCIL7p+ZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuNX9/R7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so111015a91.0;
        Tue, 05 Nov 2024 11:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730834407; x=1731439207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGhRcnGegcAs6+AZNhnWAc40T167/ZzHeEXpxdgzWUU=;
        b=MuNX9/R7DNrwttHygWNG2X6rcTckDa4oM8eNFogCVyfeOBQY0WTzT2BjlFSCvE33NE
         1zdaIHTzLT7JHixhbQsb2k2nkkr7/evNmgX8hzDPLFnPwY84yTplQ1ldsznpMlGxxIwn
         rCbT7hududiL9lD+bC4rwojcnYZMoeDO56rqPXaILm40uBTQIe2PxdTq+ljyrswS7k0t
         mjFME5NXUGqBCmOJI/hMxA36gSrne+gEG5+pX+VYrHQ8mL7P41qT5vIAnX2Hdbj8TxXS
         WKiKrOFEGJyNFjjJOMGLJeiL4IxlMU4BTY5iCDPp/Sij49nnaY6C/J23xT7w1Dzc9z51
         2FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730834407; x=1731439207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGhRcnGegcAs6+AZNhnWAc40T167/ZzHeEXpxdgzWUU=;
        b=ZCK+PIxaJmjxm3wAp+WBUEnkAQObLUYcQKbJDuxUKX0RX3IWWKVcfRBL4ODln2forc
         bDWTDbYOimT6xaWxN8sGkM75wvrsEWDM/uQs36OLihK/jyXUIfzTqZfLQLIdVPN29CsU
         iZs5AtYouz0rrSOcmOdsPrXIaL7riMRFB5IeqeZsi7o15gFLkncxOFssF9fKYGC9aQ6R
         AV1DguXxvIO680RJeSz75UcjgHG02dRoWHnYziWNZZCE65SUQvmm0iEhY41jIE0fSJXN
         C5hBEM8l5QcOByPjGtYZt5F/2/LTAlDJ70Bd70ImMm6/XCCs6lpwZgvikElz+kWLs4tX
         aZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCX7dzs+FxfKdRGIn+6EiDPAsudjVzb6i7W2vj7ROV62Gw/FLnZO72R+HI6QFbbt82Ya6IgyM7so@vger.kernel.org, AJvYcCXXY2O99JgxEkk1prl3oCEBWpnwffA41vhlXZuLUrwlZQOUaUj7RDiBfvi5RPVoDo+IfoACmLr/kAD6lEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrhotovgZASzv69eSo7zA6vz7N+QWE+lltpHYwt5iN/t1P3knU
	J/S8AUTTA2/DNwiNgHndZUOjserhnT8/k5LAkF3rLl0Hcl1RI+rY
X-Google-Smtp-Source: AGHT+IHMm9BWGsU3oqzfK2SGuGvci9VCqK/1siYq9TbZPUEggojsNz/coX+SiCFOL98KNG00rhDuRg==
X-Received: by 2002:a17:90b:278c:b0:2e3:bc3e:feef with SMTP id 98e67ed59e1d1-2e93e0589dcmr29825899a91.3.1730834406994;
        Tue, 05 Nov 2024 11:20:06 -0800 (PST)
Received: from TW-MATTJAN1.eu.trendnet.org (61-216-130-235.hinet-ip.hinet.net. [61.216.130.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc0087asm12382645a91.47.2024.11.05.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 11:20:06 -0800 (PST)
From: Matt Jan <zoo868e@gmail.com>
To: syzbot+14c04e62ca58315571d1@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	dhowells@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marc.dionne@auristor.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	skhan@linuxfoundation.org,
	Matt Jan <zoo868e@gmail.com>
Subject: [PATCH] rxrpc: Initialize sockaddr_rxrpc directly
Date: Wed,  6 Nov 2024 03:19:59 +0800
Message-Id: <20241105191959.2871-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <671acd8e.050a0220.381c35.0004.GAE@google.com>
References: <671acd8e.050a0220.381c35.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rxrpc_lookup_peer_local_rcu(), removed the redundant memset call
that zeros out the sockaddr_rxrpc structure before setting its fields.
Instead, initialize the sockaddr_rxrpc structure directly in
rxrpc_input_error().

This change simplifies the code and ensures that the sockaddr_rxrpc
structure is properly zero-initialized.

Reported-by: syzbot+14c04e62ca58315571d1@syzkaller.appspotmail.com
Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
 net/rxrpc/peer_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 552ba84a255c..c86b432201fd 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -33,7 +33,6 @@ static struct rxrpc_peer *rxrpc_lookup_peer_local_rcu(struct rxrpc_local *local,
 
 	_enter("");
 
-	memset(srx, 0, sizeof(*srx));
 	srx->transport_type = local->srx.transport_type;
 	srx->transport_len = local->srx.transport_len;
 	srx->transport.family = local->srx.transport.family;
@@ -134,7 +133,7 @@ static void rxrpc_adjust_mtu(struct rxrpc_peer *peer, unsigned int mtu)
 void rxrpc_input_error(struct rxrpc_local *local, struct sk_buff *skb)
 {
 	struct sock_exterr_skb *serr = SKB_EXT_ERR(skb);
-	struct sockaddr_rxrpc srx;
+	struct sockaddr_rxrpc srx = {};
 	struct rxrpc_peer *peer = NULL;
 
 	_enter("L=%x", local->debug_id);
-- 
2.25.1


