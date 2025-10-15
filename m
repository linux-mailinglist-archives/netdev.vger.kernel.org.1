Return-Path: <netdev+bounces-229542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B998DBDDDEF
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88C6B4E4CE2
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0E31B13D;
	Wed, 15 Oct 2025 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ktvPzeiR"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C631B805;
	Wed, 15 Oct 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521873; cv=none; b=bjIqLCuCK2RYnV3sJVlF46dZKKOYnBJNQ/iBrqOhDNQy4X9ypta/ckr2iE9KPzK4mIzDeCYG60EsACEwnCTfCddN2WWuHCze8muJnb9xB6qYC9JZF+kpxoObpkwT1in1g3zIXA2FS1OwPI+DiaBN7h59DkHvYw1OB2SVC5+ANXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521873; c=relaxed/simple;
	bh=EQxNKNke9gX0XYA/V0M+H1+7qAdQ38O3TXmITQZdJI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nvW1HpRqh+1UVUf4FTi3ibjUmx50W6rCIJDpd9QJU4z5vArGtol/le4VlnPWoQLxWZxi+E3SEr4pzFZ1HnmSiQdAM74AQNXrR3jeZYPsqEkPatiHqybbURLXaZTj/0gFyKe27aR3zq/sJab3ZgpIkaIIo0K3XG4mJ1ng/LLITsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ktvPzeiR; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pb1FEeW6OvnR/nSC7HJl57XnSy3f3DvA8j0ii52hBVI=;
	b=ktvPzeiRLZ9B8YaGsvE3bUAuozxorei71FQQFh0QQKEKxYF86DoHE8vz6mtwemGZbpTLbKezW
	jHkJ3u3EbZ+p006oc7wW7RZJkBOIdPkmItZ0sip6TiiC+q65o1KxXSb/eKACLGT+0jvYhqnYcbo
	24je0w8z5IVOtjIaLgFatEw=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cmmXb6b7FzcZyT;
	Wed, 15 Oct 2025 17:50:07 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 50F3118048B;
	Wed, 15 Oct 2025 17:51:06 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Oct
 2025 17:51:05 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <nhorman@tuxdriver.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>
Subject: [PATCH RFC net-next] net: drop_monitor: Add debugfs support
Date: Wed, 15 Oct 2025 18:14:17 +0800
Message-ID: <20251015101417.1511732-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500016.china.huawei.com (7.185.36.197)

This patch add debugfs interfaces for drop monitor. Similar to kmemleak, we
can use the monitor by below commands:

  echo clear > /sys/kernel/debug/drop_monitor/trace
  echo start > /sys/kernel/debug/drop_monitor/trace
  echo stop  > /sys/kernel/debug/drop_monitor/trace
  cat /sys/kernel/debug/drop_monitor/trace

The trace skb number limit can be set dynamically:

  cat /sys/kernel/debug/drop_monitor/trace_limit
  echo 200 > /sys/kernel/debug/drop_monitor/trace_limit

Compare to original netlink method, the callstack dump is supported. There
is a example for received udp packet with error checksum:

  reason   : UDP_CSUM (11)
  pc       : udp_queue_rcv_one_skb+0x14b/0x350
  len      : 12
  protocol : 0x0800
  stack    :
    sk_skb_reason_drop+0x8f/0x120
    udp_queue_rcv_one_skb+0x14b/0x350
    udp_unicast_rcv_skb+0x71/0x90
    ip_protocol_deliver_rcu+0xa6/0x160
    ip_local_deliver_finish+0x90/0x100
    ip_sublist_rcv_finish+0x65/0x80
    ip_sublist_rcv+0x130/0x1c0
    ip_list_rcv+0xf7/0x130
    __netif_receive_skb_list_core+0x21d/0x240
    netif_receive_skb_list_internal+0x186/0x2b0
    napi_complete_done+0x78/0x190
    e1000_clean+0x27f/0x860
    __napi_poll+0x25/0x1e0
    net_rx_action+0x2ca/0x330
    handle_softirqs+0xbc/0x290
    irq_exit_rcu+0x90/0xb0

It's more friendly to use and not need user application to cooperate.
Furthermore, it is easier to add new feature. We can add reason/ip/port
filter by debugfs parameters, like ftrace, rather than netlink msg.

As the first version, only enable the sw switch when starting the monitor
and save drop skb info in kfree_skb_probe hook.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/core/drop_monitor.c | 198 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 60d31c2feed3..d790439bbc77 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -38,10 +38,35 @@
 #include <trace/events/devlink.h>
 
 #include <linux/unaligned.h>
+#include <linux/debugfs.h>
 
 #define TRACE_ON 1
 #define TRACE_OFF 0
 
+static struct dentry *dm_debugfs_dir;
+static LIST_HEAD(dm_entry_list);
+static DEFINE_RAW_SPINLOCK(dm_entry_lock);
+
+#define DM_MAX_STACK_TRACE_ENTRIES 16
+#define DM_MAX_STACK_TRACE_SKIP 1
+
+struct dm_skb_info {
+	unsigned int len;
+	unsigned short protocol;
+};
+
+struct dm_entry {
+	struct list_head dm_list;
+	void *pc;
+	enum skb_drop_reason reason;
+	unsigned int stack_len;
+	unsigned long stack[DM_MAX_STACK_TRACE_ENTRIES];
+	struct dm_skb_info skb_info;
+};
+
+static unsigned int dm_trace_limit = 100;
+static void init_dm_entry(struct sk_buff *skb, void *location, enum skb_drop_reason reason);
+
 /*
  * Globals, our netlink socket pointer
  * and the work handle that will send up
@@ -268,6 +293,7 @@ static void trace_kfree_skb_hit(void *ignore, struct sk_buff *skb,
 				enum skb_drop_reason reason,
 				struct sock *rx_sk)
 {
+	init_dm_entry(skb, location, reason);
 	trace_drop_common(skb, location);
 }
 
@@ -502,6 +528,8 @@ static void net_dm_packet_trace_kfree_skb_hit(void *ignore,
 	struct sk_buff *nskb;
 	unsigned long flags;
 
+	init_dm_entry(skb, location, reason);
+
 	if (!skb_mac_header_was_set(skb))
 		return;
 
@@ -1723,6 +1751,173 @@ static void net_dm_hw_cpu_data_fini(int cpu)
 	__net_dm_cpu_data_fini(hw_data);
 }
 
+static void init_dm_entry(struct sk_buff *skb, void *location, enum skb_drop_reason reason)
+{
+	struct dm_entry *entry;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&dm_entry_lock, flags);
+	if (list_count_nodes(&dm_entry_list) >= dm_trace_limit) {
+		raw_spin_unlock_irqrestore(&dm_entry_lock, flags);
+		return;
+	}
+	raw_spin_unlock_irqrestore(&dm_entry_lock, flags);
+
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return;
+	entry->pc = location;
+	entry->reason = reason;
+	entry->skb_info.len = skb->len;
+	entry->skb_info.protocol = be16_to_cpu(skb->protocol);
+
+	raw_spin_lock_irqsave(&dm_entry_lock, flags);
+	entry->stack_len = stack_trace_save(entry->stack, ARRAY_SIZE(entry->stack),
+					    DM_MAX_STACK_TRACE_SKIP);
+	list_add_tail(&entry->dm_list, &dm_entry_list);
+	raw_spin_unlock_irqrestore(&dm_entry_lock, flags);
+}
+
+static void clear_dm_entry(void)
+{
+	struct dm_entry *entry, *tmp;
+
+	raw_spin_lock(&dm_entry_lock);
+	list_for_each_entry_safe(entry, tmp, &dm_entry_list, dm_list) {
+		list_del(&entry->dm_list);
+		kfree(entry);
+	}
+	raw_spin_unlock(&dm_entry_lock);
+}
+
+static void *dm_debugfs_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	raw_spin_lock(&dm_entry_lock);
+	return seq_list_start_head(&dm_entry_list, *pos);
+}
+
+static void dm_debugfs_seq_stop(struct seq_file *seq, void *v)
+{
+	raw_spin_unlock(&dm_entry_lock);
+}
+
+static void *dm_debugfs_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &dm_entry_list, pos);
+}
+
+static const char *dm_show_reason_str(enum skb_drop_reason reason)
+{
+	const struct drop_reason_list *list;
+	unsigned int subsys, subsys_reason;
+
+	subsys = u32_get_bits(reason, SKB_DROP_REASON_SUBSYS_MASK);
+	if (subsys >= SKB_DROP_REASON_SUBSYS_NUM)
+		return NULL;
+	list = rcu_dereference(drop_reasons_by_subsys[subsys]);
+
+	subsys_reason = reason & ~SKB_DROP_REASON_SUBSYS_MASK;
+	if (subsys_reason >= list->n_reasons)
+		return NULL;
+	return list->reasons[subsys_reason];
+}
+
+static int dm_debugfs_seq_show(struct seq_file *seq, void *v)
+{
+	struct dm_entry *entry;
+	unsigned int i;
+
+	if (v == &dm_entry_list) {
+		seq_printf(seq, "drop count: %zu\n", list_count_nodes(&dm_entry_list));
+		return 0;
+	}
+
+	entry = list_entry(v, struct dm_entry, dm_list);
+	seq_puts(seq, "\n");
+	seq_printf(seq, "reason   : %s (%d)\n", dm_show_reason_str(entry->reason), entry->reason);
+	seq_printf(seq, "pc       : %pS\n", entry->pc);
+	seq_printf(seq, "len      : %d\n", entry->skb_info.len);
+	seq_printf(seq, "protocol : 0x%04x\n", entry->skb_info.protocol);
+	seq_puts(seq, "stack    :\n");
+	for (i = 0; i < entry->stack_len; i++)
+		seq_printf(seq, "  %pS\n", (void *)entry->stack[i]);
+	return 0;
+}
+
+static const struct seq_operations dm_debugfs_seq_ops = {
+	.start	= dm_debugfs_seq_start,
+	.next	= dm_debugfs_seq_next,
+	.stop	= dm_debugfs_seq_stop,
+	.show	= dm_debugfs_seq_show,
+};
+
+static int dm_debugfs_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &dm_debugfs_seq_ops);
+}
+
+static void dm_debugfs_set_trace_sw(int state)
+{
+	mutex_lock(&net_dm_mutex);
+
+	if (state == TRACE_ON)
+		net_dm_monitor_start(true, false, NULL);
+	else
+		net_dm_monitor_stop(true, false, NULL);
+
+	mutex_unlock(&net_dm_mutex);
+}
+
+static ssize_t dm_debugfs_write(struct file *file, const char __user *user_buf,
+				size_t size, loff_t *ppos)
+{
+	char buf[64];
+	int buf_size;
+
+	buf_size = min(size, (sizeof(buf) - 1));
+	if (strncpy_from_user(buf, user_buf, buf_size) < 0)
+		return -EFAULT;
+	buf[buf_size] = 0;
+
+	if (strncmp(buf, "clear", strlen("clear")) == 0)
+		clear_dm_entry();
+	else if (strncmp(buf, "start", strlen("start")) == 0)
+		dm_debugfs_set_trace_sw(TRACE_ON);
+	else if (strncmp(buf, "stop", strlen("stop")) == 0)
+		dm_debugfs_set_trace_sw(TRACE_OFF);
+	else
+		return -EINVAL;
+
+	return size;
+}
+
+static const struct file_operations dm_debugfs_fops = {
+	.owner		= THIS_MODULE,
+	.open		= dm_debugfs_open,
+	.read		= seq_read,
+	.write		= dm_debugfs_write,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static void net_dm_create_debugfs(void)
+{
+	dm_debugfs_dir = debugfs_create_dir("drop_monitor", NULL);
+	if (IS_ERR_OR_NULL(dm_debugfs_dir)) {
+		pr_warn("Cannot create drop monitor debugfs directory\n");
+		return;
+	}
+
+	debugfs_create_u32("trace_limit", 0644, dm_debugfs_dir, &dm_trace_limit);
+	debugfs_create_file("trace", 0644, dm_debugfs_dir, NULL, &dm_debugfs_fops);
+}
+
+static void net_dm_destroy_debugfs(void)
+{
+	debugfs_remove_recursive(dm_debugfs_dir);
+	clear_dm_entry();
+}
+
 static int __init init_net_drop_monitor(void)
 {
 	int cpu, rc;
@@ -1754,6 +1949,7 @@ static int __init init_net_drop_monitor(void)
 
 	rc = 0;
 
+	net_dm_create_debugfs();
 	goto out;
 
 out_unreg:
@@ -1766,6 +1962,8 @@ static void exit_net_drop_monitor(void)
 {
 	int cpu;
 
+	net_dm_destroy_debugfs();
+
 	/*
 	 * Because of the module_get/put we do in the trace state change path
 	 * we are guaranteed not to have any current users when we get here
-- 
2.34.1


