Return-Path: <netdev+bounces-178198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110AEA75784
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C0E3AA44B
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA35D1DED63;
	Sat, 29 Mar 2025 18:57:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1461B3927
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274630; cv=none; b=mmfUXpRVlSkfWYg/MJnbfBRM1KLGJkprkcUQ517LBDO9TpprOlxd3VpftoZmB4YX3Bq+O0nXGSca4JPKmbh5BQIJWD+9YLzseLLtZt0U4/7Fi1drcjdwbLkjpQQa9uSowGAJ6NhzyEBpsAxaBlMJZtjC3bZLP+dPdnyYZmcq4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274630; c=relaxed/simple;
	bh=pHF1H0eRpuVjSrsaH/3OXo2Gg1tjFfCNVU8wL3vaQkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+W+kaCfvn98dhXSib6SVDGFFsXLeuz8/ZJgcA0yoevUIKtc37XnG/+xQBs3uiYNk/aYtLg238y7DX4Gzdl3shqK0lfFKnU/dM7BGrzDT3KNVkXJmZjyIfUDfCpglUUYSf32erZaFDZCULsVo/VoPberB7phS57dgrqTPLRp4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3032aa1b764so4142658a91.1
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274627; x=1743879427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH/yeg5CqGdASotNHaNY0+o7IF+PSiI928pMRRgk8/w=;
        b=ZckPL4GRmOXcixe+E6BpO/h/6B4LMFLCEyhOZuOsEbUCZ1w1vmBiwMDAivV3cCv4Ej
         1+xPa0Vo8fLSOeUkXzWtU/+hDB4x4P9V8YwiMt2NGHKk9pjKfvhlk+blHniiRpFMJP5d
         EiFfEzb1cBT9bd0UPecWCHvQYuDHRRv0W0UoPR8HsGmXzzwmPOfDI9TFwAz/qrkfn9uT
         aSGfewitc6H6uJ0dAkz4vcysLefjiBvDLdp70lbjHHaAIfkRzsgO/RtG9t7Allmz43rS
         OafcuVkK77KB/WgiYehdZHcDdDKuecoPJ2Zx9bqVawG3evgB1rvQuF7V9gU6lKv1hFIr
         c68g==
X-Gm-Message-State: AOJu0YxDjdfVUAURAuFiqSnnHIxDo8v4ZV6nh2QIW9LutkhjfmaV9P8I
	R1rMhc7Ab/8+C5Z+28i6lwbmBzcD+3m+LiB5XfCJa1wuPZQgQlCQeDzcDpY=
X-Gm-Gg: ASbGncvYpz3Gm57LBR0c5lgaB+S6qK5wG8Hk9qIDa8pjwThTyZOWDpO/kkX66S7Ezvc
	z2KaptmBjNgMdbU/SOG0ADGUIsBph1Lg8prDMrZVsRCV4XUR7RalWtEpaf82o0LwR14pq/fWs+3
	vPgQMN3WTtA7mUdz3rWR0WGGK5rSHJA0MnMBXAcl2rD/Uz27jKOnSbTAP2TE4JiQ5dj6JeUL7ut
	Hx5sObEuCqHgXWsuCojsC2b7ec551v0xAY1/anvqhaK3YOetG1zEYF6lw5n6Vl379JEr2UA6Qoi
	h7nPfS99UqVsJEKCl/1JJU3tc23GxiZ3FuxqPYNZSWdIdbKQQ5SOcbk=
X-Google-Smtp-Source: AGHT+IGIZreGMChS/9hMlzexNzMEnEOp90nQSCBr+V3BRR0cvlCA4nXMf/H+QJKZH4+N8bdGqcoU7Q==
X-Received: by 2002:a17:90b:5446:b0:2fa:f8d:65de with SMTP id 98e67ed59e1d1-30532147035mr5293051a91.22.1743274627302;
        Sat, 29 Mar 2025 11:57:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3039e20e4besm6397877a91.29.2025.03.29.11.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:06 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v3 01/11] net: switch to netif_disable_lro in inetdev_init
Date: Sat, 29 Mar 2025 11:56:54 -0700
Message-ID: <20250329185704.676589-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329185704.676589-1-sdf@fomichev.me>
References: <20250329185704.676589-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cosmin reports the following deadlock:
dump_stack_lvl+0x62/0x90
print_deadlock_bug+0x274/0x3b0
__lock_acquire+0x1229/0x2470
lock_acquire+0xb7/0x2b0
__mutex_lock+0xa6/0xd20
dev_disable_lro+0x20/0x80
inetdev_init+0x12f/0x1f0
inetdev_event+0x48b/0x870
notifier_call_chain+0x38/0xf0
netif_change_net_namespace+0x72e/0x9f0
do_setlink.isra.0+0xd5/0x1220
rtnl_newlink+0x7ea/0xb50
rtnetlink_rcv_msg+0x459/0x5e0
netlink_rcv_skb+0x54/0x100
netlink_unicast+0x193/0x270
netlink_sendmsg+0x204/0x450

Switch to netif_disable_lro which assumes the caller holds the instance
lock. inetdev_init is called for blackhole device (which sw device and
doesn't grab instance lock) and from REGISTER/UNREGISTER notifiers.
We already hold the instance lock for REGISTER notifier during
netns change and we'll soon hold the lock during other paths.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c     | 1 +
 net/ipv4/devinet.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index be17e0660144..711a946d4bfb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1771,6 +1771,7 @@ void netif_disable_lro(struct net_device *dev)
 		netdev_unlock_ops(lower_dev);
 	}
 }
+EXPORT_IPV6_MOD(netif_disable_lro);
 
 /**
  *	dev_disable_gro_hw - disable HW Generic Receive Offload on a device
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 754f60fb6e25..77e5705ac799 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -281,7 +281,7 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	if (!in_dev->arp_parms)
 		goto out_kfree;
 	if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
-		dev_disable_lro(dev);
+		netif_disable_lro(dev);
 	/* Reference in_dev->dev */
 	netdev_hold(dev, &in_dev->dev_tracker, GFP_KERNEL);
 	/* Account for reference dev->ip_ptr (below) */
-- 
2.48.1


