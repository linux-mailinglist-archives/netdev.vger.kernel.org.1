Return-Path: <netdev+bounces-144505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18989C7A04
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918EF286D82
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B543202F66;
	Wed, 13 Nov 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z23cE10e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD3201262;
	Wed, 13 Nov 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519213; cv=none; b=H15HKBGf1XghPQU+P8goRXeuDQX0PcDm97Qf/64FpUeFmonQY8MulP1EpOcG/dUKTTlV8dT8GUoRF1lckcydfrBcLnC9i5JliG+9TF/kO/NIC+U8yHpbXbmYHzKD/gSUDl1M47UEy3K0q8rJOtyJnzzKtxjV5Ke52KjwlMyRuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519213; c=relaxed/simple;
	bh=KY5nGQ1sAVQr0Mkg7C/TwvPl2QkKuJt5o7PKF8OQLTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LflH2j4RsNke3ajVCuBPDL2mba0HMCKWKzGthAv1UzP5xeWk/mX1Xn8KAo7ekoh/4lF3cmKK+Wi+oa4EVFRR4/H3ftQo+t9ubNBvhp8C4uYD9WJMyuNY0m3uraDn1+jjGncAvhFL8qzjCp66HFrEBZpN0lIXtxG5reTdWW8/Wws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z23cE10e; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c7edf2872so8455725ad.1;
        Wed, 13 Nov 2024 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519212; x=1732124012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJlRBJcEwuvQhT4VeRCSmuKVjYnGZXZ9h57evQsgFog=;
        b=Z23cE10eEQjryEyWEqYIMBnKei6cO290c7X5/w/1QG4Dm90O2Q99Erh8yIAkVQoOAH
         d9XlwLiHaQbzUvxKTFmB235LGDWKb1F9p9me9RZIIJ4bxmPNpeQ+blwIC/H6MRtjwUmL
         A/178+atd6dI7XT4d7gvF5IreXS4jlyjjk4hgOXI8e0v54Ugk3kfM++FmkccdGN7pPWI
         cfV/gP7twdJFvRkr8CzDYz93ZckYBq8hJmYvuVtwAq60UnOTINnFxy4BejogYrTyEwNe
         fqll0eCB40CpXBZpjQRlO1jPxVDQw592/r3ACwZ9VQ8S0ZUYXOvuQzyly2KXhk71btCy
         mwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519212; x=1732124012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJlRBJcEwuvQhT4VeRCSmuKVjYnGZXZ9h57evQsgFog=;
        b=TiZCCCpaawxxyVOSVT+V/7pkszlZyybEceOL2iLacnFZgbflO82/5n3waOyNRZABCS
         XdNTvvw420roKJSlbySO1H0QBzQ/SWHPn9JiDXcDg73PWqshoLzJRODdELMFVFdBV2T2
         xKC9+KQbRWs6V28ohYNrNOGprmUEd4uR6IUh//wxvYVsGQ7ygAj8j9WuoGZNk2iFQ3eY
         sooTo4RO7KYMKbdVC0pm0Vh6dvJeRsmwhqTub6635oDuAoc/KA4vNeBMijgF3euTOPhj
         EpJl9c/VCQL0EhsW9tFO5ojc58qPg3bO7bXMYveBdg+y06iAtezr9U90Gc2S+ewoE6Dy
         ohYw==
X-Forwarded-Encrypted: i=1; AJvYcCW1BOiJcZttm4br/GeCy9Zxj176zMr/vXEyJCIPiD5FP9LIuyMEhS9ozgk5aunTPyyY8M0CXpkS@vger.kernel.org, AJvYcCXLdyFrVk4Uk4sCHs7HR1YwnLISFIcQ2SqS9STB9VW0WCuGaBziEXEdg4Bnkzt4if3XGebvJ7g0nCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDvak+s+FhQle08PkZUPnv5LI/vysPgShHbe/+lXmWvOx5m5n
	PQaXtfDfzvmIvSBkt9iRdpUGALRGdyfyXMNkR62kBqL9EgL7KEEy3OW2wUfH
X-Google-Smtp-Source: AGHT+IFU7UFJttX+KcE1oTziNc1qZYNE+s3S6bAIjvB4oNoLvLtEpLVN5RPTmcWc7kAdxo+cVTXAfQ==
X-Received: by 2002:a17:902:ce86:b0:20c:cd01:79ae with SMTP id d9443c01a7336-211c0fc12a4mr2331485ad.24.1731519211658;
        Wed, 13 Nov 2024 09:33:31 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7df5sm113140765ad.19.2024.11.13.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:33:30 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v5 6/7] net: devmem: add ring parameter filtering
Date: Wed, 13 Nov 2024 17:32:20 +0000
Message-Id: <20241113173222.372128-7-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113173222.372128-1-ap420073@gmail.com>
References: <20241113173222.372128-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If driver doesn't support ring parameter or tcp-data-split configuration
is not sufficient, the devmem should not be set up.
Before setup the devmem, tcp-data-split should be ON and
header-data-split-thresh value should be 0.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v5:
 - Add Review tag from Mina.

v4:
 - Check condition before __netif_get_rx_queue().
 - Separate condition check.
 - Add Test tag from Stanislav.

v3:
 - Patch added.

 net/core/devmem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..3425e872e87a 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -8,6 +8,8 @@
  */
 
 #include <linux/dma-buf.h>
+#include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/genalloc.h>
 #include <linux/mm.h>
 #include <linux/netdevice.h>
@@ -131,6 +133,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack)
 {
+	struct kernel_ethtool_ringparam kernel_ringparam = {};
+	struct ethtool_ringparam ringparam = {};
 	struct netdev_rx_queue *rxq;
 	u32 xa_idx;
 	int err;
@@ -140,6 +144,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return -ERANGE;
 	}
 
+	if (!dev->ethtool_ops->get_ringparam)
+		return -EOPNOTSUPP;
+
+	dev->ethtool_ops->get_ringparam(dev, &ringparam, &kernel_ringparam,
+					extack);
+	if (kernel_ringparam.tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
+		return -EINVAL;
+	}
+	if (kernel_ringparam.hds_thresh) {
+		NL_SET_ERR_MSG(extack, "header-data-split-thresh is not zero");
+		return -EINVAL;
+	}
+
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	if (rxq->mp_params.mp_priv) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
-- 
2.34.1


