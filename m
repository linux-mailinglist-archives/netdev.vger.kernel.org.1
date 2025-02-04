Return-Path: <netdev+bounces-162382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB87A26B59
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 06:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D713C166256
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 05:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FD1155300;
	Tue,  4 Feb 2025 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CX1myYLw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D025A624
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 05:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738646703; cv=none; b=RNW3dbU0Ml09/Aj3YWsnZcWs+FLUOybvybSPfMnrFSURnZ2tw5KI42XQu+jd7MrujtNHM/hzRkWaKDX/g7lwQZZBhZuxp3lZjCd1ZeYM1Jea5DyUUMYHXdwH2JGI4VI6Nie975sjxApL9XeRunGalwA7WubKK5TUIZAYzmKYUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738646703; c=relaxed/simple;
	bh=WnKUPtNcbNWKD6+fVm40T/Ouzj/QCycwXGf2rOTjrZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIwWnpr1FYL+fjEayG++MGqp3wyR/H0pOrJZhTPrd3hwFp8cpxHgFP1dmwUQeLKhpZ3+/MPOJ22SSSErH0kokdWIRb2GlAtWGKwfw6nB1ZTY6CH8RmBEOlAo2gcFgKBy1g4p5Mpr76QM/K/81nfYzcwzDavAgPuvnm2dc0tRfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CX1myYLw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so7985101a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 21:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738646700; x=1739251500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/4XTKg6KBEPpjWRSrCIRSEnuQuaW8CAZPoes0lC0D4=;
        b=CX1myYLwW3caOWmjkFMtICtsNrdr6hnN/XusdaYsvs65ozeF7TVt0vNIbLlNSIDxcc
         vBZhIqevl19kjRHxnzkYcRDy4VKRQ2SYCe5PIHoqgvyYeCRq3eLt3S73gTGzO+3FtLHt
         NdcBkMipNVLnlqBqtznGJFhZsW3vwY+7HDucyl5Uy2aM6BtfSLSu0cLFY9CtyYcUpfwI
         ChumAHpwyZuGtK/pdNruFWslNnPwVB4Wh2s2Q48q/nm56dbOkPXpZ8284iXWMCpJfgm3
         1BM4hHim+WrmTqz6Fsa0+Fxi/vuJmkKXi/FsNRKQMV62IvTp0vP9JSAYmswrhbOzc5Zt
         mtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738646700; x=1739251500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/4XTKg6KBEPpjWRSrCIRSEnuQuaW8CAZPoes0lC0D4=;
        b=MeIsZFkl6nG9mhswssOFffVyfVrc7LyANWMBuwrazf2IKepSrCTlNVSk7Lu9lFc/8w
         4XQcVd5fVSw8AxRI9RNy2ywKK85LaxerO+CUmBbHS9CUb2WuP9g7VboQR9w7W3ifKC1H
         0DY9TJFhpRaWUCuq7Aq6FNE2FCZC26tR3/C9Axfjn1IlueMHmRQeMq0mJlPwhQnaIovT
         Xr+/Ml8zxh1PoncyHnQWsxJi4asKxMxKlYeoeSDaerM2MKAdyhAPWncXlcjdNnWh16eZ
         HFGp3zaJpgdvvz/aoIGvdIJFTxxC/901UYAn77lMkpJjgwViEoYqA4aVowjbtUivf9mB
         ubeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjIh6+42XdgLQwI62uRgQSeMAgaB5jf8Yg5BkoIYb/kjZaSRJ4RkpvFJBHhLguERxHJdV24DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EXe2BbX0Pd3MurE6LiaBI8EpzIbsQPhyH75QNkbynVKIwFfV
	FypQsY3/XF+p90rTCNk+7GYrBoSkuIZfDevCxdTBwRtLarW4ik3mVgNXlpUpNDOmEBAmkEG0MoB
	R5Jtzn9PUCsWDKDUQIZp3L4HA37A6X7Qupfg3FHggEdwHtkG4Tw==
X-Gm-Gg: ASbGncsKqwuGEjAqaqOEcd2m4OvdD4ca9QK/SBB7c5CBMTXdp1Y/ePZ6G66Nxsb/dz5
	DCVSeCJbyCXNlBSZUX9yzu5gBZTNOTdqNUTilTXg6qXF5NfzZSob09zZ117XnEnFRlEUS5A==
X-Google-Smtp-Source: AGHT+IHWUXFFmEzXlNaEvagCcpsZa6ommkkptbrCKiAItEcT5iH6hV9iaBDYt4Nd5Z/IlHCAT+PCwKVZSddaDztdStc=
X-Received: by 2002:a05:6402:520e:b0:5d0:aa2d:6eee with SMTP id
 4fb4d7f45d1cf-5dc5efe6376mr26740927a12.26.1738646700356; Mon, 03 Feb 2025
 21:25:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203215816.1294081-1-kuba@kernel.org>
In-Reply-To: <20250203215816.1294081-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 06:24:49 +0100
X-Gm-Features: AWEUYZnDNXXL6Cr-cRV1C2_PCeCuwv6uEmW4l0mTQrlAcuc3l0WAb1fvN_vAMlM
Message-ID: <CANn89iKstzu3O2eD1OAhR=Vc1EVyesg14DAp0P42i8juJuH_gA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: warn if NAPI instance wasn't shut down
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 10:58=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Drivers should always disable a NAPI instance before removing it.
> If they don't the instance may be queued for polling.
> Since commit 86e25f40aa1e ("net: napi: Add napi_config")
> we also remove the NAPI from the busy polling hash table
> in napi_disable(), so not disabling would leave a stale
> entry there.
>
> Use of busy polling is relatively uncommon so bugs may be lurking
> in the drivers. Add an explicit warning.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/dev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c0021cbd28fc..2b141f20b13b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -7071,6 +7071,9 @@ void __netif_napi_del_locked(struct napi_struct *na=
pi)
>         if (!test_and_clear_bit(NAPI_STATE_LISTED, &napi->state))
>                 return;
>
> +       /* Make sure NAPI is disabled (or was never enabled). */
> +       WARN_ON(!test_bit(NAPI_STATE_SCHED, &napi->state));
> +
>         if (napi->config) {
>                 napi->index =3D -1;
>                 napi->config =3D NULL;
> --
> 2.48.1
>

This makes sense. Although a WARN_ON_ONCE() might avoid some noise.

Reviewed-by: Eric Dumazet <edumazet@google.com>

