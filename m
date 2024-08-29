Return-Path: <netdev+bounces-123190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7629D96402E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C282FB229C5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED7618E35C;
	Thu, 29 Aug 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp38AaYd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20718DF69
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923920; cv=none; b=B4DzQ4x8g9b0kRSE34JKzXkJqIYdHLcm3rMw3C3pG87cwJkpsdyIyl+ZA58e24QlE8b10oP0hajywUGzeBnpBBvTzv1WprH1JZfZ1Y5PC+AE5yt2qcWFeWMfKqIDdgjRQvibyvxwnVNHmSjcebdR0XfSWg3b2fVfjIvgbPTVrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923920; c=relaxed/simple;
	bh=68XUardSUckQHYyfMhUALNt1L0KrfGhAAB+I/H6w2Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQyAl1Sjjcmshbb07lEdqppL7l4y9RA3GpKsQ6ftObZCRZrLefyZWh+NDNij721VyvV9svxKtv4XBRKPfUwIMBTB1FF4adW9CvyOD5dqWampyi/G8/WNSbMdKRC8+j4hQSf+HwQKQZvLfiJkk1pDYFj1uBloCTqnyqEisz84lVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp38AaYd; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70df4b5cdd8so304506a34.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923917; x=1725528717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uu6a/TmKbClbhkXYyeBBpO+MmkyfaTsSMktSnKqxaG4=;
        b=Bp38AaYdQZ2+r/snQqie7OO/S4mbVW/Wty5OXP9HuWD5w2BfNtmzKtPIJUJzeNX0Fu
         9ioFOMVBNlwrSDFmCAYZJ/b+lzN8Hd+4n9Eq78cpbDn+zW58QRserqdXTth8iNdXyTWN
         thIlgwSpjYhIRn0UHmT3Z3pp9O/AZQKXne4ONxLdus9nQWZU97CfiJuz6U5pqsiDAeZp
         3hM2xSXtVdbFYD4wd8pdD0lWR3qJPbKDzWde2m738o90OzYJotNSJf33sIThFG9YU5O/
         XuZ0T6YBV5SW6NbcDcg1yFK8iQqaJn1WMwftPUxMxbsMn/2/RyB5vAkX24a4k1/zfD6O
         Sz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923917; x=1725528717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uu6a/TmKbClbhkXYyeBBpO+MmkyfaTsSMktSnKqxaG4=;
        b=o3FFhm0vWH4Es7VsQ09kvN9Zqd4Zh1VtuL1NPZhR7TkvAirYWP4WcfpRbyRoj2kt96
         M8f/uaTg+T2aIJo0jIz85/x/FVSemiGxuGv2lOgdNidXZNSDlRwoSkjh9dpo6ejLprUc
         EbO2Avi3RI7GSRd5B0Levpq291uinyIkRdZRCA8tK1eCEH5WF/evCzp4GiI+Q8aN89d/
         OMjr5IrzGlFRYuXTw3b59+SVke1WgKVm+P38/BUww2EoIwQvxQx+9jNJtlVUrtxtsNMJ
         n6AKgwEsO9mDHgFpFCHSQIhc9/ROnvSyagY6yTJfSIxWMBjgZNm4CjoYGIPB2OsgTgIh
         oBKw==
X-Gm-Message-State: AOJu0YzdeLVGxW7f6Sn0TmW1Wy6HLGhtsgLirNFDTkuSMzyaYNkil0Ag
	L0qKvbL8ULTB0sqoqIPUFOUHbDWBMlZOnlZJjS61qx7J90sfLAdxXZlov2p8oUWikQ==
X-Google-Smtp-Source: AGHT+IGlPThBRVDWM9pi9MUygktSqEaADY4R6Ht0xvwOPsEwW2dcbjvI3LTh/kpJAKcjfnrAGNs5zA==
X-Received: by 2002:a05:6870:c151:b0:261:236c:2bc0 with SMTP id 586e51a60fabf-277900c6be8mr2710485fac.13.1724923917292;
        Thu, 29 Aug 2024 02:31:57 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575c417sm743276b3a.197.2024.08.29.02.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:31:57 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCHv6 net-next 3/3] bonding: support xfrm state update
Date: Thu, 29 Aug 2024 17:31:33 +0800
Message-ID: <20240829093133.2596049-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829093133.2596049-1-liuhangbin@gmail.com>
References: <20240829093133.2596049-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch add xfrm statistics update for bonding IPsec offload.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f0d479c95dd9..79929a12fcb2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -672,11 +672,36 @@ static void bond_advance_esn_state(struct xfrm_state *xs)
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
+		pr_warn_ratelimited("%s: %s doesn't support xdo_dev_state_update_stats\n", __func__, real_dev->name);
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


