Return-Path: <netdev+bounces-250568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B67D33540
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 765AA30019C2
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EBA33C1A7;
	Fri, 16 Jan 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dYbiWw9N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E79238D22
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578834; cv=none; b=vClCFwrOgohJVH0XIHyOEliOKw2ryM7tekA2GjY5dsMJ2IaioSV4Tx6DhSopWX+Zbni2jgGm59s7SfDCMQJqZduSXtxPFd2dmBABNvIYf8nEymD9K759YbRqMVP0Ik1wKfxrv5WqBsRBUdPdrxK0mOYd78Tvla1LVdApgYH+yeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578834; c=relaxed/simple;
	bh=0xEa8Yb22m/PsM7QL1vxfsX1JgV7ZzzkddwYB4rgMgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbgElR2WZIiLnWt8/+UQ8E1QikPLQESUZE+BdxzsZY9RWf0XlaIyn4EV0qCqjr4Nv1TYrLsKxT5nrVM4IZrkA7zI7o6eRtNwuSg6/Y22v0RXjum91Eopg1aNeqPxoiy3JbqLWXqRLrIt4ChHBzvfNkTTK3LXgJVKG6FZp3RoMB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dYbiWw9N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee07570deso16135715e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768578831; x=1769183631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhfsGF0Lr88dXj6BtoBIvCxUcSfXthaHRcGxI1cR848=;
        b=dYbiWw9NvUSJ53sSpvT07m9/6bVcl0krUts0Vj0oLZ7hjFnpTMuw20a5GlTyUQk7GH
         M1v2BkmIi0LswoGzs6qbSbqyZme9O2ajBC/pSuU6RVSbDhvDvNTqY7WtsA3TbMmVIGsy
         BJ80ouItJqdqvCoCCM66Kl3J+0POSuAH2P1L1kDx/WxLOSkNQcBokUIiygFYizTGrbKS
         pXYcOOdWE+GutIRN9h/uR/KWZ6jtN9prSih2AWCfQMqNF95aL+XkDMzc+AMEfQWtfjzk
         8oA+/leSK83V9jEwTj+ynnV91MLqWzj5/yEgLM4EXgFSieza2mY/Gy5xk4hJSgoZ/mxr
         pQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578831; x=1769183631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhfsGF0Lr88dXj6BtoBIvCxUcSfXthaHRcGxI1cR848=;
        b=vYq60x2cpSanl563P8CDFzFDYeHs8DG2qmmX3yt6EuxN6bHZhUW+/QNhuN2yRazDwp
         utkukf92HRRHOK35HNOEzchC0JSBl3YKUzYV3qz4ad2OLPP0pu3rP0cT3KMnbOXUVDxo
         I3zD+e8dIwYDwDyw4WLl6gs8PeRkMaSYispMuybZFubIsA/3+AUbYel8T9RkgLk+siy2
         86VTWmr8Qr18VIW8JhWNeZZMlentATOW5Ci/h3KDttkUpGyrHpCoIvZd6LcO8tIYL701
         6/Ai7qmx8ln6mC8g8qyP2+PIuDG59wLQYLr0BlZP3aWoUA2AHthZ4VymuLnQ3Lvfivsp
         B+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVm1Cz+11D011OjBhS703RDjVtc87oTWEPJnJ/zeYBnc/Nb9wNeYx1Tsa2Usibum3+r4AqrLzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDsIQhbIbyKkbig81KVeOxU3qp2bNW2hzWtZxSDgSOJRdHxCj
	aynM7FoVrary0mxwgyLHXe9gWGj0js1GwOV8DVF5CarDO5yBcbFG26eUyx81pLCAOV8=
X-Gm-Gg: AY/fxX5BgvqxAkKswexbwjUgIvsXgXdjGQadLv4+tyZ6+eraOL0iImVf50XbBTwaYVI
	w1+d+qzXKrc/3aAQCpRyO7bbeaoXtEkWkN0SYOnYX0QVAbZmKz0XID9b+ABmgO7NEO4EcbvaGoB
	tIs4ooZXMIabqclYTedTqjgAw01gpBzgnrCEERdC+TzPvMPpwbGCQNhDrqJZ7yD523kjGD3Dfvm
	YiXp5peyAQhsKT3hJgFP8r5quhtV7mnf+br9mg5ZYCTq6vtRXLW7WgqQPJMo92Y1kZJp7hShw/m
	3yd+W/MAWn3fqHz3UlIDpqHXOkBM26tl7FECQds9QOjnEePvgRgL7vvD0ntdPuvuCf5ZhXLhI6S
	RqKpp18lu6U5EEQpsfKH+Oc6rigpr13sm8WV3KGN1jE4U1nt88HecFTlOGramu+TFSxVRp+dtNN
	SSM6h7FItA9gj7SA==
X-Received: by 2002:a05:600c:4448:b0:47e:e2b0:15ba with SMTP id 5b1f17b1804b1-4801eab9ed9mr38086855e9.8.1768578831547;
        Fri, 16 Jan 2026 07:53:51 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921dddsm6174633f8f.6.2026.01.16.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:53:51 -0800 (PST)
Date: Fri, 16 Jan 2026 16:53:48 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: John Ogness <john.ogness@linutronix.de>, osandov@osandov.com,
	mpdesouza@suse.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	kernel-team@meta.com, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <aWpfDKd64DLX32Hl@pathway.suse.cz>
References: <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
 <87zf6pfmlq.fsf@jogness.linutronix.de>
 <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
 <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
 <87eco09hgb.fsf@jogness.linutronix.de>
 <aWECzkapsFFPFKNP@pathway.suse.cz>
 <875x9a6cpw.fsf@jogness.linutronix.de>
 <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>
 <jakydyx5dprrzgbsb6lorgpova46jbhq5tecwwtiihkhyi6ofy@olsrizfk52je>
 <aWpekVlhRpD4CaDI@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWpekVlhRpD4CaDI@pathway.suse.cz>

On Fri 2026-01-16 16:51:49, Petr Mladek wrote:
> On Mon 2026-01-12 04:44:42, Breno Leitao wrote:
> > On Mon, Jan 12, 2026 at 02:55:06AM -0800, Breno Leitao wrote:
> > 
> >     printk: Add execution context (task name/CPU) to printk_info
> >     
> > 
> > --- a/kernel/printk/printk_ringbuffer.h
> > +++ b/kernel/printk/printk_ringbuffer.h
> > @@ -23,6 +24,10 @@ struct printk_info {
> >  	u8	flags:5;	/* internal record flags */
> >  	u8	level:3;	/* syslog level */
> >  	u32	caller_id;	/* thread id or processor id */
> > +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> > +	char	msg_comm[TASK_COMM_LEN]; /* name of the task that generated the message */
> > +	int	msg_cpu;	/* CPU where the message was generated */
> 
> I would allow to store the caller_id complement so that we
> always store both cpu and pid.
> 
> Also I would remove the "msg_" prefix. It is not bad. But it is
> inconsistent with the existing "caller_" prefix. And the meaning
> should be obvious because it is stored in struct printk_info...
> 
> Otherwise, it looks good to me.
> 
> I tried to update your patch with the above proposal to see how
> it looks and I got:

The change seems to work. I have tested it with the following patch:

From 1966dc35bb19eb3fc13ca41257203819c36cd21b Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Fri, 16 Jan 2026 16:38:16 +0100
Subject: [PATCH 2/2] printk: Test extended execution context

Compile with

CONFIG_NETCONSOLE=y
CONFIG_NETCONSOLE_EXTENDED_LOG=y
CONFIG_CONSOLE_HAS_EXECUTION_CTX=y
CONFIG_PRINTK_EXECUTION_CTX=y

Then the extended console format should show also:

     ,cpu=XXX,pid=YYY,comm=ZZZ

For example:

[...]
6,776,2595848,-,caller=T167,cpu=3,pid=167,comm=scsi_eh_4;ata5: SATA link down (SStatus 0 SControl 300)
6,777,2623478,-,caller=T1,cpu=11,pid=1,comm=swapper/0;sched_clock: Marking stable (2420002924, 202869031)->(2789319400, -166447445)
6,778,2626663,-,caller=T159,cpu=2,pid=159,comm=scsi_eh_0;ata1: SATA link down (SStatus 0 SControl 300)
6,779,2671763,-,caller=T1,cpu=7,pid=1,comm=swapper/0;registered taskstats version 1
6,780,2672803,-,caller=T163,cpu=3,pid=163,comm=scsi_eh_2;ata3: SATA link down (SStatus 0 SControl 300)
[...]
4,1210,238099642,-,caller=C11,cpu=11,pid=0,comm=swapper/11; common_startup_64+0x13e/0x141
4,1211,238099651,-,caller=C11,cpu=11,pid=0,comm=swapper/11; </TASK>
4,1212,238099652,-,caller=C7,cpu=7,pid=0,comm=swapper/7;NMI backtrace for cpu 7
4,1213,238099655,-,caller=C7,cpu=7,pid=0,comm=swapper/7;CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.19.0-rc5-default+ #475 PREEMPT(full)  9097c5ae70fd66490486e279e5273a94d14cd453
[...]

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 84 ++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bc09fb6e33d1..ac8eccb1d2fc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -630,6 +630,40 @@ static int check_syslog_permissions(int type, int source)
 	return security_syslog(type);
 }
 
+#define caller_id_mask 0x80000000
+
+static inline u32 printk_caller_id(void)
+{
+	return in_task() ? task_pid_nr(current) :
+		caller_id_mask + smp_processor_id();
+}
+
+
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+/* Store the opposite info than caller_id. */
+static inline u32 printk_caller_id2(void)
+{
+	return !in_task() ? task_pid_nr(current) :
+		caller_id_mask + smp_processor_id();
+}
+
+static inline pid_t printk_info_get_pid(const struct printk_info *info)
+{
+	u32 caller_id = info->caller_id;
+	u32 caller_id2 = info->caller_id2;
+
+	return caller_id & caller_id_mask ? caller_id2 : caller_id;
+}
+
+static inline int printk_info_get_cpu(const struct printk_info *info)
+{
+	u32 caller_id = info->caller_id;
+	u32 caller_id2 = info->caller_id2;
+
+	return (caller_id & caller_id_mask ? caller_id : caller_id2) & ~caller_id_mask;
+}
+#endif
+
 static void append_char(char **pp, char *e, char c)
 {
 	if (*pp < e)
@@ -641,6 +675,7 @@ static ssize_t info_print_ext_header(char *buf, size_t size,
 {
 	u64 ts_usec = info->ts_nsec;
 	char caller[20];
+	char ext_caller[100];
 #ifdef CONFIG_PRINTK_CALLER
 	u32 id = info->caller_id;
 
@@ -650,11 +685,22 @@ static ssize_t info_print_ext_header(char *buf, size_t size,
 	caller[0] = '\0';
 #endif
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	snprintf(ext_caller, sizeof(ext_caller),
+		 ",cpu=%u,pid=%u,comm=%s",
+		 printk_info_get_cpu(info),
+		 printk_info_get_pid(info),
+		 info->comm);
+#else
+	ext_caller[0] = '\0';
+#endif
+
 	do_div(ts_usec, 1000);
 
-	return scnprintf(buf, size, "%u,%llu,%llu,%c%s;",
+	return scnprintf(buf, size, "%u,%llu,%llu,%c%s%s;",
 			 (info->facility << 3) | info->level, info->seq,
-			 ts_usec, info->flags & LOG_CONT ? 'c' : '-', caller);
+			 ts_usec, info->flags & LOG_CONT ? 'c' : '-',
+			 caller, ext_caller);
 }
 
 static ssize_t msg_add_ext_text(char *buf, size_t size,
@@ -2131,40 +2177,6 @@ static inline void printk_delay(int level)
 	}
 }
 
-#define caller_id_mask 0x80000000
-
-static inline u32 printk_caller_id(void)
-{
-	return in_task() ? task_pid_nr(current) :
-		caller_id_mask + smp_processor_id();
-}
-
-
-#ifdef CONFIG_PRINTK_EXECUTION_CTX
-/* Store the opposite info than caller_id. */
-static inline u32 printk_caller_id2(void)
-{
-	return !in_task() ? task_pid_nr(current) :
-		caller_id_mask + smp_processor_id();
-}
-
-static inline pid_t printk_info_get_pid(const struct printk_info *info)
-{
-	u32 caller_id = info->caller_id;
-	u32 caller_id2 = info->caller_id2;
-
-	return caller_id & caller_id_mask ? caller_id2 : caller_id;
-}
-
-static inline int printk_info_get_cpu(const struct printk_info *info)
-{
-	u32 caller_id = info->caller_id;
-	u32 caller_id2 = info->caller_id2;
-
-	return (caller_id & caller_id_mask ? caller_id : caller_id2) & ~caller_id_mask;
-}
-#endif
-
 /**
  * printk_parse_prefix - Parse level and control flags.
  *
-- 
2.52.0


