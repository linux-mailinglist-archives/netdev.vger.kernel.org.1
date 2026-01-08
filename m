Return-Path: <netdev+bounces-248281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9154DD06778
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 23:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C100330082E4
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F5332EB2;
	Thu,  8 Jan 2026 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KP4G76vN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023A299928
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912490; cv=pass; b=tIpFDVE2vQezKTTRPoISDJYtsdklq3L1d2hZ0uVkFwlAEkSmWNjrsk6xmR4pe6ftRXABk0enYVP8Mw4EIwSHghSxdD8dh0VCUUkw7tfsTQ8jHJwAanEC+j3/9rVLuMALGzMvgfqFxO+z8XuZ31pwLuiesRlivXvE4PvUfF4LnGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912490; c=relaxed/simple;
	bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoK4Esa9bU+n4XByPV0u506dW18KAXTuGPwevDP3uK9HSKnEAwY4LYxHYSYDQOLm1X7LT4j9DrTqD1BoQbczkOC/XVKlwkjfVKsYHH+xlj5A2ub5L3wVCgBZtIIbyG8hI0Fdi8EbutWRO2doT1ycRQYBgjvyuIfz6GrVLuF/i9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KP4G76vN; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee243b98caso68431cf.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 14:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767912488; cv=none;
        d=google.com; s=arc-20240605;
        b=H9yFVGXyWT/CLh0X4ropSP9Q3d7hjTLmnStR6W872KAJureworLPPlMu2ebjTN+k4n
         Hsbxuq/ck0420dnJ9HRDi+PexyB5fhsXBCWB8P+udggJGVF7UBSQwHcU26oTJwosR+G/
         BNhTr85VKaCgr1p58evyGx1LjtG5dTozoUtpUcRKnFRdWjSn33nXvbXfDlIUUZiHif/v
         8gUdxctE+Ps5r9VhUZ63std3UFKYf0m1MKWk78andPVw1qK+yxiVNlTV6o2BZyN+FtL4
         ppO6VJ7cdYNgLTX+ZI3SPXRCkTxAuv9KFUkGL53M5JnXumVYh9SocOko7DsN8l7niby4
         CzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
        fh=TTkbZOtNG7GRQDHUFuClj58Au7gdD7ycOPeOVIMZPUM=;
        b=XvTtsHjBsBh0psiEP3bKSlLP+wWKCIHZpNAxyHhdngOd+VgiILfmR488sezHRz7wM9
         2QOXJT1jwHhjh5JhlwFoUIQczqbQhDB6wnwvAoXbkcxbDPrJqfOEWSZ0cKQxvackEFLM
         FG5brGJEsiZML92lXprmsZYdyQAh0rn1wDVkAdSNRbxdDbNqNFVwGz3QqGWTj6Ul0iEh
         tNfU/EGsOcXvpfykR7+L1VmaJamDcphe28NyM9sSmDuVL1SYsq1bjPCV3BVsM7UT0uOX
         rmMC7nZnEaHliM3wuOB0ng3mCmcMqNFHDu7d3/CbmZR6vqxyqrOtAdxi19IRQSP4aExz
         5gjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912488; x=1768517288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
        b=KP4G76vNV8G2QJOzBZ3cs5ZC6bKRcr8+OPMKDkbNwQDkQxb+3lMTpACN3HVSNG9/Dv
         FLkKWfMtfH2Ic+yEEMP8peZE8gI3EGYV7ESz4VWTYr9Qd5/ANShPi8YR1NnIvlGecadL
         bSLz+SPPPu7zrn0o9Yg4WtX5DAxMce8uycGg32Vx6GMCx3ixgYBYzaZzYe2v1oRxVqZa
         9muz9upsFMIDXxg40v9qkD6BeUUGgYCwvvkvJcRi4iMsIB1AAdggE29ylmJVaiZ3/Khe
         87oC/F4AT3Qf4i4f6Pm945K4cbyH9cZo22WZNfrz8OMHRZ76yH+357zeIQHzuKABVaH4
         VK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912488; x=1768517288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
        b=l2oKmqZY2uMxptFZys1DBr5w9CnmTKKggPW6fLmsXEe5Lb+3UuNIWAIztZoIotY8f2
         +y0At8M98ha8/GwL+kRnEbinQxUgCW3AfWp1UAQqGhq2YFGcXZfsDcmSUuOTH7VA2J1T
         ywxzxQ/T7AJQdMRZjlMdgRTW6DdkOkL/jO0rFhW3FC56emWJYJXigp6gz/9Hr7JgXxVF
         8K3r/PUIVaPjinY5P7t3InvQHBUh/dCgb1AJEcwKdNmUTMmENYLTKIq6e7anvkQ/p8ly
         QPeEge5xLEUlYQXtt8jESbZBz5qcJ8KvjShNUIHRtIiVi2L2HD+sSNPMcVUl8xxHfjN5
         9Cng==
X-Forwarded-Encrypted: i=1; AJvYcCX+sHNRyBeftV6GAnr7bx0GTh+mTIiFCgMMuVV8LwiPvG3uJGq2aZdH4RtkY4+FsINu2gTBGpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRkBnHdA65983yGTY4KKxWgDNv8txM9jUZCBNZNR6U+MqzygRz
	//oJdpK9QiiK3zQz4LZXHaDQLszf5o13NTJ4N52hokXnPYlSucQVSuLFNfDBUcurruoNUbibhfU
	xlsAOG34JGNcz4l/qWIzPvp6eDsP1cQ8VHchBfbXw
X-Gm-Gg: AY/fxX5DAiCzDQKWKTD7Eu8aOrIwOH97rvlH12l2yBhd6u4V+ug+VjOaYhfyGWzBA7R
	Zp/5Cn/qqHvG4XWeJBQLtr5XW0WBHTAqoB3egJU1seFCRdpKTQY9vNpMaxWJfUydCOCtR9P6bQX
	YL1DhttcmnjPVUPV6DGPc2wsY5WYiHiun3tudVCSCkOyhdMxsEW+jr+ckumgLvaAiFI6pGB3+z8
	AS1+Zr2FvwNKlleDCgIEKCFSGozmNWI6VKnfaDuFwezCr74L4hUS1rc/lJgYfZN84M4sKCs0hhu
	qZq9K++UllUfFuYfHQjXq6yrw0BBCy5021eavCuBO1FU+T/hKmcydWTdpYc=
X-Received: by 2002:ac8:7dc8:0:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-4ffcb1703famr1912391cf.1.1767912487896; Thu, 08 Jan 2026
 14:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com> <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
In-Reply-To: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 17:47:51 -0500
X-Gm-Features: AQt7F2rHIoIx_fDko3yxcFPFIn-ukKfEKFlHAg0ugBLMmvSi3Dr6twPz-fvm6JM
Message-ID: <CADVnQykyiM=qDoa_7zFhrZ4Q_D8FPN0_FhUn+k16cLHM9WBOCw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > cover several scenarios: Connection teardown, different ACK conditions,
> > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > retransmission/reorder/loss, AccECN option drop/loss, different
> > handshake reflectors, data with marking, and different sysctl values.
> >
> > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > ---

A third note:

(3)

