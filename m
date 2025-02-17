Return-Path: <netdev+bounces-167060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0216A38AA2
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC78216CF5C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4F226527;
	Mon, 17 Feb 2025 17:35:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E7155C83;
	Mon, 17 Feb 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813741; cv=none; b=sdRdnSTcFVMTBpFWtWjF3VJI+dUITF6f9woJ6YUd7X+oZAm4Iob1h35ZR0VfETuFvhs+/WCvevO0up4SGZm3QioJamiAr2S5PYHt1RUApFsfThiJsTip+68AXst6oarBr4VCQJRkqB8ptCdrB18vYVsDj5UXw/7JDS1hdMi41RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813741; c=relaxed/simple;
	bh=BgnBtj0AzD08lsBgQi/Fy+pFTc/k9LphVoW4UhhzNWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rbrbzf091psMpSR2Y0782owLD1PeXN8YaRCCLY+UX8Oo5L2pvQFKimW54BrTgqWX/h1YoQnYnuBNTjOTZjLzlSvf1VlyZe5cBf1fwxlGRMdOGEaW+pOPHHYg7VNwFj8ltA2eu2F6WFXfkyYR9wPsxX3tyk5uVqI/VyeEWaGoE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso2498436a12.0;
        Mon, 17 Feb 2025 09:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813738; x=1740418538;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wdTgNt+Iy2o5XOobnlWxTXZJvjvFsPgj7DHE12+wko=;
        b=YfCh75coW2X9Y+fF2qKaAQlBUKdq4u7BObkX4CgdbeXfAFXeh/X2XBWpn74hBJyQJQ
         RT8shz18eX5gK5X+gZIcd2hMvOpT4ZMpLp1Vyg7RRYdE0RaKafgrgsGmapgzdL0lbJt5
         0iAGS1CwRWNeDqE8NtCpTHk3n6ILN8v4sCvvrTb5LkmafNovVZVy2r6UnKlT7qyU6LK+
         9G3FJw7jz5xM0hNjCaUkJDjD4w8qeb6wbn2qkwev7ABbxtE14mOZiUTRO6menUjItWgo
         4YRDZvMI4UmTzhQD6MKT3BP2OSko+O/I1zqAjKGwiICRBUHefw7VLXKODIHdAYmx9Z2x
         BvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBhfSrkdreMvnrNf9jPKND2OssJSWvzcXDN0lFwX28Qtzz2lOFRoiWBdwx/UuCmVxUOwQk2zIHjaC86RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoadhvoF4g+HbS3umuipqlUAFE7PuMxB+H+6SG9uHqKdCixUax
	DicJkkV/ImXtLd3k/wuUCuPiYs6PqPOH5P703MfbNjTfjDsbCTa1
X-Gm-Gg: ASbGncvd4haGCfDd5O1T3uvHYLCjSDQzLieosHlQ47XIMozLIS1kWyw7eTvhoaNFt08
	fkRm13VJjvuTnftQYxGRrlglrEU6rFLG85Nt8hok13ZJiUKZFQ/hxuCCe0ZII/HKHk0LXcfQz49
	z1Zu92AOKzYSRyrqRdHSCbv2DoVP7yRQdTdIdQkj1ghOpbTMu+s4RXoeX6PjjXIc0B1P7mHTxfo
	tXgiz1Xyq6ng3EsJnu6SyCOA3AdvpD7s5FDwNS8c8vMkVjLeHkDHEGCrtYhh/N7794wu02Axr2m
	q/99dhY=
X-Google-Smtp-Source: AGHT+IHprE12LAaVCu8fGVpg4YYkFOPV3lcnrQmbeJZijmcnV8wJnwMKZ1d1ve13MvfTv1liC8gtrw==
X-Received: by 2002:a17:907:3f1e:b0:ab7:ce7a:dfc5 with SMTP id a640c23a62f3a-aba510aed36mr1870965066b.19.1739813737225;
        Mon, 17 Feb 2025 09:35:37 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532594a0sm931746166b.68.2025.02.17.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:35:36 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 17 Feb 2025 09:35:29 -0800
Subject: [PATCH net-next v2] netdevsim: call napi_schedule from a timer
 context
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-netdevsim-v2-1-fc7fe177b98f@debian.org>
X-B4-Tracking: v=1; b=H4sIAGFzs2cC/23NQQrCMBBG4auEWTeSDFZjV95DuojNbzsLU0lCq
 JTcXeja9YPv7ZSRBJkGtVNClSxrpEFxp2hafJyhJdCgiA33hi3riBJQs7w19y5wuLCz1546RZ+
 El2yH9aCIoiO2QmOnaJFc1vQ9JtUe/Y9XrbaaDSbczsF7uHvAU3w8rWmmsbX2A1KTVKWtAAAA
X-Change-ID: 20250212-netdevsim-258d2d628175
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 paulmck@kernel.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3583; i=leitao@debian.org;
 h=from:subject:message-id; bh=BgnBtj0AzD08lsBgQi/Fy+pFTc/k9LphVoW4UhhzNWk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBns3NnNeP6tcwk+pkhfkZqf/9c6mrUBSU1ZnZG3
 WkHZUGQHW+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7NzZwAKCRA1o5Of/Hh3
 bdaQEACXagu0zavpcSHTcNPWF9oeY4FNEPi+tKQWkAsS8vddsAkDZ3my6C0uUmQQJ0b2eDbSBP2
 03XtIFu4OU/u1q6c7zxe3oueU9I86uE2ZUYcfpU8ZgOwnvvVwks0BM/nn2wD4d/IkNYSH/hbeIo
 obWKAp+rUTa/Hgme0cZM08LHxO6D+q7TFbHyMBfsSYHn0W4byMv01oQFrLIv5/BkGSFTjQ0peRs
 AALPCA87mk1cnYgratk0ermqUuoqJxxXWYYsspyMv3j/QTnEAZNgHCC3fMnp63y2JSwt5uIn+gt
 eKBfbMjFd+fTx81szV1qP3oINoqWrwq8WFk6fmXxsMelOo66j8RZy6IupXzLhJftaikoUT3+l51
 l8b67TiPySY1dt8dfADD2NUA2+oYCbugoWVckYS/2zgmPeUL3WJVkYYqk2j4SsVjxtUNk/bavPv
 t4qxYMp1iedt6sDGQ2UKuC94iZ4TQAMP9k/0fCaybLcT/PDsJapzLYjkPQUrYshL1GYMZkStKEX
 LKHGWIMGSo69Uzq7cD2iVdPfckH7a2g2z6I2fMpzq/nb7j/hhU/GAL0AemjYxeYj9mKJDPtA1ld
 Kcc+GS0KKsrjVpn0HJQ21MjuxvMiFR8Y5c7ildqakSoPHAHb0/Z1FmzLa7Q1oBo3/ISVKLpN7Vy
 2MvKMnuaaFyXYrA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netdevsim driver was experiencing NOHZ tick-stop errors during packet
transmission due to pending softirq work when calling napi_schedule().
This issue was observed when running the netconsole selftest, which
triggered the following error message:

  NOHZ tick-stop error: local softirq work is pending, handler #08!!!

To fix this issue, introduce a timer that schedules napi_schedule()
from a timer context instead of calling it directly from the TX path.

Create an hrtimer for each queue and kick it from the TX path,
which then schedules napi_schedule() from the timer context.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- The approach implemented in v1 will not work, given that
  ndo_start_xmit() can be called with interrupt disable, and calling
  local_bh_enable() inside that function has nasty side effected.
  Jakub suggested creating a timer and calling napi_schedule() from that
  timer. 
- Link to v1: https://lore.kernel.org/r/20250212-netdevsim-v1-1-20ece94daae8@debian.org
---
 drivers/net/netdevsim/netdev.c    | 21 ++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 9b394ddc5206a7a5ca5440341551aac50c43e20c..57e4ae386e44a9c3f72afc37a3a59d3a504ebad3 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -87,7 +87,8 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
 		goto out_drop_cnt;
 
-	napi_schedule(&rq->napi);
+	if (!hrtimer_active(&rq->napi_timer))
+		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
 
 	rcu_read_unlock();
 	u64_stats_update_begin(&ns->syncp);
@@ -426,6 +427,22 @@ static int nsim_init_napi(struct netdevsim *ns)
 	return err;
 }
 
+static enum hrtimer_restart nsim_napi_schedule(struct hrtimer *timer)
+{
+	struct nsim_rq *rq;
+
+	rq = container_of(timer, struct nsim_rq, napi_timer);
+	napi_schedule(&rq->napi);
+
+	return HRTIMER_NORESTART;
+}
+
+static void nsim_rq_timer_init(struct nsim_rq *rq)
+{
+	hrtimer_init(&rq->napi_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	rq->napi_timer.function = nsim_napi_schedule;
+}
+
 static void nsim_enable_napi(struct netdevsim *ns)
 {
 	struct net_device *dev = ns->netdev;
@@ -436,6 +453,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
 
 		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, &rq->napi);
 		napi_enable(&rq->napi);
+		nsim_rq_timer_init(rq);
 	}
 }
 
@@ -461,6 +479,7 @@ static void nsim_del_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		struct nsim_rq *rq = ns->rq[i];
 
+		hrtimer_cancel(&rq->napi_timer);
 		napi_disable(&rq->napi);
 		__netif_napi_del(&rq->napi);
 	}
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 96d54c08043d3a62b0731efd43bc6a313998bf01..e757f85ed8617bb13ed0bf0e367803e4ddbd8e95 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -97,6 +97,7 @@ struct nsim_rq {
 	struct napi_struct napi;
 	struct sk_buff_head skb_queue;
 	struct page_pool *page_pool;
+	struct hrtimer napi_timer;
 };
 
 struct netdevsim {

---
base-commit: 0784d83df3bfc977c13252a0599be924f0afa68d
change-id: 20250212-netdevsim-258d2d628175

Best regards,
-- 
Breno Leitao <leitao@debian.org>


