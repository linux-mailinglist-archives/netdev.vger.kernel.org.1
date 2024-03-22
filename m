Return-Path: <netdev+bounces-81195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DCD88681A
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267C71C239C7
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64D15EA2;
	Fri, 22 Mar 2024 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gupk1DVT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B195179B8
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095461; cv=none; b=EiJXUwR6OzIceAwp8yStle9LTovKcWHBW07FIoP7SnC7DJpElAtEibygHZpyOxvAEV0LQ4D7WJlKT2hwArhcD36xM+rat14v4GmXoXGrHNKQ01daZ5DnIH7VRE4KG8ETkcYTQPtDw/g710L3llJyw/DaT3JIb0D/HtmjOT05Fok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095461; c=relaxed/simple;
	bh=ptwNatMYfgsUJVbSiAzbIihvZ+5JeJgga03ggyXu/ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFx/Go6+qh04Xi+VfTwZVirE7tE5M5FZmJNsJYBRCxirZ0mZpKLrqAsvAVdZQ6qAJv6ZuvNI+8jRuIYShG3mvSHK1cVG9yY0yKlTSJIZtpAO3gTMlpi0pta6Ec3a6xXh0yVYSi4L5skrEnkMr3xA+HYGsY6Qx2fyraTm9MhBQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gupk1DVT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so2577616a12.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711095457; x=1711700257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJKr+ni+ahD+882dbB5DofObvOFlphxCJqClqDHnQdY=;
        b=gupk1DVTQ5C21v8Et/EKQeRcmZKKmaR1zu1ImbiY+nXH9MiOBoj7kFQOHfC3hXk48s
         kL/7JOKq0hTqpbqJtZR+dijYNVNvUrHtBE3bpW57DWpENkUIC2hS/0M6pJFDBECC4bXk
         g6uXeXCaHLEI/pjijUBVOK9j/mzNBJiKKBfeGmJn1JR9rxoCPuc8dSz4gDsmH8haNaJq
         NxS+VMQsJtewuhalS2IBDooUrTey/vv7tSoWcDVDTA9iHlVeW+QXHsZ8xWXdtHTMTZ5d
         aMRuXhlKwV+5wxLM7kkgvK9+lmwxwAa18tvzFyMbG/diFqptvTvDMZXBucU+GY4/cFoB
         TdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095457; x=1711700257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJKr+ni+ahD+882dbB5DofObvOFlphxCJqClqDHnQdY=;
        b=grtRh31ZXHnz+PGeEHrpXzp7AiT251Nl66vJtr6FRSgsiPFF6geAMJeLqzjLxuyapU
         5EV9iJAJHXUZZC30Oc8856U6bXPwJLwpG1Mh0mp23wgYc5In+lhoiyIzkUjYX8vIzJ1x
         5SN6kQEveAe8BfvkJbcmbVatSdnQFsMCt44I8bAj3gEt19cuAmHiG8SzDxrHxnKSJpPF
         Ik1w6lORPsb16WycrYxJrWn9BWjfyPF8mGeS4duquj/kkgoiQP5eCrqviLIr1+99c5z2
         7huAqRTNweTSi5N+hpiopXAJ7+50LetVlv7E1x7Td+OeZL33PkwMDVKY1oii5Oxi4cwj
         MP7w==
X-Forwarded-Encrypted: i=1; AJvYcCX26Be6zD3RpOQzF/W6u7G/kFNHhmhAFRu5uiuztUSNXHKTPbJDd8wsVhzuZm0NkTwhdDpmN1T/P1z2AK1Gk9OU/tG/lMoi
X-Gm-Message-State: AOJu0YxwmIPBdOES18mFxBXO4jlqMG5i45bWl7gswmUwf3NfIOgjZC1S
	qiNEXLVv5Uu6Wwa9dDLFe/8dNcLbpAe8VoflO+IoGFBKHGvbEHZVfATR3mZfG3w+5QVU1dyJtsT
	o//k=
X-Google-Smtp-Source: AGHT+IETQ3xiDviQtZdArPfJnK5ddMoyddMhAGHC+OgVtJjfERs+egfMZbYssoVZwgrT8GbqbDBQeQ==
X-Received: by 2002:a17:906:308e:b0:a47:1bab:f1d6 with SMTP id 14-20020a170906308e00b00a471babf1d6mr1095275ejv.72.1711095457327;
        Fri, 22 Mar 2024 01:17:37 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s27-20020a1709060c1b00b00a473792da26sm17616ejf.19.2024.03.22.01.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:17:36 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:17:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jian Wen <wenjianhn@gmail.com>
Cc: jiri@mellanox.com, edumazet@google.com, davem@davemloft.net,
	Jian Wen <wenjian1@xiaomi.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: use kvzalloc() to allocate devlink
 instance resources
Message-ID: <Zf0-nW-NjjoF-_Mr@nanopsycho>
References: <20240322015814.425050-1-wenjian1@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322015814.425050-1-wenjian1@xiaomi.com>

Fri, Mar 22, 2024 at 02:58:14AM CET, wenjianhn@gmail.com wrote:
>During live migration of a virtual machine, the SR-IOV VF need to be
>re-registered. It may fail when the memory is badly fragmented.
>
>The related log is as follows.
>
>Mar  1 18:54:12  kernel: hv_netvsc 6045bdaa-c0d1-6045-bdaa-c0d16045bdaa eth0: VF slot 1 added
>...
>Mar  1 18:54:13  kernel: kworker/0:0: page allocation failure: order:7, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
>Mar  1 18:54:13  kernel: CPU: 0 PID: 24006 Comm: kworker/0:0 Tainted: G            E     5.4...x86_64 #1
>Mar  1 18:54:13  kernel: Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
>Mar  1 18:54:13  kernel: Workqueue: events work_for_cpu_fn
>Mar  1 18:54:13  kernel: Call Trace:
>Mar  1 18:54:13  kernel: dump_stack+0x8b/0xc8
>Mar  1 18:54:13  kernel: warn_alloc+0xff/0x170
>Mar  1 18:54:13  kernel: __alloc_pages_slowpath+0x92c/0xb2b
>Mar  1 18:54:13  kernel: ? get_page_from_freelist+0x1d4/0x1140
>Mar  1 18:54:13  kernel: __alloc_pages_nodemask+0x2f9/0x320
>Mar  1 18:54:13  kernel: alloc_pages_current+0x6a/0xb0
>Mar  1 18:54:13  kernel: kmalloc_order+0x1e/0x70
>Mar  1 18:54:13  kernel: kmalloc_order_trace+0x26/0xb0
>Mar  1 18:54:13  kernel: ? __switch_to_asm+0x34/0x70
>Mar  1 18:54:13  kernel: __kmalloc+0x276/0x280
>Mar  1 18:54:13  kernel: ? _raw_spin_unlock_irqrestore+0x1e/0x40
>Mar  1 18:54:13  kernel: devlink_alloc+0x29/0x110
>Mar  1 18:54:13  kernel: mlx5_devlink_alloc+0x1a/0x20 [mlx5_core]
>Mar  1 18:54:13  kernel: init_one+0x1d/0x650 [mlx5_core]
>Mar  1 18:54:13  kernel: local_pci_probe+0x46/0x90
>Mar  1 18:54:13  kernel: work_for_cpu_fn+0x1a/0x30
>Mar  1 18:54:13  kernel: process_one_work+0x16d/0x390
>Mar  1 18:54:13  kernel: worker_thread+0x1d3/0x3f0
>Mar  1 18:54:13  kernel: kthread+0x105/0x140
>Mar  1 18:54:13  kernel: ? max_active_store+0x80/0x80
>Mar  1 18:54:13  kernel: ? kthread_bind+0x20/0x20
>Mar  1 18:54:13  kernel: ret_from_fork+0x3a/0x50
>
>Signed-off-by: Jian Wen <wenjian1@xiaomi.com>

net-next is closed, resent next week once it opens.

pw-bot: defer


>---
> net/devlink/core.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/devlink/core.c b/net/devlink/core.c
>index 7f0b093208d7..ffbac42918d7 100644
>--- a/net/devlink/core.c
>+++ b/net/devlink/core.c
>@@ -314,7 +314,7 @@ static void devlink_release(struct work_struct *work)
> 	mutex_destroy(&devlink->lock);
> 	lockdep_unregister_key(&devlink->lock_key);
> 	put_device(devlink->dev);
>-	kfree(devlink);
>+	kvfree(devlink);
> }
> 
> void devlink_put(struct devlink *devlink)
>@@ -420,7 +420,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
> 	if (!devlink_reload_actions_valid(ops))
> 		return NULL;
> 
>-	devlink = kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
>+	devlink = kvzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
> 	if (!devlink)
> 		return NULL;
> 
>@@ -455,7 +455,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
> 	return devlink;
> 
> err_xa_alloc:
>-	kfree(devlink);
>+	kvfree(devlink);
> 	return NULL;
> }
> EXPORT_SYMBOL_GPL(devlink_alloc_ns);
>-- 
>2.34.1
>
>

