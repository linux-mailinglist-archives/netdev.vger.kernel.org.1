Return-Path: <netdev+bounces-76954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C9786FA67
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 08:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAA61C20FF4
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7165A12E4F;
	Mon,  4 Mar 2024 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiclgH5q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E91427F;
	Mon,  4 Mar 2024 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535678; cv=none; b=fxtvjxx7AT6RchGHEUEke5w7oCpWGHSdNntcdWuUKJTwY7ps1ODYWAbbHZwcdrGbKJJTJf53QWD4FjXs5NHjZRT7i5WENCqwxhhQom3UUvOYc/UaUoc84jqP9/6RMDXyTsNPPGXTNMVp9xs86yPQlRmJAqVXP86VlV3b2F+d/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535678; c=relaxed/simple;
	bh=XQzTf+FSuP/WyHF9dIPZWrGYDsywtwr8k/e5yrdRIW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6WT3sOtWygeNJpkW7d4vuISSFtG9xjHxRomAH8/xWETHdik1zPl+HqCB8XJI09+kS5MTgNK+UP/nwIDlRylpNbluAhX6XATX3tbSaCZPCg1IUPPnxwE5Z5CLbZqKrqBbljKGfKP2HjK82E+DCWolSgpS1XngXjgdzFHPbD8sk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiclgH5q; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a450bedffdfso117542766b.3;
        Sun, 03 Mar 2024 23:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709535675; x=1710140475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS2HQh2b725w1idcXlC3Ryn4jK3Wv0t/IfpeiTz5v0s=;
        b=ZiclgH5qXeWaH3uZBBcaxRR41NY8dgYFFBFaa6bpJA+pBIcNiTn+tmDuwBMnOuW0mL
         i1ZW3apqVFpjKyGrQy+3VrsZAe8RKE6rM1O2QQ0mHGMFmTm+tejnprOkKJb84VGvFvdg
         fhhK+QuWwYKrexOlp+ce5DWK3JlUGLSvWKsyc4aBUALE0/UbdR7rVUHvy40KRQx4d52j
         iRTCYhSnVQ4MdiuyMJ/WmFHsQvPegvCX0bg5swcImYfsM4kUlfLXt1eJ+7P9Ba5/OxOO
         LoQ340NqS692czl7+EqgbuLvOAFsYg4dKcFbBTXE9duicoJis+VBgPKq403Ey7hflTQI
         TYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535675; x=1710140475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS2HQh2b725w1idcXlC3Ryn4jK3Wv0t/IfpeiTz5v0s=;
        b=ij5TYuCthiyxaBygLXYA5+qEAWWgSZeBUSAdyrKUE875T6UXOmQ32X5p0UrqKuMKFQ
         2uWqqhVr/HvpOiQyi6WgS3rgMToR5qs2SAR61z03VP6VjyG4H5WQJcYJTUjsrDJLHraD
         vNxSRytFjYVifakt1AIwLby92AZvhe55IvFERt3FRAcKHNU42VaqW9FylFDg8r83ZHF0
         IoEOIPD36hGtERnYlwDMstIjQmBHCJhAEqkB0Yr8Cuz8eTDu1L2XeKToqtM3VrN+ZC8p
         IHXVwcCy+N5hTgqMrdztp64nfEXApC9sK4FrrGuXrIMfWKwpi3wkZchaRmiWiOKuMYh5
         KF9w==
X-Forwarded-Encrypted: i=1; AJvYcCXy/3ZCKhPsa55i4e6DFIKsMDZ3kY0UMnDV/ZF8y7HiwPA/FEuYexLA4vUt+c+BMoJTPpjGs9ZF5m1PAwcfnidqvgDFIUSWgo3Ozl0K7EVN1K7v
X-Gm-Message-State: AOJu0Yw50ynafmlq733CMJNP1jYDt+DWCI8FD8Ng9xaZP1fyCTX7cmck
	vlEvedDzqH/QI7/7D2oCKoPr+jQVOHlT2PJv2+EUCV3HAxJJq3KhA/ezy+VAvU0c14SVS5zn/c1
	ve3QJG+Ss8tu5Jg2HOr5TbCgEr0xSpPnfVEk=
X-Google-Smtp-Source: AGHT+IHCC0CIxs4dY7yraefZEsX7xQyFzikT2RzAkMAE6yeTjfFvuk1DehdWhyoxP5jkT7mjH/pnd7e6QEVuadGoH7k=
X-Received: by 2002:a17:907:367:b0:a43:39fe:b475 with SMTP id
 rs7-20020a170907036700b00a4339feb475mr5129536ejb.45.1709535674758; Sun, 03
 Mar 2024 23:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229170956.87290-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240229170956.87290-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 4 Mar 2024 15:00:38 +0800
Message-ID: <CAL+tcoBJy4a_wBQbwmvWZWZP7mwaby3xHy+45x-PTEbHsGAH6A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] add two missing addresses when using trace
To: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:10=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> When I reviewed other people's patch [1], I noticed that similar thing
> also happens in tcp_event_skb class and tcp_event_sk_skb class. They
> don't print those two addrs of skb/sk which already exist.
>
> They are probably forgotten by the original authors, so this time I
> finish the work. Also, adding more trace about the socket/skb addr can
> help us sometime even though the chance is minor.
>
> I don't consider it is a bug, thus I chose to target net-next tree.

Gentle ping...No rush. Just in case this simple patchset was lost for
some reason.

Thanks,
Jason

>
> [1]
> Link: https://lore.kernel.org/netdev/CAL+tcoAhvFhXdr1WQU8mv_6ZX5nOoNpbOLA=
B6=3DC+DB-qXQ11Ew@mail.gmail.com/
>
> Jason Xing (2):
>   tcp: add tracing of skb/skaddr in tcp_event_sk_skb class
>   tcp: add tracing of skbaddr in tcp_event_skb class
>
>  include/trace/events/tcp.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.37.3
>

