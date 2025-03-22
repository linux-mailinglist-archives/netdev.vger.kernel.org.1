Return-Path: <netdev+bounces-176901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A855A6CADA
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1824A0459
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B64233726;
	Sat, 22 Mar 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="thGpqdJe"
X-Original-To: netdev@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C56233724;
	Sat, 22 Mar 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654554; cv=none; b=oXpRCLM6kx4DM6pSNWpE6idXK4Uywy88D5FEnWGK1dRo0tFlK2UBhGWYrvxfsQmCLoWMs/lRp1wrobH4YwdL4sV8DVdZT4KQg9ZJVX075Q776wvERHCZuz/mALP+nj+JxtNlmuF4o5b93SNi2DLpP2pNetneQ0WcbrpOP36o2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654554; c=relaxed/simple;
	bh=qlsO0e65seRmrgbPPRr4nWn2fRrbEoqBUH/7MbMwqCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIXXBdWhIxdo3CGJ+kCUUJ++Dg3BMaqmdLkw5cTeCdKLZF9PacdfF95YHjSVOKLPyp6E5wa2AfcJQFsuJ+u0F7k8/UmWbuj2+oVg0vukYRNfo5In2G/efHdwd7EgGTVhMLUcxAB0fo4zMbXiH+znZrw7giXZXNI4z2HWIlUGsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=thGpqdJe; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1c87:0:640:51af:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id D299360A9E;
	Sat, 22 Mar 2025 17:42:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SgNmh4XLcCg0-YwJLFhgO;
	Sat, 22 Mar 2025 17:42:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654550; bh=74hYTKaIdf6KyBzaNJ7T5WVxCPJYQi7HzojPQP6uMiA=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=thGpqdJeTEUf9TwmztJmsmqDQFEN455qIiQaqxjVh+jgUdjB0RUwOBDQ5DBRAqgjc
	 aEJBwSr8ihDOGOIVQOa7MoY1c7waiIwiULLBlBpCYxWs7ywJ129eX7DxOWu01m1kdk
	 7gC7XmyTdrCPQ1R1voHX3thPqBDKz7NuT/s8QhwA=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 37/51] net: Introduce delayed event work
Date: Sat, 22 Mar 2025 17:42:28 +0300
Message-ID: <174265454834.356712.6297354306843654837.stgit@pro.pro>
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

Some drivers (e.g., failover and netvsc) use netdevice notifiers
to link devices each other by calling netdev_master_upper_dev_link().
Since we want 1)to make both of the devices using the same lock after
linking, and 2)to call netdevice notifiers with nd_lock is locked,
we can't do these two options at the same time, because there will
be a problem with priority inversion:

lock_netdev(dev1, &nd_lock1);
call_netdevice_notifier()
  lock_netdev(dev2, &nd_lock2); <--- problem here if !locks_ordered()
  nd_lock_transfer_devices(nd_lock, nd_lock2);
  netdev_master_upper_dev_link(dev1, dev2);

We can't use double_lock_netdev() instead of lock_netdev() here,
since dev2 is unknown at that moment.

This patch introduces interface to allow handling events in delayed work.
It consists of three:
1)Delayed work to call event callback. The work starting without
  any locks locked, so it can take locks of both devices in correct
  order;
2)Completion to notify the task that delayed work is done;
3)task_work to allow task to wait for the completion in
  the place where task has nd_lock unlocked.

Here is an example of what happens on module loading:

[Task]                                [Work]

insmod slave_netdev_drv.ko
  enter to kernel
    init_module()
      ...
      ...
      lock_netdev()
      call_netdevice_notifier()
        schedule_delayed_event()
      unlock_netdev()
                                       delayed_event_work()
                                         double_lock_netdev(dev1, &nd_lock1, dev2, &nd_lock2)
                                         nd_lock_transfer_devices(nd_lock, nd_lock2)
                                         netdev_master_upper_dev_link(dev1, dev2)
                                         double_unlock_netdev(nd_lock1, nd_lock2)
                                         complete()


    wait_for_delayed_event_work()
      wait_for_completion()
  exit to userspace

As it's seen, using of task work allows to remain user-visible behavior here.
We return from syscall to userspace after delayed work is completed and
all events are handled. This is why we need this task work.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 include/linux/netdevice.h |    2 +
 net/core/dev.c            |   95 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2e9052e808a4..83b675ec2b0a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2991,6 +2991,8 @@ netdev_notifier_info_to_extack(const struct netdev_notifier_info *info)
 int call_netdevice_notifiers(unsigned long val, struct net_device *dev);
 int call_netdevice_notifiers_info(unsigned long val,
 				  struct netdev_notifier_info *info);
+int schedule_delayed_event(struct net_device *dev,
+			   void (*func)(struct net_device *dev));
 
 #define for_each_netdev(net, d)		\
 		list_for_each_entry(d, &(net)->dev_base_head, dev_list)
diff --git a/net/core/dev.c b/net/core/dev.c
index e6809a80644e..1c447446215d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -154,6 +154,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
+#include <linux/task_work.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
@@ -2088,6 +2089,100 @@ static int call_netdevice_notifiers_mtu(unsigned long val,
 	return call_netdevice_notifiers_info(val, &info.info);
 }
 
+struct event_info {
+	struct work_struct work;
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
+	void (*func)(struct net_device *slave_dev);
+
+	struct callback_head task_work;
+	struct completion comp;
+	refcount_t usage;
+};
+
+static void put_delayed_reg_info(struct event_info *info)
+{
+	if (refcount_dec_and_test(&info->usage))
+		kfree(info);
+}
+
+static void delayed_event_work(struct work_struct *work)
+{
+	struct event_info *info;
+	struct net_device *dev;
+
+	info = container_of(work, struct event_info, work);
+	dev = info->dev;
+
+	info->func(dev);
+
+	/* Not needed to own device during all @info life.
+	 * Put device right after callback is handled,
+	 * since a task submitted this work may wait for
+	 * @dev counter.
+	 */
+	netdev_put(dev, &info->dev_tracker);
+	info->dev = NULL;
+
+	complete(&info->comp);
+	put_delayed_reg_info(info);
+}
+
+static void wait_for_delayed_event_work(struct callback_head *task_work)
+{
+	struct event_info *info;
+
+	info = container_of(task_work, struct event_info, task_work);
+	wait_for_completion(&info->comp);
+
+	put_delayed_reg_info(info);
+}
+
+static struct event_info *alloc_delayed_event_info(struct net_device *dev,
+				     void (*func)(struct net_device *dev))
+{
+	struct event_info *info;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return NULL;
+
+	INIT_WORK(&info->work, delayed_event_work);
+	init_task_work(&info->task_work, wait_for_delayed_event_work);
+	init_completion(&info->comp);
+	refcount_set(&info->usage, 1);
+	info->func = func;
+	info->dev = dev;
+	netdev_hold(dev, &info->dev_tracker, GFP_KERNEL);
+
+	return info;
+}
+
+int schedule_delayed_event(struct net_device *dev,
+			   void (*func)(struct net_device *dev))
+{
+	struct event_info *info;
+
+	info = alloc_delayed_event_info(dev, func);
+	if (!info)
+		return NOTIFY_DONE;
+
+	/* In case of the notifier is called from regular task,
+	 * make the task to wait for registration is completed
+	 * before task is returned to userspace. E.g., a syscall
+	 * caller will have failover already connected after
+	 * he loaded slave device driver.
+	 */
+	if (!(current->flags & PF_KTHREAD)) {
+		if (!task_work_add(current, &info->task_work, TWA_RESUME))
+			refcount_inc(&info->usage);
+	}
+
+	schedule_work(&info->work);
+	return NOTIFY_OK;
+}
+EXPORT_SYMBOL_GPL(schedule_delayed_event);
+
 #ifdef CONFIG_NET_INGRESS
 static DEFINE_STATIC_KEY_FALSE(ingress_needed_key);
 


