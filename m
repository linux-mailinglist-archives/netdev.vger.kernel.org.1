Return-Path: <netdev+bounces-176556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66819A6AC80
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C841F485F2D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069121E5B88;
	Thu, 20 Mar 2025 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjNQXZ1I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5F2628C;
	Thu, 20 Mar 2025 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493135; cv=none; b=V0I9VJfiyz2H+0nz/a9rHFOMSp+Uc8F3ENI9LImGNH2zuPDqAoqWo73oyY3VSqYGXoJseJXU20aEAgynhXdRe3KR/bI7DxyzXHX0zQOPmpLxsdTv4aJudIoFoLE5C52QHZFdWn6YTnLH5cM/9ABgnTPW7ZUnXkr+NI97QM/KBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493135; c=relaxed/simple;
	bh=sijOHxvBvnq99fvVP5s7Vb4Qc5M38dvJVICqgOF8q7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSQipx9BIL3cVFxM9wiJfNemfz0hmQlsVVMV3aDrnyTpy1TnUo/YrKMl4h0otTlFRA2BpK18xc9p5TQ+xQgt7sFKa4XyY+TzP+dQn7FhYjkBkU+kziE737Qnai6hQ9ssq5ABAFZXHKtb9mYnQgr0Honp7opcI9E3RPSwAmW7y5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjNQXZ1I; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso7537955ab.1;
        Thu, 20 Mar 2025 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742493133; x=1743097933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxRsmOhkKPCbEAb2C7bVczPeQjTFvLVw1BSV4J766rY=;
        b=hjNQXZ1IC7xvfBnXn2AinEMi3kteiEss31aOxsVXYg/3TMay2k37b+r9pTupIbg6h8
         5cU0PSG21pNsqPD1CV9/x3ohBq9FI7fKdthGd6Z6h84WRT38YNU4Uwgex60dnvMDcYkT
         U5dDJOTKQQK1JHd/WRMmp1Q05JML7pIxkZ5hemXzsFLXRM1pkReiOQqWMKnd4pXAPdR4
         6D8OCW7MHe1IPgIXWvVJWOknhOA+Iw8eZWH5NdTxJIKVXsLHHDcIIpxOPL+cqOgiNbtd
         mk2TT4N/0kynWW3TDb3H+cW2WGQB875I66X/qYdi+hXcYTQPdR412i8BdkJ2ObZa6lqP
         jG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493133; x=1743097933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxRsmOhkKPCbEAb2C7bVczPeQjTFvLVw1BSV4J766rY=;
        b=tQQaP2QNyPm3ogXRTDkMHj/U4F1nLUZZShEsBw/EfWIwDbo2JTcVwF1EgiblBHpRZQ
         eAvUSLBMqoLq/PlQIfdtJ+qnx4MH+ZvJZATp85CN9Iuz8UpR/Rew4DbENwr89HxsgVce
         s+3ggleJ2yMdkXNzJDM7sY3mUba1H7TDUV4jiU7c1jT3lou7PDAhT6PTNqQlLRuMzrdT
         /DZPGLdQH1+Gb9EIgi0N3BI0ogI+h6mhRtgFdOtI8abEul/WdcHzValIssceOOJyDeA9
         dqUTSeSVJs6ejeg9l95fa7+2s0SOzngL51SKUTGFQSMaXGU690NBAXys97hy1HgiZovu
         fKdg==
X-Forwarded-Encrypted: i=1; AJvYcCWZs2aPBTh4ZPijooW8BVdsiPHRrnG+M/raV3g93jI5//TXhqjE+wxJhnKh+ZQZPAlfCm3sRmN9V68aa8MR85M=@vger.kernel.org, AJvYcCX794pK9KyQiYkBSjvzKl2oesj7Py6JTznUIYMlIN2JGMgXRMYxm5VUZjmuv2pNIhdAxA6M4mZh@vger.kernel.org
X-Gm-Message-State: AOJu0YyhC27RSIETq9jajud/u31Ewe3AfpjK4S//hTaYFVbac4Y/7gp1
	Vv3zhyiyATOUm8QsDqXI0AXDdIeiQyFK5YsTDki9FL/Dc6/nU0XynuPgCvkzLOorrYwtVG/AHzB
	Que07GBNjxxdLPX7YLalYOnzJlAQ=
X-Gm-Gg: ASbGncvFVr6GqB7MYw8grEt2wsDLYmpPxPkG2tm+8Xq/6nTlq5vIUvB6RVthziIZu7E
	R5Koo5blYUyLODDeZIMr90epkM8fKJp0528DMwvGJMZhFozH2X1Re4pFW45wlPTsTmEzO7PjeNh
	dVcWMkA5QFXjRN4Mbuz6ZcDyrU
X-Google-Smtp-Source: AGHT+IFmZPRxXVjszDQ8nXd6RKpYWI7EBPztPg86XFrb0RaBImzb9h5yJFWQG3PlG7T/Rih7IXlD9sMshVJsHfLoc2k=
X-Received: by 2002:a05:6e02:3207:b0:3d5:890b:8ee with SMTP id
 e9e14a558f8ab-3d5960cd0c6mr4602825ab.2.1742493133174; Thu, 20 Mar 2025
 10:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742324341.git.pav@iki.fi> <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
 <6cf69a7e-da5d-49da-ab05-4523f2914254@molgen.mpg.de> <CABBYNZJk2QjUaJCurAocMAJdOTfFHCjKO_S2rcxWLwTv8K9VDw@mail.gmail.com>
 <12a5ae18f714372681c58247af66b9535a3b4cd6.camel@iki.fi>
In-Reply-To: <12a5ae18f714372681c58247af66b9535a3b4cd6.camel@iki.fi>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 21 Mar 2025 00:51:37 +0700
X-Gm-Features: AQ5f1JpW07ngh8ys0jmzQikU-8lizauiz0ZcUFMrkK--Ese7E320Y0p_bwZ932I
Message-ID: <CAL+tcoAb4z81aBWukkMi9RU=3=6x7wrd0TGJOyjbOVqpGhVnSQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
To: Pauli Virtanen <pav@iki.fi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 21, 2025 at 12:12=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> to, 2025-03-20 kello 10:43 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli, Willem, Jason,
> >
> > On Wed, Mar 19, 2025 at 11:48=E2=80=AFAM Paul Menzel <pmenzel@molgen.mp=
g.de> wrote:
> > >
> > > Dear Pauli,
> > >
> > >
> > > Thank you for your patch. Two minor comments, should you resend.
> > >
> > > You could make the summary/title a statement:
> > >
> > > Add COMPLETION timestamp on packet tx completion
> > >
> > > Am 18.03.25 um 20:06 schrieb Pauli Virtanen:
> > > > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software times=
tamp
> > > > when hardware reports a packet completed.
> > > >
> > > > Completion tstamp is useful for Bluetooth, as hardware timestamps d=
o not
> > > > exist in the HCI specification except for ISO packets, and the hard=
ware
> > > > has a queue where packets may wait.  In this case the software SND
> > > > timestamp only reflects the kernel-side part of the total latency
> > > > (usually small) and queue length (usually 0 unless HW buffers
> > > > congested), whereas the completion report time is more informative =
of
> > > > the true latency.
> > > >
> > > > It may also be useful in other cases where HW TX timestamps cannot =
be
> > > > obtained and user wants to estimate an upper bound to when the TX
> > > > probably happened.
> > > >
> > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > ---
> > > >
> > > > Notes:
> > > >      v5:
> > > >      - back to decoupled COMPLETION & SND, like in v3
> > > >      - BPF reporting not implemented here
> > > >
> > > >   Documentation/networking/timestamping.rst | 8 ++++++++
> > > >   include/linux/skbuff.h                    | 7 ++++---
> > > >   include/uapi/linux/errqueue.h             | 1 +
> > > >   include/uapi/linux/net_tstamp.h           | 6 ++++--
> > > >   net/core/skbuff.c                         | 2 ++
> > > >   net/ethtool/common.c                      | 1 +
> > > >   net/socket.c                              | 3 +++
> > > >   7 files changed, 23 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/Documentation/networking/timestamping.rst b/Documentat=
ion/networking/timestamping.rst
> > > > index 61ef9da10e28..b8fef8101176 100644
> > > > --- a/Documentation/networking/timestamping.rst
> > > > +++ b/Documentation/networking/timestamping.rst
> > > > @@ -140,6 +140,14 @@ SOF_TIMESTAMPING_TX_ACK:
> > > >     cumulative acknowledgment. The mechanism ignores SACK and FACK.
> > > >     This flag can be enabled via both socket options and control me=
ssages.
> > > >
> > > > +SOF_TIMESTAMPING_TX_COMPLETION:
> > > > +  Request tx timestamps on packet tx completion.  The completion
> > > > +  timestamp is generated by the kernel when it receives packet a
> > > > +  completion report from the hardware. Hardware may report multipl=
e
> > >
> > > =E2=80=A6 receives packate a completion =E2=80=A6 sounds strange to m=
e, but I am a
> > > non-native speaker.
> > >
> > > [=E2=80=A6]
> > >
> > >
> > > Kind regards,
> > >
> > > Paul
> >
> > Is v5 considered good enough to be merged into bluetooth-next and can
> > this be send to in this merge window or you think it is best to leave
> > for the next? In my opinion it could go in so we use the RC period to
> > stabilize it.
>
> From my side v5 should be good enough, if we want it now.

Sorry for seeing this too late, I think I miss adding the reviewed-by
tags. Anyway,

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks for working on this!!

>
> The remaining things were:
>
> - Typo in documentation
>
> - Better tx_queue implementation: probably not highly important for
>   these use cases, as queues are likely just a few packets so there
>   will be only that amount of non-timestamped skbs cloned.
>
>   In future, we might consider emitting SCM_TSTAMP_ACK timestamps
>   eg. for L2CAP LE credit-based flow control, and there this would
>   matter more as you'd need to hang on to the packets for a longer
>   time.
>
> - I'd leave handling of unsupported sockcm fields as it is in
>   v5, as BT sockets have also previously just silently ignored
>   them so no change in behavior here.
>
> - BPF: separate patch series, also need the tests for that

Right, I agree :)

Thanks,
Jason

>
> --
> Pauli Virtanen
>

