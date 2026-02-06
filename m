Return-Path: <netdev+bounces-257540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOkNIpbjhWnCHwQAu9opvQ
	(envelope-from <netdev+bounces-257540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:50:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BAFFDB4D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2E7F3017BD1
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D53AEF47;
	Fri,  6 Feb 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nUTFbKv5"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6C125A0;
	Fri,  6 Feb 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382225; cv=none; b=sKx9oBb3UslYKRd8XmnP/tfrH4i2UeW1I8HQYLNA01fb7v7G9WxxX95ZIuh48YbADabqUTl2vUI3vjWucQLFSN0w1YooHJ2HEIVwamfK/kxpMSqNWkSh6ieHvQ9YrRauJbLvT6CDr+lrijgXG2RJm2LOl6/zyeaea2qcjNJF3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382225; c=relaxed/simple;
	bh=mblUlqMee7xPrbQSyHQAbH5cmW73s7eVaewpLfeIYIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6JOGbYapiLDEWVhuu+9b7omW+OpPOW6KsyRXGY3tuqXV7NLvgjH1MuGpOatb+yf5BP1enT/fFDpn1eCy/jppNHhCAVxWmfWlWZ7CSzQQRjPjE6dhAzIMRXEC2Ep1oUT8EUdTzcCF38qyUgJC3Iqi19Q6wc6kXX8VuhY3hlUbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nUTFbKv5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=F46+BVh5qJcmfs//UilDsQzQbvMrlIR7aX+CON5P7Z4=; b=nUTFbKv5+fAhNSykgimI1/dJ7p
	BLA7zOMl8G/NU6+2HPmUKcFRE5H1jxuZ8ocgR9kcVkSmCtVskB1PSWPdrOC9yIILDV0w+fXNCb7Mw
	zD6DAVm1ta+5P/mJSY8PzYEISpgrSwD01HUJDnoARtJNk7T4IrYJtDxqq76tpFryAMKsUj5VfcMN+
	xQxILUcQV49E6of9L7LvXbHRRSXOYSRvQgSAV7aMxTpV4eRpyVuWSc+QvozyAusmFbYxjutT0DE4k
	8a7QIoe1LDDS7TX0yZdU8ZIWcXwsGnC2HITTiUcULk588F+rC3sXcErZIFPa85XpZ2MojEjiwTZv9
	ePgd+3pw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1voLHs-007Ac4-EW; Fri, 06 Feb 2026 12:50:16 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 06 Feb 2026 04:45:29 -0800
Subject: [PATCH net-next v7 1/4] printk: Add execution context (task
 name/CPU) to printk_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-nbcon-v7-1-62bda69b1b41@debian.org>
References: <20260206-nbcon-v7-0-62bda69b1b41@debian.org>
In-Reply-To: <20260206-nbcon-v7-0-62bda69b1b41@debian.org>
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
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=9035; i=leitao@debian.org;
 h=from:subject:message-id; bh=mblUlqMee7xPrbQSyHQAbH5cmW73s7eVaewpLfeIYIo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpheN8qL11WrYKDbzDv/jlnMGRIF58kAocXDThB
 /VVf2qwXQ+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYXjfAAKCRA1o5Of/Hh3
 bZTdD/97FiaaVVLzYQjkfk/4HDYI+Ndu1q6S30I88Qg/1Z8/07N7zJlN06CQ/5EwTVHCi2/o3uc
 ifeqD90i5iWPZLUYEukRSqmI7S9l+UlJOjTeNSQ31N/6xUjhPhuZ3s399xcrvXB1Bd1oAF43/Xj
 9pAAePhYyBPkNN0k29q8E6HPr7cnqJQpXI0UGMTNkskHiTbct3JMTIbqxKscenVvMgA/5Y/pDK/
 eqTLb0uhFrInfICyr9h229bM3ipUEme3bDnYfE+36aD+PCtuySzbsQhT0ThAs2tVq2bSPTVRCrp
 UXmNqhNr29hxOPRa3BRjcW+04/qc+56ZKXF5mcS92X7YlhGrBO28bJjwd1CIBCCWMTH3Zm+Ktyh
 dYZ/cjxQ7f70CDM+WLlySZjgEIJKRCjQSlkCA5EaOG04jWz5If7U/JtB52Y9c5K30rsG3rQ5fBH
 vik2LABAKNHr5TIg6jgSVP9wbce0fVtHm0n/6Vkz5Zwid4dF06B7zBbScI9k9XMXAOEZW8FB3+k
 EcAMXiE3ZTDwL2CnnBNZjUDT7CIa/bA89co/Psw+9/5MZ5u9pb19vmmIKW56nFxCkGSyeyuNoY0
 aPaysowFA19ibHi1S941qzLvvNXJqS3rTpT+GUQkBtbgDC192EVxsYrX6VL7GqFjD6+Kmly/MNw
 NV9k8xS0gxKw/Pg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257540-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,r.info:url,suse.com:email]
X-Rspamd-Queue-Id: 14BAFFDB4D
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
Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/Kconfig               |  1 +
 include/linux/console.h           |  8 ++++++
 kernel/printk/internal.h          |  8 ++++++
 kernel/printk/nbcon.c             | 16 ++++++++++++
 kernel/printk/printk.c            | 54 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk_ringbuffer.h |  5 ++++
 lib/Kconfig.debug                 | 12 +++++++++
 7 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9c7953f8e6377..7e9becad91dfb 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -341,6 +341,7 @@ config NETCONSOLE_DYNAMIC
 	bool "Dynamic reconfiguration of logging targets"
 	depends on NETCONSOLE && SYSFS && CONFIGFS_FS && \
 			!(NETCONSOLE=y && CONFIGFS_FS=m)
+	select PRINTK_EXECUTION_CTX
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
index 32fc12e536752..f6d22510fdc3a 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -946,6 +946,20 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+				     struct printk_message *pmsg)
+{
+	wctxt->cpu = pmsg->cpu;
+	wctxt->pid = pmsg->pid;
+	memcpy(wctxt->comm, pmsg->comm, sizeof(wctxt->comm));
+	static_assert(sizeof(wctxt->comm) == sizeof(pmsg->comm));
+}
+#else
+static void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+				     struct printk_message *pmsg) {}
+#endif
+
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
@@ -1048,6 +1062,8 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	/* Initialize the write context for driver callbacks. */
 	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
+	wctxt_load_execution_ctx(wctxt, &pmsg);
+
 	if (use_atomic)
 		con->write_atomic(con, wctxt);
 	else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1d765ad242b82..cf6b528610366 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2131,11 +2131,39 @@ static inline void printk_delay(int level)
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
+}
+
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
+	u32 caller_id = info->caller_id;
+	u32 caller_id2 = info->caller_id2;
+
+	return ((caller_id & CALLER_ID_MASK ?
+		 caller_id : caller_id2) & ~CALLER_ID_MASK);
 }
+#endif
 
 /**
  * printk_parse_prefix - Parse level and control flags.
@@ -2213,6 +2241,28 @@ static u16 printk_sprint(char *text, u16 size, int facility,
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
+	memcpy(pmsg->comm, info->comm, sizeof(pmsg->comm));
+	static_assert(sizeof(pmsg->comm) == sizeof(info->comm));
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
@@ -2320,6 +2370,7 @@ int vprintk_store(int facility, int level,
 	r.info->caller_id = caller_id;
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
+	printk_store_execution_ctx(r.info);
 
 	/* A message without a trailing newline can be continued. */
 	if (!(flags & LOG_NEWLINE))
@@ -3002,6 +3053,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
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
index ba36939fda79b..938d967ae3bf8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -35,6 +35,18 @@ config PRINTK_CALLER
 	  no option to enable/disable at the kernel command line parameter or
 	  sysfs interface.
 
+config PRINTK_EXECUTION_CTX
+	bool
+	depends on PRINTK
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


