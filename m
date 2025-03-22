Return-Path: <netdev+bounces-176902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F20BA6CAE9
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D99A8A2E63
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A92356D8;
	Sat, 22 Mar 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="Pclq9XcH"
X-Original-To: netdev@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F92356D5;
	Sat, 22 Mar 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654562; cv=none; b=cvXNujcWqp7XdJQH7P+nd6e6ZcGDjJ0x8gT8Pj3kd1G5c7jU7Xg4JjqZESrN31Jm+HkjCVs4FCvJ4jBNczqsMebF5w8IZtrGZKpOz2+epCdWLXtbzEK2kOtEikBiIOfAJYTUEa+yJnn78P79+IMSulQqjMt/82VeJhLTxtCPmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654562; c=relaxed/simple;
	bh=YmCmkXIxnlAWwOzfRrJgXveZi2bIXUtj+R2kuzFqz1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxsiplXl9+Q5GtAzMvlCk1RUZ50V03rj9PgmQh97LlAK6/3HHi6efPxqxB9aZ7TLsDeo2VTEnm80RrVDclGhjMWbqAKZsNhpbpH/rlqW07moRDlyv2ryLOjKiw8escymTZy7t54aHM8Eftjl0uj++tnr36XeDVydtKh8uiwQy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=Pclq9XcH; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:7c8:0:640:150d:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id F3285608D6;
	Sat, 22 Mar 2025 17:42:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id agNAU8VLbKo0-Ek1rDImW;
	Sat, 22 Mar 2025 17:42:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654557; bh=b5UUjssc2/5D2OgzIckYzc0qmHZuXWOMArM7VVCruas=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=Pclq9XcHGEVAMpMLy4cyVihlNUYWdY8h1lDdOaqjiKuIznKnWnoL02Mkhn6/TIMpg
	 yJFxSAuoFLrbbb4FnXBKwZ0Qliq1jm36t7Vr+ANKiaGIhlyolZbOGK6aa191ACWKP3
	 ADpvgZNmkWNDsEbVQ3Qa2mgLKycAeM55kizSjYQk=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 38/51] failover: Link master and slave under nd_lock
Date: Sat, 22 Mar 2025 17:42:36 +0300
Message-ID: <174265455601.356712.15167286071046652613.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

We don't want to do this in failover_event(), since we
want to call netdevice notifiers with nd_lock already
locked in the future.

Also see comments in patch introducing schedule_delayed_event()

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/failover.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/core/failover.c b/net/core/failover.c
index 2a140b3ea669..83be0d0ab99a 100644
--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -46,6 +46,7 @@ static struct net_device *failover_get_bymac(u8 *mac, struct failover_ops **ops)
 static int failover_slave_register(struct net_device *slave_dev)
 {
 	struct netdev_lag_upper_info lag_upper_info;
+	struct nd_lock *nd_lock, *nd_lock2;
 	struct net_device *failover_dev;
 	struct failover_ops *fops;
 	int err;
@@ -72,8 +73,14 @@ static int failover_slave_register(struct net_device *slave_dev)
 	}
 
 	lag_upper_info.tx_type = NETDEV_LAG_TX_TYPE_ACTIVEBACKUP;
+
+	double_lock_netdev(slave_dev, &nd_lock, failover_dev, &nd_lock2);
+	nd_lock_transfer_devices(&nd_lock, &nd_lock2);
+
 	err = netdev_master_upper_dev_link(slave_dev, failover_dev, NULL,
 					   &lag_upper_info, NULL);
+	double_unlock_netdev(nd_lock, nd_lock2);
+
 	if (err) {
 		netdev_err(slave_dev, "can not set failover device %s (err = %d)\n",
 			   failover_dev->name, err);
@@ -182,6 +189,18 @@ static int failover_slave_name_change(struct net_device *slave_dev)
 	return NOTIFY_DONE;
 }
 
+static void call_failover_slave_register(struct net_device *dev)
+{
+	rtnl_lock();
+	if (dev->reg_state == NETREG_REGISTERED) {
+		failover_slave_register(dev);
+		failover_slave_link_change(dev);
+		failover_slave_name_change(dev);
+
+	}
+	rtnl_unlock();
+}
+
 static int
 failover_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
@@ -193,7 +212,10 @@ failover_event(struct notifier_block *this, unsigned long event, void *ptr)
 
 	switch (event) {
 	case NETDEV_REGISTER:
-		return failover_slave_register(event_dev);
+		if (netdev_is_rx_handler_busy(event_dev))
+			return NOTIFY_DONE;
+		return schedule_delayed_event(event_dev,
+					      call_failover_slave_register);
 	case NETDEV_UNREGISTER:
 		return failover_slave_unregister(event_dev);
 	case NETDEV_UP:


