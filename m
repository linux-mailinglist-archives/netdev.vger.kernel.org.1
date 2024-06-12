Return-Path: <netdev+bounces-102985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9416905D9A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 23:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A76B212D0
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 21:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CB684FCC;
	Wed, 12 Jun 2024 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LH8RxYcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4A175A5
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227523; cv=none; b=vFtoSGij+i+0rq/u3+qm6ybKyb6rMHUDRJfKG7zzPc24KpM6bHuBf9z0xKArPEAU9Y8tSrk8a1MwDL/RmBZa+piLi3+zFxMsLUV73GXeAwqHCqEU7bChyDLT4BdGSaG42ZWw90EmPurqDnBYvX1sotuIpcQDWH59sfhaZ41Ghmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227523; c=relaxed/simple;
	bh=uTNrKWk5AOls6lIhVnWMAlLKv0PufahTggonTe3uEAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4qXCALdWBHmjkhW14o+02Cc7nPZcMGljQrM7m1z+xOIaYs+7MWRxAf4UfLf010yuD+18XKP4ZdH/v7ddCOSS8FvaVB3zFOBIVZuphlSGFvb64NmwUFnRbMS1yHJcvqMql94cRC7hjPJEcSx+I4ahQYcOxA4bbwHm5ioPhbpBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LH8RxYcz; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c9cc66c649so114562b6e.1
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1718227521; x=1718832321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMgTmyXyn8MyJ0mhxgsplquVgvktemRDIOw3IgKqvDc=;
        b=LH8RxYczNsgBW8sDBDROcr2q5OMC7L993Q7vU8zIOyXUPvC+0c1IN8/nD/KVC5LFIJ
         VmSfFupmHD0od4E8s5bDtoUt+yYAegefGbsb7s2Kx3EVrpOS8otBaEVgNhMKKjLLrBC/
         SRl8HgFJBhzl0heb0x8FwAThB1XORrbH7+gPiWKKRDEwP6N1cI0XUZgt87vWbQZAqwAo
         79OOjfGswUgGDfOSBGsgss+TLgyj6BSOWToGR1lz/P0hz5p8UIUY5MX3uGsmiW72OAga
         arfTPp2LAAOgf2866sQ/zjyGbf7cXM/Kq8chDSogD8rBe0GlFw7wuPZZBscX1J4qWiX5
         ELtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718227521; x=1718832321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMgTmyXyn8MyJ0mhxgsplquVgvktemRDIOw3IgKqvDc=;
        b=tb6yOdHFDmE2vL6MQZJwPdKj+AjASGA0POmIloDWLc5O+aS26kWw6EzeO46LmXrXjv
         7npr0deRK9CnOTz7JYnBgBnk87ahmHQ2D9JzaAUv2lTmDyMvIu+gWG1dk7FHp8dCklOz
         pNqJBgOYqVxlvZUE9gDOebRjDZEyVnVKkyM9eZHyUS6Xob8Yl44J2Sn++ygDChFzEVBb
         uM/+ModG7L0VVBoTDk+h/6bkxEDwhSo3v+QOJ/BY7oe+syEPzIleQMef6rgYO+rFuniN
         2icDSU0H7ft5tYXf9FDxqRL4NEJ6+CiZcYRm/iirdhO0bpusOY4ZXJ+/pTkdzFqcLmly
         wzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxkVuHX3uRDyQ+zzVS41C7NkkDPoqCbOHbHlDovD9gOBTFpzLd5NvbO377dJC+mUV8SythuHL4lvirQTJDdSkcKHxXgBkv
X-Gm-Message-State: AOJu0Yxknrm2WFPbSzgaXEc0BbQXDZ7wx5d6trgRBqhHkOD1yZVyHzdm
	rwYs5vm4VMY1SH4enO3i/0LPV9C6IV3U4USJi6DaFPGIvARKGcnKhSOLZx/O0w==
X-Google-Smtp-Source: AGHT+IGf1VrstXGCQAK6XhpeOow0Xz8e5Z+5qFdOCDa/lykkvwfM+PI0P5SeuDSTxmRl1C2INIox7w==
X-Received: by 2002:a05:6870:1699:b0:250:73d9:7739 with SMTP id 586e51a60fabf-25514f2b665mr3438792fac.45.1718227520622;
        Wed, 12 Jun 2024 14:25:20 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:47fb:59ec:4e75:a460? ([2804:14d:5c5e:44fb:47fb:59ec:4e75:a460])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e61930dc41sm7664828a12.11.2024.06.12.14.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 14:25:20 -0700 (PDT)
Message-ID: <5fdae342-05b5-481b-894d-3f296e8ea189@mojatatu.com>
Date: Wed, 12 Jun 2024 18:25:14 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next] net/sched: cls_api: fix possible infinite loop
 in tcf_idr_check_alloc()
To: David Ruth <druth@chromium.org>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
References: <20240612204610.4137697-1-druth@chromium.org>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20240612204610.4137697-1-druth@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/06/2024 17:46, David Ruth wrote:
> syzbot found hanging tasks waiting on rtnl_lock [1]
> 
> When a request to add multiple actions with the same index is sent, the
> second request will block forever on the first request. This results in an
> infinite loop that holds rtnl_lock, and causes tasks to hang.
> 
> Return -EAGAIN to prevent infinite looping, while keeping documented
> behavior.
> 
> [1]
> 
> INFO: task kworker/1:0:5088 blocked for more than 143 seconds.
> Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:0 state:D stack:23744 pid:5088 tgid:5088 ppid:2 flags:0x00004000
> Workqueue: events_power_efficient reg_check_chans_work
> Call Trace:
> <TASK>
> context_switch kernel/sched/core.c:5409 [inline]
> __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
> __schedule_loop kernel/sched/core.c:6823 [inline]
> schedule+0xe7/0x350 kernel/sched/core.c:6838
> schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6895
> __mutex_lock_common kernel/locking/mutex.c:684 [inline]
> __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
> wiphy_lock include/net/cfg80211.h:5953 [inline]
> reg_leave_invalid_chans net/wireless/reg.c:2466 [inline]
> reg_check_chans_work+0x10a/0x10e0 net/wireless/reg.c:2481
> 
> Reported-by: syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b87c222546179f4513a7
> Signed-off-by: David Ruth <druth@chromium.org>

Hi,

Thanks for fixing it.

Syzbot is reproducing in net, so the patch should target the net tree.

Also missing the following tag:
Fixes: 4b55e86736d5 ("net/sched: act_api: rely on rcu in 
tcf_idr_check_alloc")

> ---
>   net/sched/act_api.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 7458b3154426..2714c4ed928e 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -830,7 +830,6 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
>   	u32 max;
>   
>   	if (*index) {
> -again:
>   		rcu_read_lock();
>   		p = idr_find(&idrinfo->action_idr, *index);
>   
> @@ -839,7 +838,7 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
>   			 * index but did not assign the pointer yet.
>   			 */
>   			rcu_read_unlock();
> -			goto again;
> +			return -EAGAIN;
>   		}
>   
>   		if (!p) {


