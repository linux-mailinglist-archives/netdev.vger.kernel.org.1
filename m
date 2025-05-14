Return-Path: <netdev+bounces-190487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C747AB7009
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8993B52B8
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ABF1C8606;
	Wed, 14 May 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUo8DUPp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0225E44C
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237131; cv=none; b=k4YYD/fVFgNtJRXfWtA8nCPYbk3xxTt8FwITVp54j9uRMOG8z4JmpBmlqaVFRsppc8SrXQHVNUVyXrGwW8tb2x6FHXSYecENrTOXEZ3m9CYpi8rx9knet3jWdpqTuMuRhuSBd1q+ljxQHxH83kD7MUYLukrKN2UaZ94wnMI0Jqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237131; c=relaxed/simple;
	bh=iyWM9Ku9N94nlV5t9IZydm94MDgN8D2T7m9dibIerOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsG9HAsL/9lax5zhMOqQRhRZZ1PnRQFa90dlNonO6Qr2rwLM9W9lZtzpLbnIyg59ONOO+Ufelpy/4HD3mweSRUQToojKUUln6fgk3WjC68okMmgqRezVh6fLFGfrCgxLyf7E2qYxBXy3ehZh4M/4dKxesx+EaTVPH3I4PgH+atE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUo8DUPp; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476b4c9faa2so98565631cf.3
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747237128; x=1747841928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVUHrD02UnzRJjFUVHJkpvSKfIYOmmAHXDZuwP7spmY=;
        b=lUo8DUPpXaKtgjLPMsT5/Q1URxioTGVg7cAnj6Ue+ruSxpIlm2dY/veJz8bQ9KOgDV
         IvA2m69abnPh5NOYxw1ciRMhBiOZs5bGx9M3tfFkuzE19L407xS4wjqOCf9XmQXMsymp
         burUa2yTY2nZEsveI8s3rCfSNPLL09GVc5891yKNOMTxZ3g1tDiOBsJQUPCW0sFDvhQP
         CC+Rsf7pSdBCmff8hYTqtRWgNrf3BroxEG7GaX4AEpXgn+wMTcyYdnFOliUdVw/ufJcQ
         YLjW+6c3GNTepH2UGDFV6Yg6N4xYcmzfBOR1dJ2wyrkPRYTLnw30pQZf/NHNkD37OmrH
         6y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747237128; x=1747841928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVUHrD02UnzRJjFUVHJkpvSKfIYOmmAHXDZuwP7spmY=;
        b=nkB/OBH1SivRS0vFAk5EEHtwSNdoKlf/ifgAq94r+VWnVpgo+8YwCRb68+QiOJ/cVW
         KbeR/wppmDI/kOjn2ysGf/PjuQvwPy9uLLj2wlP33wTXI5LSRei0TAOqzCrlU8nv0sBa
         72U+zfX5Keg0Ah5wYOe1o+bdmmI8g+JXD8ofMDTtGcKrK1D37TmDmZUUBEULYp/OPpyt
         3P17js17bfsHaVPR/6BirKix8XqfnFEd0RP9RQ9wrNZ8XukPUTO7nZWINnHlgh6zHE1V
         gsrnt1xpwIu1LTD+5SOaSjOWUqFb00fYBArtkJ4QRJ3rtxpjVySSpATPo07J5eenLBCG
         2I7w==
X-Forwarded-Encrypted: i=1; AJvYcCW8zgS0Uk68VQIWwBvsPKS9nF5rlqtbhkfelPSnr0qbjeHs3ZFsV7NND0Vev61CEJHHXzAqm+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSEFd/r6kLOXsRuH81f23BKiZjq7z1F4Pl8UU6LvdCafIkqn2
	B9nyMb3R9OOVJ31c+1wwvvxub029ux+TKiKd1gyKHbOdFUyQBiQFz6f8L2G86u8S2+k4UfGTnr6
	XVoQo9Iy0aCn+zxbPsEuz8f7dUoTmyT8G3fme
X-Gm-Gg: ASbGncsY/hg2MNbwmIUIK2tiGGXYvQ4IrAZWraWclTLT2nR4yXqeH+kf/M2jdktvZUX
	MDl75Vb0LpYWvB+AB4shV0Iy+Uaos9kWnAdkUKioJAcQ93t2DSjsXuoBgywlrItbGY+3niH27Iq
	RAncBTuaAs4vOAzBvJksV4KGHKnEAX3sCnVw==
X-Google-Smtp-Source: AGHT+IGFtsh/08MESmhO6pAv7hIPoI9c90mvuRsEEDdH/c6D183FhsJub78JUUqwg8c+PJrry13Gl4nvs6Cc5eQGDoY=
X-Received: by 2002:a05:622a:98c:b0:48a:de9c:8c0e with SMTP id
 d75a77b69052e-49495c911c7mr56789241cf.24.1747237127896; Wed, 14 May 2025
 08:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com> <20250513193919.1089692-2-edumazet@google.com>
 <51c7b462-500c-4c8b-92eb-d9ebae8bbe42@kernel.org>
In-Reply-To: <51c7b462-500c-4c8b-92eb-d9ebae8bbe42@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 May 2025 08:38:36 -0700
X-Gm-Features: AX0GCFsI7xbnsAmbTz4U9oOnk0i_5LU3kyWpuOZcBMat0IAzwXhyFtEBkNztzvM
Message-ID: <CANn89iK3n=iCQ5z3ScMvSR5_J=oxaXhrS=JF2fzALuAfeZHoEA@mail.gmail.com>
Subject: Re: [PATCH net-next 01/11] tcp: add tcp_rcvbuf_grow() tracepoint
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Rick Jones <jonesrick@google.com>, 
	Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 8:30=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 5/13/25 1:39 PM, Eric Dumazet wrote:
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index a35018e2d0ba27b14d0b59d3728f7181b1a51161..88beb6d0f7b5981e65937a6=
727a1111fd341335b 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -769,6 +769,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
> >       if (copied <=3D tp->rcvq_space.space)
> >               goto new_measure;
> >
> > +     trace_tcp_rcvbuf_grow(sk, time);
>
> tracepoints typically take on the name of the function. Patch 2 moves a
> lot of logic from tcp_rcv_space_adjust to tcp_rcvbuf_grow but does not
> move this tracepoint into it. For sake of consistency, why not do that -
> and add this patch after the code move?

Prior value is needed in the tracepoint, but in patch 2, I call
tcp_rcvbuf_grow() after it is overwritten.

I was planning to add a call to this tracepoint from
tcp_data_queue_ofo(), with 'time=3D=3D0', in the third patch.

But I found this quite noisy and not useful, so I removed it from the OFO c=
ase.

