Return-Path: <netdev+bounces-195815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8675AD252E
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19FC3B1002
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27181F4191;
	Mon,  9 Jun 2025 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwN6oNul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A510182BD
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749491259; cv=none; b=LRFzmojOYrfdkP+/jb8a59p/Zr0jeZGeve2fF+2t+OE7tVinabJ2zk88Ku/00n8+w8R/eHjuVFKCdJdrZOsho21OMrNTcq/sAca1XrnwO1pCRymM8IZg1J2G9qmm3oSmUPGO/8MtFwE/WmV/22J9qSv1yAXecyyInn0uOP77NRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749491259; c=relaxed/simple;
	bh=YhU1B5EijpvVaqktoQ9SMaVRarXtQPwdfeQp87o0veI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ju8rM8H04tBE4qn9GOAaqUWLabxJTIuc268lWuyddIHV9OjMXFb9kbuM5k2//Z+2v57UTgDEkWtkkokXUaamfBTU6eBbGmSjPB+DpifUJiQIdRAwG0eaWu8GFmM7tMCtEJJfBa//aaHDbE1Iu0DrYvwUv8vd+oRqPzCtd9r7GW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwN6oNul; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a5ac8fae12so51011cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749491255; x=1750096055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhU1B5EijpvVaqktoQ9SMaVRarXtQPwdfeQp87o0veI=;
        b=TwN6oNulZi1HBecz1s6n0HDgjnqp8FOG/G8UwWg5OEPxv01HbOjEPZLUwzsRZ+A1Te
         FVI4FhU1Otv+uMyZnZGD/wcZ4yHSm3M8AP0GDB47YDVUs99kV9ewiBNx+joM9560NDM8
         3k7EO86ZHpqV5YfEcmBNMXdSB0BX6RQ7+erJRTyeSGd2gz9dR7aGdwF3K4vWxQgtm1AR
         hkyfYsHW7xBLCi5/778DpdwwK9leHXXaLybXspYcE8QUK/qiWnKneilIJiVteS5+NvRb
         dd11nlBpNBmHqK3eKvRX0SkSAOrMRuwmJ9EUMKoCaIZbMrdgBHtyzj4qTSnq9R5kI6TK
         tVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749491255; x=1750096055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhU1B5EijpvVaqktoQ9SMaVRarXtQPwdfeQp87o0veI=;
        b=uuRdbN165K6N1LUPWSjCvneNM/iT74xxlYDBlRa+Pa6oFBUmDrdQfk+UdO/KVGSKHo
         8gyUu4cxUM58nocH6jekYZvUS0zojwG+ktexF3SfMF79e4QkgThCr4bdzJsGUWalhcqn
         rVaA75L+HMxJwMKsI/2ALnmy5QA8egcy6Y7nndkMRhTHJIsqlVtKpNU37pzIMB0bK3E/
         LxKSkSGjoQboZEqXG3YsWaO3xBZcX5OjQOrx0a8dKV100w9NDkKzahlY6imXDS29EucS
         hpwdBSpkSHwcqmNC0wZgd9V6kj8RCk/XSoxgmdENqHqWp88loe/PNWT6RY5x2cSPHUex
         9zUw==
X-Gm-Message-State: AOJu0YwIzSUFb2SzaHUrdirjNhloZd5Zpco++e0xUNxrWUwjnn/aboGG
	fElNhMcka8inuqzwudtpsGY2WVdcJoXvxiyt1RiOA6HBLvjCB+CaOxRaIueXsTcODW/seRlEJ/i
	LVBBR4kNalvaKORZzzMTeQhI0iT6AmGTYSvZvpJDL
X-Gm-Gg: ASbGncunkiZjAU36OLsCWX11t2zmorNb8ABMGjmdlOh3S8TiiJiFGINsckd03NSUAtf
	grizdc3n30SCjxAgCasa7GOHl4a2cqH4bXC9HKhHJcGwtZ0SrlyNTeAqb5NXQ5FGWuvEBuDJZ3/
	JCGW2YIpmqzm6g3QPbxPVNlgvr1YCKACqdeEZ4pkr8GKJaK/S9CSPCIAAxFLhmkoOx4L0uZtdeM
	8J0
X-Google-Smtp-Source: AGHT+IH3dKM7j8nYibjABSANb1FztdvSCSQgVBQbAajBR9p0CLfMGmpzrPXVD/uFCXxDqtc1ZX3hrKWXG+JQprEkWNY=
X-Received: by 2002:ac8:5e4b:0:b0:4a6:fc57:b85a with SMTP id
 d75a77b69052e-4a6fc57bd2fmr4495041cf.14.1749491255040; Mon, 09 Jun 2025
 10:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
 <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com>
 <CAAHxn98G9kKtVi34mC+NHwasixZd63C8+s5gC5T5o-vKUVVoKQ@mail.gmail.com>
 <CADVnQyn=MXohOf1vskJcm9VTOeP31Y5AqCPu7B=zZuTB8nh8Eg@mail.gmail.com>
 <CAAHxn9_++G0icFE1F+NCfnj3AkErmytQ3LUz2C-oY-TJKbdwmg@mail.gmail.com>
 <CADVnQymURKQQHHwrcGRKqgbZuJrEpaC6t7tT7VeUsETcDTWg2Q@mail.gmail.com>
 <CAAHxn9_waCMAh3Me63WQv+1h=FmT10grA13t09xaym4hX1KgCg@mail.gmail.com>
 <CADVnQynDkHVmTdnMZ+ZvDtwF9EVcOOphDbr+eLUMBijbc+2nQw@mail.gmail.com> <CAAHxn99QAYkxcAS5nKdaR93taCPykzxLXOXEJfDh7a1k0y9sug@mail.gmail.com>
In-Reply-To: <CAAHxn99QAYkxcAS5nKdaR93taCPykzxLXOXEJfDh7a1k0y9sug@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 9 Jun 2025 13:47:18 -0400
X-Gm-Features: AX0GCFuGJcKJ-J9f2xRRct5K93_iCG5bcN1NRi-VaRiq6LhKOmm5riw3G799aoc
Message-ID: <CADVnQy=x9D7ad8LGpBTj0CUeEXCpqLiiGsbdoy8se_epUckdzA@mail.gmail.com>
Subject: Re: Re: [EXT] Re: tcp: socket stuck with zero receive window after SACK
To: Simon Campion <simon.campion@deepl.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:27=E2=80=AFAM Simon Campion <simon.campion@deepl.c=
om> wrote:
>
> > I agree it will take a while to gather more confidence that the issue
> > is gone for your workload with net.ipv4.tcp_shrink_window=3D0.
>
> To confirm, it's been over a week since we set
> net.ipv4.tcp_shrink_window=3D0, and so far we haven't seen an issue with
> TCP connections being stuck with a zero window and an empty recv-q.
> So, it looks like the problem is either entirely gone or occurs much
> less frequently with net.ipv4.tcp_shrink_window=3D0.
>
> We also attempted to reproduce the issue with a program that sends
> data over a TCP connection but leaves out the first N bytes.
> Unfortunately, we haven't been able to reproduce the issue so far,
> even with net.ipv4.tcp_shrink_window=3D1 and with a system under memory
> pressure.

Thanks for the detailed update! Those are very useful data points.

best regards,
neal

