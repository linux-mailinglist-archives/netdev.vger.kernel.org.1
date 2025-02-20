Return-Path: <netdev+bounces-167957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49BA3CF68
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDBD1898874
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C9E1D61BB;
	Thu, 20 Feb 2025 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1F/F/RO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E01C6FF0;
	Thu, 20 Feb 2025 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018933; cv=none; b=QjNQIx/ykfzkpL+Eo6qQLlbRQ+bf1CjwqANxdG6xpe3WMPX3uEirPGen83vpWuHcMWQ0P37TIlb1EyZcMFEYzT+/B3/TVWOgUHpNFu3TrnHDFiIhBhBH4XVaonONz+V/Tk2pcO1TaRDTR5ffFV9MRjXiwZZxaTOezmzjHkiHfY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018933; c=relaxed/simple;
	bh=DXHFJ+tOPXcPoGcwm4xRajRbCFSCv9LfVE2LWOEOSIA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PLOVgrxeKYcVcv7AdxeBoW8s00odgzihZBOPVGrSUF3HPkivxZLeGY2u90xuLN5j+IFQyr8qx57qg9xWzEhR5YAwV6OFBz55N/AAO2evy6z6UfDkwFpGbHggN2nEjZdi8wjqO6hqfBFmad2rq5nd+cpgwCgKy5AAgEhg+VNQyb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1F/F/RO; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0a3d6a6e4so42538685a.1;
        Wed, 19 Feb 2025 18:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740018930; x=1740623730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ+p8dbSiIsoyTslXMyurJlydhBLuCYlpN+t/Y0lvCQ=;
        b=O1F/F/RO0aS3h8CvJ1h20Jz9eH9sRybVDLTIxKDsRAtP2D0Q3xCAPxlPwgPQeVTAfD
         Ucl6rrEOjwdeSfZuKdV44SypW6v4QTKamQF1hwLvDtRuWFiqXP22TPlkst8yGA399WtJ
         KvIdsiwEEaAaa2zXuXNFlvjTkHmi6xpuLs+CKz3YovzuTZ6xGMloTc8lrSOMwDZYiczU
         6dDymOum8r/PB/sTgwwFIBTWsjqgfnp+1l32XzB/wsYKBYul0AA0OyF4htQRAGIF2bQp
         w5h5ImJVHGOSA4RX9yCN7p/xPmUDgMoTH2gE67anC0XPucWobAtMEqyB+Zx1kqnHqQ1Y
         nv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740018930; x=1740623730;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AJ+p8dbSiIsoyTslXMyurJlydhBLuCYlpN+t/Y0lvCQ=;
        b=T9chwgAzCQQE0dXanSW7TJo/n8D/M+AkHxBuUh3Z4eoy7Xxgw+vJBK11gKhpt3FjyY
         PouO93EMNPqWFjFCiKnqnMz9U5voFOlr3Z2Os6uPxNsSU4NdW/4ghHQVlEgKTTABVOA7
         LZwHSQrYTgQMX1pluh2IxHzXs8ESwopqCduYi/xJfJd1YruCMNWLNXCt1jFQc7uTMHp1
         KUo2Vd6nhLFSMgDa1ZzMGu+rW4YwC3ZskY2arYg3B1GQXNIlCrdphl9ZPRQJOWKhpryv
         535OsXv7wboUxuboDkQgnnGl5jEM+svlO/3K6wHaUPsGojhw4bbypUke+ZGfQ7l0laBK
         QN+g==
X-Forwarded-Encrypted: i=1; AJvYcCUUUaX7E/oqhNz6OlPIp5dGgXUvMO+ct+8FIMvguY44SUI0RX0ry3Q/N4bpe1rVrJMA3CsjEXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLte4Px8Fc8IGEjX8ymiBorkGsS7I2AIEiEL2kZpx7XA6HFjQH
	PkgUzt8Y9SnQE7MFw6PIznnwPHv3AlNtpULVqBqqUG1hkCGOwlzc
X-Gm-Gg: ASbGncvBBQ8+Ez0WIyLtnKJH3N3XBsINog9gFmtMc50Chqt/ZvC7Lptn8rg3t+HGcb5
	uaXMrLNF1BkUolH2S8TeHqn0z6vcCCei6Y0UF2fMK8SigKm8raiqCPamsJELh8Rr/JdpnyJTiy6
	Mv4qXO4uaD8cvvy//Md46iUp5dfRwlbdLuOUSIOC/cy3oXjMLP/XwBKAoMOFKlMURuXhNh5qWhM
	7OpJjna/GT56paGE9SlUANJuMFnlnPGR72fLJV7zx8uNWCfiAIW0FnOyc2mFYlfnFbySiDfgh67
	18BsbuWRRtjI6Qqeer+E0Udtb7am70unXfvPMwF7nh5T2eXArKsS7TSUKKeVh4c=
X-Google-Smtp-Source: AGHT+IGuMwJjnFEvwQqpT16I0OaADyTAlIJua5xiXGoXZ0/IsVhlkahCISkCXlS92vKIQczHtaX5Pw==
X-Received: by 2002:a05:620a:40d0:b0:7c0:79aa:4706 with SMTP id af79cd13be357-7c0c4376f56mr97560585a.53.1740018929787;
        Wed, 19 Feb 2025 18:35:29 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0c2d9f679sm37840085a.5.2025.02.19.18.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 18:35:28 -0800 (PST)
Date: Wed, 19 Feb 2025 21:35:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <67b694f08332c_20efb029434@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBxtxCT1R8pPFF2NvDv=1PKris1Gzg-acfKHN9qHr7RFA@mail.gmail.com>
References: <cover.1739988644.git.pav@iki.fi>
 <b278a4f39101282e2d920fed482b914d23ffaac3.1739988644.git.pav@iki.fi>
 <CAL+tcoBxtxCT1R8pPFF2NvDv=1PKris1Gzg-acfKHN9qHr7RFA@mail.gmail.com>
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
> On Thu, Feb 20, 2025 at 2:15=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> >
> > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timesta=
mp
> > when hardware reports a packet completed.
> >
> > Completion tstamp is useful for Bluetooth, as hardware timestamps do =
not
> > exist in the HCI specification except for ISO packets, and the hardwa=
re
> > has a queue where packets may wait.  In this case the software SND
> > timestamp only reflects the kernel-side part of the total latency
> > (usually small) and queue length (usually 0 unless HW buffers
> > congested), whereas the completion report time is more informative of=

> > the true latency.
> >
> > It may also be useful in other cases where HW TX timestamps cannot be=

> > obtained and user wants to estimate an upper bound to when the TX
> > probably happened.
> >
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >
> > Notes:
> >     v4: changed SOF_TIMESTAMPING_TX_COMPLETION to only emit COMPLETIO=
N
> >         together with SND, to save a bit in skb_shared_info.tx_flags
> >
> >         As it then cannot be set per-skb, reject setting it via CMSG.=

> >
> >  Documentation/networking/timestamping.rst | 9 +++++++++
> >  include/uapi/linux/errqueue.h             | 1 +
> >  include/uapi/linux/net_tstamp.h           | 6 ++++--
> >  net/core/sock.c                           | 2 ++
> >  net/ethtool/common.c                      | 1 +
> >  5 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/networking/timestamping.rst b/Documentatio=
n/networking/timestamping.rst
> > index 61ef9da10e28..5034dfe326c0 100644
> > --- a/Documentation/networking/timestamping.rst
> > +++ b/Documentation/networking/timestamping.rst
> > @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
> >    cumulative acknowledgment. The mechanism ignores SACK and FACK.
> >    This flag can be enabled via both socket options and control messa=
ges.
> >
> > +SOF_TIMESTAMPING_TX_COMPLETION:
> > +  Request tx timestamps on packet tx completion, for the packets tha=
t
> > +  also have SOF_TIMESTAMPING_TX_SOFTWARE enabled.  The completion
> =

> Is it mandatory for other drivers that will try to use
> SOF_TIMESTAMPING_TX_COMPLETION in the future? I can see you coupled
> both of them in hci_conn_tx_queue in patch [2/5]. If so, it would be
> better if you add the limitation in sock_set_timestamping() so that
> the same rule can be applied to other drivers.
> =

> But may I ask why you tried to couple them so tight in the version?
> Could you say more about this? It's optional, right? IIUC, you
> expected the driver to have both timestamps and then calculate the
> delta easily?

This is a workaround around the limited number of bits available in
skb_shared_info.tx_flags.

Pauli could claim last available bit 7.. but then you would need to
find another bit for SKBTX_BPF ;)

FWIW I think we could probably free up 1 or 2 bits if we look closely,
e.g., of SKBTX_HW_TSTAMP_USE_CYCLES or SKBTX_WIFI_STATUS.



But given that two uses for those bits are in review at the same time,
I doubt that this is the last such feature that is added.

This workaround is clever. Only, we're leaking implementation
limitations into the API, making it API non-uniform and thus more
complex.

On the one hand, the feature should work just like all the existing
ones, and thus be configurable independently, and maintaining a
consistent API. But, this does require a tx_flags bit. And the
same for each subsequent such feature that gets proposed.

On the other, if we can anticipate more such additional requests,
then perhaps it does make sense to use only one bit in the skb to
encode whether the skb is sampled (in this case SKBTX_SW_TSTAMP),
and use per-socket sk_tsflags to encode which types of timestamps
to generate for such sampled packets.

This is more or less how sampling in the new BPF mode works too.

It is just not how SO_TIMESTAMPING works for existing bits.


There's something to be said for either approach IMHO.

