Return-Path: <netdev+bounces-241211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 488CBC818FD
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0ED73A9494
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3B318131;
	Mon, 24 Nov 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e5sKABNf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6492316919
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001759; cv=none; b=i7Bvg06DED/r1qtTjDu2vgHVd+CZjAyxkzGuRGh0T4b53ej200U4xapS6TKL3rZaEoRk+DWdiY3LKGNwjNdUaYKvUtNAB7ynAlrsm84y4K33RyHvBMs0dUp46HnKpePl3C0TFw1U+3xY8L2uRODUm4lRmMHkvwDBfMZb4J7SZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001759; c=relaxed/simple;
	bh=gpO/s3IET6M0QBXoFLb578gA5Up+AO2D0gt4GSXzoj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzRGTIve+jixguOh1jmhrJQQhbucjd5Yuv2UndiSb7jYoSRJPDUxD+MiOiO4upG6Tx5irqHN8fNGTgFKAXb9ydyerHR2hst4iQQR3pj4nMcWrVSDRJTkF8TJS/hYsrgw7xFgYuTQ0Oa366Ei0jdP5YMNalxdNdD+B+WTKf5Fwyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e5sKABNf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b725ead5800so569241866b.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001756; x=1764606556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=e5sKABNf0S88pNRSyeygq5+P4mB0YUgz19NrtYGTKs2VPIT1LIqDbdJVXhkJhrRs6t
         yGlho8RliqEu9tUII5Jxuqw6Fr3ixWtnowN1qb5ilsiSaYpJ21FJfZfIG38U8YW/NP6E
         xjGOmjnGLlFQu8UqloLRp4HexgrNVifzvuJAGVeSoOQT9urrKTqKwmLV/jzpKcEdZBhs
         h7WrFSu9SZp573KiYl3ilZDq4S5QdBadncil7FkOpAVedkL15Sbx1bAUbjV9PeuIUt/p
         fYHHQV5WkpAtOABNYaanrhybJ9UIa854zDcQ7ZzX07Cv/X7nFVf0wuppIOrjMxLUUGhk
         Qbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001756; x=1764606556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=cuD3+Qiv8iNH5P9lf1fg/LSlzRaPfLTDCLQv8jwCF4Mm9AdcVdp4yfiyjxt9ytSeKC
         BtTCNSKsl/BeqrdEQvOC6zLF/EPHLGoHAcm5KBcLpgtg5w348FF58gNTodRy/Fsmi0Vr
         IFm/FnjzOVDJWyK56uzqhlLaDJmapgsdPpZuiJpMqFU7pNcFuyURHDsww9U53kv+dspK
         Vt5a/yzwHdhZDHRBWg4MBZHuHESRXBp/LEhWTiMT7B+Ef21HziVfFfK1ugoGHLdYCA7Q
         rOwU/rRNgYybmSLiSlXmfHAVEK1Ibq17adjHvzPIuZyPIzWNStZ0Ndz3UdtYAHRTQbOI
         0iFw==
X-Gm-Message-State: AOJu0YxKiQvdKtEkDSHNztdERJfX46sA9xbF8qVswEGZfXUEU+Qs/bIG
	w3C48Hn5Hmu/Rf4FfQxnUf57trcMaFSHP8tKDJ8ntVVoFGdjCqLtJPbjJmmW8F03Ryg=
X-Gm-Gg: ASbGncu+fK9sXkFqZ+/3j4DBGk1/XrtKl2G+YhEgg3S70RhYWOAQ2WtOUTv8RczPlHs
	N0mXHzRAcjeWqoNem91tQVs+9aEK07CCHBwCEJ0vG63qdcjrcuWH8ruZuar4AocQ+oOokz0uvH3
	oU4LW4Bhq8f4u+ngBOqHCFk2jP7QOzdhojAaaey3Yqd/O3sZFn30CyIL8DNuPx9aNHqMCWAlgxV
	Tvb3HQSFQmiiMnD5E5F5ATBxeHCWeyD/Rp2OivIydCRDbMvkAqlYBMhj0BAED6WCjaHs5mvfm6i
	k9ioPGSEUyU/vgoAOGUVZzB7ABN2zUwL3XWMTLGdVd2jB0QTd1hM2ro1PPiq95zqlYz88GIl3qZ
	QANQLpNhreh7hV2RnYnJ94sfUndHecTx8seJasmQYdyLYarDAWL70qEfd1j/IzBmA903XWvUF6v
	hEOlsFkjLSvpQMMxqinU/MS89AutN2CUHt1wy/zOnxTczYDVJ4JwTrGw0X
X-Google-Smtp-Source: AGHT+IEC/J2e50ch8ea6zamwDiGIqGrUIxtoQkbAYFNboIFPtK0B3MuUJXUm67l0//8J7UshJY8edw==
X-Received: by 2002:a17:906:f0d2:b0:b76:74b6:dbf6 with SMTP id a640c23a62f3a-b7674b6dd6fmr948776566b.38.1764001755975;
        Mon, 24 Nov 2025 08:29:15 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76550512d2sm1334713866b.67.2025.11.24.08.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:15 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:41 +0100
Subject: [PATCH RFC bpf-next 05/15] ixgbe: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-5-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

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


