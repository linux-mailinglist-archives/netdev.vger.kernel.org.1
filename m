Return-Path: <netdev+bounces-157420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934EA0A439
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA8A3A817F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138B1AA1D5;
	Sat, 11 Jan 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2eAHOoq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB411ACEB3;
	Sat, 11 Jan 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606782; cv=none; b=SceSpelx9pezt58aUpKFumIQegrArWwfs3kzTsXV9jLxxsxAsD03B+iwWmha+fxHzuo/BHPXx7h2dbb5qimPdv6W+7Knvp6plbnGxL/Ov2pU62zv8kaekoB9rBvwMq9iF1kwzWxN04dhmXCQxsqME3EjJmLOVyGtwJ5G8BYXrMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606782; c=relaxed/simple;
	bh=7Hv2+j1gqFRCBBX4Vhrv90cbVH+8CBZGIHZ8eZqUCbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPdK0mo4I4HyvwH+JUtlds31tE3Kzlq1F6byqDsTqM5S2PE22pYqGSX2DkSZgyu/quswbDUJHUYsWT4ls7OQMH4u/KnYetMQFmMvjPifufOXDdMBgaFIp2gio7Jg/9ddbv65mfY9C0qSipUdegXeGEqDInITe+GPNaRU7GWAQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2eAHOoq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2162c0f6a39so70851595ad.0;
        Sat, 11 Jan 2025 06:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606781; x=1737211581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge7d5xxrX8Z1wZ+vMnyLBHwBGoZEYxbK6jsDnmmefh8=;
        b=i2eAHOoqLUpXmzWEfVzecJqGxpPQjha2ALT2pFjQoCUWiy5LP23GSLAfKXeuXQr7IN
         bOIe8x/fqr1VF108Vg3wV+TODsWJZi1joUlYCWqkUhAstwsw42prteuCAUxL7mGbXyxY
         78Ihcan6M+PNRdremOy9LaSA6kZlpTi5rP7GDMP+AwvupP45ypNx2wVJ2v1uZMLfjajo
         QlI4dcrizWQ2akZvQNfuArdONMg11HtfRBnMtGMJRWyU5QDAtQSqAC0qrEntgwoodhxS
         89UC14KCfbLKhPDXixfpzzTFQYhqNGJjjmnCOumtRB/E39adsJXhX2ZQ5Ndo8TWy6M1+
         BK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606781; x=1737211581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge7d5xxrX8Z1wZ+vMnyLBHwBGoZEYxbK6jsDnmmefh8=;
        b=V4Va8AaJ9mPBxetjgpV7CgZeOSlJK954GTtM1rRQm37x2X2OXbE0vs8Lh9zX9VwpqN
         iDKxwE2wS2QdVrnPDL0LCfsAiTShJI6o9qRSQ4b2VMU+qJLHh0ZfbOxu33HZbBAGn17K
         Ql0GhibPL6mcOKWs1C2gYOI+2lf0WZwG/yXa1VBhA6PSjQXljxFQO6scgArVGYdNbOuG
         KWd84X1VOUROn/Nee6zixt2zXwcDOGvYJT+h4C0xM3Jcw1SglRrGLjxW8o1e7zK6VpVg
         JU6o0Bf1H5ug6rBbPgJP5Z4laWSRA5aOt+ckTZq4IHgE5w+bNt++f1lEbl6D5kj5Fqz6
         92Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUVEtfQSe0WcFL2dZvQ6CofcNHfRh4htepfi6ETuOdz/epTaeP9Ynpv1my2hObi5GolVlPOxtGb@vger.kernel.org, AJvYcCWwW7fb9NtjacwQhCS9G+oOHr2I/t9dWxXcq0bjGoJ3bkOqZLvmbYbqvtq768vix5IcM8QeLwCrtaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGzLBiNN08FpDp25miesCLINuisXWO1w6KnRLgOhx8YWmqmvxd
	lrx/o/sGyxWnU5rvIq/cdkIKTMm/eNtrgbcZFmW4+ibRZUR8GoW4
X-Gm-Gg: ASbGnct0M498OII0cMpzHnXoEihFl05xjnCS8yob9/NOK2gKxQYVddjP/hDeCDPnSXT
	hzkT2pmZzNTdarznVsT+Zjq0KPCmdlA9eIUROpgQWqME6ccONYjjzXgp4+bb1VqdWlJGZiK4zaF
	5LG6A4nNGlCKTq+5yS4z6/jHbLf/K5VJG1gUG0i25bjb1fIGDaLZz9PyEhyf8ksOqCayulhyFVN
	eZQe6QNS+Yz/tolcPO9+jpXDpj60ibE+izMxE+hnTAoqQ==
X-Google-Smtp-Source: AGHT+IHfsEL3ThCvlKUXlPsLOpROxWBTv7hhI7qC9cArSzhxPPijVCGDfHFNiAZHbvbTD+w71d82aQ==
X-Received: by 2002:a05:6a00:4651:b0:728:15fd:dabb with SMTP id d2e1a72fcca58-72d324df33amr15417284b3a.8.1736606780674;
        Sat, 11 Jan 2025 06:46:20 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:46:20 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
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
	linux-doc@vger.kernel.org
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
Subject: [PATCH net-next v8 04/10] net: ethtool: add ring parameter filtering
Date: Sat, 11 Jan 2025 14:45:07 +0000
Message-Id: <20250111144513.1289403-5-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111144513.1289403-1-ap420073@gmail.com>
References: <20250111144513.1289403-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the devmem is running, the tcp-data-split and
hds-thresh configuration should not be changed.
If user tries to change tcp-data-split and threshold value while the
devmem is running, it fails and shows extack message.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v8:
 - Add Review tag from Jakub.

v7:
 - Use dev->ethtool->hds members instead of calling ->get_ring_param().

v6:
 - No changes.

v5:
 - Add Review tag from Mina.

v4:
 - Check condition before __netif_get_rx_queue().
 - Separate condition check.
 - Add Test tag from Stanislav.

v3:
 - Patch added.

 net/ethtool/rings.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index a381913a19f0..d8cd4e4d7762 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -252,6 +252,19 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	if (dev_get_min_mp_channel_count(dev)) {
+		if (kernel_ringparam.tcp_data_split !=
+		    ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+			NL_SET_ERR_MSG(info->extack,
+				       "can't disable tcp-data-split while device has memory provider enabled");
+			return -EINVAL;
+		} else if (kernel_ringparam.hds_thresh) {
+			NL_SET_ERR_MSG(info->extack,
+				       "can't set non-zero hds_thresh while device is memory provider enabled");
+			return -EINVAL;
+		}
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
-- 
2.34.1


