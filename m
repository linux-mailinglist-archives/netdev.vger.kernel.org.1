Return-Path: <netdev+bounces-249057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA31FD1344F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CF413009D75
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2153125B1D2;
	Mon, 12 Jan 2026 14:40:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41E24A06B
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228837; cv=none; b=cInuaxGlfan2aZ5m/8/HhrGlDavep0YiP8zJ4QRJ1mu7rJHjbdArMjCRv8PcsPpmXtc/I9sxsmnbkkqtAhiPRySi2Iml2RAFVY78yMksqGL1RXJYQRsuRawJjlWr71S8XvwOUVmIwwyMvc7FuZYKxoAuPLxKxuC4XTL9LFmhA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228837; c=relaxed/simple;
	bh=hHp5wEWvtu2/8EyzN6x5ir5gbVmu8QuIrGAM8IielDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvUT3aBpVQQDTwovNL6wZlCvZ7uxW3K8lJQZZ/BNdeesekYVPQhgBkODWmTMjt26mNxNASoS2JVbl5CHVBL9MOh9QwMSnVeEqfYQ7UZL8jX2vLRnpQbnYHoaDABDPA6vP63on5i9WCFjvf3qg1uUa+4vyOx7LcVWYUukm4YJBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88888d80590so84271216d6.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768228834; x=1768833634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZssGPCoEo5EOZd62uB85szCiK1muwx8pIQMV+xndCFE=;
        b=uq06dxPhr9Rc9SbbFNfOz97EnwMY+wsMnaqviuQqiWVzNyB8p0iFWJNwjXx7i3FEdZ
         qO2vOQI4ztQOf7T4a4xCA6tW0PX8Wh/KvNR8IDBL6wOIH+N6H5UWCFXSKzSBFDVBxSLS
         o4a6BNw34aGAJN/yIHPixzqbh42G6j8uVKZCSB1AC9Z+BRlUk8DLNtmgao5kRvROvwvm
         htkDhBAQj9ukx5yC3En0CLTDF3UcQehkdZSkyhWgIijGJqMC1LfGri5Krx06P4IDcai8
         gFg1rHEkVTs37e5tY+mzn7u0MtkIKWog1TR7kPBNfFgShS+zWLCPO3tnoumVInR+xIiQ
         vdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUparcvTMW2tWmWUUkZHGJM1lv1YkKanDLIBSnKfHj6efvJncZvI/1tbqBNXvawCDpJtmL2reA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXmxsxtW3M8BwCG6i9sBGfJ5XFw7OXx/x1oxgwGV16mLPKUXlE
	2PryKYX9Z85QxX0TsvqMKunOtgyYbeZNvU+La3b2vhguQmbjb5cgX96PJ+O37fH2
X-Gm-Gg: AY/fxX4x96aNeo+KwHng1E8Q8zT4DMs6TTfKPGxTEgUkbu931GRWVYSp5dAM/GkLdKa
	tJSS2xqjYNo+CXwsFfrn0kvwfDdsJBSF5BdBswfD+DBZTtdRAmTGp1m7YKY5J6TlU6qDtUaI/Sv
	jxGYYdzYa6TAtpeW3OiOPrgmtV/z997LV9qzeYcjfLuXvsKn3TDgwh/HAmlYtgtzR3cisNtzBtj
	rI5eT33xA5VsSQat+GMlPmR36U4LJn5iwYxKCNyxwJN/exZ4DxoQogW5ukMSXp5dwPGf192xOeg
	Q6UFLNfyt0+Os2mGzFF81vT4flsWWOOHazQD7VAww0D//7RsGXggTVY6EMcTr2D77Eb4A0E4Ph2
	6qHBhjsVoIf5Ovfvx/Dz/j+1akuzvQyz6pW3sQRLZKP7m4djbe9xOMMDVE9TnqbHuxPQhLpiRmN
	RcyA==
X-Google-Smtp-Source: AGHT+IEKV+JjMCOl7eFASI55Nw7wSFdRLeBwJDDUJQmSuHbbj21BVdCQpdCeTNsmKFhm0pXrszSq0Q==
X-Received: by 2002:a05:6830:4390:b0:7c6:cb39:adf7 with SMTP id 46e09a7af769-7ce508ce57emr11413632a34.6.1768221884738;
        Mon, 12 Jan 2026 04:44:44 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:59::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af8b2sm12584208a34.15.2026.01.12.04.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:44:44 -0800 (PST)
Date: Mon, 12 Jan 2026 04:44:42 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>, pmladek@suse.com, 
	osandov@osandov.com
Cc: mpdesouza@suse.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, 
	calvin@wbinvd.org, jv@jvosburgh.net, kernel-team@meta.com, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <jakydyx5dprrzgbsb6lorgpova46jbhq5tecwwtiihkhyi6ofy@olsrizfk52je>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
 <87zf6pfmlq.fsf@jogness.linutronix.de>
 <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
 <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
 <87eco09hgb.fsf@jogness.linutronix.de>
 <aWECzkapsFFPFKNP@pathway.suse.cz>
 <875x9a6cpw.fsf@jogness.linutronix.de>
 <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>

On Mon, Jan 12, 2026 at 02:55:06AM -0800, Breno Leitao wrote:
> > My ordered preferences for right now would be:
> > 
> > 1. keeping @caller_id semantics + adding @cpu + adding @comm (similar to
> > your C)

...

> Let me hack a new version of it with @comm, and post here to check how
> it looks likes.

How does this version look like according to the suggestion above. It is
mostly Petr's option C with a few changes:

  a) caller_id continues to be unchanged with (pid and context bit)
  b) Append @pid and @comm to printk_info


Author: Breno Leitao <leitao@debian.org>
Date:   Thu Jan 8 03:00:46 2026 -0800

    printk: Add execution context (task name/CPU) to printk_info
    
    Extend struct printk_info to include the task name and CPU number
    where printk messages originate. This information is captured at
    vprintk_store() time and propagated through printk_message to
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

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ac12eaf11755..12e47cb27ffa 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -341,6 +341,7 @@ config NETCONSOLE_DYNAMIC
 	bool "Dynamic reconfiguration of logging targets"
 	depends on NETCONSOLE && SYSFS && CONFIGFS_FS && \
 			!(NETCONSOLE=y && CONFIGFS_FS=m)
+	select CONSOLE_HAS_EXECUTION_CTX
 	help
 	  This option enables the ability to dynamically reconfigure target
 	  parameters (interface, IP addresses, port numbers, MAC addresses)
diff --git a/include/linux/console.h b/include/linux/console.h
index fc9f5c5c1b04..4bb97700806e 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -19,6 +19,7 @@
 #include <linux/irq_work.h>
 #include <linux/rculist.h>
 #include <linux/rcuwait.h>
+#include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 #include <linux/vesa.h>
@@ -298,12 +299,18 @@ struct nbcon_context {
  * @outbuf:		Pointer to the text buffer for output
  * @len:		Length to write
  * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
+ * @msg_comm:		Name of the task that generated the message
+ * @msg_cpu:		CPU on which the message was generated
  */
 struct nbcon_write_context {
 	struct nbcon_context	__private ctxt;
 	char			*outbuf;
 	unsigned int		len;
 	bool			unsafe_takeover;
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	char			msg_comm[TASK_COMM_LEN];
+	int			msg_cpu;
+#endif
 };
 
 /**
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 5f5f626f4279..039eb9b44a66 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -281,12 +281,18 @@ struct printk_buffers {
  *		nothing to output and this record should be skipped.
  * @seq:	The sequence number of the record used for @pbufs->outbuf.
  * @dropped:	The number of dropped records from reading @seq.
+ * @msg_comm:	Name of the task that generated the message.
+ * @msg_cpu:	CPU on which the message was generated.
  */
 struct printk_message {
 	struct printk_buffers	*pbufs;
 	unsigned int		outbuf_len;
 	u64			seq;
 	unsigned long		dropped;
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	char			msg_comm[TASK_COMM_LEN];
+	int			msg_cpu;
+#endif
 };
 
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 3fa403f9831f..38117b72d0b8 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -946,6 +946,18 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static inline void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+					    struct printk_message *pmsg)
+{
+	memcpy(wctxt->msg_comm, pmsg->msg_comm, TASK_COMM_LEN);
+	wctxt->msg_cpu = pmsg->msg_cpu;
+}
+#else
+static inline void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+					    struct printk_message *pmsg) {}
+#endif
+
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
@@ -1048,6 +1060,8 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	/* Initialize the write context for driver callbacks. */
 	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
+	wctxt_load_execution_ctx(wctxt, &pmsg);
+
 	if (use_atomic)
 		con->write_atomic(con, wctxt);
 	else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1d765ad242b8..76dfa7ee1d23 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2213,6 +2213,26 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 	return text_len;
 }
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static inline void printk_save_execution_ctx(struct printk_info *info)
+{
+	get_task_comm(info->msg_comm, current);
+	info->msg_cpu = smp_processor_id();
+}
+
+static inline void pmsg_load_execution_ctx(struct printk_message *pmsg,
+					   const struct printk_info *info)
+{
+	memcpy(pmsg->msg_comm, info->msg_comm, TASK_COMM_LEN);
+	pmsg->msg_cpu = info->msg_cpu;
+}
+#else
+static inline void printk_save_execution_ctx(struct printk_info *info) {}
+
+static inline void pmsg_load_execution_ctx(struct printk_message *pmsg,
+					   const struct printk_info *info) {}
+#endif
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -2320,6 +2340,7 @@ int vprintk_store(int facility, int level,
 	r.info->caller_id = caller_id;
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
+	printk_save_execution_ctx(r.info);
 
 	/* A message without a trailing newline can be continued. */
 	if (!(flags & LOG_NEWLINE))
@@ -3002,6 +3023,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 	force_con = r.info->flags & LOG_FORCE_CON;
+	pmsg_load_execution_ctx(pmsg, r.info);
 
 	/*
 	 * Skip records that are not forced to be printed on consoles and that
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 4ef81349d9fb..4ecb26d8dc8b 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -6,6 +6,7 @@
 #include <linux/atomic.h>
 #include <linux/bits.h>
 #include <linux/dev_printk.h>
+#include <linux/sched.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 
@@ -23,6 +24,10 @@ struct printk_info {
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
 	u32	caller_id;	/* thread id or processor id */
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	char	msg_comm[TASK_COMM_LEN]; /* name of the task that generated the message */
+	int	msg_cpu;	/* CPU where the message was generated */
+#endif
 
 	struct dev_printk_info	dev_info;
 };
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fda79..57f91ee10b8e 100644
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

