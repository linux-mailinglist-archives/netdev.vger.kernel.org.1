Return-Path: <netdev+bounces-166598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FAA368AC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6841A3A9E53
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE7A1FC7EE;
	Fri, 14 Feb 2025 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sj/IziDH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C81FC7FC
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573090; cv=none; b=USzKZNULH1FTEf3Ad38n2bf9TTLhpeuGTgPFE13Vqo5weH7Rae4CO/YtmeYSsleUeMT78LQcNNbcLLbs9PQoItkhfk0c/PbnV5w/7/rTDyCbCzgHWbqfjJDGd60xyL0tnSpGzntJoaRsG3jldZES4EM817Mg/qJgW2HqcZYfEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573090; c=relaxed/simple;
	bh=C9A3LWRVVEvM4OBlqT9wYA0yWCdJj2Hpz7Z1pzmG8wU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MuLbcx6xcEkmCd+Gz8HMZ+IxQ2BULVtdgMDMJe7zc1ibZHzMUpc0rlLMlv8UczFleghxlRQIO6TIv9ADtbG29BJp9w8mADI6VRbVtuC4T1UynvlJDnTBFSgLKWBoYIjFaQ8uQkQssBGgU1SerHQ7mv++Zt7Pdr8nhrnes5SPxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sj/IziDH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21a7cbe3b56so42533535ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739573088; x=1740177888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUNETmfCcN16mATl/cudDdX8wxXBFFNsGuPJIeAzz7o=;
        b=sj/IziDHroH5kXw5DjtQJdNC0AeZGArJJh2x98x4jO7HBS6Lp7Tzk+QZzpa8dqlUYP
         jfqLmNconmo8MCmiAOPWrPLU/TCV3nuJNTehQ/OVNXbbLClxjaiAiLNxLKA5WIblBQb6
         7NoOkVtNjckuuQY10tkKmL4ZsEAR3d5lWYDpM75KGEDAxgp+m2fYP1Z6XITeuCKYkuE6
         EZvFJYqiDjBQytspQ5rYqzYceWstJ4fS8EdgThrk+ZAyL1e4Qh6ok/h5O40PPUJ0zsCk
         QI4C36QMidbIjO60BKbHmGiHDc68GtFC1NeQFj5F+cM5sPeA2uzs/3ZHZvbPbRvlR/LM
         DFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739573088; x=1740177888;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUNETmfCcN16mATl/cudDdX8wxXBFFNsGuPJIeAzz7o=;
        b=pazihgMM+98Xp9byplq9yENjgTjszpbRLzByGyngGPAIprDiEjJaLCI0EgmbcNqeSv
         mrjWCfC8EiZ+xPwqdJ/oHEb/EAFLRppPILQzwPa3VXNkH+bXtFnvP/z6//WapfnuaPDb
         fIvlfXY1v2qFs//33lcbxIxYCyHKtjTPgR4/lBZZwfK5B2zjUztV5Swk2H7v6DqklVVg
         ICBtWo4D1guLvcDXy7agfwPCUnaGzOpLhkAsm3pHbh9AjfsthBVTDgB6NqXfiVSpg8Nx
         Rwm/p2EyK5aD0/TI2ddegl3za8vchfdVG5w6smoDJdYllFqGbt5+CPcwX5hkg3hJ9wZx
         epRg==
X-Gm-Message-State: AOJu0YzJ2kvGLoip0ZTFDVlVP1Oe+j9+1BlUP3NGojcUbjUbf/XoN1F5
	i87VL0POPFbxauXosCARMpdKFpKy89swpLtMUQncm8ZxOQRuCiJOuv0Wz2o+B/PWMKel60CN6Lp
	7jjSfXx9FqIaY3vDkQwfzkea9vzchBTcHowtWL0w1dhCvn4pTTnwczhZ8Nrn3sljV5ydoMimd0u
	ytnWWEVd/BSonjwOvq73/kMdWzVJaIbqaXXTDW/VC0CeY=
X-Google-Smtp-Source: AGHT+IFipCMt7qHod8wE+QJEnJFVy+GDVWXm+FNM4uL263Au9RAnEUGi4OFC3Gq37Yk5dRgHAwAYikh+aCfyzw==
X-Received: from pjbtb14.prod.google.com ([2002:a17:90b:53ce:b0:2ea:756d:c396])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:986:b0:215:5ea2:6544 with SMTP id d9443c01a7336-22103efa6e3mr14484155ad.7.1739573087787;
 Fri, 14 Feb 2025 14:44:47 -0800 (PST)
Date: Fri, 14 Feb 2025 14:43:59 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214224417.1237818-1-joshwash@google.com>
Subject: [PATCH net] gve: set xdp redirect target only when it is available
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	Joshua Washington <joshwash@google.com>, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Shailend Chand <shailend@google.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

Before this patch the NETDEV_XDP_ACT_NDO_XMIT XDP feature flag is set by
default as part of driver initialization, and is never cleared. However,
this flag differs from others in that it is used as an indicator for
whether the driver is ready to perform the ndo_xdp_xmit operation as
part of an XDP_REDIRECT. Kernel helpers
xdp_features_(set|clear)_redirect_target exist to convey this meaning.

This patch ensures that the netdev is only reported as a redirect target
when XDP queues exist to forward traffic.

Fixes: 39a7f4aa3e4a ("gve: Add XDP REDIRECT support for GQI-QPL format")
Cc: stable@vger.kernel.org
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      | 10 ++++++++++
 drivers/net/ethernet/google/gve/gve_main.c |  6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 8167cc5fb0df..78d2a19593d1 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1116,6 +1116,16 @@ static inline u32 gve_xdp_tx_start_queue_id(struct gve_priv *priv)
 	return gve_xdp_tx_queue_id(priv, 0);
 }
 
+static inline bool gve_supports_xdp_xmit(struct gve_priv *priv)
+{
+	switch (priv->queue_format) {
+	case GVE_GQI_QPL_FORMAT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* gqi napi handler defined in gve_main.c */
 int gve_napi_poll(struct napi_struct *napi, int budget);
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 533e659b15b3..92237fb0b60c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1903,6 +1903,8 @@ static void gve_turndown(struct gve_priv *priv)
 	/* Stop tx queues */
 	netif_tx_disable(priv->dev);
 
+	xdp_features_clear_redirect_target(priv->dev);
+
 	gve_clear_napi_enabled(priv);
 	gve_clear_report_stats(priv);
 
@@ -1972,6 +1974,9 @@ static void gve_turnup(struct gve_priv *priv)
 		napi_schedule(&block->napi);
 	}
 
+	if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
+		xdp_features_set_redirect_target(priv->dev, false);
+
 	gve_set_napi_enabled(priv);
 }
 
@@ -2246,7 +2251,6 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
 		xdp_features = NETDEV_XDP_ACT_BASIC;
 		xdp_features |= NETDEV_XDP_ACT_REDIRECT;
-		xdp_features |= NETDEV_XDP_ACT_NDO_XMIT;
 		xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
 	} else {
 		xdp_features = 0;
-- 
2.48.1.601.g30ceb7b040-goog


