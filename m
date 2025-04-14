Return-Path: <netdev+bounces-182094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1929A87C0F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B941188BE81
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBA1A83E8;
	Mon, 14 Apr 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDpu7pvd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F225DD0A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623603; cv=none; b=K+j3LVOJwJYb7Tqcc9i/ztgqmeSqCUBWRW6BZDcVbbUBGhGExzRnulo4cKHEX6eLSVRtxc261ybW/jN8QjmuVY59c5nsXHQmo4R1uvSO6nZDu7js8qhdo3O4Cn1akDX4rNbFsNHC8Z/AfoKpgXLKmYweVe1lMr0C1+u6R/+6hJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623603; c=relaxed/simple;
	bh=UMfBWltjn+H3qXvdamXbvVQE5gCj8EIURaEEJ/phrcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNXZkV/rN2XOMxP2F9e+g1g3EBeVyjmaN3k5vD9SmyLTAeIVSZTcs8/XZX1PQ83gVkWbDG2jM/XP7Bc6iIkkxOYMAT1PZdSzHuw6IQ8EbL5jAddVaeiEffUHTaLSDy02Q/RGxbJM061Y23Bb6pQJe8v+nEnh/jTPUvgLg6grwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDpu7pvd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736a7e126c7so3420958b3a.3
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 02:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744623601; x=1745228401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l1MkEC0z+xbic1UiZTC7jZcA/ZklHXMVIFlXtYWxaS4=;
        b=EDpu7pvdIDFPsf7slCCff8Q4qvk543DqjFYwSbXcKOyvgeNe7OzdAvBIKJGSdg+oke
         PSkElCdQMeAoANIcrqjALKyaG1Hp0fsHlgaEaPEfKS6RJ8tMQsJYJskfxz3DPxML42bO
         Ph3i7K57jphIJ5XZtrorBoO4zAE76Zfph3EV/nh1wMB1XNAfxQT23HxMUvuuriL7hBHK
         D1Nw5pw2NjwtX0v/BrYm2chCBGCek0fBxhfN+pRS6RHGz3WVEUc+FxarNQFO6HKfu6RL
         KOazxAuekttREsjCR6JiBk3R+eTcRXaPcF6EXXWMo9ZwDPDmuZqjrkRTC3DVUrYeT1Dm
         JSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744623601; x=1745228401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1MkEC0z+xbic1UiZTC7jZcA/ZklHXMVIFlXtYWxaS4=;
        b=d2cg7GmbWP/v/pfRv6wpVkGPfc2ALlPVnNEEC84rtk/nX1lfoN07uPwKjMm7uOkTu5
         S1E3aLRlBKLoQ47ibiSKIsCaZndb8QhJevQPwBKMhxkvuyEVo1Qt06lQIXhPiYPfT5sh
         qlenIUq2S6/YZy0vCBGl9ja1bPn4kv1gvK+Sos5RwtCV+4buvFHXTvynxg08gCQjqF0K
         PZwUoduAPrScbmpy4r75BDZmRLTYXHVG0cPsio6yZDnd6KkjhBduL8BKIRMizc3bkCvc
         txIdDtZ/SrNfQToca3CIbc04CvmspNtioZzmGJTZ7XFgyqPLi/RCuwGKGWy/Hnc2ZWQd
         jmPw==
X-Gm-Message-State: AOJu0YzKBtX/LCnOZMgmh5SB5GTp2bRLOm/7wbzvCwh3dfJGrkw6I6Xy
	eYnJTnBpWypRLrvDs634oEykyYtliOmUXtbKFJVE6qDBkXAuHjgtnX8RTz7J6l4NpseG/NYdSWC
	nNeXu0jFuDDQwuZ8eYPlxkibLpL4=
X-Gm-Gg: ASbGnct5XKYVAWzPVV6unPCms+WaRzqfsWUo7TEb4NE74dWXIQ0gsDJBvQV6oG0/1xZ
	Wu+5oJ0NEtMQpy1BmSTy5YyXYsfvI6GXiH8uVMzG5VzqWcjQkJvoUoYJnofqMakQrrwWF5Se4el
	AqwFIvUVdeIoov4q4kSJIgLTrG9JmsTsx1somI95BolsqLte7O
X-Google-Smtp-Source: AGHT+IEyFW8Emk0lBn06KY7RdFx4BKTF5Ez/RA0FwgQuriAfB5NB2Bc6pA+IOTmVIeYBFdnoJh8YSvaF+B7Kk4s3ni4=
X-Received: by 2002:a05:6a00:b89:b0:736:34a2:8a20 with SMTP id
 d2e1a72fcca58-73bd12c9e39mr15567894b3a.21.1744623600745; Mon, 14 Apr 2025
 02:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414010912.816413-1-xiyou.wangcong@gmail.com> <20250414010912.816413-2-xiyou.wangcong@gmail.com>
In-Reply-To: <20250414010912.816413-2-xiyou.wangcong@gmail.com>
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Mon, 14 Apr 2025 11:39:49 +0200
X-Gm-Features: ATxdqUFdME70f-wl6WueLSXr2RQ0r9NTAtvZnLHVmHJkNBedU1oPzDiaFU8DKh0
Message-ID: <CALYGNiOV2sJY5gQwMX+U6ot9fFURHLWW+F87pBtH3T-RLDL+5Q@mail.gmail.com>
Subject: Re: [Patch net 1/2] net_sched: hfsc: Fix a UAF vulnerability in class handling
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	gerrard.tai@starlabs.sg
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Apr 2025 at 03:09, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> This patch fixes a Use-After-Free vulnerability in the HFSC qdisc class
> handling. The issue occurs due to a time-of-check/time-of-use condition
> in hfsc_change_class() when working with certain child qdiscs like netem
> or codel.
>
> The vulnerability works as follows:
> 1. hfsc_change_class() checks if a class has packets (q.qlen != 0)
> 2. It then calls qdisc_peek_len(), which for certain qdiscs (e.g.,
>    codel, netem) might drop packets and empty the queue
> 3. The code continues assuming the queue is still non-empty, adding
>    the class to vttree
> 4. This breaks HFSC scheduler assumptions that only non-empty classes
>    are in vttree
> 5. Later, when the class is destroyed, this can lead to a Use-After-Free
>
> The fix adds a second queue length check after qdisc_peek_len() to verify
> the queue wasn't emptied.
>
> Fixes: 21f4d5cc25ec ("net_sched/hfsc: fix curve activation in hfsc_change_class()")
> Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  net/sched/sch_hfsc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index ce5045eea065..b368ac0595d5 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -961,6 +961,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
>
>         if (cl != NULL) {
>                 int old_flags;
> +               int len = 0;
>
>                 if (parentid) {
>                         if (cl->cl_parent &&
> @@ -991,9 +992,13 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
>                 if (usc != NULL)
>                         hfsc_change_usc(cl, usc, cur_time);
>
> +               if (cl->qdisc->q.qlen != 0)
> +                       len = qdisc_peek_len(cl->qdisc);
> +               /* Check queue length again since some qdisc implementations
> +                * (e.g., netem/codel) might empty the queue during the peek
> +                * operation.
> +                */
>                 if (cl->qdisc->q.qlen != 0) {
> -                       int len = qdisc_peek_len(cl->qdisc);
> -

I don't see any functional changes in the code.

>                         if (cl->cl_flags & HFSC_RSC) {
>                                 if (old_flags & HFSC_RSC)
>                                         update_ed(cl, len);
> --
> 2.34.1
>

