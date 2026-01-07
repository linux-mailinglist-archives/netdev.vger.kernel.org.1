Return-Path: <netdev+bounces-247782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE04CFEF88
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 17:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ED70351AB8D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0E534CFC7;
	Wed,  7 Jan 2026 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DlnQabRy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621F34D3AA
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796117; cv=none; b=L8DH5e7SyJIXn2kJKZPKHBpWgMN9cI31mNtTpfm++Twq3m36mod9QHhPNX7n/IKm2o5W0VdUcIXli/mJUHBKjO/FY4oJA312W5qX+ItEixU4RQxI+pj3902eVlGEHUoILJzRo1J3+9jB1GJjzLSyK0mgkLWUWeboGhA9GwTbo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796117; c=relaxed/simple;
	bh=1tuE34tqdRZ0Cq/ciIXf0IbqXReLHJ00YT+wtQPddnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JgbQtLsPcDiSp/o4RxcbO6nGwbT29bKLR7MbZyahwtYGOreCx3j2xv5PWnwzUn13gEs5I3VvtnsuwYbn1JHQMqNXVVwaBrL+WlbA2mepFD/0i1paQv9ug2WVqT6ye3svmwwaw2jJoFujkj3uix7gTfJBmCXI8hX3RxoQ/ZEkfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DlnQabRy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so1357727a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796099; x=1768400899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvsM1sRJWYDcPZakX1MsPvBpIu+3P2Cxb3oshH7eLdY=;
        b=DlnQabRyj5at5r0zIrQ4HSbSWQnhsf0koS8llLJgK6lIbulKZx/LWIyNaewmPLgCp2
         lRdFT4bL491sghJdfJJqVpSL/FGPo4sLyJ4oBp/7VYyQwGlgWZ9e2SctojwXt1w8LnJI
         PG4BkaAMRK3jC/L4GuzdP1nYFd77NfI2hhn0hKF8XWrLTKymYyOWpQmkOqdYefWLyNLG
         EyH/c7JbXEPqkjUS0MrmEi08DlxIM6EjT882CkDj6Vw18JJCm8ozS8d6sDkfjt0EjzYC
         n+9NgICnhXgF91NVu6sHh6VYWgvKhvouJ/G3I5+3j0grXVocXo+gh+cs5pQV9LxHo1Ss
         F0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796099; x=1768400899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvsM1sRJWYDcPZakX1MsPvBpIu+3P2Cxb3oshH7eLdY=;
        b=VZ4p2kkJIkWOsB1G/9T25soLJ0FI8lstH0zqXTJVYwEGtOgSs82DvM16LIHRsSqXd9
         tLRdymywprKYsOIFHOqZennIyulVzMuGq0PevSXxpPqoGtnuiXjGw4fx4NbOiwkWZB2x
         +rkdPIoFxjKh9F+ChI/zfB536ISoaEKaZxvpm0mNl0vJITHq+/zit+Vax0ts24PVdFFR
         b2wHYpBhnj9J82CfIkJUT0Pq0HvrHMoeQAE+4C9/u2CHnmIhW3nTmAmmiOlAYSOJ0wBl
         7dyoJJ/xtnRytsdi+Y0oTghMuLmpZhnvx+PwkpcptZdElNAXL4jNOcjGjRIgj1aFtNL/
         aEKw==
X-Gm-Message-State: AOJu0Yw4lrRKzmzmbryTRUOjTuuabQxPxD0g9KJGFnhFOChawxBs6hjI
	7otTShPzgzY+ew2Nnc5ZanXYgOQ6ivlCn4aoTKETeUEH7XdxGUeh7Z0XlaqCEnqFqysw8zSBozt
	QtKuk
X-Gm-Gg: AY/fxX6d1nnVil7yWOlCZwOFAAwCJwZNOBp6qc2mTiHSx1uFqF63GNoV046ePzfxkL5
	ysmMhlcMV0WSFX2qiB+rvcISxbvQiK96O2uhSxSZmwTrK2PIsHZqrnWkKMd+bb9ESSKpE1voad3
	PVxZUbcdBtWYr7FYpmSjVaZ4nxXj0ja0MuTicoBukaOJaeEoF1uWZVW6YjgkRagj0+PlbWoOMj3
	XpvC+4mmN/vQDwRXnxYJgslmooiToiS50AZccCCkicD32Q/DRiOgFuZLRbRWCdCLarfPMDEM9pn
	FtJCy97dCSCzGN/e3MHf5oTVekoeUOGoQEq7TweSbLuupH/s4hvsG4YJKmW+bzdTBJkMWPK4zam
	D/bmaAr24d8n3wzsMKV39I4u3695kwWgxJT5f+0voJH8OPeaxSLp9e5ur29dI9MlOrDYiTaCSXd
	fbIW9f98IuO4T0QPfJ3r0B6LgPEFeKPoaISixWaKw2Ptab29LXse+Sx/Jk7Bo=
X-Google-Smtp-Source: AGHT+IEecpe3jiGI8SXIV763BBgyluAV6tRhMtb46iFeU2sSBdZeRQkgSyXlUdzVAnEHk17J/a8jKA==
X-Received: by 2002:a17:907:3c82:b0:b73:9222:6a64 with SMTP id a640c23a62f3a-b8444c5a808mr344054766b.3.1767796099347;
        Wed, 07 Jan 2026 06:28:19 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27bfbfsm520269466b.17.2026.01.07.06.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:18 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:08 +0100
Subject: [PATCH bpf-next v3 08/17] xsk: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-8-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust AF_XDP to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index fee6d080ee85..f35661305660 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -768,8 +768,8 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen > 0) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	skb_record_rx_queue(skb, rxq->queue_index);

-- 
2.43.0


