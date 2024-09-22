Return-Path: <netdev+bounces-129177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C73B97E22A
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464501F2123E
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4451B663;
	Sun, 22 Sep 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c9jvbamp"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B42581;
	Sun, 22 Sep 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017755; cv=none; b=HahqqQxJaOxI/9IprSRcRJBwjJZu2mcTA654L/hDh6DU6l1MNCAJw//vf7kpH9Di0hoti2BzF1v6avWVpyhvPDJchLr004A08RkNNbqLzSkdc45haDva9Udd//M3BGS/f8Di0u5iyd5RBtqGdpJAe/cfrHZbHQxpYGLBoDhPdSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017755; c=relaxed/simple;
	bh=mwoFutD8GXwZ66Wwu9oO8GGsBjXliRczAJwqjPAvDw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDMBP4sI6eoYPQWPqZSsl07jjZlp7IL2K3PgTmEeMT9+RLZ23GfVDXhHyU5N7fTUWeBf1ciUdqoR6FyvIhc0dUlWYQb8RvhfjyQqGEHHDVmiP+Q+p+W/yIvQte3eF/qCHgD0MSQGxROJQpX5qDlIClKRa5TgowDl93q89t8+VtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c9jvbamp; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2m6EA
	raoDl//a0mxAh04bE95Qd7Q2cA+7EgMLMpLMaA=; b=c9jvbampGQd5HVeq2HJ9S
	ZbKAVq91Am47SA80nL4TlTM2pEd5J3c+cdxryXKXHDXsQIimjZusp0GUlVG/YznQ
	q9p6tChu62gM1NBHmWj/ayKatraXoh4VXv9UAB/T22sohs7UAFB0taG9P9bNOQWf
	Z+B9jQMbh/13UP3MplIXN8=
Received: from localhost.localdomain (unknown [124.90.105.166])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wC3_y3GMvBmr3lMOQ--.42972S2;
	Sun, 22 Sep 2024 23:07:59 +0800 (CST)
From: tao <wangtaowt166@163.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tao <wangtaowt166@163.com>
Subject: [PATCH] netdev: support netdev_budget for napi thread poll
Date: Sun, 22 Sep 2024 23:07:46 +0800
Message-Id: <20240922150746.185408-1-wangtaowt166@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3_y3GMvBmr3lMOQ--.42972S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XryktF1ktw48GF1fCw13CFg_yoW8Jr48pF
	WUtFyUGFWkZFZrCr1UXFZ7X3W5t34kWa42k3y7C3WFgF1rAr15JryUtFy3JF1rZFZYqFy3
	AFs0vryxW3yfZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piCPfPUUUUU=
X-CM-SenderInfo: pzdqw3xdrz3iiww6il2tof0z/1tbisA9i8mV4L6sUJgAAsE

For napi thread poll, we expect the net.core.netdev_budget to be available.

In the loop, poll as many packets as possible to netdev_budget

Signed-off-by: tao <wangtaowt166@163.com>
---
 net/core/dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1e740faf9e78..104a17642842 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6876,6 +6876,7 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
 	unsigned long last_qs = jiffies;
+	int budget = READ_ONCE(net_hotdata.netdev_budget);
 
 	for (;;) {
 		bool repoll = false;
@@ -6888,7 +6889,7 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 		sd->in_napi_threaded_poll = true;
 
 		have = netpoll_poll_lock(napi);
-		__napi_poll(napi, &repoll);
+		budget -= __napi_poll(napi, &repoll);
 		netpoll_poll_unlock(have);
 
 		sd->in_napi_threaded_poll = false;
@@ -6905,6 +6906,9 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 		if (!repoll)
 			break;
 
+		if (budget > 0)
+			continue;
+
 		rcu_softirq_qs_periodic(last_qs);
 		cond_resched();
 	}
-- 
2.25.1


