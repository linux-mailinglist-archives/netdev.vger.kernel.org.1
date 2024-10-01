Return-Path: <netdev+bounces-130732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21DB98B5AF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583001F22324
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6761BDA8C;
	Tue,  1 Oct 2024 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkCP6Ddu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D61BE257;
	Tue,  1 Oct 2024 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768109; cv=none; b=lSj+zp7efMYLpM24RFoqx/fqXryc0SffHMIXV1Ds0PE0Xyjsr5HRPmXuLPhHTrG0iyMWfcWLqrIC9QYLrAuIzJHht1oipu7ezZAzPiIXaozDOHdWX0hKouIM8IDNCbvNIb+e3fyauEXjXefwBLOEGqmDvGiPn7hp0LoD9Xsnh2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768109; c=relaxed/simple;
	bh=jsm8UzYJHtyzr0fmZQYa5FxmxIg6wgcjb9tBJoBw7hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgEV94e/gXCuOy6Vq2QprfYjKntY7qrxyQjwU9Eu39d3UM98PY+fghrNI2oA9LQDT3tQuXZF2N9Jd7XbaH5i6asN7aVijvBPFtGPyiy+pYxwxV7OKF6pUnwJoHtxOAWZlZ86LkWQUz6DcY7W1fdSIRvRLNzxedDPvt/55vAYKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkCP6Ddu; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20b7259be6fso23189895ad.0;
        Tue, 01 Oct 2024 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768107; x=1728372907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObqaWI+h/lvogCrzNiugI15D5VX0ZGVlhesl4HFROZ0=;
        b=HkCP6DduUYYFo4Bo5W1Brz0wwwRaBV2JMzLHpxs7yPGXFdguNTFjMF/RMbb7K1+/FC
         OeRtpvewaCZdVD00a4nIlPN9/DXbrcfoYHPJWtNSUJRPNihj0HSNsO5EJ/A8sfPaBUsq
         V35bGaqWoPWRJBrW/UyvgrjOf1fzEdhjR+M7Thy5JDk6WR8Y/aNVXCOUjEvYQvOm+3sF
         ImB6JvIvqLHF71OeVRLuBvY7Q4ccQyAUIpOyGCpD2jODW9r8+tWLMeXjLsn6k6l1jltV
         XPuVxXZSRtMy5o00UgK93x7kfx2Q8U1Ecu4vES9YInxb7fSX2wKFIE/AnXkB8fiBDf7E
         bMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768107; x=1728372907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObqaWI+h/lvogCrzNiugI15D5VX0ZGVlhesl4HFROZ0=;
        b=OUWZkXOCRcE7XOjQUtyNfbBsm6VeuLj5GreJ02l61YGFIOu6YXVRuyKHPVEQ2FsYLu
         so5Va8539dIac0fNrU0OCRB5Jk3xZy8T3k0LCqmxTj09KXGaLveBo06gRRYVDNPLzsCD
         S4Cz5D1plhWJRXl5uHWCLXU0/5WBxflSbjSt99PBIv3+W3mLcCGnDoEeqjiixfMoZNow
         9CfgX+VWN2SxNHcTp6ODXiLWVq8CzfhR2AI8DC9q70jH8Js7C2rsGWkTQqwjx+7Vy7ad
         vYZqW78+Mgz+WKON/1PptZ95OXf0GetfB0LNdINkhOOZE8MvEGZPY1nHdgDR0K9pPztm
         4lcA==
X-Forwarded-Encrypted: i=1; AJvYcCUMbkRQUX++G0bsO8CcFEEOOq7afy/NAoI2hIHjpDO8G1ozzM5T0TJw7rYML1l3y9i/dxFcAwdl@vger.kernel.org, AJvYcCWhFCi/BbzR3qtwKg6+dpHRES98pyIYCi+WiXQxjA9OT4bTo9NHIUorCof6M5BRzlqgWcWUXdkAMsGAUrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCldOgMDR0/XcrplOhPJfQUzESy0FPmd4PLeWuXC+jORgJbJ3+
	3bo0bmX9EHmbM29CVDAkC55WvD9PgJRf24FOVrHrdk4NHNjRVIIn
X-Google-Smtp-Source: AGHT+IE3q0Cj/fQSVHCHTYAIOHNlX97jEHV8+fJh4tfhENnwQ6rdgLLchY0qxZC7U8JD0cUZyJy7jw==
X-Received: by 2002:a17:902:c403:b0:20b:4d4c:43e with SMTP id d9443c01a7336-20b4d4c057emr184733655ad.15.1727768106946;
        Tue, 01 Oct 2024 00:35:06 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:35:06 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 05/12] net: vxlan: make vxlan_remcsum() return drop reasons
Date: Tue,  1 Oct 2024 15:32:18 +0800
Message-Id: <20241001073225.807419-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001073225.807419-1-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make vxlan_remcsum() support skb drop reasons by changing the return
value type of it from bool to enum skb_drop_reason.

The only drop reason in vxlan_remcsum() comes from pskb_may_pull_reason(),
so we just return it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- add a empty newline before return, as Alexander advised
- adjust the call of vxlan_remcsum()
---
 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 04c56f952f29..03c82c945b33 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1551,9 +1551,11 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 #endif
 }
 
-static bool vxlan_remcsum(struct vxlanhdr *unparsed,
-			  struct sk_buff *skb, u32 vxflags)
+static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
+					  struct sk_buff *skb,
+					  u32 vxflags)
 {
+	enum skb_drop_reason reason;
 	size_t start, offset;
 
 	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
@@ -1562,15 +1564,17 @@ static bool vxlan_remcsum(struct vxlanhdr *unparsed,
 	start = vxlan_rco_start(unparsed->vx_vni);
 	offset = start + vxlan_rco_offset(unparsed->vx_vni);
 
-	if (!pskb_may_pull(skb, offset + sizeof(u16)))
-		return false;
+	reason = pskb_may_pull_reason(skb, offset + sizeof(u16));
+	if (reason)
+		return reason;
 
 	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
 			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
 out:
 	unparsed->vx_flags &= ~VXLAN_HF_RCO;
 	unparsed->vx_vni &= VXLAN_VNI_MASK;
-	return true;
+
+	return SKB_NOT_DROPPED_YET;
 }
 
 static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
@@ -1723,9 +1727,11 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (vs->flags & VXLAN_F_REMCSUM_RX)
-		if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
+	if (vs->flags & VXLAN_F_REMCSUM_RX) {
+		reason = vxlan_remcsum(&unparsed, skb, vs->flags);
+		if (unlikely(reason))
 			goto drop;
+	}
 
 	if (vxlan_collect_metadata(vs)) {
 		IP_TUNNEL_DECLARE_FLAGS(flags) = { };
-- 
2.39.5


