Return-Path: <netdev+bounces-155022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC355A00B0E
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D884163FAC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090321FA8F1;
	Fri,  3 Jan 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8y7hgGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AAF1FA851;
	Fri,  3 Jan 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916665; cv=none; b=ESqBIk2cgdVkwCen3Sjyjbp0muyonceurRou9EKtS4c93jLsiEhLiLmnG1maO0QR9uKNaGK0mKMF7Oii9ap/y6eVrZ2KSxJSLt/nY0wiETd+u/MQD0Q3p3B44h+iWCS1vn4pw1gXDGOg0znBtOw10qUTDd6Ch9gJRq3jImQOnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916665; c=relaxed/simple;
	bh=BKQDlt0s1wORrdqRTBkoVwnxnuGA5YRsNvdq0RF/qEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PH+X35XfuC8olont8P1naGum0XYS87ueA2yYC4vDZuBiS26TtlAmOwk4cfdysF7BUWDNQG+vaFb+ZnwZxBr2lez4IxQN+mVgirf+pRDJGUZn+D+H3zHzRa3pJgwz0vqwJhthSJsmOnx4x4jcXX9Vyp7c0RTiz9IW8QuwvrpFET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8y7hgGD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2156e078563so149276215ad.2;
        Fri, 03 Jan 2025 07:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735916663; x=1736521463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlCsNZhi+pyCRlJI1oGA5APrS8t1ogGMgB2J84mRRbM=;
        b=G8y7hgGDVj++0Ri1YCDrblmv28m0elouhQWpDwJk82fHOTUm8NsTOpY+96/EwidJn9
         XLZZHUyVu/OW/jyT8l4shQLOWxcQCvjxBr04PvXwva5bjhBY3BowoBn1Coif+PyyuN8s
         NF0oL+2GHBfZBXlv3gn209PtVqIEeiucxXSdEyTag03rSkQHDAflbFwI2BX9GkcCRupi
         rQ5QYIsUZeH+dnc6R1p//SgwYhMU+AhZoTI10WY+pr1sEZbRUCt74r8bm92q3uq1pO6c
         pk7K0oLLw5WBXUWg9nktkIt4clEcqyQeqBwzGsQMq41LSFGWAeyPHiUNUXdcgtfN7Xmd
         0HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916663; x=1736521463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlCsNZhi+pyCRlJI1oGA5APrS8t1ogGMgB2J84mRRbM=;
        b=RyUF3ChoYb83ks6QIxQBpWGWfEa8/F9OoXFyV/1MGAJ7hA6wJshyh2WdDxOYFFFxg0
         e+lvmmyTOsfvVhwg4NdEbc8OSpCmom/plLO7bBU7a5F1v0hliEGoBYskqiSxa7CmN8cr
         butguqUpS8yizn5tDAz9AwRY8ykWNuqGny0xUnVdyvpgVhGaxx6mz9jvwfhEkqEB6XF2
         NjULUB7mVo5k67xOvdisFyJ2DkqOV7zlsxLDTyqlzeBwAauNOCMYhE6lhBKny8miLX1D
         4NaXyRwGp0L6lzyRf9jPusyzNmVZA3Zp1A96eO+7fEyIRhG1csgyHu6+/sFJ9vpwFDoD
         RHmA==
X-Forwarded-Encrypted: i=1; AJvYcCV/U92TOdZxGCdtIh99UzToFukg4oJs3Ve5M6RC5U1taT1slYhzEK2wcsXu4k2ecmwtLJlQ4veKP4w=@vger.kernel.org, AJvYcCXOSpxTOxZdHKPKrYdOJ9cZcP7mbiQH30NK5GUFgjbAgBkIi3Rn38rpFuKMloVnh+p1zCkzD32u@vger.kernel.org
X-Gm-Message-State: AOJu0YzNl4LClNEBvnNK+yCvp0T3qpc4DJDeMvIyyuDC2DuzeDvaRhO0
	wwCT2HeKqDxbrPYTfcIldttLurX2nXqXIHagc8RxuxevyKWwSttl
X-Gm-Gg: ASbGncua+Ck+kPa9STAXk44yflsEnGvRmi7Qq1sGY5XdsIu2JuFp9GkKYQ5W54Mek5t
	NOz63KrZJx33sp2KVpQV2w2qySB3bv4SYuKmBlR8Rma+axvl6BZRQEXCpDYO5n3z3bVQxnwkowE
	XvL/M7NUv8oBQHUUMxknzQQZ0j7cvtaw1sXqwhZ9JzUeq6gZQBBRWwIt2cAt/PCI9DxfLEgQru1
	nsWv1HYbLQsGum4oaYW7wDo/QPj39Y3cpyu37MGIn4+vQ==
X-Google-Smtp-Source: AGHT+IGfiw8U2ntfb0cmk8qGAK/jhkvSutFKJwRC8AXPD47pNpyfLh/Cp2mlK+pgO/KKIoyrYlP8Jw==
X-Received: by 2002:a17:902:db0f:b0:215:9379:4650 with SMTP id d9443c01a7336-219e6f10958mr780001455ad.42.1735916663318;
        Fri, 03 Jan 2025 07:04:23 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm247047255ad.41.2025.01.03.07.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:04:22 -0800 (PST)
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
Subject: [PATCH net-next v7 05/10] net: disallow setup single buffer XDP when tcp-data-split is enabled.
Date: Fri,  3 Jan 2025 15:03:20 +0000
Message-Id: <20250103150325.926031-6-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103150325.926031-1-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a single buffer XDP is attached, NIC should guarantee only single
page packets will be received.
tcp-data-split feature splits packets into header and payload. single
buffer XDP can't handle it properly.
So attaching single buffer XDP should be disallowed when tcp-data-split
is enabled.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v7:
 - Do not check XDP_SETUP_PROG_HW.

v6:
 - Patch added.

 net/core/dev.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index bc98f4920e12..2e0a5272f466 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -92,6 +92,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/skbuff.h>
 #include <linux/kthread.h>
 #include <linux/bpf.h>
@@ -9497,6 +9498,14 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
 
+	if (dev->ethtool->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    bpf->command == XDP_SETUP_PROG &&
+	    bpf->prog && !bpf->prog->aux->xdp_has_frags) {
+		NL_SET_ERR_MSG(bpf->extack,
+			       "unable to propagate XDP to device using tcp-data-split");
+		return -EBUSY;
+	}
+
 	if (dev_get_min_mp_channel_count(dev)) {
 		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
 		return -EBUSY;
@@ -9534,6 +9543,12 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
+	if (dev->ethtool->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    prog && !prog->aux->xdp_has_frags) {
+		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
+		return -EBUSY;
+	}
+
 	if (dev_get_min_mp_channel_count(dev)) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
 		return -EBUSY;
-- 
2.34.1


