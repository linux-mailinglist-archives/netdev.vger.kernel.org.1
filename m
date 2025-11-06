Return-Path: <netdev+bounces-236497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C63D9C3D3E9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 20:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9921891DA9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 19:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B42C15AE;
	Thu,  6 Nov 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHPfb4PQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DFE3563C1
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457301; cv=none; b=HV9qW6mv2aTHPSTqkzZXiniKeSglinOoDKvPjXAHAktG/KKpR5tozk9TDQpGIvKmxIOC/PFjRv6pYoqYI5clEcdJOCddtWGDe4TylCuON+7svSBU25FixIhehHW45r3y5v6cwNv+DXGEeBgzA4RWustzVBa2WWHpNCOM5o4jy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457301; c=relaxed/simple;
	bh=1Y+YpubDp1qb7oc7hg3w1PWoz9inIa15b2wdhzuZk9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y3KC/RsDcKePmVZ4kPhwoBro87ocd568iSsoSCz5H37xNdS09LPcOhiu/gKgzWOKy4oSnte2MEIVt4DWjIAXQxiJoqD7+Y0qucnCPZJbQEhDfd5JOnHtBk+3BIdfGvnr3Fh31IDL1aa8Vqb45T7Qk/cKNAB5Yofw/35LnI95+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHPfb4PQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340c261fb38so30177a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 11:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762457300; x=1763062100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3U2BLp1AgEXNIvYOhrj08jJ81pfESpJT+bWqtR6/KU=;
        b=UHPfb4PQU39Cv/eKk8WklWaxzzx5nlgo0wkShcS3pz+RkqzJiUgIPD9yql7++QZ8ps
         3hIRl5HRiN6Q+fP9QbJFveo2tr/o3aY4Hbp+wiVNNXBiHRujRH+Cf8Ld189uqhqXjlc8
         NOBO9ASCnX6EHRy/jDLUkZz2tVtkqCM2Go5HSDqeqvAf8BOMDvdZtgs0KkBb7nfEk4wh
         BjSuRfV4mNB/YTKcj3an9PSPNj6b0VP9QIMnkiJ5tV/h/1pjTANrwjRshGtgPoCYnOTe
         Z1NO4sbnhGTHLg/xo2mTB8z6ITO+6YsRB9W0eRnvwYnlYCmcgGwwlxJd8bD34MEKnQvU
         PNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457300; x=1763062100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3U2BLp1AgEXNIvYOhrj08jJ81pfESpJT+bWqtR6/KU=;
        b=WJVGeFUBz0z3LMokuvIzJqkfVDcu1fHFIpEBwEr4CD18gDRKEbPGWI7Zkj0Vuayp41
         zew7ymWtW1fFQ9Y0iFidoXzrkXK8ZaJN4BDZa7rX7do4ure8OH3yNVPQAdlOiE1ZR6zd
         RyH5uuBiaT+Y8lHgl8n8VBCyoWpbKeFadtcapcPrzPvR2rmreiZZQZXEHz609UF+ohq7
         bHyWf+kYSMez5W5GVDKhpE0PDc5DsAUFEXQRNDJuhE/Un3EXr5U07PsdCH3WgA42d+K+
         mvQqbiCV9kT0J/s16oILeGUmOz+heYx/C4vmkFZXUhJHfprFOB7xJ02HpKhdxwUZvVB1
         k7Hg==
X-Gm-Message-State: AOJu0YymoYJH2nPNrwZ8SzbWLVYkbBKQH+3HR1l1p5AfXteEQZvp3aWo
	wgEcmC5C1cLfMqqB4eNmC9a3nRYiFVFjQ5NM1PUFpxpb5NTbUhNXKXwdWc0Mwbti/o+3Ks2aEwd
	NpB6aF25We0LZqWhfk0Z+b9xnlcob36FS4Ray7y+MQoH9doxO6TGvL2d/z4+gR8iN2qNd6kvp7S
	t8iA3Uk48zGugx/WRcPJKfOTCQCsZ4fISvsM2TZT1oGoi9JfQ=
X-Google-Smtp-Source: AGHT+IEsIfGYhZdZ2tqtBbcVUZ7ueSUHICQoVDbIm+m6yTPLyYNJ4OIu36HZ71hM7vJ6QPPO9Ilb5TFmeTcycw==
X-Received: from pjbrm14.prod.google.com ([2002:a17:90b:3ece:b0:341:2141:d814])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3809:b0:32d:dc3e:5575 with SMTP id 98e67ed59e1d1-3434c4e0e7emr325363a91.5.1762457299298;
 Thu, 06 Nov 2025 11:28:19 -0800 (PST)
Date: Thu,  6 Nov 2025 11:27:46 -0800
In-Reply-To: <20251106192746.243525-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106192746.243525-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106192746.243525-5-joshwash@google.com>
Subject: [PATCH net-next v3 4/4] gve: Default to max_rx_buffer_size for DQO if
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
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
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


