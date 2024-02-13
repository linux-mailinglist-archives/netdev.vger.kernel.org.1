Return-Path: <netdev+bounces-71467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FB185370F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADAF1C2370C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407475FEF5;
	Tue, 13 Feb 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/GtxxmK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CEE5FDCE
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844627; cv=none; b=cfz96K1epxiLttDsA9Mtx7l+Kd4ZkPMVbnLJuEVmEtmZy8YLy18AiVlZ/uJ+ezPk7ZksDOHYN8g2WBsb4pB6jdV+vCZ11lFntaYYTib7FhupjMSEopg92T5oth/cgqYcl2y3lnZ+hzZjn2bbjEmLdifXF8ZLlZTx2GvZhD42kkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844627; c=relaxed/simple;
	bh=RwgOnebiOoWfdzI43MFO2xIbGMwDG4vGIZFEKCqL2ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DX9hIhPkM9J1MYeEYr04JYQev9wUPhrR8SowMy4WyOyIGA962uYpw8Ul0NAdXtINU4vN27zTtEugJWEIufEHY/bzIVm93gUhy6xHFdJ89Rcftgr7zeLbev7VqqO26Ec23pZvXZIRA1QnqGBAlk30C/Blh21+lSmClmCsXytjILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/GtxxmK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5114c05806eso7405688e87.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707844623; x=1708449423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hhquAOBQSfxsoPduK/wJPrID2vxSnX36/VY1RnyyOE=;
        b=i/GtxxmK9R73DYKOarKeqegDsiuqBWALs4gAeoX4Ie5YD+W5KXaL+6XhD77gMmX9x6
         RbANZlE9Fzm1K9KdELJWvs0MMtKjYRYC2wKZUUx0i/SGBb+0AlBka3aIFjTDuGVdIk8j
         K0vI1ekziAVVWfTNx18eBUURHVHlXwAyAHMLGAyvdboTxKeuP9LRbYabApkAbcgMJA4M
         BzF6IR4FtUtLbW37pRkCRil1eHxfw8H2vZC8n4HokqT8JBdTWTUk/igvownYh2BsqGNO
         C0TeeKz3iCjMGuxjp7wYZ9r1MAkyJhPjYZmAVcZLg1LK23Kl2aI3W1Qh5eIKELDEyS25
         W1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844623; x=1708449423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hhquAOBQSfxsoPduK/wJPrID2vxSnX36/VY1RnyyOE=;
        b=dZOqHRh8bxBxxJMyI5x6w1RXK1ajxKcnkd/d9ULIbN0QWbHMmPEJOPY6DWxz8Ivb86
         VpOigWCUMTcVvUPWSE2RGx9DUMX/aeT4l6gcMBnkRMrIr80jnJCzbDMmOPrDDuW/NkmS
         MiTVNBoW+SlesmwhbU4dWGdm3pY+cvcfY8Y8pEfJHp2ZuA0Mo4duALHkCKT1z5fgCUhL
         EuF/imv+JMHwYAr5dHuXFGTjG6Ngq8zHGktmenuJekyOsHJxfzloYNdJQETYLa2hGsJe
         ouUaSfcSKplduwKbIGU68yIaAypxkUd1Y5yiO0qYM8Ncm9kyrUondyQUjvRRvu6LuQv1
         o7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXQtmvgiEK6GWXrNC6RKAYZcEhYHFlF/NDwJpsMAI3J7t4utXQ6bNvzWDEOYJqnNrluOzwXZP9tSLoXb5TPI3O4kvuXdz0M
X-Gm-Message-State: AOJu0Yx5711L1Uc6gS8FNihuQjwVnU2lYynhD624sPuZ2Y4TxV4HGCig
	j2PC0CLLznIjTXiIiUBcL2cefGq6eZ+6U5IGCQKh9At3HjehsDgh6DdezvFK4ffxkPyhVCHr0nM
	MlnN08mJa3pk+f7Ga7/QutjcwSoM=
X-Google-Smtp-Source: AGHT+IFf9TagjVwdfZYoqaZDrqpMawlvi606WrbOta7ql1hUXw+2yumNSpNfpqmQfZ/4HYjOPbn47bm7GvqWMN1f0PQ=
X-Received: by 2002:a05:6512:b95:b0:511:6fe4:efdd with SMTP id
 b21-20020a0565120b9500b005116fe4efddmr162964lfv.5.1707844623550; Tue, 13 Feb
 2024 09:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213134205.8705-1-kerneljasonxing@gmail.com>
 <20240213134205.8705-2-kerneljasonxing@gmail.com> <CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com>
In-Reply-To: <CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Feb 2024 01:16:27 +0800
Message-ID: <CAL+tcoCs2u9eR5WXGsnCmsORWCXsNgTXq4q1uRupBqJ8s7NuGA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/5] tcp: add dropreasons definitions and
 prepare for cookie check
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:24=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Feb 13, 2024 at 2:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Only add five drop reasons to detect the condition of skb dropped
> > in cookie check for later use.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > --
> > v2
> > Link: https://lore.kernel.org/netdev/20240212172302.3f95e454@kernel.org=
/
> > 1. fix misspelled name in kdoc as Jakub said
> > ---
> >  include/net/dropreason-core.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index 6d3a20163260..065caba42b0b 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -6,6 +6,7 @@
> >  #define DEFINE_DROP_REASON(FN, FNe)    \
> >         FN(NOT_SPECIFIED)               \
> >         FN(NO_SOCKET)                   \
> > +       FN(NO_REQSK_ALLOC)              \
> >         FN(PKT_TOO_SMALL)               \
> >         FN(TCP_CSUM)                    \
> >         FN(SOCKET_FILTER)               \
> > @@ -43,10 +44,12 @@
> >         FN(TCP_FASTOPEN)                \
> >         FN(TCP_OLD_ACK)                 \
> >         FN(TCP_TOO_OLD_ACK)             \
> > +       FN(COOKIE_NOCHILD)              \
> >         FN(TCP_ACK_UNSENT_DATA)         \
> >         FN(TCP_OFO_QUEUE_PRUNE)         \
> >         FN(TCP_OFO_DROP)                \
> >         FN(IP_OUTNOROUTES)              \
> > +       FN(IP_ROUTEOUTPUTKEY)           \
> >         FN(BPF_CGROUP_EGRESS)           \
> >         FN(IPV6DISABLED)                \
> >         FN(NEIGH_CREATEFAIL)            \
> > @@ -54,6 +57,7 @@
> >         FN(NEIGH_QUEUEFULL)             \
> >         FN(NEIGH_DEAD)                  \
> >         FN(TC_EGRESS)                   \
> > +       FN(SECURITY_HOOK)               \
> >         FN(QDISC_DROP)                  \
> >         FN(CPU_BACKLOG)                 \
> >         FN(XDP)                         \
> > @@ -71,6 +75,7 @@
> >         FN(TAP_TXFILTER)                \
> >         FN(ICMP_CSUM)                   \
> >         FN(INVALID_PROTO)               \
> > +       FN(INVALID_DST)                 \
>
> We already have  SKB_DROP_REASON_IP_OUTNOROUTES ?

Oh right, I will reuse it.

>
> >         FN(IP_INADDRERRORS)             \
> >         FN(IP_INNOROUTES)               \
> >         FN(PKT_TOO_BIG)                 \
> > @@ -107,6 +112,11 @@ enum skb_drop_reason {
> >         SKB_DROP_REASON_NOT_SPECIFIED,
> >         /** @SKB_DROP_REASON_NO_SOCKET: socket not found */
> >         SKB_DROP_REASON_NO_SOCKET,
> > +       /**
> > +        * @SKB_DROP_REASON_NO_REQSK_ALLOC: request socket allocation f=
ailed
> > +        * probably because of no available memory for now
> > +        */
>
> We have SKB_DROP_REASON_NOMEM, I do not think we need to be very precise.
> REQSK are implementation details.

You're right about this.

>
> > +       SKB_DROP_REASON_NO_REQSK_ALLOC,
> >         /** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
> >         SKB_DROP_REASON_PKT_TOO_SMALL,
> >         /** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
> > @@ -243,6 +253,11 @@ enum skb_drop_reason {
> >         SKB_DROP_REASON_TCP_OLD_ACK,
> >         /** @SKB_DROP_REASON_TCP_TOO_OLD_ACK: TCP ACK is too old */
> >         SKB_DROP_REASON_TCP_TOO_OLD_ACK,
> > +       /**
> > +        * @SKB_DROP_REASON_COOKIE_NOCHILD: no child socket in cookie m=
ode
> > +        * reason could be the failure of child socket allocation
>
> This makes no sense to me. There are many reasons for this.

Let me think about a proper new name.

>
> Either the reason is deterministic, or just reuse a generic and
> existing drop_reason that can be augmented later.

I learned that.

Thanks,
Jason

>
> You are adding weak or duplicate drop_reasons, we already have them.

