Return-Path: <netdev+bounces-248745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AC6D0DDDC
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D23F306C556
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647D2C11D5;
	Sat, 10 Jan 2026 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZOphFmmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908BF2C0F72
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079138; cv=none; b=PJoJyLkU2YlAFkM4PNn+aNZlnVE817Ie89Fq0s7yHkboNzX8Giwxv7NM1wTokCmhKTHlQ/pMZqmobalawX66TI47lcZZxaxBTdfBDmhxjcxjlFbWBEnIIXM2xglJ/rO1JwNeFtSYWqKmmEfhH7e96qbzDtKv7O2VhZeJw9JfSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079138; c=relaxed/simple;
	bh=ghj/Rz9kW6fv2FQC40zwayq6ljXNfVu3AXwF5ut0cFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxGdyn7HBEIOU9PwlMMKVOCUREiD1869VWvaURxuLUzLf8jR3HtmVNXH8CCYPaIBO7Wg1avTc7zpCM9zRLrS33KNO2hOGV2M/WvFQJLNS8q7iPwMSYk6y6MeVab0plVmC5DMHRprpPLnxxVETjizP7nMeedNX1QOYTl/sVmH8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZOphFmmZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8427c74ef3so794440166b.2
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079129; x=1768683929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUu+7PHs26UFdRHqzYfDQSourHFpoo8C5CEANCSZKUM=;
        b=ZOphFmmZ/6Rak0F2pGk5/oEvCq07/K3C062GIlJjTPtpEGhPob6wNv+CfRb+Ey4dk+
         GfoakI2aIzZvIk5/HB81oMwH1TVk78YzWlwJHnLwW0K4ikC7M2MRKYPjaJUjpOM4w0F1
         0aMf2imhEGlWrf9aqnEZ3iDOBkGW/y4UU/rXfmrlthSxfezu4dtFq7Y1Z/GeARNRP0HW
         67LtQzNtn0GzEf85Uo23ObpXZryCjNdX+zCLsmIjOaQaY6QLIsqDqwgVv3rXzX6fhpjr
         y7Usgp/A3gpILSpiqvljIhQyh+oypUzX/dEGND70ExCDpqLfHzl/X4xOZavSoGMUfzbb
         GBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079129; x=1768683929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZUu+7PHs26UFdRHqzYfDQSourHFpoo8C5CEANCSZKUM=;
        b=ZjxXYzS38tvLSyeNk16BIPxsFiO6f7iKPbNwzjnK3GT6nwj/NMtuWxMUCtXOPFEWMQ
         9KwR3LX+MpJUDbFdGx6sueFngAIXa8HCxPGfuTEagl80VWuCXQkKz6FTUsi8+D9HvIcZ
         PNa4PhEzuFdiuQCY0G7H4f4pryB4XR9+5EhAyxUKZDffvs6nqdvZB5lcU9BRF3bM1lWp
         /PXgv4zaIGdtrzdaYamNJoE02+WE55avp8E2QpYrjSIGM6H9+l5mp/h5XTYZ9k/Mypv9
         Uh46gUVs5FisDTrXK9UFt6MRZGlAcq+ha3SsL28gE8XlvSsC7Ya/Y/WNAdkqfoaXEzI0
         Dsdw==
X-Gm-Message-State: AOJu0Yz2HgQkv/JOWaCvssTKuO6CDoKp9j9n8Q+XQTng9G9pGuCmelsu
	oJsA0dq1zQSChxxJxjEhmF02KacN5jv0rAr/iE7TaTh36Aq4JddbZS9N4sVWva0nfzM=
X-Gm-Gg: AY/fxX5DGj4yqhBnJx5w6bQO3bPaaul6CsTUiRcjvz0soMbF1WR1/VqmYbiTItUA/Ab
	m2NLFMUmEaxWkhummsyUY7ka8WIVTDYJljfxCmIVY9Aw/S3dOsbzB0/Sc5f0FxV31XoZvuXddwZ
	SXqhK1zcyhWokZS9A2TXU1jvOw1ur02scnYsUWF3dLCwxCj1gO7ktNNsv8JWwYo3ASNz9Ud5/uW
	hz5Gf12w53dTJET2BPIHTuWJKE5r6ebjnf2+BJd8V6NuvK4Kp5FjF7NwedzZOq3cYicaRvizvea
	k8BTVdWB2iYqioDYWs7u0rTqExhWb4fQ09pOoCaxOmtpo9Be/HGvUMeenc/QDGZzNhgEFd1iePB
	K0CvVQiGSCavwsbhNUqVzCtBbnAm4FVd6Eqh6uAvE62jYfpjyCifuM0CExxRXsr/0cE8CodJee5
	WNJto9q23jdxZDJlRCRQVrKbZH0ybycIQXRcQN6VrQSt/vjRMOe9iGYRPf/8Q=
X-Google-Smtp-Source: AGHT+IHZ1MkiW0BAlwdN9FIWmp/bE434W0FOzATRuz84uWEpbwM/KqLENQwYsINhv7tL4dP/p+Cb3A==
X-Received: by 2002:a17:907:3e9e:b0:b87:751:6f21 with SMTP id a640c23a62f3a-b87075187c4mr49897366b.36.1768079129480;
        Sat, 10 Jan 2026 13:05:29 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a235c0fsm1479807766b.9.2026.01.10.13.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:29 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:19 +0100
Subject: [PATCH net-next 05/10] igc: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-5-1047878ed1b0@cloudflare.com>
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

Adjust the driver to pull from skb->data before calling skb_metadata_set.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7aafa60ba0c8..ba758399615b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2024,8 +2024,8 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	       ALIGN(headlen + metasize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	/* update all of the pointers */
@@ -2752,8 +2752,8 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (ctx->rx_ts) {

-- 
2.43.0


