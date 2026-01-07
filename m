Return-Path: <netdev+bounces-247770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4FBCFE510
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F2FA3065B44
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AE934D397;
	Wed,  7 Jan 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XPRELppN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6C34CFDF
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796099; cv=none; b=WgpLTYmCyYzb2RJXULdiFYbfXFyzEg5074NOblbCSymsCzyXO5LmffLJKfw3YohLpBliXsmwUkmCLhAFqIG8YnRYQA3xkgH2//UrPgXf6x92zFAqwPxO8hlb61BeKdq2RZq+xLJhGlS4EKxZqUT7kXzQO+FamxlxgEcmSIcC5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796099; c=relaxed/simple;
	bh=gpO/s3IET6M0QBXoFLb578gA5Up+AO2D0gt4GSXzoj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRRM0VBLUfpG8uOsW34wSjIrA75YeK4kENnMFxgRCqiRKcOPvXUdRBzUT7b1/Jb/JxwtoPU2yOLfKHLsZpr0RfdcQfcLbCMEvJRZ9PArHjI/TbKQBIT6Ps86L94iYAaAfmn4P9dI7kGkyD8uc6elixJU0WoWXjLo0scHmsCqjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XPRELppN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so3515631a12.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796096; x=1768400896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=XPRELppN2RB13QJUodLSThy186s+qopIGQKPzlCGYmwTG868YdNnykU9DepgSV+O7O
         mz7/3CRwPeJi4zv5vdEO9fTo6u29wMWyPesHZatzEZetRxaWMxflAIz7Qxb3g7ZOHWgz
         fg02nYUuqyi0U/cx173HTGUAl6aO3FKBw4tVp6A9IXVTrEem9gbpQtI1PFQCooROPdsw
         H1jGAc/2Sw7fIVKTo0xuCgIgG13ruo1hkE8vk+xRZWDlBC7Nw1r4ygRmFwF3fJktY/vk
         TerI+gzWeShhHXq6v9QBg2mul5Nma2/gjtsz4hfqOMAQKdBI+mw36wuE/KcFeeHmjTdm
         DMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796096; x=1768400896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=dS6S6CjjTAO3twhAxkxtqv+Pc5OqAWiGdpBQWReIdK/6GmVkCLtXEvkbRJZB1KhYw6
         6iSROvtlSwPWwMaudMGvPheOxGLlXGIAfZ3R/ydFfdW4AbrFT4JZV/F4a8ROSpqkbusF
         y86gGsKUm6iOYUUikMPBD/hznRKAY9wcyxWi78yGTLPMPdffpyYwMhQVdLyyppwdrdqe
         CPOXaiIheKR28VyNScFHc2ZKY45PxjcfEas4BYoANBWGpTAQ6orQyolqH/eBkdCwgP7T
         m1oK8YPc+hvyfhiAI3yUbkOLPNm7Jog5pGHunHsRlXxRlCLopBqw11LEXYtOa3MOalT9
         joHA==
X-Gm-Message-State: AOJu0YxNQUneRo08ZWwZS1AOQAN+Rsb5yvgMgphpo2OaFnvy88RO5z6B
	ZkWXaUi11s9RRnpMX2vfTyXoxAPP0+pW147ZeM6cwtxb5DgTfCY7zTqeAVOxWRzX32CXvYrf2Wa
	+YJ4P
X-Gm-Gg: AY/fxX57MeqbgXFKlXG1jdw3RSgrxpxV2ylHuAgMDQPYskZlUnPG0Cf5mvRsIRyCHtv
	ZWpYDi3OdFLdhf+Z7R4IUvUJ76+Rqiw2/dVsb+FwF84w+4jcTgC+hrWOybUJYm0Hl3Sc+Y3pEEs
	3NxUEcPClwWEJKtXbMGUAwZiSLlpAuDwqRrQmui6kpJCnM50kdYRBa7/JrJloFewROqBTHp6NKY
	YtXwmeJtpVioxfwr1Qx1/obIpBY1G8l6kR6zfitnTSEMay6UR2yTYKCs11W4W9ez1e4m62YHIIN
	2DjMuTI4NlRGom73p6J67qydv4GUGcwZ62uDbk46/DSfhSd3ywVyAXLfJYtv8VmONbiJyQbsteL
	/O/QnQIejycr8z0bAlex5dRsb/CgZnk2w+R3r3e02JYVSM7PF6koMDj7cB4Z4du2c1/66pan1s3
	aOp6Uz9zkIVRxQ1DIz3JiqctoAgJMRCEkuQYLDqs/ACoUdZwZQ291hrWn7G6E=
X-Google-Smtp-Source: AGHT+IEB+UD5y8ywWtlBBElkloGbtwlscAKvyqvwbVfNSR747HP+E5J4G59xBFl6Yd5xQX4XuePbZw==
X-Received: by 2002:a17:907:3f14:b0:b79:e99d:913d with SMTP id a640c23a62f3a-b844533623emr262535566b.42.1767796095898;
        Wed, 07 Jan 2026 06:28:15 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b22c3absm4927510a12.0.2026.01.07.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:15 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:05 +0100
Subject: [PATCH bpf-next v3 05/17] ixgbe: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-5-0d461c5e4764@cloudflare.com>
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


