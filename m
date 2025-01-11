Return-Path: <netdev+bounces-157421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90118A0A43B
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBCD7A02EC
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365C374F1;
	Sat, 11 Jan 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPbPWwL3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAB19AD8D;
	Sat, 11 Jan 2025 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606792; cv=none; b=VBFzoJ4MrHL1pZ9GqMRHsLzJZUvaW0nuzrLATczFSmejfuyrT5vGElFrkBTT11Muk9FSKJ+JlBaq/9BWusvOvU/4wdVV5WG8ECeJ/B4NhE9SJ1j6qVbKsYmzCdlZLg4Ll4OWmYeGvy7qbMj7ckAGKNjzBLyTjWdW7/VKrGCbLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606792; c=relaxed/simple;
	bh=TFUGwOY000b7ECS/SUThlSGrc9Ir6DhmTpLcfk/T/io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OEOyHRJqklfOsayQXsyiOlgwkFOQk+FwVjUhyZ6ozCPlF/qOChggJKlm4S688oaYiMMkH8RmGF0MXEokRH0UvkgLn0A9eFuPA0MUKZcNhWG1oIZhKMig/C2YUYy12TpriISWyUFNEpEKwTArl5PBotj4/Lc/fLZC1YRLEeie0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPbPWwL3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21a1e6fd923so66556475ad.1;
        Sat, 11 Jan 2025 06:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606790; x=1737211590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oleZPm/uQ58mWMFgGwU/0hEEtcx09X7TNRA0EpQNiwI=;
        b=cPbPWwL3k6wuh31MAB+P9O4nXxFH8kvTQ0CvgNdpwNFm08mfqJJWeyCBZyl0vTFW3B
         vu91wmIViFXoMRtYQ6/8PDf7KcYQUXuwaeiMfiNPYT0hZnounXhV7Yp811BUo45tTNXE
         +NK1nr2PCr4Wu4nKf+Ix5gZPz7irktmkA0Q2g3RDseQvhD8Tt/lVqJHwfquxtgcEisFP
         2NeqAfgQQuwrIV67gY8rCmgm5wBfrTHyTc3FMI5TecJRWhGsEPDfx4gWdjEyu4iDs8te
         BkctpBvOA7kYAYXNo09VUu1JPKukRLkmFpuS8TW82E3+oZnXEWwXiEQL2sRDWkXfSjAC
         f4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606790; x=1737211590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oleZPm/uQ58mWMFgGwU/0hEEtcx09X7TNRA0EpQNiwI=;
        b=Ko9h0Q8qrEmT5LzPcUn4+SiD9x47eYoKudSwKNUgqZqcAFcorsA1LdSIOtdvRaXyxF
         yXrsR/qze0hni6+IFO/SvTKearQtCbmvo5xGpQXnbC4ouiW3+u2EVQxjULOyRn0/yeA9
         y/1TxXZDbLwxXeuT6API+9bGqHv8qZVp5G4lJ3v/RSq/YvHAuxlqukgusn0rmvCmSTyI
         iqIXLiLARD/ATyjI99knA82XK0CH9AW055Wv9KlJOQeqhwile1smNt0eIuMr/z9tE+5k
         ckf+oXSKVg2vldaw2Vn/TGVVYj28FuAy3xYIt2MoGvO/Fp/mq0JCa46wFB3me/CsQ+oo
         iTeg==
X-Forwarded-Encrypted: i=1; AJvYcCVuBYPBzrpTTdDjT/RRXgTHQRGJe3f9a7u649phtkDRSTRD9BEGGQsjelnA8da2zURV4eyu6asS@vger.kernel.org, AJvYcCXcOa/712Q1KNmO9aYjXGVPnhm6xc2MJTvLAC+SMRqaki+5bmpWyDr7XbkDB6kRTN2KVWLBZYS/dW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzL6H1w/nlfpClUa0NkIrBOulCXUHrS7yhWXNcgoP+feFaWl6
	5EzXaHsB8o3TlwqSn0aJwVfPLL7Wg6Lp270gcl3pt27z3tvdEm1J
X-Gm-Gg: ASbGncvjWzh6tSP/MMGEDOOYoocxM3nzJeenHwbZKN0gXDsWeqLKTpIuHXQKJRpEJLw
	h0Fe2PN0ZZ+WzaqYrS2TUd611ceA6szaFSDO9gqaYK0Ho2FWsVtHRhU3z0kWIdeM4Wyi03YKYqD
	+BGI6gyB0fuPce+Rx0Yg0DagSh8T1hsHV79vRb4zipfTXEehSKqJ92/yM0YMZhpS9HnXC/YlC86
	5hkUhFYmuDxSN+c+kjjRzepJ7D47i+Rud3+cVS9FybXhw==
X-Google-Smtp-Source: AGHT+IE4AXR4vrxTUByR1P10rPN0YGKRhuE7x8hzqKu5c+XOgMg284GNWsGMbU92QAPXGfDvDKoVpQ==
X-Received: by 2002:a05:6a00:39a7:b0:725:eb85:f7f7 with SMTP id d2e1a72fcca58-72d21f17c7emr20506589b3a.5.1736606790621;
        Sat, 11 Jan 2025 06:46:30 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:46:29 -0800 (PST)
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
Subject: [PATCH net-next v8 05/10] net: disallow setup single buffer XDP when tcp-data-split is enabled.
Date: Sat, 11 Jan 2025 14:45:08 +0000
Message-Id: <20250111144513.1289403-6-ap420073@gmail.com>
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

When a single buffer XDP is attached, NIC should guarantee only single
page packets will be received.
tcp-data-split feature splits packets into header and payload. single
buffer XDP can't handle it properly.
So attaching single buffer XDP should be disallowed when tcp-data-split
is enabled.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v8:
 - Add Ack tag from Jakub.

v7:
 - Do not check XDP_SETUP_PROG_HW.

v6:
 - Patch added.

 net/core/dev.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2701920fea05..2b2fcca199f6 100644
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
@@ -9499,6 +9500,14 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
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
@@ -9536,6 +9545,12 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
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


