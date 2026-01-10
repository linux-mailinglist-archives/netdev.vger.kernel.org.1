Return-Path: <netdev+bounces-248744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23083D0DD9A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78B12300D29A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDFE2BDC10;
	Sat, 10 Jan 2026 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZJoTh+0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC42C08BC
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079138; cv=none; b=JEzunEVN593HPlxCkSDdmc9DH5OIlMtdyTrnMyOiC8daiE57JwcYEi3NObOd7XimjYg5T5OdhT1V3QJfDZ013ZXMtoZTPlZmQi9vkZKvx3EHhpL6X8WWYsk3Kg2NtEXsSyd/uuNaw4sdpBJHu4APJzc1rav1x99JI135Cb0ayLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079138; c=relaxed/simple;
	bh=NMdhogUQMVehSS0mf+8AXeIAr4iVGjT6IB0EBPb4Dvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WtDSm/pDRtX7gfxQC7zFadV5wKxehY6SdI1vPvdwfmG6iPY5jUZr4+1Pluor+3xIzDjlG5VVOUeRN6K7PpW1htEbZM2I5IXIkrOmr13+SGW/LybU9/Ecjzz9to1eyR+k3MIL+nibh9TwBhpKnai99cClupXhmyyKFRLyyzr0sCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZJoTh+0V; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so7757816a12.0
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079133; x=1768683933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eg4zjCrLlkyG6qsti60/giOUAtyjjkrdEhVln0uD/Xw=;
        b=ZJoTh+0Vpho36AtFkwblfmKmVZ+sweyfb4+TgFhq3DXGE4tuw+IYLPlVIAmXB1IxwK
         BxfVmtAp8nZtoU15RuKjrINdsU2MNDUlqYJpojLWCnVLkXxyRSJ4hfTkYtqb4nUuvv3C
         iZQI9Oi10I0rLHQPE2mbhch2M1aFAvpnaL+Oi4zd7ZjiYAP4T2wJjRD14K1fZm3jsICu
         wfueF0wRInw3iZLNiNcuaw/IzphdJ6tv0gG4gRuqsTOY0lprCCrOl1J4blMuar8IAuFh
         r41r5ZgNzfk8aBT6pgMoynYouzSAx/pu9Z2tIK1d01yUWmv89/r/Vh21nQ5hWnPwvthE
         RGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079133; x=1768683933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eg4zjCrLlkyG6qsti60/giOUAtyjjkrdEhVln0uD/Xw=;
        b=Zt8SW/Pzlbk48COiV5q05Kp0FWarGAJlb814D92P3QiNFnOw4tprTFqaogvXrLNvHX
         tFnNoz/2BvYyaNn4ZUd07SBCod1vc7AFTv1FHs7qTwK9UjPXYlKuCPEchRfqoa7GrbTe
         PeCGCU/dzOVi7bIRFFlIAUBGuUmGYUUqTfJSJCh+OOMUt5+r/ClBfPZkoaWSahCk9tRj
         vlg4F4CYHOREQWkgD+IA0sYTLCU0H9AbY5WMyf2XIPL86RsXK4gpV8FFqI+hLGDiRfWx
         pmOkP/enbSX834NqYdgzpw0M0fk2s0Hyepa2KeZarsM4tFTrL2yfK071HKQAAGo6LWoU
         yf8w==
X-Gm-Message-State: AOJu0Yw5EOgmcveaT5wmYLayGLSH7aOTkWwgRHxbiU/ElRPDBL9Sox7j
	sniFjiuESsQRFq5E7f6qpCDL3BPjSVoXTngeiqOHAHND9yymoHemGrEaQfplEGNkqGw=
X-Gm-Gg: AY/fxX6qxPPu7wN5Y4Q1laKOoVqcz4JroUOBKS4YXko3/seXrr0fIWtzJ6EeYMETaq8
	IJYDMcwvHKzbkgFQF1Z035KVPFbgC8XultzNQX4SGxAIpvnwEkpr1VhzlmHviUi0NBMxZT7Ombs
	F1l0j92mKDACQcYyaeEB3I0NCdJBxA8XxI8WkTHbzu4S7mfRes6dDFvG4BbQFGBENJuYjkMmthc
	TVtwx7+edHHYMIsoHtEWHlbLlaz2bQ+tp/L2g5GG/YtM9iAdjFHMistVMnEmXe4raJuKq3Y/A9m
	PpFDGHcYQcCaPmXp0zBZVYjXhqROLba4t2m63PEXVnOjFIrS5ppLarGiEvEFp/56Ifq5rLAx/3H
	xlqGFVY0uUc2lGro2eQjxp9EZ3E0bzSYi6dWjfOVo4iSO1sU889gzVV5mOvF3LJY53slqdA/mta
	X6wz37vhnudPFeR2B0LjSPKA9VwuA8f9Z3oAK9HuPnRnwXqU5Kl4pgVzPnEgc=
X-Google-Smtp-Source: AGHT+IHr5jjLIg7Fc8OxmV32vOhb8biD7VVZIPMdffGLc0JSFUNEJ8LGc6xEjJiUaoLQN5K1DNcPEQ==
X-Received: by 2002:a17:907:1b02:b0:b76:f57f:a2c3 with SMTP id a640c23a62f3a-b84451ef354mr1384718666b.12.1768079133287;
        Sat, 10 Jan 2026 13:05:33 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f912a2ddsm209666266b.71.2026.01.10.13.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:32 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:22 +0100
Subject: [PATCH net-next 08/10] veth: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-8-1047878ed1b0@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.

Unlike other drivers, veth calls skb_metadata_set after eth_type_trans,
which pulls the Ethernet header and moves skb->data. This violates the
new contract with skb_metadata.

Adjust the driver to pull the MAC header after calling skb_metadata_set.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/veth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 14e6f2a2fb77..1d1dbfa2e5ef 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -874,11 +874,11 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	else
 		skb->data_len = 0;
 
-	skb->protocol = eth_type_trans(skb, rq->dev);
-
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
+
+	skb->protocol = eth_type_trans(skb, rq->dev);
 out:
 	return skb;
 drop:

-- 
2.43.0


