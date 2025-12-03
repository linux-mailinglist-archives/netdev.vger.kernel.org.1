Return-Path: <netdev+bounces-243381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8457CC9E7D7
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 10:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 848F84E049E
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED352D8779;
	Wed,  3 Dec 2025 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QA9mr1MG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420021CFF6
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754384; cv=none; b=hBwWVEB+ccU2xfoJLo4XOO8pQF5UxyT64tAOY5S5mlGpOUGS+akF2ZXP/UxRUUisaJepHTT5MyELG5QlIkdsbef1msOD8xCIF9iHqGhJ/lrp7j1edoBB1B/uKVRTe5yZlR1n/dDPz7UpkYo2ydID5cLCy2lgJEzjHf3kva6G/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754384; c=relaxed/simple;
	bh=2DYv1agfJ9n9VkMlSI73M4Hj1+2Hc+Ie0drsSYly99A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkjZZdJLQG2xuf5fnvc1bGoRTPxYM6uoWce/8O5sf21rT/upJ0HiFnI8RR0Qqr8rb3dpeVTk3gEai2d4rSrdicKON0aFagD/g+QEAm6c/NtAK6q4m5JAm9MWwiIBnfKWCwMwLDeRzOYO672PZUDm9YdqLM9Lq3ddJB2eI//WMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QA9mr1MG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed82e82f0fso50767631cf.1
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 01:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764754382; x=1765359182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRC3rnLtuEd2lfCxmjxDFYLmH8sArIj9NispACXVl1w=;
        b=QA9mr1MGohrOXc5L0WiPLt1zW3CE3bFjxtV2QwvIqwSqLJ2IdHkKTDEVQwbXTatHyi
         vOw/VIbOgf0CUDFEGtsKMp2XpGIweeq/02RxLT9K4Df70B+xB25+BUYUZCSbUwUQ1BQt
         ay7C4Il3jLheTX7z63DMoq/HkmWm+jNIvGEfgQ+3Rv1zN7kONShSrld6wErWWIyc/wAz
         CKIq3m76M+xk4wc1d4VaqRKswOBTCkCbfjVS3rvooq5AL3oyZ0xnYp4SevM/lcEnQHn2
         wTWXDBKEVOLjFVlcoBgWOf4+KNcFoih8cFdZD73N3KWyQnOTvqKq4GrLxIxqVrQqBBhi
         E+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764754382; x=1765359182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRC3rnLtuEd2lfCxmjxDFYLmH8sArIj9NispACXVl1w=;
        b=LuVwxJwl0n56t9wmd/YCPuIfphvNGhVMFyBrfwU68NeCag5KQrVJiq1cRwvyB/bijK
         o6NiPvyKfK0Tz6Uxn7ikd+0xYRRoe0aJxNeYsvgaVwsJOK8hCQ+La0svJVAuR1KTGs+k
         kMc8Qjz2sphJTm2glJLIZR/Bhdgu/gEQYWvx8JsgPXOeqZ8hlL20qC5IFLSL9+/Jpkcm
         rvIpt+6GD+yRWgtPoL5G5z3aQQQRbhapZ1mOpjDG1D3vHNOE2LN6E8Ri3/27yLigQtKN
         +xVWGEREeo3LJxkEARcQ9dwr3Bm3P4ax3febGK/TDMYJkgG/ZhQSOawIu7JKpB8B9CdO
         tuFQ==
X-Gm-Message-State: AOJu0YxYkCFgRmV/rMAB8kW7k1d7+OEqYns9Be0O/5qVb2ovgldMhyiX
	O4v6Qx7M1QYzqOlsPPh+0GmHkbZQOxvHVU+uN3hUP5uExWTvmk3zGHmb3hos8lJBnkkXY2UntWQ
	wRPv+4WH8LLjhEtaeTfOTV8C7p5vhkGrW5cuCeGZR
X-Gm-Gg: ASbGncsqkww5dUgS0kOstYs0HeTiRr6M5tCDwx8Z5xutQgBXEkC2fWhEA489TEuqvQm
	b4qA0y86o5vyD8lPJbPAOUHpv98294Zuc5dF0dke1HS68IZtKkig6iP9LEneRbC+VibgOC2Tfkj
	pQCOj+Yc/ivKLiOU0NLISInILKxTGnPT/H8u7HaSf4xX6fPohwUJkk9gwO7tYE7PgDwN1xozlFW
	yOqlXhbF42ZxQ3r+AuQvvdhv8U9GkpljNh1JhLZFsgEU9ucDGWRRSHA8tZu+UimBObEG/E=
X-Google-Smtp-Source: AGHT+IG9Q6pBViYhFWM/lqWF1UIHccIroB3GviAPLH4oj7ED4doZDLxHNZ7l61rAybvudv1AAVfY8oahZzoFPp+HqRM=
X-Received: by 2002:ac8:5952:0:b0:4ed:6e70:1ac4 with SMTP id
 d75a77b69052e-4f01760340fmr20016111cf.42.1764754381945; Wed, 03 Dec 2025
 01:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKrymDR1X3XTX_1ZW3XXXnuYH+kzsnv7Av5uivzR1sto+5BFQg@mail.gmail.com>
In-Reply-To: <CAKrymDR1X3XTX_1ZW3XXXnuYH+kzsnv7Av5uivzR1sto+5BFQg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Dec 2025 01:32:51 -0800
X-Gm-Features: AWmQ_blkdfwgIvsjfItsYshwc_eABXQWA83bk8bwk4zEZ83IVLlfJGBJ8jXyprM
Message-ID: <CANn89iLb-0kDwYerdbhHRH_LN1B3_gSKYOgu8KENQsk7akX-WQ@mail.gmail.com>
Subject: Re: [PATCH net] atm: mpoa: Fix UAF on qos_head list in procfs
To: Minseong Kim <ii4gsp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 12:57=E2=80=AFAM Minseong Kim <ii4gsp@gmail.com> wro=
te:
>
> The global QoS list 'qos_head' in net/atm/mpc.c is accessed from the
> /proc/net/atm/mpc procfs interface without proper synchronization. The
> read-side seq_file show path (mpc_show() -> atm_mpoa_disp_qos()) walks
> qos_head without any lock, while the write-side path
> (proc_mpc_write() -> parse_qos() -> atm_mpoa_delete_qos()) can unlink and
> kfree() entries immediately. Concurrent read/write therefore leads to a
> use-after-free.
>
> This risk is already called out in-tree:
>   /* this is buggered - we need locking for qos_head */
>
> Fix this by adding a mutex to protect all qos_head list operations.
> A mutex is used (instead of a spinlock) because atm_mpoa_disp_qos()
> invokes seq_printf(), which may sleep.
>
> The fix:
>   - Adds qos_mutex protecting qos_head
>   - Introduces __atm_mpoa_search_qos() requiring the mutex
>   - Serializes add/search/delete/show/cleanup on qos_head
>   - Re-checks qos_head under lock in add path to avoid duplicates under
>     concurrent additions
>   - Uses a single-exit pattern in delete for clarity
>
> Note: atm_mpoa_search_qos() still returns an unprotected pointer; callers
> must ensure the entry is not freed while using it, or hold qos_mutex.
>
> Reported-by: Minseong Kim <ii4gsp@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
> ---

Thanks for the patch.

Unfortunately it got mangled when you mailed it :
https://patchwork.kernel.org/project/netdevbpf/patch/CAKrymDR1X3XTX_1ZW3XXX=
nuYH+kzsnv7Av5uivzR1sto+5BFQg@mail.gmail.com/

Documentation/process/submitting-patches.rst might be helpful,
especially the part about git send-email.

Thanks.

