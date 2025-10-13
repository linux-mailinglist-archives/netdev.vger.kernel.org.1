Return-Path: <netdev+bounces-228787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F7FBD4060
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E703E71A8
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684C274B27;
	Mon, 13 Oct 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc9l9MkZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539030F942
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367219; cv=none; b=tyNrBGnEFFnGMLLccjeo/JXJjM0iGiyoIowOmn5rnlbsSSsvt45NtzzmnvJ/KzcS+73VxrRuWiCV8suFHHhPFDNKyvEaXtgjX60Lu4oqIWfmIX2nINuwHJK+Bpmz1dpF0AmQG7OxQ1OayBb5lYSogWgiMfXru4scN79a0RY1WrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367219; c=relaxed/simple;
	bh=PbuNSYS4ZvphCG8IIqw5e2RtAOtPsOlFF3aKC+mIwRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOlQjwKfGtuzfvCVAGkEcwu8ITDCq8eGUcYnsvwL5uBPFsvyNFaFK+5GWRH/z5W6L9YJ3lMHQGQIEBzfb0lR4wbb6g8QY74I+EbXBkk4Bz2SxMOUy7E6xYRlcXecEKftJe6l7McQUR5SgAFRsfvI+76qXkMEFHiWo1TDJLbOwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc9l9MkZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so2537314f8f.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367214; x=1760972014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRwTRM1YMVNfPJcUo8UFI2K+NlERkppykhGVZsYyCi8=;
        b=Sc9l9MkZ3jsGmKuzKFJ+WZzEdPxLvhnRI8KiyXKOgbVGZwAcnRqNP2Ec0LNq1zZ7md
         Mgq4VfOY21/tdd8fUZAVvlBcnBPIvU/xKZUYZw+ZPbW3jqi0ybSXxiN+ADp6xSnfF0c8
         aJnV60/1bMla5WqYSH4g+oYgHEAmF0gsmgDAAfe1RLWuoaUpKKPAQ5I5cdOiUCwWuK9J
         /sEwPMpYtXR5vCLJYbNm1CJS1DaJGx8PL8Apt906L1RQYAMoXgFTCXplecSj7VXQf7fF
         5J2uOwtwVSGXxOVIYxD+8NSZxxxZ80vhkwxl2ojns6ifMWP5ALcdJlIftTQJE/D3aG58
         7pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367214; x=1760972014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRwTRM1YMVNfPJcUo8UFI2K+NlERkppykhGVZsYyCi8=;
        b=KHeaK6j11YBfGqh3FUpHqDNFI8TU5xjsQ9HqhuVWuDbGSnKq1qrGBVq4kSaeZXDEyZ
         qqfZGUMC7Wi9dFkt6sJhIfUqKruo5wayKnEKv5jEwY3X4t5IKX7tBcuIELEqPsYkDCkf
         mW4guBFUttV0Qk/ZTP6mW4pZ5j2ivIrbEkNCn4cSCG8bWcOZURtdhawZBTImKXhCbxc7
         NlizRm6I21hyhGNtEEqHy9DvVExaW0XTqu+akq34AMi90OMxPQg2XFD/GVhA+EUnRXwB
         j7ofXsCj9UUX8uAYfQuRtgVquqnz42c1m4QK33mjwLo80X+JvB3hP3pig6j4nZQtQtAS
         Uu/w==
X-Gm-Message-State: AOJu0YxmweEvaBN0qqTMY0lXJn/Sn00GQkesqIpG/NgtnbNv4egZZE8z
	1c9+GoC/xL3b8it1ctoOkl8hw9kU0LZ8b53A6KBqOYSN5l0z0a0m0nn5O9ukRzzV
X-Gm-Gg: ASbGnctaZety7bXdR058OafkYh65K4gTxoYf9DGg4/P0GtQzK9wnScQ7Ms/4csPK1NL
	JbaZCafdQbDtYigK18l3d5UU0JMnvQBZANzOvaNDJvwsmThVh02enUME4AXy+OJIBB0lU9I6KlO
	PTY6KD3TiGAhf7QQ2s4UaqbxaCINT4vJTntqBZDPSdLtae1lKvvp4PS5TwygojlUm3Vl3Fe051q
	0ph6DQ+w6m5FnD9SSVEttYDmIXP/AgBcHyXypFz0z6SgE6tsVHco+XloIwuABDTKXGB9Yu2sUWe
	v8hwFJRR5J/wVRvmKywU549SRYwlJ/pIx0fIwmfogK/egVHv9k0zowrAWKBnHElC6vKV+RNKJ7a
	FTkIbuiU6J10ZVNNTk8wezZmR4GfPHVeJBjA=
X-Google-Smtp-Source: AGHT+IHmUh7f1JWY1Bn/xnAz1OdnLNh1wSTUkKJWaDX80Ssi4DYZzLpugyxu+bw4gsN3KGpLNos3vw==
X-Received: by 2002:a05:6000:4901:b0:426:d5bf:aa7 with SMTP id ffacd0b85a97d-426d5bf0c0bmr6709517f8f.63.1760367214055;
        Mon, 13 Oct 2025 07:53:34 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:33 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 07/24] net: add rx_buf_len to netdev config
Date: Mon, 13 Oct 2025 15:54:09 +0100
Message-ID: <bd750653950673fb2a4bc1fe496ddb24cca87619.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add rx_buf_len to configuration maintained by the core.
Use "three-state" semantics where 0 means "driver default".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 4 ++++
 net/ethtool/common.c        | 1 +
 net/ethtool/rings.c         | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 9d5dde36c2e5..31559f2711de 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -25,6 +25,10 @@ struct netdev_config {
 	 * If "unset" driver is free to decide, and may change its choice
 	 * as other parameters change.
 	 */
+	/** @rx_buf_len: Size of buffers on the Rx ring
+	 *		 (ETHTOOL_A_RINGS_RX_BUF_LEN).
+	 */
+	u32	rx_buf_len;
 	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
 	 */
 	u8	hds_config;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index eeb257d9ab48..2f05359d9782 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -909,6 +909,7 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
+	kparam->rx_buf_len = dev->cfg->rx_buf_len;
 }
 
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 628546a1827b..6a74e7e4064e 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -41,6 +41,7 @@ static int rings_prepare_data(const struct ethnl_req_info *req_base,
 		return ret;
 
 	data->kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
+	data->kernel_ringparam.rx_buf_len = dev->cfg->rx_buf_len;
 	data->kernel_ringparam.hds_thresh = dev->cfg->hds_thresh;
 
 	dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
@@ -302,6 +303,7 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	dev->cfg_pending->rx_buf_len = kernel_ringparam.rx_buf_len;
 	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
 	dev->cfg_pending->hds_thresh = kernel_ringparam.hds_thresh;
 
-- 
2.49.0


