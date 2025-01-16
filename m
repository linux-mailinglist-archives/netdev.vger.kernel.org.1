Return-Path: <netdev+bounces-158935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1379DA13DA4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6903A9C08
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC9635968;
	Thu, 16 Jan 2025 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpdo5BCD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A712BF24
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041426; cv=none; b=jqwKGBLN2KldroX1gPdjCrX504SfhJ+mdstxRjteziysVa/UEf4hqj5nIWleXry4OiQraH7HfRFKzAEmjlNHCnLat+bRDmn5B5fTJiagVJ+G8GMXXpRfQsUkuhsPEAwTWuS4MjYSyzYD2OJXWUgMfJ33yCaS65wuJouo1qbB1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041426; c=relaxed/simple;
	bh=H+wJNJJb1N6FKJqcKXUDaiMLQ5FpwEyXhKeFs5Ra0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Omh4CUwmm6axjZ+z+8vyOXocJeZdvr0RPL+NGS4iF0HMffeTActe7mz+l3e4TY/z6BTevgQEsrkt9hvQbCFBpsH3nSpKzF5hwL47rr+ISEs70QIrQdE1eWZIzcZY/eUCKk9pmP+W73gybF7tghVjl77THZYwWLGAoCRSkXTW/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpdo5BCD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so1469024a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 07:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737041423; x=1737646223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+wJNJJb1N6FKJqcKXUDaiMLQ5FpwEyXhKeFs5Ra0+o=;
        b=tpdo5BCDyfUIYxcTvh26nXUB5PnE2rwF1gQ6yxxc7ZEYmM5lRBmnRmxHc9aYTjhTHa
         TZvXMpPEWJ3TKwAmpzzbFCaLXOfUPOJwWcPHViwe7kld9wSF8uRez0m8ESgcRi6JAuea
         yHsCBbImycKshWpJZqJmtkqu4MpbMdN2LFqKBlqGhlSpqIb4S4M7KKTWo/fF2MP1QfPr
         fA1H20NIOZGOXEVu79WvoUDNZ2lUfItSsujwDzzUQKiRRQSbdWu8nXU/2Xw+hMaQR9Tt
         nlNBLb0M64c3ZWtCMcVrl7+338bVb6JYiIQ3RJwYc0/hn/+buvgudec4lPE+g3sfXnsI
         3tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737041423; x=1737646223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+wJNJJb1N6FKJqcKXUDaiMLQ5FpwEyXhKeFs5Ra0+o=;
        b=xUpr2ER8GRdZEGpRwGctl3GCELDXgDzJAhqqdL0A6k5jXDNu58jzpvtVo/f9xRJycV
         C4JSn2VeSY8g31LhTX/60P+ejYGERaon4AzgdEBQT+q3gVYnXYgIx297jJ+wHtI9VEEc
         5jRHzO9+prNsu+POetWd+LyOVDHvElqc4IoeIGWkUy1Oxy8XXJo0fCA6EAxRPmSMuUpu
         jhD0tNrHEN3xEYvpFbbJWyC52ZiBp9FEOqEw0EtnuN0YIDdFNtj5ThzBZe9/vPnI3dCB
         qrWeghznXgUJaibkL2mXkXnEccfz3Mdq5/X/nlyQUmeNnVlRxKpWs1TBAIMwEJeAgn9W
         GOjA==
X-Forwarded-Encrypted: i=1; AJvYcCXsYDQ/f629VRohZY28FIVRYmfXYLpOBBKPW9WoeyLqfVh595mt31y9v7OG/JSCU4rT8Mtj7OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/8QDt0O/KWnsRcx2QSwERJOK9XbU/a6i/vH23c91Cv4oprHV
	jHQmOet6lKSHcZ8fckgqEnc6rAmTCRMHnAJC6V1l8ZxhdLj+5gnfwzoMu+/m9cGxxfvn61FRQdG
	zYuBWBPT2NX2LCjxBQmxDHoIald177lP4uGwH
X-Gm-Gg: ASbGncvxGziTLPIwX4UVwzIUf+EKjzngoZWhw2ahTUiDLa2H3LcgeAUP20/+XVC5qLK
	XpF1fXAZoKL10lMM5gv+SjIV90rKzds9Z2D6l
X-Google-Smtp-Source: AGHT+IG96xH0lX+KT49SwN7wIpWAnhUmxscKBwEmNN284TIzYuqpvR5tdwJLaL3okKC14Ca9n0bsHj1begHgqYLQKok=
X-Received: by 2002:a05:6402:210f:b0:5d4:4143:c06c with SMTP id
 4fb4d7f45d1cf-5d972e4c99amr26896481a12.23.1737041422999; Thu, 16 Jan 2025
 07:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115010450.2472-1-ma.arghavani.ref@yahoo.com>
 <20250115010450.2472-1-ma.arghavani@yahoo.com> <CAL+tcoAtzuGZ8US5NcJwJdBh29afYGZHpeMJ4jXgiSnWBr75Ww@mail.gmail.com>
 <501586671.358052.1737020976218@mail.yahoo.com> <CAL+tcoA9yEUmXnHFdotcfEgHqWSqaUXu1Aoj=cfCtL5zFG1ubg@mail.gmail.com>
 <CADVnQy=3xz2_gjnM1vifjPJ_2TpT55mc=Oh7hO_omAAi9P6fxw@mail.gmail.com>
In-Reply-To: <CADVnQy=3xz2_gjnM1vifjPJ_2TpT55mc=Oh7hO_omAAi9P6fxw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Jan 2025 16:30:12 +0100
X-Gm-Features: AbW1kvbAqQQBZaputEazZcjPDUoqzYWveg6Y0XMkoxOYp5HN2VNZiaM-ASqRKtM
Message-ID: <CANn89iJfx3CBJYBS01Mz9z3twjsP3xvSSOamno-cYSSzv3gSxw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp_cubic: fix incorrect HyStart round start detection
To: Neal Cardwell <ncardwell@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Mahdi Arghavani <ma.arghavani@yahoo.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"haibo.zhang@otago.ac.nz" <haibo.zhang@otago.ac.nz>, 
	"david.eyers@otago.ac.nz" <david.eyers@otago.ac.nz>, "abbas.arghavani@mdu.se" <abbas.arghavani@mdu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 3:42=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Thu, Jan 16, 2025 at 6:40=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Jan 16, 2025 at 5:49=E2=80=AFPM Mahdi Arghavani <ma.arghavani@y=
ahoo.com> wrote:
> > >
> > > Hi Jason,
> > >
> > > I will explain this using a test conducted on my local testbed. Imagi=
ne a client and a server connected through two Linux software routers. In t=
his setup, the minimum RTT is 150 ms, the bottleneck bandwidth is 50 Mbps, =
and the bottleneck buffer size is 1 BDP, calculated as (50M / 1514 / 8) * 0=
.150 =3D 619 packets.
> > >
> > > I conducted the test twice, transferring data from the server to the =
client for 1.5 seconds:
> > >
> > > TEST 1) With the patch applied: HyStart stopped the exponential growt=
h of cwnd when cwnd =3D 632 and the bottleneck link was saturated (632 > 61=
9).
> > >
> > >
> > > TEST 2) Without the patch applied: HyStart stopped the exponential gr=
owth of cwnd when cwnd =3D 516 and the bottleneck link was not yet saturate=
d (516 < 619). This resulted in 300 KB less delivered data compared to the =
first test.
> >
> > Thanks for sharing these numbers. I would suggest in the v3 adding the
> > above description in the commit message. No need to send v3 until the
> > maintainers of TCP (Eric and Neal) give further suggestions :)
> >
> > Feel free to add my reviewed-by tag in the next version:
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > Thanks,
> > Jason
>
> Mahdi, a few quick questions about your test logs, beforePatch.log and
> afterPatch.log:
>
> + What is moRTT? Is that ca->curr_rtt? It would be great to share the
> debug patch you used, so we know for certain how to interpret each
> column in the debug output.

+1

Debug patches can alone add delays...



>
> + Are both HYSTART-DELAY and HYSTART-ACK-TRAIN enabled for both of those =
tests?

I also wonder if cubictcp_cwnd_event( event =3D=3D CA_EVENT_TX_START)
should also call bictcp_hystart_reset()

cubic was not really expecting app_limited mode.

