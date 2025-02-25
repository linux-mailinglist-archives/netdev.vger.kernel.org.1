Return-Path: <netdev+bounces-169409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E6A43BF5
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F010167C2C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F854266B4F;
	Tue, 25 Feb 2025 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icRHCSIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A14266B42
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479889; cv=none; b=EFhSO5m96ZVhX+y0+3NEaki3iPKD6wHgDkmUk+Ps1sejZZnvXAh0JPd4PaQdsTikfK/wslIuukKCFaTIYBybRwMEgJZpSEVKJIBF1A11SEpI57JJfa3BG6kPDMNzNKQeGEA1nqk2x8XEQbUub7GLolGY+BHS/ZtTjb625xKfidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479889; c=relaxed/simple;
	bh=3o81t6aSt9iaeu3G+ZXcCZ0hnNx0NxoqRPLQZckctcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsF5EMB5us+9mpX8vp27kdaG1/C7GZpqsDzNRKwTS5ucmfzR9ozKG2vQcHxDxEis/wRwiMBI88DX4+ooUeUqIJM0DX2h2xNo7RZ1SuTB289k8g2kfEec39hqFBSVIguWozaCGATvmvmCr1bxhhKnrTtemPQJ9xxtGerw2Jqn/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icRHCSIG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso9742045a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740479885; x=1741084685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cb6K165bx10WbLDn3lY0OnmhH8Le1uGGJO42lwqlNY=;
        b=icRHCSIGIHmJwfQs+91LZcNFmEylXwLb0ik/hmJKgqqY4sWHsm4fcBNuNgFmm6tPXc
         PbTD4hCadM1IK9JxH5B6KE3CbSmGxZAOb6NzbKycNRuyRaIwAIJJitcsLvH6oVtMVGat
         gTy8pKN2hb+QTk+1a2PfXsUO+QnEpN3J0wAY0KQf3FIaxbP2w+zvOH0Vi+bIU4RIODG6
         fdOD/xR2SRc6s+HPUfiz9HEytkyF7SBgTB5Szt6BNIPFDUVw494BsEfwG26jt9mGjXH0
         R608fv+zb47ac5nuu+AstlqmZJZ14iPPM0e7qGstKW7Hb/c3M7hBLv2ZmEeUbXtmii6V
         TG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479885; x=1741084685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cb6K165bx10WbLDn3lY0OnmhH8Le1uGGJO42lwqlNY=;
        b=ECcPknRiVseOb5AObn04MgATwd30jcyHK5ckNnz07y7W5nkPSikxsfM3oebaf9mE28
         xdeNzs33xXY8/LFkFCELTChzqOppL5Z8lfGSKStnCjKcqAT6bZNW7w+ir3z+AsKMoT7I
         q0Y1QFxKeI98ERanWSbDsXU6KPtWIfRtnb97ElyEXdL/mqfSn1NJbpggO/n0V+26Mzud
         g7Wmyz4EbgWTXE7w5HcDeswfZDofzm2eLyZtZD+kN5tcK6vmWXf8A/vP4jSsRZwVamEP
         2fJ6/3sgAs2lYDwqiocPBwQsDzFhieUWAkfWExcYLS+dBb+0bcmcn7zLA+WX7D5f5q+A
         K3BA==
X-Forwarded-Encrypted: i=1; AJvYcCWkCBWzZDznp2OD0KU8SAmEJZbF/EjUSxwI/VAoJFcXZ90XoRxTqX3iZWIu2J0iJsi0ZFkXDbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl2IE1/NpMC1mPqPrSUkTxq+groI4Ww6hYem56dm2FXnzXS3w7
	GH1r9e8m/n23xWxk303cq/Ma4DOwXnCblwi0pecqVRLVoCVlUToEa2lgDfYbTTyyfOWc9wv3xlX
	QrZtwGg91TO1Af97xA3CI/7WzMjflBs2D3ZIW
X-Gm-Gg: ASbGncshP3jXiJlzUkxRSrqzh8MOQs34359pVguTAVi32bykK9oUQtfhoAk5uC3Ascu
	N58MNr+KXwnkqBA0UVFICssoTaTcs/paK38rJEOnj9yM7DZpEgRMUod4Mkcg/37I0cgQCV/29Br
	WQCauQfPDH
X-Google-Smtp-Source: AGHT+IGMQUGMC+ji8hFvWjOuzCr03JwEZBIvXNAXLJKOHWemDO522DYYihsCbZyji8vmgtiLkHTzj3Yve2UKq7mokn8=
X-Received: by 2002:a05:6402:208a:b0:5e0:2e70:c2af with SMTP id
 4fb4d7f45d1cf-5e44a2545e5mr2171691a12.26.1740479885175; Tue, 25 Feb 2025
 02:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224110654.707639-1-edumazet@google.com> <4f37d18c-6152-42cf-9d25-98abb5cd9584@redhat.com>
 <af310ccd-3b5f-4046-b8d7-ab38b76d4bde@kernel.org> <CANn89iJfXJi7CL2ekBo9Zn9KtVTRxwMCZiSxdC21uNfkdNU1Jg@mail.gmail.com>
 <927c8b04-5944-4577-b6bd-3fc50ef55e7e@kernel.org> <CANn89iJu5dPMF3BFN7bbNZR-zZF_xjxGqstHucmBc3EvcKZXJw@mail.gmail.com>
 <40fcf43d-b9c2-439a-9375-d2ff78be203f@kernel.org>
In-Reply-To: <40fcf43d-b9c2-439a-9375-d2ff78be203f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 11:37:53 +0100
X-Gm-Features: AQ5f1JoyoAMRVaa4v3l-LhkE4mdB7qzO-S1lbxOUFw6xrKvphcriOwpK5DjElnw
Message-ID: <CANn89iLH_SgpWgAXvDjRbpFtVjWS-yLSiX0FbCweWjAJgzaASg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: be less liberal in tsecr received while in
 SYN_RECV state
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Jakub Kicinski <kuba@kernel.org>, 
	Yong-Hao Zou <yonghaoz1994@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:33=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> On 25/02/2025 11:21, Eric Dumazet wrote:
> > On Tue, Feb 25, 2025 at 11:19=E2=80=AFAM Matthieu Baerts <matttbe@kerne=
l.org> wrote:
> >>
> >> Hi Eric,
> >>
> >> On 25/02/2025 11:11, Eric Dumazet wrote:
> >>> On Tue, Feb 25, 2025 at 11:09=E2=80=AFAM Matthieu Baerts <matttbe@ker=
nel.org> wrote:
> >>>>
> >>>> Hi Paolo, Eric,
> >>>>
> >>>> On 25/02/2025 10:59, Paolo Abeni wrote:
> >>>>> On 2/24/25 12:06 PM, Eric Dumazet wrote:
> >>>>>> Yong-Hao Zou mentioned that linux was not strict as other OS in 3W=
HS,
> >>>>>> for flows using TCP TS option (RFC 7323)
> >>>>>>
> >>>>>> As hinted by an old comment in tcp_check_req(),
> >>>>>> we can check the TSecr value in the incoming packet corresponds
> >>>>>> to one of the SYNACK TSval values we have sent.
> >>>>>>
> >>>>>> In this patch, I record the oldest and most recent values
> >>>>>> that SYNACK packets have used.
> >>>>>>
> >>>>>> Send a challenge ACK if we receive a TSecr outside
> >>>>>> of this range, and increase a new SNMP counter.
> >>>>>>
> >>>>>> nstat -az | grep TcpExtTSECR_Rejected
> >>>>>> TcpExtTSECR_Rejected            0                  0.0
> >>>>
> >>>> (...)
> >>>>
> >>>>> It looks like this change causes mptcp self-test failures:
> >>>>>
> >>>>> https://netdev-3.bots.linux.dev/vmksft-mptcp/results/6642/1-mptcp-j=
oin-sh/stdout
> >>>>>
> >>>>> ipv6 subflows creation fails due to the added check:
> >>>>>
> >>>>> # TcpExtTSECR_Rejected            3                  0.0
> >>>>
> >>>> You have been faster to report the issue :-)
> >>>>
> >>>>> (for unknown reasons the ipv4 variant of the test is successful)
> >>>>
> >>>> Please note that it is not the first time the MPTCP test suite caugh=
t
> >>>> issues with the IPv6 stack. It is likely possible the IPv6 stack is =
less
> >>>> covered than the v4 one in the net selftests. (Even if I guess here =
the
> >>>> issue is only on MPTCP side.)
> >>>
> >>>
> >>> subflow_prep_synack() does :
> >>>
> >>>  /* clear tstamp_ok, as needed depending on cookie */
> >>> if (foc && foc->len > -1)
> >>>      ireq->tstamp_ok =3D 0;
> >>>
> >>> I will double check fastopen code then.
> >>
> >> Fastopen is not used in the failing tests. To be honest, it is not cle=
ar
> >> to me why only the two tests I mentioned are failing, they are many
> >> other tests using IPv6 in the MP_JOIN.
> >
> > Yet, clearing tstamp_ok might be key here.
> >
> > Apparently tcp_check_req() can get a non zero tmp_opt.rcv_tsecr even
> > if tstamp_ok has been cleared at SYNACK generation.
>
> Good point. But in the tests, it is not suppose to clear the timestamps.
>
> (Of course, when I take a capture, I cannot reproduce the issue :) )
>
> >
> > I would test :
> >
> > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > index a87ab5c693b524aa6a324afe5bf5ff0498e528cc..0ed27f5c923edafdf489196=
00491eb1cb50bc913
> > 100644
> > --- a/net/ipv4/tcp_minisocks.c
> > +++ b/net/ipv4/tcp_minisocks.c
> > @@ -674,7 +674,8 @@ struct sock *tcp_check_req(struct sock *sk, struct
> > sk_buff *skb,
> >                 if (tmp_opt.saw_tstamp) {
> >                         tmp_opt.ts_recent =3D READ_ONCE(req->ts_recent)=
;
> >                         if (tmp_opt.rcv_tsecr) {
> > -                               tsecr_reject =3D !between(tmp_opt.rcv_t=
secr,
> > +                               if (inet_rsk(req)->tstamp_ok)
> > +                                       tsecr_reject =3D
> > !between(tmp_opt.rcv_tsecr,
> >
> > tcp_rsk(req)->snt_tsval_first,
> >
> > READ_ONCE(tcp_rsk(req)->snt_tsval_last));
> >                                 tmp_opt.rcv_tsecr -=3D tcp_rsk(req)->ts=
_off;
> Thank you for the suggestion. It doesn't look to be that, I can still
> reproduce the issue.
>
> If I print the different TS (rcv, snt first, snt last) when tsecr_reject
> is set, I get this:
>
> [  227.984292] mattt: 2776726299 2776727335 2776727335
> [  227.984684] mattt: 2776726299 2776727335 2776727335
> [  227.984771] mattt: 3603918977 3603920020 3603920020
> [  227.984896] mattt: 3603918977 3603920020 3603920020
> [  230.031921] mattt: 3603918977 3603920020 3603922068
> [  230.032283] mattt: 2776726299 2776727335 2776729383
> [  230.032554] mattt: 2776729384 2776727335 2776729383
>       ack rx                [FAIL] got 0 JOIN[s] ack rx expected 2

req->num_timeout might not be updated where I thought it was.

