Return-Path: <netdev+bounces-153008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0789F6912
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C838D172675
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4171C5CA8;
	Wed, 18 Dec 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIxv5iET"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6511B4254;
	Wed, 18 Dec 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533280; cv=none; b=RWgMAdILZQW1CnahCGbqZZju7n1CUsl3EknRvmJw+lqd8X5KRQWJRwYYXIkaVGFtrf16rZ8B/PiVGWbcNHAkypVVsXI3VxL2XimcPizaLZ6rW8TESqVEhc5H5mCpFlA8qvUzfbd0Ur+Rm/92Ujzh/GCKIaiMeIluAKhv1/mDxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533280; c=relaxed/simple;
	bh=ZUp/096lTgig11kq8/t25MhHSZxNhpH7JNs1XQQouy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ShUmyPYlfxJCMDse+eLUHyO4Eq5aCHT6db+dlHqf7kH2ItsWrA1I2SJTfRy9lhhqh8XVpHb8frXJRT7K9LVoq+X5l1bihPqTPHGbaQN8ECAsRsW8XqK9zXMw8UzI7DrBnF1XsWj5arc6zva4Bl8BmKSObRH7cH4z86xz3O6mWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIxv5iET; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728e729562fso5728876b3a.0;
        Wed, 18 Dec 2024 06:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734533279; x=1735138079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+eemS5JfDPM0T4Ra5TmhFfyQp7rmHYSEkGxE4hfA2Y=;
        b=GIxv5iETGh5SyfWbhh2JjlYFwNX3ASPSEYtS3wDW6M7VWBpiDI5uInCppmptPxv1yI
         FRUEvVQGt9sDyY+gKGjk0nz4Fvz8NA0R3a8ZF/XRU4LziNDn9IiE49V0kzuMo/lztsxQ
         1LVaF1nH95JhO8868F4304m4YoVTObYI4T8xd0IitaXT1hnZpmbRgLp1Zp4Ry6cwIdYS
         bPh0Q7h1T1fHc/KD/mredfCKuj1+ZN19FV5FlKoMK2sewaxCD/Ljo3ztOVfJtxdtV+ZR
         endhYEflourTmW7weLdG/g+vyNumsonvx8mvKYCxdwl9UigkKNZCIkqCncr7p6/2PENg
         26Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734533279; x=1735138079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+eemS5JfDPM0T4Ra5TmhFfyQp7rmHYSEkGxE4hfA2Y=;
        b=M5XvDYGu0HMY8ze9x2TzP3ngndGYHefrgF0DUx5//SuZeTMMruwsaAP/9poeOnA99i
         Qa/KTmFEF/FJEM46FqUB4RLoJFdVbKbsTQun5Cg9uM9Ymay8Z25xYQCPt23NeSyAVwOK
         YBkYDSsZdHiLpLxjtu5OosgiQgx9cJFOuMODWUu/mWtiR6YKAgg0rTzcseNQp7NIgHdj
         v8yaTtJ6bNfn4fiGtvF6amd3G4ZGyg7k98k9P8fJDDcqqvm1dQHZSSsc2/s5b6Hs++3K
         hgJuNyN+IxFYHY9V3NyWxA75BS6xIe/4wt+n5Bv7T06opoRMQW5bRZwN3rtg7K00zI2K
         tZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCU3YrT0YHzaTmDvnOfipHz1xnFJiNcPUXgz9KtClFB9JJFP76rPZwSQgQH+tSPzMIKs5wKYwxtx@vger.kernel.org, AJvYcCVHL1SKuPKM33gW4q4FON3gBpMPRVGcCvCXVtZRPAH3wi9d2RpcHV2hcHVJLyi7vqFt/ugIr5Epv3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWjYK4qzW8Wbg2phofGY/QKv+eXI6mXt6J5+PAhFFP68j/N97D
	bXjPv5bRPmP+mm/3QA/zEb6PAlso7NzSkEgfol38xevpGx6pq44o
X-Gm-Gg: ASbGncuwcucC1OCoKI20BjWwwmgW44w29UtKYB8L0AoeC8EOmKFnh3yz72jjgfBaJFI
	MxQc4WLZkgQVPS6ERRVNeMGmvXNwoIHasDlEmhbslMd13dUwC+/V8/ls4GfQfSSFbGGC4jOCLfm
	9cWTIQK6P2T7dZtDBkZUel828Ar2f6tnMe3C3ovR0TspTEqlj0oJqMSanF8yeYziGeWyn8MNCUA
	3h4TISc/IvIW/5u/SnFA7zrC946YpL3zmc4tr7xOBNj6Q==
X-Google-Smtp-Source: AGHT+IF6K0WlvzNDshTqQDZGpH5CId8EN4ZA8pxBcCsQ1VfNQm1y/wpesZcxgO0oeIZC8FUg9c0qeQ==
X-Received: by 2002:a05:6a21:6f87:b0:1e1:af70:a30b with SMTP id adf61e73a8af0-1e5b487d79emr5685913637.34.1734533278967;
        Wed, 18 Dec 2024 06:47:58 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5183sm8912687b3a.29.2024.12.18.06.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:47:58 -0800 (PST)
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
Subject: [PATCH net-next v6 8/9] net: disallow setup single buffer XDP when tcp-data-split is enabled.
Date: Wed, 18 Dec 2024 14:45:29 +0000
Message-Id: <20241218144530.2963326-9-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218144530.2963326-1-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
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

v6:
 - Patch added.

 net/core/dev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6a68db95de76..da4a34bfb675 100644
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
@@ -9498,6 +9499,15 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
 
+	if (dev->ethtool->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    (bpf->command == XDP_SETUP_PROG ||
+	     bpf->command == XDP_SETUP_PROG_HW) &&
+	    bpf->prog && !bpf->prog->aux->xdp_has_frags) {
+		NL_SET_ERR_MSG(bpf->extack,
+			       "unable to propagate XDP to device using tcp-data-split");
+		return -EBUSY;
+	}
+
 	if (dev_get_min_mp_channel_count(dev)) {
 		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
 		return -EBUSY;
@@ -9535,6 +9545,12 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
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


