Return-Path: <netdev+bounces-229253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE22BD9D55
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0537F4EF162
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9923148D5;
	Tue, 14 Oct 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5iBVKyt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F243148CE
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450308; cv=none; b=l3+YorEnKltJwXHe43190hfgabiCHoqSXKR04QHebMbANRc6cXCP3EoQsK4YkgFDB7C4CPj45S/s4NfcTbnoJLgrX4PTbZPw0ZuRC7vrG9YBEqVLoh7I2lfnYfiC/JtwnHP4EmMGMcgmHl2OX6pY2Dyp2I3hy+a79MTMwJBunvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450308; c=relaxed/simple;
	bh=6qLOx+rl44CDgXVATMI2AcMypFV/hRouSp+32ok4whI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LX4jps6v0MJSSC7xspQxAqvGy73ABrz/eYdjT60dPViTyDAKL/++a5G3QmNOw3mIcSD7VLtgHGNb5CSxTVbGFRIt3CuTaFzTGMaO498y3E9xNEydy5DJ/eyGcMiACiMm0E/zAtHerM/qSluhP/VbmdkN7UgXZtzarh6XbJ4KMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L5iBVKyt; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-87808473c3bso976349285a.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760450306; x=1761055106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGER6te6UjzRUCMdiL1GZ28UC4aFmN6jb45XeC4NmsA=;
        b=L5iBVKyts3FDgAoBmR4D+f3eAQbVf+S20bufKSo3TATtVklG1RtlKHnNpjpHoZ5Kd2
         9whIBT3F1P0UQdsaAkSK+JgXuWwK+Vk+01t1OYSpUxI9Xj+Y8fQizl6mSSFUhppxrWnA
         iwC1cLSsm89jb8FOKatqvterMG0VWFursJduNpaGsp2uNcp0nriy1S2u2VGwHwXGvvDR
         Pa41u8XaFdqpJJNMmSmd7lbsa5Dh+9gVul2hhBmhWnor5uDoTEoXnbVPdS7Dn3XmNbD1
         VulJBmrHCfKdgLltlRJRKAuweqD/onWi1DPfL2s+B/EAS2WkxfiXZQz0I3IT6XaC+b+/
         7kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450306; x=1761055106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGER6te6UjzRUCMdiL1GZ28UC4aFmN6jb45XeC4NmsA=;
        b=LVnIaMzr7D6njkv78fWc4BDvhMHn+HzqBJ8NYpOQg0iU6Coa8ipwlc42RKqpiZGeoR
         EBBuckJVoMA9kG5kJeFazFaBZooII2zOOgk8BStEfRoz12sV9YcFouFr8TGts7IzkAk0
         i2oFKf9NKxASdZp+/4WYKatjgO69f47ywIp4gaQhgeyl27Mq0HRK+76iMr3Naa4DMJjd
         OMYbBEHL1sDrppZPZsgalzZUabnC9hM/XfNlPDFBkc8hDAlvujTm4d1lq0+w22+yPKon
         qeac+VcxwBG+65mOKxcSqDiPGVWzDKPH6r+2LQLKhjREcuBjPu3sU/9dwjGxbwt+f8sY
         xQNA==
X-Forwarded-Encrypted: i=1; AJvYcCVtCxNSKTlMSE1uC7BbIEnIelW84s/trNuPfbGaPdZO1MJ6RU8jH12ktUY6VzRFcwYu0garUWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmr4H+r1VQW0dt/STarGL8nSvqgkAqdOTrRKxVqsHWYtn/t1H
	e6aUemt8fRd8kNL0JWEA8k7W+iPy7tny/fVCKLPeaw+UXDGp44lS8lg7U418oU+AFp79Y5/6vwI
	IHtH8KyYAQKUzoxgB5V5k3uPK6USxyhLveciBimCD
X-Gm-Gg: ASbGncvSnmg8aUPqjQ1G/9PJ/xTsNrvqG/779BJ5Q8pqfb+5HBWN5TTuvRbTn1nlNW2
	ddUA2x47QtTLMwq/NZTfz8zjmStPyJzqYsNWTI8CiAnLI8Vv9NBrLtgkwYYaBcEgiuSRaaxlokz
	sTjZCZCn7n+iaktn8c2jPZFJn+O9Vdo/17pCiAwH95kiidGD94RUHfXth5bXcisfSjwJ1bWXu5y
	r87ZtUXVtdbAApZYUm6dSEcPMPCfi/3
X-Google-Smtp-Source: AGHT+IG1ISYWni9Lp5Mim7TWPOMe1zaxTRW+VVsvQ6XC6zHyMQSvniAPDKau3alhoxuUWbEzDFS/9CTv96s9a0lUGdM=
X-Received: by 2002:ac8:584c:0:b0:4d9:5ce:3742 with SMTP id
 d75a77b69052e-4e6ead650cdmr357023441cf.67.1760450305234; Tue, 14 Oct 2025
 06:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014060454.1841122-1-edumazet@google.com> <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com> <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
 <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
 <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>
 <CANn89iLKAm=Pe=S=7727hDZSTGhrodqO-9aMhT0c4sFYE38jxA@mail.gmail.com>
 <tdxplao4k3tru2ydqrjg5wzt4mmllblmilys456y7latayvdex@3l7xabhdjf2d>
 <CANn89iKQYN1qTZoSW4+1v6scDgH53zi9pP_O_mEbTdYQYie1uQ@mail.gmail.com> <aO5Sv9GEEPl6zAE5@strlen.de>
In-Reply-To: <aO5Sv9GEEPl6zAE5@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 06:58:13 -0700
X-Gm-Features: AS18NWCKU7SiwA8LFxBIfgAUu29_fRIAZ7R69HicCfR7Nuac1qQ0s4XL-EVMPVs
Message-ID: <CANn89iLpOcrEERr5ZJPb7Yyub0JUenkSLojV_DPxMqTSqeS-Qw@mail.gmail.com>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive queue
To: Florian Westphal <fw@strlen.de>
Cc: Michal Kubecek <mkubecek@suse.cz>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 6:40=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > Thanks for testing. I will follow Sabrina suggestion and send :
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 95241093b7f0..d66f273f9070 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1851,8 +1851,13 @@ void skb_consume_udp(struct sock *sk, struct
> > sk_buff *skb, int len)
> >                 sk_peek_offset_bwd(sk, len);
> >
> >         if (!skb_shared(skb)) {
> > -               if (unlikely(udp_skb_has_head_state(skb)))
> > -                       skb_release_head_state(skb);
> > +               /* Make sure that this skb has no dst, destructor
> > +                * or conntracking parts, because it might stay
> > +                * in a remote cpu list for a very long time.
> > +                */
> > +               DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
> > +               DEBUG_NET_WARN_ON_ONCE(skb->destructor);
> > +               DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
> >                 skb_attempt_defer_free(skb);
>
> Are there cases where we expect to pass skb which violate this to
> skb_attempt_defer_free()?

So far UDP makes sure these fields are cleared.

>
> If no, then maybe move existing checks in skb_attempt_defer_free() up and
> apped the skb_nfct check there so syzbot can blame other offenders too.

You are right, I forgot skb_attempt_defer_free() already had:

commit e8e1ce8454c9cc8ad2e4422bef346428e52455e3
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Apr 21 09:43:53 2023 +0000

    net: add debugging checks in skb_attempt_defer_free()

    Make sure skbs that are stored in softnet_data.defer_list
    do not have a dst attached.

    Also make sure the the skb was orphaned.

    Link: https://lore.kernel.org/netdev/CANn89iJuEVe72bPmEftyEJHLzzN=3DQNR=
2yueFjTxYXCEpS5S8HQ@mail.gmail.com/T/
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0d998806b377..bd815a00d2af 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6881,6 +6881,9 @@ nodefer:  __kfree_skb(skb);
                return;
        }

+       DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
+       DEBUG_NET_WARN_ON_ONCE(skb->destructor);
+
        sd =3D &per_cpu(softnet_data, cpu);
        defer_max =3D READ_ONCE(sysctl_skb_defer_max);
        if (READ_ONCE(sd->defer_count) >=3D defer_max)

