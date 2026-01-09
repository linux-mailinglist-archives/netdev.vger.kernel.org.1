Return-Path: <netdev+bounces-248532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C4D0AB49
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 15:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA3F23023D1D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8084235FF78;
	Fri,  9 Jan 2026 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXaPp4W6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DC29DB61
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969756; cv=none; b=iVAUyzTxxoocB/XzL9UE1EUAKu6TjWnvZom0U1J7FIEkmvjAe7/ngVhJYeygeid7QUMNubu9QleoFxn2dj0DBcq5UztnLPXVOlCz9fQUx9eyN5hvlPAPZ/33iJvpNgif6mQHBMxy7Z+CFR5feGjg1VPT3kVNGxwi21QBo96oeHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969756; c=relaxed/simple;
	bh=JcDRY4pIwhN5HC5l187cKU2h/ocDHIqwNL5bRk/+1rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvYpIfr1BI/+LgeHgJZ+uzLKB4A2k82uCQuQbpgy9wwAkpNoz9bb0RZxj0iQS7Eo/T+GNbecIoka3r/9uGx0TgJwhf2pkoOyUD2ygUaJBSWDsiOxxMKL/mSHC8SpwtU5SqX6GcYWoiRDgQJMJBeIo8x6dq6VoF4ksr7rzO3Rg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MXaPp4W6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ffc5fa3d14so17038471cf.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767969754; x=1768574554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvySuEXcNwsHzU3lpZv08v+bJvpYxOWItyc565ALTpg=;
        b=MXaPp4W617rC5XpswmAgX+kceCaf7mL48szoPf78embxZ0xbYRLeYn3DKzppi7sm3j
         x2WhWwX+UGxj9Y35MxyEIVcWFpzvh6UWhNAEZSOSA7MkYOZpmhiYQIMe/JWga3MxyakH
         CZKHuAJkEau998a4OWDuI5bOsjF7ofD3RaVJVgRxt8z3g2gWXnKVIh110ht6MypAq8fP
         vtm3qF20Cz2myYo9dPPwCX8AjLaPqmXvRixXxraeMPYurpaLf2y1ZF9jeYcGsQdUORKk
         6K33YdA/oxjPM2fWb8A4OjjabGEE0UT/rV+gTYh9V7Woa7K0zYzhQO/hHjV5M3UUJT0h
         9qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767969754; x=1768574554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvySuEXcNwsHzU3lpZv08v+bJvpYxOWItyc565ALTpg=;
        b=TDOTL38Z/+zTWeEZROx1lcDqouBLRNlJ80YJfjwfK88u6zG3nOblmvG9ghACNMMFCp
         El8YHMvzt8bqvsiXtZsWaF2IMKMN65Yvz1LnzO/iKCKRamutOIu1xf5NO943ptcFDw1P
         KDcm4ZupjhRFCxqYjjaQdOYMpklURP/qxsZYMqHbEQ21WaCcHMltT5r41Lwew5pXKSVt
         V2gnUhZFZO2KHtdGFP2y/N/deCKdP1gVd3GMTmBx6jBxrE83+tuP4AUW8NOpPi3Hj6Kr
         CgjRrIEeAm13kbT8Hz9K711atvt/LuqJkXFmblPddKTka7eEMkxAdrR67S+vrEfX8biH
         MqgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuDP6OX8fNZrLdxi3REndB9LlYaoEPTfhgPtkjUreHaW9Dmja57Hlzrne8yypJPpKmj19OHg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MQBZVslH4M6W6DH+UCeVUMLuyGsoOWZsYJm4zCnVCSguee6+
	y4EPY09VvhsXPwFfmatT7M+pBjEvjxLMuJ+X+CTcH8aKTLI1XIU80TCH/gy13Z16ZfngyBLGNJ4
	+HgaUWY1Dz4kiQ1ysl0gSQycS12ZiJJ3fyK7VJxV5
X-Gm-Gg: AY/fxX7rh0ynrp3z8hBy2gVYEQA8WR/Lb1f+6Q6tjxoi1qqDehNYDgJjeWPXhbGV9nJ
	M8jCeXXmRz39OzyJ72lZ3FxqUzXz9MonhghEfNIm7RbzvSjVEeznan+UMJKTt8i2a5ar/umBW1G
	ZABd7yKPoWHxEPn6tM5J78q/nUgq4edCOpRcdMra5+3WEJxu6alRG6ZX+az5yuWFTeecbf+WP/C
	6gndQg+pH7v63wAVAAySTetRtY8nIHzOZI5+ggfixN21GUr3/noRQaEUUYazf/FtvQU+w==
X-Google-Smtp-Source: AGHT+IFpehQjRf7w5DgIfy2z4NKm7I02OjQiAvJvwgddAOCKyo8jgLyhL8NJsEnFOnmB0DEs9k89fVt0KJYCtSqBv1Y=
X-Received: by 2002:a05:622a:88:b0:4ee:7ee:df70 with SMTP id
 d75a77b69052e-4ffb4a6069emr132854621cf.80.1767969753468; Fri, 09 Jan 2026
 06:42:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107104159.3669285-1-edumazet@google.com> <aV7rd0dNS2NBX5b+@pop-os.localdomain>
In-Reply-To: <aV7rd0dNS2NBX5b+@pop-os.localdomain>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 9 Jan 2026 15:42:21 +0100
X-Gm-Features: AQt7F2o-ukhkTOGbsfD-mmCoWDfZCa2VjtdnjOgnEf5NdruhBEcLCwkNDeQvDIM
Message-ID: <CANn89iKNGtyFvWHAB_MnBgF4rKW10OhAGeptkoXWf97LtArGSA@mail.gmail.com>
Subject: Re: [PATCH net] net: add net.core.qdisc_max_burst
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:25=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Wed, Jan 07, 2026 at 10:41:59AM +0000, Eric Dumazet wrote:
> > In blamed commit, I added a check against the temporary queue
> > built in __dev_xmit_skb(). Idea was to drop packets early,
> > before any spinlock was acquired.
> >
> > if (unlikely(defer_count > READ_ONCE(q->limit))) {
> >       kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
> >       return NET_XMIT_DROP;
> > }
> >
> > It turned out that HTB Qdisc has a zero q->limit.
> > HTB limits packets on a per-class basis.
> > Some of our tests became flaky.
>
> Hm, if q->limit is the problem here, why not introduce a new Qdisc
> option for this?

My first patch was using a plain macro.

I think the global switch makes more sense : I do not expect anyone
would need to
tune it, but better be safe than sorry.

A per-qdisc parameter would need iproute2 changes

 A per qdisc attribute would force all iproute2 users to update their scrip=
ts
in case of an emergency.

>
> >
> > Add a new sysctl : net.core.qdisc_max_burst to control
> > how many packets can be stored in the temporary lockless queue.
>
> This becomes global instead of per-Qdisc. If this is intended, you might
> want to document it explicitly in the documentation.

My patch did update Documentation/admin-guide/sysctl/net.rst

Are you thinking of something else ?

An alternative would be to set q->limit to 1000 in HTB only.
And eventually add an TCA_HTB_LIMIT new attribute to tune it.

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index b5e40c51655a731e7c1879e4eb4932b9c1687ea5..7f2402dfb0bfb4e8ee8a07f6d18=
eab0e8555c6d0
100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1059,6 +1059,7 @@ static int htb_init(struct Qdisc *sch, struct nlattr =
*opt,
        bool offload;
        int err;

+       sch->limit =3D 1000;
        qdisc_watchdog_init(&q->watchdog, sch);
        INIT_WORK(&q->work, htb_work_func);

