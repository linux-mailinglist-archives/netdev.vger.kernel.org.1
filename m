Return-Path: <netdev+bounces-247014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40724CF37B4
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3337B30DEDE3
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8DD3358D7;
	Mon,  5 Jan 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="G28qRTlN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A232548A
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615290; cv=none; b=OdXK+IIpFXPN+uIN7B/eFeesY+2/8GEkKb9cjr9G06XOSROi7/OtO2LwFBKg3CDvxMZxLgTkbsr5VN0Pbh3bF+CtmT9N5Y/TRAtz+8DfcdjIW7h3EFgdQrwKCT64Q2WL4Eyjora/86T5GGZYkxo2Zr2XfuIPpk+P8NA7opzH81o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615290; c=relaxed/simple;
	bh=vTSKYdEKalEEC0tYawisXPYcDqtHT/RCHD4qS7kEMbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikGG9043ZrdslEAQhMIvwV3kYvz/6z9d/4q2k/gL2Qlebpgy79AiVWu1ZAQufQ/yWeTP0+zxGWm7xLfXhcqzE0Jxnt5VD5Djx2s/olCqAt5wuabixCtKM7ixUSUpsqkHuiwgp2SpGkgcAsu0mFwIRROqnYQ6p//6vSs6XGesu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=G28qRTlN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b728a43e410so2669264466b.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615287; x=1768220087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=G28qRTlNUUGwzJkWeUSlfEo26gDnr27jngwYsYaDrjlv5YgHKhrCuYfgEjXBj8f8Zg
         Alwi/qpfSGBn0Z0NEUVZfHcpCDmiTribNFFV1MAN6yzFoOzqj856v4a73VSbn/SbZ3kk
         CWbF3aGk2dxop6Snmfoshi0ufpnK7LDuUZF1KEAzDTuGHr2FU2oQtP3VUSvc2tcBmHVm
         pJAxfZuaM6l9v8SWiaeBJnSUuveGkFyRPBfPJv16Fn+E2qV4l22ApG4TrcKCDEGTduNm
         t79OthcHzCIqQpafqPrgMoHfhEeDJ2wr5CJyNYiN3mLxDRRN1sCuz2wYynFtnGjqRCOJ
         a9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615287; x=1768220087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=WUvpfAsECPRXgg/+OQHQQ8F9Ft1dxRYjae7xvLW0eWfhJFX1QebhtXReRqu+kOM2Qx
         q8fQ3MWO5GoHVn3aZdD+yTTXmvJB+jNzmB4DiGuBunpfdV73SxIEbkHfGD9TUtxTc7fM
         1o3S2cuQW7hu+ciKK8oepn9iA8WUg72BP8jjpT8EWTXb6bDno9ptcsRJsSa1q7r1+6fG
         KYGVCWz+SJYfzxyfQcb2CKs1n9BU5uDjf1wGXpxua6o/eSSFDY+IVT6Jv7rEYCf5taFo
         BnxLl/Pqv157Jvy38Q/saG2av6ixUqDslJoc6A+OmBDt6nJc6Rq16wO57EYPFN7bKudZ
         LeTg==
X-Gm-Message-State: AOJu0YyKshigJEl4MSAdgMGhqkC5vUo7K3SL/XQgtCbS1igPkbGcXh7N
	jOwJHszcH2QtUMV5iJDW0CroZeDQdn2rA20yDv2Qj/k7kH4f/zzisgaEI9Qv0cCGLBo=
X-Gm-Gg: AY/fxX7OBMxf25T6wS7cTPTtwON3ycbQwn+2t+x4nRJn6hcTb+LQkIzjXMrRy3/16Gx
	uDF28bZkeHKwAnop8fW7Zbl+b+RvVxx46Nzca6KQwzxkuLjUItSRO6TArVKyLprXK2y1u6TC+kR
	u5KOw1NWxX1omldA+7WrvQrHaEq38XL9sUe4TgjVFrCHhXOE8gyY3ymaDOu4DHTWqrZCB0FHq08
	dYUD8iMt5ogMvVA2RUTmFWV6ygJj+ppQ54XY7MrQIRJRBCSSC0NuXPa34/pjiuefdlE3tGb08SA
	WDlmZeXJAxHObIu/Oe7vQ4yXNNaXUoLed/sq+w0K/jmUFokMpfK6vPHOn5Ad6pJcpWOdh/0lGEj
	dBYLOLXC9FbfDBtBm1Iyk9+njMEgsKgtmrbB4/we4HKlPFON5RdtIxQHP4Gce/M0azdSY5sXq9e
	aMcsPTHBZy429iDB+fmK3MfkoUnI/xTBXeOg/CXPT+p0IOvPvkBLG+OukCByE=
X-Google-Smtp-Source: AGHT+IGmBFITIlNHpUQ9BWeKEfuFmXyuejhK0HAC20IEk3IcEAm4AJYk1tQYG5xWuKlOvuIu4hFrcw==
X-Received: by 2002:a17:907:7fa0:b0:b80:413:16d6 with SMTP id a640c23a62f3a-b803717e275mr5408693966b.44.1767615287057;
        Mon, 05 Jan 2026 04:14:47 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b830b5fe8cfsm4040726866b.59.2026.01.05.04.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:46 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:31 +0100
Subject: [PATCH bpf-next v2 06/16] net/mlx5e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-6-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
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

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 2b05536d564a..20c983c3ce62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -237,8 +237,8 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct mlx5e_rq *rq, struct xdp_b
 	skb_put_data(skb, xdp->data_meta, totallen);
 
 	if (metalen) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	return skb;

-- 
2.43.0


