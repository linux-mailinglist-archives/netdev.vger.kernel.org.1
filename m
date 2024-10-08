Return-Path: <netdev+bounces-133140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39445995192
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A43A1C25639
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369A1E0DC8;
	Tue,  8 Oct 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duBkNpI3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A51DFDBE;
	Tue,  8 Oct 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397473; cv=none; b=eM5c4j49OKhGUktpqJPBCZ9RkfJ2aaMWorjDO6xF89HPOUb9IKfTpVGIrfR/asf7rYJym75C5YStw/DiF59nC4ecBQkdJfa4pY5wl+yG1SKVJxCwwSIL5xMAskXj3mtzD8ECr86sofX/J/2kRaHwX01IjWPnxg3f27oOD1pNZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397473; c=relaxed/simple;
	bh=RqJB6ZWkDR9/PDVgtjzb6hIWH6sz0+ZXugXeLypicD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kcNWD8BK41v1PH+GjEkOHcc2LZEdfWkz7KIiBZROt8yuYgIxh71llGSzd4aEYEeQf2xEAYtJ3T5gMzMJMYPtwfue3ZAcgO+UDcGlM0CTczCBsNwVHEO/ayPn+JxGGX2AleDTXXBw+tC+aDh/IN6nJTsBPBt7owD+w3h1nTt9edQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duBkNpI3; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e2840bb4a0so585900a91.3;
        Tue, 08 Oct 2024 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397472; x=1729002272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYnO8bxbAcS5ofNqn2tjM8UFXYntoF7uV3soxSFaKsg=;
        b=duBkNpI3/05RgobsTst5727zLMAi2M0F/SZhjGC03FDuzZZjdsMz9Z17Yd8GQM4Cfx
         orIoOD9eQ8AH/z/Myrxx8eug4CAuMjc5aWU8ybZ72jUiBorfTdJsBtDmc01mtC4KTaSO
         kjMUrnSq4d8GlEge/hYKXfI+ASfbO54IJJ67YVGIIGt6OO9Y+KqnQ5qHVf/Q5QJNwpDC
         zuqzjGYUGDOnXzfPcxD17SaI25ZQdipFgG4jkP1jwxl6p0MRpM9pbWTkmAGpvyqGRiy8
         j1HXpJN+exO/3Y8iM98KQTAks56QpYj/+zGS9j61GnIV5p4m2G3bq7NklDWlFfJ54Mzc
         uKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397472; x=1729002272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYnO8bxbAcS5ofNqn2tjM8UFXYntoF7uV3soxSFaKsg=;
        b=oQ8qfnha31VG2nLrAyMYz4YJXLn8Xbm1viq2+EC90OMxwSUVk5bAj0X2Rc7rmFiqcz
         IJ3wjS4XVcGl6n5WytBLqBeZfkkMxKfBPFDvmLXjHIEW0iEDAgM5fHi9GDTy5usmV2ef
         OE5y8WzmrLFGtzzMCli3ODdJ7LRBL6PVyObQn02Z9eUfOBnVB39QYiNUzlJYqCQANE4X
         9IWMMEECOwulz/+YUBRXo9mkw5cPrz0jok1+U+3miGs1kKeiTtFf0CdJKKjk/dueSvL9
         Z2Ijh1/EwbTKcXNc2cNbOY4P7ppvzfwKkyu6jEYlze1jt3cr7SO5KRbwsXwwzkwXKa3k
         0kxA==
X-Forwarded-Encrypted: i=1; AJvYcCUe0E9a+boN23AubjgCwHCTOH1N5blNCVYoldJJnvHASPw6bfAVatuXJwKFPt+5ITrx78dFAzaitPQITFk=@vger.kernel.org, AJvYcCVoxIYh4spaKyJcGD7m/IrbVOxMTc0RgC1PbsdUODvWarkDCZ9AbaGapRpki65uhVWemWsAO8I9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywov7P09p26gipVIcEm/L/+8OcsvtYLQwbenJyqjqen8IJ2sdRe
	jOMhv36mluxl6lUS4LBvVfam2sRRAFVHRqhuWySdMHevmae6k33l
X-Google-Smtp-Source: AGHT+IFh/BFnmqLGxVjf6ON9fbWe2iL221pzBD6ykg1SSZzmyL7BJryXyk5AbXx53QLfrLOi4MWhAA==
X-Received: by 2002:a17:90b:3891:b0:2d8:e3f3:fd66 with SMTP id 98e67ed59e1d1-2e1e636c2f7mr16356143a91.34.1728397471888;
        Tue, 08 Oct 2024 07:24:31 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:24:31 -0700 (PDT)
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
Subject: [PATCH net-next v6 05/12] net: vxlan: make vxlan_remcsum() return drop reasons
Date: Tue,  8 Oct 2024 22:22:53 +0800
Message-Id: <20241008142300.236781-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008142300.236781-1-dongml2@chinatelecom.cn>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
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


