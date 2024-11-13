Return-Path: <netdev+bounces-144506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA229C7A75
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCEEB32C82
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08E8201262;
	Wed, 13 Nov 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEFv15SS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD018201106;
	Wed, 13 Nov 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519222; cv=none; b=tCVQcf26+ecyxzzwSX7/hHmsK4VNe2EZPlet9HEv/uYalaaO1DPbcSUdhUfDjMRpvbEQchqfTlFWIseD/R7rr0iTtm2MOnhjor+8F+dOwse5z3fAIwUkmnBKQlQ83hh5JRMzw49uMu+qXY8Cs42TZDNqENF6jaLuRnxBv+3cBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519222; c=relaxed/simple;
	bh=Y7ggVn65s34L44hclSWqs9L7XSAELwhqhlkJzs+KwKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbMXmeBx/BWIJ7nOt7wE6DTsWaj8f+XxgFC5CeYO8sYCC5IhhY23ZxSNpOKsLC9a59/ehjqmD5q0HatEbI0U5rQP7bghBrQw2ElIGbupnCGR0oY6GJuBCmXj3DGZFbymwruNy3peN0CiilO9q6AtiAx53RBaAkVBjJvN+QjNmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEFv15SS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2113da91b53so53235335ad.3;
        Wed, 13 Nov 2024 09:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519220; x=1732124020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deUvSBZGMk9qIorja3waJc0OCGFfAoFCRG4VLMZ1kFI=;
        b=BEFv15SSOiuUM1+HjAJ9+eU7K8oCZP9JV1mCnAoloQPBhoORJ+N0frjJL8zpvu7jVy
         zxgaUNQHzxgNUi8Qp8JYw8fkTCPtLzFBVBY/0ZlQgJ9Df2ek8vvFyElZAydGKh1Ys3h/
         8yT8OEMXZ27c73UVTxflXyK521jjxYMUsR68Nyo1a8tDYaMMw8cPCqImweb/xe9mCHP2
         s/boXxnR6GLglGeVSLfxualVNIbgJG+fXVBjY8Mb6jElOc4L7eHdhIWiex/JL8CqAYxc
         AMI5+aJC2EFZCZcmJ/8A0CxtpA+wXXKGYcvEa52WyYkNFC7qDOlQ/lPEgqxLucEEfQlt
         O2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519220; x=1732124020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deUvSBZGMk9qIorja3waJc0OCGFfAoFCRG4VLMZ1kFI=;
        b=YoevnbyjY0yzGh3Ctlh3AYc28Dfo7/4ffyKz+Jjna/VGmZb6xrz23dM0FPUAkpt6Q0
         DN7CQrxPllGs1YDvwK4djJSodecoy9VGDYfDCwr9Z+0YnuHDUGsEhizFlCzeBLz4QYdY
         O8ibRAHrZg3VwrTJhrEcuNaTrBeUvatdNiOp6OGNoQLj7mMhAgAPaDhLR9ROFCdnwDCg
         DUBbvI1Y9g8RIybrGHBppQE6MwZ0pkfgrk+KKexFrEcYHrugYNUlZeCwZGiO5+KD49lk
         EV7gbmZcfW6WUGi1oyf2bbkOcHkr4nd+Wf+n3qVppjvGN5kpeZsvVMXLwqkPfMrYVGrd
         JE5w==
X-Forwarded-Encrypted: i=1; AJvYcCVZH6Mz6pNqBWHv1MUcYIazl2/mUxPJmgCnW2pQBOL5FUMt1J0A0ygwQFJDywdJ714BAkMCWesUwAQ=@vger.kernel.org, AJvYcCWVtrNraUpO3t4EpKYlIZnl02BfIVgvJCKWwNwNgsGDKmEWQnYErqBTN9yCd85xDrUFk/GE02/p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+cmk++ltHeEdYlz1SBpckUb3kLLSacLhFHNkgbnJ5a1EGmA3p
	pW1aG2z+0ddY79zAt5KdptANvULJ7tLRWoucW+7JSSbr7nBF6QG2
X-Google-Smtp-Source: AGHT+IHdtEHciLFUClZY3RmcxL/NP2gFz+MEQyuFDZ5wCx0AxuicbQIW+OPt+YDqasSDlEUze0hIpA==
X-Received: by 2002:a17:902:ce89:b0:20b:a10c:9bdf with SMTP id d9443c01a7336-21183d67d05mr307268665ad.32.1731519220204;
        Wed, 13 Nov 2024 09:33:40 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7df5sm113140765ad.19.2024.11.13.09.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:33:39 -0800 (PST)
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
Subject: [PATCH net-next v5 7/7] net: ethtool: add ring parameter filtering
Date: Wed, 13 Nov 2024 17:32:21 +0000
Message-Id: <20241113173222.372128-8-ap420073@gmail.com>
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

While the devmem is running, the tcp-data-split and
header-data-split-thresh configuration should not be changed.
If user tries to change tcp-data-split and threshold value while the
devmem is running, it fails and shows extack message.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v5:
 - Change extack message.
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
index ca836aad3fa9..3f3be806c6c8 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -258,6 +258,19 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -ERANGE;
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


