Return-Path: <netdev+bounces-172456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E6BA54BDB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAAB1898290
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4350F213236;
	Thu,  6 Mar 2025 13:16:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4E211469;
	Thu,  6 Mar 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266991; cv=none; b=YUezALA8s25TeRneGpbFdNm26b3Ba6/TZp+sVum2gqSZc+rSWRkuBg9XABKTWd79ulz9YVKEKquPWfm7BWD1jt3jU0pnzHzP1KMbmp+gofagM1O9Trt3cGNoZEC8MI8jTEJLw3v+TrutXQ89JKDJ8IbuK4dDUcS6tm0q85Qepx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266991; c=relaxed/simple;
	bh=Id/YqAO3zpxcKmfd61Fz8/37PE/mK6E1qlRG89GO/lE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oZVW69HiLF6AfBtcrL4GHSrCkXf3G6EGIoYBXKQN9GqLuFdCEEr6A2dqD3zK0MEBMYzDs561pDQgvA4TIznuxW0DwNB5kkONxt86QTWtP/1kF19Dtg4SCn20+YiYthCJpUXdinDRlRluYQxpb0dsNgedGmKrdf5+9n479nstPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso941340a12.2;
        Thu, 06 Mar 2025 05:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266987; x=1741871787;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCEwMcpguVILuRqhPxpMN+D94R4VwDza0OZembQSer0=;
        b=X5erX6LkpCmP9ULOxt1LaSfv4pvlazwqvoSXi9lRzm1HbJmul1t9tEB47KZmg8fERU
         t//UjNV5YfFxwtiVUsCkM0XIqS32kQsCtyl3xloJheWbYtlfujJKpuqrh7AoFXF7+zSe
         YghRkeVjAmNov4Yn5CLNNljC1c1BPxGgYpArKULVhAsmaCxEA6kFxCA3pwwa0ptMozUj
         OP5ag0HBVN0fR2yOnwXvZfZBHO7R2n7gKjSxi8IT6BqPrPwd1sY/UTnBuraqBUbqG0JI
         K7h6bB7E1WixldO6L5CkS45AK22+Lq5UrWGctCFJWoCRAuDFGiTZo9/WXyMLryFmjSQv
         ZlTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPQtpBMRsAQp/HKhuipSAudW6HMeQGu28MfgcN/KAi7YX3J0OSjXHIWiY4PMpdAbpIMY00sUuBE462V9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWCgbVBlG04T340z0IKbFnSktIdJxyu1eNJf+qnI1vqKT+D3j
	Y/c/rZiO+4B0ltHoAmjawnNAZmxXxzsXOoQkj2liJLKrpDMtEz3A8pifbQ==
X-Gm-Gg: ASbGncuPwj6RcW2vrv3rPEryw1JM7dPOSyInxMRbPXlWMFNvrTQLUrskeoC5je6rlM5
	ITXmdwuoxMekbIrk52UVXEkJyd2TJTKbWsj0C8JzCC4VyvMC+07XDajVhnktW1FKdiMOVoZAHYW
	s1MXk9ZxZ1QLJ7jFkaJvgEeML+ww99/W4iQqvONChFfsDHt8R4gEMVthTAotj3cqZFXCWzzbCu5
	pvLBnjuRSl+n7QMgIswPFgxRNOZZ2dzJ4ea0VWXdVbW2pgIXv8YGB5dHZ82uXGU0x1EdcaV0r7g
	5mb1UU8IHFicd1zgxazT/1tAz9XwynKJQEJK
X-Google-Smtp-Source: AGHT+IFufcaw8qwbnHKO1xusmGK7yPkQTo03GQWWeQsSxaOc6Fphrc2FVZdmaNXHcsnSQqTzyYSfiA==
X-Received: by 2002:a17:907:198b:b0:abf:6f87:c720 with SMTP id a640c23a62f3a-ac20d94a4bemr666410266b.29.1741266987065;
        Thu, 06 Mar 2025 05:16:27 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2397363fasm94937266b.102.2025.03.06.05.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:16:26 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Mar 2025 05:16:18 -0800
Subject: [PATCH net v2] netpoll: hold rcu read lock in __netpoll_send_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-netpoll_rcu_v2-v2-1-bc4f5c51742a@debian.org>
X-B4-Tracking: v=1; b=H4sIACGgyWcC/3XNyQqDMBRA0V8Jb21Khg7iqv9RRDK86ANJJElDi
 /jvBfddXzh3h4KZsMDAdsjYqFCKMDDVMXCLiTNy8jAwUELdhBaaR6xbWtcpu/fUFA/oHwqtcLb
 X0DHYMgb6nOALIlYYOwYLlZry95w0eaZ/XpNc8rvVV98bIYNRT4+WTLykPMN4HMcPq7vQtLIAA
 AA=
X-Change-ID: 20250303-netpoll_rcu_v2-fed72eb0cb83
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Amerigo Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2349; i=leitao@debian.org;
 h=from:subject:message-id; bh=Id/YqAO3zpxcKmfd61Fz8/37PE/mK6E1qlRG89GO/lE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnyaApynwTtXe9hxL6ZEj+q1834fk/uLfSyHulz
 +ycL+I0IJiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8mgKQAKCRA1o5Of/Hh3
 ba8vEACjT3zJbVPv2G4S03YDiL6fNJhhH2p18xOMxykOUMFmS3d8S68f15wvoeYql1chIPv7Kz4
 /d4K6yBGRgKd6r85ZT6DCNwIVzgOHUe+ZZ/+p3ksyF9MZb0lrBMMxfpnucALPoqXCYiXAT38Nv3
 sGLa6GpHgb++7HxrMYdNis9Q1VEqfBRfCinITCaTHPUoHOQto5h60RyvcHoC+e/TC6LF6C7ZbQb
 TtMSMJZ5SFlK6TdoFerQH6JMZGo82uz0HeNEOwkPgvasjjDk+87IM7HKCVyDk6IEruCWZbUv6Sx
 tF8Rib+o87gy0IdAtWomMSQIjLvL7NxKIb0qFLcUxqa7fvw4LQuoSJwj7WEepoVcV1igNDmgjgc
 pXDJXxWRoDu4mMHgCMHjETPn20ukJ2600noebqpkDPwh4gt05HkrI8h8cU1zEx4LhsHT9pK0S06
 qKSBvZp4jpRFNiqK2GqkRB2kTI2OKTbqR7gOBcszrtCwMJaS3WDyIdrY0+XZb/unDjhrfOa+Qya
 XIJjTgRH+4L51TsNPnb9wiyNv54VSunc4gPpWg3oO+Ag2azEIvprH99YRFKRcjFFwrumkxIh2l/
 0EHTO0bpRxPMeZBWATFFCvYWRxl6ywrnBix9IW2vQeWrGY/wghWyULjPSvB2gFP6Ch2ZQjzj7Al
 YoLOnZiYr1FRa/A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The function __netpoll_send_skb() is being invoked without holding the
RCU read lock. This oversight triggers a warning message when
CONFIG_PROVE_RCU_LIST is enabled:

	net/core/netpoll.c:330 suspicious rcu_dereference_check() usage!

	 netpoll_send_skb
	 netpoll_send_udp
	 write_ext_msg
	 console_flush_all
	 console_unlock
	 vprintk_emit

To prevent npinfo from disappearing unexpectedly, ensure that
__netpoll_send_skb() is protected with the RCU read lock.

Fixes: 2899656b494dcd1 ("netpoll: take rcu_read_lock_bh() in netpoll_send_skb_on_dev()")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Use rcu_read_lock() instead of guard() as normal people do (Jakub).
- Link to v1: https://lore.kernel.org/r/20250303-netpoll_rcu_v2-v1-1-6b34d8a01fa2@debian.org
---
 net/core/netpoll.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 62b4041aae1ae..0ab722d95a2df 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -319,6 +319,7 @@ static int netpoll_owner_active(struct net_device *dev)
 static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	netdev_tx_t status = NETDEV_TX_BUSY;
+	netdev_tx_t ret = NET_XMIT_DROP;
 	struct net_device *dev;
 	unsigned long tries;
 	/* It is up to the caller to keep npinfo alive. */
@@ -327,11 +328,12 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	lockdep_assert_irqs_disabled();
 
 	dev = np->dev;
+	rcu_read_lock();
 	npinfo = rcu_dereference_bh(dev->npinfo);
 
 	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
 		dev_kfree_skb_irq(skb);
-		return NET_XMIT_DROP;
+		goto out;
 	}
 
 	/* don't get messages out of order, and no recursion */
@@ -370,7 +372,10 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 		skb_queue_tail(&npinfo->txq, skb);
 		schedule_delayed_work(&npinfo->tx_work,0);
 	}
-	return NETDEV_TX_OK;
+	ret = NETDEV_TX_OK;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)

---
base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
change-id: 20250303-netpoll_rcu_v2-fed72eb0cb83

Best regards,
-- 
Breno Leitao <leitao@debian.org>


