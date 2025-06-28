Return-Path: <netdev+bounces-202199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF93CAECA5D
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 23:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1833E177AE8
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 21:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A3223DF5;
	Sat, 28 Jun 2025 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QkJpqTbV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8821E098
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751145562; cv=none; b=LROtvYdmVjKxCZiEqq3Dzn5om2BYNmFVXs2DZktRPZ0LUoEdrMaQmaamU+0XKGUyNEPXkk83p2uefMY0JHco6XbCzSFfkg+UB6OtmRlwERwmndiNOgSFA9aIe7gWe92tSmhiHql5bzoAjrsJ9fRgWKyjWpHl48A02EshcvuA8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751145562; c=relaxed/simple;
	bh=hmvzHVwg+p3kmldxrQBhHPuxcvK3HCYKztQo8aRy5cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsQHQ2GrNsS5GgQnWj9cr8E5Uk7GWlXh4X2Mb2nN3WbbFX7+JihaAseSoHKNt532k+ppc0KkfvNboCmP5mU5VUbjtKvCrnaOnjRqypAPlWeXPC3HPAa2ZwCpWAXhk9aM7g4cWwDJZ3gIZd90r2ZNB3pjwmoMT/TVQ/egC0GwObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QkJpqTbV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso986683b3a.3
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 14:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751145560; x=1751750360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5ip6w1IXxOfvnHoKxLFvst7k20arah9x+7WXZ3JinU=;
        b=QkJpqTbVbYoG1W4m7YgIAYQFCUBhL7Y6fCF5PI4RXqhi+iUgQihn8E5oirTn9M02ig
         Au/+VyVS3YIndsgCOrhciUUWa8giSP9EJ4MDtVnqNc+B4zaKcJtftSTJnarLFyCumigD
         2sS/9s/Fhsny2QrhTt+7c43dfA79aO9KD1rgih8aXWBExZYi04+jmOZLIucQqqWquceB
         sogqtr79QNGkfoBawhupgPm8ci2lVnnPfa7+YNgFPpAtIlwulmIaG94Kx/tp/6x/IULU
         LZyyAU8t2YEx+ke44K2txCCAocHNxFg+sI7K60lz1kz/HbszyWze8n+f9yfB7MXj7V/n
         gxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751145560; x=1751750360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5ip6w1IXxOfvnHoKxLFvst7k20arah9x+7WXZ3JinU=;
        b=Au2h3daK6c79GGDxYaeKyZ9tn4IzsKrl8eZTeWQSL/IffquxKzyqttM9E4U8uIPJxz
         HBWDaHq8CI6sJkvnJoOP4Dk0GlDvW+a19DwGoktm2W74MZhB6hRClxn6Z0H7Fgp4Ka7V
         Ebs5U1nYuCYNKy3Clmu8RCiAtctQSWGnIW7OQDny3frvHqvxo1nZQ2p8pVgTmCI3ou1Q
         fcAROwE6ZDh4eA+bU3ct31FYLMKDCI6FpjARlg/0aiaeiPpip9VG3OEhj4dfW6kpkSRH
         pAQiTlZxgAJEHuIn8ro5K3e/O93j/tes4cRPTl2ohDW9hDX4JPN3vZiNdBLIRh+XkRPr
         SYYw==
X-Forwarded-Encrypted: i=1; AJvYcCU7NHmujB/ZDd3p1TstV1JhgqvKVeuJFhxj9bwMLij6zThA1MRbkUlqerxRk+E6cEQOZbCtUKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX85uyR6WSuMiAKlAIO2BOKBHz6ZHk5/cnxv/aV1/nAUtbyKKb
	ClECpEk0RMvjnyuYeoNjTLjmhtwj+ntjS7+MWIUEtNyUwpCYcLpoexE+A0PhxCRy8vFeEQBY1ZB
	+e6o1VY9emvLLfos1PaUyw0QLCumWqtkcPMgB+342
X-Gm-Gg: ASbGncsqKyaVm1eX4/1P6cbQWfwKpwyB2Iz5BEqNebfO+Pe9nkSPT7bb11HJ6kAe7UI
	JZ4mlUP0hhKsIopAQJw9b2QtSD2hujqoeN2GrIZAzTB30iqnYKY/N0l2flwdnxR5rLXyZ8JMCRi
	vy2Oi+LLnP2RWODNHplI9cS7Cl0nRfA30vm8diRD6BRw==
X-Google-Smtp-Source: AGHT+IEdJqrLMPdhT3GnilSSfTFUEkUpSiwZnuqUh9FUPrIMt6peSZmgEuH8VPHCjsFB1aTLdYVXC5VUsgVzv2MWh2Y=
X-Received: by 2002:a05:6a00:9094:b0:748:ed51:1300 with SMTP id
 d2e1a72fcca58-74af6e61c70mr10533022b3a.9.1751145560634; Sat, 28 Jun 2025
 14:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627042352.921-1-markovicbudimir@gmail.com>
In-Reply-To: <20250627042352.921-1-markovicbudimir@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 28 Jun 2025 17:19:09 -0400
X-Gm-Features: Ac12FXwKq9hoZPPTZhuO1X4BEgO8dooVRCUvx7R7g6jiyqxNmleYHBq2WY5zP-0
Message-ID: <CAM0EoMmA1WLUtamjYNFVZ75NYKznL3K2h8HSv=2z4D3=ZDS83Q@mail.gmail.com>
Subject: Re: Use-after-free in hfsc_enqueue()
To: Budimir Markovic <markovicbudimir@gmail.com>
Cc: security@kernel.org, xiyou.wangcong@gmail.com, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:23=E2=80=AFAM Budimir Markovic
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

There are several approaches being discussed to do this on the list.
Please come there, see this thread:

https://lore.kernel.org/netdev/aF847kk6H+kr5kIV@pop-os.localdomain/

cheers,
jamal

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

