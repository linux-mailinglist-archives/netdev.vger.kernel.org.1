Return-Path: <netdev+bounces-103385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFB1907D22
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8052D1C232B3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655478614D;
	Thu, 13 Jun 2024 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AfRUoRPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A557C8D
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309203; cv=none; b=I8xaL/nyXS+EPYlpwDsgjLxXaRMQXdkMFzvjUHmbuCX5vwqHYP6cLozeK2ZpdeQp7fYADbvcWR6AEHR5uiAIZqyI4KTR4A33ihJ70mJW4XABvzAE/d1Na4sxfccPmvzHwsN8fN4RhVXtO1xdiQv+KWvn+8Xo3wEwmBO2n58cG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309203; c=relaxed/simple;
	bh=EmWsMlaDnrIpuHCLBLMPAiqiu63/n4OrW12lz7BVflg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYLGQLYPPLYAfnhl3Q2CKhxMV/iCjQDoCN1JzP1EpdswqIvQd2IKudgeilCBkSx6ysDvKdgG1EghvLOoIJJKBwTbtYXuPe36D6hBg51RKcE6T8gVAdU8Lg3/VFs0Av/JKZETbe15o8hYVdshudSQPzhVVOjkVasby0zXm7vnz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AfRUoRPU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6301aa3a89eso16846457b3.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1718309200; x=1718914000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jFY3bcNfl9Abf/Tm2c/uX2BZTaefC2CQgWR23XFnAY=;
        b=AfRUoRPUEYSz0yU50j4B+G60sHGH0oXc+TWdJjrG5l7PB32VcrcEZTKEfKyGZuNr6Z
         C1G4RvNzivjlZ15d+oGGfqloDjoILHe5VhRkoxB5rWa1wSu1Ytwq6dA+O0Z/beDlhhGh
         Efc9w9bhAyTViX+T16xctc+9jvYKNctJDOyMYqSyY5QP65+3xVYRlcLzGid0OQuYTZa4
         S08QrtGHmiDRdaxkStBQHcWs7nzm/dhFrOEMN8Ye2IGfsoiz3QLTr1sde0hcZH6eZC2R
         XsI39FFCuJgm3TTTIrcuXL22nX8JhlN3lBZFlYTlOrhS3Z+hKSkwz+VfeSNKnNvzbGFO
         Rhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309200; x=1718914000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jFY3bcNfl9Abf/Tm2c/uX2BZTaefC2CQgWR23XFnAY=;
        b=JQ7d8t9MR8op897+88gy1A97Taqe3plKjOV+q4BRYqyz09D6xFfpIkquxvQPTCJ0kI
         s/XAAG20sFF5LY609Qli66wt9Qyye/DFfW4xbY8BravySX98ZQt0fjwzh3/veAozDDjf
         keW2gTI124wS8LCz8BOfP130kBZybSLW/Bd8aN66HXGHN8QYSIxtddn61kSyIVC5NWg7
         TLV+gl7G6Jni4zpAcfK/BHEn4y0hIeKGKk0JJXLvg+4PyLQJ9+SdGku8HzwUWFo0XqI0
         NAT/kIHxzVOipmt/2Wu1jYu2TPCI8JYHZzAwwVp+hp98kDuJ6FuV2/HSxkM8KjaaBFEs
         uV3w==
X-Gm-Message-State: AOJu0Yx1dGCrpNjp5rzfJkw3hq4rS1QdzeXlefUXw3K60r6E14oHelr8
	QR2KYbGNhHnKFXUysvvekwZTjUMWP+arp3y/EUayNOEEJ7SoqhK1L7DtON49cIAAUZwdgWTu0Rq
	dH6xDlh7UhMu5SSdNGW31C64IJlNd5XJelm6j
X-Google-Smtp-Source: AGHT+IGA11SSJ4tbsEcrDRm81QbsusHZhIb/CJD+XwEDMgZvxZsIUynSBfDVmda2ObOB3Ttzl9Zht0Y+5X9yCkWmzY8=
X-Received: by 2002:a0d:e248:0:b0:61e:a62:d8fc with SMTP id
 00721157ae682-6322265fd29mr5005277b3.20.1718309198809; Thu, 13 Jun 2024
 13:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613071021.471432-1-druth@chromium.org>
In-Reply-To: <20240613071021.471432-1-druth@chromium.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 13 Jun 2024 16:06:27 -0400
Message-ID: <CAM0EoMkrTcMrsd=8249inrU4HaCP9nh4xva+LO1ayF_ONH=-DQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] net/sched: cls_api: fix possible infinite loop in tcf_idr_check_alloc()
To: David Ruth <druth@chromium.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	marcelo.leitner@gmail.com, vladbu@nvidia.com, 
	syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 3:10=E2=80=AFAM David Ruth <druth@chromium.org> wro=
te:
>
> syzbot found hanging tasks waiting on rtnl_lock [1]
>
> A reproducer is available in the syzbot bug.
>
> When a request to add multiple actions with the same index is sent, the
> second request will block forever on the first request. This holds
> rtnl_lock, and causes tasks to hang.
>
> Return -EAGAIN to prevent infinite looping, while keeping documented
> behavior.
>
> [1]
>
> INFO: task kworker/1:0:5088 blocked for more than 143 seconds.
> Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:0 state:D stack:23744 pid:5088 tgid:5088 ppid:2 flags:0x00=
004000
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
> Fixes: 0190c1d452a9 ("net: sched: atomically check-allocate action")
> Reported-by: syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db87c222546179f4513a7
> Signed-off-by: David Ruth <druth@chromium.org>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Small nit, should subject be:
net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()

cheers,
jamal

> ---
> V1 -> V2: Moved from net-next to net, identified the change this fixes
>
>  net/sched/act_api.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 9ee622fb1160..2520708b06a1 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -830,7 +830,6 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32=
 *index,
>         u32 max;
>
>         if (*index) {
> -again:
>                 rcu_read_lock();
>                 p =3D idr_find(&idrinfo->action_idr, *index);
>
> @@ -839,7 +838,7 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32=
 *index,
>                          * index but did not assign the pointer yet.
>                          */
>                         rcu_read_unlock();
> -                       goto again;
> +                       return -EAGAIN;
>                 }
>
>                 if (!p) {
> --
> 2.45.2.627.g7a2c4fd464-goog
>

