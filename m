Return-Path: <netdev+bounces-203219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDF1AF0CD9
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CF6165461
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169A01D63F0;
	Wed,  2 Jul 2025 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfuBMt8j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AC22F74F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442304; cv=none; b=p6qY+iyX+MYDTjweOdKM366u7veE95EWviVhneR3pkRv7m+V+7ICPDQoiB23yL886J4hUV6qmh1AEIw8O5GZ6RJV70xjKrrHB9AfyXiP3DPPPyyL8l1Z/L/2cDsfHm/fKxo5t3nyrfSV3/SiUejDIobi/yN3oR8EeYpfKmqjD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442304; c=relaxed/simple;
	bh=ByPy8wzUNr4NRU1yLQGd3jGvCGi2uppZcEMOwV0Ch/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXZzaYdwUMSi+/OHR2xG+m1uhUVL90N98pzvoENdSn7qBY/qJ1X/cSsJ5zKCfYltWFQVj/RfS8KH1NjcoEc1/9oGAe1XAhfAfY6fXevkpf+CCzlaCH0fT6mJJparC68ucKDcZ8H0LDkJ5rlkGnzrzUHzsYTE+j6ji1o4/2Irf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfuBMt8j; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-311a6236effso2928811a91.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 00:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751442302; x=1752047102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5XgOEJshhFldbUCuKZt/ovxejiO9lh26bpuZFV2+Qs=;
        b=wfuBMt8j9KQktSe+w/t2y4OzvEiRoRBlE7iBg1EE7GhC6aT6wtiIiWJ4xU4ChWfXXT
         n5nyFzKjcZUyVUhdqkzNQyp/ITlGC2Nj0RS7h1CAT2BVz/9/eLE7CmDkkPIX3ItRT5C6
         q2nv8+qUOlLo5mPMZcMpSY+7OuGDHNW8EmxLLE2t3/MeUKs2/AdIMkR+F82sjEYtxi/v
         aC0qBYkSKRkc7ALwkMUeK+iKYT9w1M884itGoq0mJdjLVjYm2heMo1wumKCnUKxzaLOH
         vnzugJnAR4uJOIeBXurUc7e+6scgZ1PCFkI0a8SGWG4Yjx4+fJLGEwkZXtcv1nqXv+Yn
         7gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751442302; x=1752047102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5XgOEJshhFldbUCuKZt/ovxejiO9lh26bpuZFV2+Qs=;
        b=uYI/bhirafVM6JEGSb6s7lOEIsPqyVHpexk7aY4L1uy2Goo4qcQkvgHeNASwgEKH6P
         7h8lFr6705BfImyvOS+E8V+UoSbAPStBlOWpAP/ru5Jmoz7uUjPGL1oFic1Z8I+U/3Yl
         hwnk3wZoMMAs3JIAIamnD3sO5H3c0D2NvpvOFz+9GuqRIK7RHMmQOTFnQvFgzuHk82ZV
         ++R5ihximMcDZcktqNkIP3JjHjOFW1JOLnFV1MCZasDcND0WRFO3Wr606ngJd+FLtouX
         YtjFbk9bhnaKbrpszvNHhXUz7/cpwdFpw4AgdjflIZG0bT3E3En+ZquJDeqhq1aAK2JT
         1FNw==
X-Forwarded-Encrypted: i=1; AJvYcCXKW4ar8neiwIeeQg21kBgCucmXflq6/T40nRXaLyB1ZsTWKi8F/8XYsMCGSzxzL6TTjLmFm8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsW41ItmmrvGHAk0daU4v8qeHDwF/SqAYi7lcI/CoCwLgnikHS
	HCSco0jGfL207EeSWAt3HgVLlffSbQqtY9jWCG7/nhYdkWbbKyDoAp71ohj/W3DhhJ0xDB0KBVH
	xwVhrdVXd3sjbU+dO0m0etqMqlHn0pC0go2BVx3W+
X-Gm-Gg: ASbGncvUCsUZIlYMnMgFLyTDwtvFfBz24+ZOGrk4DshgfAuHSJmIGfZuhhkHnBJOjZO
	DRqiHHMqzDXth0Phk5HAyWbb1vZKxWm7O/RzxH6Ue0DSUMA1IG25+TQB2xw6ItP9FIKzCda5HSs
	DrFO1WcuL86HCQGmI1Yg2YiutU/x6xOwu3wYIkUl/G0WPkF3xzpLRTxYy9EgXXgwU7YxIiTS/st
	8U=
X-Google-Smtp-Source: AGHT+IGp92hddEznExlfCsIEx93VHFzMo/XxFLtejSVbj7ZCo58EkTk7VGJtNv1nQnA/oLC4vGDfUMMPqv5BS1+7iqM=
X-Received: by 2002:a17:90b:2645:b0:312:26d9:d5b2 with SMTP id
 98e67ed59e1d1-31a909e5593mr3857568a91.0.1751442301655; Wed, 02 Jul 2025
 00:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701133006.812702-1-edumazet@google.com> <aGSa3bgijdi+KqcK@pop-os.localdomain>
 <CANn89iKA23zDtt3+3K46QrFx-3iUP-Ef4+n87xWdQJhTWA_zcA@mail.gmail.com>
In-Reply-To: <CANn89iKA23zDtt3+3K46QrFx-3iUP-Ef4+n87xWdQJhTWA_zcA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Jul 2025 00:44:50 -0700
X-Gm-Features: Ac12FXxnFhGPZL8Swzg4cMvUjhqQD9oTag5oi9vpwOg5b8CmeFexPk2dFFQSFQY
Message-ID: <CAAVpQUDfftGhVvsiHy999avT=Tz8Gyw-Dwvrd3=rPvU8GyzP2w@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: acp_api: no longer acquire RTNL in tc_action_net_exit()
To: Eric Dumazet <edumazet@google.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Vlad Buslov <vladbu@nvidia.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jul 1, 2025 at 7:35=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.co=
m> wrote:
> >
> > On Tue, Jul 01, 2025 at 01:30:06PM +0000, Eric Dumazet wrote:
> > > tc_action_net_exit() got an rtnl exclusion in commit
> > > a159d3c4b829 ("net_sched: acquire RTNL in tc_action_net_exit()")
> > >
> > > Since then, commit 16af6067392c ("net: sched: implement reference
> > > counted action release") made this RTNL exclusion obsolete.
> >
> > I am not sure removing RTNL is safe even we have action refcnt.
> >
> > For example, are you sure tcf_action_offload_del() is safe to call
> > without RTNL?
>
> My thinking was that at the time of these calls, devices were already
> gone from the dismantling netns,

I thought the same because tcf_register_action() uses
register_pernet_subsys(), and subsys_ops->exit() is always executed
after other device_ops including default_device_exit_batch() that should
wait for all dev to go away.


> but this might be wrong.
>
> We can conditionally acquire rtnl from tcf_idrinfo_destroy() when
> there is at least one offloaded action in the idr.
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 057e20cef3754f33357c4c1e30034f6b9b872d91..9e468e46346710c85c3a85b90=
5d27dfe3972916a
> 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -933,18 +933,25 @@ void tcf_idrinfo_destroy(const struct tc_action_ops=
 *ops,
>                          struct tcf_idrinfo *idrinfo)
>  {
>         struct idr *idr =3D &idrinfo->action_idr;
> +       bool mutex_taken =3D false;
>         struct tc_action *p;
> -       int ret;
>         unsigned long id =3D 1;
>         unsigned long tmp;
> +       int ret;
>
>         idr_for_each_entry_ul(idr, p, tmp, id) {
> +               if (tc_act_in_hw(p) && !mutex_taken) {
> +                       rtnl_lock();
> +                       mutex_taken =3D true;
> +               }
>                 ret =3D __tcf_idr_release(p, false, true);
>                 if (ret =3D=3D ACT_P_DELETED)
>                         module_put(ops->owner);
>                 else if (ret < 0)
>                         return;
>         }
> +       if (mutex_taken)
> +               rtnl_unlock();
>         idr_destroy(&idrinfo->action_idr);
>  }
>  EXPORT_SYMBOL(tcf_idrinfo_destroy);
>
>
> >
> > What are you trying to improve here?
>
> Yeah, some of us are spending months of work to improve the RTNL
> situation, and we do not copy/paste why on every single patch :)
>
> I will capture the following in V2, thanks !
>
> Most netns do not have actions, yet deleting them is adding a lot of
> pressure on RTNL, which is for us the most contended mutex in the
> kernel.
>
> We are moving to a per-netns 'rtnl', so tc_action_net_exit() will not
> be able to grab 'rtnl' a single time for a batch of netns.
>
>
> Before the patch:
>
> perf probe -a rtnl_lock  # Note: This does not capture all calls, some
> of them might be inlined in net/core/rtnetlink.c
>
> perf record -e probe:rtnl_lock -a /bin/bash -c 'unshare -n "/bin/true"; s=
leep 1'
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.305 MB perf.data (25 samples) ]
>
> After the patch:
>
> perf record -e probe:rtnl_lock -a /bin/bash -c 'unshare -n "/bin/true"; s=
leep 1'
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.304 MB perf.data (9 samples) ]

