Return-Path: <netdev+bounces-227171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E54DBA97D8
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FA11705E0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63D9309DAF;
	Mon, 29 Sep 2025 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S5iEM8VL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6D309EF3
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154968; cv=none; b=AMkutlwm9i9Lnh2vxivSXV0a8kyJa1202cg30/XM7prdQbpPayC5B0MQFISGIQG4XIBc3jQpTLc4bcDmsKjY4/ik/P8yyvUecepuIT1xf5LdSRObLrLfWigVR1JWt6Rqp4d6VE68JqGFYFqoXiCa0ABkRubV1bNGt60bAOmyxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154968; c=relaxed/simple;
	bh=1I+ZsuBg0UdnoIKEEzTbkQeFlzkeHVAGD2Ztup8Ifyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=misZpN24n1ndd8evR4naJZ7BZYEt07Ow+/ioRbEk/k072Jw41bt/tF8+1gqnDyyEWxkJrg2QaTXXWE49slLINsUiAJk+1+MD9X1/0XdIVZVYNVAbcR9crwYs2BkFLNA1IoEB5npfltqG61Oh8IW/oprb4I2l+Crshi3+1o/OhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S5iEM8VL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso1348031a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154965; x=1759759765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=S5iEM8VLrSdeUyB6aRRmzNG7aAEZ4r4uTdldCsR3FP6XwGA60vgw/GzPeVWTR5INQ/
         eWNs63/Ghk7S7JF/E8TRSwP1O6f+oWr1rPo1+8vovaLqDvR9PrStxg0WVOFtIt8EkosL
         oU9UOJpRa4qEDSS6RL/JHl7LSqbBVogzvepC1guLNQYitdakGOyK8jEerlIQEp9LUrDf
         L7HOQQIVRbOaasrvxB7T7s8aI/IT8rVaTebr0fHj+MZxsc5sHFOY13hXrw/PqR0vU7Ly
         uIdCcd2oztwdmyZVX7VJo9MHWYHjiv+r5yUQq0osbaDxlUjswYImnINyT7CBvWoaci1T
         WzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154965; x=1759759765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=hmgJIV+7cVDOWETcEEqJiYKadP5W6ZeIdzfUkR9qz/pBxo2fvK/WG3KD9yhPRlrtXH
         taMvB9gqwp2eOUR6k+aw2XSDEi+lfE6UQ36X34xVQZ4WLd2e43V7CF1pmQFl8WnUVy+W
         7tANii2URwVZx13hxnblMdKlxEJ39yapu1iC8Wl3OyqayPuMJQqCcd0qPPzc/YSWvhQh
         Vs4pRfoBOgMvNn/BICxQIxhX4PSALbCR/AM+7xZgT3tW3Av6AxD7c7VopLOusdCQRnPB
         oxEuRZm/kOvrCiH7HHDhu8hjEfhfZfnSnMPGJYh/M56Lf3huBYR7+779v0bq8kSdcmw/
         fUZQ==
X-Gm-Message-State: AOJu0YyFePk7aMj/Pkbd/7QULMVgRMHY0R1X6UJn3WD7nsPRUq0rmub/
	wUjN/RFPOXXCyMaAVFK0z7FVw75E0FDos9iKDhBczLLRY7PGv2M03KKEZa0TnrcRx2M3Te+8qM2
	kQnuE
X-Gm-Gg: ASbGncuSHguFoKLxin4VBJuDrD7XU5rcKL0uZirRcKGf/XTbTbKoI+U6+mj2zkTlEu8
	O6aeDJUUos1f/fOs6Eao+XDRlVNEM2nfLOk0zM5XhKLKqHSO+zAaQzKhWyMQ3V0uMMyvwtv1lp0
	8E0cvKzOsFtN7Sd+4ck2cxOaPSVgsgTfwqfwNTET+VVA/wGeAZWjDpbq8+2rd3azjYZDEiw411c
	HpPieJPfkiXG5vE6cJRmWZLE4BGFZmfuoab09T8BIBxpkfKZk9epbpAB9M4eYSsqDETFrXK1gwf
	McS5vRIicxItUGSYBXnnZfmoO5hc+Se1A5KjzBQpEtttQzB/Ps6H/fBwuqhxl2jBDUPw9qiJFB3
	tjjgOLQd4ne0s6xrH5JyqOm/Td9vMeiczKWcj+P586FdyTCABqznZJWXJbZ5s2LPcyTvJnv30af
	W8nsDpXw==
X-Google-Smtp-Source: AGHT+IHfYTKK7D2GCRM7CjqrVNQEML8OsJ5npVFLVU8/k6C4bbxCNtkV/3y4ZkdiBcYJiEQN9HqjkQ==
X-Received: by 2002:a05:6402:d0b:b0:62f:4828:c7d5 with SMTP id 4fb4d7f45d1cf-6365af2b69amr638587a12.16.1759154964842;
        Mon, 29 Sep 2025 07:09:24 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a36521c2sm7847111a12.20.2025.09.29.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:09 +0200
Subject: [PATCH RFC bpf-next 4/9] bpf: Make bpf_skb_vlan_pop helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-4-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Use the metadata-aware helper to move packet bytes after skb_pull(),
ensuring metadata remains valid after calling the BPF helper.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index afa5cc61a0fa..4ecc2509b0d4 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -738,9 +738,9 @@ static inline void vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 
 	*vlan_tci = ntohs(vhdr->h_vlan_TCI);
 
-	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
 	vlan_set_encap_proto(skb, vhdr);
 	__skb_pull(skb, VLAN_HLEN);
+	skb_postpull_data_move(skb, VLAN_HLEN, 2 * ETH_ALEN);
 }
 
 /**

-- 
2.43.0


