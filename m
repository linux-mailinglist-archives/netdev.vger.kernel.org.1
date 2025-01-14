Return-Path: <netdev+bounces-158142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B022FA1094D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642153A2185
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FCE146D6E;
	Tue, 14 Jan 2025 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUM8vg7I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CDB1411C8;
	Tue, 14 Jan 2025 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864991; cv=none; b=md1bYBr7m4bdyspiY6FZVwrZLLN2gV5hIjgHqVpp70BbYCpMrXkSbU7wp710QnkeZjHfOA+76zS/LEjvK2Xu+Z+J3ShXh/+rfHhHHggXYxfnlDGmSot3hO8lNHnxglNmjUTWj27KoLFUv+qhMy40dHZCgrET22HQMATCv9BWdow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864991; c=relaxed/simple;
	bh=sYjxBhXYWCmuvkdC1A+vex//OrhDcxd0KjaG6Nsk+Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQPEkAINSgDTkcKRLx1EdHNDVGBRyNBtvJV5Nr2JcZHJh6Pv4tFxqRrYJ2cddLwgcgjPcuQ49dC9abnnkA1NZDC+yPmMgotiLeDLKaStL2PK0g4jAdc1i+aDACzf719U12Q2ygZNq9OzGP/w17fgNPfOAU54u9ayVFled34Fzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUM8vg7I; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b662090so95479575ad.1;
        Tue, 14 Jan 2025 06:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736864989; x=1737469789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbE+UlgknWj3V/9EOtpyTiR9ENTWCWam96Dcz1tTLjE=;
        b=YUM8vg7IqAWG785DnHYvrTafe6wm9nq4wmKwoalCanTNi4vzuL75aREICUrsTZAgPC
         rElsgJ0eaNGhFa9l38aWm3S/TzETOnXL8qg3JOTHfOr8brYl04cW7c9nHschTQXAPubX
         tZKJaYa1ydY4n5suyATyakhN6ps9mGRj3HOyd75TL2hKDCRnW1fL4GWGCYPB4F48xUFo
         2fW24gQevsmhyw9RS5ZK9exIV6agGRvpW3WPLCy/kLZakC0NmVHrsu3Ey3wtQkFHwX3M
         nqRDQ6iZwtpynp8zAboxEblMsIWE1wJfxfS2FSXM1dw9UbwmW1KKHCeGJD4ayaex6Shn
         64ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864989; x=1737469789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbE+UlgknWj3V/9EOtpyTiR9ENTWCWam96Dcz1tTLjE=;
        b=X4GitEDBbce+49WHRhqU83ovGyGDwJN97cxKMcr6kUzFZuCDYlQ4+iirWPmAYMPlp9
         UmweBDPjmspAcA6FI0egWU3GXdiFrMAew2daV+AjHaYqkmGV0yWnJTcs7uhSWo/uiKjm
         rQ26D9CbfTSheC5Cc92j0QFbSWaAOYz81Q7h/KBEMfhoZPOvBC8a5YpkUCONH4P7JnQQ
         /pVKY7fqAcFhf0qtRLJkJRlHqdxpd7a8DdKkVArXbnupBUIgKKn4PWW02kVxE7U7/VEx
         /oiFMEBT/GQ7gU5WU/IZMRLBSUeqItPI97ItWHzcQ4TbFbDgZFMuLdBukIb2qvu1KjdO
         ceSw==
X-Forwarded-Encrypted: i=1; AJvYcCWLMmn8y9xOf5ShX9+t+udEikOKTvJ4jnkbCpbfgar/zzEicTzs9yQYKnU27pmc+qX4hff1qcGP@vger.kernel.org, AJvYcCXWjZSO2APxLpztJC0vNrYIiHgOgSvjxzvLQLs6ujov620X7PTgS01pg7R3ExShvI9k7J60+kV0iMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYFTBZjceXYOAiTvV7cSqqAQkLkbSadu/CaRGAE1q4A2ll2/q
	4Tw/a/0Y7jJjp1rP4+f7EZ3WJERkvthvEFOFTr+F/9Xgi4kUQTB4
X-Gm-Gg: ASbGncu4/iKo0NrGtCLnwBR3f1Bq94HYbB4BZea64L7yNhPvVhap9EBLvcskcwBGb4V
	baCSgXH9DXF8NbnvNjuqTX+r+IG+trFPuVQR2GvQK+AO2IcUMcfVB4xRN7AfAFbwrpsOJxxJOZ6
	19QwyA9JflBb7PmHokg/OhcYi3TYYTtTPomAoEtj1SgCxETLX6RbO8ak1Ozk/Z3M3u5KmzMT60d
	7YYjxXlnCu3riLLN3LqKzpg9cveIlDMx0qAoWzMVjtq2Q==
X-Google-Smtp-Source: AGHT+IFx0Gm2t/wxHKpuLILPmsyGEtI7KGEThwmY6k4QZwtTLE6tL5ir0KvQzwTIlR3QUIRV+EnFog==
X-Received: by 2002:a05:6a00:6f0b:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-72d22048bf7mr31969097b3a.16.1736864988684;
        Tue, 14 Jan 2025 06:29:48 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dfesm7474582b3a.156.2025.01.14.06.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:29:48 -0800 (PST)
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
Subject: [PATCH net-next v9 03/10] net: devmem: add ring parameter filtering
Date: Tue, 14 Jan 2025 14:28:45 +0000
Message-Id: <20250114142852.3364986-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114142852.3364986-1-ap420073@gmail.com>
References: <20250114142852.3364986-1-ap420073@gmail.com>
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

v9:
 - No changes.

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


