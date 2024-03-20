Return-Path: <netdev+bounces-80885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B36488174B
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 19:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0F9B20C33
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 18:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DFD6BFAF;
	Wed, 20 Mar 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="25alXUAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13B6A03E
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959162; cv=none; b=HKLqaKkEBlkQnNt+m/+eIF243bpvN2ZHtM+U0IB7SpAlA6yMMw9Nn6C5hMCyBxI3N9uSG8/oASr69kajIvHzGg1qNS7x0xGOf8GoTZiIKoxhMDJezyIHCmnupdWL8ibWGj83G/y6b7ygC+7G4uBCRAsWzhmuhVMBSTt7Z3nG4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959162; c=relaxed/simple;
	bh=iq4tGYOvTKWRWRDqPNMEhojder/9m1N2Eht2yyOjrbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dauXrL15SEalH6afGJiBGJD1bSAgc+sjoaT0BhXhvM+4K6dp02nMIilU8Hpr2r6oeiZrg+Y88+aPiZMKrD5lwjwsP1wvjxffE4RB3R24Zq/ay1wLq9jeIm0j9m2U3HuhAVz+dRW3RyJSvfDNO6StUpk5aEaH2ZwhMtbMaxOmGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=25alXUAG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56b98e59018so2649a12.0
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710959159; x=1711563959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0PPjawfV18ohOQFq2ls8uycj1EDrQpyPD+wtWSWgLA=;
        b=25alXUAGjfrSb9rQjTmoc9PBe27NHpmZD1bLheT8OuXZd/8IOatm49r0DlKBPtr1xD
         fFHIfvIJ1kEoeqamvhVN7quDTCbqlAX9m1wPMklCrw9qt1ggn+53cN1oHB0lZLdEksyy
         SYF0b8QYVl3FIxkHY9Pvyd19GNQlBnAoAB9DViiRzaMLTCUPoNKxGnFieX/hJtQJxz+F
         ublqIyaR9ysI+XTJ3K7ZWmnjWrMuSUdZ6J6muBkNRFAkqmOVTUkj9K4YiaDKgO04BHcU
         KXzyHQwrbZGI2p8Kbe0ey603irDrK7DyKx5guULi8VQgj24duSM5pjDmIzsP6pEelQoI
         hWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710959159; x=1711563959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0PPjawfV18ohOQFq2ls8uycj1EDrQpyPD+wtWSWgLA=;
        b=BANRC0rRovknwTK3XXAT5SqIGTww1R6JIcGMoF06Uo/nm9DMv7iafllu4Y+Pyg38Wo
         GqQAu/4ZdoQ2v4xPVj+mubdmKY6enY7NXaoFgVZNLRW0Nw38FTUyeQKlRfEizc1m1sQL
         sfEODUbUGtc88eiplW2Lr2Gsze5b50XWAEHnHAWvhNe1MKu5Lvo8c2WN0o53VcQWRVSd
         yJEy51Ij71yH8Dpf7KptTen3Enh6bSWRQcFKqMG08l5Dd3kwi2D3hERpFZqFV15HThee
         LDN4M1IKliM8t/Ikt6A4EhPs5lMZiPAU9v30cv7wwXh7WtE0A6eeUd0yk+F8sTV5nba4
         oWow==
X-Forwarded-Encrypted: i=1; AJvYcCX2i1IN+q4a+Q8mOx5fIQZh9ICBc0QoyYAicen4mZxBFeldnX+4+FRju2HaKPCsfBvvU2IPmKNnQXPj98JNB7kqY7VGK8TU
X-Gm-Message-State: AOJu0YxxdufAQg3xzKvqTh73o7i9T+aDnJPrMQpW7wpxYSHQ6X9Oi+3p
	Cbcm+a5IkOPD7MX807dTRx5qcaTDGP4K1rQBaIwwOwbS9r5y90vMwrLp6bVZE+ecR27IXkrNa06
	h0/zJqCC/8oSMpXFvd8sR4kGY3YsdJxKs7+MX
X-Google-Smtp-Source: AGHT+IEe7uqkxXDOoY9y9XBTokAtu2vn3p9tFMezE2DBc0bELTcQL97k0oPteEBHPZLrc7H2ywKEomq+JH1IwhaYNS4=
X-Received: by 2002:aa7:db47:0:b0:568:ce1e:94e5 with SMTP id
 n7-20020aa7db47000000b00568ce1e94e5mr7972edt.5.1710959159175; Wed, 20 Mar
 2024 11:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com>
 <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
 <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com>
 <CAM0EoMm+W3X7TG8qjb8LWsBbAQ8_rntr7kwhSTy7Sxk=Yj=R2g@mail.gmail.com>
 <CANn89iL_hfoWTqr+KaKZoO8fKoZdd-xcY040NeSb-WL7pHMLGQ@mail.gmail.com>
 <CAM0EoMkqhmDtpg09ktnkxjAtddvXzwQo4Qh2-LX2r8iqrECogw@mail.gmail.com>
 <CANn89iK2e4csrApZjY+kpR9TwaFpN9rcbRSPtyQnw5P_qkyYfA@mail.gmail.com>
 <CAM0EoMkDexWQ_Rj_=gKMhWzSgQqtbAdyDv8DXgY+nk_2Rp3drg@mail.gmail.com>
 <CANn89iLuYjQGrutsN17t2QARGzn-PY7rscTeHSi0zsWcO-tbTA@mail.gmail.com>
 <CAM0EoM=WCLvjCxkDGSEP-+NqEd2HnieiW8emNoV1LeV6n6w9VQ@mail.gmail.com>
 <CANn89iLjK3vf-yHvKdY=wvOdEeWubB0jt2=5d-1m7dkTYBwBOg@mail.gmail.com>
 <CAM0EoMmYiwDPEqo6TrZ9dWbVdv2Ry3Yz8W-p9u+s6=ZAtZOWhw@mail.gmail.com>
 <CAM0EoMnddJgPYR75qTfxAdKsN3-bRuqXrDMxuwAa3y95iahWFQ@mail.gmail.com> <CANn89iKrW4em3Ck=czoR32WBkhqXs7P=K3_dMX9hdv7wVGvKJA@mail.gmail.com>
In-Reply-To: <CANn89iKrW4em3Ck=czoR32WBkhqXs7P=K3_dMX9hdv7wVGvKJA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Mar 2024 19:25:48 +0100
Message-ID: <CANn89iLzc7onLZ6c9OJ-8GW8DpoGHFNWagqttZ99hkhRzVpSOg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: renmingshuai <renmingshuai@huawei.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, vladbu@nvidia.com, netdev@vger.kernel.org, 
	yanan@huawei.com, liaichun@huawei.com, caowangbao@huawei.com, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 7:13=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Mar 20, 2024 at 6:50=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:

> Nope, you just have to complete the patch, moving around
> dev_xmit_recursion_inc() and dev_xmit_recursion_dec()

Untested part would be:

diff --git a/net/core/dev.c b/net/core/dev.c
index 303a6ff46e4e16296e94ed6b726621abe093e567..dbeaf67282e8b6ec164d00d796c=
9fd8e4fd7c332
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4259,6 +4259,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
net_device *sb_dev)
         */
        rcu_read_lock_bh();

+       dev_xmit_recursion_inc();
+
        skb_update_prio(skb);

        qdisc_pkt_len_init(skb);
@@ -4331,9 +4333,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
net_device *sb_dev)
                        HARD_TX_LOCK(dev, txq, cpu);

                        if (!netif_xmit_stopped(txq)) {
-                               dev_xmit_recursion_inc();
                                skb =3D dev_hard_start_xmit(skb, dev, txq, =
&rc);
-                               dev_xmit_recursion_dec();
                                if (dev_xmit_complete(rc)) {
                                        HARD_TX_UNLOCK(dev, txq);
                                        goto out;
@@ -4353,12 +4353,14 @@ int __dev_queue_xmit(struct sk_buff *skb,
struct net_device *sb_dev)
        }

        rc =3D -ENETDOWN;
+       dev_xmit_recursion_dec();
        rcu_read_unlock_bh();

        dev_core_stats_tx_dropped_inc(dev);
        kfree_skb_list(skb);
        return rc;
 out:
+       dev_xmit_recursion_dec();
        rcu_read_unlock_bh();
        return rc;
 }

