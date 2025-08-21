Return-Path: <netdev+bounces-215739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDEAB30168
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F72A16E88B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99081341AD9;
	Thu, 21 Aug 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufjD5Ioc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6428000A
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798402; cv=none; b=W6+BXtEKNDP3Kat3T3Db2oD8SK9rmjio33Rlk3me8j+ql1w9Sk+cY6nXDM/8yiyeY9B97ap9j1ftmc0iClnT/C6mHBJeSB9+AzrFv1zMkTTGZeo16XtGW1N4qeSWuY9Du2UzCVX49pDRe3aB3jDsGaSe1ICdNvYF4uimOqyfA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798402; c=relaxed/simple;
	bh=+6CPkCJkU3jwdrOKTxcDt42eFa4pUWh02uNfZWyKCUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGEi1G6LZF6hLAp1pynEuTQ7JA/o5vlDn8zskMdUyOfqUQOKhMJ0NIiMyYRYUF9FVM1xVAWL3JEZ9IX+9vw/BH48MFip83CVGQ5fxaDdXXfE8PhtHWKr9+cPMrtEXDG5QfdHl3c60nFDWOSevnrfqjU+Z5b+jTzwwHJVBxY4YSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufjD5Ioc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b297962b9cso12755661cf.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755798398; x=1756403198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzrL+hxbYv3dn1xiOMrlh++7JUhUx/rmU8UbpYquXTw=;
        b=ufjD5Ioc6f3aeem10cQp6hRCB3ScljLN/y+3d2qWbFN9Eimq8y+FWt+QtvVmXw9dA4
         opeulrOPmQX5n/mFtbIL/TGlMlZbnTUNNxB6KW6NoHeNABHeSUynR/TgbIGoe2x4zCI6
         nvopJFZyGt9f6xVR3CQ6tv4ba4GsIlScUEt2kQtHgO9bK/3yrzBsOK6NfZlkRf7O4/ut
         EqJ9vy9ofIhpmGP3KAjUpbQjMUKP8Pc+HiXVaCxnU2m2kb6QMiPr5JJGGhibv43aZ1Yd
         tPpr2o+f7YA7GJ8tiVAI7LiTSl9p8BZHc4RputahW2t/HP5d75rCiZ0gDvsgP6mZqPdd
         3o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755798398; x=1756403198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzrL+hxbYv3dn1xiOMrlh++7JUhUx/rmU8UbpYquXTw=;
        b=dTqpVKhx4SqT+DDLdcQUjWgXxzk1j64j2MwJPIYc/M46cDyY3EQPR3d+5Jv/PY4MNl
         aUVTzSCEbztzcH1s0w9L3DagTddsy4vQ9ht6Nz04XE6nxijUkYFcPOiVLFzWdbOZjaZ0
         e47pqT5MFlOpvZi26VmVq3iJB9LmpXa+dOfwYQU3UHeJg8j3Mb7Bu8k9fUAFuvnmbjzS
         BSVVYaqYP+t1cuC8JpSr33RJ5exGPHnMAtZ3vFQN7GYdNepFtJOOzzTotoQa5GeI0E58
         MNFirR/MPTcU7UtrLhyFwfQfxuIIJWhw00sbEcbRoc9u+9RTWZOqOv4CQ5w53UaMP2Ju
         exkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk6XFIYLuDHBq3C0Xz7Olf8LYn/EGK3GvB0ArJ0fmOTqvvFpKLeavA8zbs9PUvp8RemsWsPDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYREDcLYsLArUveqdn5epnYt08/03LY5PRTtixX6BuoePKCUs6
	cqw7s49GrznXnQNWuLBhCmRSRg/u9ogn/deKvaicARvz41BOaV2dZc4ncOZAID5We12UZAlzqz5
	DZqUGTfw9vZD7nI02xWzao9aHzVfi8F3xBM4xKfRn
X-Gm-Gg: ASbGnctMicCKVhOGN2iKCRaRVSy3DvHNGh7D1EN6P8tguxeV3Y0le2dEPY5bYQlZK1Q
	F6S5oxnr/x1DupFGWnPFINqSZm69fGkbQGrAOsG8cA1BIOBjmBlSfbsbV0N+oqkr0rdGkQWz4Su
	Zzg5RtzQqM+ARWdE0/qL9OwxlIiUgYkarSvf5dX2MRLHhqR2sWo0xXqWmqZizr+VHkaIJHwfNq8
	Wlt+unocjyS
X-Google-Smtp-Source: AGHT+IEPW6QZom8xTHjRvXzIsbS/Xb3yKjPQUt3+2w0w7igAKtZFc1SFusSTDUIJPiCoiwOQWVVN1GDfEbX7kTFDR6k=
X-Received: by 2002:a05:622a:4246:b0:4a9:c8e3:a38 with SMTP id
 d75a77b69052e-4b2aaa43606mr2186881cf.30.1755798398051; Thu, 21 Aug 2025
 10:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
 <20250815083930.10547-11-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKPTWBdi8upoxjFok2CPFhkGB9S3crZcefZ0mRhFHGPhQ@mail.gmail.com> <PAXPR07MB798496F6B674558AFD2B1641A332A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB798496F6B674558AFD2B1641A332A@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 10:46:26 -0700
X-Gm-Features: Ac12FXzuY5h4-8nywf9JRUgDh45lUrIesLySxStr10g3ePmx7oNQt6qd-NsptN8
Message-ID: <CANn89iKyU-r93MWukKRh4qPmEgLwSNKudOp_xQ2A6YpaWoUJFw@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 10/14] tcp: accecn: AccECN option
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, Neal Cardwell <ncardwell@google.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 7:58=E2=80=AFAM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
> > -----Original Message-----
> > From: Eric Dumazet <edumazet@google.com>
> > Sent: Thursday, August 21, 2025 2:30 PM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: pabeni@redhat.com; linux-doc@vger.kernel.org; corbet@lwn.net; horms=
@kernel.org; dsahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; ne=
tdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.or=
g; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; =
davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fi=
berby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.ker=
nel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koe=
n.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johans=
son@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.iet=
f@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
> > Subject: Re: [PATCH v15 net-next 10/14] tcp: accecn: AccECN option
> >
> >
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >
> >
> >
> > On Fri, Aug 15, 2025 at 1:40=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.=
com> wrote:
> [...]
> > >  /* Used for make_synack to form the ACE flags */ diff --git
> > > a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h index
> > > bdac8c42fa82..53e0e85b52be 100644
> > > --- a/include/uapi/linux/tcp.h
> > > +++ b/include/uapi/linux/tcp.h
> > > @@ -316,6 +316,13 @@ struct tcp_info {
> > >                                          * in milliseconds, including=
 any
> > >                                          * unfinished recovery.
> > >                                          */
> > > +       __u32   tcpi_received_ce;    /* # of CE marks received */
> > > +       __u32   tcpi_delivered_e1_bytes;  /* Accurate ECN byte counte=
rs */
> > > +       __u32   tcpi_delivered_e0_bytes;
> > > +       __u32   tcpi_delivered_ce_bytes;
> > > +       __u32   tcpi_received_e1_bytes;
> > > +       __u32   tcpi_received_e0_bytes;
> > > +       __u32   tcpi_received_ce_bytes;
> > >  };
> > >
> >
> > We do not add more fields to tcp_info, unless added fields are a multip=
le of 64 bits.
> >
> > Otherwise a hole is added and can not be recovered.
>
> Hi Eric,
>
> Thanks for the feedback.
>
> Then, would it make sense to add __u32 reserved; here or this is not an o=
ption?
>

I would prefer we take the opportunity to export a 32bit field right
there, instead of a hole.

A reserved field makes it difficult for ss commands to know if a new
kernel is using it for a different purpose.

Neal, any idea of what would be useful ?

I was thinking lately of sk_err_soft, but I am not yet convinced.

