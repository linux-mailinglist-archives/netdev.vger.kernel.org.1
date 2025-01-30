Return-Path: <netdev+bounces-161628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454F0A22C64
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 12:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235BC1617BD
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870941AF0D0;
	Thu, 30 Jan 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xp1VKvlI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3EB2AE9A
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738235870; cv=none; b=E0QlDomSH6GXiin+2Yz8S8Q068UZUOS6xEfttkM40fX0umM3qWWbd2WM4A9mAJEUAcsiSA6X2oHYswp3s/K3GaIeGApT6T1DDNpJ7NqMw5mSCMTKh4RKCsITAM+f/ygVsuD5IbGSy/JrGTCFgLezw+PvEG+Bt1n7aSoi0NlMAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738235870; c=relaxed/simple;
	bh=H3wmo/9M5fImFPgcqyCp0t2NOohRjZR4qkc3ptNUY+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9y/1AniFvENoMlrv4BH6WyQxZnXr1mMviooP0pMhYhV8hrDqfm8IrXCT6UUG1pWl67Y14DgA2CODuWT2upHjrk1NsfCprM1D336+AEetTYrBBElrB0Ql8jBpM2xva3uKpCKOVchBCT43P3R8CSFcO32fqgq1PNgIFOnW31EvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=xp1VKvlI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215770613dbso7226955ad.2
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 03:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1738235867; x=1738840667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0jOJvLKXIu1bF1TsC07aYclfjzwUPtZt5UpdWQJtsA=;
        b=xp1VKvlIRSNtd0jiJ6vthkyaWdHM6YoFbujM25Lg3YZ4Grcx3gJmtPnYYGYPpXBQn9
         ZtlogQ5Ya534yC4WX4sxAx5qBGnCOu3YFZuA0mDvmFMH+UbugW1HUEtsqcC2UBbG0uR+
         xobZ2CXYLb1Ewy0bA7mI4F7LqVDHpHdLiF9jlRy76gjl+mbyIQHpQKhKK2oItAXE42jZ
         vmq22D9Q4O4uihyBgAW77sk7989fz8n/n25cIaXS/1vKLDg9wyuja1whiUjxLYMX5QGR
         eNuBJLdCvedHGKSNOIZ2lf2C1KOZl4pcelr3qeU7EndWBPmluWffydQ7wk52zKLbyN/L
         0/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738235867; x=1738840667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0jOJvLKXIu1bF1TsC07aYclfjzwUPtZt5UpdWQJtsA=;
        b=dbLS4lReoRkBVbCFg+Q3S2n99GBk5Q9ZHUlXgb577tZyeK25f3/xAgNthjtgcxVwPB
         LRDiLtUgWpL3FdQxFW/urj637h4nTAHBc7uZJgbSBXmgVY2CQYkiNjFcZVYaCPlJRXtc
         cykZEpzyXIdq870s1w+ZMn2GwFO4GX40jTPoPq6uwuk2nrMz77+pPDupdLFy7nyagMrm
         gTsCDAYPVBHJMIhN/UjXigTUEQo6jGM7nRAVCvwF/94kHSYJCQHDdBC6T0FXFU27AAV0
         poTRCNtnvNj2g6mUNYMfHia4XRNXhuYFio/k+ou26i1AYeQfmpM/scCAuHENxJIfYttk
         LNEQ==
X-Gm-Message-State: AOJu0YwjGh8rnARcefzOfIQkHG+79e0CtsK3lvBcCGeY/GQuAxyN0r2r
	vLNrSo1jDHFF6iK81qiCb2cREhWRowpmUl1mBzY2Z8eloO4On+Lde9Bf+B5V9jfwVggXd0pfXKf
	jv90nw4bzlLrisin17DkiFZdPf4oGyRij6pe5
X-Gm-Gg: ASbGncvsEsURjn6A/2nd2YlUJskX1R3PkJcd+eEmeEPYX1RUcP0JVd6Gy2siGQ7Iv57
	+jDYvwZvGJhmTz+QI2CXSeFoaEQc1MiecKuHu6vDHpwfgwJIWxdiWqjJfxIut2ZqrW8SiZSwa
X-Google-Smtp-Source: AGHT+IHdSE8eEQcjvG66bahNEkdM7QMaolzmVgGD7vRQirxRt852e8ldqJH2+H7hF4HwRoOSBvf6Vtarl5qtqckccPc=
X-Received: by 2002:a05:6a00:3c82:b0:725:a78c:6c31 with SMTP id
 d2e1a72fcca58-72fd0bc6a90mr11064432b3a.3.1738235867452; Thu, 30 Jan 2025
 03:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124060740.356527-1-xiyou.wangcong@gmail.com> <20250124060740.356527-2-xiyou.wangcong@gmail.com>
In-Reply-To: <20250124060740.356527-2-xiyou.wangcong@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 30 Jan 2025 06:17:36 -0500
X-Gm-Features: AWEUYZlqLkBDuiNEZuwXU_c_pL34t35Ij7p_PG6vSq5XriRJYozfQVEfmdkf-jk
Message-ID: <CAM0EoMk8dBGaZOUUqw4fbZUVK99Q3xO=uyuCKGE7eQjDELZdQQ@mail.gmail.com>
Subject: Re: [Patch net 1/4] pfifo_tail_enqueue: Drop new packet when
 sch->limit == 0
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, quanglex97@gmail.com, 
	mincho@theori.io, Cong Wang <cong.wang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 1:07=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> From: Quang Le <quanglex97@gmail.com>
>
> Expected behaviour:
> In case we reach scheduler's limit, pfifo_tail_enqueue() will drop a
> packet in scheduler's queue and decrease scheduler's qlen by one.
> Then, pfifo_tail_enqueue() enqueue new packet and increase
> scheduler's qlen by one. Finally, pfifo_tail_enqueue() return
> `NET_XMIT_CN` status code.
>
> Weird behaviour:
> In case we set `sch->limit =3D=3D 0` and trigger pfifo_tail_enqueue() on =
a
> scheduler that has no packet, the 'drop a packet' step will do nothing.
> This means the scheduler's qlen still has value equal 0.
> Then, we continue to enqueue new packet and increase scheduler's qlen by
> one. In summary, we can leverage pfifo_tail_enqueue() to increase qlen by
> one and return `NET_XMIT_CN` status code.
>
> The problem is:
> Let's say we have two qdiscs: Qdisc_A and Qdisc_B.
>  - Qdisc_A's type must have '->graft()' function to create parent/child r=
elationship.
>    Let's say Qdisc_A's type is `hfsc`. Enqueue packet to this qdisc will =
trigger `hfsc_enqueue`.
>  - Qdisc_B's type is pfifo_head_drop. Enqueue packet to this qdisc will t=
rigger `pfifo_tail_enqueue`.
>  - Qdisc_B is configured to have `sch->limit =3D=3D 0`.
>  - Qdisc_A is configured to route the enqueued's packet to Qdisc_B.
>
> Enqueue packet through Qdisc_A will lead to:
>  - hfsc_enqueue(Qdisc_A) -> pfifo_tail_enqueue(Qdisc_B)
>  - Qdisc_B->q.qlen +=3D 1
>  - pfifo_tail_enqueue() return `NET_XMIT_CN`
>  - hfsc_enqueue() check for `NET_XMIT_SUCCESS` and see `NET_XMIT_CN` =3D>=
 hfsc_enqueue() don't increase qlen of Qdisc_A.
>
> The whole process lead to a situation where Qdisc_A->q.qlen =3D=3D 0 and =
Qdisc_B->q.qlen =3D=3D 1.
> Replace 'hfsc' with other type (for example: 'drr') still lead to the sam=
e problem.
> This violate the design where parent's qlen should equal to the sum of it=
s childrens'qlen.
>
> Bug impact: This issue can be used for user->kernel privilege escalation =
when it is reachable.
>
> Reported-by: Quang Le <quanglex97@gmail.com>
> Signed-off-by: Quang Le <quanglex97@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Fixes: 57dbb2d83d100 ?

cheers,
jamal

> ---
>  net/sched/sch_fifo.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
> index b50b2c2cc09b..e6bfd39ff339 100644
> --- a/net/sched/sch_fifo.c
> +++ b/net/sched/sch_fifo.c
> @@ -40,6 +40,9 @@ static int pfifo_tail_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  {
>         unsigned int prev_backlog;
>
> +       if (unlikely(READ_ONCE(sch->limit) =3D=3D 0))
> +               return qdisc_drop(skb, sch, to_free);
> +
>         if (likely(sch->q.qlen < READ_ONCE(sch->limit)))
>                 return qdisc_enqueue_tail(skb, sch);
>
> --
> 2.34.1
>

