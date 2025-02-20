Return-Path: <netdev+bounces-168182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DF4A3DECE
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9A11890CA3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBDC1DF754;
	Thu, 20 Feb 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fARdf2H/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3D34CF5;
	Thu, 20 Feb 2025 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065867; cv=none; b=uncF2me79blpbNHJkW8L7FyiHLZ8d6nyxg3cXLZdWDW1KO6//LThzpcT8pzV6v1ygtnIMcmovB/XO5vs4boWr69ottA9+U0oDIQjzAStz2vdKxH6eT02c6rz4GhywaSu++r9qaa5JNviRld6/pO0bkA/Zzel85Z2alRIdJ/feRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065867; c=relaxed/simple;
	bh=gm3aT3xJVEcevHDKRS9IHv0+hwhWj93Qnf9MQrTOnC4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aQlbcD3jeILcdGne8H9tEag5KZ4H0slbMkJFcfegY3pR74gPS8NgMAMzFpOrYLSLqXQMHP64THrKy+OM39wS77xcE4wdHSFFGjIjWT9/N8Dc631r1usQOoPTBfnSDph9ATsotGbU6MvRO2EpYqjtOCFB38QE2f1nWh64i9fQJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fARdf2H/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e66b4607d2so4967926d6.3;
        Thu, 20 Feb 2025 07:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740065865; x=1740670665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jjwxgX319lQAURpDXqm+mW4q3CD+FIioQogSlas3Qg=;
        b=fARdf2H/SrA8NDiixGVpaCe4JzZmgEVdLETQGOOTy2Hu6+JPH7tM8UuEeTZXXPteHt
         mrUWzrCm/SmBjVkWiRmp5YO8FnItWQA36hCTgjazBNqa5EeGzFBMoF1l7oTmrvaocbnp
         xWhZgycN/gru6Ss/fmllPWwjr+LTirx9owEL1cXzq68oe7l7+iVBsudoVcAgAcW3QGqZ
         3GavLXNM/K1n8xALBz59wCCCvNRRuQ9YTDaI5YVjB2bmKEeP0PVyWHDqDvlyn3glMZFp
         O9hQsLg5/KSIQu8GV8pPb9TVZJ2PnX0YXiC+oaXzbR6bFX8Z0sVORRjOmkm1LDNDBQlW
         1V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065865; x=1740670665;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5jjwxgX319lQAURpDXqm+mW4q3CD+FIioQogSlas3Qg=;
        b=AWVBn5Mua+P29zzA3Tqgcnrbsu0Dk2b5h9zA9UcIxu7ldM3ETdjO/qhf7Av3zm4625
         qsBNuwo0zyl//HJ7ID5iYpPYxO/dLM0ac8T225AJuXJL4cYfAD+4bnDXECL45vhBgSCE
         Efx3QJW2w19EtUOExb1VbEyl4RvJmzTduIih5aFPuUtdmWchIUh3IV+8o/HyHxKBx2iM
         tVzwioED6z5JYbuCM4iLhgtkv8Nl0r/7sHcRokRDp+XJf+jTszskp4zIbm4JjnoIVWkS
         pQP95Q5wEmYeHlgCk/Y3Da7OVvf7MpBtutmWlKkC22WB3GJPLzzY6uNLNeS3QUgkmvjB
         Z8XA==
X-Forwarded-Encrypted: i=1; AJvYcCVjihs6D3DxVMgtxgybJFpNzIm1hRGBCQ9iyfnqGAuLBxF1Ikx2pYv+35h0savLVeeUWiFRZm9CGKlVE5CUAHk=@vger.kernel.org, AJvYcCWvxOdqngKLS3NLlLKTIpVgGJ79cekxLhszAYlsc7LULMl8UKVtcmfienrDhJYxZU47equb6QaT@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEM0pWrOHAh//mP2gKk6Elcp930rIN0S8wS3mna9RINZcwYzF
	6TKus7y+8haCapP3WmY2WZyaIjQspZ/V49LGrnaY5VX1ji3Pk7c9ljzfRw==
X-Gm-Gg: ASbGnctSSQnEUbvSfoNlr/S4nu90POsvIskQt/mD2quG2YZaIsSMOuWt99OFigLirVN
	hAAaBlKsDM6eXaRrD+AsDQo5KoZJT/INjA7M5i2y4o0PQUV5BO0gc9I4I5iqxz4TBD2HfrwXNeF
	/WDGqrXEMPWKBCU0OOcBSs+hTUoh/wqnj+6qnWPpYV1DnHaZ4kietyMKpEcXA+LvCeQSlmpm2yq
	kT+rMIrjZj3yMa0Ea6blOEg6Cv1hRNKmd7e5yfn5TmfHfgKPeM8BUKVtDk3hQnlZQbTA3VD6KqT
	0yHPp6BG3qw/l83TQal93OP3pcnhZYmM+Zz/RjQyGCbvsmAJFZDFy5ZXl/CSnV8=
X-Google-Smtp-Source: AGHT+IFNcYwibZJc6cPQO5jOQwpypBJP6X5pxLah9EGJwZEZ4iM6H8hAI+imAfB7J0DHetuVxwbVBw==
X-Received: by 2002:ad4:5e87:0:b0:6e6:60f6:56cc with SMTP id 6a1803df08f44-6e697543c30mr79225716d6.26.1740065864703;
        Thu, 20 Feb 2025 07:37:44 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785bdbsm86935476d6.38.2025.02.20.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:37:44 -0800 (PST)
Date: Thu, 20 Feb 2025 10:37:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, 
 linux-bluetooth@vger.kernel.org, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org
Message-ID: <67b74c47c14c7_261ab62943@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDJAYDce6Ud49q1+srq-wJ=04JxMm1w-Yzcdd1FGE3U7g@mail.gmail.com>
References: <cover.1739988644.git.pav@iki.fi>
 <b278a4f39101282e2d920fed482b914d23ffaac3.1739988644.git.pav@iki.fi>
 <CAL+tcoBxtxCT1R8pPFF2NvDv=1PKris1Gzg-acfKHN9qHr7RFA@mail.gmail.com>
 <67b694f08332c_20efb029434@willemb.c.googlers.com.notmuch>
 <CAL+tcoDJAYDce6Ud49q1+srq-wJ=04JxMm1w-Yzcdd1FGE3U7g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Thu, Feb 20, 2025 at 10:35=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Thu, Feb 20, 2025 at 2:15=E2=80=AFAM Pauli Virtanen <pav@iki.fi>=
 wrote:
> > > >
> > > > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software tim=
estamp
> > > > when hardware reports a packet completed.
> > > >
> > > > Completion tstamp is useful for Bluetooth, as hardware timestamps=
 do not
> > > > exist in the HCI specification except for ISO packets, and the ha=
rdware
> > > > has a queue where packets may wait.  In this case the software SN=
D
> > > > timestamp only reflects the kernel-side part of the total latency=

> > > > (usually small) and queue length (usually 0 unless HW buffers
> > > > congested), whereas the completion report time is more informativ=
e of
> > > > the true latency.
> > > >
> > > > It may also be useful in other cases where HW TX timestamps canno=
t be
> > > > obtained and user wants to estimate an upper bound to when the TX=

> > > > probably happened.
> > > >
> > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > ---
> > > >
> > > > Notes:
> > > >     v4: changed SOF_TIMESTAMPING_TX_COMPLETION to only emit COMPL=
ETION
> > > >         together with SND, to save a bit in skb_shared_info.tx_fl=
ags
> > > >
> > > >         As it then cannot be set per-skb, reject setting it via C=
MSG.
> > > >
> > > >  Documentation/networking/timestamping.rst | 9 +++++++++
> > > >  include/uapi/linux/errqueue.h             | 1 +
> > > >  include/uapi/linux/net_tstamp.h           | 6 ++++--
> > > >  net/core/sock.c                           | 2 ++
> > > >  net/ethtool/common.c                      | 1 +
> > > >  5 files changed, 17 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/networking/timestamping.rst b/Document=
ation/networking/timestamping.rst
> > > > index 61ef9da10e28..5034dfe326c0 100644
> > > > --- a/Documentation/networking/timestamping.rst
> > > > +++ b/Documentation/networking/timestamping.rst
> > > > @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
> > > >    cumulative acknowledgment. The mechanism ignores SACK and FACK=
.
> > > >    This flag can be enabled via both socket options and control m=
essages.
> > > >
> > > > +SOF_TIMESTAMPING_TX_COMPLETION:
> > > > +  Request tx timestamps on packet tx completion, for the packets=
 that
> > > > +  also have SOF_TIMESTAMPING_TX_SOFTWARE enabled.  The completio=
n
> > >
> > > Is it mandatory for other drivers that will try to use
> > > SOF_TIMESTAMPING_TX_COMPLETION in the future? I can see you coupled=

> > > both of them in hci_conn_tx_queue in patch [2/5]. If so, it would b=
e
> > > better if you add the limitation in sock_set_timestamping() so that=

> > > the same rule can be applied to other drivers.
> > >
> > > But may I ask why you tried to couple them so tight in the version?=

> > > Could you say more about this? It's optional, right? IIUC, you
> > > expected the driver to have both timestamps and then calculate the
> > > delta easily?
> >
> > This is a workaround around the limited number of bits available in
> > skb_shared_info.tx_flags.
> =

> Oh, I'm surprised I missed the point even though I revisited the
> previous discussion.
> =

> Pauli, please add the limitation when users setsockopt in
> sock_set_timestamping() :)
> =

> >
> > Pauli could claim last available bit 7.. but then you would need to
> > find another bit for SKBTX_BPF ;)
> =

> Right :D
> =

> >
> > FWIW I think we could probably free up 1 or 2 bits if we look closely=
,
> > e.g., of SKBTX_HW_TSTAMP_USE_CYCLES or SKBTX_WIFI_STATUS.
> =

> Good. Will you submit a patch series to do that, or...?

Reclaiming space is really up to whoever needs it.

I'll take a quick look, just to see if there is an obvious path and
we can postpone this whole conversation to next time we need a bit.

> =

> >
> > But given that two uses for those bits are in review at the same time=
,
> > I doubt that this is the last such feature that is added.
> >
> > This workaround is clever. Only, we're leaking implementation
> > limitations into the API, making it API non-uniform and thus more
> > complex.
> =

> Probably not a big deal because previously OPT_ID_TCP is also bound wit=
h OPT_ID?

That is also unfortunate. Ideally we had never needed OPT_ID_TCP.
 =

> >
> > On the one hand, the feature should work just like all the existing
> > ones, and thus be configurable independently, and maintaining a
> > consistent API. But, this does require a tx_flags bit. And the
> > same for each subsequent such feature that gets proposed.
> >
> > On the other, if we can anticipate more such additional requests,
> > then perhaps it does make sense to use only one bit in the skb to
> > encode whether the skb is sampled (in this case SKBTX_SW_TSTAMP),
> > and use per-socket sk_tsflags to encode which types of timestamps
> > to generate for such sampled packets.
> =

> Very good idea, I think.

After giving it some thought, I prefer the first option to maintain
the same API. Let's see if we can harvest a bit and use that for this
new completion point.

> =

> >
> > This is more or less how sampling in the new BPF mode works too.
> >
> > It is just not how SO_TIMESTAMPING works for existing bits.
> =

> If needed, especially when a new bit is added, I think we can refactor
> this part in the future? Or can we adjust it in advance? Speaking of
> the design itself, it's really good :)

We cannot change existing behavior.

> Thanks,
> Jason
> =

> >
> >
> > There's something to be said for either approach IMHO.



