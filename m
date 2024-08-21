Return-Path: <netdev+bounces-120504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C16D959A06
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F93B1C221C4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E2199940;
	Wed, 21 Aug 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2yMafX6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD6192D96
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237423; cv=none; b=PRkJTs7fJkGdndur6dbGWpZriSTlU2Um+00bRInpuJcwVO4DJ/S1Xs/tS9VFseeMBU07o7VCukJ5MF0HxnjHobtduL6QWxHlmNOhWr70AAja0edTLr5ZPXOvnMhkmknlLvZcbVssIEIFegptrWWXUPxeAZO0CDl7TSIKpdFiZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237423; c=relaxed/simple;
	bh=l5Htu+4YK0/DnPXh3keN+cEExP+NgFStDvf0ACtHRVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRO6snxa1+78ft+hcTvV8dDuuCaSvtBa+I7H8s7jYOr9uhSozfz0nhE2O3+n0T/c8pwHJjPgznbtAT7Pi8d90drZ7JW9GuOq6UQ8GtEKuEQh9YTnI1YDoZ0GIFuEg8EhXkk9OgXQQq1EinxtY2Fv08tl9J5UD/oYxa6MqqBIueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2yMafX6; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2702a00aad4so3103771fac.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 03:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724237421; x=1724842221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSH8K/D1F3FbpQ53Zg061gb48/Lg7Mg1AaeNfy/4IKA=;
        b=H2yMafX67duokndCIkPBdBioadndfkNzHTXwv03gqS+8A8QtBAD4gzVB0eftRrwXoB
         8qk9ql8nexGxWH4ulmMVOgCEq5yRZ9J3AVU/1sMgz3CaFK7oBr48ithUClEcBAk/yhDh
         eSnp2A6tBgVi8FMcz4wp5+l0e72wu0+IjmKmYKt5jRe6RURn6qcsnP+k2uNHDH6elwy8
         Dx03NwEzT/Vjy8jsKH9JmwYCLfpEeyfu8b3pSj0i+wYMSsfYxf0xrV1nQ2T5rI3Ih1a4
         0FGnl77QUgtqF1mYswLvk83gqvHdbwl46KuVG3FnEYH6OQm6v1edc9EJCTBe7dkfJ+Op
         +2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724237421; x=1724842221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSH8K/D1F3FbpQ53Zg061gb48/Lg7Mg1AaeNfy/4IKA=;
        b=iEixgZOgZLELimw5Rmj1hlN40+i8KwZ/C54YlARvXBdXqBxL0gAZgA4E0++FnVZGvr
         XuwAVESXfwsmA/h/ZanAeHEEuxMbkSmDH4jfCnuVhk7c/YUv654RyYuFdjQ2gpLBoqT9
         gDbJJ2lXETHKevT0XOoztYokD3y3EXA1DzwitUG14u/OnJTP+9NAiEA0pZaZ+V3iiGNh
         rXVNSEwFrSV27KzT6LHpbM4QhYfZuYY8FdjGq7AW19cp7bdBbDfH4NU2C/qVJsjpAk4I
         sBKfK+YRQJuHF/MmSX8abxWaj1BmVFf/R29fNyVquEAFbTaKQi7/NxR9hjcfYiKsuQUX
         dUNQ==
X-Gm-Message-State: AOJu0Yz61paMGPuZxbnOKgiSvPee74yioHf9CBS2Bg++k2pza3hDlRGs
	LdZosCbz5OSACR5etm0MwhLrlfSsm9VHQInzgznpPnqUKzE6KMP4bYjUzjvRsw4=
X-Google-Smtp-Source: AGHT+IGcoGZSm0j66xHeh5I/XpHaF9NpKnulDNB/5oRQ2nBor4inlNLWRH7CdMmjFZMybVZVU0Mnmg==
X-Received: by 2002:a05:6870:d14f:b0:255:2e14:3d9d with SMTP id 586e51a60fabf-2737eeb59d1mr1947522fac.5.1724237421153;
        Wed, 21 Aug 2024 03:50:21 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6db6sm9652521b3a.20.2024.08.21.03.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 03:50:20 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 2/3] bonding: Add ESN support to IPSec HW offload
Date: Wed, 21 Aug 2024 18:50:02 +0800
Message-ID: <20240821105003.547460-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240821105003.547460-1-liuhangbin@gmail.com>
References: <20240821105003.547460-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, users can see that bonding supports IPSec HW offload via ethtool.
However, this functionality does not work with NICs like Mellanox cards when
ESN (Extended Sequence Numbers) is enabled, as ESN functions are not yet
supported. This patch adds ESN support to the bonding IPSec device offload,
ensuring proper functionality with NICs that support ESN.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index fe10ac66f26e..2fffc5956545 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -650,10 +650,35 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	return err;
 }
 
+/**
+ * bond_advance_esn_state - ESN support for IPSec HW offload
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_advance_esn_state(struct xfrm_state *xs)
+{
+	struct net_device *real_dev;
+
+	rcu_read_lock();
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
+		goto out;
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
+		pr_warn_ratelimited("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
+		goto out;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
+out:
+	rcu_read_unlock();
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
+	.xdo_dev_state_advance_esn = bond_advance_esn_state,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


