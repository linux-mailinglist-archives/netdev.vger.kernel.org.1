Return-Path: <netdev+bounces-169403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1007A43B98
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4746D423516
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB0426658B;
	Tue, 25 Feb 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rrq7nidp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9128199931
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478889; cv=none; b=AVcUvndUKNLBxqnacQO3QXtpB0DNUpl98H6ztnXpqwV6dtFlA5buElFy396pLT+ClwMzD53ysHFYCY4EiTXofcyOjdNWaq07PNxecC0SbRkl2TQ5+K+wH4COQSogXOxo9bXrfIIHkQRf6/BnBNz5zp7JKwZ8X/LY6VStVQLqxAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478889; c=relaxed/simple;
	bh=C2oBCIh40Uo2sRbtgS3V2zZY2p3qcwdSfi51JffFrJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzbrPuGXDf81VAmk1xAK9ReWe/9FHgzYj0LWI1GvjcDe6nJ8UVDKgzj4FjZNQOcgfhdCpOniCN8AdYaiAf67XiHZxq/EPAe0ixP394zj6UDONPpV0JcxnOg3aQcv1PpSYoJim3b+fAS1lSDXVq3zDuURysPtayH6Y+rs4necrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rrq7nidp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so10044285a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740478886; x=1741083686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYOhXzCvS79eHMrb8gADmSyJ5Or8uMXx3EEs0rcyef8=;
        b=Rrq7nidpUmEO7wpwMM023kLuk6Et3xoGiU/338d7WU8Vw665gwmerM4ohHyUY2NpjP
         /CsSh82dj67jA8ww25TnMt/oSPtEfnm4Krsyl6BeXmp6A1WC2y54muUZjMQ/FPgesW1+
         QKEXcLnJ5fpLVtdmdRr2bLyySE2Pq4leQ/9qnwiDTIQqCKqRkYG/wLqUR37IZap6E4Ui
         F8saVbGrllTGLC6R0K/ybE1g7U8I84ZQnEVHpOTI8y5N2d9GCvn4EB0aUtjd0EJPeVYY
         7ezYsbqdn6OciAXoLV+1Nd7ZE6RNWVUU7hTJvJCfAS6ufYtnWAu34tjxMfkg914vTuKJ
         R08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478886; x=1741083686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYOhXzCvS79eHMrb8gADmSyJ5Or8uMXx3EEs0rcyef8=;
        b=lqjuw7ErFFWoBqW58opUakd2/8S9uDUOtuSu5fKWH1jPfuIH8OjBMsPBaD7UmLHG3W
         IOLl2c1IYhCxpqntZYBt3xuGxpVKt3k2epz67NYyJ0RgtVS5DXAU4isX4tSZ7RAPFSjJ
         YriHu3SZmuIBjjZvjXas+HtY0Uc59TphkuIlWGa2XsnrbqfyHHgWuVkrUynAlpjKNf2M
         VSplRCH3ZMShi0cpOdnJ6mfy4bDF/dOBHoH1AazMPa7zRQ6oIoKPuxCQl+xK7NcJ5+YI
         1PnASx4R9KniK4uIfcTYKxxjnKvFaiUpgix8OVkekL/+RUgic65Og1jRGXSicbWj2qgA
         K1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVVdgyVzulqmBA3Z8Xv6+QoxEx/2HUBqhpHsrjJuJupNY8uQlgBegExovxaXinmzTkxNlCEvXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6FTNJoXZ23jYv8cWv7DrcKjR50VNkK1tXIjYjrb0XSAS0rAw
	FOCyM2R7t5laitN0Qzxrdx00rNUwaP1kT7SQp4j+EisVrwKgquYZeNJndf7BxiSu4Kgf4Jz3XF2
	w4up3Pm7zCH3Q6OW8X/6PgedGdJKplrY0R4iA
X-Gm-Gg: ASbGncs7m71sgyWNC79ET1j+M6pmp08BzmzVvMRi93K3ryDVUZuWucnC2dpFyeBMYY2
	hW7H9EZiLTYF1YAG9+GMAK2JD/CtDb9E0gg2lLyIuPbviorPTTjpQsrVkq6xFcxBK/nc8AiLvLO
	5TYVKw0+e3
X-Google-Smtp-Source: AGHT+IExencjeu3IPdOjSQfGC2bxpFY8qFQUPq24NFIQp9PyPsobpRHCFo5zPp2hqzNCZB7GCi/xszck8ci/bfsmR28=
X-Received: by 2002:a05:6402:520d:b0:5d3:d9f5:bf08 with SMTP id
 4fb4d7f45d1cf-5e44448155cmr2383503a12.7.1740478885885; Tue, 25 Feb 2025
 02:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224110654.707639-1-edumazet@google.com> <4f37d18c-6152-42cf-9d25-98abb5cd9584@redhat.com>
 <af310ccd-3b5f-4046-b8d7-ab38b76d4bde@kernel.org> <CANn89iJfXJi7CL2ekBo9Zn9KtVTRxwMCZiSxdC21uNfkdNU1Jg@mail.gmail.com>
 <927c8b04-5944-4577-b6bd-3fc50ef55e7e@kernel.org>
In-Reply-To: <927c8b04-5944-4577-b6bd-3fc50ef55e7e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 11:21:14 +0100
X-Gm-Features: AQ5f1JqlAiB1IILIbCxx_GgyikILffUZf9GqJoyYBZ_jUh6AIMota3zXWcS-YZI
Message-ID: <CANn89iJu5dPMF3BFN7bbNZR-zZF_xjxGqstHucmBc3EvcKZXJw@mail.gmail.com>
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

On Tue, Feb 25, 2025 at 11:19=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Eric,
>
> On 25/02/2025 11:11, Eric Dumazet wrote:
> > On Tue, Feb 25, 2025 at 11:09=E2=80=AFAM Matthieu Baerts <matttbe@kerne=
l.org> wrote:
> >>
> >> Hi Paolo, Eric,
> >>
> >> On 25/02/2025 10:59, Paolo Abeni wrote:
> >>> On 2/24/25 12:06 PM, Eric Dumazet wrote:
> >>>> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS=
,
> >>>> for flows using TCP TS option (RFC 7323)
> >>>>
> >>>> As hinted by an old comment in tcp_check_req(),
> >>>> we can check the TSecr value in the incoming packet corresponds
> >>>> to one of the SYNACK TSval values we have sent.
> >>>>
> >>>> In this patch, I record the oldest and most recent values
> >>>> that SYNACK packets have used.
> >>>>
> >>>> Send a challenge ACK if we receive a TSecr outside
> >>>> of this range, and increase a new SNMP counter.
> >>>>
> >>>> nstat -az | grep TcpExtTSECR_Rejected
> >>>> TcpExtTSECR_Rejected            0                  0.0
> >>
> >> (...)
> >>
> >>> It looks like this change causes mptcp self-test failures:
> >>>
> >>> https://netdev-3.bots.linux.dev/vmksft-mptcp/results/6642/1-mptcp-joi=
n-sh/stdout
> >>>
> >>> ipv6 subflows creation fails due to the added check:
> >>>
> >>> # TcpExtTSECR_Rejected            3                  0.0
> >>
> >> You have been faster to report the issue :-)
> >>
> >>> (for unknown reasons the ipv4 variant of the test is successful)
> >>
> >> Please note that it is not the first time the MPTCP test suite caught
> >> issues with the IPv6 stack. It is likely possible the IPv6 stack is le=
ss
> >> covered than the v4 one in the net selftests. (Even if I guess here th=
e
> >> issue is only on MPTCP side.)
> >
> >
> > subflow_prep_synack() does :
> >
> >  /* clear tstamp_ok, as needed depending on cookie */
> > if (foc && foc->len > -1)
> >      ireq->tstamp_ok =3D 0;
> >
> > I will double check fastopen code then.
>
> Fastopen is not used in the failing tests. To be honest, it is not clear
> to me why only the two tests I mentioned are failing, they are many
> other tests using IPv6 in the MP_JOIN.

Yet, clearing tstamp_ok might be key here.

Apparently tcp_check_req() can get a non zero tmp_opt.rcv_tsecr even
if tstamp_ok has been cleared at SYNACK generation.

I would test :

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a87ab5c693b524aa6a324afe5bf5ff0498e528cc..0ed27f5c923edafdf4891960049=
1eb1cb50bc913
100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -674,7 +674,8 @@ struct sock *tcp_check_req(struct sock *sk, struct
sk_buff *skb,
                if (tmp_opt.saw_tstamp) {
                        tmp_opt.ts_recent =3D READ_ONCE(req->ts_recent);
                        if (tmp_opt.rcv_tsecr) {
-                               tsecr_reject =3D !between(tmp_opt.rcv_tsecr=
,
+                               if (inet_rsk(req)->tstamp_ok)
+                                       tsecr_reject =3D
!between(tmp_opt.rcv_tsecr,

tcp_rsk(req)->snt_tsval_first,

READ_ONCE(tcp_rsk(req)->snt_tsval_last));
                                tmp_opt.rcv_tsecr -=3D tcp_rsk(req)->ts_off=
;

