Return-Path: <netdev+bounces-248493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF843D0A41C
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D081E3075799
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABED35C199;
	Fri,  9 Jan 2026 12:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64435B149
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962759; cv=none; b=ladQTx4/427GsfcFgIKyjStHaB2lwIcd0yUefr0pmFPIlsG1SMRNyZzDDGprR9PnFSm+QInlQJhJ2+MNnZJJnFfPqWF1SXSgQF/hQE9TQAvf6cT726VMRkt/bZTS9zfPmedSnaH1NCMrsLldQmqtA820kqNEABSo1mi21qi7F6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962759; c=relaxed/simple;
	bh=0pzfVJ7bHHkboSH6jHOWl8BiVjekVNsqMcE6PbrRoFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s220QN5j8lf7NSH6e39WjwtZfQVPw7kLMwV/akn0ZzsOpjjEKkgu1IL5WKLWLSySqRN316Nu2alDxGacaY1Z2THZxTI4r4fRyB5o3OzJmV6QDL4xhfUakhtwkX75vzLYK8ijKddY04L0sVNFJxQcd6OWVpS+i2W2dhslqVD7dWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8888546d570so51235396d6.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 04:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767962757; x=1768567557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmsdmjjjvDrbrLW5W6lOcG/dmw8rZZmLBnSTgWkXsbM=;
        b=w2akmF7k4MW15VHSNN2lH/5H11nYzx3EF3O9w46kNwrPHbMDi+gmJUNECcRdpKiN4M
         riAoi1WHBeC6FygrYhUeCmbZU6EDv+ixAwZsq7dwsofxhUkTl40+X+vAy3xTWcr6Lyn4
         4PFpO8xWdtc7eyMleDR8GiU/DwG3x35ILssyDDL7+lpxpYU+9hUTqzuR8CxlGEy4LlI3
         u0l7FI5SH8ls39ZK9EV51F3LvaI4X5nsVjjRn7YSTBoJavtK2RViZH3eqOG4xuimHSbb
         15zCwHxImTt+WNvQz6RekqhnESzLtsaPmlkC1w8bUKkhS68IiTGMC0jrpId2ZvDliyqx
         XeBw==
X-Forwarded-Encrypted: i=1; AJvYcCUDr+67kBWlTxL0d2WD06hN4e+CXuX2JqDBDhp1IcLA6/KDIg9sEpU4wSQdSOw+6QkGyOQMWEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rRe4xjhU5aUjP+NuNbifaUgKOTZuCe7VdXtpFY/rVzFNZMH0
	4KOkMLcklPQrmeHTqOr/oUrFgnqNehTP4hK+xBn7wxQjjeJKHeVYV7lLW56IxA==
X-Gm-Gg: AY/fxX4G/zSX7EoxHvabvZqPYi4NCGy41hFryeVEpwg2Qpb8aa5bPPxU/vV53nb+KgH
	b4oF1mnGnmY7tdSrKdm/oCJtmQprpVJiy5CXXtVHAdNBBJxfhzuO6pHKOK6xZN5PXXk5ZT5zXe/
	pGJBdjK7hzhfBUbw+hnpyJbWoaeK45RSzG1YNGAFOnR4ev01g/ZXt5VFmrxp3NsMi0EgELY6z4X
	E1a4dKDLmjOnJzhB38xy3uga4m2qY4sjJiptjYUFVsuysVs6uwMjkV/IUVExcHC/tmr0LO8z3yl
	Anr5U7hacNlKPm7MSlqNu0tdlJ5AcWBT796QJUyu+l29X2YazQpb7YIMiI8luBB+ER3+Jyqh7lw
	Z1j/ubtXrMW8scc9VmzERFvG8msJcjZYzgXB58SdalXeqdTl+41fLz4HBhGoZz+qU9BnLW9hqUg
	tf5Q==
X-Google-Smtp-Source: AGHT+IGmDpnGsIfT4SQR3WwrRfusYLCNDOkRk5gbft86HExu5O86qrdr1R3kKgvG+BVsiR6QdQmPqg==
X-Received: by 2002:a05:6830:25c2:b0:7ce:517b:6010 with SMTP id 46e09a7af769-7ce517b611emr6429658a34.8.1767955738007;
        Fri, 09 Jan 2026 02:48:58 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ee990sm7378522a34.30.2026.01.09.02.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:48:56 -0800 (PST)
Date: Fri, 9 Jan 2026 02:48:51 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: pmladek@suse.com, mpdesouza@suse.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, 
	calvin@wbinvd.org, jv@jvosburgh.net, kernel-team@meta.com, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <bf367mxsrilyjwg433pnoy2dqis3gw6r647zt3sztsi7zwyk4n@efzf3y4etvms>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eco09hgb.fsf@jogness.linutronix.de>

On Thu, Jan 08, 2026 at 05:56:44PM +0100, John Ogness wrote:
> On 2026-01-08, Breno Leitao <leitao@debian.org> wrote:
> 
> > +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> > +	pid_t			pid;
> > +	int			cpu;
> > +#endif
> 
> Something like msg_pid/msg_cpu or printk_pid/printk_cpu might be better
> to make it clear we are not talking about _this_ context. This struct is
> used by code outside of the printk subsystem, which is why I think it
> needs to be more obvious what these represent.

Acknowledged.

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

I encountered the same dilemma. There's also another trade-off: passing
the context from the msg to netconsole requires some string copies.

Instead of simple assignments like "pmsg->msg_pid = info->msg_pid" and
"wctxt->msg_pid = pmsg->msg_pid", we would need to use strcpy.

I'm fine with either approach — happy to defer to your preference.

> I also do not think dev_printk_info is the appropriate place to store
> this information. These new fields are not related to the dev_printk
> API. They belong in printk_info.

Acknowledged.

> > +	  This option extends struct dev_printk_info to include extra execution
> 
> It should extend printk_info instead.

Acknowledged.

> 
> > +	  context in pritnk, such as task PID and CPU number from where the
> 
>                      printk
> 
> > +	  message originated. This is useful for correlating device messages
> 
> Rather than "device messages" I suggest "printk messages".

Acknowledged.

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

Good idea. This creates a transitional layer between the context and
printk's internal configuration: consoles explicitly select
CONSOLE_HAS_EXECUTION_CTX, which in turn enables PRINTK_EXECUTION_CTX.

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

That would be straightforward to implement and would simplify things for
console users like netconsole. The trade-off is increased memory usage
in printk_info, printk_message, and nbcon_write_context, plus some
additional strscpy calls.

I don't have a strong preference here.

> 2. It adds information to printk records that only netconsole can use.
>    If we want other consoles to support this, we would need to modify
>    all the console code. I would prefer it is dynamically added to the
>    generic printing text. We could do this by extending
>    msg_print_ext_body() based on some user configuration.

This would address the problem for other consoles, but based on my
understanding of earlier discussions [0], that doesn't seem to be the
direction you guys decided.

Link: https://lore.kernel.org/lkml/20200904082438.20707-1-changki.kim@samsung.com/ [0]

>  But it would conflict with the current netconsole format.

Good point. Let me provide some additional context that may help us find
a better solution.

Netconsole's sysdata and userdata append data to printk messages in a
similar fashion to the dictionary/dev_printk_info — essentially an
extension of dev_printk_info data (though with one regrettable
inconsistency: the keys are lowercase).

Here's an example of a netconsole message with dev_printk_info plus sysdata:

  <message>
   SUBSYSTEM=net
   DEVICE=+pci:0000:00:1f.6
   cpu=42
   taskname=NetworkManager
   ...

So while the format is similar, the differences are significant enough
that moving cpu/taskname from netconsole to printk/dev_printk_info
wouldn't be trivial.

> Despite my concerns, adding the PID and CPU information is generally
> useful. So I am not against expanding printk_info. My concerns are
> more about how this information is being used by netconsole.
> 
> @Petr: I am really curious to hear your thoughts on this.

Thanks for the feedback and for helping me work through this. Let's see
what @Petr has to say, and then we can decide how to proceed.

--breno

