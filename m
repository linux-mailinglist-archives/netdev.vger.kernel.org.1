Return-Path: <netdev+bounces-202280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 961E6AED02A
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE2F1892CEB
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 19:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F102253AE;
	Sun, 29 Jun 2025 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUzLxHBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD116E863
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751226201; cv=none; b=Eo2Yikd5cqsP6OKe3Tvnekgb/D4YAzmCuAVQ/w3y7LQI4FbFT1u6nCiFJawjRAOkJESzCZEy6nXxGMcSNr08m4d/eh8qI6+TWCNR7AlsHEym2KU4PcJRcHlSFHh4wFzuTPVCiYVT4K81BxdatyJ2EXsXCu1q4ftiArWY+EJKXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751226201; c=relaxed/simple;
	bh=TIy+P/3YS6u22xOkoVLpO4ehcRXV+KJmVjZ8BPNpx6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1flZVDyRsfC88MWLuBBqkBQ005QtuuHYxGT2JIHQNBoucU/jJsozqC1kfZun18JBkp3ph8OVlY6HE5WxKTI4sCO1V8UUkQnE81RHJWtLlJZgKR6e2rJhv6gE+uCm+84SPfBaUaRPYTo21T40vYvJoNzOD/vk3yfQqD+LsS4zQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUzLxHBS; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5315972826dso2403511e0c.1
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751226198; x=1751830998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00gfp8O9oE4quHfT3JpHFNXmQu+7dEOFbgWYkEVqZmM=;
        b=dUzLxHBS3+5V/C9M7Z0CAASVwZwX9J6pxZjDc8IQ6GIxPmAjrB8N2axjR5sq7PtRZP
         c5w4l47WPZ6DAutY4ptSpKLL/0B5vt89u9h66sZ6g66O0JWmPNH9MMgcdPEuPXt3O4W1
         91gOXVbxY5dG+vC9WV3Kk+RFbi626J0KD31tNH9Kio7BiQjs0ehH+CEnzS3plQxASs2u
         KWVHZR7KyFT6VhvwhaWB5uod7QLfugVWZkXLiS3keyxzyVCcyxxhkEJWHm2NDFvNm/tn
         NghXFGXUPiLE1mY71swsRzSELUW2vchmAKXTEZRoftH39lLEU8fiFAzQvtfDiX/RrvsY
         suig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751226198; x=1751830998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00gfp8O9oE4quHfT3JpHFNXmQu+7dEOFbgWYkEVqZmM=;
        b=bVPk/QkPlLRqsssH4LdFLVUcmhnsvGtHqV9UiK57Wwe/rLuT+8vvLuhRHRGtPHRI0k
         /bUTFU34/y/8GKQe48kr9xaz9tOmGizTH9yfmEGez+/2kjHjNJRn0hsBSm5EtWTBggjR
         d6w4lBBfE1MkoaslAXFPNdRBLAZEt1Yx8s3AVRXvEm4S/flcWLVRo0ssUN+ChCuOEwkN
         AIwhrcnFqm8cClalitRqt9QMxX4AC3KAeEyi3mebTcAVpt/m457QtPneLhB3W0yxq0XL
         kp3YFObYaAichudULtENAibLtMBsQku2bVR8J+yQrrFaTKHL3y52Sr0bsYz1MNYkBPO0
         slVA==
X-Forwarded-Encrypted: i=1; AJvYcCXUKRE0zdCiivWHLYgxuaKUdhyu4p1wxWXUmyYwBapQnjKGrGrTmJkDMkIR5VMPsba5UJlABNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfvctIOatBBCVS995pSoWqJfJmI4higM325vam8LtiiC6zWn1
	apOjkvfv9xyhckCUgr6vUtZ7vRMubZ6ntw9ZvSxzNlwvCwLIbfG6DfM20GIe0+j5vv2vsFp8QJH
	zgNOHuk9SYO9X9NLSOkb8ofIx/ddwNl4+mHRs
X-Gm-Gg: ASbGncsbpK7JtDfXYbvA5oOZN6fe2q+DDuVwYAkIwjI2tcilrr9kNxnA5VVV2E4ynmu
	Sbnt9cZIeZMWYm6zw6S0uojYJATV9sAEl0zia1yFMSQxsQqUTv5qctOWUXi3WjireZTR7OlbjYt
	z6p7075CdeKJ5glEQY+7U9P0q3Ua3IdUBCJFp7R0Z65FeY
X-Google-Smtp-Source: AGHT+IEkk+HbFQqFHiqm9WiJTg3VL03mg+fYp8LGh6fGsZwFcCpYzzeiQc1CohHr/irlht/pjSv6SLIX8ZifcilBRjU=
X-Received: by 2002:a05:6122:7cb:b0:527:67d9:100d with SMTP id
 71dfb90a1353d-5330c667622mr6561837e0c.4.1751226197634; Sun, 29 Jun 2025
 12:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627042352.921-1-markovicbudimir@gmail.com>
In-Reply-To: <20250627042352.921-1-markovicbudimir@gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sun, 29 Jun 2025 12:43:06 -0700
X-Gm-Features: Ac12FXyoD72WYHCXqPXOxuMzIWzgu-ptP5EpvmloDLAa3CxBqsDzJZwYGlalfKY
Message-ID: <CAM_iQpVm66ErGcm+WriMSoudh8-XYt+GiEH48b0un3G9vpA=oA@mail.gmail.com>
Subject: Re: Use-after-free in hfsc_enqueue()
To: Budimir Markovic <markovicbudimir@gmail.com>
Cc: security@kernel.org, jhs@mojatatu.com, Mingi Cho <mincho@theori.io>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Budimir,

On Thu, Jun 26, 2025 at 9:23=E2=80=AFPM Budimir Markovic
<markovicbudimir@gmail.com> wrote:
>
> The use-after-free referenced in commit 3f981138109f ("sch_hfsc: Fix qlen
> accounting bug when using peek in hfsc_enqueue()") is still possible.  Th=
at
> commit ensured that qlen_notify is called on sch's parent class during pe=
ek(),
> but that class has not yet been added to its active list at this point. I=
t is
> only added after hfsc_enqueue() returns, and since no packets are enqueue=
d it
> will never be removed. The same applies to any classes further up the
> hierarchy.
>
> These commands trigger the bug causing a use-after-free and often a kerne=
l
> crash:
>
> ip link set dev lo up
> tc qdisc add dev lo root handle 1: drr
> tc filter add dev lo parent 1: basic classid 1:1
> tc class add dev lo parent 1: classid 1:1 drr
> tc qdisc add dev lo parent 1:1 handle 2: hfsc def 1
> tc class add dev lo parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0
> tc qdisc add dev lo parent 2:1 handle 3: netem
> tc qdisc add dev lo parent 3:1 handle 4: blackhole
> ping -c1 -W0.01 localhost
> tc class del dev lo classid 1:1
> tc filter add dev lo parent 1: basic classid 1:1
> ping -c1 -W0.01 localhost
>
> It can be fixed with the following change:
>
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index 5a7745170..8e25fae48 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -1589,8 +1589,13 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sc=
h, struct sk_buff **to_free)
>                  * head drop before the first dequeue operation has no ch=
ance
>                  * to invalidate the deadline.
>                  */
> -               if (cl->cl_flags & HFSC_RSC)
> +               if (cl->cl_flags & HFSC_RSC) {
>                         cl->qdisc->ops->peek(cl->qdisc);
> +                       if (!cl->qdisc->q.qlen) {
> +                               qdisc_tree_reduce_backlog(sch, -1, -len);
> +                               return NET_XMIT_DROP;
> +                       }
> +               }
>
>         }
>
> Returning __NET_XMIT_BYPASS prevents sch's parent class from being added =
to its
> active list when no packets have been enqueued. It also prevents it from
> updating its queue length, so we need to do this manually with
> qdisc_tree_reduce_backlog(). This is necessary because netem_dequeue() as=
sumes
> the packet has already been enqueued to its ancestor qdiscs and decreases=
 their
> queue lengths when dropping the packet.
>
> qdisc_tree_reduce_backlog() will end up calling qlen_notify on non-active
> classes, but after the recent hardening of the qlen_notify methods this s=
hould
> be safe.

I think this is probably the same as the one reported by Mingi a few
weeks ago. Your above patch looks reasonable from my glance.

Do you mind submitting a formal patch? Ideally, send it together
with a selftest (in the same patchset).

Thanks!

