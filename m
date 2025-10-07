Return-Path: <netdev+bounces-228089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 721DEBC13B9
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 13:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFDF034E409
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629FE2D73A7;
	Tue,  7 Oct 2025 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ISKmvB5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF687483
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837078; cv=none; b=WXGvMTiPlj3Kp/ALIUb9VEeggYKUWRtEYOAuNIJ/RrFAy94/f6oRE6J8X3AQqH+DLuDMDP7zgWcgteC0kZgSS/q0w9JmyI/Xf8HlNvmFTVnb/fBnP14lPujOHygkvb6cDlB7Sfx3wDhwPvBocfWpoIczqGEY9WOnEK4s0E3lGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837078; c=relaxed/simple;
	bh=cNS6s2uqtQe7/Vi1htHNYKq80sHiwJ2XSDiXNvAiOyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sk/rmA5ExIeDLHz/mSpe24O4hUX3CGhmmbuqXgu7XDJZHyaL5ldFyFSG8VflpWD2fiDDJqWXkx4kTT/crSM2yp6l1V5WqSH7etCOgdJNTHvRBL7v6/BnQw1+8PgXVV346W+aGtME7ZcNOGzPM4piiG2cQGhVS6RUbfCutRGzz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ISKmvB5W; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6353e91a04aso7064159d50.2
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759837076; x=1760441876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQCJRhEhrzI6eVRa/jjPiWHpYBGwXMMvoO0iben26aw=;
        b=ISKmvB5WsYcD2KwZgS08Wi9HzLwImu7z/u6B2lLYRoWtUQG9zXVYt0rTgon1V3b1uZ
         WFIk59GeW5aByXrEyTlxVH7kVFPgffN31bKRqLEskyggn9PULLs3Cgvvr3MvnH2yjZfN
         +OXoDpGf4CqbQnBXLRAungv+JaULQ+EZ8/ZIUnCEBxVWVkHQqA9kXOHheyaWHZlTqgxX
         0eZA0KKucdD0A0TnPwP2v56E7gkS3WxHWvsOr9AnZVKxmU/g3iUW7OpdLmOAyJr4bdtE
         DEY80ZvYgSlVMYK+W4wBjYAq4T91iXNu1SVOpzMf5GdXxdgZzy60zRS04Yz+67OdhGp1
         Pnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837076; x=1760441876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQCJRhEhrzI6eVRa/jjPiWHpYBGwXMMvoO0iben26aw=;
        b=fa4CZ8V3RkPwCDitAXcPNoCYunEDjg5MIT7Z0lhSle+opyCypcU9luTpDrVmydflls
         Q4Br3Yfszk55nTmJOxG+fTmshewTW6e7e6WKiHLlWiPVg+7jK2pCUafhMaNFSBYcThbq
         1gX/QZ3CQwGeByMNdp4YxK//++mGAp8W3yJTGWSG1N2aDXqicICwtr1KRbZBG+RA6l7c
         uooSOXwy6tzgE7tTxUzNr9fqL9zFWbZlkDIJyoImZuAF0wSPHgLtbnXCyIy3nA8TMGuR
         YFZRHKVBS7oRCP9zA+tDpxHXOdpc+iYwYwKrUg+xe3L9ZgSxkC4hgEcC9Kne+g/31YnD
         Q6NA==
X-Forwarded-Encrypted: i=1; AJvYcCWM1E2HRHfxXNzOrIUKeEwc/CbWT4qEEKxujH8S+wLUigZB6oH1vvAYBhE277jiWX9Xtp+fNvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtL/dwbsYhkFZp+DqUIyBV8JbOap+IOMBjSulto4abIL6Uurb
	sSlGegtGty1BkOzYs8oga4gWGtZBiIPEcL8WbOOH3Zc5mSKZt3UnqLVIxJX0wavbJcURNOJgNsq
	bS+khFwTx7vLgFP1dgbFdOXm3mp3Vpjq51uvJx0NR
X-Gm-Gg: ASbGncutndPvUyrWSCAyI6Msb6m4Ntt1kbrVISb/u9fv9fy14GOlOETd8XSaphO/dVD
	L2whuyhlPXcLOaWHGsmvlWi3v+LauPebRNyIuUaYDDBQyh0vMKtz8nYUT3uocGwUeFunYqa8lLq
	YnATzbeYDXw41ONzmx+KDIh82QW4YRbmbug1yrL6O14QXEqV+3SWHrx54bwn1KH0gHn8cYP6ugU
	/I6T75ePoCF8dMeXEypS63ug53kBh6IvL8VaQ==
X-Google-Smtp-Source: AGHT+IFNs+TpBVgsvO2+JVkBcdP5XAOsG/vuBpiZG80Ghip6TWQ+yTzBxF4KPYE2vjO6jmyBd+npOmPWHOvaNKvW/5A=
X-Received: by 2002:a05:690c:ec4:b0:766:6507:686b with SMTP id
 00721157ae682-77f94594206mr250129337b3.8.1759837075121; Tue, 07 Oct 2025
 04:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com> <20251006193103.2684156-6-edumazet@google.com>
In-Reply-To: <20251006193103.2684156-6-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Oct 2025 04:37:43 -0700
X-Gm-Features: AS18NWAW6a6s6eeLYq5UGbgAZoDn5MU0pCFdREPPnaGIL4JwtDWcbSJiaKrB2Ss
Message-ID: <CANn89iLLSLYNDe8OnsjDuYHBee66p9F7uFuZznri53V8ZYkbQA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 5/5] net: dev_queue_xmit() llist adoption
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 12:31=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Remove busylock spinlock and use a lockless list (llist)
> to reduce spinlock contention to the minimum.
>
> Idea is that only one cpu might spin on the qdisc spinlock,
> while others simply add their skb in the llist.
>
> After this patch, we get a 300 % improvement on heavy TX workloads.
> - Sending twice the number of packets per second.
> - While consuming 50 % less cycles.
>
> Tested:
>
> - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
> - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
> - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid contenti=
on in mm)
> - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"
>
>

> +
> +       ll_list =3D llist_del_all(&q->defer_list);
> +       /* There is a small race because we clear defer_count not atomica=
lly
> +        * with the prior llist_del_all(). This means defer_list could gr=
ow
> +        * over q->limit.
> +        */
> +       atomic_long_set(&q->defer_count, 0);
> +
> +       ll_list =3D llist_reverse_order(ll_list);
> +
>         if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
> -               __qdisc_drop(skb, &to_free);
> +               llist_for_each_entry_safe(skb, next, ll_list, ll_node)
> +                       __qdisc_drop(skb, &to_free);
>                 rc =3D NET_XMIT_DROP;
> -       } else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
> -                  qdisc_run_begin(q)) {
> +               goto unlock;
> +       }
> +       rc =3D NET_XMIT_SUCCESS;
> +       if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
> +           !llist_next(ll_list) && qdisc_run_begin(q)) {
>                 /*
>                  * This is a work-conserving queue; there are no old skbs
>                  * waiting to be sent out; and the qdisc is not running -
>                  * xmit the skb directly.
>                  */
>
> +               skb =3D llist_entry(ll_list, struct sk_buff, ll_node);
>                 qdisc_bstats_update(q, skb);
> -
> -               if (sch_direct_xmit(skb, q, dev, txq, root_lock, true)) {
> -                       if (unlikely(contended)) {
> -                               spin_unlock(&q->busylock);
> -                               contended =3D false;
> -                       }
> +               if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
>                         __qdisc_run(q);
> -               }
> -
>                 qdisc_run_end(q);
> -               rc =3D NET_XMIT_SUCCESS;
>         } else {
> -               rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
> -               if (qdisc_run_begin(q)) {
> -                       if (unlikely(contended)) {
> -                               spin_unlock(&q->busylock);
> -                               contended =3D false;
> -                       }
> -                       __qdisc_run(q);
> -                       qdisc_run_end(q);
> +               llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
> +                       prefetch(next);
> +                       dev_qdisc_enqueue(skb, q, &to_free, txq);

Now is the good time to add batch support to some qdisc->enqueue()
where this would help.

For instance fq_enqueue() could take a single ktime_get() sample.

