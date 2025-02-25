Return-Path: <netdev+bounces-169392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9BEA43AE7
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518A07A6182
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EDA26139E;
	Tue, 25 Feb 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhA2ohUn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0613263C86
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478282; cv=none; b=nzE99bTFpfd8xhMFdwBvXfHKIZnuYXIfnD5o2R9hIEzlYiiQm0ZX6QFzMR21H0ql8QQQO5q/fAYRIbBoMfdDSOTw2XahTW7CM4JYTSUGSimrP95aiWS9eZBu1VPq4dhwcPV225pp+n6j4Zx+CbR9oxRmoMFR60wLojgG2sVXVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478282; c=relaxed/simple;
	bh=/TukNZfdZcJnJqlGUTayo+cbdcCXDF60f5HiFsnr8zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snwjOB8OTkW5eo0q2aarlkUJgwu6Pfde+dSJXJaBLCZsu6ABGAW8YFNCxwVrK6Yo8yLUYTtGwPlgqAYE6BM7XC/OJb/kB3hRBUX8cWEp4EAEDjsh5fmxMB7/MiAdmueBEcgiaDubf/9htjVp66HOZgl8sC0sMW9tcCMnZIHf010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhA2ohUn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so8329952a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740478279; x=1741083079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzseC7TE5yROJInpw1BHLRzHMDpvksChoWt2dWl13XA=;
        b=yhA2ohUnx/nTn05oyk/Hl/TBMgZZAJDLv8ioMmwCdtUnXptNPmP1x6cvzMwfT+zYdt
         /Tkvc2nD2OUourZ/7vmbGNo5TdBO7lelxApVrV2RYZ/L1xuZShimt54NKqAHgNKLb99o
         qy6c4xLOOcIndur/nvElA6JAxGXOa4qCgga7Ut1YnROCQTKS+rKq95EYHqU/Rxf7CDcF
         qxiqC0pgFxeliAOvctAZwUdO1gj8mPPnLM6c+M8B68hoeF5uBafoAg8hc+ksycKJ2lya
         vmBlSYEcvyTLPg+m+uploneKQ3DanJvBINK6xEdfY0qCnTWsOsnXyKD+B1rkR3QZYc1N
         AUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478279; x=1741083079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzseC7TE5yROJInpw1BHLRzHMDpvksChoWt2dWl13XA=;
        b=ZfUJLmg4qlIEYzoAl01o8Gy66HoVsUyTLQyj9xk9a+GnEYs6u+pr+Y4vgWQXS8ByO9
         ri6z1oNZLixY0v0uJRcnIYTY4U6fp4E9/HJOSqRIGV5kxm8h67sRRjRqS8mzabO28Zwu
         dgHMwWkXAfwKsJs1akCgvXC+ENTBsoPEAPdDdrdjBIYXSSSzeF6MFuzUZ6Q+M2D/Mi1F
         2+/wxtnuPVm4enFdDBS0Wzon/YQMj00JsuoIVPCIO8RpzrR6xaCaOp3ZSH7L9EE4fG1C
         gJAdx/Pjgwsnlb0a3W/tlaUhbj8CfW3SZs3FmPvyYms7+Fv1UZ1fuUsQYfNMvRqJaaci
         BIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdS1PTRns8I2Bhzl2dJevTJ3EE67YE4Mx8kui3efAYZ1d6+QdHqkE/2Pbu4PRn6MMeDDS5x4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTi7b297ZMUTxL5Bbf+UYE9DbPtSvi/WjaEbywJSc7gtF4Cnvf
	IaK9KRrwm+X9U/xuSTz7xSzdLNSd7i1dr+6ie9J1a3NqIfTBuzdRpDRf243EIwxb7c1GiD9bS+d
	hVmWsAhg6M58YxT6FyJxBMlMwYr5Z+IdsaHSl
X-Gm-Gg: ASbGncuxG5vWDayKQC303JAR2UmZLI05eyA4jBx39ivFXNFTmTCdycFJtkX+FIgKmn+
	5KDr5ixqLgek98MJcTWngJL7mzNCwxVTSEccGsntDaIxGUNgXHwcRDWe1vlbUjK08umjv/FwtVK
	tuLeGdbbnS
X-Google-Smtp-Source: AGHT+IEMaFRlnjVZhNHnGBw1w+Bc7lVMznsgl6XDNDSP6NEMAFA7rS+ab1fUgPl9w6DuKngpyvAzAAaN3tEUcm5QE7E=
X-Received: by 2002:a05:6402:4611:b0:5e2:81c:fde9 with SMTP id
 4fb4d7f45d1cf-5e2081d05ccmr2908336a12.15.1740478279057; Tue, 25 Feb 2025
 02:11:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224110654.707639-1-edumazet@google.com> <4f37d18c-6152-42cf-9d25-98abb5cd9584@redhat.com>
 <af310ccd-3b5f-4046-b8d7-ab38b76d4bde@kernel.org>
In-Reply-To: <af310ccd-3b5f-4046-b8d7-ab38b76d4bde@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 11:11:07 +0100
X-Gm-Features: AQ5f1JpRxGTaxp4PmKphbnEyB6yo1_O2aZmaLk681OaNP8yNyH_Qsr0VfGp33_A
Message-ID: <CANn89iJfXJi7CL2ekBo9Zn9KtVTRxwMCZiSxdC21uNfkdNU1Jg@mail.gmail.com>
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

On Tue, Feb 25, 2025 at 11:09=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Paolo, Eric,
>
> On 25/02/2025 10:59, Paolo Abeni wrote:
> > On 2/24/25 12:06 PM, Eric Dumazet wrote:
> >> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
> >> for flows using TCP TS option (RFC 7323)
> >>
> >> As hinted by an old comment in tcp_check_req(),
> >> we can check the TSecr value in the incoming packet corresponds
> >> to one of the SYNACK TSval values we have sent.
> >>
> >> In this patch, I record the oldest and most recent values
> >> that SYNACK packets have used.
> >>
> >> Send a challenge ACK if we receive a TSecr outside
> >> of this range, and increase a new SNMP counter.
> >>
> >> nstat -az | grep TcpExtTSECR_Rejected
> >> TcpExtTSECR_Rejected            0                  0.0
>
> (...)
>
> > It looks like this change causes mptcp self-test failures:
> >
> > https://netdev-3.bots.linux.dev/vmksft-mptcp/results/6642/1-mptcp-join-=
sh/stdout
> >
> > ipv6 subflows creation fails due to the added check:
> >
> > # TcpExtTSECR_Rejected            3                  0.0
>
> You have been faster to report the issue :-)
>
> > (for unknown reasons the ipv4 variant of the test is successful)
>
> Please note that it is not the first time the MPTCP test suite caught
> issues with the IPv6 stack. It is likely possible the IPv6 stack is less
> covered than the v4 one in the net selftests. (Even if I guess here the
> issue is only on MPTCP side.)


subflow_prep_synack() does :

 /* clear tstamp_ok, as needed depending on cookie */
if (foc && foc->len > -1)
     ireq->tstamp_ok =3D 0;

I will double check fastopen code then.

