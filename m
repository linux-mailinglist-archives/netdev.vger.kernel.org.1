Return-Path: <netdev+bounces-220428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357FB45F9F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B103C1CC6329
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0935AAD8;
	Fri,  5 Sep 2025 17:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B19B313277;
	Fri,  5 Sep 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092063; cv=none; b=YaB/bO1WDe+ycK6kmgP0ctZ8wneEj0w43NWyQp+Csp5+ppvRAbC2ivP5OxgP1g/69ZUtDDCWTIPTgTvM1kwC9HVdtGocrAogcPLXp8i67DHb49O46gOGMTh7dAFebeDDo20MCSZJIwGeR6RsQjzs9FjCIh+GpXYG3eIHLSo4Aug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092063; c=relaxed/simple;
	bh=CeqI/CPfLt91GzhZXuIdCi7ZkDtyIbGKbbgMl5Idh5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUY2lkzIDCwEq1gXbupdF0kjcdKRMyM84lI7VmWz7jD/cf21Xyl63WLwfBwfp9x0QsC63fgMV31G+mbD6/25bUsRhsO47fh+0o1/QOp0P9yKyTq3DBJx04OZ+tdfp+8OZ+tBDqMG5NPXy5/TfqXGfn9+xSvzYuAHZKxwdhHMQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0454d63802so399134366b.2;
        Fri, 05 Sep 2025 10:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092057; x=1757696857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxdlD9Z0X49cP7JCYN5rg4ONGmDsa0/rUnEhDLiPlaE=;
        b=JD7flmG2f8J3hzNznwoezwGNrFryq2noax/yMeT1Vn5VJhqcSE5CmCQ88xFs32lHcQ
         48RULhx5Utzruud4UdovZM1Q6uTWHRUGmuPyFnDMhb5jwIUaYbq9AMxoS09+xGOxlVop
         iHUe+8YMz9tHAGM/0fCXyh7kcGGnhsFuiYIkKbLQfFGIbuEM+2CtgaoRBHTK1FaSpXA5
         qK5k7a1xnG9AxYszih0ttkQ0v2oMUd0pPQJB9EgR/Y5QQGoOeif7BGHZ6ka61mAm3eeW
         4bbGdvAPOH8qGS7Eh5eolFM7mYr+K/KJ86sP2XF6Tgx8J9NUUVGdb8aKmtge52kq05rq
         zv0g==
X-Forwarded-Encrypted: i=1; AJvYcCW7o2YZqKfTBQ0rG4hvYBk53xp8N9iW1WT7SHd9chjrWlKRHrXh7/DOubEMxr4zl7NchIam/1O74+hDmEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMVCwUUV2+RbFpXqOf9gavI9nzQCLwvuGMrW8bc8Ov5jFGxy3I
	Ki2kVYvR+1kUdaFvNx99XQA1j8sMsHDQ8xmawv9Y5p+MKVFOOv8H0BBq
X-Gm-Gg: ASbGncvarsChCcV+WYGsy4o0gZOEpjtf0mjXkr/oNSdbjeo5q5Z+PNoTkqHY1r70KxJ
	zb13sPQfJb00pg+w2HUPvoj/XbC/5KJUdMllhmqUEnfb4q9a8WsTpwCKR6uhSLLhnT1FYPp+3vc
	pwaGt56O6eV39GO5UertZs4U7jD1t4pTM23M3wCsavHnAWs0U/iYGKbl3mCsVggKzuNNcvRI3oQ
	IfFGRDzi914DhKSv3vs0e3wpr1TTeZ1MOLNkYXKJNcmEX/dO7Uptce9U0ffw8DQbeFaj0Vtlh7Q
	3jVb8Lm2i712UOqFniM0CAJUyuyNtgrp8gt5VksVa52FJK0CImZFygr4Ep4K7KbwYalYUFvAeOH
	wy2pGvLtYuwkXUg==
X-Google-Smtp-Source: AGHT+IFyGzIlqDsGhq19oUFnJmq6/ZpxkKdMi1XxXMB1n+8oNFxl2efi4d+YlV018cOAZxqPq1U0XA==
X-Received: by 2002:a17:907:7f8f:b0:b04:2b21:a4a4 with SMTP id a640c23a62f3a-b042b21a975mr2071162566b.63.1757092056558;
        Fri, 05 Sep 2025 10:07:36 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041cef6b4dsm1381805066b.65.2025.09.05.10.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:35 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:07:22 -0700
Subject: [PATCH RFC net-next 3/7] net: ethtool: remove the duplicated
 handling from ethtool_get_rxrings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-gxrings-v1-3-984fc471f28f@debian.org>
References: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
In-Reply-To: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 jdamato@fastly.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=leitao@debian.org;
 h=from:subject:message-id; bh=CeqI/CPfLt91GzhZXuIdCi7ZkDtyIbGKbbgMl5Idh5w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjSvnaJuRjHtK0yeKEGoQ4A5NW22cVpy1kmQ
 lCxuucJjouJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0gAKCRA1o5Of/Hh3
 bYBwD/9suGdhma341NDgQsMOw2iyLW54YRcwxFm8uq68CLVHFgiKdKCqCHlRGr1gK0jwK3lIrJm
 BLo15fZ3x3KMt3j7FwIBzcoo1oGK4agXImKRhsbR602Oqj0/sAHXrgf6hiwuUi5l7zYtEXycRAi
 UR22vJRHd2+LZet0/hIYqTjdymCAIMvH5w35eoQpd0KASO1Z9tPXjI1XUBfMDPJIeTQQazqKzr+
 1Ie5PCtoRiIBNc+MFNg3TMRQqnvbikxYIESqx6Jlpo0cc+nTL30K4gT8Yd0N/hV1tjJBr/X3OSl
 V3Kj2HUkQoReL/3u2EO0MwEhJmQhANLIt6OX3yqi3Vg1Q20ZXyb5K+JLQ1aq9DpUD5TKENXSFKc
 TFaANTXxAECp7v8LZby5FAIKPfW1ByA+gcXPt439MXVqnCY3o4qUsnwrir7ZvMPz2NjtgcOLnJ1
 K2sHa2Fc9BS8yZjwpz6JvhcSWlD9HZj2rRk2WeZnTm9JLypP7Ui1xP6/MJ9j9QxM5inNLH0R94o
 QxxbpIVtUKyx8KPneCBWx6SG33u8IjJ/wKuYhC8hvypO8XO8BQBuyjYm4uH7KQISm/7JI3sateN
 /+JWJIfUTyNeu1Q49stFie7cyQvZ/85vttbMfIYRny/rakd0ZPEXrxpTCWrc0YjL0B7l72r4gxT
 pDS++R1eO/SKfaQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

ethtool_get_rxrings() was a copy of ethtool_get_rxnfc(). Clean the code
that will never be executed for GRXRINGS specifically.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4214ab33c3c81..1a9ad47f60313 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1216,7 +1216,6 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int ret;
-	void *rule_buf = NULL;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
@@ -1225,25 +1224,11 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
-		if (info.rule_cnt > 0) {
-			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
-				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
-						   GFP_USER);
-			if (!rule_buf)
-				return -ENOMEM;
-		}
-	}
-
-	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	ret = ops->get_rxnfc(dev, &info, NULL);
 	if (ret < 0)
-		goto err_out;
-
-	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
-err_out:
-	kfree(rule_buf);
+		return ret;
 
-	return ret;
+	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 
 static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,

-- 
2.47.3


