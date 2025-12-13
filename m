Return-Path: <netdev+bounces-244588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD5ECBB022
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 14:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EF6F305059A
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED03090FF;
	Sat, 13 Dec 2025 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8jJh2ZC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077922CBC6
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765633015; cv=none; b=MIbh1xxmCCPAgnSGJNKy6Tl4siY6MlUviNQ5D/D2VSvUF/Of0DCjFpo3eb+TSfwQ5Ne/38hy8Ps2No9WnvccTN3BICUopLiy5DGeIErNEOv1WfqDj0L0U/p3zN/B3JJihDxXQGDdgtdsVf8NKhw0VhE6P4fuCDmq4wdloBC51TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765633015; c=relaxed/simple;
	bh=WoHLyYxLOaic+yRkmMLgJR7K7zw9Inko4gu0ghQYXHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiiXcYkyEDEHKOm+qvcIPeqUMdMaxRgrWgENlIAnEqeVw4KDoukUj0enu04c6V0/jdhDTNTGiwHWXr8YVSfwtQ8rJL/GGW7SK8n4t12t6cWNbxTCkWUTTiotX2XHt7FkOMzZplMT+/LpKp2zwV7jnMknzz1yvT/VOpGAir94fEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8jJh2ZC; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b9d2e33e2dso313926085a.3
        for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 05:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765633013; x=1766237813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZjrRqSLjo+ZyL4UIbe+eZ6xRuU7MvFmgIJ10Ocp18c=;
        b=E8jJh2ZCKfvXCta/bawyYOtX5DUVF5mT0j8YTJ/m2itd1SZQgrRLpVOEo7PqxcEaFl
         QZVH282FtbRkXRfW/go40gsek5mLaelLqyrc0H9DvFxaaG8KiT6BulUrtHjQilflcnPx
         kdFkex3cZfqbC3Kc5bmFC082pFiTL4YHadiJa5OYwwT4ykr0PH/CtdAa3jLOqBE38GFz
         Lhkc6UV8fkgHSTe0hY6N7pSXVzOxtODCsIMuiPMSoPfm7OUsfpzTXbdNJTjriJmKbBGu
         2YP2ItZQyrHTxoqCAeOHMoum9L3ff+/R8sNC17h4x2WHF0ccy9erPxILQni4/+OsMs/4
         FdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765633013; x=1766237813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ZjrRqSLjo+ZyL4UIbe+eZ6xRuU7MvFmgIJ10Ocp18c=;
        b=vhVbmRxLv56QS08jYPQ6y1OlUmrY0og53iRmAJNSauxQIsexXvn77KpSz8/E5Uw1SD
         woHYtqUg7qH5iol8L721W0CcDH1kxxMwOlRC/VLsTHWm4wAjDdFl8oJIMWkV8jv76Jjh
         rMfrLOBfKL6nx5JfhnMXpF//MG6IcFv3lOVkPEm1Yu45dqJwWS+tCfwQxatvEBc5Ku4u
         amRl5lDn5cvj9v/sZo9tNmxvG3+Q/MGAvELMLb2cewJiL+SezgxHnB/emCdeoqnDvHY8
         FRrdSIN94+HFPnzJCEiGc3EiJWNcpzJegxAMnEvkeqQh7lg1JterlCxx6A/V4um8Uls+
         DMkw==
X-Gm-Message-State: AOJu0YxlvZQGWg7n0bdigcwNha6PE5TcP4+iu0v4Bn6bAIv5QkUefc17
	MD0xrU1yOx5pO2cxKY6VJu8VjMF5WUmCzciR5AMUSnyUlJRpWnJriHKUNJ7izUD1dNCS/7JE1hq
	vzg0bpxsGjgshkIdnIRM8mCYWkAKi7o9U1hG2TFyLfBzrPrfLK9XI8qnYiYI=
X-Gm-Gg: AY/fxX4Qp/9gLDXeO1GqPvNQgVCKOfVSRaK/vG7WdosCkMSw0rZLlgW1C19WXd4+b67
	0Up3i1SLWOZvlWjefeqrMPpV3qvVkggNVSaLo46qsxt956VogCbnKSoDpEM/kOqXMC0ZQ7rzQ+g
	0+GQgVbtGXxRYrlQAjnNFB0J4uzxnU+8Z/vWKCtnZKxoEqr+lH3IU3HiCDEKTdNEdcwPRB99YuV
	X+7AC/SJPq81QenOFRff9XW0FE7DNO6i5PMPssW1g2LEGWnOAzq0h9bOb2+LL8RfqmwvA==
X-Google-Smtp-Source: AGHT+IH/7foLfly18vqTfZ2bK7JUtQ3jnP73LlYwtHZ8du7ErR4/dtAF62EZebiY6HHFjsOkE8Xv8Lb8XnMM0APTuEk=
X-Received: by 2002:a05:622a:24c:b0:4ee:1227:479a with SMTP id
 d75a77b69052e-4f1d06438e1mr68068821cf.84.1765633012675; Sat, 13 Dec 2025
 05:36:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213121024.219353-1-mahdifrmx@gmail.com>
In-Reply-To: <20251213121024.219353-1-mahdifrmx@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 13 Dec 2025 14:36:41 +0100
X-Gm-Features: AQt7F2p8Zg1DIZe5tr_m6fEYy0ppaZm6uGNYa6jS9xHNP57ZuIWSZxw3eUAMmEw
Message-ID: <CANn89iJnV=ea+bP3LCF7FKVAXrvc5qHd9j9yrgv50-rFaPO0ig@mail.gmail.com>
Subject: Re: [PATCH net] udp: remove obsolete SNMP TODO
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 1:11=E2=80=AFPM Mahdi Faramarzpour <mahdifrmx@gmail=
.com> wrote:
>
> The TODO comment demands SNMP counters be increased, and that
> is already implemented by the callers of __udp_enqueue_schedule_skb()
> which are __udp_queue_rcv_skb() and __udpv6_queue_rcv_skb().
>
> That makes the TODO obsolete.

This is not true.

Please carefully read commit b650bf0977d3 ("udp: remove busylock and
add per NUMA queues")
And perhaps you will see what needs to be changed, thus the TODO .

hint : to_drop can contain more than one skb.

>
> Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> ---
>  net/ipv4/udp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index ffe074cb5..60d549a24 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1797,7 +1797,6 @@ int __udp_enqueue_schedule_skb(struct sock *sk, str=
uct sk_buff *skb)
>                         skb =3D to_drop;
>                         to_drop =3D skb->next;
>                         skb_mark_not_on_list(skb);
> -                       /* TODO: update SNMP values. */
>                         sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO=
_MEM);
>                 }
>                 numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> --
> 2.34.1
>

