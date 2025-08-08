Return-Path: <netdev+bounces-212197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC3B1EAC1
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E19C3ABBB0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30E3283CBF;
	Fri,  8 Aug 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYgh8cEn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D89283153;
	Fri,  8 Aug 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664819; cv=none; b=XTUfuvLiwMQO+ZuiSt/ahDtqyqVN2oJcUK1e4qznphzAtOrhS9XmnHjCZzmE9Uq8CmjgxT0RAJAnEYXsgF8/Y/IUSYFbzuJuXe7PrV6kxT3Cpd3P7uaiyJvXSHW8L7kFkfXByRpRtlwo9cAnsuE7x9zan0woY10s2m9yYDOdp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664819; c=relaxed/simple;
	bh=pQVryzCrqKahWsbuvWHxrlarAv7fIySFGod7Nm4agT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/Vp/GYaSMU1HJ+MB0C8iSTrlJTohq1Pu8xmhrwl4Z1C80Wbg3HbkagFF1xb5hn5C4UXGmi81FTHczBKQ/ri560rRtmOcylcOkg8Sw4vjlKqMXzYJoDRW3xgy97/tfq2wDHOKh8rVyWRHWP7MVjTqzzdznGTdFUMvhlCU/VeOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYgh8cEn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso13876345e9.1;
        Fri, 08 Aug 2025 07:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664816; x=1755269616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wvt1QlZQQO31LYe7Ap6eWwat4ky5qPqLAGE0m10UM/8=;
        b=JYgh8cEn5vmbziMZ6hKei/T6sLHFQGEBqNUCRawPOZqsz7fSx5d+ahHyZWWHBKhbGY
         oxPnc0bojLe9n/ISJc0FAVVNNzyK3Az5D/zemWDa3B3LBOp0o90nysneg5k8JbcDoNuk
         ZfdGzluUMCxKgaHGPokv/vWzhSvGEYsB6SATV51ne6qNrwrQLF6P1F+mnyrGEz3iaMlj
         LfpePTk9af9cX5CG1ECzc4NoBIjHEcSqcz5GcrRH6uDZ2RdwbHGRgzX7z2Lx5vlqCp76
         NhNRtZAfQVrPvLmnZOe5CpvAZolhAB6rI3nuvmMczfjfLT1aXMSOdDSqoxSeI34NMTtm
         8U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664816; x=1755269616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wvt1QlZQQO31LYe7Ap6eWwat4ky5qPqLAGE0m10UM/8=;
        b=NIBXfGVIKziMx1fPBus5X1ZQs+U94gg51zn1tugR8rpmXjOEVkr+BnOwMGseH8Kse3
         FfauL2129K6m2Iu8d5mpnOh6jKf9RVVD4BvXKxLCWzRaJF/0fa3qhYz6eGTszxcVUnl/
         uV2KmKIjWN5binBnw1h6fZaNjmJEo27zdOJETjAp2e6mdCqvh//2KKJsPAAapLGxZLMu
         jZECHda93q6kfZNM54iHFd9ZpAn8W4TuBsNxhSE+nfZYsN4yj8qfbzdAVu6ulUmgwbqU
         4NVYVCwb7+oKJIx4Sev6F3uEwUJokxwHWvm8ISDw/HGZZ/nu5hXLxhjRwk4kIUhjQZy/
         se1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpHD4CEw4+ka3Ds0AZt/Hh3dMD1v0rdQy7iijxlbB1dBKFNMwWHxIpoKlKJC7+AcEK8fdMuGsRmEMvtsw=@vger.kernel.org, AJvYcCWrgtquWXVPtJSePTkFzaPXWhhbXLXlrGWGO09qLPtDUddyxF+H1jsRMETlug8Maw4Y+XduDXTV@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwpIuecv65+kz/H0/PoJvHYa7uK06kl4c+3+yfESHdO4GjAOu
	HhTmknrtfLfbR/EUnw+bT4/93Dx0l1Lmv/J/35yz+0MVLkD+IxpMu3rB
X-Gm-Gg: ASbGncucFqG8WlJ+UIAHMZcGNEJUUdqUxG2H4wpes5xGP+/tij/Fj2e27vnHqwDU4Lv
	s6VjhjDDxHfjk8TOnXc5czaWSd9iHSOV8pJ1o9dv2VMygYi3Yd/DVjkY7d1/4SHT7TbqxCiRXkw
	LbFn8iwuABe5hPpwpCYTJPzwkcxHXwldNk8RDX3UNpuWA1uXCyLJrPQGzXJ+lUb54fK5bbGN2kE
	h7UwcVnXZSlx5edIIPkVYDESFjm9RZCFdl4sxPfZWrZB3E77S7FNq5YtZmjk3S4+cAtTnUZYSEz
	oCEzW08g7aI14PtwekMHAPAtm7LUUgTxcY+p2U9+8I3Q+2vPMg8qjV3XgxHM7Ua3QNirk5JjOCF
	oIlaYZg==
X-Google-Smtp-Source: AGHT+IGnsotUMAXWQ9z6oBZguViBC9JRi+3dpda3wxbyXEJhPhYZPfjIhazyp7c+hU+dVoUHxploFQ==
X-Received: by 2002:a05:600c:1c16:b0:459:d780:3602 with SMTP id 5b1f17b1804b1-459fa492ef8mr10650795e9.23.1754664816216;
        Fri, 08 Aug 2025 07:53:36 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:35 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 04/24] net: use zero value to restore rx_buf_len to default
Date: Fri,  8 Aug 2025 15:54:27 +0100
Message-ID: <c03609a83c8e9477f41fa7235dc25f255ee8f613.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
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
index 05a7f6b3f945..83c6ac72549b 100644
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
index 1c8a7ee2e459..1d120b7825de 100644
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
index 9267bac16195..e65f04a64266 100644
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


