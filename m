Return-Path: <netdev+bounces-169632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BDCA44E0A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7C172767
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0619DFA2;
	Tue, 25 Feb 2025 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1zWit8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBBDF59
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516762; cv=none; b=ntKdZX4A67GST/wpI/ufejqAX7y/4nhI3GNxdQ3WFI6NZWJii7WCQYoXaQOBoTy2o89LUkRT3Jtk06qTx5aaGSt+bN8YNrt6TvOnEwvGJ40MvSzV84ZxOzUlAK0+zVmO71h8QMKCZ/5IOrcR7mURlDs3rJpUFrWDPQNMrTLf0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516762; c=relaxed/simple;
	bh=hjz0gBE9twZOOp7C9S3tpcPR8h5pPtLgczWgnTi26HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu/8A9eP1mDg6/2QL2rjRwgefokJvaKw7xiPzYWbYBOeYEY/l6+xooffUab8YTM0pEOmhZxaYIaRGkMHIoPtYG8nfoB3RDZliIiN30osNIQrZI8eaAEcWJO+65wH0s2KXl/p+eJ274Ai3S43oyXkebmhfJR9fXLFKb6Sj+MfdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1zWit8W; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471fa3b19bcso53801cf.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740516760; x=1741121560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPNE7Tr/f423mFCnHjLQC6m2BRNVKkHqF77gxN6IZs4=;
        b=h1zWit8WhOFD1ivQDjr7zZT61jOgQEOczLLabZQm3rc/OHcM3qouEdTyXVKNbE+Cl7
         N59Hca8aYMqciHZndzsHrFfpbv9jt37XhFbQ4KKKqs0qx5xSyDi/6HlCBq76BPFx6PcB
         7wSyuzXvQTUzkdeRJADcK/rZW5hqSQoSa8rviiOWfFIRPBPjZzj5h9KDt2g7hueV2aup
         vOmdsMe7PhGSXgRUvvWqiJvOrvGTkmFATPpiJI6xjxDFyYZ3O8PhPotleNnfkKI3doaA
         EWF2KJr0gyjuEty31ZC04HhVoVc/ktAaiMR7V4IVrSIVgqqXFwVmc8n/TqPgs+3y9tQA
         8pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740516760; x=1741121560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPNE7Tr/f423mFCnHjLQC6m2BRNVKkHqF77gxN6IZs4=;
        b=SMCJonVahE6MxzeefjZ8udf/bzt5XDWA3rqQqKF0799qWA1Ks4WCpWjn0BF+4EWPqt
         4his9fqd48Wwp9UUcZ66IBqJ5g1kHJVp1H7zljJx6FosS0vrykp942+FHQHj09GiOdVs
         8d6+UUQr4Ahua+/+sr65JV3BhFyb2ykG/pGGAbhhZgHUiup833PWFKuC+KwBFfp9a5b3
         Ns+/lWabThn7datNSbGz+pp6wrpchoe83rfgAORh96VIvgj2onjoEkxIQFOK3sdB4CS2
         yB3JpFXA3O7OTsxND9o6B1xMDr1IK9O1pGFydl//UPik2QuKfDppA0DC6iu0uW1Xpqwc
         6e2g==
X-Forwarded-Encrypted: i=1; AJvYcCW1zgjDXm4QkbfIuJwSwZkyQaXluMixOG2oj2DtaGr7E7rJMmSA25ZQMzpC9Kau+sFsbViFTvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hxAyATuIhxo20Io7cH1QGhZh6w7cvapq55RgJTOCM0J4rlMy
	pz3G04pipgnxIW9nWJKqwWuR/Jsv5F8w0186SCDas+494aZyPlWH3Mn0MBfLcvoIkv1svAyGkKH
	XcKE2/a3wPxbToHyCP1I3ZvPhzAX3DvBSO7zZ
X-Gm-Gg: ASbGnctvViEpxLT4KEHtg2+Bpv1tx7eJ9NORGPJDKxfZ6c13eHDroV5lrEy3isPxvGr
	TWoJbLHdyEtoOjE7Am/Hs6CXr5dhj8RzLf2lSY/ZEIOJ3/9bCgTIrUp7jNf+SJndlfztLnAkfIr
	6Vw/QuTY26EJzw3AMRQlbEVbnx59VUv6dw3fy6tSA06dW2AoNX2M2G620=
X-Google-Smtp-Source: AGHT+IH5AOCS6JZ2mI1zqQHspQOD7FeMuXqDxmTdFaEGEJFBMjiPH8AbqUufH0Pq+y/PtHGWArocPqx+AtmwFJ0TV9A=
X-Received: by 2002:a05:622a:1342:b0:471:fe4a:b907 with SMTP id
 d75a77b69052e-47376e8f66bmr6550781cf.15.1740516759767; Tue, 25 Feb 2025
 12:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225171048.3105061-1-edumazet@google.com>
In-Reply-To: <20250225171048.3105061-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 25 Feb 2025 15:52:23 -0500
X-Gm-Features: AQ5f1JpYfH8_Bpyyei96smq3SqWZZnw1RkiJsvvSwH2wsP6M20b6Krsq7JB9thY
Message-ID: <CADVnQynMnDaDBkKy9c+DVRL6mf=bmpzjiyVEgxX0df-5iRS8Mg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: be less liberal in TSEcr received while
 in SYN_RECV state
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Yong-Hao Zou <yonghaoz1994@gmail.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:10=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
> for flows using TCP TS option (RFC 7323)
>
> As hinted by an old comment in tcp_check_req(),
> we can check the TSEcr value in the incoming packet corresponds
> to one of the SYNACK TSval values we have sent.
>
> In this patch, I record the oldest and most recent values
> that SYNACK packets have used.
>
> Send a challenge ACK if we receive a TSEcr outside
> of this range, and increase a new SNMP counter.
>
> nstat -az | grep TSEcrRejected
> TcpExtTSEcrRejected            0                  0.0
>
> Due to TCP fastopen implementation, do not apply yet these checks
> for fastopen flows.
>
> v2: No longer use req->num_timeout, but treq->snt_tsval_first
>     to detect when first SYNACK is prepared. This means
>     we make sure to not send an initial zero TSval.
>     Make sure MPTCP and TCP selftests are passing.
>     Change MIB name to TcpExtTSEcrRejected
>
> v1: https://lore.kernel.org/netdev/CADVnQykD8i4ArpSZaPKaoNxLJ2if2ts9m4As+=
=3DJvdkrgx1qMHw@mail.gmail.com/T/
>
> Reported-by: Yong-Hao Zou <yonghaoz1994@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

