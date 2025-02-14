Return-Path: <netdev+bounces-166602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08EBA368EF
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39D63B2CF0
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FE21FCCE5;
	Fri, 14 Feb 2025 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRYJ9Z5U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5E1A83F2
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574894; cv=none; b=cynG3IkIfmTO71/Qi9BFKL/hNuRc2E9v10B+/yE49dQ2H4xxc1LAi+fdPUMA3f5VjthattyfhMqTHKjGAsGvUta1bQ1I+GQz8RTGN8FU9Zk9E0zu+3o6goj9247agAoLubbcnbsY6h453M8QkJ5T2LFscqhyBmH4F6q5MwTw75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574894; c=relaxed/simple;
	bh=2BfXSQtd4Eun6gFm8oWjAvDAj7pumA5WVvsN6iOp/6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjNClPD3lbJkv+yiWWwWAczoNd9M8RWPCb3fCF0/573etY4OV5sIyK9qsm9mn0S0Izxr+Cgtp6UMyakrTLJZ1PFjEg3bwGB+sx1jWfiMaR3ODbgPm8Dp9IRZDOXlP7akqLsgnfcxvAYIkKiahe3P7hbOthrUb5j18dxiZcSNm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRYJ9Z5U; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-855370e0de6so59761539f.3
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574892; x=1740179692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtOJ9LPima7r43wL22QYAj2INdZ/xjZ5OPT4uZHWc7k=;
        b=YRYJ9Z5UnVmf/zaObbt/Zi7McV5xNTN/OVm+sRulh9Oi2+fKd00Vm8OepYz48e9566
         JWxeX0DmvlLKbHRExWai51bRiDblFvjdvHv2iyuqMiHok++tFqPLcaNXrKNFcu5xTN3Z
         yybThDuiohemHPW/FqVqT9XKBGNeXRFWpRnrt/y2bvhXyUd0nsGkHaMS4eOkyw9ly2AU
         AE1GoM2Oi/dkGpeTCgmmSveMrMFggHQsC9/O6g60nAiu9ONiRybHVan462bhkUX7J/+2
         vDZx4h3BW9Qyav6jhpY+sTBr0Sw7ghx+gh7IhHfsGSlbwjdFgxidkmOpnaQ48ip4I6g0
         XRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574892; x=1740179692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtOJ9LPima7r43wL22QYAj2INdZ/xjZ5OPT4uZHWc7k=;
        b=tkSdV5bAoCd3A9rNP40p0tgmA/BDDXeYLWbgv9q04eTtfbBg2cKwEFw5Nq1EnQIQSW
         6nBWXUMN1ryMd7Jkhc8oalRWlgR6mL2oo5YsTH0ePF2awvC5yZL6szvY6qE04j2wpZCJ
         6nzyr5+MWFyrp1CTJYsF3FZLjanwvRP//opuejo+TryTW+dxyRX1Z6mhmherRwfR4gpd
         aWTMMw13AWlffo/ZfJBhhci4fIwzecRSM4X0jnb52xt+Fn0k4n2PGa7K2JHm2Z1baTTw
         hgofuiedbiVvPbqx425JT/9XXTOBnHuD8e6DWxQVj77IF6bRniNW1NfyS0fAfxsPRP3x
         izqg==
X-Forwarded-Encrypted: i=1; AJvYcCUDZdzvS02SWJLFNZozkmd/0T55Cmz4giWk6IVt1SKZ9xdnxxgFcj2h8GhlGYFbohC5wFRrliE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2xU8H4NfiTre1KVl50zPuFjpLTQJrsNh3jaoQ//kULtpenMd
	0Fd9FWp6HC6x8rzyqV+pqjYg7zfuQ0R/sJEdAo7bBTCtAKunwvK3SI48sBFXw7Th++G0yOfeisM
	v6d4Xpu90ScgAjZ5ctEqIy5htyuM=
X-Gm-Gg: ASbGncuFsi8lPasgW0mZc2GlcNqfbh5uiRg0+Jf05xLA23vmoQCWLfKkJRfWJtCqnUi
	dcs+Qrq2hV0RbOXvJZsKW0+stcp6rku12GUOmCzqVx92dljs29DmotCM7GyfNqmbfQidisxu0
X-Google-Smtp-Source: AGHT+IHp99sLA0gk8PCDebatFpUw9/qo/q2gZVMf7CkzVjw2xIW4HViGjWi924zOYOVMH9ardZfHGbWf49Y4AK6M160=
X-Received: by 2002:a05:6e02:3487:b0:3cf:b365:dcf0 with SMTP id
 e9e14a558f8ab-3d280970b44mr9538145ab.19.1739574892262; Fri, 14 Feb 2025
 15:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214064250.85987-1-kerneljasonxing@gmail.com> <CAHS8izOcLnt3SXzfbSA_vqno0R1SaBbXq-U8_LtRv64Bj7tUSQ@mail.gmail.com>
In-Reply-To: <CAHS8izOcLnt3SXzfbSA_vqno0R1SaBbXq-U8_LtRv64Bj7tUSQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 15 Feb 2025 07:14:15 +0800
X-Gm-Features: AWEUYZminbneqB-LDGegsev3o8w5xyPWcWkk2VbEMqdQN-MspqjP9AL26lCb7Ns
Message-ID: <CAL+tcoAn3Je1P-c5=tAB9DNPQyYPEknk98WOZpC0jaPMuDqgnA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] page_pool: avoid infinite loop to schedule
 delayed worker
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 4:27=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Thu, Feb 13, 2025 at 10:43=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > We noticed the kworker in page_pool_release_retry() was waken
> > up repeatedly and infinitely in production because of the
> > buggy driver causing the inflight less than 0 and warning
> > us in page_pool_inflight()[1].
> >
> > Since the inflight value goes negative, it means we should
> > not expect the whole page_pool to get back to work normally.
> >
> > This patch mitigates the adverse effect by not rescheduling
> > the kworker when detecting the inflight negative in
> > page_pool_release_retry().
> >
> > [1]
> > [Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
> > [Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
> > ...
> > [Mon Feb 10 20:36:11 2025] Call Trace:
> > [Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
> > [Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
> > [Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
> > [Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
> > [Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
> > [Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
> > [Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
> > [Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
> > Note: before this patch, the above calltrace would flood the
> > dmesg due to repeated reschedule of release_dw kworker.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Thanks Jason,
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks for the review.

>
> When you find the root cause of the driver bug, if you can think of
> ways to catch it sooner in the page_pool or prevent drivers from
> triggering it, please do consider sending improvements upstream.
> Thanks!

Sure, it's exactly what I want to do :)

Thanks,
Jason

>
> --
> Thanks,
> Mina

