Return-Path: <netdev+bounces-228782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D54BD3D2F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFE9188487E
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5730BB82;
	Mon, 13 Oct 2025 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/KBSFmk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973F30B506
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367208; cv=none; b=GnPTDNImvhQCei1jbLyt6mqh9Ut8EY7XRlyD2KiuGm/EXLRBXOA1DMwopv4xz7rrKT7L96FPE64uvBK2stmuN0obz+goN6OkinGH4s8GSb8woQUGu34mlhDhHcPHxj1/bhMakJ1xSZMDdKOQ4KnKUav5sAWBpjREcu0E1pQDUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367208; c=relaxed/simple;
	bh=w+9GYnLfpJPuENZN1hq4bylmO2y99fnzpTWEsZZvlXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZx1zjiUpHg5nsCNJNv+ukA24I4A0OXvUC54Vkg2DycyHPNvWaTyYAXjFzC0qb1rtEA6US4KGmHBvx0oxyt25lOvMhonHDOspsj/ZpUaZOJ4qkf3N14bVkVCIL5Tzq133SPhH/JrpJocLlCjhaPkuLZt9FHP0GkBIJPylHLIwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/KBSFmk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso2854537f8f.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367204; x=1760972004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Intn0C5yI8uAf2z3e0yNoFGVnV8Ruh2Zw9BITbwKtgg=;
        b=I/KBSFmkr823VYLJ9wwtqrnu7+aTcICtjpZOfR/GQ5E1yCUygyix9jp0J76TMiY+C5
         yZd+9yDEdAH3g2i48cCgrqHH07RL2OdfWlSTn1ph8SQc6pOXb0XlHAaPIl/iuSFzDkFI
         cP1sJvjmu7Lx/8FAkkh4d4aQtIJck7g1rH7T6IAQxb7/fw+t/UgWDLULE8p80tOzf/QL
         nqZgWYDkJSrFZS4Q08d96Br4TJmIg3xi6HeuazjSD5K7g/NYlK626UE1X8NyF326HTyb
         qTSolPWPXrGexUR0pupc0I9yObjTg5bpRzqQ1/3YV9P7pAMQvu7uDAEdBSm6VALAyfZS
         crkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367204; x=1760972004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Intn0C5yI8uAf2z3e0yNoFGVnV8Ruh2Zw9BITbwKtgg=;
        b=JyrqWP1Imu16X1cfCIF4LgI48rNeaUZ7/L2+2vMcNXH3I9aZCEqJ8T9yyGQT43JrEd
         7c6HKqzXmL5O1wt3u7TpUGSpseUIeTM0VzUigqI36X3E4qL7865j72yQM4c8z/s/AMXt
         CgkcHIyMWuuUgokD7ODNLSytKUlxWFa2sZZzvyDc0dqMQCUT7fEr3dnu5FKKvCKtkKVa
         k3KPxVQesWxfwYGCAmk6Y58Y5VC7Rgy042GvtOUw4frekeG/LpdEGMcFvJSgeWbZLXFx
         6zac5Q09eXRTZSfRpt+xHMtV5kstdNzgbP6NXklTOQBLAMJUaotKHLKUs7LDTyOBw2OY
         zuig==
X-Gm-Message-State: AOJu0YwvfdoUsBMh1lTZSZX7vhZOXgrhKq6jw9YAOjZczGDsfINhHOrA
	3GPO5koAVx/v7TwigJu6Ig2hi4NCibU8Yk31h9lB/laDvMWu5Wm8+JpY1SiUevCm
X-Gm-Gg: ASbGncv/VskWHsOH7g0/ArscQBFCPE/m3oN/H9Ytd9LXbqJA2nlYXHAiIkfoXMQ8WNf
	mVPXVJXqr+7qiipiOx57ooJM4oTyjhfygrMxLzeT2o1dBtcVYq3hG1LVj/7Ul3I2BgW9AyIXXhb
	C181nU3qbR7gdW8vDeT4vAtwAaGgOklVCDkQLnFzWpOzM96/l8rZJqyaGh45EkS+BxIbthTTTgq
	Ld0y4f4Xfo7JC4Grd3LhxR+expJ3LZrLIVo9/0b0a+MB9/kA0AVE04S1SWA1xGs8g+nl+qRikvd
	qyF0VVLr+YzKTNCaYDHEsycWmn9uDGjo+LxHkEa3FrY6874WK+9f2uj/YCy3MkXzcw+chyaDHzs
	FYLzYdqgwJqcPrYTTg5F1ilwp786kSMvx8+mLWUmnDgMnMw==
X-Google-Smtp-Source: AGHT+IGM5o9+wFkfIja0oLP61fEHz91/0NGcuhmPQVULbrd0ZLVSDTzb9zJ9+EqpQiODyKQcWi27WA==
X-Received: by 2002:a05:6000:1863:b0:3f6:9c5a:e1ff with SMTP id ffacd0b85a97d-4266e7dfda8mr14321226f8f.39.1760367204244;
        Mon, 13 Oct 2025 07:53:24 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:23 -0700 (PDT)
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
Subject: [PATCH net-next v4 02/24] docs: ethtool: document that rx_buf_len must control payload lengths
Date: Mon, 13 Oct 2025 15:54:04 +0100
Message-ID: <e685eeccc2a46d8ebfde77209e505a77d14f7e8a.1760364551.git.asml.silence@gmail.com>
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

Document the semantics of the rx_buf_len ethtool ring param.
Clarify its meaning in case of HDS, where driver may have
two separate buffer pools.

The various zero-copy TCP Rx schemes suffer from memory management
overhead. Specifically applications aren't too impressed with the
number of 4kB buffers they have to juggle. Zero-copy TCP makes most
sense with larger memory transfers so using 16kB or 32kB buffers
(with the help of HW-GRO) feels more natural.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 Documentation/networking/ethtool-netlink.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b270886c5f5d..392a359a9cab 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -966,7 +966,6 @@ Kernel checks that requested ring sizes do not exceed limits reported by
 driver. Driver may impose additional constraints and may not support all
 attributes.
 
-
 ``ETHTOOL_A_RINGS_CQE_SIZE`` specifies the completion queue event size.
 Completion queue events (CQE) are the events posted by NIC to indicate the
 completion status of a packet when the packet is sent (like send success or
@@ -980,6 +979,11 @@ completion queue size can be adjusted in the driver if CQE size is modified.
 header / data split feature. If a received packet size is larger than this
 threshold value, header and data will be split.
 
+``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffers driver
+uses to receive packets. If the device uses different buffer pools for
+headers and payload (due to HDS, HW-GRO etc.) this setting must
+control the size of the payload buffers.
+
 CHANNELS_GET
 ============
 
-- 
2.49.0


