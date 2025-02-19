Return-Path: <netdev+bounces-167792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B1CA3C54B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3358A1764DB
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E19C1FECA1;
	Wed, 19 Feb 2025 16:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644071FECA9;
	Wed, 19 Feb 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983299; cv=none; b=Xwd2FrTt6AJzAfMDV0yfiht8CXiK3+aEEyO52FFdAHxT6vWIuSYLLfBe/9nvJyql5UcmyGi+L0uapF5Zzpq2ZePp2b8DjBEgKXZTwZNVls9bdpwt2tlB+myH1XjmmrOZyhf/92QlB6L+/G3uffeb06tkcMwcSbVup6SjKHMIpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983299; c=relaxed/simple;
	bh=yKqC4ySa0GGYhnBuRaIQj26Sn1XtOBOC8Lq+InnucGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NNh/R6Y4y/+MQK241tSjf/BPaZkbTVHZlh9CytnCvhBZnlvkiiagbaeqDPm8BL4hLLznQVxHwwTup79DhAH0bREOjGy5lnTV4MiaHXJV3+8SyacY13LKQLSvQSZoD87JpEYTGh9EYjouuMb3/z1uZB4dtOdT1+mTd9yRDbaonTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7f539c35so4933766b.1;
        Wed, 19 Feb 2025 08:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739983296; x=1740588096;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfCwk0fcIEqa4ZcVJEGvI7w5MrLD/F4qjXaZqGHjJQQ=;
        b=odT58/nLOgO4PrL00/A8L0IXAxvg8HS1ufeL4i7yHOuaRZ0jl587yP6WIgtX5O3ijC
         4qhS5v0awbwsZDU/i5tWnYtTDp5pBslQXfSGUay28Fj/D6FCnWpl5ni9wbUYrrAabZow
         5qW7UYuOATxLG+bPkhdnWzhuL2w3c9etfJmGo5LPAkIpI7dm8lmUuALjIVJeGsbfhM/j
         3492tfBQegh8+GgAbKXFCJ4lUpFqd6C4w/69LBtFpqD6GhOtV1tuPb+IqPxAaQCTE/0s
         3iDFvCrdZu4zL/YVbAibHCz2xt1osbNuS3zEzFNmFCbWagPM009clxkwWqgDjs7qlR2J
         ulkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe1dQKmSAGV3bvES6I1qyi4EBF8dNzm6rq8UA6JLP0vtf8DXa+kg7KpD1jKRI/5gfgNoyxBHGTQQ578p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHeLoia1upa/4OXbEQdDaSH2yfrYYbtGMWRKgCNlsZt1a9Pd/h
	2iQHGlg72w3eV5htDt+JWlsgs7UcHNXfNdsAElWYr8903azqY2Mr
X-Gm-Gg: ASbGncvicnBNVVod+MkjItvIRarKVI5nEWRHUvBr4XP5XUVGLY7WkcxGz6B9rnGVeA0
	GpRTYxnNcvTTjWgoQCFiA9atkCrCmytI14g+1/f3UCmalrKSzhzz18zzi2gfK4StArGpbnz6s2V
	aJMNphX1YC6wOW/E/NmIp6QzTK4JsZCMJSjWx3eWo4u6euA1SzWKkVroHPemd0+oNh4Nfc7Bbtr
	HBpu4riz8hf/fayeHeuYF8GtsUKjpU+GhHATJy/hLZZ6DbjrIlGAur5qQ/TsVOfkb0qEB8MCUIx
	gvvL0g==
X-Google-Smtp-Source: AGHT+IGMqbBs9mwDkW+BmfLXoXJ27HtXA3PHEWUCUzurZDICTOEqCAt4PlBDvtw8KKKwGrJsDJWKkA==
X-Received: by 2002:a17:907:2da0:b0:ab6:f789:6668 with SMTP id a640c23a62f3a-abb70b1e60amr1811786866b.17.1739983295223;
        Wed, 19 Feb 2025 08:41:35 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532594a0sm1327405866b.68.2025.02.19.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:41:34 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 19 Feb 2025 08:41:20 -0800
Subject: [PATCH net-next v3] netdevsim: call napi_schedule from a timer
 context
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-netdevsim-v3-1-811e2b8abc4c@debian.org>
X-B4-Tracking: v=1; b=H4sIAK8JtmcC/23NQQ7CIBCF4auQWXdMGa1gV97DuKBlaFlIDRBS0
 /TuJqxq4vrl+98GiaPnBL3YIHLxyS8BenFuBIyzCROjt9ALoJa6liRh4Gy5JP9C6rQleyUtVQe
 NgHdk59faekDgjIHXDM9GwOxTXuKnnhRZ9z+9IlEitTzy7WKNYX23PHgTTkucaqbQkaojJZToR
 uVYKjXctPuh+75/AQ3rAOnoAAAA
X-Change-ID: 20250212-netdevsim-258d2d628175
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3669; i=leitao@debian.org;
 h=from:subject:message-id; bh=yKqC4ySa0GGYhnBuRaIQj26Sn1XtOBOC8Lq+InnucGc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBntgm9+9ihFOxpJunxmla1PEccV6PPjN00NryTu
 gIgTKW4VkaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7YJvQAKCRA1o5Of/Hh3
 bVKWD/9T21B/9atgWB6NZk0JFfi2RVremJMU1SxLhO47kfINTQpGGqogCEjA20vDV1+fLpLRMSv
 J/fcApremB3mku5ylmWp/UzF6rhvQBOzlFdrvHvoAs5Fznuz+O3ps53K1ufTpbypWeHd1yRQ5mz
 zuaY4Kq69opDOYvtVdnRu9916PzfBi46sn9K9SYSBhwNhe7+I/yjnjBMMlXpuB8s5MhAbDp7++t
 aB/dVcv9/Za+TmLGnpVzhslBSVO4IFh6C/psaw9jAI4qpT8yMJ9cpCSE/Gvim3/aceUW/xZ88Pz
 N4zEvLqOBRrdvvF9Kyn2MVd8O0Qv79zCpUTukJKj6LXgaHC/I3z6SEZTIsT05o8Qm1qi0qD08Oj
 WTkOoRqTHaksX5f4LXt32wTAcBOlurmpyyGRnZUZwKPvnzCGSmZWR+VEOp7DH53QvX2M8YI8QfY
 9+QFllWV+BTav6tOr9wn2fxKVSLfCCZiKHwzFdz/EEH8mv9MOK0f14LrGrtIWliO9ZJt2trN/qI
 syTWdccffzWeZC3DuLYwl8t3idZWeb17XxnlPW/5c1drsWYyvd3mcq+0ownjverzmXGq/N+fWbZ
 SM8c3k9aX+HM15DZb1S6sBK3P5KV7mak06Vh+lz1vcSPpCTh4JjMa5V5cqtZ/xykMz0gz2jLF08
 OS+euky/tXsBIwA==
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
Changes in v3:
- Move the timer initialization and cancel close to the queue
  allocation/free (Jakub)
- Link to v2: https://lore.kernel.org/r/20250217-netdevsim-v2-1-fc7fe177b98f@debian.org

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
index 9b394ddc5206a7a5ca5440341551aac50c43e20c..a41dc79e9c2e082367af156b10b61f04be8c41fb 100644
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
@@ -615,11 +632,13 @@ static struct nsim_rq *nsim_queue_alloc(void)
 		return NULL;
 
 	skb_queue_head_init(&rq->skb_queue);
+	nsim_rq_timer_init(rq);
 	return rq;
 }
 
 static void nsim_queue_free(struct nsim_rq *rq)
 {
+	hrtimer_cancel(&rq->napi_timer);
 	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
 	kfree(rq);
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


