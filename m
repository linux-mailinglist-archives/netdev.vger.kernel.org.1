Return-Path: <netdev+bounces-89821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C98ABBC8
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 15:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF56A281585
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 13:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F6C1CD3A;
	Sat, 20 Apr 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="posOXgQh"
X-Original-To: netdev@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070C3232
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713620396; cv=none; b=pykITsYfWXqi3ghM3jEJ44qeILwIfe76zhwRvS9ORkx0vknzsJfGvE6ORXnLphzgrfzgdVFNc3nsfKmXwUjPVTcNC6i917TtOJ10FLV2o9T1Y2sQCVvINFeYYfKhpZoRNrYi3VTsZc/JThTnBn6olRk6dgubWw2n/6cqL8fSdHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713620396; c=relaxed/simple;
	bh=1N5C9gCaAH1w1J6TqDuKvVRJjtR7xeKUR7pOpowwj5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcbmgCt+P+F55KnB10OdUaWNg+tg2V/8jV2VbwVc4qX5XnQG8AgN8MvtYbqTdX1knSZ4bXpiLs68M7UlEX7h4TLNiAAjLLpGhAEBuzFa+upCNFOorbLS7Jh8p/9gZ8p2TWrMYXRARa6j92vpWAjy9Od8jhV9nMHjXv5Bs/DIbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=posOXgQh; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 6609 invoked by uid 988); 20 Apr 2024 13:39:43 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sat, 20 Apr 2024 15:39:43 +0200
From: David Bauer <mail@david-bauer.net>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] net l2tp: drop flow hash on forward
Date: Sat, 20 Apr 2024 15:39:40 +0200
Message-ID: <20240420133940.5476-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.999999) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=1N5C9gCaAH1w1J6TqDuKvVRJjtR7xeKUR7pOpowwj5A=;
	b=posOXgQhymiCJVwQuSqOoW7p4zFgu00YdTFdRyQQhGRF+DsudbEk/d1WTeAhAIEVi7KK6nNfy9
	ec2ZzreZOr9bWp1hJVOHXMVfw2WpJ2I4OF7zUrlgpNe9Y1fNQ1+up91S954R+eLS8rDkKxvMUNGi
	wvrOmt43Q0OtS9DX14vNI/ghVO3rjASRJjByi8PFu6WUFx4EOApm0u5u/7qZnN8Kx4tF7G33HU3B
	uN/liMmifnSaVtHLoRnny42ggxc0tWmyLGRR0x1erffH1VYZVTkOhOKnaE3iEVDJUHN/8IqVZV8i
	OCfRTkOOttDI88HMS0r0GPoA7jDBt5sTxpPR+A5gZFu5tJfjkKk6xb6PsowwtZjkHmaIRfrlI1vx
	g9ucW0Sb89oNlsND89ekXjuWHom5bft1KceRSlrs6x774MOJ3IqUjMgz+VyHOvqcUZLi1Q/kWcvF
	YUHFEupxmhk27IW1uRLX4MWgaBDPdu6BXQ/oY7e7n9VwrO+YjP/uuJFj6dFULM8kVZLcecuNTh2K
	e82TM0rmAiwdPIYc1TTskHSE4OhJk952qCZvXB71KtmQtBIq13pP6jzgLXvX1Z6TBmN7cX2DVRfk
	23RsMNNtybeJYOpcZblPUDtrUFGvdF+VrdpeKgz8EwkTGUiogTY8rOdFDYCP3pDmVVVaF4JGsUQX
	4=

Drop the flow-hash of the skb when forwarding to the L2TP netdev.

This avoids the L2TP qdisc from using the flow-hash from the outer
packet, which is identical for every flow within the tunnel.

This does not affect every platform but is specific for the ethernet
driver. It depends on the platform including L4 information in the
flow-hash.

One such example is the Mediatek Filogic MT798x family of networking
processors.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 net/l2tp/l2tp_eth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 39e487ccc468..8ba00ad433c2 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -127,6 +127,9 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
 	/* checksums verified by L2TP */
 	skb->ip_summed = CHECKSUM_NONE;
 
+	/* drop outer flow-hash */
+	skb_clear_hash(skb);
+
 	skb_dst_drop(skb);
 	nf_reset_ct(skb);
 
-- 
2.43.0


