Return-Path: <netdev+bounces-115493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB49946A72
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 17:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A544AB21280
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8B1547D8;
	Sat,  3 Aug 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVIFv4W5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E71509B6;
	Sat,  3 Aug 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722700124; cv=none; b=sWPrcjd1XD36jHdzVDAdWC1N+feb/xiF+ZhLKkT/oN6rBgPBdhHsV/snb4U2UQjIr2a9+mjDzuE+5AfeLA/UoTbQeDwI/HObhlFlvIufBkIQmN9jQJydorO81Feh0ip6L5vAnGrsbpf7QOW7gHT1i5MWJ7SL9bhgMl7U6AbZleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722700124; c=relaxed/simple;
	bh=zvCMh2scSAAzx7sSA0dGXKLUtTv2QHSXx5XOq0pGNIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQwQiMfUi0bmwLkMnloR1fykN8eYESGS6G6b2zjsH+KbvXCI4q/+Il9WK4eRkM4Qfyb2o0X77cStb83BVjoYF/dRIlMG8M4wx0CUCDX6nE73DorJ4BVPPX9JlVfolW3SHlPmyy+L1AaUHzmc4YwlBNeWy8lveoeQ0wlM5XBBOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVIFv4W5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso6893494a12.1;
        Sat, 03 Aug 2024 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722700120; x=1723304920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvCMh2scSAAzx7sSA0dGXKLUtTv2QHSXx5XOq0pGNIY=;
        b=QVIFv4W53k1iB+cqdgwTjJjNqnNblAGz4SH3Dkd1xkpe8AWqbfzWGlAf09hqGZrOMh
         jiV4boAkdoM1eN6CwXOVi4LYNow0trcW0FSQ1Dzhe+o6b1EFqj1VARbieC6mUi/x7Jlm
         MTJMMlFVSBRbU4/vwFXX+GoMNqedbArBcqFhjg76yQaIY0tKoAT4FNDdKd5q0ns6lFDD
         5cdb23xzBbMnibpnCf2ewpxt0ZSLKGVDfJcLyWq3zJF4QbvsqkgyDc8TrV135P1gQgDW
         5UsUrt+GHVURei5zBZl+cNqcCFKBdkpsJIEMpmx5n08K2tT1gBbvphrIa39Z75xl8NeE
         gYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722700120; x=1723304920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvCMh2scSAAzx7sSA0dGXKLUtTv2QHSXx5XOq0pGNIY=;
        b=ZBehcy3+XYlbz3uItjUay6QcWL0aB/cEIfqpnh6eoeJSSK8ZqoAoegeTd8mweFfnY9
         Kq4qVFN2HeaEShkCUen/B/T6qqaOxKzpZoDIPkPh/f5Yg8m5rnxEFZBBBQeF7nMIRRJ5
         6dALuKubVVnCLf2lHmjGnR0jXIFjxF6tcuHtOECc4of68EGnMk4RgZeKss8ZdJY8vI5l
         CT2ah8CSeccC9DTrql0NawTa/TFXki8hi9KjAUFcjDi1tM1n4yRBW4NZcTZljDcxDXkj
         9pnG3yNyEvY7Ut2Uh7mZ04fDNnTAEJGiXXI2w3vzyQPxCb1bnK+ANooOTR+O9RwjUM+L
         TOCA==
X-Forwarded-Encrypted: i=1; AJvYcCVMzaiIPpg1EayviRtlJJES0FLcZiM1TAunYLMbEKIzRJswsYk68h6w7qcdp9EzPpVPUKmFkDw5wK+AN10u+4vMf0W1hV+nU2+djsKrFSaHFUiMK/oQxxt8+y1f5zN7hRlmDmV2
X-Gm-Message-State: AOJu0YynG7U95k74giim52clMch5OZMoGwvFdN+gOvs4PDuE36VsZcB2
	Y/V14SdVFTi9gEByoQBGAhhJezwjkxhvbf0mt3KszpCD6a4yQiM0bVRe4SqmNU7GShG1sSLwz5n
	J25OngZ0xFUDwQF52iUHUo1E3lLs=
X-Google-Smtp-Source: AGHT+IHzoUsOPUmNwqNBBZwXxScIiO4bcD4bws4wUfqUGx+w+8Cp96xBCQYRpfoAMWqGsqil60w05f1cvDxBoiaUEgw=
X-Received: by 2002:a50:fb8c:0:b0:5a3:8077:3c90 with SMTP id
 4fb4d7f45d1cf-5b7f56fb7c0mr5889995a12.33.1722700120100; Sat, 03 Aug 2024
 08:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
In-Reply-To: <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 3 Aug 2024 23:48:03 +0800
Message-ID: <CAL+tcoAHBSDLTNobA1MJ2itLja1xnWwmejDioPBQJh83oma55Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Eric Dumazet <edumazet@google.com>
Cc: Xueming Feng <kuro@kuroa.me>, Lorenzo Colitti <lorenzo@google.com>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Thu, Aug 1, 2024 at 9:17=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wrote=
:
> >
> > We have some problem closing zero-window fin-wait-1 tcp sockets in our
> > environment. This patch come from the investigation.
> >
> > Previously tcp_abort only sends out reset and calls tcp_done when the
> > socket is not SOCK_DEAD aka. orphan. For orphan socket, it will only
> > purging the write queue, but not close the socket and left it to the
> > timer.
> >
> > While purging the write queue, tp->packets_out and sk->sk_write_queue
> > is cleared along the way. However tcp_retransmit_timer have early
> > return based on !tp->packets_out and tcp_probe_timer have early
> > return based on !sk->sk_write_queue.
> >
> > This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
> > and socket not being killed by the timers. Converting a zero-windowed
> > orphan to a forever orphan.
> >
> > This patch removes the SOCK_DEAD check in tcp_abort, making it send
> > reset to peer and close the socket accordingly. Preventing the
> > timer-less orphan from happening.
> >
> > Fixes: e05836ac07c7 ("tcp: purge write queue upon aborting the connecti=
on")
> > Fixes: bffd168c3fc5 ("tcp: clear tp->packets_out when purging write que=
ue")
> > Signed-off-by: Xueming Feng <kuro@kuroa.me>
>
> This seems legit, but are you sure these two blamed commits added this bu=
g ?
>
> Even before them, we should have called tcp_done() right away, instead
> of waiting for a (possibly long) timer to complete the job.
>
> This might be important when killing millions of sockets on a busy server=
.
>
> CC Lorenzo
>
> Lorenzo, do you recall why your patch was testing the SOCK_DEAD flag ?

I guess that one of possible reasons is to avoid double-free,
something like this, happening in inet_csk_destroy_sock().

Let me assume: if we call tcp_close() first under the memory pressure
which means tcp_check_oom() returns true and then it will call
inet_csk_destroy_sock() in __tcp_close(), later tcp_abort() will call
tcp_done() to free the sk again in the inet_csk_destroy_sock() when
not testing the SOCK_DEAD flag in tcp_abort.

Do you think the above case could happen?

Thanks,
Jason

