Return-Path: <netdev+bounces-147254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F09D8BF6
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 19:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00A4162909
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 18:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E245D1B6CEB;
	Mon, 25 Nov 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fdwy0Rt/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F31AAE0B
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558115; cv=none; b=EVvfeJD1yYu1l5RVpe7gj/xLbGZxIJVrVWUHQPpj8sZILSzlnGwoczCW1evGh4LDaYinNh6jLvBBPACOlfAIfQyz9OGmU0VzXD6qU6n7mUDpa2GFWidQUaJduntUPtd66GvE+LATKLWPWfkM/g3xEWo8nb8SPD3oiWJsQkMbmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558115; c=relaxed/simple;
	bh=f/8NwLKDNGwA4BBNxjludT6JeLJQpYXupFh0WKIWdEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7ElFk/MAPRzBKy8/e4ao+ETNNQGrHFLCX3zRuW9ChL+U8VKLrpClp6CUfcfQvGNRfvaUCSXt1BKkySl7SPE8xrqtgWnGDzn9/cL4CvaviGf4FpkSfCmqOWvweQhySDng77uXg6d3aabQNLXjAs1D0DWfTPKQ7EJ0LuzqRvZRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fdwy0Rt/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d043043d46so2587747a12.3
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 10:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732558112; x=1733162912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/8NwLKDNGwA4BBNxjludT6JeLJQpYXupFh0WKIWdEA=;
        b=Fdwy0Rt/VHlqgQ0xl07X/D3HQqb15N43TZn9J8LhVyQwlhspRXvcAqme9SzgiKgX/j
         Msyflet/kAp/RTl1Y0r4MZ/Xf8ZnBhb5EVQ7Gg4IHHm2hP41wl8RA2rzfolCGfIY0/WC
         NaCw1YL4Kpam7q4fCrValZM5YTM0eRy5dvEM72dFRkFjaXyCYxin1jS/saNht61Gb1TR
         syAi/+GhoGIi18aeYFr8soAoXKfmjhJwnziXmoHIR5m/YLx50TPC9aR4Ecq4D7dpe2Ib
         4YqEpXlk/0ZeY7di5Ddx8PSAokd+3dR5/bVJUG+jIzKeI0Zvo6e/sOrOp2PCVxnA3Nsa
         8ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732558112; x=1733162912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/8NwLKDNGwA4BBNxjludT6JeLJQpYXupFh0WKIWdEA=;
        b=acOqb8FTFS5E974rbvXPmK5GkpzsElTrhqVbPeLkpbHkMS2ZWFbU/UbaC1DFNVRjU2
         fKve6Y0VdHtAo4yRHCrt6QqRz30bJ08Ak/9vSGUpUn6f/L/jsULqjgZ7KNlHz2lUnk5Y
         PdN7q2qqOIu6bwu2FyM9mYHQph6wnyQ81fRMzuFLvCTkbTR8uBXJsEUH923AqoyFz132
         LAVcYjB3wQZ2V2R38eHZdQXQD4O5Z6em/GypgUjAzxCs9Mpc5uBqwt2OkOH0O/LpWZ7K
         teeyZzIfiQyZ/LJHjScr2T+x9229LhNBtwRFBTirrBsuGb9vni8amH1Coft4toNnjJ4J
         mJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAWG232W6goc0qgXKggchEsaxWue7WUj9X7QTsiSxRjKh8U7BOFZHFFTghqsMNE5SrXRzO8OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX42mS184ildWiUsbeeBhqsh9Ltbowvx0NmHlPuouFtBnpI/ig
	OHARP0r9b7Kq61pnJz9ZnlIKZAKSjGRR6cEf3IEwt6XkyiAC5rcqgTb+MA/9hatGdrDoQSlg50K
	v39hpHykjIISZpp2zwcl7y2etCnF++PG513g+
X-Gm-Gg: ASbGncuosRvwRFYUkHS+fffmRSCPBtxPlZe5qMbPrFD5kvlH3foI1Z6H1mk/EZYA5/R
	a3BToKUrMLbeQUu88J2B/NXskkiIKFk4=
X-Google-Smtp-Source: AGHT+IHKMdoCdYVLYstvTLbkIH5an+q5VLUZCM0/VpgrdnIYU/0qaxzK96Z5d9X4Yfsfb2kU+0cF1c0TftMw/R/GZ4w=
X-Received: by 2002:a05:6402:1e93:b0:5cf:de89:9364 with SMTP id
 4fb4d7f45d1cf-5d0205f4b61mr11330079a12.10.1732558112236; Mon, 25 Nov 2024
 10:08:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJ7uOuDCzErfeymGuyaP9ECqjFK5ZF9o3cuvR3+VLWfFg@mail.gmail.com>
 <20241125174608.1484356-1-martin.ottens@fau.de>
In-Reply-To: <20241125174608.1484356-1-martin.ottens@fau.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Nov 2024 19:08:21 +0100
Message-ID: <CANn89iLeSEVDZv-Nx6RGghSJdpozBAdoU==VQLgH5v+Puc=i0w@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: tbf: correct backlog statistic for GSO packets
To: Martin Ottens <martin.ottens@fau.de>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 6:46=E2=80=AFPM Martin Ottens <martin.ottens@fau.de=
> wrote:
>
> When the length of a GSO packet in the tbf qdisc is larger than the burst
> size configured the packet will be segmented by the tbf_segment function.
> Whenever this function is used to enqueue SKBs, the backlog statistic of
> the tbf is not increased correctly. This can lead to underflows of the
> 'backlog' byte-statistic value when these packets are dequeued from tbf.
>
> Reproduce the bug:
> Ensure that the sender machine has GSO enabled. Configured the tbf on
> the outgoing interface of the machine as follows (burstsize =3D 1 MTU):
> $ tc qdisc add dev <oif> root handle 1: tbf rate 50Mbit burst 1514 latenc=
y 50ms
>
> Send bulk TCP traffic out via this interface, e.g., by running an iPerf3
> client on this machine. Check the qdisc statistics:
> $ tc -s qdisc show dev <oif>
>
> The 'backlog' byte-statistic has incorrect values while traffic is
> transferred, e.g., high values due to u32 underflows. When the transfer
> is stopped, the value is !=3D 0, which should never happen.
>
> This patch fixes this bug by updating the statistics correctly, even if
> single SKBs of a GSO SKB cannot be enqueued.
>
> Fixes: e43ac79a4bc6 ("sch_tbf: segment too big GSO packets")
> Signed-off-by: Martin Ottens <martin.ottens@fau.de>

This seems fine, please note we ask for a 24 hours delay between each
version, to let other reviewers chime in.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Can you also take a look at net/sched/sch_taprio.c, it seems the bug
has been copy/pasted there as well.

