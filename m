Return-Path: <netdev+bounces-241215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E3C81912
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC2CC4E75AC
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D385D31960F;
	Mon, 24 Nov 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OfNjbizE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE23191B7
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001764; cv=none; b=FG9Gcl+R1eKbfj1lrQImv1Mzb+MXz8Jw+KJBHJZNY1BJC/6lvPV/uOxhIGXneRL6RgCXSeauZBPkjuFdHhuyHHZYmTA1N2f50vfDPchQ/dmbsaA8X/Z5+myBHBs3zHUYJoEdDAnL1necNtdR0PjLHSwfWmWCcmcEI03hKmQ2xHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001764; c=relaxed/simple;
	bh=dBBJNBM9lwB3nIzNG7eIWw8ZLh10JiMWH7jW9NWEH5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DUzv6naA3QynFyiT3cU6Wihduz/pTurS9fuEEzWsMN0qsT626LTcSFOKegK/p0SlC75prH6BgPEuiASX08wuX2OQptEe4oLDvHBDd4eUrFYpIKM8hH+dMSQ2PfBOse4KjpQQI9sJEAsC4Hmx859jVLwmqwC/CuX1OUPTyvGRkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OfNjbizE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so7596687a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001760; x=1764606560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMmoF1WyxWUVhcv2mNwvbfP/vLAgX/en8ow3WzUaKdc=;
        b=OfNjbizEKJHvkE7XD8bo5XaENtMp6vWAp0W0hCUliDaHvidanJjGbfdqjZ4EcfSWCZ
         dzicXKQE/8SOy82Osn448zJORRDK/nXEEQ05JMhsFKgqVvbmi8Hn6DUCBblU9jR3i9WV
         K29xHNob1u6uqKX/Q3a41wuSzX2oUc7oTyGFs+losNgmO0/+kjB73tuwS2SZ9cPKQ0Lo
         3BRuBJkNtMdXQlia/BvCdDmEYTDj633hn+8hzIMc/UOGi8/yUurClL3cYoKeWXkk7PCl
         JSERZEKsjCgDKdIkAgKQu764CSWmQOYU/PObtRlYriNvD3caf+yTaV8IB/KHt0BOOR9l
         jg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001760; x=1764606560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uMmoF1WyxWUVhcv2mNwvbfP/vLAgX/en8ow3WzUaKdc=;
        b=B11J/enkNtw9TEViQz9FqrFvngmAjaShHTORq2OAkIlfTvIXZpWYxsuoC1yOZxucjv
         pEieM1hP7vfwGERxDJzfPKLOvcuZM5cgPz+3hR8BOSYngpF+muA/9GAN2bI37ohsJlcq
         oyOhRgoAn0AqeEphrdnsZc9hOH4WZ3rZyw22jdE50KnXKaAkUEhmaiTpfwEgCu/WxhW7
         ysIOWP3FwjmFCTAHwkGgqR15bCMoLCOdsAp68/ni38xfRyunocK+FScc2lK1m4FC7uaZ
         thPA4Nwa+4LU4WGBWqPU7CA7pA1i8P7qERnvLafUmbZhmplAZIa3Eiyim0nGEBXHuV/q
         +ezw==
X-Gm-Message-State: AOJu0Yx1drER9MCi6v6d7SPYN8jnYF/s8MIKbWJOYmGALAfr22yiTKpZ
	Rj94jmnmSpFbERAAKa/VMZuzjEZH5ZS+LoBStQMh9kI/A7qMPxyCnBns9LWqDR/ipZlhW2FmQVX
	EQ+XP
X-Gm-Gg: ASbGncsVgcr0TUK+ZF8ygGxCCbaVDPTesO5qTkCvEksxPL6g227Su+VkCbwoGvWFW0/
	QBt8hkScmgtVH48LW9lUgVIAEIbvkfI1A3cw2/MsOkt2AGKdQslSwlfrfjx3MhHWnk0zCPCxCj6
	knFcC28RieTJxRSrnw89ux761EcsAxtQRgI47lLZyChfub4Rh3Y+S/xyyWEzo9uq2MDb2QKXFe9
	V0jcfQj/GuOpQ3LrcVURVX+BPtCyM6I4Xz88WWkTkrXr6r1Dn11nFkRqPyqb2G2IH+G0/f5WeKe
	/V7W+b4ZaA6VSo1uG7wL2hnR+u7QbcImLyDwA5gyegdAx+c/BotEbCoXgDZIz9oVQGsHk2Iu/4i
	hpSEZ4111A+0+evSwN0VjBdhCylXUPXDCwKn2eU7VWQF165pKE+9wv0f102gJTtLV2ppe5c6NVm
	vEv7SDF5w5auRNgh6n1Aqlq5ml5ZYNe7/eLUzkMWiPmWmb3BxzCNhBwxrU
X-Google-Smtp-Source: AGHT+IEGHT2H6DgkF2j3zNLW0uQCTluvlrloCK+PiFdA+fvxy/R60b5jESaEnu6z4FC5JiLsxz5B4Q==
X-Received: by 2002:a17:907:96a6:b0:b50:a389:7aa4 with SMTP id a640c23a62f3a-b7671547e0fmr1220083266b.13.1764001759920;
        Mon, 24 Nov 2025 08:29:19 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ff3962sm1344035566b.50.2025.11.24.08.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:19 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:44 +0100
Subject: [PATCH RFC bpf-next 08/15] xsk: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-8-8978f5054417@cloudflare.com>
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

Adjust AF_XDP to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9100e160113a..e86ac1d6ad6d 100644
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


