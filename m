Return-Path: <netdev+bounces-251391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82DD3C257
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9FD8605B17
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF47E3D6682;
	Tue, 20 Jan 2026 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMStobre"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137083D348F
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897148; cv=pass; b=rkvXaiFJtDs4Ia24a2nZyIosuKCuJLk7ZiliNKePgzjPE1kC/wH4YsE+ICjsx1v89FO2UfyQSIwAEFQV8dew4oQExLQ1+3Q+rAHOLZmI1YCdFxPYziSpqQDlWjfyp0ccWnX1gnMIRiRfjui2/4TRMjfhFNuYLZ34nqnYJLNpOGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897148; c=relaxed/simple;
	bh=qKOfXYGD97q6vOh6lW5kdz7Yfd6NWQKy7hK7jp8SDNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/Fe1JndR8Hmikny5GuaAjShYNCzKxYlX1WEzWWdO8BTYeY8VETH9IrF1VJmyR77Cpe5+mcZx3+k6C+9Atq7e1cQhhdRy0BvzHnJjXdGwataEigQ7DpgHglwjcF+wCX6mXPerOsO49g+gY+xutxadWyFby6lk5Vh/PX/wKVsNHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMStobre; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-382fa66fa9dso38548041fa.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 00:19:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768897145; cv=none;
        d=google.com; s=arc-20240605;
        b=VMWXCsg4DRD2VipxlCEeeRchpwvFS8CtooiY0hbXBfrd+v+lX4obHoVk+pUYz0OXSc
         zJsbzlAfjb+JXPlUSpIxeNURQ2XhBv+NErQH5+s4e5yJcug3maAJYgLZy3T9zEhQ8CaO
         fdcfIVstnI53iOx8lf4wbhI1urjSCU+xRcycpa5A1/GSs71r0rUVa29GXjviJYdLYNVo
         30t/+eV/VOXr0zZ9bH72ZSzb6KEOF01TooluaRnq878iXsTEGvZWccMkXJt5Yb701BUO
         2dsrpIx670+d4441n+5bWDuiV7v5hlLo4o1eMM2hEdcWJkazQ+TdxJ5DssJTPQeEhJnh
         B0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qKOfXYGD97q6vOh6lW5kdz7Yfd6NWQKy7hK7jp8SDNI=;
        fh=xQ+zEMP8RY/SKuW3De0HSf4J6A7UM2J50zorTjAoExg=;
        b=KDlB5YoyAZ5LfAMR/mNgciJf/j4syD1f2XPt8TTHKTORlWe8Zm1ixWOEZ0ymnLrzgT
         mPgJkBGIFgB4DYBwa/GzPtNhI5bbESYAGnu0Vh9FM63dsq3YSdvw/Zd96zgTygvqKZSS
         2EYK64SbVEt2HFAQIfzYYUWKZEwWV0KHMR+NEpH2Di1dQs5WsBFhU3bI9mA+JwahQAE/
         Rz9wueOc4shmVFjaR8Adbx8vj+RoabDx1fbQgufEJ8088qQftX7epx4VKgmDbfCiuxJT
         L0dPbg7dYj5LZFEGYArIq5YlDnxtfFPbuiDS34d1J8Oy7arp7RtElJ6YieK83Q35aCZP
         492w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768897145; x=1769501945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKOfXYGD97q6vOh6lW5kdz7Yfd6NWQKy7hK7jp8SDNI=;
        b=HMStobredgNr00dFMgsj4PtHADsi+Anyjz7cM0WQkjeos5l3BJWscQnz3CUERUMVXE
         36gBM4CHpMYzd4C6PTSeY+Ptilfw+ADpkORav0LDDLTqCL8lmbDF53YxSKi78HEUDeGE
         ELbiAK/4JC4iBnmXJvi9Y8B5Jjw3OH6YTrRukyZjS027kVQ7TJnGa0EASZ2tTK+nEF08
         6BTJKqKS6VTRJDJFZTdIWDPGQl3jYQlCzZkyvq/YTdN48lTO3cy5P848vGir4Z6Nhhly
         Rg0UzupTXmqMl2KXEh9dYuK5USyHoqr/B36O6CbEM12qFQbte3evodNaSgTedi2kxHnT
         yBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768897145; x=1769501945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qKOfXYGD97q6vOh6lW5kdz7Yfd6NWQKy7hK7jp8SDNI=;
        b=Me188QJpKUeyX29+vANjhOFgiiNdD9AOI+tB9gtXV2k3wQcxTaB4iVelkSvEZrVNKy
         wWw1C9FowapFtqigFyIbIrxeQ4cEVmowCGgYH82BjAh6Cd7IkzjtNM5lAaJE04FTnxJr
         6LnPT2TGmC8PHnTY7uZURRA7cSxhEQCzgfXNw2oCT1wWLFyLkHM3bsEtzY8pR5cCTAdx
         oq12w6Wgsqnp2lxk7WJ7/attI4uQWNMBlFjV0HtTkbgXrRL50xBnMhddB2us92DU3WFy
         zYPL/SSDejEqBt1SUSI6v5WyhPwEW2f7dNfUZshFmniRZRjOLgUZ83lQV6mvToEQqpq2
         d/pA==
X-Forwarded-Encrypted: i=1; AJvYcCWxvJ3gFJvW7nY7IgC/GmOl9IFf3KJPmd2Yw63LmSfNSx9VsxeeJeMxaEnTjiK4fMS/QAjYjf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsKVIfYB91EveOYxrUL4Pvl9HByvRuBBBDXo9B+8OsrQequ8P
	pPpAXozKK+sWlxU7jnl33Z0CUvCOfs7/cZSbKBtovIbqCOsOfnWs8Rwr0aIXev3v6t0LMphiiR/
	13WUIrSkGzhTF0aE78IuhMhIUyydEri8=
X-Gm-Gg: AZuq6aKYDt9jpi127ItpO/bacd6aV5C3DZrxBmyG2w3Z/thGIoAn8YPO/FEmX5jj4F4
	gwf/CSpUxQjJ3ckhjN+xGwu0u4QOgEnpgTmCGAyop+7oC4z9AS2zmZEptiHrTdNePfpSeVIT4JW
	jVfUo0STq6tujbN1SRoE4UmUax6XnP5S8cZSSCNCCyyupArgW5EKtF4CL6DPrJmA7Rnxf7ZUB6r
	jfS1SCXKIs6gpY6yt1POFM7RATnQaYT52v+e505rDNuI2jRrBuQ7MhfnrJubJiUk9VMO6Nd
X-Received: by 2002:a05:651c:19a2:b0:382:56ff:5207 with SMTP id
 38308e7fff4ca-385a54c950emr3907911fa.36.1768897144840; Tue, 20 Jan 2026
 00:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129095740.3338476-1-edumazet@google.com>
In-Reply-To: <20251129095740.3338476-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Jan 2026 16:18:27 +0800
X-Gm-Features: AZwV_QgURGFUCI_K8muYDRHsvkdWRTIzrBhGfT_zd62exZdQDk2p6UN4pLr8sGs
Message-ID: <CAL+tcoAS9u1A9xpsWaAzSojJ7qepWsvF3imC5LtEhu=zD9AjsQ@mail.gmail.com>
Subject: Re: [PATCH] time/timecounter: inline timecounter_cyc2time()
To: Eric Dumazet <edumazet@google.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Kevin Yang <yyd@google.com>, 
	Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 5:57=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> New network transport protocols want NIC drivers to get hwtstamps
> of all incoming packets, and possibly all outgoing packets.
>
> Swift congestion control is used by good old TCP transport and is
> our primary need for timecounter_cyc2time(). This will be upstreamed soon=
.
>
> This means timecounter_cyc2time() can be called more than 100 million
> times per second on a busy server.
>
> Inlining timecounter_cyc2time() brings a 12 % improvement on a
> UDP receive stress test on a 100Gbit NIC.
>
> Note that FDO, LTO, PGO are unable to magically help for this
> case, presumably because NIC drivers are almost exclusively shipped
> as modules.
>
> Add an unlikely() around the cc_cyc2ns_backwards() case,
> even if FDO (when used) is able to take care of this optimization.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Link: https://research.google/pubs/swift-delay-is-simple-and-effective-fo=
r-congestion-control-in-the-datacenter/
> Cc: Kevin Yang <yyd@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Yuchung Cheng <ycheng@google.com>

When I'm browsing the modification related to SWIFT, I noticed this
patch seems to have not been merged yet?

Thanks,
Jason

