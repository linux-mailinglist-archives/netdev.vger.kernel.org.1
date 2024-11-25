Return-Path: <netdev+bounces-147231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5F09D866F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 14:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E85D16A828
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9A1AB52F;
	Mon, 25 Nov 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxZIUr/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741311AB517
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541394; cv=none; b=QXFy69LVD92gvrupNhkq+OGsTrZqnTHnPFBWDiSKbrCkje93AKFvfIdmllWY74OZ1LXSlXLP7i3CLG76FpTDoTsYiUw5YQbxiVYhUTLwDKPR/c18g7Fg6lyp5KsxQyhTNL/jqoiK9wQes/k3CvOXQJsKFuALIYTgJOlM+5SzOW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541394; c=relaxed/simple;
	bh=An/yzXprONnMPtlpU/2I9a07cBX15M0rhhil7Q0mVKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/ppUqy8bf9I3TISaDUJgppUVPqsHdD6hBmNzK2n0cO/CtBahPLsJRVjgZDI9EsA34mXVL0Krw91uj9Jb11Pbz+SIzrMnzfEHm+5febl/AlZAeeq2AFaH9kbHA5eoTsvd3CAmr94ohdkxm8OgxaG0Ds9E+KQSDzV3aUwDC+HN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxZIUr/h; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de2c7e101so1329035e87.1
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 05:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732541391; x=1733146191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngAhAzZDfROEb9czhlQGE20UKXU9N4cRJ6/BqKJofTk=;
        b=CxZIUr/hisUgw7oIAgeiBQ8B5mnw5dV5qCfEjwBgCb22i3mianlbHaJf1xcnteFm9p
         Yky9tm86UguljDZBqBg8jAcUMnQdv/Hyg7CKp/7fHv+c1HTKnU1iUwSVu0qyWMAQibrF
         GfbS0NWUYQlifpC95XxhzLjhIOTYF8GixxnMDQTsS8CJ9SjYP1aT6374Cy00Y7sL2b/B
         CBRniYYGA4DkeGt/UT5UsGwd+rL60Q/kTCDEhgmwnHSm2H9vasMryiXpdnXAnDCmU/4D
         krEouX9vjP/sf8ABXtpCdnw+v7IpJNUt0nWjPEHL3P85ozzTNsnkVFP08+ozSegS93uB
         yUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732541391; x=1733146191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngAhAzZDfROEb9czhlQGE20UKXU9N4cRJ6/BqKJofTk=;
        b=UNpxYru0+iF1H6P4DyKIEwJlY2/9W5qOR6/RXuZUz4J3l16bQt7h6Op9yJXjbcp/0d
         2XdiSSva/ZL0xRqlT5UYbv0IAbPinIeidIQGPOrBV8UO2VOn/gJIY0you4Ja+LMLiKMr
         RAAOBWJlIwS6eD1Oimf0+2Hcq9X75H2E62sPXLYW6hc7UT/5kUBY1c2ikjx6x5qNPeFu
         nO+MyUbbBHnBw2XkTz70jdthtJnP3awigdvDix1GDoXRNVSlR2OjeBuQQGrkcvv76cFV
         /9GeacONy7DdmrjS/Uf3V7/f6uM8Js4bW9mZ09MOXd6UhjOPmdfKWmID52ooVUbChxQ4
         OchQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZpfyO2AfCZIjBlSam0mNhmbNR1dJmGScyk1cEk7wvqddGp8cMHFlhmsvjB3OIj9484s105FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWm3+4mqbfA+zhZlTgOT62PIv9hQfSzfi2xkEjyYe9VKEMln1
	6NFh5EK9QXCgDMLes3AcJ6Zh1kowVQqvUx/yPCpIHzXRHQIf7DXn+uocyNYyBEybh1rHDAoF7/f
	tjwor5D41Us2p1GkMFPUY5srnt7sZcnlcSJbU0gVHwWkTm1P0KFwRbGc=
X-Gm-Gg: ASbGncs3gHtP5aV7WQl+cjYsPRvlCZp88m4z+iXem5SAVMOy1UOk7VIHtH7JDRoHFcz
	qd7CZwXYb+KMO4NQgAstX4204VLtw69M=
X-Google-Smtp-Source: AGHT+IGWVoplYlvnHtzBV1xQQjqDUjZdU7Ryuumdx03PRR5hYwhAqGj/hfUtcBbT39lo/UuIn0uq4Op7uwOA/EkwVcU=
X-Received: by 2002:ac2:4f11:0:b0:539:e1c6:9d7f with SMTP id
 2adb3069b0e04-53dd389d698mr5173159e87.25.1732541390357; Mon, 25 Nov 2024
 05:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125131356.932264-1-martin.ottens@fau.de>
In-Reply-To: <20241125131356.932264-1-martin.ottens@fau.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Nov 2024 14:29:39 +0100
Message-ID: <CANn89iJ7uOuDCzErfeymGuyaP9ECqjFK5ZF9o3cuvR3+VLWfFg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: tbf: correct backlog statistic for GSO packets
To: Martin Ottens <martin.ottens@fau.de>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:14=E2=80=AFPM Martin Ottens <martin.ottens@fau.de=
> wrote:
>
> When the length of a GSO packet in the tbf qdisc is larger than the burst
> size configured the packet will be segmented by the tbf_segment function.
> Whenever this function is used to enqueue SKBs, the backlog statistic of
> the tbf is not increased correctly. This can lead to underflows of the
> 'backlog' byte-statistic value when these packets are dequeued from tbf.
>
> Reproduce the bug:
> Ensure that the sender machine has GSO enabled. Configured the tbf on
> the outgoing interface of the machine as follows (burstsize =3D 1 MTU):
> $ tc qdisc add dev <oif> root handle 1: tbf rate 50Mbit burst 1514 latenc=
y 50ms
>
> Send bulk TCP traffic out via this interface, e.g., by running an iPerf3
> client on this machine. Check the qdisc statistics:
> $ tc -s qdisc show dev <oif>
>
> The 'backlog' byte-statistic has incorrect values while traffic is
> transferred, e.g., high values due to u32 underflows. When the transfer
> is stopped, the value is !=3D 0, which should never happen.
>
> This patch fixes this bug by updating the statistics correctly, even if
> single SKBs of a GSO SKB cannot be enqueued.
>
> Signed-off-by: Martin Ottens <martin.ottens@fau.de>

Please add a Fixe: tag. I think this would be

Fixes: e43ac79a4bc6 ("sch_tbf: segment too big GSO packets")

> ---
>  net/sched/sch_tbf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
> index f1d09183ae63..ef7752f9d0d9 100644
> --- a/net/sched/sch_tbf.c
> +++ b/net/sched/sch_tbf.c
> @@ -220,17 +220,18 @@ static int tbf_segment(struct sk_buff *skb, struct =
Qdisc *sch,
>         skb_list_walk_safe(segs, segs, nskb) {
>                 skb_mark_not_on_list(segs);
>                 qdisc_skb_cb(segs)->pkt_len =3D segs->len;
> -               len +=3D segs->len;
>                 ret =3D qdisc_enqueue(segs, q->qdisc, to_free);
>                 if (ret !=3D NET_XMIT_SUCCESS) {
>                         if (net_xmit_drop_count(ret))
>                                 qdisc_qstats_drop(sch);
>                 } else {
>                         nb++;
> +                       len +=3D segs->len;

I do not think it is safe to access segs->len after qdisc_enqueue() :
We lost ownership of segs already.

I would store the segs->len in a temporary variable before calling
qdisc_enqueue()

>                 }
>         }
>         sch->q.qlen +=3D nb;
> -       if (nb > 1)
> +       sch->qstats.backlog +=3D len;
> +       if (nb > 0)
>                 qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
>         consume_skb(skb);

We might also call kfree_skb(skb) instead of consume_skb() if nb =3D=3D 0

>         return nb > 0 ? NET_XMIT_SUCCESS : NET_XMIT_DROP;
> --
> 2.39.5
>

