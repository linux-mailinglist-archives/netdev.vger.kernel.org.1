Return-Path: <netdev+bounces-247772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 630F4CFE586
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6902730303B0
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ADE34D4D7;
	Wed,  7 Jan 2026 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EnwMBMMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4F34D39B
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796102; cv=none; b=NRJTAlrVn8NY73CieGe0Ex2CbksiB+R5IdfPgWNMYdwsYfgIaKDWdxFPN+dHPj3UG3W8i2+DVL1N9dWRmU8LmklPE67G8CkfVF3+TEGfX/JxnQgmeFJ3z3berWfcj0poeE8xA/3g1YDYGG8SdJ1sMnJkEOyGVw9uk/AkxgfSoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796102; c=relaxed/simple;
	bh=NaajF5tLSJC0MVk186WINR7q37KABHcy2kYvLo9rMVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QzlF4Yk+uK6/haJiY5ZF8u3eDBNBcDr7hcRASH/sbE4HU0TV6wJBtrVOjLVO6FFg/mD1XXJPb+LPEhLOHzoEBhclLbXt0ht2EFd4EMbm8arXol6fSDGY39IwcTHoRYTB0koaAf4FSONJXLI6w+64diPd+TrWsjfxTabIn42XjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EnwMBMMG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7cee045187so164216966b.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796098; x=1768400898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyt1pEvTxrkLTTNOpoJZXjB9GHiCuwIadpGr/Kcla8c=;
        b=EnwMBMMGL8haINLqX/qQHtgAmmdQbuKw4Dl+gcSYHKXOxdiQSqqNfXS2+A1G/rbFfH
         yAxG8ETxr01nzfuR8oGjiICoDxTei8gjry/zhqYoG13LDxW5IuVWC10uBHW3qmUqSDqt
         T88L7lPGkiMjFxD70CclE9NaNK38gJZAUhlfjNMwlDaR7MyjkU74j0O6BvS3zN+A5Wio
         MjfEdjDKr+Nq77NjS+sLnQkA36pyDsl6UpZEoTiNuwt+l9ZU60OQWX3SYPC7WiGfq5KV
         LI8hcsG04NOLAUKGFKyJy6A2hpWNHwqgIubN7OkiRn6ALv7AqrydttKcwJsOdXeQJPOJ
         4wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796098; x=1768400898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nyt1pEvTxrkLTTNOpoJZXjB9GHiCuwIadpGr/Kcla8c=;
        b=GWedr/Xjh0830cIHhbJdnjJy1YuM+IIZnotZdcB6OQJXesr1R76Sm4sIHJU5DVYMHC
         aYw80hi32GVx57lvdfs6i03dtylVloRz4sEDdRm7u/JWx+QbOZdrxazGG3gTKj24N1Am
         oKnsNpg5M42NHsAfwroakgjXnbQvkdu4PX3Tek+4dJwrseKynoFYL8NdynaEZC0Ezl1I
         t7oJEQw5FQmL7jOkCmfvwuh7B2Em6bIyOSNLPdRcxLqUq+KoLYKpIC/wt2uz0f2MUs8L
         ThX0FHvVKT3sV9WCzAjvVX8PXDREx9t/S6kQj3ZyxQvSYaksFm++Sd3QOEdYujHHfg/p
         zjuw==
X-Gm-Message-State: AOJu0Yzq/N2uq2+z5IpGmyCFDKvGD6D38a5MfmC63ZU8B6k3TuhCSrz2
	UqCS8N6n771wRaRHZZ6pSx8ITZ9BoEXgZe4bC9fLHrTWbOLVCcizH6gHsV0ci1C6tDw=
X-Gm-Gg: AY/fxX5j1JEkbEt6w6YvRSBwxaA/exvM/Ljk8KqWeUze9VBy4T1Ash/awm7uUodUmGw
	os+/V6hhytGgDqgvBxHsuHa2uIrLt9frk7JOjNKsVhMI/SaEtanY+wpFwijNlPvQlnEd7SfZ0xi
	CjJB8+s3emyIb3wTINe4zpJPVwOb5yVQPuWJnr1Iz3TXHKkdlknvLVGGI3Xrd4m9k1p2/Cxj4Je
	OrSC+22+efONsK1SQCVzyndp0wpqX4dYfIXZfAhBC5nrSvvkLRBLV5omg31qRAlwK7/exaNWLHx
	cIXDGuI5mNczpUYCD0K98fRtB9GG/LluUboFvPQl0GeaYDdG2W9XsihE1D2yEwL0mgFgesOR6tu
	qSWLuvzAr/ySp5kKhN5/GU7TLnsUcm61Q657Us1rjRgLMDI4DKlXVb9VLp9R1O24dhgM0dusEc1
	uXAPWsjKeYspSRjq3bkr4spTJ62+/hOhcquz5FvHAEN6esV683Ifm8BhUaxgc=
X-Google-Smtp-Source: AGHT+IEExcKIthsPJDITR8jYbXCRYoJRS+tApF4PYQnCgfrHNXaZtgzMTVY3hb1FfS0AHvszM+Xs1A==
X-Received: by 2002:a17:907:802b:b0:b7a:1bc5:14c9 with SMTP id a640c23a62f3a-b8429b9c13dmr489449566b.32.1767796098132;
        Wed, 07 Jan 2026 06:28:18 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be64efasm4631150a12.21.2026.01.07.06.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:17 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:07 +0100
Subject: [PATCH bpf-next v3 07/17] veth: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-7-0d461c5e4764@cloudflare.com>
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
points right past the metadata area.

Unlike other drivers, veth calls skb_metadata_set() after eth_type_trans(),
which pulls the Ethernet header and moves skb->data. This violates the
future calling convention.

Adjust the driver to pull the MAC header after calling skb_metadata_set().

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


