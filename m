Return-Path: <netdev+bounces-230566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F1ABEB26D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AB3735DF15
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4FF32E157;
	Fri, 17 Oct 2025 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNwSmndC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE40258EE9
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724398; cv=none; b=ssY3thT74KMX4xHkre4VEZGL12K1uwBmiAaR1ByCzAsHS2l7QyUdbagwY+aCCoqvbcaQfKarvX5mIXiuBLXgjVnzYZkJiFMvlrfUxPTvwe1rzk6n1jjjq7n159qIISN+juLCb9USi2EMLdCqA1rFaeUCvekJ8UmJybrRxV7F3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724398; c=relaxed/simple;
	bh=RswICkAVP/gJfU84z7sG0RSQkn8OBmkgeH5K1mNTLgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkWiD3TuPHmUkhEfuoAtVPiffeTsVKaCFuGczauzWKSKhlc+jS0x+ChecJv9ekZxNKSIzbKBoY8skV3YB58v8dC0ynvLhw3L+NeYNDf6xuwLdoQrx7eUQyUv7+NF1hQc/YNRoaTQ+jAxx5rNJ7wxK9g1Z2m3ZipDYm9HgljNNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNwSmndC; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c1f61ba98so27113206d6.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760724394; x=1761329194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rif0oa9DkHAZwRALv2degzNg53F1yw0lZ1fMrEk6s1E=;
        b=zNwSmndC1G8BjGCizsb8qzsXiGoY84YbF6A1GNeK0ZVSd9rxTqiFebDxfWSwIp7Go2
         pDqDTpbI1LWJ38YzR14fYjGoxsC3vmHZpb9ulCMC2EpFrd7q1+qZ1nnTQpI+rC55Y6se
         b8XyHmQSrk8QPtGyg4NtBoSqpi06Di5AkANIRU9OSeS90U6kmfKKs6Xg4/3mKQmjWHSj
         FkhmFHbmrzsE3axqYkkahNTr97fL8qovIaJNRcb3QJJq5xhkoY6sOj0ukPP6/eqYk6hu
         zxd9tZ8mts0+jHH6JEJvrrfso/mJ4NzfGske1/o9fNadOKtYWhcpEEyKEOgYGOO7bm6b
         DS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760724394; x=1761329194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rif0oa9DkHAZwRALv2degzNg53F1yw0lZ1fMrEk6s1E=;
        b=wsr0RKb65AiEvtdKISH6HmsAMCowyhXNTgMO+IEZ8W0RcKZ3jVdMin8ngijeip3NhZ
         kySC5pg8Q3wCM34l+gWSMhsMe43KPtdyS3EzYrrHjhk96mLvnukrWxa10yUFzufo2s7M
         1ZmJcC1aCzMwd7LeT4lb6OXHk+QhwS81FwXwkG5Ixm1tQlBFR2eCOnO09OZhKh952ESu
         KFAx5f28NDKrV4uWsyjvFQtuUht3iNDbEgG5up9V/zCvV6SjJQAF3ZJKfpihiZGIcqet
         s9m7uJFIwfuJKYvZ1wcJjXBrsbZViSC8feCSIFEMNMNwjZd/4qO5M/7CMd2BQXtpH20S
         2t9A==
X-Forwarded-Encrypted: i=1; AJvYcCWzIHLqmlDSYTTp40xHtmh6LX4nlAVp00tOscJ73aPObVAXmF8OJKO91Kbhm9WQD8t2bByBax4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD2wFRvJilXXo3xBSng4qgp3oDJ+2gSxVUMqgsWUr1wbJaLglW
	KMhKfVuo4MQX5Df1WgQtQKKXmyMh+1h/Zdh1r9cNBS8D+i4OT1xDPyvQgLOdyEmCRacfXEgjiOa
	8bUdgEhmlzDcoona6/MnErinLakXHNQE8D4bbUQk5
X-Gm-Gg: ASbGnctFJG8VYViTBxMXa0CF1Om6xioSaGxHo6CY1ckkhWCDRhGM4DAXTA9qqBGf/AV
	KmiI6/5NGgyEwlVlt6+oM1vR5pKVZBqd+48wfZtkXd1HkOhP3tNkpceXrVxg+uUx2Pl7YfroIJz
	jYlV0F/BXFQz9rxP5ryM+IUgRxolULFznLSHWXQVo7GtlIE2W9KAmGOOX3fVvdo2CsJhKyT3Ypp
	S1Kk2uDtr4uj00IqMbJwd4olE/BKXfe/985mt8pUKgMYt+diad2dsge4Zk68yY5W5eMpOtjurJl
	jSDJcFY=
X-Google-Smtp-Source: AGHT+IGs9M6rMBKgqyMBA77+Os13P8a0Trwqj3NIUOuVflQK6sbRWDZHMmwlxaaugj3dXHN2eVpH1oOwE0XiM6XeBZg=
X-Received: by 2002:ac8:5d0c:0:b0:4b7:8d26:5068 with SMTP id
 d75a77b69052e-4e89d1d931amr68197211cf.17.1760724393834; Fri, 17 Oct 2025
 11:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CANn89iJwkbxC5HvSKmk807K-3HY+YR1kt-LhcYwnoFLAaeVVow@mail.gmail.com>
 <9d886861-2e1f-4ea8-9f2c-604243bd751b@linux.microsoft.com>
 <CANn89iKwHWdUaeAsdSuZUXG-W8XwyM2oppQL9spKkex0p9-Azw@mail.gmail.com>
 <7bc327ba-0050-4d9e-86b6-1b7427a96f53@linux.microsoft.com> <1d3ac973-7bc7-4abe-9fe2-6b17dbba223b@linux.microsoft.com>
In-Reply-To: <1d3ac973-7bc7-4abe-9fe2-6b17dbba223b@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Oct 2025 11:06:22 -0700
X-Gm-Features: AS18NWD9oOYYHDWUxXoRuwJar8qOGE2ISFfEALKFndeOAt7P5v6X0t3YuKTfx3M
Message-ID: <CANn89iKFsuUnwMb-upqwswrCYaTL-MXVwsQdxFhduZeZRAJZ2A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com, 
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, gargaditya@microsoft.com, 
	ssengar@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 10:41=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> On 08-10-2025 20:58, Aditya Garg wrote:
> > On 08-10-2025 20:51, Eric Dumazet wrote:
> >> On Wed, Oct 8, 2025 at 8:16=E2=80=AFAM Aditya Garg
> >> <gargaditya@linux.microsoft.com> wrote:
> >>>
> >>> On 03-10-2025 21:45, Eric Dumazet wrote:
> >>>> On Fri, Oct 3, 2025 at 8:47=E2=80=AFAM Aditya Garg
> >>>> <gargaditya@linux.microsoft.com> wrote:
> >>>>>
> >>>>> The MANA hardware supports a maximum of 30 scatter-gather entries
> >>>>> (SGEs)
> >>>>> per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds
> >>>>> this
> >>>>> limit, the driver drops the skb. Add a check in mana_start_xmit() t=
o
> >>>>> detect such cases and linearize the SKB before transmission.
> >>>>>
> >>>>> Return NETDEV_TX_BUSY only for -ENOSPC from
> >>>>> mana_gd_post_work_request(),
> >>>>> send other errors to free_sgl_ptr to free resources and record the =
tx
> >>>>> drop.
> >>>>>
> >>>>> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> >>>>> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> >>>>> ---
> >>>>>    drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++
> >>>>> ++----
> >>>>>    include/net/mana/gdma.h                       |  8 +++++-
> >>>>>    include/net/mana/mana.h                       |  1 +
> >>>>>    3 files changed, 29 insertions(+), 6 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/
> >>>>> drivers/net/ethernet/microsoft/mana/mana_en.c
> >>>>> index f4fc86f20213..22605753ca84 100644
> >>>>> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> >>>>> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> >>>>> @@ -20,6 +20,7 @@
> >>>>>
> >>>>>    #include <net/mana/mana.h>
> >>>>>    #include <net/mana/mana_auxiliary.h>
> >>>>> +#include <linux/skbuff.h>
> >>>>>
> >>>>>    static DEFINE_IDA(mana_adev_ida);
> >>>>>
> >>>>> @@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff
> >>>>> *skb, struct net_device *ndev)
> >>>>>           cq =3D &apc->tx_qp[txq_idx].tx_cq;
> >>>>>           tx_stats =3D &txq->stats;
> >>>>>
> >>>>> +       BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES !=3D
> >>>>> MANA_MAX_TX_WQE_SGL_ENTRIES);
> >>>>> +       #if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
> >>>>> +               if (skb_shinfo(skb)->nr_frags + 2 >
> >>>>> MANA_MAX_TX_WQE_SGL_ENTRIES) {
> >>>>> +                       netdev_info_once(ndev,
> >>>>> +                                        "nr_frags %d exceeds max
> >>>>> supported sge limit. Attempting skb_linearize\n",
> >>>>> +                                        skb_shinfo(skb)->nr_frags)=
;
> >>>>> +                       if (skb_linearize(skb)) {
> >>>>
> >>>> This will fail in many cases.
> >>>>
> >>>> This sort of check is better done in ndo_features_check()
> >>>>
> >>>> Most probably this would occur for GSO packets, so can ask a softwar=
e
> >>>> segmentation
> >>>> to avoid this big and risky kmalloc() by all means.
> >>>>
> >>>> Look at idpf_features_check()  which has something similar.
> >>>
> >>> Hi Eric,
> >>> Thank you for your review. I understand your concerns regarding the u=
se
> >>> of skb_linearize() in the xmit path, as it can fail under memory
> >>> pressure and introduces additional overhead in the transmit path. Bas=
ed
> >>> on your input, I will work on a v2 that will move the SGE limit check=
 to
> >>> the ndo_features_check() path and for GSO skbs exceding the hw limit
> >>> will disable the NETIF_F_GSO_MASK to enforce software segmentation in
> >>> kernel before the call to xmit.
> >>> Also for non GSO skb exceeding the SGE hw limit should we go for usin=
g
> >>> skb_linearize only then or would you suggest some other approach here=
?
> >>
> >> I think that for non GSO, the linearization attempt is fine.
> >>
> >> Note that this is extremely unlikely for non malicious users,
> >> and MTU being usually small (9K or less),
> >> the allocation will be much smaller than a GSO packet.
> >
> > Okay. Will send a v2
> Hi Eric,
> I tested the code by disabling GSO in ndo_features_check when the number
> of SGEs exceeds the hardware limit, using iperf for a single TCP
> connection with zerocopy enabled. I noticed a significant difference in
> throughput compared to when we linearize the skbs.
> For reference, the throughput is 35.6 Gbits/sec when using
> skb_linearize, but drops to 6.75 Gbits/sec when disabling GSO per skb.

You must be doing something very wrong.

Difference between TSO and non TSO should not be that high.

ethtool -K eth0 tso on
netperf -H tjbp27
MIGRATED TCP STREAM TEST from ::0 (::) port 0 AF_INET6 to
tjbp27.prod.google.com () port 0 AF_INET6
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

540000 262144 262144    10.00    92766.69


ethtool -K eth0 tso off
netperf -H tjbp27
MIGRATED TCP STREAM TEST from ::0 (::) port 0 AF_INET6 to
tjbp27.prod.google.com () port 0 AF_INET6
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

540000 262144 262144    10.00    52218.97

Now if I force linearization, you can definitely see the very high
cost of the copies !

ethtool -K eth1 sg off
tjbp26:/home/edumazet# ./netperf -H tjbp27
MIGRATED TCP STREAM TEST from ::0 (::) port 0 AF_INET6 to
tjbp27.prod.google.com () port 0 AF_INET6
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

540000 262144 262144    10.00    16951.32

>
> Hence, We propose to  linearizing skbs until the first failure occurs.

Hmm... basically hiding a bug then ?

> After that, we switch to a fail-safe mode by disabling GSO for SKBs with
>   sge > hw limit using the ndo_feature_check implementation, while
> continuing to apply  skb_linearize() for non-GSO packets that exceed the
> hardware limit. This ensures we remain on the optimal performance path
> initially, and only transition to the fail-safe path after encountering
> a failure.

Please post your patch (adding the check in ndo_features_check()),
perhaps one of us is able to help.

