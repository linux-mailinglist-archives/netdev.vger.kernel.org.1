Return-Path: <netdev+bounces-228797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAAFBD3FFA
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64A544F71AA
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC9313264;
	Mon, 13 Oct 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYZdR/1B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8EB31283F
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367236; cv=none; b=UVCPhbfhnZnDKqsFLv4fJB9CV3+JVN4jGRQRKys7Oob1G+R3leFjuZbwriE2yrsHtfQGiz57aTJe1RJnFoRIegtqJvvf0k7TEFy8zdLXtcNKZwykkCUJw4rh9hyy1l81+uKrJugT2u3AkGTAoW0OGfgN+c5XPfuK4EsomG6qH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367236; c=relaxed/simple;
	bh=5njEvVGvRvg5n+or8A0T0TeMIvuwdSGOGUYTMwZoZrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6MXeUh0N8HJCYlQK2Ba3v0OLdTkwxTzhVulRVmZ6LWQ1tHE1njlek7UjXPjDZNUUym/Z+oi8ci0BD59T/gA1UoUFkl+ObP51RUVH9OshYy4hnSpcLU8Rl6H8VmnNEEa8hI0IEamsKF1eAlSNM85shByMsPmN+SCoodxztwX+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYZdR/1B; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso31765595e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367232; x=1760972032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx3rKwv8UpZmKoPpNp8c4OWFyXZ2MQ9zKc0xRf7JTbY=;
        b=bYZdR/1B6EnR21UtQM02QdZ/SlZlUnJJ4HgKFePQdxI8Eh4Vz5mxonv4tvx8GlyEfe
         QNFqDE0Hof7aL+0Jg3oW3H6WPiUMPKaN8cIc8NGDQBpMgAvthmHzN1euRS2nEHuxbeFz
         ueQfYEXZB+DIC4i7aXyx3HfYzKhQAyj8QCqpqhoHSVAeEet06Gm6WL/yARIQ7D2syVcm
         eYIzEEyZrR4F76VxwW1m3QECHx4dITHvTH/Ipc4uu4tzrxtm/vbGe+Z5rwD8hpVkaSKP
         XZYn9xO45FjKRQMDpCUtRS7PZjJVtGsSXz1bVqCy/mxVcAhFrxuhShn6pd50eloLt5bv
         eM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367232; x=1760972032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx3rKwv8UpZmKoPpNp8c4OWFyXZ2MQ9zKc0xRf7JTbY=;
        b=v1mehQOOml73+bC2tnBMLFco2w/ZfMFRGMF3RkINmMMc/VJzwwMIJBhUse2k/iaRrV
         7DY5S+ghvERbTXp43mHq7lL2HzEbQs/y7WkTavWHxjnIvADxoRq/vABswMTtkLLZuMNz
         HOhvkJPslCgrMGWGU0B1XAUELAHyHnb/WtGVpyxNmyJbNJUB7V12oEz1L3qXpurnc1bS
         hO9GDeC1hbwd42Xw2TfOl6frYpuO7KE4d2Yl68jh6tp+ka65gI4J09TwIYNqc2xVj7ES
         cx3dfrgAjbiMjeQ6hK9wYqeYT/r4WRWNUPsTCwbu4Aw3aKwOfEbTtfiSvI6iwAmo2Fpt
         krKA==
X-Gm-Message-State: AOJu0YyOJ2gho/+oBTI8rAXhwv31X10sUNB0zK0e0RGkGB6cjUZkCVEL
	FxTUkMm2VxDGwCVmV6KfRmZEMiC3tQK6NP8kqX3HXPnV4CMxQVJLUsIj52j7Gmv3
X-Gm-Gg: ASbGncsv9TTXmxN1kKxhqO29/58d6l2E5mBUZ3IG9u5jDKbQh/EkqUsZ77vFggBZ5+f
	6WoIlYC7Z40bIFeCJhWvPLG69+1Dd7qD6iILgCfnsPQLrsHk28Y44NRtyTfSBq3sQigKfm1g3YW
	V1jZgLBXPEuxqmfxjjIzPiqX4MBwkyu47RZyqotnYxSWMh9/lBv6eVgxLaxTCIgjcIao6QONlCG
	NSv0dc+m6hck8RAdPecNB7qypoI2x3/mXY9O9YO6wMWbgUL6z2fEBQVPGFcNZbHFL6V7nlIkGm4
	9oEVRusCks9bMFl3T4sck02FBgUWPwBQUYaZewNWTa2Z+ai7oR/nY7YMUCfjXtiMl/FTfZSefVj
	1orepz1/2uQOIRIoCDsFSrF5Gah2mDr6Tm38=
X-Google-Smtp-Source: AGHT+IE3H2i/VyBQ+RSV0mjlmorIJH69FGvZYgt2TChv0GqkPZvFJ5kiUJWgTBqn/GwNWnmRiH+YrQ==
X-Received: by 2002:a05:600c:2287:b0:45d:d86b:b386 with SMTP id 5b1f17b1804b1-46fa29f13dfmr128925175e9.14.1760367231769;
        Mon, 13 Oct 2025 07:53:51 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:50 -0700 (PDT)
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
Subject: [PATCH net-next v4 16/24] eth: bnxt: always set the queue mgmt ops
Date: Mon, 13 Oct 2025 15:54:18 +0100
Message-ID: <a91c4a947563f305f284d54a7bb127c10016275f.1760364551.git.asml.silence@gmail.com>
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

Core provides a centralized callback for validating per-queue settings
but the callback is part of the queue management ops. Having the ops
conditionally set complicates the parts of the driver which could
otherwise lean on the core to feed it the correct settings.

Always set the queue ops, but provide no restart-related callbacks if
queue ops are not supported by the device. This should maintain current
behavior, the check in netdev_rx_queue_restart() looks both at op struct
and individual ops.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: reflow mgmt ops assignment]
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 61e5c866d946..bd06171cc86c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16187,6 +16187,9 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_stop		= bnxt_queue_stop,
 };
 
+static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
+};
+
 static void bnxt_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -16840,6 +16843,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
 		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
+
+	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	dev->request_ops_lock = true;
-- 
2.49.0


