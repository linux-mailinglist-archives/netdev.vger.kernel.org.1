Return-Path: <netdev+bounces-248742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC79FD0DDD3
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0EC3062B11
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15A72BEC3F;
	Sat, 10 Jan 2026 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DqcxWv3r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEAF28A3FA
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079134; cv=none; b=dA1XMvoT5jTcMW2aVEnCZwc8PUzEv0WORkFAgHY5gtCaH0reMahZDLMkPvDJxRzeKL/Zrvbm1UeEyheIZINjneL+xWEenCle0dUO4M6GYb9b7z+e2tp6lRblYSWtOBkCPQYhhpV8WSHUOTl1wl/z3aPjWqQ4gwYwYeop8p3q+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079134; c=relaxed/simple;
	bh=79nK24opN6uM1iQ+K6OE/uKIwjvXCL9v0B8DauUBPRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGirc5u6KcqyzGp0tHeDmWk1rc1L1HKCuvqUHL/eC8qUkiUYA1Md3Dz4ojBBBrZirrF9qbgu876f86SQPEbNCfBXlTqGO3gFHxa/QZ0f/FkS9ALh3D1pWmXGj3H/sz8Sdoi3JY8RdXClyLW8MoTbadO2w0RXe5ty+19P5Yc6iG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DqcxWv3r; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso4207771a12.0
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079127; x=1768683927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOm2Dco79W8CJqhRdT3ov73dnM6p4xH+R1QoW90QGkc=;
        b=DqcxWv3rBrfzUju2khjIjf6PA6ujXHBoZi5nkX6TsMhA9jehbmiMbwVY5R9OjGhy7b
         Q7Fa6pnQz/2HLNEPZSmDIXczYH2Z3k8H/AXAiHIzpgZyIkck4IMds3HzNsDFN/A7uWqc
         P3mg5T6Fg0NZi5zm4d0K161UcZgR6rFjMC8sCr3br35ZsEup2huL3kGU9QcFUyLUITF+
         q00wkIq7QqLdeUmS+5sLuniUWvb4FvUtExp/IaDzm+cXqEkWf4kFsgNsU3fdFArGfEeh
         NsOZscgVGIyeKxtfgoZMwUlwjaWcEILuBn7bel6vQ8JnA1N1LEMk7RYv2pbmuQqBNA4V
         SQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079127; x=1768683927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qOm2Dco79W8CJqhRdT3ov73dnM6p4xH+R1QoW90QGkc=;
        b=PGSrWQFKp8CMJ8TeF8fC1N/c8RG1AoWXs/KknHnKYunsOFGwHlhDvqsrJN6U1eY8y2
         X352xCpwwFhhxew7mHsuA7YQXeW6swmXgTzX/9BN3IpKAJNaie/zzogN0cngJhb0eoa1
         2nBbNWGcNDdX84iZlj+3j0FU26I0h1d2TCcADoFjCyVSESS3vTyR/uqx5GwQBq9YZpau
         pQ7q9DlDLMtHGZIB/OtKyOEIzlfLtyrIMr92oPyZdpyycx7vNK86Zli59zwAAirFfavE
         HrVLOnduCN8yGp3gDOmrFC0XzS2QOGNnvCaz6YpAkUmip1Q8Y5LLjWdSBxSF5xbyuPU3
         vlGA==
X-Gm-Message-State: AOJu0YzrY21CKeLnum123z3Gu6EAJGaFg8DOtMEmZX0dEFReYjHa39hh
	S22cSUOcJ/g3iaEG6CziafOQ1kVXsrGfnnBvxk+ObSnHpxCiluaAufkdDeHdYf51h5o=
X-Gm-Gg: AY/fxX7OYgkPE5jcOTGy7Wfxnl2rWcV98DVbtm9NwqcWETvnjP8NeeYM0cRCdAOmqSB
	KSG66CJHrqCFk7+3tsErOgIbgJH/Xm7Q+uX313NDsIEEmx8yP49i/rLHAOH4GDpiejBaZHFl8B6
	jLMwyvUwyvmrHJkaGxOGyv5Wvuq3tmHvqVjZKNk0jWBnN54ucPDL2ii3hj9UUbe1izhEatoO38n
	4jbl5lCTL7ohsLCijs24UW2vzYTUGfgkesGWa9lvQL6EJGIVGNW/VoBJBsQsxVoMibm1JuUReUo
	T2t7ZU3OVPUHtxNvvDIlJDfAOipTIiIMxmAwGHoy6s4pKwdIbJH6covBnKq+nOb4t4yI8HBKO+B
	yDFW7TxWEQBEdj5AWe4hO7EOCr19kwyY59dRgpnbvszv673RCfbX8da49Z/t+8bk105UmEHvpon
	KH64Oe8naHnsi0tGnLjvjNgbYtuQ0BWfMkBI0wJdkIBfSxhOKsLVHFjH5fV54=
X-Google-Smtp-Source: AGHT+IEEoQmWnDDRGqBo6ow/YqTGmki9h0Hp/wugoaNy4VsuTpMCu3HOef9yqHlTJ1K/zJx1Hlhozw==
X-Received: by 2002:aa7:c845:0:b0:64a:86db:526a with SMTP id 4fb4d7f45d1cf-6507bc3d721mr13850443a12.4.1768079126946;
        Sat, 10 Jan 2026 13:05:26 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4c15sm13415763a12.4.2026.01.10.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:26 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:17 +0100
Subject: [PATCH net-next 03/10] i40e: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-3-1047878ed1b0@cloudflare.com>
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
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..11eff5bd840b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -310,8 +310,8 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (likely(!xdp_buff_has_frags(xdp)))

-- 
2.43.0


