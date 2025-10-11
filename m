Return-Path: <netdev+bounces-228601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E1BCFA5E
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 19:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51F618974C6
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 17:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E583626E6E6;
	Sat, 11 Oct 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHHmNeJ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B318A6D4
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760205519; cv=none; b=Q7DFQOURd0sabJu8nJmCFSPn7hvxq2xNqkGIa0pbY8cwy7zNa6PENKRg0oewDG7kX4AJEQksGEV3ttym+jjY8+T5YdfJUGOKY/dptqzLxY9GBwcUgkAwdhK/HiRnwbv7dx0O+TgYXpJa8vPA28wwdbzqUs9Ok1msHRB9w8O2/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760205519; c=relaxed/simple;
	bh=ztCgEjeSm5QWfKdIMsylb9vBpYZ8dXFKl7yZOD1ILT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYiLlN2Bkn51Jzr5K3mRm9zhxrVL7B0zEggwyKPzXl/yrumazDhNCbRbNkpublldESDsE/j3YHKndAV/i2Pr3edtMVP2xHdqDEybFu8ZlwjroEcQU3bD9sQoJrdYxvwFLwpZ1Y9Hen3ZKwqNHu6kGUHDr1AGWL11Y9A7ia79pnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHHmNeJ2; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4308afd43f0so340605ab.0
        for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760205517; x=1760810317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4lOKDIigswOdW3lLMRo/9I9yN0tcBS8IM0nhuqIKjI=;
        b=YHHmNeJ2XY4hTOBijIS72iIVYe/tbMtxVb/sz64iJE81gJps3scHp3dWrigQvXJ/B/
         jrTG+Xtb8WWFzqan+3i9io3glY6Y0xPAWAXxAoWPMFsOZQqhrN8R8FkxMlehJIgiGUt5
         q/0ngJ8dqxw0CU9t85l+/uDK892qomXwau2EnPbykP/Yyl2jHpGdz8ngNdvjIPpnbKKJ
         9/CuToslTlcAgywQerGMUMvCg9LZ9Oqyc9+ODRuBvy6skTvJeZGNZcuEXPYFYpuG6Ual
         rOQCutz/DouUorew3DKfA0sJsXLYh4+5o31HQ4TU7zr8Kwai9MluAMLl7rcRst+ADcvE
         64YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760205517; x=1760810317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4lOKDIigswOdW3lLMRo/9I9yN0tcBS8IM0nhuqIKjI=;
        b=M0sOw49bGH4s7tFYEV/AvcSrSe7ZF55WUyo4xVo2rI+8b6zP8vGj3W3vrAk7IVmd2Q
         YycpKQl6APqG1mXEkaEXPr3f1uBobt2dp3QqaENv7I5duipWKQCW5OwgiLX9ySru+G4k
         QOrvi3uQxEpWrPa41F8i4j7Ohp4gAl0p7UBLB2wOUq8ayOB2+HxiE8jM1A3mHvWK3CyG
         SPKydH9WpES4T0qPSTQz8d+3SvSx0h8L+wJf1nBI56KgTPuMReCFNAnWXTXAYSmgtRnK
         x0+y4M59usBi6CZsYQ5ikwfAsfuHaSEiT8gbDgXD1OfLGRzL1xjv116hMRDeV/79lnDL
         /XgA==
X-Forwarded-Encrypted: i=1; AJvYcCX2WGxLcVt5yfHqB/24ZBVSc8H22qR9pHl/G+LNo6PlasIdyFoABgbgDCI8S9PX3gpUPyl9BW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJxIvuNah4kFkPYoplQaCxcEQ2ac5UgUH/jo3yOvvLOJPkufF
	bOY3wX+4o00YxT+fIOie6nTdWBH3xS04MjZoBshB3GvGoHu93SfQf72YWb8C50BatQJItQM8LiX
	IFG2Of8ibvjq9fB9DZwIlWY/OSL1ftIS0FUgEfjIw
X-Gm-Gg: ASbGncvg9SP20/kFq/xy/oLizr+PFnhKU26lyJ70P8DsUWyBS1oQMDJBeU22KAwB5Fv
	VCoSJGBQft5PoQ2gqH3d6enJ1qMe4ARtNMQGyKZ2y6Zjw7rB83bL+z8/yMkdpxlf4Um0fjHHrOi
	VpCARSIbCpFIledBe349bHgiLMMP5d0I3jJILapN7w1PNpVIDA7U3ajIA0lDpJtIFGSdCn0rByz
	ka7u1u3j0lmgOLwZm1xdj9ARcaD1EJq2kV6XaSHrRT0KVcLRhDaAWIOFmUGuZQ9Xg==
X-Google-Smtp-Source: AGHT+IGUDqO7luDHtkmTjoqJwkGD7U99l1JHor+zAnAZOiHcypaKl8AmMXqgeWg6QNaYxFYI5NpC8dtQMSaiQpOB4ug=
X-Received: by 2002:a05:622a:4889:b0:4e7:1e07:959c with SMTP id
 d75a77b69052e-4e71e07992cmr855061cf.10.1760205516982; Sat, 11 Oct 2025
 10:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011115742.1245771-1-edumazet@google.com>
In-Reply-To: <20251011115742.1245771-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 11 Oct 2025 13:58:20 -0400
X-Gm-Features: AS18NWAQDqsMVv0QeNLgSz-sSH_jw4As6vO2O-oEzs5fdUc5XAh51ozfTSglxNM
Message-ID: <CADVnQyk7M2Z0fz3ub_qpVyW16mpEbRWjRudpRzzTvOMA3j9fLw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix tcp_tso_should_defer() vs large RTT
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 7:57=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Neal reported that using neper tcp_stream with TCP_TX_DELAY
> set to 50ms would often lead to flows stuck in a small cwnd mode,
> regardless of the congestion control.
>
> While tcp_stream sets TCP_TX_DELAY too late after the connect(),
> it highlighted two kernel bugs.
>
> The following heuristic in tcp_tso_should_defer() seems wrong
> for large RTT:
>
> delta =3D tp->tcp_clock_cache - head->tstamp;
> /* If next ACK is likely to come too late (half srtt), do not defer */
> if ((s64)(delta - (u64)NSEC_PER_USEC * (tp->srtt_us >> 4)) < 0)
>       goto send_now;
>
> If next ACK is expected to come in more than 1 ms, we should
> not defer because we prefer a smooth ACK clocking.
>
> While blamed commit was a step in the good direction, it was not
> generic enough.
>
> Another patch fixing TCP_TX_DELAY for established flows
> will be proposed when net-next reopens.
>
> Fixes: 50c8339e9299 ("tcp: tso: restore IW10 after TSO autosizing")
> Reported-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Thanks, Eric! Great catch! The patch looks great to me, and I tested
that it fixes the issue I was seeing with neper tcp_stream with
TCP_TX_DELAY.

Reviewed-by: Neal Cardwell <ncardwell@google.com>
Tested-by: Neal Cardwell <ncardwell@google.com>

neal

