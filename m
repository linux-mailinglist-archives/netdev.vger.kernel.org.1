Return-Path: <netdev+bounces-157419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C263A0A436
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594C316A1AB
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC411AA1D5;
	Sat, 11 Jan 2025 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEEPLAuH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECA374F1;
	Sat, 11 Jan 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606772; cv=none; b=OgNNjsdemLmc36unGa0t7K4kz+jZhXhSp0wZSUIaaK1xEyxk5Yl8hPH4WcCS/he7BSAy0iE4XNODN7kuOopcB5HS+WyA28ykt7gwcbAo6HgCxEycr9H+Cj2kN8ygqcfMwunHM8jcJrpBRc0cskNhD6nRlJXIGXfpmZjvto6VinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606772; c=relaxed/simple;
	bh=gZDxZR6wAyYLXNuCzPTtGo2+1ddGAwssPkoAf/rfU/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXsz1W47yeAWfMdyUiwb8bY1tr6qaWydU6VBNQtyd4SEBrovh5VhnU5SWerhiHP27sHa6HhNBMQstQ2CAJFTlqruKLq3djvoDRbH64CwrG8/x9mTQANl6xTf4ebJWwdJGTGMVREpiVEhwFvrVvKAwBRvrDtUKCrIVeHxZswca+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEEPLAuH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2162c0f6a39so70850325ad.0;
        Sat, 11 Jan 2025 06:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606771; x=1737211571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqXP+XBPEy2KO7wvgay//dP2eWiCD52Pp8bYG85Q+tA=;
        b=eEEPLAuHHMbije7P4sGwrdRgVvwnGQz98eRHmDwu3wrxwpgHolH4PG+Qcsj3/gYvpt
         aRs4bfKdNCHyd7/ZkJ3jnASXXFvtLkV1GL54yS/xjneEzsr/VjDabva8JURhEP+QKFNa
         utbW3tfYOdXwKNZyrAaF0NfRauMJ2bAtY1VKisg+LgI1lXIthBXp6lMXx//DIcgSXUZ5
         WY2njRMD4fKo8q/kTUMR5wgdU7FLhQ9Y2g5z4/yuaAHyvTPzWhnurQxKx+DntAbsmNsF
         pJidaIQoEwRm+rnTQMHEliCIPlxnDnZivDcx/L+a++r7Dy/AiJsWoAQOPjflAO9J8PaX
         duQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606771; x=1737211571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqXP+XBPEy2KO7wvgay//dP2eWiCD52Pp8bYG85Q+tA=;
        b=R7yqeGTHwDKqy+1GszsWQIbF0TndNpNCRYQZpmGGU5/V8bCEH4c5jFbeFS6eLuA7Uv
         JkHKoKDaLEmgBDBSQKFwIWQQyiDHg89iXO8sjuxYvMaWditvtC9y+H/TII/KcQJDhiMb
         9gaOf8D4HoRp+3IIQTG/O7lm78XoSwcro2hfPGQEeAFaThYKIJZU7bT9vBpPThhbIJ1w
         0c3mZ+nMGoWNgFOAsirwILmuv71BvtsKpxFQp1111xa0vSc7VAtA1JrRQ3Sw6Fml/4cy
         EDZqrHn5l8PBqDOBFqTtzE6GYoIFqvByxOaCJCwrQLqHH2KRM60Tm9ecfNkGqFXg87Lk
         Mt2g==
X-Forwarded-Encrypted: i=1; AJvYcCUy8d4SW22Ap4OrKsbq2eGSaKxMlYnqQBp40GD+ky4OjGNjvWoNNymsbrEJG+3cH2xj5NBgKvMW@vger.kernel.org, AJvYcCXzoQTetlAtMrkrkb3fUw66F22ZR53AsHHQPUvFof/RmmlKoB0WsE2cG+dimr7wx6DOb/ebAa0+ZAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnt5Tfb6heksbWxF9BtNCHwUYjI00QdzyBr2uE64rYjvyxASK8
	Ey5rEZaU3Y7CXHYYYr729vE8ZxLCSbWDvo89A1VSqPuAXaNIGesm
X-Gm-Gg: ASbGncuaJzkcSxqgwgWZhjezH3P1Wow5l5kWz1ofECVpDEsJvZHoeKwXvsuqLpPIrGX
	Rr929xVqsIaafSOnJe55DuuPcqm/Hn1z1Doguo176Jr8Doaab1R1oH0Ovq+3OGuoYg+O9w6HyDn
	AMKiTnfm+QOIOwe8OajIrLe6UqF801YT8sGDaw60//HnH/f/XSB0ANROK6+8NtIrozie1YfTtZ5
	CZdz9BExzqOeET6XAgFqa13bxJqRoLBFuEn0ZwONhd7OA==
X-Google-Smtp-Source: AGHT+IHapTVGieGw3Zi0oPDCdclVjWDB1Mointj4VmrN2gRujFZdeVWV20j8x/rJXX03yJpBUYqygA==
X-Received: by 2002:a05:6a00:170a:b0:725:4915:c0f with SMTP id d2e1a72fcca58-72d32506c6fmr14309817b3a.11.1736606770684;
        Sat, 11 Jan 2025 06:46:10 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:46:10 -0800 (PST)
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
Subject: [PATCH net-next v8 03/10] net: devmem: add ring parameter filtering
Date: Sat, 11 Jan 2025 14:45:06 +0000
Message-Id: <20250111144513.1289403-4-ap420073@gmail.com>
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

If driver doesn't support ring parameter or tcp-data-split configuration
is not sufficient, the devmem should not be set up.
Before setup the devmem, tcp-data-split should be ON and hds-thresh
value should be 0.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v8:
 - No changes.

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

 net/core/devmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 0b6ed7525b22..c971b8aceac8 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/dma-buf.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/genalloc.h>
 #include <linux/mm.h>
 #include <linux/netdevice.h>
@@ -140,6 +141,16 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return -ERANGE;
 	}
 
+	if (dev->ethtool->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
+		return -EINVAL;
+	}
+
+	if (dev->ethtool->hds_thresh) {
+		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
+		return -EINVAL;
+	}
+
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	if (rxq->mp_params.mp_priv) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
-- 
2.34.1


