Return-Path: <netdev+bounces-248045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348ABD036EA
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12E2C303BA92
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1DC461DA7;
	Thu,  8 Jan 2026 11:08:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B6461DB0
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870511; cv=none; b=AGAX8AaasjjFNl8U7h/LiCwInUHb/5aUjipLdei0sA4Tq1YmpuA3QPCMr5A+wWEF2UXexGgNXssS4aYRi7fDEuZnl9G9uaHCHQK077RAlMFC4JvxcBdofnMekHGotCTCXkN1SETzKIit4m7eH2m9u1G+3clLxNtsMEJYLy/188c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870511; c=relaxed/simple;
	bh=wcGRWM+RnRdB3POnfupDCWelJbx+Hr39/IrIZi1Sq3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mck8Gx7hP3jAMZzkYQSXg0rg/oMTZMMP5MUl55INU1Mxz5epJKkxn3yH3rAd0wV9UvJzbuVsf8ajbYPZR4JpBHdAH2jbNx07bE7njaiqs0UXkAP/XfNHiBsn1DsBhdXH3ldJpCqGTwf3eONyym/YGzqJYbbT93DopJ7H+Ty13FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65cff0c342eso2151070eaf.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 03:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767870499; x=1768475299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlbXXe8ivVlM+DeeY84GE+OAIs3+4LxqS0gyqDVJQ5A=;
        b=OPBk/t93AHCtJaNnYZsugxKdntkchFvTLqYkEjawacnyMrFsq2qp45jqJ09+bvs+j8
         zqoVHuvRWu999Ky8MyzoFGbAwYJPkfwEqPAu2a2q+YgqZFYGtIXa0REDYLycGbX777M4
         bALXJTWiWqtwfiuDRYWX9nNt2/rw2nH9ZnbUgWPGfIzR+FIpcHmGqOt6VQHHpKf64QXH
         uOPf09JlVHPtZVabPxArw/YNUZUKTTejZPNkh5sh707bXtCJ0yDJxpJeGhwKw6Po+xk7
         CFpFp5EbtQRsKkZH6b9dRRbhMidg+BmdUe3xkN3tJJbunO36TIvJmOu4UFP+s8NEASrG
         eBLg==
X-Forwarded-Encrypted: i=1; AJvYcCVJML0HLyczW4EX0OYBwncuA1F/lXwPkuecWQYSFezIzvg0jxhFoBG0dfm9Ts4xpQPQK/s19vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhzZ+c9OCUiBmgkzstnqiLuAiPCPKgBDkCm/PIQKh93IJPFC1H
	HlHABAF+4EiTLqhjqLzp3QNdMBsxog1b4UOMzJdJhK1cPWh2p1y1oGaX
X-Gm-Gg: AY/fxX5jaNk9TJWwGR+I6/rucNJ8uwQLU6G0ZM3SV9Qp+FUa86NsPIg4PPEQmx1rQ6o
	9V+FHBhh9kafb+Buo43/EaEWwtdfPFkCPklE1eHGdpKa24Oc7jB0UpTa5CRrT1axl8YVPc8y+B7
	L5l3nM7DbABz1SlsPicJh90wGHywXBaHdj7qh9XqUidaMp2WSjNZsTT6iaHWgqTsmzLwsxKQjHC
	5gCnKUH9WY0BhBdJxiAmbCpUw24oWds8I3TPLdwokNnSMsHl/tzklhxbBFBWbrb/LnXg13f6Xi1
	xFKdehn3VmbpLIlYCSXSibElrRs6ECH8ENMKVhzgHWhSPFmmsl9fZ91he+sRDD1Yjo/ELtDS8x9
	BNqvZwoDqt/vr5t1I/iv+rxDp7btbT2SyqnQgzXIS2p7KSJRZKyQZdRZlEIVtuuwpNY97VveCuy
	ml91jTszXMH0wP
X-Google-Smtp-Source: AGHT+IFcPD+ED5vq4PSH9sGAATnX//FOjx5ZkRYp2X6L9Gh1I9FJuyRqd7zLWOVuXVwlMFRnhpKBNQ==
X-Received: by 2002:a05:6820:f002:b0:65d:a79:568b with SMTP id 006d021491bc7-65f54eebcccmr2237188eaf.34.1767870499469;
        Thu, 08 Jan 2026 03:08:19 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48cb03d4sm3297830eaf.12.2026.01.08.03.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:08:18 -0800 (PST)
Date: Thu, 8 Jan 2026 03:08:16 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>, pmladek@suse.com, 
	mpdesouza@suse.com
Cc: pmladek@suse.com, mpdesouza@suse.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, 
	calvin@wbinvd.org, jv@jvosburgh.net, kernel-team@meta.com, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
 <87zf6pfmlq.fsf@jogness.linutronix.de>
 <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>

On Wed, Jan 07, 2026 at 08:58:39AM -0800, Breno Leitao wrote:
> On Wed, Jan 07, 2026 at 04:56:41PM +0106, John Ogness wrote:
> 
> Thanks. Let me prototype this and see how it turns out.

This is what I am thinking about. How bad is it?

(I've also implemented the netconsole part as well, so, if you want to
have a tree, you can find it in
https://github.com/leitao/linux/tree/execution_context)


commit fe79961da6cabe42343185cf1a7308162bf6bad3
Author: Breno Leitao <leitao@debian.org>
Date:   Thu Jan 8 03:00:46 2026 -0800

    printk: Add execution context (PID/CPU) to dev_printk_info
    
    Extend struct dev_printk_info to include the task PID and CPU number
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
index ac12eaf11755..e6a9369be202 100644
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
index fc9f5c5c1b04..c724f59f96e6 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -298,12 +298,18 @@ struct nbcon_context {
  * @outbuf:		Pointer to the text buffer for output
  * @len:		Length to write
  * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
+ * @pid:		PID of the task that generated the message
+ * @cpu:		CPU on which the message was generated
  */
 struct nbcon_write_context {
 	struct nbcon_context	__private ctxt;
 	char			*outbuf;
 	unsigned int		len;
 	bool			unsafe_takeover;
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	pid_t			pid;
+	int			cpu;
+#endif
 };
 
 /**
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index eb2094e43050..42ee778b29dd 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -27,6 +27,10 @@ struct device;
 struct dev_printk_info {
 	char subsystem[PRINTK_INFO_SUBSYSTEM_LEN];
 	char device[PRINTK_INFO_DEVICE_LEN];
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	pid_t pid;
+	int cpu;
+#endif
 };
 
 #ifdef CONFIG_PRINTK
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 5f5f626f4279..81e5cd336677 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -287,6 +287,10 @@ struct printk_message {
 	unsigned int		outbuf_len;
 	u64			seq;
 	unsigned long		dropped;
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	pid_t			pid;
+	int			cpu;
+#endif
 };
 
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 3fa403f9831f..2465fafd7727 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -946,6 +946,18 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static inline void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+					    struct printk_message *pmsg)
+{
+	wctxt->pid = pmsg->pid;
+	wctxt->cpu = pmsg->cpu;
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
index 1d765ad242b8..ff47b5384f20 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2213,6 +2213,26 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 	return text_len;
 }
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static inline void printk_save_execution_ctx(struct dev_printk_info *dev_info)
+{
+	dev_info->pid = task_pid_nr(current);
+	dev_info->cpu = smp_processor_id();
+}
+
+static inline void pmsg_load_execution_ctx(struct printk_message *pmsg,
+					   const struct dev_printk_info *dev_info)
+{
+	pmsg->pid = dev_info->pid;
+	pmsg->cpu = dev_info->cpu;
+}
+#else
+static inline void printk_save_execution_ctx(struct dev_printk_info *dev_info) {}
+
+static inline void pmsg_load_execution_ctx(struct printk_message *pmsg,
+					   const struct dev_printk_info *dev_info) {}
+#endif
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -2320,6 +2340,7 @@ int vprintk_store(int facility, int level,
 	r.info->caller_id = caller_id;
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
+	printk_save_execution_ctx(&r.info->dev_info);
 
 	/* A message without a trailing newline can be continued. */
 	if (!(flags & LOG_NEWLINE))
@@ -3002,6 +3023,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 	force_con = r.info->flags & LOG_FORCE_CON;
+	pmsg_load_execution_ctx(pmsg, &r.info->dev_info);
 
 	/*
 	 * Skip records that are not forced to be printed on consoles and that
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fda79..197022099dd8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -35,6 +35,17 @@ config PRINTK_CALLER
 	  no option to enable/disable at the kernel command line parameter or
 	  sysfs interface.
 
+config PRINTK_EXECUTION_CTX
+	bool
+	depends on PRINTK
+	help
+	  This option extends struct dev_printk_info to include extra execution
+	  context in pritnk, such as task PID and CPU number from where the
+	  message originated. This is useful for correlating device messages
+	  with specific execution contexts.
+
+	  One of the main user for this config is netconsole.
+
 config STACKTRACE_BUILD_ID
 	bool "Show build ID information in stacktraces"
 	depends on PRINTK

