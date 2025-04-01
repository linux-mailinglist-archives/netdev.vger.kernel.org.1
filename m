Return-Path: <netdev+bounces-178650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B53A78091
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFEB1887681
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E820D502;
	Tue,  1 Apr 2025 16:34:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1E207A23
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525299; cv=none; b=C6akVpRKjSUVyic3TvG98NkHEcUUXoncSDSTvNwz+UizvRDuHzBjTrTxGmpxEtnwjYorhnhSerynzsOuWgY491FLrSKvuGGDlhrlXiNuouGh/BHgkVYmUahuF+iNlbJYrWQnS1LEGTE1ExPBWTeUSWG5JBIpsnhEBkmRpH/n5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525299; c=relaxed/simple;
	bh=lVli2XcpkFVkj2pcszPjwXfUE4AKc4A82mHJobVKVs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxItCEo5fsV1mJTA5QSKMHFboyhOvwU2S6rZgZOd6mru60ubBxQ1Tz8z79htqmAr9cz52UtQsnQ5Winoi2K7wjy45G+J2PJq/EMBqQLf8zlEdOXlzMHzdQDFj8hZvIvXtqan1fTVcA89ccCG3h+5ZKTfeoTAFVD8SheG1Hcf4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2260c915749so81436395ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525296; x=1744130096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GUgZG5VvzNgh+1mfB+3OA3fyiAKrjf6aeYdbDZGI6c=;
        b=IbjsZLGrnK1F3+kt7y8iNTw/zPTN5ew6zx4FmUuzLWvelZvvlh1uSNNHrUezg7DWjw
         f8ApwnPQznNIhVLlv1gjNirkkuW1y/4e2xOfXZwEopb8dg0qU8fBg93Wft4aaSdIQS07
         C7cUdVJc09iWVeP35d9z9FtvQtUkCLSRDjkcVjYfmyi/9PLUnuaWutl9dCtOV1yVEblN
         nI3mTNp7lROF1cIwr/qiPrPE7Nj1RsZSuCT+LlxkxDJdstJq6pSHkjUhfjRWkApkmbcS
         v7Fc34XsoARVsXEll7OfFA3oorWrtusJ90Hsx6TqXfxUQ5zYRJyFr3dqp/znEaGrPYkI
         3SOg==
X-Gm-Message-State: AOJu0YwQ8CpOQn/nZzxYKRSLaYuE5zXSJZ0x0XftpW2hamqVXO7Y3Q1J
	BHoYpoMKc9PUdwRWexYOFOpMqwtfUHuW+cJplSdf7DX2LcMtAly/p3PC+BuEtQ==
X-Gm-Gg: ASbGncv8uRS33B3xhzT10ifisjSNc4PuKKPckZK9KMbG+AvTdmLil6aumsfuScb2Okx
	4Rw2AZ8djLlIP+cMoHG+pN8yH30Re5Nvm/RlKiOUzKdmRGlQzF6t8MAfpkYW1BAsVLmr5xFZtca
	vO6bSIWr1392wcd+T1p+XyKkXnCb1IeE+GDXGr3jsBO2n+mVS7t6M6Oz1jkyd5LKHm3dmHJPe1N
	2osaJyAyWtxNWwIQnef18Ol7qWyECUym9bO9xzqCePmyMDkkW3XUEAVkXmhh8WU2Jp4QnkWRs4d
	chs82ERv4fRSsBMlGXnemohvkP8ZMQdDPx8sLIqgJkws
X-Google-Smtp-Source: AGHT+IFpxZZiMKAj7OlrMAo62Gmsef1aRBG8SEzKtVE7wjd+zfG1dVDB0uepw3vsimVEWR1d5BYuiQ==
X-Received: by 2002:a17:902:d50a:b0:220:e392:c73 with SMTP id d9443c01a7336-2292f95f2d2mr238151375ad.22.1743525295586;
        Tue, 01 Apr 2025 09:34:55 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73970deefe4sm9097734b3a.30.2025.04.01.09.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:34:55 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v5 01/11] net: switch to netif_disable_lro in inetdev_init
Date: Tue,  1 Apr 2025 09:34:42 -0700
Message-ID: <20250401163452.622454-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
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
 net/ipv4/devinet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.49.0


