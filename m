Return-Path: <netdev+bounces-228784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A734BD3ED0
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B36824F9FC9
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDCF30C340;
	Mon, 13 Oct 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dttiYk1R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBE30B506
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367212; cv=none; b=hz6H/ONKpuNK9ruEbONKi6RcibDWjpkJVf9/jEA2cLWwxtbdeFpRTlmVUSxSb7tNcwqd+rhg5ot5P3P3HTBN8GpnC3EewZskVLljnbqL17lkTiC31fa9vyBNnadW4Br1jbd63Xu6Wsd0Rkcof8EdOBxwUTjXWZn90d/x7CoPLM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367212; c=relaxed/simple;
	bh=8yivflMmS6ZWIrzJSRvVg7Se0eo997CBR4EGse4XT6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjgOwZG3rO7YX9hO7RaRBhiYjjXG0R2/vyQK7hrW/iJ51hnkID+O/XqO4P7xzjANECth69b7/HVvEoLFWWMEg8x8ZNedYSAQaNaMkkzuFBTxUlDb/y61wuKRs+/w7oVy+/hPKNaXNEl4H42t8SdAeZVCz2hBX5pqjYm2HzoYMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dttiYk1R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso31761825e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367208; x=1760972008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiKBlG9HlBGLvLNYc+/UZCgemFX+hK9aM2Cm2KqNb2E=;
        b=dttiYk1RMiXJYpx+btQtg+m0l/59NdUYe799cbaiEAZ9V4bqy1Pm1Jcyz0s/3Za6JP
         kisRXY9YR8vcz+PuknSdeGWa6yrnbH2Emp5lgMRHkYRyGPsDo1Jv1FCLf37IywFmh5+m
         v9oS6lrE/MM9xa17SIrDq1I50tVZLKhNvsbZci8JPuKo97CQwIgba9LAKFDsFynxNRlo
         jwqZ5UarIqNYnzKRP1pzXebrZStqBMeWRkiadfnQ3UxwCB/8ijckVZ8172f+w35+TjGm
         jybRi3oVO53CFZ4F94ivTVz+7RWeilop1Hk9p4b3pZgTwYRpkg8AjdwZVG7MpAWcWwjf
         RJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367208; x=1760972008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiKBlG9HlBGLvLNYc+/UZCgemFX+hK9aM2Cm2KqNb2E=;
        b=eV8hFXE3MDhVlqPFJi5/izU/H301TrIS+COkyeSJDsC5ylnbPWOyOQGOJSyknV+wU1
         qWLeO9pvO9PDaFcS/w/t2oZljzRom7/SbPHs8MVcLI1qwAc0U8du/4PQdGxfyKi34ur1
         sy75Lm+yfdz6ILT1aTbbQUHoNCtBre/mlkqqNmzrWEfPAyIbVqDKQIAGX4L0vvHL+dpg
         xGsPsH5/G7EvUXEB++J3g8HnpVSsWNQrip5KKudLlze+XNK2aw4TkHcenu2fViT5Een2
         Piu7074h7PY5kygVfxhEBQHjQeD4qoPrprEnK/oHl9J5ZaTgmZRvIy8FFZl+XHfrBKTi
         kb5w==
X-Gm-Message-State: AOJu0Yxcuy0FahHkhvx9n8EuGokbAztdnviFBxbztPMBs53Mct+X8cb/
	yrLeaFMHKZeCGwHfoz63s/d3qx00xuLMrRCS0lTst6Yrl6DXgPHUxdgRPpKJxIkw
X-Gm-Gg: ASbGncvfPeXawiTOlwHnTt+odq41mGVsTk4yck571DsenbHnWxdU/QOUtObs2mPOhFE
	74yvev4f7JSyQvVSvKqLcFdNgQLEGS4JRlaRSm2nE4+PUTiLF9MqElAx7sIujHXM7VDKcAe82Ep
	G5NN5eWLbT7dfUuN1fESKDW5IIZ+OzMBRuBptQDD1gCtbmHiQvQRQppjQKwSyAh0bdyVn1wX2fy
	/L6qgRN6TQaYAoulLFjDrEzfWRcHWU8TsjSX9KQngJe+c9TviLQflmX02ZsxWFys/mE1G5Tpqsh
	TgMMOTmrDtWqaP40pyw0xX8JAyQw0O7l+Pn8uFsFQNl/Cjkm23yA8g3ziJc9xykBVTgVIfgsKtg
	I6m2VCny1SBkU0ofV0j1N8ifz
X-Google-Smtp-Source: AGHT+IG0nnL9ogS0pl6/D61qEgnidvhF+6cZZVmeF2+ocwra6H4vaRwkXGqdq/k3KCd5ICzpoZPQag==
X-Received: by 2002:a05:600c:b96:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-46fa9ebe245mr152016175e9.11.1760367208347;
        Mon, 13 Oct 2025 07:53:28 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:27 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/24] net: use zero value to restore rx_buf_len to default
Date: Mon, 13 Oct 2025 15:54:06 +0100
Message-ID: <271820dbf61d9de6f62440598a318926aa96f9cd.1760364551.git.asml.silence@gmail.com>
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

Distinguish between rx_buf_len being driver default vs user config.
Use 0 as a special value meaning "unset" or "restore driver default".
This will be necessary later on to configure it per-queue, but
the ability to restore defaults may be useful in itself.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 Documentation/networking/ethtool-netlink.rst              | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 3 +++
 include/linux/ethtool.h                                   | 1 +
 net/ethtool/rings.c                                       | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d96a6292f37b..41d4d81a86d1 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -983,7 +983,7 @@ threshold value, header and data will be split.
 ``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffers driver
 uses to receive packets. If the device uses different buffer pools for
 headers and payload (due to HDS, HW-GRO etc.) this setting must
-control the size of the payload buffers.
+control the size of the payload buffers. Setting to 0 restores driver default.
 
 CHANNELS_GET
 ============
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 19bcf52330d4..ada6244445da 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -397,6 +397,9 @@ static int otx2_set_ringparam(struct net_device *netdev,
 	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
 		return -EINVAL;
 
+	if (!rx_buf_len)
+		rx_buf_len = OTX2_DEFAULT_RBUF_LEN;
+
 	/* Hardware supports max size of 32k for a receive buffer
 	 * and 1536 is typical ethernet frame size.
 	 */
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 26ef5ffdc435..0e6023df3ee9 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -77,6 +77,7 @@ enum {
 /**
  * struct kernel_ethtool_ringparam - RX/TX ring configuration
  * @rx_buf_len: Current length of buffers on the rx ring.
+ *		Setting to 0 means reset to driver default.
  * @rx_buf_len_max: Max length of buffers on the rx ring.
  * @tcp_data_split: Scatter packet headers and data to separate buffers
  * @tx_push: The flag of tx push mode
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 5e872ceab5dd..628546a1827b 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -139,7 +139,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_RX_MINI]		= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_RX_JUMBO]		= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_TX]			= { .type = NLA_U32 },
-	[ETHTOOL_A_RINGS_RX_BUF_LEN]            = NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_RINGS_RX_BUF_LEN]            = { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_TCP_DATA_SPLIT]	=
 		NLA_POLICY_MAX(NLA_U8, ETHTOOL_TCP_DATA_SPLIT_ENABLED),
 	[ETHTOOL_A_RINGS_CQE_SIZE]		= NLA_POLICY_MIN(NLA_U32, 1),
-- 
2.49.0


