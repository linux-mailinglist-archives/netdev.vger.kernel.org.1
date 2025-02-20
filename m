Return-Path: <netdev+bounces-167988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B09A3D079
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 05:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D653A5145
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101A52F852;
	Thu, 20 Feb 2025 04:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz52NvFo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0CE3FD1;
	Thu, 20 Feb 2025 04:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740025854; cv=none; b=t4lvnyTLJzlwFuJSJFrKB2eZrIwT0H14WOXx5EqEAGRSFpL7vPzuVeLqbcE1zZsTu173hZr7/xWDEPt2e54t59PtKbA2g17ZqA7o35l5MvHZiBe3W9Mt4g++ss3dIpU3+aY527lf4qwWpWNa1XC9jilNzzUqtJn2i44UUmaoSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740025854; c=relaxed/simple;
	bh=PTL4DW0ryN/YxCPoZbOPnBzpjwc6PUEOHJdrJB28ALo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lo4Fs/ncrx0yVs+8vVyL9OCb+GYPdG/HQEmDk0ad9DPYeiYhUrdBRuQpVKnsA/qJMImP7UCwF648HnqYWtlJFsw1Qtg961CtHutX0bz3CaLrDSFZjS1UVuo1Asu9tFeETrj6kDhV1CLndgUiS5CC17uiU03LL8cQX1e/JiR7/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz52NvFo; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d284b9734fso4561185ab.2;
        Wed, 19 Feb 2025 20:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740025851; x=1740630651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM5pYm1QCPD/MQVuAfYurtdIOxPeikSDBLRIMom6N/0=;
        b=lz52NvFoBf8fHAsopCibglp/OoYCeQBE6kFek5+ghgNOQE7vnpYxvYk/ajSM9IClyh
         q5tubnyUPdKHkw/DkzaWvFq02p2+d/s9I42fMAq5RNPw6Feceh6m4sGryOzzT0A1Xed8
         xCpyL7YQ5bCXw4/u9bKQlf5aQJulWi03fmRmBP+9v9HmXzOVN0yy3IL5o/J5V+y2dIU/
         sOjwRLKS90WujYof/PmKXhsEPSDGqnHEveFucvqJ2pl6i37DWgyYPXnvWM7yUBvBvCRt
         G+O+ItJV208YulrEq7kxl9KaYH5XOxS3OdtJ4PCuk1DzDaM7v7xuSGTaqD87wm8JmOID
         O6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740025851; x=1740630651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qM5pYm1QCPD/MQVuAfYurtdIOxPeikSDBLRIMom6N/0=;
        b=FaIKZwIaYIWY5KtYyjTsD5XR3PFy3tXVXGG67IF7nyS97Eqj6HLkOWqDrclD6JplpA
         MYrxP9J15DJOmOkZTC9+08Bik8pGEdJVu7I+KaV4aOuQTAuSQQwWFj/0apgkIu0DLdtw
         lCTUpkcS2x1XE4dTtWfgJ55ECKJMvNB/WqyVjXbu/UD6+S8NxuNNC8ih34trrCSwr+jx
         X+z7jTTYNxr2cHxgGIjM0jHlD58uhzwnwUKvrHYhzRWLjFNoMi85v/KeZOVB9YS6iZuM
         Of4tqyMWGGD3eDWQ/2bLyp/H/g1Osmq76K+mqRwkkOMSZCckFGdSKbYV0hKvVhNRPMUi
         o7gw==
X-Forwarded-Encrypted: i=1; AJvYcCX+mSxZt04Q1SYvU23oizEHa5BnL9zqczET+06fBTI81Ivbl15svOPHyIPXMJOsepFov1hDYgNd@vger.kernel.org, AJvYcCXomXdASnhV0HijdPFUob0cKyHCGrIRI4YIKCwADuHrMet7t3pH2oYZt0qRH1BJ+JqIN/pM6orNXeq3TILtoxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkuoCAaLmyptXKmX1RTkw0bBs1t4UpnzF36w/IQ0I9oPk/ud8k
	28rletXHU/9sC9bviCIDi5rGsc5NuVUpF1KoGDREjTiph060LrwSUh0uYDwzzRkKdBmFyb6vEbl
	XCGOLV5027FqPVvuvmcX3SKAPbXSasAFcZY2gjMH/
X-Gm-Gg: ASbGnctpxrgyXEBHdMVh/y8/buw5oF0UnWtlyBWOk1n/mHX+Z6JuV2m9R7/5k1i5eOM
	9rso043b4hUT6j1U3yv+JQv4qt13NZgT/PcREdrNTRB8upjQD03iRpb1xquO7tT4AUWZcVxEB
X-Google-Smtp-Source: AGHT+IGwBjNFQvhpIRAaHS8B4yiJ/mHxPG9z1y4l1P8QXWzmRtUCw0nTO6jMVLH1Q0ytyHV9uUbrrmjADQRdFNvHnjo=
X-Received: by 2002:a92:c24f:0:b0:3d0:4e57:bbe3 with SMTP id
 e9e14a558f8ab-3d2c24dbb34mr9933505ab.4.1740025851240; Wed, 19 Feb 2025
 20:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739988644.git.pav@iki.fi> <b278a4f39101282e2d920fed482b914d23ffaac3.1739988644.git.pav@iki.fi>
 <CAL+tcoBxtxCT1R8pPFF2NvDv=1PKris1Gzg-acfKHN9qHr7RFA@mail.gmail.com> <67b694f08332c_20efb029434@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b694f08332c_20efb029434@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 12:30:14 +0800
X-Gm-Features: AWEUYZkch07W90CvEFg9UMT23Cw8S6yAxbpfbluvG22mLEFuhXNxX2BlWOUy17s
Message-ID: <CAL+tcoDJAYDce6Ud49q1+srq-wJ=04JxMm1w-Yzcdd1FGE3U7g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:35=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Thu, Feb 20, 2025 at 2:15=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timesta=
mp
> > > when hardware reports a packet completed.
> > >
> > > Completion tstamp is useful for Bluetooth, as hardware timestamps do =
not
> > > exist in the HCI specification except for ISO packets, and the hardwa=
re
> > > has a queue where packets may wait.  In this case the software SND
> > > timestamp only reflects the kernel-side part of the total latency
> > > (usually small) and queue length (usually 0 unless HW buffers
> > > congested), whereas the completion report time is more informative of
> > > the true latency.
> > >
> > > It may also be useful in other cases where HW TX timestamps cannot be
> > > obtained and user wants to estimate an upper bound to when the TX
> > > probably happened.
> > >
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >
> > > Notes:
> > >     v4: changed SOF_TIMESTAMPING_TX_COMPLETION to only emit COMPLETIO=
N
> > >         together with SND, to save a bit in skb_shared_info.tx_flags
> > >
> > >         As it then cannot be set per-skb, reject setting it via CMSG.
> > >
> > >  Documentation/networking/timestamping.rst | 9 +++++++++
> > >  include/uapi/linux/errqueue.h             | 1 +
> > >  include/uapi/linux/net_tstamp.h           | 6 ++++--
> > >  net/core/sock.c                           | 2 ++
> > >  net/ethtool/common.c                      | 1 +
> > >  5 files changed, 17 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/networking/timestamping.rst b/Documentatio=
n/networking/timestamping.rst
> > > index 61ef9da10e28..5034dfe326c0 100644
> > > --- a/Documentation/networking/timestamping.rst
> > > +++ b/Documentation/networking/timestamping.rst
> > > @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
> > >    cumulative acknowledgment. The mechanism ignores SACK and FACK.
> > >    This flag can be enabled via both socket options and control messa=
ges.
> > >
> > > +SOF_TIMESTAMPING_TX_COMPLETION:
> > > +  Request tx timestamps on packet tx completion, for the packets tha=
t
> > > +  also have SOF_TIMESTAMPING_TX_SOFTWARE enabled.  The completion
> >
> > Is it mandatory for other drivers that will try to use
> > SOF_TIMESTAMPING_TX_COMPLETION in the future? I can see you coupled
> > both of them in hci_conn_tx_queue in patch [2/5]. If so, it would be
> > better if you add the limitation in sock_set_timestamping() so that
> > the same rule can be applied to other drivers.
> >
> > But may I ask why you tried to couple them so tight in the version?
> > Could you say more about this? It's optional, right? IIUC, you
> > expected the driver to have both timestamps and then calculate the
> > delta easily?
>
> This is a workaround around the limited number of bits available in
> skb_shared_info.tx_flags.

Oh, I'm surprised I missed the point even though I revisited the
previous discussion.

Pauli, please add the limitation when users setsockopt in
sock_set_timestamping() :)

>
> Pauli could claim last available bit 7.. but then you would need to
> find another bit for SKBTX_BPF ;)

Right :D

>
> FWIW I think we could probably free up 1 or 2 bits if we look closely,
> e.g., of SKBTX_HW_TSTAMP_USE_CYCLES or SKBTX_WIFI_STATUS.

Good. Will you submit a patch series to do that, or...?

>
> But given that two uses for those bits are in review at the same time,
> I doubt that this is the last such feature that is added.
>
> This workaround is clever. Only, we're leaking implementation
> limitations into the API, making it API non-uniform and thus more
> complex.

Probably not a big deal because previously OPT_ID_TCP is also bound with OP=
T_ID?

>
> On the one hand, the feature should work just like all the existing
> ones, and thus be configurable independently, and maintaining a
> consistent API. But, this does require a tx_flags bit. And the
> same for each subsequent such feature that gets proposed.
>
> On the other, if we can anticipate more such additional requests,
> then perhaps it does make sense to use only one bit in the skb to
> encode whether the skb is sampled (in this case SKBTX_SW_TSTAMP),
> and use per-socket sk_tsflags to encode which types of timestamps
> to generate for such sampled packets.

Very good idea, I think.

>
> This is more or less how sampling in the new BPF mode works too.
>
> It is just not how SO_TIMESTAMPING works for existing bits.

If needed, especially when a new bit is added, I think we can refactor
this part in the future? Or can we adjust it in advance? Speaking of
the design itself, it's really good :)

Thanks,
Jason

>
>
> There's something to be said for either approach IMHO.

