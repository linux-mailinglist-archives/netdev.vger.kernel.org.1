Return-Path: <netdev+bounces-217075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA0BB3748A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E4C361F33
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC37E279DC5;
	Tue, 26 Aug 2025 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws7aiz/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2052343BE
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244922; cv=none; b=G2OCgG2Eq47W+BsOB3nDumHTa5S0asUZUosD+oaSVUk/aOesVBzWBphGw4ABFtWt7ewMI8TelxBnvQ8oYXDdUNGxjEwW+qbzqynay1UpSdOIKIBJyiAwqZOi0Q7QR4A5TEGlyEbTOX4KOJI3Be4ryG4AoZJvyLdXTIOm5CbnYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244922; c=relaxed/simple;
	bh=eJQ6MWOdZCJ25Q+ugQ5m4yaofmX6Ei6SYfuK7vBemOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9jgZvGrUI47KedXNhCeACdwaXCtks6Cvq53jQEVjIXx3H8hSpSxypTnBW5kYtXcbFvnASBPUteEo6+XXh29rPY/MjQ9qx8DsuNLw4mT+dpXU+9J1Vk8xi9iR5S8UU7IY7FvDAMyTqVtw1TLMfp15p+RqauIgIF8QoGkxoHq4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws7aiz/c; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso5070113a91.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756244920; x=1756849720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJQ6MWOdZCJ25Q+ugQ5m4yaofmX6Ei6SYfuK7vBemOc=;
        b=Ws7aiz/cA6w0MiDcaOtxY419NHhg7ZcYn+HV07uLHaBnNQaurAPN78caUgiyfFiakV
         xaE8iFmL3ozsNI/RGJ9sCveaFYsRBCHusdTI9xskcNFKQoK40ouyKHCrsm7ZuihlhrPl
         AmGhBCpD6uzwkQLebzYXhRLIfviozjMvta579O8B8lR2Q0mmz6EwKDTMHgsR5OdBljxK
         bdOEncIUIlHEbonT1m+BErPN25lZ0Wr383CzK28H/oyI8wH3CPin903BQMQtCkT8UtGt
         IAZaKBnytS0LuXzi2XZz09f+47PSJBwnJE/Yn4fr6fOgiBrL/STQ9ABL0QLodKKU4l6r
         feBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756244920; x=1756849720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJQ6MWOdZCJ25Q+ugQ5m4yaofmX6Ei6SYfuK7vBemOc=;
        b=Wu8DmNLPfEjVWPKFsnjYp1JBHtRwQ0ISrd3B2QVLiAYJBXpbt9bdI/5WNWX0V/HnDf
         hy05NF4h5F5pSZFeNk/ketnRLGbojh5l1far7KPJnwepu01NOApk7jizXUWMS3mOuuRU
         C4ZlSYq8llHbkh9FYrENCS8gnzlLM/MB+xa6ysQvdO2vqvHaWRElPzxwaZUCMpj2H44c
         HTOz7o2IavpXQUyW10gG3qpTv9W3j1Wh7hCr+1C46jQGioaAn9uV6lZWB4qUX1CCJPEn
         IV0hDSgEKdH+VNjiQOjpuBuzVOU855l7LEgpNjLkQ8Z1WU5QoCljbCPCVjXysrFP7yQk
         qzEA==
X-Gm-Message-State: AOJu0YxS2RV1zCllzILwAfcD49d7K0i5IRrWJWVttRlhMorD2OSLs5UM
	FPlg4lEi76zyEn5KnI5VcvG/XkdkxSYjOBW4FgC43CX+qbVFLXpDYw4CvEjRcx+vV0Ta7dn4IGl
	A3Cd/e9A8O1nhS3KXNFM0/yuxW2fXDUpEDD9P
X-Gm-Gg: ASbGnctOpXCdxCbYJHY73upWUtCGUA7AewJ9Sj9pdqbhghmMryIbbWX7M/8gDRdcF5p
	eymaCx/AMc2nGdOdlCwOfghAujkGEi7psnPxARX9q44P33+VGZdOO2a1AJWVh5P80yJpXHCoI8b
	oBJOlC49iB/kJid1L+PEMOpQJu5ExEGGCMATxYofxXVinF1AdwYYY36ahER4Ou/Yksa8rwPWDkI
	DPOdU+l5dktKXkK0bjdB+fjqO2tEUag0PutN8TM/Luk4xLkKA==
X-Google-Smtp-Source: AGHT+IGzdVhjfVQh6LPWA67zc99Ei23/KM92yJvizgNof07b+aPpgdeUrXv8li+pdsrFv27/xZH6I3n08KSE0zJJR9U=
X-Received: by 2002:a17:90b:4b8f:b0:327:41c8:8840 with SMTP id
 98e67ed59e1d1-32741c8899emr5585440a91.37.1756244920401; Tue, 26 Aug 2025
 14:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755525878.git.lucien.xin@gmail.com> <cb74facd-aa28-4c9d-b05f-84be3a135b20@app.fastmail.com>
 <CADvbK_f4v916nbx4t0fnkCj44S-buTytj_Paurd3j3Ro2tLDsQ@mail.gmail.com>
In-Reply-To: <CADvbK_f4v916nbx4t0fnkCj44S-buTytj_Paurd3j3Ro2tLDsQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 26 Aug 2025 17:48:28 -0400
X-Gm-Features: Ac12FXzUryOp5o2sZFp0DBeCGGxf7TEZk5lsZKWx27o1ya7d4lotCZr6WCswwNY
Message-ID: <CADvbK_e9sNbvHSCNuvetOCFY5OQPG99tmZLW=odcRzcN9xK8rQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/15] net: introduce QUIC infrastructure and
 core subcomponents
To: John Ericson <mail@johnericson.me>
Cc: network dev <netdev@vger.kernel.org>, draft-lxin-quic-socket-apis@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 1:57=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Sat, Aug 23, 2025 at 11:21=E2=80=AFAM John Ericson <mail@johnericson.m=
e> wrote:
> >
> > (Note: This is an interface more than implementation question --- apolo=
gies in advanced if this is not the right place to ask. I originally sent t=
his message to [0] about the IETF internet draft [1], but then I realized t=
hat is just an alias for the draft authors, and not a public mailing list, =
so I figured this would be better in order to have something in the public =
record.)
> >
> > ---
> >
> > I was surprised to see that (if I understand correctly) in the current =
design, all communication over one connection must happen with the same soc=
ket, and instead stream ids are the sole mechanism to distinguish between d=
ifferent streams (e.g. for sending and receiving).
> >
> > This does work, but it is bad for application programming which wants t=
o take advantage of separate streams while being transport-agnostic. For ex=
ample, it would be very nice to run an arbitrary program with stdout and st=
derr hooked up to separate QUIC streams. This can be elegantly accomplished=
 if there is an option to create a fresh socket / file descriptor which is =
just associated with a single stream. Then "regular" send/rescv, or even re=
ad/write, can be used with multiple streams.
> >
> > I see that the SCTP socket interface has sctp_peeloff [2] for this purp=
ose. Could something similar be included in this specification?
> Hi, John,
>
> That is a bit different. In SCTP, sctp_peeloff() detaches an
> association/connection from a one-to-many socket and returns it as a
> new socket. It does not peel off a stream. Stream send/receive
> operations in SCTP are actually quite similar to how QUIC handles
> streams in the proposed QUIC socket API.
>
> For QUIC, supporting 'stream peeloff' might mean creating a new socket
> type that carries a stream ID and maps its sendmsg/recvmsg to the
> 'parent' QUIC socket. But there are details to sort out, like whether
> the 'parent-child relationship' should be maintained. We also need to
> consider whether this is worth implementing in the kernel, or if a
> similar API could be provided in libquic.
>
> I=E2=80=99ll be requesting a mailing list for QUIC development and new
> interfaces, and this would be a good topic to continue there.
>
Hi, John,

Feel free to create a thread on quic@lists.linux.dev for this.

Thanks.

