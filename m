Return-Path: <netdev+bounces-233265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A2C0FAC9
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F27054E8168
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C0631197B;
	Mon, 27 Oct 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9puPOaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540CD1A5B8B
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586410; cv=none; b=jRtUBvu2v2yN8kblco39eTI1L3NIdhg4v6gHDj/2alNpBHb7HJqx2NSvriERbrRYuKRKotd6zyeA5RYAJjWh1NezI62XHDvqRUkQ7Ai2nEI73txAuyNI+Hf3+koYP+4f1UJIHMVRZOdzPeYenTc3B4SHQOOguMnB3XhwEUk7WCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586410; c=relaxed/simple;
	bh=dOaMOgWdPSwBQaDAtIKDfnU/2HKoBN8nAiCUEaGdvqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+z4eKQW+zzVhJOhvCvzCFfgZ81G2BFdRyvg5y8LMK29AZSp1SmN6Hf9KZmtUgxmzqjUvjKLMQO86bmAD9lxxApYV6dSIYrw+7sqfqmBTn1Z2ZdWRoWov4lyv3ZE/nLJXygXb1kKeunCAYWTAmd8Z2hHuuz+BGiXoZwL2G3GTv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a9puPOaC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6cf257f325so4013423a12.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761586408; x=1762191208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOaMOgWdPSwBQaDAtIKDfnU/2HKoBN8nAiCUEaGdvqo=;
        b=a9puPOaCEnAwHm76G0OPbU4f3IF2OAIc17xGmnECwMThF/EDEfF+b+VnEvouU8856u
         mPoFWsz48v+heeofifvwHkWOX2rJBuxzLa7KZxwl75dgoHyi8RAfCJivimWzDzbcI/MZ
         sFfaxN5CCpcD/ZkebYJb9v+gu8Ejn+tf4oGf5t85p6los6990yDTFrVVHQilWMv10HyN
         dxgpleNUyNjbkQvvEaQD/6CQKyW/osvJsIWNEGC2bz0KOBaXmD4WlOAjqvxCHhxFcmp2
         OVrKyNE3v/A6RPJA7pg0GID/Bf4UJ7htUUPxKQQBEDOCn46T6eBkcTuy7uTdNDGnO8Ms
         A3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761586408; x=1762191208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOaMOgWdPSwBQaDAtIKDfnU/2HKoBN8nAiCUEaGdvqo=;
        b=aA8S9DKDD+uHedt8XigA5rhhWOIwXzc+r1YJUCEfq/6hFXwXNK5FCP+arBNQhMRgQw
         0MNblg42RqlS117Iza7xoZTvTZs25/XvPe8jGyGcvoiWDJ7+wXw2DDfWOWG3mgqKEkpg
         JVajGLCx7RW5puNRbL/1X0mq8RRfdwV1cdqXkjvzNSflzgNj5o+CytRoDrKE62Azafhj
         T/7RMFC0ZbVunijSTocabJmHnIE0pS9bR1dMygpNsfEIbxphh60KswIIa4G7lyFw97pe
         M+6oYoDJef6PzLi8Q2YLLlp0En9Vfqs9/CljkJi3uLPvkpIBRitTzgLoCsIQTWa6+YQm
         nePg==
X-Forwarded-Encrypted: i=1; AJvYcCUrm3uQC521cDueou88m6bQMqrNFJCC32NW2YQepg//mzrCKmuqrc5iPykCZqP0omsibXgIXTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszyXfftUOy4fog+g19sCGPAgYv37bMqmFfX3h0hdrWuwTukqz
	UYg7WKg3aacjOgSopGvdtokosgISdUQx6x6kynnSgJeIA+B+hTWPFViLrxU6jBQ2QSctlb/XhTZ
	lxM43w6mKnivTrJYM6difKgQbcj/an67csbz8l8pwWdGJl09x3rufncL+D00=
X-Gm-Gg: ASbGnctLLcVCZ8vSI7wQlZ7sRcGkyir3yAf2bM3jkFAhwmUUy0rj4GsDC6kMIwiUwTt
	fhk7oTJ8PF7QXgIDbrhxTNiptS17DrDyh4O6QLjP8sWdWOjeUolthKc0law+g9rWFrYghyfi5iI
	w4S+lLzrWEITr398BZB3PQP5gFcszfWj/90GgbJpanKjh00a/NUcKbBiF2iNgFj/oYccdn/L+1y
	CMr1KdDQ+FU8lR33DMz3mNdIbM+TrO+MPDs3JsjpC28EOtOUJwQi3pxZshaavv3DuBqZjfu8E98
	X2x9ygFtU4nE42Qc3eMpi4A+8w==
X-Google-Smtp-Source: AGHT+IGVyFzmmT8KAE40Vr+40sEeQEEraeWaw/Va6KNWp2UmPyIPvjwYZZf6uUwC1GRO1zVxYdIJciayFW8fona361Y=
X-Received: by 2002:a17:903:38c8:b0:290:2a14:2eab with SMTP id
 d9443c01a7336-294cb3785a8mr8345225ad.11.1761586408263; Mon, 27 Oct 2025
 10:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024120707.3516550-1-edumazet@google.com>
In-Reply-To: <20251024120707.3516550-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Oct 2025 10:33:16 -0700
X-Gm-Features: AWmQ_blhLuLkzfgTgvBjZT5bQIuWVv2Azv7M8xWXUiBwRoywNXbeC_iLrrgLF2w
Message-ID: <CAAVpQUC4W2apjwr87D-bxJgGzyAJ82OPZiKRai6+4TFfre+NQQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: remove one ktime_get() from recvmsg() fast path
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 5:07=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Each time some payload is consumed by user space (recvmsg() and friends),
> TCP calls tcp_rcv_space_adjust() to run DRS algorithm to check
> if an increase of sk->sk_rcvbuf is needed.
>
> This function is based on time sampling, and currently calls
> tcp_mstamp_refresh(tp), which is a wrapper around ktime_get_ns().
>
> ktime_get_ns() has a high cost on some platforms.
> 100+ cycles for rdtscp on AMD EPYC Turin for instance.
>
> We do not have to refresh tp->tcp_mpstamp, using the last cached value
> is enough. We only need to refresh it from __tcp_cleanup_rbuf()
> if an ACK must be sent (this is a rare event).
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

