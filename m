Return-Path: <netdev+bounces-241206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E5BC818D9
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04CBE4E1DC6
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91832315D48;
	Mon, 24 Nov 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gCsag0yx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD4314B69
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001754; cv=none; b=OR1hBqgmnAQ2qiX+UxrbSkGhX39k/NrX9Aj2WIfMMt2w/SqjqCJrM8Enp903k3s0rAjngxsMkTL0BqydwRogRbpNhgSj8ILtT6mdJ4YoqGcl9MSusWjovviB4eneUPvPEPBcldJWKvBjWNvWm7EWiWoZr2NPSbpHr71NAHRiDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001754; c=relaxed/simple;
	bh=ODvPSeLFM8ZsDBxMc9y4w7KsW8ANKhLH35flBrsgLZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/OQJGLnHJV23Nex/0D+q0I1Yb02B7ppEYnix237L6+0uijlQf0KzgYGkdBuzoVX1VE37vF7rO5FaCAEqgGx7o9ZanVPLej2bhZ2gBdkVeG3xMFy7/iUxRenOIZZltpX4FO8iGExY2owrNGE3AYivEqUl0lR5gOaL6IX3fasH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gCsag0yx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so21504a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001751; x=1764606551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N95V21IBNIbUG98EtbcsCf1tsPCMp3NjpmmsQKMdsbo=;
        b=gCsag0yxlY35APICcy8GWcCfRQUUKo5n/AgdL6H6J+T2OiIXma4MIB78t9QorrqXyN
         xtu7usJicH5s8BpFkn1VQ8Abdkt+ElDy4xHduj/fa4m3+8bBOtqpQfujBzYWmJ7XlLpm
         r27NdNQtUnB5FIpZA/xiEM413XPsn2iBk9KZG2GzDmkScHQoDCiyn8viLkbFab+wHP8i
         9LByi56iq+n6D5CFnyRB0rxMRW6TRGUCf2rK3cWzmxu+A/VNeBzuqf8uTdo4kFy/6sAz
         bVIB6b+9deoi9jc1FTq3s76GYsbzLUfcPYUHlCUCL7q7M68mptGXxjJIeqY85qyKeqGd
         b1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001751; x=1764606551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N95V21IBNIbUG98EtbcsCf1tsPCMp3NjpmmsQKMdsbo=;
        b=olWliRGbfJLlKmXY/9xhZ0/VWO40D/+aldCvrNUTJ5ArCQLX6MJqklXesuiUE0AaeU
         UiVdp0hTxHsrC5YnUhr4i6S3Xev9GZDeeCJvVLaBo4Rpwpu1Wd6msMi7UN+mR5QBKrQK
         II99bWKEHzUHpS7GuMb/NPFSFqOQ5C2kbqhJHenCmAeIYGN/ZXXN5B4qXZGHHRa4RFXd
         vVnJoIeFOg5QoXlsWPEQ5/PS7qbJIMGt8CGxd+xqyWihQynM7uBm03pU8QOCq1EFFtaG
         MrzcNpSTDD4htwbZKChuzoXeSA8/HEa8YKTPdpK6bNNHwyHkwP38co5iGb0NaXwf7DDn
         hbxA==
X-Gm-Message-State: AOJu0YxhBcf6d97KPcLFodTWqZPGnhV5pRaVaYlvZeV+82h58TL9DDib
	ISg1EMgS85yFxD+c5qt0FfNd/XA8gun2QjxpQCEMxwHnbNj04LHpUAMkixQ6Yt9CBaYQEdqorVK
	hmQld
X-Gm-Gg: ASbGncuuRUcHwDSJW+wIPT5gk9QztRTinsdZuj5hoHAL2huxgFvTW3X5M/KHz+sPoMz
	EFtRu1Gk+x8XefnJJMb8cdhewrGKedI6cgHqEXgBNIC0awgYHT7m56ai8f4hlum39LpxdMq2E+b
	0L6CD85GniUMnYIGQ4vs/UJ02eDb6Y2QWxkNw+ivgVN7YSc48xU7rN60MIpxZ9Oak1g4EIbsUcv
	GWcYj+ddxxNJ6/NYIt6QZz8udnJ/QO3HiB5QPRVx3dIKw15QXRWlXwTtlwkBnNiZjlZyO4BG4bK
	xpWfbP+SfLd9xcghRZI2rR+uQhZF+mbdX+4ouf88af783Q4aAUNeFYDBGq3hYK5L0+Ldozp6pL6
	VSn/egwA3Wkv8HdOKUtnltumgZUgo4ptA942Zj1MRemhua7SzjhuBVDOouR+KOmh23CtiV2MjHB
	PIV2pDdWVrULOQ9HiMlfLC07Wp4Uhf3fls0JYDOwLgNVZ2TqMBVIlZGcBN
X-Google-Smtp-Source: AGHT+IGQhhyru0gVVmUUEDzO7cCLwI+nfgVhC781M5W/ItgC6K+XRDDi5fUxA9/voPjDkRBDTi5y9w==
X-Received: by 2002:a05:6402:1e95:b0:640:b7f1:1ce0 with SMTP id 4fb4d7f45d1cf-64554677486mr9900740a12.23.1764001751062;
        Mon, 24 Nov 2025 08:29:11 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b5e97sm12524557a12.9.2025.11.24.08.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:37 +0100
Subject: [PATCH RFC bpf-next 01/15] bnxt_en: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-1-8978f5054417@cloudflare.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a625e7c311dd..93e05a0f1905 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1440,8 +1440,8 @@ static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
 		return skb;
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


