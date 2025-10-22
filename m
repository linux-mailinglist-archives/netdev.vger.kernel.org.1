Return-Path: <netdev+bounces-231823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03738BFDCFB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BCF3A4E83
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59668346E4B;
	Wed, 22 Oct 2025 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+4aXj7p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3066347FFF
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157429; cv=none; b=Cb5KCwebXVP3l6z82TpGhtD2x2fLPseJt+UBQNtqcHK6eJRbMZe6UG/n/xm8jCwd0O+YmhQ8g192l+qk9drBCWy9GbMe869zfBYpTCJ43PxyI3xJOeK1YqzjQ7bdMRhGD93AJjXYHbxMb22Ai6OKDjnXbSGa/CIB8QbBlR+tnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157429; c=relaxed/simple;
	bh=ngGs7qC7XiTRdW1WxKVCgH0EVqNbevtWNDS0KzGl0eU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RrTNw3fPxDF/t+6DSbODGJBgkY+zLZKurI2YFfohNmeIoupJgPn7q5MBHHpdfsf2jnNycQaXSkkxKaoXn+Pv9NbHVuRNk59CFbpTw3uiz+ogirBKka3B8etG+OsMB90ykaXxWTTD2UQHBVtmlVMjvWoyVGUlprPwK3gy40PEK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+4aXj7p; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-783c3400b5dso4687929b3a.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761157427; x=1761762227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJqa9G7A4Q2Gw0yM+02iQJ2e6q59hAMYcfkAChUeSCI=;
        b=b+4aXj7pnNfCoBT/bZbdmLqYrx2SZ4Nx2Vcl0OUyw/1xzLzjDa1fdbprsRvoUTjcq/
         L3yNMPKu6RCHHgArYDiU/+i/C/xiC+Z/FWvte2ARG1S8gBojGBMy5pXubxxd8UMtKjro
         Au2Xqt3niDoCKVM7pzUeSYC9MxDrmRVKNM16E3wVAx63okKLR21MltQwxymnCRjDSSKJ
         047nsybotxgCM1WIVJHoRxcP4y+5u7ug1eTaEKME4OFA/ZjdujFLlXH/36awF3xzDpwE
         TclL4Du99oUSNXavl+xe0XBdESS3nUO6C7RT30BzJ7Kj0RbBfEouX6QT0L5NZ8u7M3a8
         oMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761157427; x=1761762227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJqa9G7A4Q2Gw0yM+02iQJ2e6q59hAMYcfkAChUeSCI=;
        b=kmCmmdab6wVyk2qCsk+LegTwS9rLMpXHvpqUy73/sAMCI/DvNZpxxCdxO9MiqAiia9
         FV2b9fxqBZBHNQdnFDgXttXs6quTQ79/8b+SwJsA3YzarPZ2fPWiecY6Lv0b7F0v9PdP
         D9iy3iEDc2YbKxhiCcVz04lZX0Jd+BYWIzZc4yVyjwzdq60BPZqDoSfz7u1P+PoIFWMa
         sJ9NoCMlhonksxf3IXdKehNCWACB7HScCgklkYv/yrXeQuRvrTk8MUSmyDz9Woh4EXOu
         vlJBnythzNZiMufjyLXzF6AY1C6f206I0OEHlgc0hVFP3W4S9AA6AnfkhX3slZBw9+/z
         SfXA==
X-Gm-Message-State: AOJu0YzRfNuDDhmkIhIftS9YhbJD0SZUVOkfu3Wj8t6pG18I84igMlJD
	+rVJUljruSV13aJSKi1C3vEIzKEopX3++h6G1/tcjpL/yx2kqfavjg4Owvqf3I+na4L9rbh1CSG
	vGnIBBIcmqfSo8rU/QQa7o5aTao4VkMikGn6d3qhDxHpRari/2vxxrUgsSUxZtqys1VNg5GBQhV
	izAj0wEdKd7BpM04dSceaxj9FS9H35EIvCLChj6wbtSADk4GU=
X-Google-Smtp-Source: AGHT+IH4li9Ga33HZ+gGWLZT5UKQJRJQZGVfWGKFmZ90B+Jjpg/o9JndMkJPrBL5cRHUgn6p0beT3rXehkBDvA==
X-Received: from pfx7.prod.google.com ([2002:a05:6a00:a447:b0:77f:1f29:5399])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:9283:0:b0:781:275a:29e9 with SMTP id d2e1a72fcca58-7a220b107afmr19180407b3a.16.1761157426936;
 Wed, 22 Oct 2025 11:23:46 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:22:25 -0700
In-Reply-To: <20251022182301.1005777-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022182301.1005777-4-joshwash@google.com>
Subject: [PATCH net-next 3/3] gve: Default to max_rx_buffer_size for DQO if
 device supported
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Ankit Garg <nktgrg@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Change the driver's default behavior to prefer the largest available RX
buffer length supported by the device for DQO format, rather than always
using the hardcoded 2K default.

Previously, the driver would initialize with
`GVE_DEFAULT_RX_BUFFER_SIZE` (2K), even if the device advertised support
for a larger length (e.g., 4K).

Performance observations:
- With LRO disabled, we observed >10% improvement in RX single stream
throughput when MTU >=2048.
- With LRO enabled, we observed >10% improvement in RX single stream
throughput when MTU >=1460.
- No regressions were observed.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 4f33d094a2ef..b72cc0fa2ba2 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -987,6 +987,10 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 		dev_info(&priv->pdev->dev,
 			 "BUFFER SIZES device option enabled with max_rx_buffer_size of %u, header_buf_size of %u.\n",
 			 priv->max_rx_buffer_size, priv->header_buf_size);
+		if (gve_is_dqo(priv) &&
+		    priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
+			priv->rx_cfg.packet_buffer_size =
+				priv->max_rx_buffer_size;
 	}
 
 	/* Read and store ring size ranges given by device */
-- 
2.51.1.814.gb8fa24458f-goog


