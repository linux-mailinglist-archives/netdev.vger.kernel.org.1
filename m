Return-Path: <netdev+bounces-228785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D00BD414A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEF3E5B76
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A037030F7FD;
	Mon, 13 Oct 2025 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfXa/LL9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4841A30BF75
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367214; cv=none; b=Ipcf65+hYkk24crMTXPYSglR75Rpy6C8g7ztfsMtv5LP5dxoZDdy8sZb9mEXTRrlfnaPA4CwIkomNNutBmTcblmsVDSBafoo1Y5sAIgDnjCAuJ7sJJjzMtBmPVpSV/NIfNxofDpd3SqeNZyA/HGnRGjGR+OhLBOa4QunWG0lIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367214; c=relaxed/simple;
	bh=+Yq4ejKTaKLjG6/YRDf0JOYouI+O/PnZAdPWT/9Qhhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSWJ43gkAOTw8NYqYq6T41R7oGCVpQGPHXX0i50cwMSunMfo4IKXQl7LbCVZ5H4f5In2AlC8Soae+mVOosqMIKCmqMokn29SIw0e+tu+fbhu9pDiBVX+05fTXIccv2FkyDQhkvhcFXJHhhhspkdndRR+QDbjUaXghQvSkZ/zACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfXa/LL9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3466769f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367210; x=1760972010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU2s6sLvAqme/ijuimTj+jjmuWN5wreusGBihnFUvPU=;
        b=UfXa/LL9yt+Ysw1wELrwsK0t6iKsy3t5IUCTAtjy9DKPeEQanGkLuJByICJfJiZRCo
         2Wl0lW72AvP8ho1HcN9Vh9JHkJEC/het3urWxISh4IBGSTI2zcl4uDokpum0E4gS+f6S
         rzKjJA0ZoNwMByGLXQsosTYoRpzxaDEu9+6EFUP7NhJ6QZpIMPouJpt0h36oOrWjjJc2
         mGWA+JtH+YR7SJWokCKiE0ZMpHPgQMlW19yf/Eppm+0Svg+S2t3IQHeSgDTDa0jcTk3W
         sYh82YaDhp5lLDSbjYC+O2Iz7tPfhod7oVo1LybgB7st4jk7r/J9i8Iroo5GUcs8HNzb
         ZXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367210; x=1760972010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU2s6sLvAqme/ijuimTj+jjmuWN5wreusGBihnFUvPU=;
        b=TpRhZpNS0Pls/p+OBo0Rqb2BfIpGRB5H4pG1uTDDVKKols8Z2ZaBW7Z7LIgsukGfb9
         iUJ0+SsHZgagyNZhrf/asTZ0njYiMvqjqN1zg4bS8ulI0D0HB+qelPtMiSHnxeeHr/zf
         67hPk2iLjgjX+W5jSjkSAZ1Cjvnew6YWS5f/ZdlaxV+OVDCRoNeFgGwQxl6dRcvvCAJb
         KKKO0XAmE0SXuizJzIg4+zBkZAUiiMgr9Juq66po/Z6lMx6eNJQbW+tR0mUBU41juent
         KoRJRPiMtcPPIkUhRmGvNTsdLP9vXOH8Pe6oDt4tZJHnfUyf+LGEnQxzQwnZ2jenWbdw
         sL2Q==
X-Gm-Message-State: AOJu0YzJm4cRP+AuAQUdZ1Vp04YZxW5Y6JrQntDSBkbfqPPeMSjq8QYZ
	SKMqnEN7gUY59lIFz7Rf0zcugYCpWYM8n5I2dOFLrob/54Gevec2B3PIEkQuPXhB
X-Gm-Gg: ASbGnctzkqLA6hz8t7YPxuGW7M+G113uMt6Fuu4Sz4dBYq6xvJMwX/+CPcbFKFmVCOJ
	2GmehmwMBMUD89riuKg5/gWf9hovhqc/quvrf8GSgUAoy1OhY8tor8Cu28vyPZJ4qDUroYXKhyC
	vEOklno5X14HwjFRTgFKXdAUojB3jNPAudTYgA+GqW0oPgnB/HPPg0SWdn+DDWAHFmcJXR2XbFv
	XmXRm/Al+MKMrnZJX2D2DlaCmrGpp414kKnBQNH1f1uZJwgBWLZJtF2TBcV0Nu6eaSg1vVuHOJ7
	isA+48S36vr5DLeNvIDeAVGHEL7TzYORzjgAMsij/wxAZ4+6VldDb8mYux3hPPWvfQdPo+pfWmv
	pVufnbYhLEwSxYvzNrsFR+e1w
X-Google-Smtp-Source: AGHT+IFXhn4holBktx1xsLQ9+wDO9MN5koElxro/9HDsZg+Lkdgx3g/gzvUUvtFHe8wBJMhvUCR6Yw==
X-Received: by 2002:a05:6000:400a:b0:408:5363:8266 with SMTP id ffacd0b85a97d-4266e7df744mr15794027f8f.44.1760367210172;
        Mon, 13 Oct 2025 07:53:30 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:29 -0700 (PDT)
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
Subject: [PATCH net-next v4 05/24] net: hns3: net: use zero to restore rx_buf_len to default
Date: Mon, 13 Oct 2025 15:54:07 +0100
Message-ID: <17130da451bba12995b3e0de4eeddef72de70235.1760364551.git.asml.silence@gmail.com>
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

As in previous commit, restore the default rx_buf_len value if the user
passes 0. Also initialise rx_buf_len_max.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index a5eefa28454c..3d3acc2b9402 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -10,6 +10,9 @@
 #include "hns3_enet.h"
 #include "hns3_ethtool.h"
 
+#define RX_BUF_LEN_2K 2048
+#define RX_BUF_LEN_4K 4096
+
 /* tqp related stats */
 #define HNS3_TQP_STAT(_string, _member)	{			\
 	.stats_string = _string,				\
@@ -684,6 +687,7 @@ static void hns3_get_ringparam(struct net_device *netdev,
 	param->tx_pending = priv->ring[0].desc_num;
 	param->rx_pending = priv->ring[rx_queue_index].desc_num;
 	kernel_param->rx_buf_len = priv->ring[rx_queue_index].buf_size;
+	kernel_param->rx_buf_len_max = RX_BUF_LEN_4K;
 	kernel_param->tx_push = test_bit(HNS3_NIC_STATE_TX_PUSH_ENABLE,
 					 &priv->state);
 }
@@ -1113,9 +1117,6 @@ static int hns3_check_ringparam(struct net_device *ndev,
 				struct ethtool_ringparam *param,
 				struct kernel_ethtool_ringparam *kernel_param)
 {
-#define RX_BUF_LEN_2K 2048
-#define RX_BUF_LEN_4K 4096
-
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 
 	if (hns3_nic_resetting(ndev) || !priv->ring) {
@@ -1127,6 +1128,9 @@ static int hns3_check_ringparam(struct net_device *ndev,
 	if (param->rx_mini_pending || param->rx_jumbo_pending)
 		return -EINVAL;
 
+	if (!kernel_param->rx_buf_len)
+		kernel_param->rx_buf_len = RX_BUF_LEN_2K;
+
 	if (kernel_param->rx_buf_len != RX_BUF_LEN_2K &&
 	    kernel_param->rx_buf_len != RX_BUF_LEN_4K) {
 		netdev_err(ndev, "Rx buf len only support 2048 and 4096\n");
-- 
2.49.0


