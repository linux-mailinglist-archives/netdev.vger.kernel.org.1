Return-Path: <netdev+bounces-234285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5FFC1ECB1
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B94374E6DD1
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64526337113;
	Thu, 30 Oct 2025 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXC1U2hY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD091B87C9
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809751; cv=none; b=RTcLgNg7l/360cz2Kd5QoZFPMz4pTUIDb5Y5mMfcccr0svOuk679Ez4GWrqSPKGyjzxHtl2b8jgtOcCKrdi3lS85U8odsC5Dl5NtiIPx0abZ+cO2PUquDvM4Qj+75F49KtaieCLCfPfpmMofCSKZNHiC019c1wp1g7aVOvbRNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809751; c=relaxed/simple;
	bh=C7diEITXUEtmKmG2LIyDdMUvDkfO+9mxJdkStxpXl2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpyF5Ur/HjK9e6epypoMxRwUInehvusEeHHuG39U3/HCrRyCP9ubDKfwD6DeBzyyD+jgMPrnf98HNiAHPfwwhn3ikpJn28GGPYjU1l+GhufGOrbp3xnG7yO0y69HudgXSSEBiWRdAEXt8tnCa7t+zJpyuPc0Fno2upcac3duNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXC1U2hY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso780790b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761809749; x=1762414549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJP2R/yq4szU5oDK3Iv0D37dq3ICh+xQev3u/MxltXM=;
        b=kXC1U2hYKIFgwayj/9v4OgQUUQl2crBGKAMKyf853RWLl9d0EV6Zuh4dLFHvy08bnI
         ZsW7LCoCxRQWL45wQHkeF+w+oeF74Rk2zlCGzpkEYqJzl7aG+C90HjueOOBGFFUw9J+x
         dijxLNtbVUeom+udymX5wmy9JVbmnke4QUVT2NkQSvlQu8yGBvpsh+fN/XycCJCqekgn
         qyMe0qbzbsfN68ABJHGmdxtFzXkRcL6sqloxZb6sVwxJL7wXGQuyMXgkORTGiv9c+Ai/
         L40gL5ZzGFevs8Smzz362wkl1loVuWs4jymqsMsPvNdGgTAcVIevzyLiqY2Q+crduyXE
         C2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809749; x=1762414549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJP2R/yq4szU5oDK3Iv0D37dq3ICh+xQev3u/MxltXM=;
        b=KLe3I2p5KUIqsUlevQRnNAP44km6lAQ+6rxkdjsTOH9YGqrbPuXbWfqnASF4DvnVf5
         fdVbHwKG2tL5kmpyqm7+L4vdazaWbUJDypWpRKrnWwUcDliMDOJgOxr10NGffesotmdX
         C7eZgKQfBp73dRDB/0oGzOofk14sNSPN5JY9XdrrQoVD6tgftHlTs2bb77EDknQSyY0d
         dSeTA9h9EmflebzrsQ92LAhAPwYdKDvZFb7TX4q7Yi9XCQu3KkN/RQfwpggVdZ92J0yx
         Q6Y7VNDCYFBU3I/awLo90n9/1XBU40mcRZnqPv/CGdhRDy6tB0AshfoEDKLueMMNwCRn
         X0YQ==
X-Gm-Message-State: AOJu0Yz2RPqOfFev18V4uIaa9TiB4QS4Sx9Gcu+YUoipjGTY1Nmg1T5Y
	KID0ZgnTpWf/6HNwVjxS6UAN1+Vpojut5kjyZstQUxJrGQT7QT3TwwjEboTo5toz9uY=
X-Gm-Gg: ASbGncuVvrg1DY7yy67HMGg1iuCv2lTUihYUNOWZMQAqUBJBaO+X9P+ocLM2F5nUAqQ
	Yuu5j7Pt1WhuwzJU25FgmG0xfk13XWp26siKQxUMKNZ6o6N512Kcaz5ZBbkh9s4xSSS+pQS+DWW
	pQ3QfqSgVkWxzRjKW53UG6inJ8KY0X0GColy7g46TveHw5HGt6d8oiiqm/Mcdp2qGQi/Y3QDUBP
	Y/6/NA2nttv6SjL/ERVIQ7aLt2rRQ8daP3bWV/uhEU4cvXbM2iPoaV9umtHAyklGwkjUK3osQwU
	S6gSBhkMy3Fuxiy4CfXrgvGB362hZmdF9sjZdg4F9OGAaUJ854zeJv1faszcDsvTGJkaPH5Kge9
	Hc6KksaPkg/GQswXI6joJjbkvwhBOXKL05Bw+sJEpSTmDYyF4EL9MiNuDPuqgAGkb3t0azM+U5P
	IL6G2R
X-Google-Smtp-Source: AGHT+IEWzo4lCa5o+AWpFrc6U8OWPPUBgIRDXxrUH9MA4q4ittpWvJJMsk3K71oK0uACZVM8jY3F+Q==
X-Received: by 2002:a05:6a20:72a1:b0:334:a523:abec with SMTP id adf61e73a8af0-346559dcbfamr7778811637.60.1761809748783;
        Thu, 30 Oct 2025 00:35:48 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdd50sm16323243a12.0.2025.10.30.00.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:35:48 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	Oscar Maes <oscmaes92@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net] net: vlan: sync VLAN features with lower device
Date: Thu, 30 Oct 2025 07:35:39 +0000
Message-ID: <20251030073539.133779-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After registering a VLAN device and setting its feature flags, we need to
synchronize the VLAN features with the lower device. For example, the VLAN
device does not have the NETIF_F_LRO flag, it should be synchronized with
the lower device based on the NETIF_F_UPPER_DISABLES definition.

As the dev->vlan_features has changed, we need to call
netdev_update_features(). The caller must run after netdev_upper_dev_link()
links the lower devices, so this patch adds the netdev_update_features()
call in register_vlan_dev().

Fixes: fd867d51f889 ("net/core: generic support for disabling netdev features down stack")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v2:
- Add Fixes tag (Paolo Abeni)
- Use netdev_update_features instead of netdev_change_features (Paolo Abeni)
- v1 link: https://lore.kernel.org/netdev/20251021095658.86478-1-liuhangbin@gmail.com

Jakub suggested to add netdev_upper_dev_link to __netdev_upper_dev_link, but
this change touches too many callers, I need to check each one carefully. And
I'm also considering add a callback for netdev_compute_master_upper_features.
So it's better to make this change in net-next. Before that, let's fix the
VLAN issue first.

---
 net/8021q/vlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index fda3a80e9340..2b74ed56eb16 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -193,6 +193,8 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
 	vlan_group_set_device(grp, vlan->vlan_proto, vlan_id, dev);
 	grp->nr_vlan_devs++;
 
+	netdev_update_features(dev);
+
 	return 0;
 
 out_unregister_netdev:
-- 
2.50.1


