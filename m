Return-Path: <netdev+bounces-248505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB48D0A70E
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E9533002D1A
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C929435CB65;
	Fri,  9 Jan 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XR4rQF3r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8D733506B
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965399; cv=none; b=o9SM+pvTHoBnzMHIeE5uoYIzo4AfDeNlY5LAw5NjVzG56rUjjs4I6QjmJoNxEuN61wq4Xs8o3ZTcA40VkmcW5gGk61lNmcSFYwHdQpdfje4sAAc5gbP8sTo6Op/YiADlkR8HvZQHd4rhyO26tgZnmYf9+OeWBksFSLduufUyHSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965399; c=relaxed/simple;
	bh=24i/YweZXz9MvgqpmtsfhrPXBDdOuu+CO5uT54+fvfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifVoqw3l2CxjL1PAGVw5vntaSdPps7DhMEyMzqKCaeevjs4F4v7ulkbbBEueDbIAcBnFep0fikgl7MZ7vVKUtUGOUarRDGY23MJaNUUmBCDD5IguF3dY8teN9gLiWxXNeEpcmJkx4qHGZ289P7OzfRkvzNIGC1bfzAoyMGjU/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XR4rQF3r; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2388279f8f.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 05:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767965395; x=1768570195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdNxeMMwqg9n0j9uNb06mt2pI4eGh9zqhksT/7g8s1I=;
        b=XR4rQF3rzLf/nFZ2ostGa6reL6rTX/T7c45q/R05ESC2qEg1/9zOmh3t6zSqG3diX2
         4q4fPMScR4odTO3r+CyDJEuEc76RFbe6RVA7Dbs8koMdo4dvqR5n0k6Cp0Y++LOjHv7O
         lEKSLjPj8EkzrTovQIhnI9J4paWkau25L4YbsTLLbWyoF8+1XKtYZaSIHGERccpOZD4z
         AO+x3Swpjxga7mZwn32P/efQ/oDq8KNzez1PuXrqnPIc2wJxgjRi91+YuWiUtPJT8eeU
         RhN+AXD4oEsafB3RlqCt8GI7GUdf/AJ3jinibic4aF60QwxWvUjmMubuW1q9s6bf8cj4
         3Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767965395; x=1768570195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdNxeMMwqg9n0j9uNb06mt2pI4eGh9zqhksT/7g8s1I=;
        b=Cx8WNdYfAZNIihqjcxyEQ+Ozgiuvbvv0ralc622pwBJE9ragKE2MTaBthjI1eS6T3f
         HoWvM9bTE2gnRtDvlKave5Op2kV3BXaXmmxhZ0MccZdG75kMVwPwBILYG/R2uoov5u/r
         CmkYmWphdKtEdLK0a8escfTYtOg4DBWzpOxJTfTN5AycZpl2f5bTKjnnaClwZ4sT0ZB+
         EqtO0BeAsD46T/eadVeSFpeHj/yxjFdWXawuth15RC+ou8tk8l+vtxRztbxh/kejTuSv
         i9e6e3Jeo1pE+kMct8ObXzHHwP9RkluiUYnk35iBD05+oGoX+KJ6eRfLu5NVvo/chBOr
         S0tA==
X-Forwarded-Encrypted: i=1; AJvYcCXubcJj50zVMw4Wc0Gbr/5bZUMVDYJIJGFEAcUvupTXe5R+V81mN0G3P9NU/59GlrQaHubsHAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMmXk0jgKLm5VzDVPA9dqnny6omJDm2gvpRRFJ/h88QVDZ2+DO
	reO2Qye1/rYqccQ1hvpHQCKlVBXKALkYrIZJ84Gf0mtqw/FibLg8IkSdU56X6mSTJr0=
X-Gm-Gg: AY/fxX4/UwlHNtnL7iTWvXWqgGn7cWoqaA1nkASKnM5nwtMejBJl4uv5+DfEcc+LkyO
	bfF/UCb+yobJ3+WRRdU04pLeehG4FFaV4qAnnr9IG0aOSdXJN63xryePNe1n8ddsmLICbkrovq/
	Rqf3uA8vSI/F+Wgqnok1N+3JzgtcotNhroHBWcjE7tKV3rk48u6JlWiLTuR2lISrgJsj/MA4TPn
	JJWvI18u8hwiNvX/ux/7MM/d8CisJF76MNRJw8iPeuDLMdqY37j0A7CmgE8pZdTQIkFdC1y1KFo
	URLM0eSUo14QjafKQNJ0DvJmIaAlq38Ig0+xZTkjzzdpcioFYCHeLr6SgEguVx3ADcmUHRnxIki
	xBHuEDTD751tK4i/r7PrdUI3wYux2S0qS+msgFMHp1gjIp549CbeJ/7RnA94Ml9frTxegBgzO6c
	4/1gddKYP3peA/Dd1zG6T2peid
X-Google-Smtp-Source: AGHT+IEX7cPVMSLurLOF1lDxBhI+5RPgaCAXBqej7srl76NqZIhC1a3/xWqMXDx0Mh+A6MiFu/gaRw==
X-Received: by 2002:a05:6000:1449:b0:431:488:b9a8 with SMTP id ffacd0b85a97d-432c375b4eamr12141977f8f.33.1767965393131;
        Fri, 09 Jan 2026 05:29:53 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee893sm22135700f8f.37.2026.01.09.05.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:29:52 -0800 (PST)
Date: Fri, 9 Jan 2026 14:29:50 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Breno Leitao <leitao@debian.org>, mpdesouza@suse.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com,
	calvin@wbinvd.org, jv@jvosburgh.net, kernel-team@meta.com,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <aWECzkapsFFPFKNP@pathway.suse.cz>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
 <87zf6pfmlq.fsf@jogness.linutronix.de>
 <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
 <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
 <87eco09hgb.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eco09hgb.fsf@jogness.linutronix.de>

On Thu 2026-01-08 17:56:44, John Ogness wrote:
> On 2026-01-08, Breno Leitao <leitao@debian.org> wrote:
> > On Wed, Jan 07, 2026 at 08:58:39AM -0800, Breno Leitao wrote:
> > This is what I am thinking about. How bad is it?
> >
> > (I've also implemented the netconsole part as well, so, if you want to
> > have a tree, you can find it in
> > https://github.com/leitao/linux/tree/execution_context)
> 
> Thanks. It is very helpful to see how you intend to use it.
> 
> > commit fe79961da6cabe42343185cf1a7308162bf6bad3
> > Author: Breno Leitao <leitao@debian.org>
> > Date:   Thu Jan 8 03:00:46 2026 -0800
> >
> >     printk: Add execution context (PID/CPU) to dev_printk_info
> >     
> >     Extend struct dev_printk_info to include the task PID and CPU number
> >     where printk messages originate. This information is captured at
> >     vprintk_store() time and propagated through printk_message to
> >     nbcon_write_context, making it available to nbcon console drivers.
> >     
> >     This is useful for consoles like netconsole that want to include
> >     execution context in their output, allowing correlation of messages
> >     with specific tasks and CPUs regardless of where the console driver
> >     actually runs.
> >     
> >     The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
> >     automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
> >     the helper functions compile to no-ops with no overhead.
> >     
> >     Suggested-by: John Ogness <john.ogness@linutronix.de>
> >     Signed-off-by: Breno Leitao <leitao@debian.org>
> >
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index ac12eaf11755..e6a9369be202 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -341,6 +341,7 @@ config NETCONSOLE_DYNAMIC
> >  	bool "Dynamic reconfiguration of logging targets"
> >  	depends on NETCONSOLE && SYSFS && CONFIGFS_FS && \
> >  			!(NETCONSOLE=y && CONFIGFS_FS=m)
> > +	select PRINTK_EXECUTION_CTX
> >  	help
> >  	  This option enables the ability to dynamically reconfigure target
> >  	  parameters (interface, IP addresses, port numbers, MAC addresses)
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index fc9f5c5c1b04..c724f59f96e6 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -298,12 +298,18 @@ struct nbcon_context {
> >   * @outbuf:		Pointer to the text buffer for output
> >   * @len:		Length to write
> >   * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
> > + * @pid:		PID of the task that generated the message
> > + * @cpu:		CPU on which the message was generated
> >   */
> >  struct nbcon_write_context {
> >  	struct nbcon_context	__private ctxt;
> >  	char			*outbuf;
> >  	unsigned int		len;
> >  	bool			unsafe_takeover;
> > +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> > +	pid_t			pid;
> > +	int			cpu;
> > +#endif
> 
> Something like msg_pid/msg_cpu or printk_pid/printk_cpu might be better
> to make it clear we are not talking about _this_ context. This struct is
> used by code outside of the printk subsystem, which is why I think it
> needs to be more obvious what these represent.
> 
> @Petr: Any suggestions for names (assuming this is even acceptable)?
> 
> >  };
> >  
> >  /**
> > diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
> > index eb2094e43050..42ee778b29dd 100644
> > --- a/include/linux/dev_printk.h
> > +++ b/include/linux/dev_printk.h
> > @@ -27,6 +27,10 @@ struct device;
> >  struct dev_printk_info {
> >  	char subsystem[PRINTK_INFO_SUBSYSTEM_LEN];
> >  	char device[PRINTK_INFO_DEVICE_LEN];
> > +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> > +	pid_t pid;
> 
> I am not happy about this being resolved by the netconsole printer to
> get the task name. A lot can happen between now and then. But I also
> shudder at the thought of making dev_printk_info much larger. This is
> already a horrible waste of memory (which I talked about here[0]).
> 
> I also do not think dev_printk_info is the appropriate place to store
> this information. These new fields are not related to the dev_printk
> API. They belong in printk_info.
> 
> > +	int cpu;
> > +#endif
> >  };
> >  
> >  #ifdef CONFIG_PRINTK
> > diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> > index 5f5f626f4279..81e5cd336677 100644
> > --- a/kernel/printk/internal.h
> > +++ b/kernel/printk/internal.h
> > @@ -287,6 +287,10 @@ struct printk_message {
> >  	unsigned int		outbuf_len;
> >  	u64			seq;
> >  	unsigned long		dropped;
> > +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> > +	pid_t			pid;
> > +	int			cpu;
> > +#endif
> >  };
> >  
> >  bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index 3fa403f9831f..2465fafd7727 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -946,6 +946,18 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
> >  }
> >  EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
> >  
> > +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> > +static inline void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
> > +					    struct printk_message *pmsg)
> > +{
> > +	wctxt->pid = pmsg->pid;
> > +	wctxt->cpu = pmsg->cpu;
> > +}
> > +#else
> > +static inline void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
> > +					    struct printk_message *pmsg) {}
> > +#endif
> > +
> >  /**
> >   * nbcon_emit_next_record - Emit a record in the acquired context
> >   * @wctxt:	The write context that will be handed to the write function
> > @@ -1048,6 +1060,8 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
> >  	/* Initialize the write context for driver callbacks. */
> >  	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
> >  
> > +	wctxt_load_execution_ctx(wctxt, &pmsg);
> > +
> >  	if (use_atomic)
> >  		con->write_atomic(con, wctxt);
> >  	else
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 1d765ad242b8..ff47b5384f20 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2213,6 +2213,26 @@ static u16 printk_sprint(char *text, u16 size, int facility,
> >  	return text_len;
> >  }
> >  
> > +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> > +static inline void printk_save_execution_ctx(struct dev_printk_info *dev_info)
> > +{
> > +	dev_info->pid = task_pid_nr(current);
> > +	dev_info->cpu = smp_processor_id();
> > +}
> > +
> > +static inline void pmsg_load_execution_ctx(struct printk_message *pmsg,
> > +					   const struct dev_printk_info *dev_info)
> > +{
> > +	pmsg->pid = dev_info->pid;
> > +	pmsg->cpu = dev_info->cpu;
> > +}
> > +#else
> > +static inline void printk_save_execution_ctx(struct dev_printk_info *dev_info) {}
> > +
> > +static inline void pmsg_load_execution_ctx(struct printk_message *pmsg,
> > +					   const struct dev_printk_info *dev_info) {}
> > +#endif
> > +
> >  __printf(4, 0)
> >  int vprintk_store(int facility, int level,
> >  		  const struct dev_printk_info *dev_info,
> > @@ -2320,6 +2340,7 @@ int vprintk_store(int facility, int level,
> >  	r.info->caller_id = caller_id;
> >  	if (dev_info)
> >  		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
> > +	printk_save_execution_ctx(&r.info->dev_info);
> >  
> >  	/* A message without a trailing newline can be continued. */
> >  	if (!(flags & LOG_NEWLINE))
> > @@ -3002,6 +3023,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
> >  	pmsg->seq = r.info->seq;
> >  	pmsg->dropped = r.info->seq - seq;
> >  	force_con = r.info->flags & LOG_FORCE_CON;
> > +	pmsg_load_execution_ctx(pmsg, &r.info->dev_info);
> >  
> >  	/*
> >  	 * Skip records that are not forced to be printed on consoles and that
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index ba36939fda79..197022099dd8 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -35,6 +35,17 @@ config PRINTK_CALLER
> >  	  no option to enable/disable at the kernel command line parameter or
> >  	  sysfs interface.
> >  
> > +config PRINTK_EXECUTION_CTX
> > +	bool
> > +	depends on PRINTK
> > +	help
> > +	  This option extends struct dev_printk_info to include extra execution
> 
> It should extend printk_info instead.
> 
> > +	  context in pritnk, such as task PID and CPU number from where the
> 
>                      printk
> 
> > +	  message originated. This is useful for correlating device messages
> 
> Rather than "device messages" I suggest "printk messages".
> 
> > +	  with specific execution contexts.
> > +
> > +	  One of the main user for this config is netconsole.
> 
> Rather than saying which drivers might support this, it would probably
> be better to make it explicit. For example introducing a new config
> like:
> 
> CONFIG_CONSOLE_HAS_EXECUTION_CTX
> 
> that can only be selected by the console driver (or in your case, the
> console driver option NETCONSOLE_DYNAMIC). Then make
> PRINTK_EXECUTION_CTX depend only on CONSOLE_HAS_EXECUTION_CTX. That way
> it is only available if the console driver supports it.
> 
> > +
> >  config STACKTRACE_BUILD_ID
> >  	bool "Show build ID information in stacktraces"
> >  	depends on PRINTK
> 
> While this patch might be "good enough" to preserve the current
> CONFIG_NETCONSOLE_DYNAMIC features for NBCON, I am not happy about it:
> 
> 1. It relies on the printer context being able to determine context
> information about the printk() caller. I would prefer adding the task
> name directly to printk_info instead.

Good question. I think that both appraches might have users.
I see the machines on the opposite sides of a spectrum.

a) Huge machines, with hunderds of CPUs and TBs of RAM, might afford
   allocation of more space for kernel messages. And it might be even
   useful when they run containers which are quickly comming and
   going.

b) Small embeded systems want to keep kernel message buffer as small
   as possible. I guess that they mostly run just few processes all
   the time. So the mapping PID <-> COMM is stable.

Let's see how complicated it would be to make this configurable.

> 2. It adds information to printk records that only netconsole can
> use. If we want other consoles to support this, we would need to modify
> all the console code. I would prefer it is dynamically added to the
> generic printing text. We could do this by extending
> msg_print_ext_body() based on some user configuration. But it would
> conflict with the current netconsole format.
> 
> Despite my concerns, adding the PID and CPU information is generally
> useful. So I am not against expanding printk_info. My concerns are more
> about how this information is being used by netconsole.

I agree. I see how useful is even the current print_caller() which
shows either PID or CPU number depending on the context. And it does
not make sense to store this info twice.

If we were adding this info, I would add it for all users, definitely.
We are going to touch the internal printk ringbuffer format anyway.
Now, the main question is how far we want to go.

I see the following possibilities:

A) caller_id -> pid + cpu + atomic/task context bit
===================================================

Replace the current .caller_id and always save both PID and CPU
number. Something like:

diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 4ef81349d9fb..3c7635ada6dd 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -9,6 +9,12 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
+
+struct printk_caller {
+	pid_t	pid;	/* caller pid */
+	int	cpu;	/* caller CPU number */
+};
+
 /*
  * Meta information about each stored message.
  *
@@ -22,8 +29,8 @@ struct printk_info {
 	u8	facility;	/* syslog facility */
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
-	u32	caller_id;	/* thread id or processor id */
 
+	struct printk_caller caller;
 	struct dev_printk_info	dev_info;
 };

Plus the task/interrupt bit might be stored either as the highest bit
in .pid or by adding LOG_CALLER_IN_TASK bit into "enum printk_info_flags".


A) caller_id -> pid + cpu + contex
==================================

Same as above but the caller context info is stored separately and
might allow to distinguish more types. Something like:

diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 4ef81349d9fb..44aa60a3f84c 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -9,6 +9,19 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
+#define PRINTK_CALLER_CTXT_PREEMPT_BIT		1
+#define PRINTK_CALLER_CTXT_SOFTIRQ_BIT		2
+#define PRINTK_CALLER_CTXT_HARDIRQ_BIT		3
+#define PRINTK_CALLER_CTXT_NMI			4
+/* This is not supported on all platforms, see irqs_disabled() */
+#define PRINTK_CALLER_CTXT_IRQS_DISABLED	5
+
+struct printk_caller {
+	u8	ctxt;	/* caller context: task, irq, ... */
+	pid_t	pid;	/* caller pid */
+	int	cpu;	/* caller CPU number */
+};
+
 /*
  * Meta information about each stored message.
  *
@@ -22,8 +35,8 @@ struct printk_info {
 	u8	facility;	/* syslog facility */
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
-	u32	caller_id;	/* thread id or processor id */
 
+	struct printk_caller caller;
 	struct dev_printk_info	dev_info;
 };
 

C) caller_id -> pid + cpu + comm + atomic/task context bit
==========================================================

Similar to A and B but add also

	char comm[TASK_COMM_LEN];

into struct printk_caller.


D) caller_id -> pid + cpu + comm + atomic/task context bit
   and move printk_caller + printk_dev_info into text buffer
   as suggested as mentioned at
   https://lore.kernel.org/lkml/84y10vz7ty.fsf@jogness.linutronix.de
====================================================================

   There are many possibilities how to do it. And it involves two
   problems:

      a) how to store the data into data buffer
      b) how to integrate this in the ring buffer API

    I thought about several approaches and realized that it still
    would make sense to keep:

       + binary data (pid, cpu, ctxt) in desc ring
       + text data (comm, subsystem, device) in text_data buffer

    Something like:

diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 4ef81349d9fb..41232bf2919d 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -9,6 +9,27 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
+#define PRINTK_CALLER_CTXT_PREEMPT_BIT		0
+#define PRINTK_CALLER_CTXT_SOFTIRQ_BIT		1
+#define PRINTK_CALLER_CTXT_HARDIRQ_BIT		2
+#define PRINTK_CALLER_CTXT_NMI			3
+/* This is not supported on all platforms, see irqs_disabled() */
+#define PRINTK_CALLER_CTXT_IRQS_DISABLED	4
+
+struct printk_caller {
+	u8	ctxt;	/* caller context: task, irq, ... */
+	pid_t	pid;	/* caller pid */
+	int	cpu;	/* caller CPU number */
+};
+
+/*
+ * Describe which text information about the caller
+ * is stored in text_data_ring
+ */
+#define PRINTK_CALLER_BITS_COMM_BIT		0
+#define PRINTK_CALLER_BITS_SUBSYSTEM_BIT	1
+#define PRINTK_CALLER_BITS_DEVICE_BIT		2
+
 /*
  * Meta information about each stored message.
  *
@@ -22,9 +43,8 @@ struct printk_info {
 	u8	facility;	/* syslog facility */
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
-	u32	caller_id;	/* thread id or processor id */
-
-	struct dev_printk_info	dev_info;
+	u8	caller_bits_size; /* size of the caller info in data buffer */
+	u8	caller_bits;	/* bits describing caller in data buffer */
 };
 
 /*

The text would be stored in the test_data_ring in the following
format:

	[<comm>\0][<subsystem>\0][<device\0]<text>\0

aka, strings separated by '\0'. The information about the caller
would be optional where:

   + .caller_bits_size would contain the size of the optional
     pieces, including the trailing '\0's.

   + .caller_bits number would define which particular pieces
     are there. It would be even somehow extensible. The crash
     tool could ignore parts which are not supported.


My opinion:
===========

I personally think that the approach B) is the best compromise for now
because:

1. We really should distinguish task/interrupt context. IMHO, it is
   a very useful information provided by the caller_id now.

   The approach A) stores the context a hacky way. The approach B)
   is cleaner and provides even more precise info.


2. The mapping between PID and COMM might get lost if we do not store it.
   But it should not be problem most of the time because we try
   to flush consoles ASAP.

   I would keep it simple for now. We could add it later when it
   becomes a problem in practice.

   BTW: I think that we could detect when the mapping is valid
	by comparing task->start_time with current time...

   Devil advocate: Adding comm[TASK_COMM_LEN] into struct printk_info
		might be acceptable. It is "just" 16 bytes in compare
		with 64 bytes for dev_printk.


3. It would be nice to optimize the memory usage and store the
   optional and variable strings (comm, subsystem, device) into
   data buffer. But it looks like a non-trivial work.

   I would do this only when there is a real demand. And I haven't
   heard about that the current approach was not acceptable yet.


Best Regards,
Petr

