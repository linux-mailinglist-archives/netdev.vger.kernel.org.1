Return-Path: <netdev+bounces-252835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIj+EhBoc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:22:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A64B675B5B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B6D6308FFB3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA52E310777;
	Fri, 23 Jan 2026 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QvMOXeG8"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6B27CCF0;
	Fri, 23 Jan 2026 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170698; cv=none; b=KHq60lOmzr3qGbeT+95xP8y1Q2MyhMdScep/okI2OJF7nFSk61meRAZjCUBg6tH3CwbwtCcslNdDVKekkLVLnbtHK/hyq3ZRLHwDdNnps+N2adnvO5V+lHZPMvq769FVyspolKv+XWwDH4AtSmqU/hydF3t/0xhgoph2MjJbQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170698; c=relaxed/simple;
	bh=YzubzAFZCOZGrHGxvv3+ISh10iWECd1XJZnMJAfb4xU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOLiAqUWXkE1YMeKbla61jbm37ljkVqbHs1o9g5Y84UBi+CM43xaXej7ZdvVMt+pSZZIlUKI9LCWw78nTzrRsaOfooTDbW6WxITESs661aiXFuEpT6gy5ZhHtSrIIgY4Jf7arrks7wxifYMyH6yKmLj35c3cwEmv5pUQndz7Tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QvMOXeG8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=OET3znP1m4/7noEK4AnYb6WIYY6XK6AggZNLvXC7sVc=; b=QvMOXeG8gAYp0ThRpKyLClibSt
	EN9PMDZc+jLP62XeHT5iTxxst2E8MHIE/9iBtzjSXJmK8QKkXgo+Tn7y+PBgpkdIRtLkBMVfLtmTo
	Yv83tJf35SzmP0pTbAz7/3IYwM8YHXLrJBLvD22zFBjGFTiOh0yPf+IqKvaTM//Fw7HsSqUWVlxk4
	4DNtGgxQUC2OdmUFUxzDrBap2+kgqcHc4fANZ9kj+Nzo/etgD6PboOQQ0a77bC8EFoUDvm2+y4Rr8
	tkjJ76JIB8lntzZ6s6HbIjJWfpF4vXRmQft5g7AOI3/8lKDZRUOnWSjxP/EhLamXFQdYkaVPnYDm4
	hH1cqUZw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vjG6v-00DpeF-Ed; Fri, 23 Jan 2026 12:17:57 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 23 Jan 2026 04:17:24 -0800
Subject: [PATCH net-next v4 1/5] printk: Add execution context (task
 name/CPU) to printk_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-nbcon-v4-1-46a5cf567926@debian.org>
References: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
In-Reply-To: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 pmladek@suse.com, john.ogness@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, 
 mpdesouza@suse.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=9210; i=leitao@debian.org;
 h=from:subject:message-id; bh=YzubzAFZCOZGrHGxvv3+ISh10iWECd1XJZnMJAfb4xU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpc2bqHE06eXAQYPvR3PTOPtk/SOz+Hd8Q56O0x
 PEmCJWjQreJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXNm6gAKCRA1o5Of/Hh3
 belXD/9dUlQ8DTCcCLTrwsAyGxWob2IN0b7Qp2fRVdZCrhni/lacZEwIYbE8RNdOSzUvmQ6caOt
 4gYLhk6ZZ/UeAsjoE5kDvWszq8lpi6h6pmsE4fRknbZpZBZ4VlqqkzWf0f7kg2QH73ky80RnnqU
 XGEjokojSVqakwHJMc66eHKvRjs9gvrLuyFQ9iLJ/wwXFOHUZjWrxlgWtJchvnROx/NI4ZJXU7g
 mDHi3ydK3CTyIVZFJTG+wV2wA4fISqVEQbUtxJNbqGVBhijK5Gu/EVdNuJ0/IUJkdJVHET2rj+u
 tqkuhyzr2wGmYn04xLv38x3eWTYNzmxLucpSMNgxlVvicp61zenAUXcD8uc5w4qWnfh2W3MCEKR
 qvw+Ui/blZQ/Aqr3c4NeRa502KvAUV0j0WmnoVHTmWWs0mjmmUcBri5+5sz6WOQxDSykZFc6LVw
 0mwNoNRV9Lw5bVVQXGUvtmhBD5UXMbJBQz6hRuQZeJaiV0Fig9m3Fa4DsN9vOa7RUhvpI2k07tf
 zN15E1AMhOG4CFhemqe4RNXCOUEqEbp22yZh9ubh9bydlpstEkqZVjyHHLN8BQT2bDgpi6sdSvK
 s1enM8F2ASGzFN8UbtheJx0EXOeIbNNeA856cTESg8beNjH2FTrCT+RZi44/MceS1WGe6J89uUp
 MBnhPchn745FXuw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252835-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[r.info:url,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A64B675B5B
X-Rspamd-Action: no action

Extend struct printk_info to include the task name, pid, and CPU
number where printk messages originate. This information is captured
at vprintk_store() time and propagated through printk_message to
nbcon_write_context, making it available to nbcon console drivers.

This is useful for consoles like netconsole that want to include
execution context in their output, allowing correlation of messages
with specific tasks and CPUs regardless of where the console driver
actually runs.

The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
the helper functions compile to no-ops with no overhead.

Suggested-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/net/Kconfig               |  2 ++
 include/linux/console.h           |  8 +++++++
 kernel/printk/internal.h          |  8 +++++++
 kernel/printk/nbcon.c             | 15 ++++++++++++
 kernel/printk/printk.c            | 50 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk_ringbuffer.h |  5 ++++
 lib/Kconfig.debug                 | 20 ++++++++++++++++
 7 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9c7953f8e6377..356c70be868ff 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -341,6 +341,8 @@ config NETCONSOLE_DYNAMIC
 	bool "Dynamic reconfiguration of logging targets"
 	depends on NETCONSOLE && SYSFS && CONFIGFS_FS && \
 			!(NETCONSOLE=y && CONFIGFS_FS=m)
+	select PRINTK_EXECUTION_CTX
+	select CONSOLE_HAS_EXECUTION_CTX
 	help
 	  This option enables the ability to dynamically reconfigure target
 	  parameters (interface, IP addresses, port numbers, MAC addresses)
diff --git a/include/linux/console.h b/include/linux/console.h
index fc9f5c5c1b04c..cc5dc3bf58b60 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -298,12 +298,20 @@ struct nbcon_context {
  * @outbuf:		Pointer to the text buffer for output
  * @len:		Length to write
  * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
+ * @cpu:		CPU on which the message was generated
+ * @pid:		PID of the task that generated the message
+ * @comm:		Name of the task that generated the message
  */
 struct nbcon_write_context {
 	struct nbcon_context	__private ctxt;
 	char			*outbuf;
 	unsigned int		len;
 	bool			unsafe_takeover;
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	int			cpu;
+	pid_t			pid;
+	char			comm[TASK_COMM_LEN];
+#endif
 };
 
 /**
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 5f5f626f42794..5fdea56827564 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -281,12 +281,20 @@ struct printk_buffers {
  *		nothing to output and this record should be skipped.
  * @seq:	The sequence number of the record used for @pbufs->outbuf.
  * @dropped:	The number of dropped records from reading @seq.
+ * @cpu:	CPU on which the message was generated.
+ * @pid:	PID of the task that generated the message
+ * @comm:	Name of the task that generated the message.
  */
 struct printk_message {
 	struct printk_buffers	*pbufs;
 	unsigned int		outbuf_len;
 	u64			seq;
 	unsigned long		dropped;
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	int			cpu;
+	pid_t			pid;
+	char			comm[TASK_COMM_LEN];
+#endif
 };
 
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 32fc12e536752..391a58be0c5b3 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -946,6 +946,19 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+				     struct printk_message *pmsg)
+{
+	wctxt->cpu = pmsg->cpu;
+	wctxt->pid = pmsg->pid;
+	memcpy(wctxt->comm, pmsg->comm, TASK_COMM_LEN);
+}
+#else
+static void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+				     struct printk_message *pmsg) {}
+#endif
+
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
@@ -1048,6 +1061,8 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	/* Initialize the write context for driver callbacks. */
 	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
+	wctxt_load_execution_ctx(wctxt, &pmsg);
+
 	if (use_atomic)
 		con->write_atomic(con, wctxt);
 	else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1d765ad242b82..7daaa27705339 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2131,12 +2131,37 @@ static inline void printk_delay(int level)
 	}
 }
 
+#define CALLER_ID_MASK 0x80000000
+
 static inline u32 printk_caller_id(void)
 {
 	return in_task() ? task_pid_nr(current) :
-		0x80000000 + smp_processor_id();
+		CALLER_ID_MASK + smp_processor_id();
+}
+
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+/* Store the opposite info than caller_id. */
+static u32 printk_caller_id2(void)
+{
+	return !in_task() ? task_pid_nr(current) :
+		CALLER_ID_MASK + smp_processor_id();
 }
 
+static pid_t printk_info_get_pid(const struct printk_info *info)
+{
+	u32 caller_id = info->caller_id;
+	u32 caller_id2 = info->caller_id2;
+
+	return caller_id & CALLER_ID_MASK ? caller_id2 : caller_id;
+}
+
+static int printk_info_get_cpu(const struct printk_info *info)
+{
+	return ((info->caller_id & CALLER_ID_MASK ?
+		 info->caller_id : info->caller_id2) & ~CALLER_ID_MASK);
+}
+#endif
+
 /**
  * printk_parse_prefix - Parse level and control flags.
  *
@@ -2213,6 +2238,27 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 	return text_len;
 }
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static void printk_store_execution_ctx(struct printk_info *info)
+{
+	info->caller_id2 = printk_caller_id2();
+	get_task_comm(info->comm, current);
+}
+
+static void pmsg_load_execution_ctx(struct printk_message *pmsg,
+				    const struct printk_info *info)
+{
+	pmsg->cpu = printk_info_get_cpu(info);
+	pmsg->pid = printk_info_get_pid(info);
+	memcpy(pmsg->comm, info->comm, TASK_COMM_LEN);
+}
+#else
+static void printk_store_execution_ctx(struct printk_info *info) {}
+
+static void pmsg_load_execution_ctx(struct printk_message *pmsg,
+				    const struct printk_info *info) {}
+#endif
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -2320,6 +2366,7 @@ int vprintk_store(int facility, int level,
 	r.info->caller_id = caller_id;
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
+	printk_store_execution_ctx(r.info);
 
 	/* A message without a trailing newline can be continued. */
 	if (!(flags & LOG_NEWLINE))
@@ -3002,6 +3049,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 	force_con = r.info->flags & LOG_FORCE_CON;
+	pmsg_load_execution_ctx(pmsg, r.info);
 
 	/*
 	 * Skip records that are not forced to be printed on consoles and that
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 4ef81349d9fbe..1651b53ece34f 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -23,6 +23,11 @@ struct printk_info {
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
 	u32	caller_id;	/* thread id or processor id */
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	u32	caller_id2;	/* caller_id complement */
+	/* name of the task that generated the message */
+	char	comm[TASK_COMM_LEN];
+#endif
 
 	struct dev_printk_info	dev_info;
 };
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fda79b..57f91ee10b8e6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -35,6 +35,26 @@ config PRINTK_CALLER
 	  no option to enable/disable at the kernel command line parameter or
 	  sysfs interface.
 
+config CONSOLE_HAS_EXECUTION_CTX
+	bool
+	help
+	  Selected by console drivers that support execution context
+	  (task name/CPU) in their output. This enables PRINTK_EXECUTION_CTX
+	  to provide the necessary infrastructure.
+
+config PRINTK_EXECUTION_CTX
+	bool "Include execution context (task/CPU) in printk messages"
+	depends on PRINTK && CONSOLE_HAS_EXECUTION_CTX
+	default CONSOLE_HAS_EXECUTION_CTX
+	help
+	  This option extends struct printk_info to include extra execution
+	  context in printk, such as task name and CPU number from where the
+	  message originated. This is useful for correlating printk messages
+	  with specific execution contexts.
+
+	  This is automatically enabled when a console driver that supports
+	  execution context is selected.
+
 config STACKTRACE_BUILD_ID
 	bool "Show build ID information in stacktraces"
 	depends on PRINTK

-- 
2.47.3


