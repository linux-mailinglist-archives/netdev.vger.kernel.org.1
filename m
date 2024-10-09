Return-Path: <netdev+bounces-133425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03395995DC8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BE21F21023
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4815442D;
	Wed,  9 Oct 2024 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWioyPdk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF315C156;
	Wed,  9 Oct 2024 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440977; cv=none; b=DVQv9JCxwyRJ4p2/dU7pA25FMVt7Z6a8ZxfVxVXH6NpFCCZv/uvbs9ML3+lvSfS298FHysXIxsLhNpqWBY9tkAzf6Ljyhkk5cFdP5nwZiaFY/aOXI8EAsfjN0n6s9FuLpvUukSgitiLIqY8019wUJAdHizI+JPKBzwBeBycfQaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440977; c=relaxed/simple;
	bh=RqJB6ZWkDR9/PDVgtjzb6hIWH6sz0+ZXugXeLypicD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sz4g2OofEzcqCCSfvz2z+yG0jTfAoGbf7sHk5v7nBQ4BuqHuvC6UNVQZGFzqtqpI6yiQMh1WO5Qv4j3yuGHd2RXPKDAuDaAKbXV5ND8JcrWfXL9pwQY9vQcYQMBOqyFMv97k1jo4gYtnuOSbT+kp/ZlwA5sr69Nm3uXG+g7X7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWioyPdk; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e192a2fe6cso4629702a91.3;
        Tue, 08 Oct 2024 19:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440974; x=1729045774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYnO8bxbAcS5ofNqn2tjM8UFXYntoF7uV3soxSFaKsg=;
        b=cWioyPdkmmPi508gHeNwomxB4QM039W79rMAHC8+E1kkSTZXVbLnrSTuvzkaIBEMY8
         HhofWSNaQGzqAuMbnVTquq+AssYVqAxM0GizG2Lc+G4ZKEecGs6xEqyJ81dJst4nmU2Z
         jcnY13nJSGxpm1n0onm6tYYuPanIro6ft7JJBaQST/J4ZKiXqhOKnQhwqAqTbktEFgjx
         nHvaxGvYWmDEabZAN3WwR3401jPn7fBNcMxSjO0Fo3urJ6kuPw4pcERliKreWEwBkXXg
         +lCixPfRNQgg+B9ECLyRYUwtx+JoqRco9WSzKG+f2BJ49qWYydhZoGDg20Aq0j1EBkZE
         iMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440974; x=1729045774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYnO8bxbAcS5ofNqn2tjM8UFXYntoF7uV3soxSFaKsg=;
        b=v3EhD28FKtrt+REv7ymWmyPe+enYLFkduKgCLH3BU6Wsi/nYuhQxFHLBbbKwsnvw/O
         mqJ9zYE8BICHzCK2UZfCgBgrw581mJt+uex0+JPAFhcn8kfvBxW/kphbWt6SvotdXd/R
         HEOc9M0K4EDRDXagf2nzg8jSKrT9KCIfpj3MwFEs7xaQ0nfTtUS5dt+XMx7hAbjeMltQ
         6SVLBbwECfZLD83AvoQp5+qfhpnfLTBd4OJ3260jMghjCmj7CIpdqg4lq8zX4IoRXBlb
         arX/GzseGpuFvG49/1cgnwnZZT0aEZRju+E5Hhnbu6gYOzEF2kyNz0kUCQ58Yow8o47r
         a7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAvL2kdnGt2QjbjaINiuqNTUe2I1PPpKE+2D0cPJTTBWSjYn3s1Ys10Qhjs1mt7LWKV8uTE7u/PBsuOeY=@vger.kernel.org, AJvYcCXgyE4WiJHJuHepgSeTrp6qIYYtna/jlPuWlCNUP2PeJtDc0HvaUHJQkuvuN5fvDLavXsDto7Gq@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOmf2sU9QGsgbQWMiV+9JF0C5ob6HrE9yIeCLK9aqX4HHTdui
	oB9dSopQuvn+fR1UzROH2pAEINXfO5TpCn5RuQrEsdjBk8SrD8mH
X-Google-Smtp-Source: AGHT+IHvopXBkS77CfGAfceqFPdFPmSkEkinj3J8ogMlDEDDZIc/iQQe+FlS6tsyGMiLrZe2JoX9jw==
X-Received: by 2002:a17:90a:6d65:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2e2a2322fe7mr1353575a91.10.1728440974332;
        Tue, 08 Oct 2024 19:29:34 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:33 -0700 (PDT)
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
Subject: [PATCH net-next v7 05/12] net: vxlan: make vxlan_remcsum() return drop reasons
Date: Wed,  9 Oct 2024 10:28:23 +0800
Message-Id: <20241009022830.83949-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009022830.83949-1-dongml2@chinatelecom.cn>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
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


