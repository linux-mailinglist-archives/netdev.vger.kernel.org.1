Return-Path: <netdev+bounces-109321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD1927E55
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 22:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A461F248D0
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 20:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D221428F2;
	Thu,  4 Jul 2024 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCj25mVo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FF7C2ED
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720126068; cv=none; b=LtL00oQYyJkFC6kbZhdiIH5NTMQieVHJc4ZRtOmjgpTu3q6Z4FU/0/qeGOJreq2znuj9h2I4GmMl/cGU1aaXykjVdCfmOnYZRqaRAxb2RB6MS4ZAtUoj0t/GeUcSpg5PZwQaYh0swRethFynGoiOiMrAozFRBOykr6HwTGt0KdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720126068; c=relaxed/simple;
	bh=pknVDfz3Ym2CLi7ZQTkPCJp4T2a6uyQ2BpMKtD0sFCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auKuCIJP2eGQE1ew6NsciK2WlmW11IcMCWe2IQG8gx3ctzrY04VfSS0F12BPnuyXico8JrY+uOPjojmmzHqeKn2kaVBkZ+H5obP3UGipTWItNZDKMh5U3E91So+by/ydg7v8y79Si8A6FXfdN4R6nGaGiSVVww21Eah7F7Cyfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCj25mVo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c9785517c0so702849a91.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 13:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720126067; x=1720730867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umqPbZhY77BWJpLXOD7EcR0NlxRkYXFTFvFqXEAa3o0=;
        b=HCj25mVoItDP8fjeF2b+q3gUg8MetyelwcMX1RfvGpTJwHGCIjcjnnjw0EmxPhhzis
         8YMKnkayOpz7LvBYyB+0SsQmT+LtKjTe8HOAjXrD+zT62rECH+SOLMiKKAhnhuZq5Tsn
         I3Pjb8gssU6n+txoPIZSoq/UCDp0UwFTdVULYJH3KKfzOKuBwjJCX8lj+OBVINP3BSaF
         KV1t5j+J2G6WjYabEfy/9njZ6XfmdGJ6hJYgXTM7D8pvHTsi+dZmUN2oCJCxm5JzE23f
         bLzehRFLFIAuzWqrwyiRXEJo0zgmI56D2FlJ35TpJz940k/sotNO3R2hCvvO4Q0s0iaH
         w2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720126067; x=1720730867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umqPbZhY77BWJpLXOD7EcR0NlxRkYXFTFvFqXEAa3o0=;
        b=krnEeIj2u+xJlOm9p/NfbqlouY9/6QKNZ+7ZWakfu52VoNFCK3thulP7YpJnJJnelp
         pqXeVAPkZQw8ch9jihSC+ulmx7cVIDuL59E69B94ibDTPcdMOjnbjQK6x3hxnm6AzPSz
         yRY0MhNBJGuXnAoAB08YCcIMpvK0aZaFKHNMWQIljfdBMznPuXJyyBFNVbGONgS63CDf
         KivdGbUWGrPDBPU4wDqiNqu6cLU6JzinZ8Ufcdy2LkuKckd6aGb/aOEyokThxs4NQMtd
         ixeJ4s7FFhbdnEX48Lq6+cnikURIe7eHRJfMwoK19YjnbbPnEgYmRoqbAVm7CxWBQ8hA
         aJgg==
X-Forwarded-Encrypted: i=1; AJvYcCUjbHG6q+QvOHovt9YJB4q6U1nJmTumwl8JelXg44fZ3BcPu298is5nGR/ggYweO0paQP9M2/jR8bWKeYjsjSWHEcvat6K3
X-Gm-Message-State: AOJu0Yz9ZoYC5oNzQ+ObLh5iS8w3RU2JjY39AqfNkjlZ1SCyHidHTiSx
	jjtdqaBA/7LZ2axTuimSo3xw54tqFxNhh9XDSBYFxY1Thxe5SqbG57CXpXtMjEHcpJOby7UPOT7
	2r7cTCaXiQSgrQwWwzHifs7T8vRY=
X-Google-Smtp-Source: AGHT+IEYI5evzXwZncTp0Ds/4KuMcob7a+vxku+wc40JCP+1w73XZbFp1QN7/2wo3GinAD3F/K0s/VHRiZnLO4jKQp0=
X-Received: by 2002:a17:90b:30c:b0:2c9:6187:98ca with SMTP id
 98e67ed59e1d1-2c99c7f7a4fmr2136096a91.22.1720126066557; Thu, 04 Jul 2024
 13:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704035703.95065-1-kuniyu@amazon.com> <7c1264b94e70d591adfda405bf358ba1dfadafd5.camel@redhat.com>
 <CANn89iKO=Y8P_tms-nymhLF8QbWmOD-g_N33DLMfA6WcO+vhbg@mail.gmail.com>
In-Reply-To: <CANn89iKO=Y8P_tms-nymhLF8QbWmOD-g_N33DLMfA6WcO+vhbg@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 4 Jul 2024 21:47:34 +0100
Message-ID: <CAJwJo6bFnNKXvxtpEBC5TqrQ0ATXJeFr7onivgNM1cqz3HJWgg@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't drop SYN+ACK for simultaneous connect().
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Lawrence Brakmo <brakmo@fb.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jul 2024 at 13:23, Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Jul 4, 2024 at 1:16=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
[..]
> >
> > Apparently this behavior change is causing TCP AO self-tests failures:
> >
> > https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-2=
024-07-04--09-00
> > e.g.
> > https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/668061/22-sel=
f-connect-ipv4/stdout
> >
>
> These tests seem to have broken assumptions on a kernel behavior which
> are orthogonal to TCP AO.

Yes, I think my intention here was to verify that it tests
simultaneous connect code-path. Which is quite guaranteed in
self-connect tcp case, I guess, but some experience tells that
anything may go or evolve with time in unexpected ways (aka paranoia),
I thought it's reasonable to check TCPChallengeACK & TCPSYNChallenge
counters to verify. It seems those checks can be just dropped.

Thanks,
             Dmitry

