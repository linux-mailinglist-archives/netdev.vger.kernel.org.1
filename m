Return-Path: <netdev+bounces-119949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEE3957A9C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA87E1F23BB1
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A61E541;
	Tue, 20 Aug 2024 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObXYXMuC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F319478
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114948; cv=none; b=sjWKD4q7xr529cPzVNi/1h7waSU2mOoJCd6aj00wN11VbdbrbnkQPpiXhfUMHiZCkgR7ESx/0TKrjPKq81PbSs+9blvj/Au1lxcojJBddY3gQrPKnXoZRianwcWH6VXHSLkwdhzyNcXNoL55+XO6f7HYoJHmXbu1d2+N97/D6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114948; c=relaxed/simple;
	bh=0s+SKheHmDsntXrpZ41L4KTwsIhFZvohAAJrkM5ibx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyrvcYImlRYOdXlbrDidmRf/GEp1PxLkAXbOIy4I7DEWmvmYZT3pmMPcIfmq/cfv0rQ5RB47jTvAq88jrOyqdvo4daXM514ki9hUAFjKCiJ3vE6zFhju0xdQCGQOaA1K7B6hrPWhK6PWLNKkQuK08tp4CakEcZRVfpuHpFAKwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObXYXMuC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20219a0fe4dso21899695ad.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 17:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724114946; x=1724719746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvEsBVaU9vacqW8jEWHgaimLveKbFN8Ava8ep4RfZhc=;
        b=ObXYXMuCFdN9EjNB7GnMmQWbPk3KRcvIJIIE0mXV8yUfT7OWNQKEIb9CWg4/aFZ0BI
         46FwuYJXRLN32fzyEIr8QZc3FD9tFIyKxjmOhaS2JU3fz34BQdc48a07LON813i7Plru
         uXYdAKef8giwvbeg1l9F/L41g9adtAzv6i3nS2TT9ncaNKa/H0ya/eit7VCKHiVxGPXD
         3zM2mIevKORSQztGEiMU7OZxrvoYEDvP+qQF98tTAW+ihEMVALnk7GeoShqDVwU2dgdi
         7SjK1ScKfPVAfW/9wNP9lSrFie0utuZR4FOdAUuX0asDOvZBJ2g7kio8MxFFe/FnTTYL
         bEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724114946; x=1724719746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvEsBVaU9vacqW8jEWHgaimLveKbFN8Ava8ep4RfZhc=;
        b=QTGCAsD5iEV6jec0VSdh7+QZK5OAoAs2R2ZdFEokOQUHBtVOwU4VvzC3ijTrdkfBn6
         CS5DCUz+RjuG5pYaZLtx0pmB4DrUQCdah0oK1qQSYvNKfKVwM92M0IX7pyQJGOK3oPMS
         zKxOAg4d/Si7XvxvqcArDokfmHwF3R1UiOQm/by5J2kAAIr1hUZNgCvCpLpwc7Hd6FAn
         CrNkffJjZxwEb2MVFFxL1mljyt6Mak+iokn43Boqx+GY1TNtPGQxeODRNe8mle4SuoRW
         DQfngtVwHtosnyr4NjGeCJOwbC8NyzaWVj6BVybbmT/RuJK7a1AQOlwzu/4G9Kg+1QjM
         O39w==
X-Gm-Message-State: AOJu0Yycpks/TGtAD+DJGD9+IHkHJbtTYwZVHJrMPE9J8UdCVuPZTPtz
	IonkC/tFTGiKL4puGlC66UfrSisGZ8nk10ThGJmk4WVXPPXWzzsaMMILmq4DDTQ=
X-Google-Smtp-Source: AGHT+IGzNdO4WMK/r4TPpAJt3zg9m23EtXpUlrHfuS/iNZYLdK2Zq2FBWPgH/BSlYzSVB/QlAjwgtQ==
X-Received: by 2002:a17:902:d50d:b0:202:3469:2c8c with SMTP id d9443c01a7336-2031517c8e6mr11562545ad.40.1724114945752;
        Mon, 19 Aug 2024 17:49:05 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0300522sm67861455ad.6.2024.08.19.17.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 17:49:05 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 3/3] bonding: support xfrm state update
Date: Tue, 20 Aug 2024 08:48:40 +0800
Message-ID: <20240820004840.510412-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240820004840.510412-1-liuhangbin@gmail.com>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch add xfrm statistics update for bonding IPsec offload.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 24747fceef66..4a4a1d9c8cca 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -675,11 +675,36 @@ static void bond_advance_esn_state(struct xfrm_state *xs)
 	rcu_read_unlock();
 }
 
+/**
+ * bond_xfrm_update_stats - Update xfrm state
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_xfrm_update_stats(struct xfrm_state *xs)
+{
+	struct net_device *real_dev;
+
+	rcu_read_lock();
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
+		goto out;
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_update_stats) {
+		pr_warn("%s: %s doesn't support xdo_dev_state_update_stats\n", __func__, real_dev->name);
+		goto out;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_state_update_stats(xs);
+out:
+	rcu_read_unlock();
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = bond_advance_esn_state,
+	.xdo_dev_state_update_stats = bond_xfrm_update_stats,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


