Return-Path: <netdev+bounces-152420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C68D9F3E72
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 00:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0D21679A2
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85431D90A9;
	Mon, 16 Dec 2024 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nINK7j5P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8342A9B;
	Mon, 16 Dec 2024 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392966; cv=none; b=COZTcGVw7+EcaAT9C+JHRVbvPp/zJ5yibVaRFeH2Q4F21UK2/oBDX5JSM/UT3BlPlMM3LHXtgkE2vuV9fXol3Spe8BlHxnlvj1ABeKP13ovq0MV1DLejRTEc9ZsVIB4MFgLl62E/U6QFyhL1wikpq8b2NhjkOWD4WTk4dsDN3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392966; c=relaxed/simple;
	bh=L+iq21VNjCG+P2uvEmoH86300hgdxFjXns0/uc32kRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSTzLwj8N8iYLS4Eps9K8f5grdCNVbQlAI0iF9wwNU6aeemHvmzjb/LY8AA0slIissngxtgJiItkb10bgLsRvrzOny3JV0Ei9OWFU/g+WO0R61QfJjzUoHKqnmOMn2iXH/q6J5UW42xb6qfa1P099a7PTyULjeia9wF5QiPAbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nINK7j5P; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728ec840a8aso4975966b3a.0;
        Mon, 16 Dec 2024 15:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734392964; x=1734997764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ix4Gh4iwbkjJuB3qgl+mlNRzP8fScSG0OnzqHfqlJNE=;
        b=nINK7j5PC8K91qnz998bW7fPD6jVK+XrYI+Y+mm9xlllO5aMCBe25u6Y1VbQEEk6sf
         8atvdskDZZpctL/elv+dC93sJeqej2z/exjxq9lsx7QB1ylGPeJQxMqVxqJ/fYhUCVrj
         i1rpkmLEWALj7rJ51f4e9w0FI2tRlF077wGSUL2UJEBPVS0OJg/IlwB/zxVAHxeFjL+f
         ROnoqTcceRX+LN4MMQryDPrUWFO2jo7DlHV1Vehnvjn38CZtHzXd5/n6WODf++CeAs1l
         rlNMdqSAgrEi/RHU1jA0Yi78sxmo8/cEqJzcrHuONjFXhwN0Ss0Rpr3keLkI0D/jfJEo
         kt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734392964; x=1734997764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ix4Gh4iwbkjJuB3qgl+mlNRzP8fScSG0OnzqHfqlJNE=;
        b=tYfefp1h9yp+oS5Ck1NcW/e8YXqy8pgJdSNnX/R9MOtsZiYDpv/1pT5cmOcJKyl/Lw
         ZKeMqmMNx7/n815+X82aJhqSlvXAQCZDr7YLVVCJPcm41BzG6XBdUdpkTslfJyV3+Tiy
         95ZlBm6pxdyq6k8qVZZCXNRuTvtINr2UiZMzODFVgN46DpFwj1St2UawKV8H8/Vi8lfs
         vP/Fuw2o6DVogTcRxxAXELtRW6FYrENpNvbOm9TDed5+ys6HZLQiK8T7CN+6oJJptlIu
         DCNJdUbjYXvP/+5skEHWrAvIGOqhy5l39dL7HUMMVd6amRQ+kvp6wkO8+EmPCHluAJH1
         QG6g==
X-Forwarded-Encrypted: i=1; AJvYcCV7fpjSOg2fVvTYEOhk4B/w0SM00jRthEaA2AbOiwQRK7pFffbMWapIAnqSo3cdH+Bc9gql0+E4PezSVtc=@vger.kernel.org, AJvYcCXr9n4vgrMSRQBI3HF9vghfea4v9KpiHeyi79AmEPAZYgnrYO80mFfs6pXyTfjRhWTCOZ2gQ6/c@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUQXaKL363ELzx7HyrkvxIgLqF/BunI4q1+/AdTuSUDr1Xufc
	ejDsRZ+0qpyAf8002sBay1VDRuvwIuVRxgfp4BpzJX7eK+UpZQTa
X-Gm-Gg: ASbGncvpZkSEcUndZiV3IwazpLqybItXZHf8PXxcEUPsbsor2DVYj5m9alMpz9PI4tO
	VNvIiM9hYOnMkAm9tewVzD/jo4YNP0USRrOqahl+LegB+xqGqhwvOIdaaIWK1IGoFOj6UlUGLjE
	JTPHY2/ago55b/cBFIp40lNPiBG04GX4vawRO3xJ6H0idxF6mNaeAJSdh5kgtiscgXknTq69xEc
	WQ97rDuPC/bJ4x4aLwu9s78S3vx1EitUYYXwdCrFTpHy4vViuP1AG6K4K4abJp9kWm8F4ql5WA+
	g85yA0T05WmW
X-Google-Smtp-Source: AGHT+IGYMsnP5MYv4KoMNICzCXEjaaJx+QNzdrxPI66r0iStuH91FO6jk7p9jIJ0eN870nmzQlLqXA==
X-Received: by 2002:a05:6a20:734b:b0:1e1:bef7:af57 with SMTP id adf61e73a8af0-1e1dfd70b1cmr23634726637.21.1734392964480;
        Mon, 16 Dec 2024 15:49:24 -0800 (PST)
Received: from jmaxwell-thinkpadp1gen4i.rmtau.csb ([125.254.29.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c3297asm4657901a12.70.2024.12.16.15.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:49:24 -0800 (PST)
From: Jon Maxwell <jmaxwell37@gmail.com>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jmaxwell37@gmail.com
Subject: [net-next] ice: expose non_eop_descs to ethtool
Date: Tue, 17 Dec 2024 10:48:50 +1100
Message-ID: <20241216234850.494198-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ixgbe driver exposes non_eop_descs to ethtool. Do the same for ice.

With this patch:

ethtool -S ens2f0np0 | grep non_eop_descs
     non_eop_descs: 956719320

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2f5d6f974185..8ff94400864e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -345,6 +345,7 @@ struct ice_vsi {
 	u32 rx_buf_failed;
 	u32 rx_page_failed;
 	u16 num_q_vectors;
+	u64 non_eop_descs;
 	/* tell if only dynamic irq allocation is allowed */
 	bool irq_dyn_alloc;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3072634bf049..e85b664fa647 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -65,6 +65,7 @@ static const struct ice_stats ice_gstrings_vsi_stats[] = {
 	ICE_VSI_STAT("tx_linearize", tx_linearize),
 	ICE_VSI_STAT("tx_busy", tx_busy),
 	ICE_VSI_STAT("tx_restart", tx_restart),
+	ICE_VSI_STAT("non_eop_descs", non_eop_descs),
 };
 
 enum ice_ethtool_test_id {
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0ab35607e5d5..948c38c0770b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6896,6 +6896,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 	vsi->tx_linearize = 0;
 	vsi->rx_buf_failed = 0;
 	vsi->rx_page_failed = 0;
+	vsi->non_eop_descs = 0;
 
 	rcu_read_lock();
 
@@ -6916,6 +6917,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 		vsi_stats->rx_bytes += bytes;
 		vsi->rx_buf_failed += ring_stats->rx_stats.alloc_buf_failed;
 		vsi->rx_page_failed += ring_stats->rx_stats.alloc_page_failed;
+		vsi->non_eop_descs += ring_stats->rx_stats.non_eop_descs;
 	}
 
 	/* update XDP Tx rings counters */
-- 
2.47.1


