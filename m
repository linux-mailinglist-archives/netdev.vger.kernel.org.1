Return-Path: <netdev+bounces-223250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA1FB587ED
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670437A2515
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1A92DAFD2;
	Mon, 15 Sep 2025 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS8kWx0w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178AE2DA776
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977143; cv=none; b=a+tsnPAO8hHqkg/mNNxrGjwP6HLAWYLhW6dTmC+APFSMaP6u2/UtBumfD/iLdSmTYHlWRp3b8h2Nh2HfP+eZ0Mdal8TOdPGwkTa3aeGm9J0m5l2RRxyvKTc/hyZVK3AfDWGRpkJs1NGag2tfpYbMWcI5V37WXTEzz8df0tdeIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977143; c=relaxed/simple;
	bh=oJxZ0LJpiaRLyNvWrHRBYmWKDR9q/SiCzqlMoBmKTwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLfRs/6i+svfCKr7ul57FWYcthXbb4GWP4eTjMpA56MtQo2tdKQ+C+FuNuHSXZsO1/sGIlTk5M9H90EUkU4ikTHJ/xEBXUZM7jqlcDCGB3i0maBL4xxDH8jX46LHh68C0AvM+YDjL4k9BNGgtn8TQrO2Vme2YPgByNlo08gjvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS8kWx0w; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4010600a12.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757977140; x=1758581940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFpvUejFadK36BdJ1wBmBitmXKjhSS9UT5HZga+oq7w=;
        b=HS8kWx0wPjbHaSyyeJy6eqW11F/0cDcbbo8+qhOWpMSaIFgdyyrSSeeq+fhCbx8rhD
         8M6zFeMkFcxXlqCL0dHNBf9r++MwZs3rdsbf60/0IIL1FrrZaZ7cWzgNRzf6E84ejxwi
         jPT/PEfcjCH1ow5F7t7HeXTD/uLngPREJNoePmGZgvdsK1IJInsGa/lh38EG7Xal73/i
         6zq2VTBB0HIhXFwReLCMduHqr35VwaTNLS7otGLjxW03Fj88L7nViKxdhzTst3kf8YHX
         OWOxvD/BllZXl1kNXW8gPx7DKLgJBvRhRC/DmLi5C8uEdFx+kNjOEOkLl6oBXmDYt7y+
         SKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977140; x=1758581940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFpvUejFadK36BdJ1wBmBitmXKjhSS9UT5HZga+oq7w=;
        b=aeF/Rx+HIlEy9HwZe83mDv9fHWKz3b4do0x9NV/HRLtfLX/8Mqt7oR541nyrMweAF7
         8yfscZS9wuntVcb3aJdh+Wdht5s/7y8DMvmXZBp7e8t7d08dUtqiMPxBAkm4ZAtFhkY/
         VikGpGDo9udR9QVLvUsdCHJrHBgsfHdjAWjUhCPWYnzOFz96HtbGiVKQ3p0iP5V8hRjN
         6ryyMyHq76mGw6GML6+UI5zRPkHJ9CsZezhpikBCdEe/8OszhLACL+LGSqGLGu1RvqTr
         kSItMlT5QXPsUIeNWS0alSn2W2wP9fnTmSZqv1kGxfhF7PtUrBrOmUD6tPYUsjPy0kex
         WihQ==
X-Gm-Message-State: AOJu0YxwK8D3DoqKG9ODXsfj/52tqHIeHoBthHMGUywRMdKN5zn85okM
	E6jQzxvVnBEghKxajYluUIs++SMFgxveAlNeK8DJLFOnRpWTqrO1jRPWvgdTyw==
X-Gm-Gg: ASbGncsj19Cvp+5ww+kGsyjmsADXVytzypdAKwaz3sHXa3f0+0GSmI84TWotjPexTu4
	rPxF1R1ifO4AKHybwyNTK2XMUmPdEo6YfOU6WwlfXNzaICb771vPKaJLIdA7Uc+uiFEED+eV0lY
	+Xj4IteKMH7cfTKPNtr2lA561Snorwis/100oKyywQQvSqJqS3fnI7avqVbHOMLdNVSfVhmEViK
	iNO1s3WpiYJdGgAkg5yyZDNydT2/xTzIoiN9cqDmpyy6M2SMpBl8nLgSNXL9BFEx4FlIL2xPoQp
	64B/m6XEQGVh1RfHwLmi0gLkiA0WBhL2Fq8UJMj4Na9jOl/eMfi2RTu+RBtp5yFJ8pGTHhAMeaJ
	dZmvQfZc3MR1OMVfveATrUJ4=
X-Google-Smtp-Source: AGHT+IEXQ0S8aPcKl1Zt8DDOYbgd6c+4EMejzZmAL6ZqpmLq0pwFmRt8DDQ5wktIjHik9QCXPh5Bcg==
X-Received: by 2002:a17:903:1a26:b0:25d:d848:1cce with SMTP id d9443c01a7336-25dd8482072mr164256295ad.19.1757977139904;
        Mon, 15 Sep 2025 15:58:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-260e10401ebsm83673445ad.91.2025.09.15.15.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:58:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	martin.lau@kernel.org,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	cpaasch@openai.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH net v2 1/2] net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy RQ
Date: Mon, 15 Sep 2025 15:58:56 -0700
Message-ID: <20250915225857.3024997-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915225857.3024997-1-ameryhung@gmail.com>
References: <20250915225857.3024997-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP programs can release xdp_buff fragments when calling
bpf_xdp_adjust_tail(). The driver currently assumes the number of
fragments to be unchanged and may generate skb with wrong truesize or
containing invalid frags. Fix the bug by generating skb according to
xdp_buff after the XDP program runs.

Fixes: ea5d49bdae8b ("net/mlx5e: Add XDP multi buffer support to the non-linear legacy RQ")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..fadf04564981 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1773,14 +1773,26 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	}
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
-		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-			struct mlx5e_wqe_frag_info *pwi;
+	if (prog) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
+			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
+				struct mlx5e_wqe_frag_info *pwi;
+
+				wi -= old_nr_frags - sinfo->nr_frags;
+
+				for (pwi = head_wi; pwi < wi; pwi++)
+					pwi->frag_page->frags++;
+			}
+			return NULL; /* page/packet was consumed by XDP */
+		}
 
-			for (pwi = head_wi; pwi < wi; pwi++)
-				pwi->frag_page->frags++;
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			wi -= nr_frags_free;
+			truesize -= nr_frags_free * frag_info->frag_stride;
 		}
-		return NULL; /* page/packet was consumed by XDP */
 	}
 
 	skb = mlx5e_build_linear_skb(
-- 
2.47.3


