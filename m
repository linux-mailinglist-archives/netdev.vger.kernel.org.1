Return-Path: <netdev+bounces-248741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 394A2D0DD95
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84BBB300E8ED
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B6B2C11D5;
	Sat, 10 Jan 2026 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="K/XIFzhk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC4829A322
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079133; cv=none; b=CzAQ7JrVudB2/ewYLWvHnU8t8hi96eCosd8S3sHeKiUwr0n98LIhpDB+2aimLWBDfWjqMdeyXMCP4oJ6dpLzXvT78js8uqHDNhu8YsGBbjWAEIfwxs0wLNxSNXCYkZUu6w391sOGqazse5Kh8ctfmM5MEsmZRZL9+/YAVz3wuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079133; c=relaxed/simple;
	bh=Ghap+Uyv9EG02fN/gnmF6GE+EbcYHA//0AOkobhpB5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NvXztfEMVkIuSVRemt0KOU5YG6SrJ830FNYlqRVxXajTFwicL/yKQ+bPcfYc6gAi3LXxxt7fbZAZ3dKu7+nXZJWB+pLZP7M/ivFAxOcBXF/nn+plvGiy7+9Jo9u+YOAFeK2hQw1t15neekKxppzhIc2t2wlA+bTkUUnNibJKNe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=K/XIFzhk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b86f212c3b0so100032666b.0
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079131; x=1768683931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrS/fiDVSpNqpnGbLktJGFsAvmbG4oFl4B9ZbG+ylX8=;
        b=K/XIFzhkDz3I/91Oj3cNjwR2MQqSipg0686W5vrGHcxAW1loty2U5Fw4fYjTcqfphD
         Luk4XykAPhgdn1IBOvxFNBg70wm9PBfMeRWupa84Q5oqARe/r6YwU8GsxcCuJNDUKY1E
         etTK/gsWG8Hjhj5HJpYEN1rv6JRSZGa4rYakWeIWM2XeAHCWWwsZr0Y6hqQFR7d2OGct
         P8C3km21syv48Fi3m/uRj1EYxspLWnL6GvwphoK5n9qR9LJetCyXM54XBAw3vt4cajV0
         WWKaNytR5KcFzBNPpk4XlLZN6o3AMGG4IyhabX301hdZlWsFJieIPUhB3b2X+s/dAYJ2
         n9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079131; x=1768683931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZrS/fiDVSpNqpnGbLktJGFsAvmbG4oFl4B9ZbG+ylX8=;
        b=wphlPxhTbkXwvhsqcRyzVIodj4bOtSa1iiQF8skzAZnLSZt4vXb5weI3XutXuqpvdZ
         r4KtcyR26Mt/zgzhfCljK9DLY1x3L1rJTCGRTbyTOJIGCJkPBzMtygFma349TRbxiceP
         T03i8DUuVhb7dJQWQNSZYGzSpLd/Yk3WU4qP+UhuYBL0Z8de4I+RdaQue2RMIMIxwQaL
         tkWEy3HU6ubIH6ZCOdb4y/nrbj1s27HK2FarPqlaoTbMF9cG8queajyaTUWY2lY89epy
         +FXMGh2BRefe+n8TADz/lVnQwAaB8DFhFPtweRCezO7pyzHH3a1xMkcOMFrs2n0Ydo40
         9cdg==
X-Gm-Message-State: AOJu0YwDn64thsFETMn4F2J3cBNl8NqxFvJDNhd7rVSjU7knJwbfCA64
	dh2Y3z8j7n8TECFtTjx6Ccl3ExLW0fWNH5oV0e2iQMeIkoFFNMQePh+QDyg/p0lPdb8=
X-Gm-Gg: AY/fxX5EHoNtGSUOwkAl/l2WuNoOK81wXte1imGwHd2ebDlTR/q9Ku9khU+ryQvTrSP
	+YlpoPT3B3eA3xIP2b6oi40ZQyJiwxbH7KSDLFMdq7UjIZaK32LhRfrIldIQsU9w36DHl5/s9CJ
	FrKSdiUARXI2lIJN4ECG4zTiIFgKtKcrJuevZ5GCxVU0vEuj3PGUNd0vn6EE+dOQwfU40CgJpfF
	JiW+LxVAqSnV84Q7NoCPL7P7gZahQkiT1e3wl4u49+3gzVgaXI5QIxTQR3fvN1LspbTV80VnOum
	7GIsy8Kzgr6aUVZz/6K/876/gq1k6kF0H3abK1KQ/mmb/5WqPxc6drd1sHXlN0jxrYHYsmRWmc7
	oy86FQ15VFDrFgaun+ows1p/QO4tDCnYbzqwEDe7gsFuobA6iGqASemx0L684e30uibwPQCueaH
	6bRI9+QRd9SVR28UKtzUkYsTlBklx/0IZeHQhj7zVxCGQYLyiWia5VW/RfHIg=
X-Google-Smtp-Source: AGHT+IEXzU4wEefDLk0fDfjXgkYuzrme5GrsRIy+MsiA/VGuWxBA6XjNbLVOftqt0DT0rpqevpx7vw==
X-Received: by 2002:a17:907:a08:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b8444f488f0mr1563600766b.16.1768079130751;
        Sat, 10 Jan 2026 13:05:30 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d3113sm1479232866b.43.2026.01.10.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:30 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:20 +0100
Subject: [PATCH net-next 06/10] ixgbe: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-6-1047878ed1b0@cloudflare.com>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 7b941505a9d0..69104f432f8d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -228,8 +228,8 @@ static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


