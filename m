Return-Path: <netdev+bounces-144501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372269C79FF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE26285F0C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4801202F6B;
	Wed, 13 Nov 2024 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5d40fCF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A93201106;
	Wed, 13 Nov 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519178; cv=none; b=pyfLezegWLahJ/YJeL+j5eeNTVYaOb/idPiAq7nNV3jwJ0I+pYAVjz+6dtba4AsL04bjZJJlIJbHk+pzSTS4XUU7ThZ3M57mr0PBoELLjdue6YxApISJnmi85KgpazK3Vrew6l2R6L4Z0NHY1CltmXgkAiN4CGH4RYFRuKeb4ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519178; c=relaxed/simple;
	bh=LIBqxl0cUzUkK45JDAK+pEBJcNtYbi70BkxQP33QF+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUhNrMsHqQVoqJGC1BdOjgxIQw57t6YZgDt4tUW/mwofkBW3+fBVR8EUIVAe/1fDZGFQdb7qH1Gl+x9hhiFbCP4g8LCNEt++4yfxR1zyrKGim0BgTRee2v6pQL/3FP4j9cUebvRUXlzMhNt5+yjOkIufAYRuMgriL/lPgIf7owg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5d40fCF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso5725643a91.3;
        Wed, 13 Nov 2024 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519177; x=1732123977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3V5AK3oPRQdRZx+J39SvU4EAiowmHP3Xjjl1jyOkUHg=;
        b=N5d40fCFiHIixHxJYZ9GFbs2GaBX3dhgk+vZ8PB4sVrLq6qD9h20B5mCxDBlkh2Gyw
         XjugRU+c1DvRGzpSYoHZFPckngoPDd9a6K3DdKh74Za+C5Chop1Z/An/XnzrHWWjLP56
         i/AzrkC4AocE8tjpt8hBchpR6vb1bkNM6t/56MEkPA9BIiHZRlA1FhvXSjWXDCpHX6Sw
         xWuPR3xia/KI4jbDjYx+6nlMSanb/vaM0bhC+L6W6/tehmGddOMOEQaRAC6MNqGjjNzq
         igWi8+MA3kh0y5YXVq88WdF+LqGMpQ6ue+qsQ+S+wEBOhwPV+LCKEeAq4PEjIBEm8psJ
         aa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519177; x=1732123977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3V5AK3oPRQdRZx+J39SvU4EAiowmHP3Xjjl1jyOkUHg=;
        b=Qaq4j7u227fmt+VpGy6CRQl+uqV7pr28cNM2ZsNS6D1dit6pgaR6xLD1Iir3iTmodU
         aG9mwmvz/9k+j8RwFWoRci34PTKaJpoKmDmTPgSdCgQ+8rRTq6Pry5IleqBAcUdP0O5h
         XKry4V6T+bTAms9yIpUsNTGCcQQM9XnxSao9d8OAnGJvOEIYpu7jsbF9If0jTiY8RM2t
         KDlD3t/b5EDR5gzHJqbOyfPjEhQkvLt0sr7C12JZ7AM8IfxDXg7Uo+LAC+DFkX/PkROH
         HOvdYxt1kXBUXtj49deSc3NcKViuRWo9CJjDffLgplkbryHCBtPepvDf3CTX8a4NWdn7
         KXSw==
X-Forwarded-Encrypted: i=1; AJvYcCUwxa/nSKS5toQe/cdnA70tiuhjFQAaZ8cTyejIbOptMHDKFarac4w8BO1Gz7H2zf3TSBN0egL+@vger.kernel.org, AJvYcCWyjDGxp20U1CWj4CagFFm3op3w3ccgy9d4oJqUo58lT9sp4H2VcfEtpEQyWQA7PRwmMO9sqnGNHRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJlJYhgOn9BIp9CYzewikQFvUcVOsMJfZ3YDtiuMYBUxZjJ5U
	YdwzO7/ZGdGPOG+uXxYt5o+dr+QRd3KqYHpmbXAvOJT+fg6hk4WG
X-Google-Smtp-Source: AGHT+IFSmaX/lqM8HWQiF6G2OyTpADXe8d4MIiHktHv139OCBnOj4o2G4b9pEdV/8nvX5AnWRzU3KQ==
X-Received: by 2002:a17:90b:1a8c:b0:2c9:b72:7a1f with SMTP id 98e67ed59e1d1-2e9b1773966mr28069105a91.28.1731519176541;
        Wed, 13 Nov 2024 09:32:56 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7df5sm113140765ad.19.2024.11.13.09.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:32:55 -0800 (PST)
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
Subject: [PATCH net-next v5 2/7] net: ethtool: add tcp_data_split_mod member in kernel_ethtool_ringparam
Date: Wed, 13 Nov 2024 17:32:16 +0000
Message-Id: <20241113173222.372128-3-ap420073@gmail.com>
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

When tcp-data-split is UNKNOWN mode, drivers arbitrarily handle it.
For example, bnxt_en driver automatically enables if at least one of
LRO/GRO/JUMBO is enabled.
If tcp-data-split is UNKNOWN and LRO is enabled, a driver returns
ENABLES of tcp-data-split, not UNKNOWN.
So, `ethtool -g eth0` shows tcp-data-split is enabled.

The problem is in the setting situation.
In the ethnl_set_rings(), it first calls get_ringparam() to get the
current driver's config.
At that moment, if driver's tcp-data-split config is UNKNOWN, it returns
ENABLE if LRO/GRO/JUMBO is enabled.
Then, it sets values from the user and driver's current config to
kernel_ethtool_ringparam.
Last it calls .set_ringparam().
The driver, especially bnxt_en driver receives
ETHTOOL_TCP_DATA_SPLIT_ENABLED.
But it can't distinguish whether it is set by the user or just the
current config.

The new tcp_data_split_mod member indicates the tcp-data-split value is
explicitly set by the user.
So the driver can handle ETHTOOL_TCP_DATA_SPLIT_ENABLED properly.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v5:
 - Patch added.

 include/linux/ethtool.h | 2 ++
 net/ethtool/rings.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 1199e308c8dd..ecd52b99a63a 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -73,6 +73,7 @@ enum {
  * struct kernel_ethtool_ringparam - RX/TX ring configuration
  * @rx_buf_len: Current length of buffers on the rx ring.
  * @tcp_data_split: Scatter packet headers and data to separate buffers
+ * @tcp_data_split_mod: Updated tcp-data-split from user
  * @tx_push: The flag of tx push mode
  * @rx_push: The flag of rx push mode
  * @cqe_size: Size of TX/RX completion queue event
@@ -82,6 +83,7 @@ enum {
 struct kernel_ethtool_ringparam {
 	u32	rx_buf_len;
 	u8	tcp_data_split;
+	bool	tcp_data_split_mod;
 	u8	tx_push;
 	u8	rx_push;
 	u32	cqe_size;
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index b7865a14fdf8..c12ebb61394d 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -250,6 +250,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT])
+		kernel_ringparam.tcp_data_split_mod = true;
+
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
 	return ret < 0 ? ret : 1;
-- 
2.34.1


