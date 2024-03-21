Return-Path: <netdev+bounces-81057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38DE88597F
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8EE281C0D
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D6C83CCD;
	Thu, 21 Mar 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="syyMtsq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11079B8E
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026000; cv=none; b=O2hr5cqrul4jZ5rpwo8LCzZPt/Z7t7BZhH+m16v8ViE/5tH9Y1G23XAE1n1yE/Oa1sbSEuOqCBgFvhiVvFCTgOJ1tChey93PabvySscFh+gmIc5Mqo+rdHrER68O80i/moJl4NjS0e6kARr8ktZ7HUNYL6i9B3rKT3DqwaarvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026000; c=relaxed/simple;
	bh=OnQ62RV+5NDi75Yj+cOdjgwXpuRLhGyXsrwRN+Eer68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaTpeaYvL6Rn/EPykrAg/HfEctnXPVXc2BJDmN1Aag5/FuZfqDxPytNfR1uq1/NBtL7bKPxtz4dwow+eReQFfqrW8DHB8U8o1c9xiYxC66Q38oLqa6VxHk8UFD0UWOSV47gxpe2P4ZJy7TV2vEb5qcMznBIGMHZiRkatWvGl9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=syyMtsq4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-414700cffd6so7261045e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711025995; x=1711630795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Prm1mDX4jihuvd9iCU9hELJ6fswncHr+zRz3/2+O5h0=;
        b=syyMtsq4jgZhfqwOU0sKUxTX5OvtU6lwI09arxYeajmcCex9Rc37E0Owhd7D6g6KTU
         +OHm+6HBnaC0cdA4zMOyTD85JpYq8lDmlemXWgXsNF8JRAMj0q+u9SZcXXZ6eCjaVIWb
         ZT3hcJyBKlJkO3YxvWLSo2W41ZCpm6wpfThA90TbNN78I8uW8BRLbsLzIgu9zIf9qLwd
         a9zisiMzEfhfEvshvA99RN29mjIPcATnUPNZg+N7GsT/VwhXmt6FgmLdsVAXpJnSxcoq
         hYTfyEFVJDCGnlyiqB5xwdfG+VbiCLP9IwcribnqU2OX9ViJR5NAVgOEKn6qMbza/WRE
         h55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711025995; x=1711630795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Prm1mDX4jihuvd9iCU9hELJ6fswncHr+zRz3/2+O5h0=;
        b=KWA0u6L1RhMp7Vh/FatPIXil07Uz7a397w0L6WLuBKA7XAShdMvhdYgjpY2ojNlXQs
         81mvDag4h3d8POOHl/KMQGgHbtKV01SgPLoVUi7SeSH2NPYGUOWSWdaqFM/xdWid6Dio
         M3NB6GcmJb3tTpufZFugd1wTqIFzqsD2ic01G2Y3/Em4YvwUqbzjkjQmDCpk7XTQ3x94
         ZJoMjnj5acICvxundS7ro57wSoxKjOfX38h7Fta5m8+bz2PKZuA97gyiDcBKG/5km7Hr
         e1gAmUNgGxa2da7k6KlE/ODZRx3/hr2gG68afV85wNW8v3fpfdsCnlQkOIpNr+2m11tA
         pGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCr82hmvcicGv8hcL1l40lgLopv/SJlL3prIZjyf2PUSlADcmXCK33DALcRs+FjWutuXVE1y3hxOVLaCcEsnI35cSHQ5QE
X-Gm-Message-State: AOJu0YyHEyzHVDogGGtP2Hn21FjsSNQdTsuQIiiJbhnmXXVscmBsjmGv
	AFmRsiabsyNvgYZ8W665w/0duA1u/LflxNZ49t2gJ3s9iQDf0duI6sia5Wle0jM=
X-Google-Smtp-Source: AGHT+IFFa7fntLsI4XL94disyGqHRrdXBJJN5EVelO3T6Dt/GqVH5wpYO+N8SxifFWgNZEF+xQVzAg==
X-Received: by 2002:adf:a3cc:0:b0:33e:8aab:fde7 with SMTP id m12-20020adfa3cc000000b0033e8aabfde7mr3611263wrb.28.1711025995396;
        Thu, 21 Mar 2024 05:59:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id i18-20020adffc12000000b0033e786abf84sm17185305wrr.54.2024.03.21.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:59:54 -0700 (PDT)
Date: Thu, 21 Mar 2024 13:59:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jian Wen <wenjianhn@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net,
	Jian Wen <wenjian1@xiaomi.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] devlink: use kvzalloc() to allocate devlink instance
 resources
Message-ID: <ZfwvR81dq4WN0XOG@nanopsycho>
References: <20240321123611.380158-1-wenjian1@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321123611.380158-1-wenjian1@xiaomi.com>

Thu, Mar 21, 2024 at 01:36:11PM CET, wenjianhn@gmail.com wrote:
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

This is not fixing a bug introduced by specific commit, is it? Or is
this a regression? In that case, you need to add "Fixes" tag.
Idk, looks more like net-next material. The patch itself looks okay to
me.


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

