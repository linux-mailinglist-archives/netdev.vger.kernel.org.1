Return-Path: <netdev+bounces-119224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D961954D4D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC5EB213A0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27CB1BCA16;
	Fri, 16 Aug 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hWct/svc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A86127E3A
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820680; cv=none; b=qvYLrdIHVpPo0noFbWDsx55zwLJNfpmRLXPiMLXtRdM6sGBSDbHea3dCw7XFT5v8ElRB1Ke+vkKUgXJ49CqSQE+FlDzVbGgp5dtMyR1yIL9t4iPOnKl8LKYuTj0TdM31PHP4FpXQ+fH3xi0NIX2vnheJ7YoU6BWVBIy9FgpZ0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820680; c=relaxed/simple;
	bh=s3USxx1qgqL7lxLH1uWT0FkSk5kzDvMsaDTfgpb6fys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ul56L2vLP/uOUqlkKx4EqSA0Gkm3cAyaGMm+phTL7Jt985qf46zUGSfTcynE5KR3e8C40l35IdLexFuMneUGPnb9oshcQRZdLclLBpVCGGdJwHRNMokTsUo8GK9Pm8K3k9ZhVmQZF39izXkX7KlQ76vxMVbQpMhfAIINXbk/2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hWct/svc; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-65fe1239f12so20648727b3.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1723820678; x=1724425478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vHAIRH2kiCPOLhpwy1w91JMGd3u0z2V4nztIPw0osA=;
        b=hWct/svcTLmMOJxarnvFQJtxG0gIU82gSPYRmGhqKugbCGLotC17y06xETvqkE6rpu
         qDt2W0VWmvGQ26ZQGby4nSHEcB3+8rHEdIhD6teFtcnrO+OH7vzxjKMmVhsxx/n8FL2C
         xavNKQjd5iQupqecjDGR6GPMRcIrGpeOGjgSwWGsMbqDcIkhu/YMHzZgCrwmG+EM8zlV
         lDcpTMPomQxdu8eP73C8y30R9l9ohAqBNti3iNZD9fN/QflofjF6f4NOmdImuWBI8l+M
         iGoQyB+zM8c+EsSrgiqALFnN8Box4n2p2ZIcGTMjqu87ZtF/BVGeDu0LtCqJYzNNfw1i
         rzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723820678; x=1724425478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vHAIRH2kiCPOLhpwy1w91JMGd3u0z2V4nztIPw0osA=;
        b=jUD5erS5CDz6Sfbr+tY0qBwB6TtxIFIpAG/kOMXuzMOPkDRwXeyy+G/LAvxssvT0c8
         Pr/8nTqjlc9GMozwqDGEf4R5kTeUY9Q0j6F1DqoewlvR/JrDYK2d4lkH2HDu8l+qwU1p
         y58sOKWj0xjG+sfES2X60gwUa8bdl3lnLAYPEIRK3LeP6V1GwngC4boNNtsGT4IzgRkf
         7fGa9p7XVtzHepSBleCs3bbs1NPq9B3baxmZ4CFThuS9KM7HZO9vhB3cJb5SkZ9ksUHD
         vKu8qjHKW93gbnOZ3szyZ6IMjGu2VITeOgeq/6OlgPj7RiKSruxO3Nri3l7kF+Bi/mFc
         bm0g==
X-Gm-Message-State: AOJu0Yw33T5qV58NKKdqsYtzaNxmITPDoyVNDYmb3LzoDcMbMEA1ckQF
	JiHZ+1W32D9AqKZM7VoBPT6nfYSpLEfXO2qxCOOhAKyte4UaF6fA61T80nOGRj24V+XvfK194Lm
	D0RHSYyMIR1JRKgoJMr3O/NhtuCT4hnxOzpIh
X-Google-Smtp-Source: AGHT+IGTnolWWBI+Wlg/qD251skyW7DUskZdIr4vvEEkBsEF8g5v2KaqEF5u01SGQNqsgyz1JsbmtuUoQGwxu//TTvY=
X-Received: by 2002:a05:690c:2f0b:b0:61b:3364:d193 with SMTP id
 00721157ae682-6b1bb570dd9mr29393947b3.40.1723820677610; Fri, 16 Aug 2024
 08:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816015355.688153-1-alex000young@gmail.com> <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
In-Reply-To: <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Aug 2024 11:04:25 -0400
Message-ID: <CAM0EoM=qvBxXS_1eheyhCKbNMRbK_qTTFMa1fFBFQp_hRbzpQQ@mail.gmail.com>
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
To: yangzhuorao <alex000young@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	security@kernel.org, xkaneiki@gmail.com, hackerzheng666@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:06=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Aug 15, 2024 at 9:54=E2=80=AFPM yangzhuorao <alex000young@gmail.c=
om> wrote:
> >
> > There is a uaf bug in net/sched/act_api.c.
> > When Thread1 call [1] tcf_action_init_1 to alloc act which saves
> > in actions array. If allocation failed, it will go to err path.
> > Meanwhile thread2 call tcf_del_walker to delete action in idr.
> > So thread 1 in err path [3] tcf_action_destroy will cause
> > use-after-free read bug.
> >
> > Thread1                            Thread2
> >  tcf_action_init
> >   for(i;i<TCA_ACT_MAX_PRIO;i++)
> >    act=3Dtcf_action_init_1 //[1]
> >    if(IS_ERR(act))
> >     goto err
> >    actions[i] =3D act
> >                                    tcf_del_walker
> >                                     idr_for_each_entry_ul(idr,p,id)
> >                                      __tcf_idr_release(p,false,true)
> >                                       free_tcf(p) //[2]
> >   err:
> >    tcf_action_destroy
> >     a=3Dactions[i]
> >     ops =3D a->ops //[3]
> >
> > We add lock and unlock in tcf_action_init and tcf_del_walker function
> > to aviod race condition.
> >

Hi Alex,

Thanks for your valiant effort, unfortunately there's nothing to fix
here for the current kernels.
For your edification:

This may have been an issue on the 4.x kernels you ran but i dont see
a valid codepath that would create the kernel parallelism scenario you
mentioned above (currently or ever actually). Kernel entry is
syncronized from user space via the rtnetlink lock - meaning you cant
have two control plane threads (as you show in your nice diagram above
in your commit) entering from user space in parallel to trigger the
bug.

I believe the reason it happens in 4.x is there is likely a bug(hand
waving here) where within a short window upon a) creating a batch of
actions of the same kind b) followed by partial updates of said action
you then c) flush that action kind. Theory is the flush will trigger
the bug. IOW, it is not parallel but rather a single entry. I didnt
have time to look but whatever this bug is was most certainly fixed at
some point - perhaps nobody bothered to backport. If this fix is so
important to you please dig into newer kernels and backport.

There are other technical issues with your solution but I hope the above he=
lps.
The repro doesnt cause any issues in newer kernels - but please verify
for yourself as well.

So from me, I am afraid, this is a nack

cheers,
jamal

