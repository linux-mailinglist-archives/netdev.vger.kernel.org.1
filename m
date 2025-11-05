Return-Path: <netdev+bounces-235936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA8C374DB
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FDF3B5E11
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F8429C339;
	Wed,  5 Nov 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZ4FYmEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA1299937
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367186; cv=none; b=iseXKtANa/kimagBxS6Moa9r1oNJWSqCbBDSip30RvJrjQnIWXIgvjSSO8Gyn5atye5Zmql4qRZguY0vD4CJ0l+R5f2y2CoohTXnqG2BbbjfNTXSK9qGVyGxrfxQwp3lvrUXFdnONkDA8I4MPMWatF66qRoov8ldmEcbXY+S45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367186; c=relaxed/simple;
	bh=1Y+YpubDp1qb7oc7hg3w1PWoz9inIa15b2wdhzuZk9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YOsHDzzz7qHbGdAwL8YQa2k4P6SVXPvTLtvGIkTQVmnaFLJuyGYH8faooBXOUkBv0elGHiX078eW/iNcD2NlMg1DdfvufWAb8nEHF8mBNpn5f/+0fB2tV39k6dmNXXvHDkbM9VqsHy3VSfy7ObdlES/HtVouFOpf0TGDIZe4pg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZ4FYmEO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34029b3dbfeso197636a91.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762367184; x=1762971984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3U2BLp1AgEXNIvYOhrj08jJ81pfESpJT+bWqtR6/KU=;
        b=KZ4FYmEOqMSHflpbIZTc09vYFVz9FOEA4TGzE1mWItdHQG3BL1io/C9yyGpgMSQqfA
         HRASmZFdTOF+rfJYPNX/HImatjed2toO+SYchkHdm4cJKy62z1tUu3dH1+RN4JEqQCRz
         WXucBIO2H1PWCkx+27eKymukxqakkTOeWTY4SluAhIGP4AY0IXoe/DfvLCVcwBkMYvZS
         N5yrTE4vB+85opE2HHmiAUUsj2KGsPdIvfybNKZ425Mygqeew7BEmQC1Sjma/B3LKb/C
         8PIU+1jYw3QKsprq5Xnk3dpPtIMFFX4ITEujXIQ9b56WcmsmmoCPukUVc1/mYmITyGou
         yG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367184; x=1762971984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3U2BLp1AgEXNIvYOhrj08jJ81pfESpJT+bWqtR6/KU=;
        b=dfKHAzeOdNBgLhOSxKuTBqm2MGdfFigrg2TLnaIzg5sB9wLJ02rATEMAvl1gPY8Lgb
         YBgXiWvMzevZyqLRz1v1V4Uyg0DxJDB0vwRtgI6XEfkCiZsNPH4y7VPJ326QAGTpDSL/
         p8uUvD0MJ760RDbm4zh8O8v70KGFr5vxCGdWg/dHzgpd4tkAcF3wY10nvUtDBre8N4rB
         0mte06okb1r+pHXNYq9bPDCW0deCCFAa8VDQMn3LCu995q19T6CiO2wxAQOIQyWuI57R
         6cu04+9cvtsGZYUIBl3G9viKbswKXCZgP+XPWwX3pHnSPWIORP87jM1NRxdx+aeROJUc
         3L9g==
X-Gm-Message-State: AOJu0Yy8+0F0fXgz6sFcV1I460BoTi01pxFTU7EumaE1uS1MPMtArym0
	AoRlVFswLVd/itEmAZQ9gNAZYFuHyhSgbPMTEHgzNu1Q6cubOHOoj6yrGOApdYn5YCuANM8mMi9
	7blIBVSlnkVspB0ubNvu0/Fj7BVYhG52aKdMgs6aF1QOXbePSzVj9Pt7p15gWwTUa+6SCpHBPwx
	GQZ1eHBnBBmNmmfv/Zozp3iEsLiYJydOc5e4VpJDvQWsNBAMY=
X-Google-Smtp-Source: AGHT+IEdUAxa3HWekMEatlxH9Kt/FB0hCWCz5vzdSLG5I0UzRSXnc0Ih9uf0QxQgeyniEKJEai53BK+w8nYlGA==
X-Received: from plgm15.prod.google.com ([2002:a17:902:f64f:b0:296:18d:ea1a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da82:b0:295:8da5:c631 with SMTP id d9443c01a7336-2962ada612dmr64665275ad.42.1762367183511;
 Wed, 05 Nov 2025 10:26:23 -0800 (PST)
Date: Wed,  5 Nov 2025 10:26:03 -0800
In-Reply-To: <20251105182603.1223474-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105182603.1223474-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251105182603.1223474-5-joshwash@google.com>
Subject: [PATCH net-next v2 4/4] gve: Default to max_rx_buffer_size for DQO if
 device supported
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org, Jordan Rhee <jordanrhee@google.com>
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
index 4f33d09..b72cc0f 100644
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
2.51.2.997.g839fc31de9-goog


