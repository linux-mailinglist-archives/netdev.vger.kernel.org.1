Return-Path: <netdev+bounces-261998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK/AARQhomm4zwQAu9opvQ
	(envelope-from <netdev+bounces-261998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:56:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9E01BED15
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F355305ED28
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A33D1CCD;
	Fri, 27 Feb 2026 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lybEYp5q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15437B3EF
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232976; cv=none; b=R+mBpyS6txXxbmYK9HpSV3GszHFO62lr8TkLK+KN6dk2FM8OF8LP97wfCBLSjjRi5c2uzTFxucBc43uq1M4d9Iv6HSTEtdZCxrWqjgMG9sJmf14967wIDmubE+AG7Gop0+tuIpG5ZHpH0B2pgzVddJ0YsrDOVxHFRHKauxqFcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232976; c=relaxed/simple;
	bh=tGHbvMzJBZkvJu7/EnzVGWTJZo+LV6O5gW930K2bwh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGN2poI/iyzyJLIZAxSv9FQIO7JHfCPwJ8zdo/rdt4rmYUFfMdq+SMWDUmXRxmO9CrlmMPU/hoJtv8saALn3xqkW1Ih6kYH2llkfzPK5WBzLbGeA5VbDMSocysIVifRfvYKJIsMjOmriX1hKSO7kiz/ViEjwy7Hq2jzllPYhgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lybEYp5q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so28815ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772232975; x=1772837775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aaHPjOliG6TSwy/BTU0mhIdonMpqhWbW5rNhQojlWZs=;
        b=lybEYp5qhSa2x0/TIangJQoxqJQrQmsYfWbyll5xmPfECLu602nUHPCpjSXtpuMXAQ
         slG4LwAKgshqXACTQyYfULIsYaf77LakH6t8sF3T1EoUpoym6wpRbzGTqkQfrdSQR9r9
         vg/Km2ZE52bEvshpY9pOUqScTwO8mPvCTNwVA2Wrc+3xKSAuaXypErxa8cHqN4LOb7yC
         3tVQiDku/gyGmXQaODiIx0H/+tya44tbmhljZPFrojG1VMgjFzK3gF+dpqpwm5azZx+Y
         hJ79K+sOwIveknK/o01rlG8TnV/VXOmNW2Cxirz+Vk5PUGpoQOL9EoVcwGtw0PaZhaIu
         AVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232975; x=1772837775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaHPjOliG6TSwy/BTU0mhIdonMpqhWbW5rNhQojlWZs=;
        b=WaqhfjUgdLgZRFRZna2sYE+WdRnS/gtA6zmQRT8bGF8YtmdTojendqr1rbnVRo5Hzf
         MNH6pxC2u5KrKNtnIZHdU/983SVaXpecE3Cenky76ZBjOGabgYV/WHV11Y8TZgs7hU+v
         ZeujCHYFygu5a82pbnqQIqonRiNlD/h3Y1snc99Rb2XRt7XIxU93gBdm1gIO62qbbdcv
         IuMSguqvZsrLL2mOu8AKeNtgzHNSfCGGu21LyPE4gw5HKy87QgQqq0jFxLUsCPv5xNR3
         Rmz1qyv9OtASaocYbiLi2Sfm3QqByUbsdUvQuwmS9VCfbyymbh2USUVRV1teos3JK6zc
         rEqw==
X-Forwarded-Encrypted: i=1; AJvYcCV/0D8c5MwoiNoTlgrNfw7XCZdI2GkNyc5CtgfKaaImQKTTUBxTTOzwqh5EunLoFqvaHv1kblg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyona/vzkn9rPV7Gqs/NWIhtys/WeomRFoJE1o6BCxOkMdj83dS
	NIzDjVkLy+Lj+Q1emSkgFlXw3xaigKfwFzcM+yo02OpxRdzw/PSVVNCnfek4KRzi3MzR7LQnMA7
	kmeNvMxnD
X-Gm-Gg: ATEYQzzxGT+DljuOr7agvLvp8YT45WMr7vKkrbYKBXiybGhNvvE/JlvMvPEDcZUHpsU
	yNYhGroO8/YFIC/5azsyP7//YPzbypHnnjfKQN8qmPH8wOgGc+pE1xSt4tKQwR0Phba0VDSWneS
	btFEkikpGZUHlVcfjprH5oXO/4+h2dO3vwCPHqFwOEmsDkNFEGjmfzgS5IEk+hQAHI4yrbvjB8c
	8qldOIw6soNBtRtV1+xpespJA57XVW+ztc1MnWtLWspvldswMm4ZOCxL1frqJv84n6OwiCAXOFa
	QsQKtCnh0sKyDPE8xA/4l7iJFUbqpwtQSajSa9QO0aA3wPUwQBPF9xSsO02O9qPoCvkigfeclMB
	CPMeq2QqxSxUiBdcJxGoatC6fZcCgbJMozWFYG+yhVLFbhFRwsFHGAzApOUNUgUR9TiVI1xZE5F
	H07iTDho/WZYQRk6AhrdZ1iE3f1X0Y9bpCnWx4x/QOHMGa9lGTATiYwnX/JlXTdw==
X-Received: by 2002:a17:902:ef02:b0:290:8ecf:e9f9 with SMTP id d9443c01a7336-2ae3b50a847mr325905ad.7.1772232974103;
        Fri, 27 Feb 2026 14:56:14 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a0107f5sm5815016b3a.45.2026.02.27.14.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:56:13 -0800 (PST)
Date: Fri, 27 Feb 2026 22:56:09 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: YiFei Zhu <zhuyifei@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller " <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: Fix rcu_tasks stall in threaded busypoll
Message-ID: <qle5zz5723mobukjvxnda6bdenfbvw2oaw7whgplz6cu5r3ac7@3urnzm3ni6qe>
References: <20260227221937.1060857-1-zhuyifei@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260227221937.1060857-1-zhuyifei@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261998-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D9E01BED15
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 10:19:37PM +0000, YiFei Zhu wrote:
>I was debugging a NIC driver when I noticed that when I enable
>threaded busypoll, bpftrace hangs when starting up. dmesg showed:
>
>  rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 10658 jiffies old.
>  rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 40793 jiffies old.
>  rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 131273 jiffies old.
>  rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 402058 jiffies old.
>  INFO: rcu_tasks detected stalls on tasks:
>  00000000769f52cd: .N nvcsw: 2/2 holdout: 1 idle_cpu: -1/64
>  task:napi/eth2-8265  state:R  running task     stack:0     pid:48300 tgid:48300 ppid:2      task_flags:0x208040 flags:0x00004000
>  Call Trace:
>   <TASK>
>   ? napi_threaded_poll_loop+0x27c/0x2c0
>   ? __pfx_napi_threaded_poll+0x10/0x10
>   ? napi_threaded_poll+0x26/0x80
>   ? kthread+0xfa/0x240
>   ? __pfx_kthread+0x10/0x10
>   ? ret_from_fork+0x31/0x50
>   ? __pfx_kthread+0x10/0x10
>   ? ret_from_fork_asm+0x1a/0x30
>   </TASK>
>
>The cause is that in threaded busypoll, the main loop is in
>napi_threaded_poll rather than napi_threaded_poll_loop, where the
>latter rarely iterates more than once within its loop. For
>rcu_softirq_qs_periodic inside napi_threaded_poll_loop to report its
>qs state, the last_qs must be 100ms behind, and this can't happen
>because napi_threaded_poll_loop rarely iterates in threaded busypoll,
>and each time napi_threaded_poll_loop is called last_qs is reset to
>latest jiffies.
>
>This patch changes so that in threaded busypoll, last_qs is saved
>in the outer napi_threaded_poll, and whether busy_poll_last_qs
>is NULL indicates whether napi_threaded_poll_loop is called for
>busypoll. This way last_qs would not reset to latest jiffies on
>each invocation of napi_threaded_poll_loop.
>
>Fixes: c18d4b190a46 ("net: Extend NAPI threaded polling to allow kthread based busy polling")
>Cc: stable@vger.kernel.org
>Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>---
> net/core/dev.c | 17 +++++++++++------
> 1 file changed, 11 insertions(+), 6 deletions(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index c1a9f7fdcffa9..4af4cf2d63a47 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -7794,11 +7794,12 @@ static int napi_thread_wait(struct napi_struct *napi)
> 	return -1;
> }
>
>-static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
>+static void napi_threaded_poll_loop(struct napi_struct *napi,
>+				    unsigned long *busy_poll_last_qs)
> {
>+	unsigned long last_qs = busy_poll_last_qs ? *busy_poll_last_qs : jiffies;
> 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> 	struct softnet_data *sd;
>-	unsigned long last_qs = jiffies;
>
> 	for (;;) {
> 		bool repoll = false;
>@@ -7827,12 +7828,12 @@ static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
> 		/* When busy poll is enabled, the old packets are not flushed in
> 		 * napi_complete_done. So flush them here.
> 		 */
>-		if (busy_poll)
>+		if (busy_poll_last_qs)
> 			gro_flush_normal(&napi->gro, HZ >= 1000);
> 		local_bh_enable();
>
> 		/* Call cond_resched here to avoid watchdog warnings. */
>-		if (repoll || busy_poll) {
>+		if (repoll || busy_poll_last_qs) {
> 			rcu_softirq_qs_periodic(last_qs);
> 			cond_resched();
> 		}
>@@ -7840,11 +7841,15 @@ static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
> 		if (!repoll)
> 			break;
> 	}
>+
>+	if (busy_poll_last_qs)
>+		*busy_poll_last_qs = last_qs;
> }
>
> static int napi_threaded_poll(void *data)
> {
> 	struct napi_struct *napi = data;
>+	unsigned long last_qs = jiffies;
> 	bool want_busy_poll;
> 	bool in_busy_poll;
> 	unsigned long val;
>@@ -7862,7 +7867,7 @@ static int napi_threaded_poll(void *data)
> 			assign_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state,
> 				   want_busy_poll);
>
>-		napi_threaded_poll_loop(napi, want_busy_poll);
>+		napi_threaded_poll_loop(napi, want_busy_poll ? &last_qs : NULL);
> 	}
>
> 	return 0;
>@@ -13175,7 +13180,7 @@ static void run_backlog_napi(unsigned int cpu)
> {
> 	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
>
>-	napi_threaded_poll_loop(&sd->backlog, false);
>+	napi_threaded_poll_loop(&sd->backlog, NULL);
> }
>
> static void backlog_napi_setup(unsigned int cpu)
>-- 
>2.53.0.473.g4a7958ca14-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

