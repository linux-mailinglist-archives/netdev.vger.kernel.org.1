Return-Path: <netdev+bounces-132474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B234A991CD3
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545421F22FAD
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7492116FF4E;
	Sun,  6 Oct 2024 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIOr4SU6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7C16F8E9;
	Sun,  6 Oct 2024 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197840; cv=none; b=WhPg3dsV2A1oFAd1w1ONEyPwNvE7/a2GhcJd9riky4+Mzq8Nv36T9EDPh6jau4KBfAqG/YV0bGN933nZRl1a6kF/ldikTRzOtz4vy2xBAfw+2jpLSZQ94dsSqRLzxThbWIPITk7lAELZVATq6futYY/cqYj/6KZrL+Jm+Z2qR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197840; c=relaxed/simple;
	bh=RqJB6ZWkDR9/PDVgtjzb6hIWH6sz0+ZXugXeLypicD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c7JFsR7wXuHK6u41JRil7d2/q767fO5+In8+Bggsy1R35UuLWQ0+Fm62cQ9cf7kux9JoWgTWqDFJkN3IZ7I3esg2I8SNdHBx3gK4cWMi3n5DthepeJmX96rB2VvcWcRjT1CkWgASkRpiY4Y/mZw4JFccHufEWpejZ2lIhc+LYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIOr4SU6; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b95359440so29185435ad.0;
        Sat, 05 Oct 2024 23:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197837; x=1728802637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYnO8bxbAcS5ofNqn2tjM8UFXYntoF7uV3soxSFaKsg=;
        b=EIOr4SU6j5xe7U4/ImC4V1MbdC9SeyLyTe5N/TNhApAW3pA0xj5YEhqvKudxeEDbKQ
         PozP3rgS0PQ8kd4whodw+oDPxeLDBAr/JWmaxNXni0lCabj11YIi0kn7fVg8eobeeGkb
         J7U3hIy1XtX9VtyNqok5mq7TzZZzIWAVDCZ2Yj4UVYiUy2JHz795erJUfNozazkGkIor
         OpntcsvZNEcIeDLF5L4cxM8iXFtk3EOXpEQU0F0zI9HoAEHYH5Au2ej6uWnQK/yd4Vez
         2qzcq7yAXlajy3CMlONrgcS+7lEevd5cz9zmNSqkCnbMMRBcMxQqEMTvmOEpdTehGjZH
         1LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197837; x=1728802637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYnO8bxbAcS5ofNqn2tjM8UFXYntoF7uV3soxSFaKsg=;
        b=COhjIYJrgym4F0NkJJR0JT7kHL/HrOa81w/ORZqoq8novaz3aF7FasbKnill5AMNRz
         C3Iu4XejzPaGqTBHKfM8FYJ7LC2bC1a3mXgnlLCtwRLVGHFJHcu5LhzsEGB2J2T/rT8f
         yufrRFYol/k7135oO6CPHR67q55t0Oiv5DPorhNfBq0tDBc2FZUQH/4FZ0lBxaljiWGe
         1hWlEI2h88tBY5lnGsZOd9or/PPTQkQiC4wPgooAndjFkTZl51F6yGDEArvsrMCNsQV5
         /KQ/gOpS1Fu21c2BH+SZpkGiN/NQBu8dfpV1uAlP0y1+/V1YqDFniKQ2rqE7xJWeT4jn
         0QSA==
X-Forwarded-Encrypted: i=1; AJvYcCWACOQmAc/K8UnGeWOtcyShRuV8UwzaWw/TtSdMgOGMjlaqyKOLl5NN2mWKWgJvlaWC0jR4wekbsAfABtk=@vger.kernel.org, AJvYcCX+c/cOI0Lge+YqXjHjUUqZ1gnssHDvXcRZXfo8aoZpwO/UnWB5fY3vKBoyqJJkIbBjf0MG5rpO@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7fYv0AgCQELVoH80F3vxplflTL8Uu2nWYsRkkV/wnQcDAY8n
	zp17tLsuzpOYE1lKHZjPiBHx9G2qKM7oJx04NlY7RXoCJIqPzjEy
X-Google-Smtp-Source: AGHT+IGhzl23QZe5oiIY68+Gwzi3jX3QaPRoRJc0QbTSwKKTcyFCMRzC6Xac2GYxHdfyuj8m1NjemQ==
X-Received: by 2002:a17:903:11c7:b0:20b:aebb:e17c with SMTP id d9443c01a7336-20bfe04af0cmr114614775ad.36.1728197837164;
        Sat, 05 Oct 2024 23:57:17 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:57:16 -0700 (PDT)
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
	netdev@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v5 05/12] net: vxlan: make vxlan_remcsum() return drop reasons
Date: Sun,  6 Oct 2024 14:56:09 +0800
Message-Id: <20241006065616.2563243-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
v3:
- add a empty newline before return, as Alexander advised
- adjust the call of vxlan_remcsum()
---
 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 4997a2c09c14..34b44755f663 100644
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


