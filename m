Return-Path: <netdev+bounces-101087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE28FD42E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43711C21DD5
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D513A3FD;
	Wed,  5 Jun 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt37xxFr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3B25777;
	Wed,  5 Jun 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608929; cv=none; b=UEIasvPQpbXwLdoMywDytPiTGWApbA+kPbbRcXmbkKp9RCH2ZQJxrWwMD1nuWcbaZJGIBTV9zxqEWYXyqtY5n8YK14qXGvl2yugg6wAejwz1NnTJt5pjzCqO2U0b7vonsV5/klP5I+QVB4M9TcpES2cCUMQaaJ2PPjYznUrnY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608929; c=relaxed/simple;
	bh=0lkAYlhkJDwNq/2ycGN1uDHcMuZYQd7D+U9wE9TF8N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apghEwci/O5VLNRucVinTtn4412Y2vXqU1xjg5teVBrf6fS0HI4ZVMcw704TpsmOc1VsasWyvNm3Lx1cLUPxzF05QYONAswixdMcnvGpdMPaID7lBOKpNqtU66gP+s05qc2SI9j2dWf/N8H80l3nK3KVcBKwpaV0tOu2uSh7osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt37xxFr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4a0050b9aso920345ad.2;
        Wed, 05 Jun 2024 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608927; x=1718213727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7HSPYHAHlI7FlH7VN49FXeagd5Oowbwy6bFarEtu/Y=;
        b=Pt37xxFrxd7x91Znpg8HxQ3rokMN9r7AwSWqNOtAbDozVaXyJVdPWX5nsxMhUBep9K
         19FX5vs0HEJL5gy0hrI2iGoG10e56zwwoE7Z//9kSDq926MmJuc75ADTNh+6Gdq06GiR
         UgfexSiz2eEm2FEV/ti/E5CxmQVKeiXWZNudcXwn7MYV1pXFIHspTUYDPu6avMDDd7m2
         4LxpdwZPUe7/7Z0ZExw2HF9MtDnY1c+coxfZMt+MqXzBFpogQnDPb+kbbMmz2FKsLTvp
         H3d/SSD2fbDS+fYZh0x9fvUKGBMb/NT1ilq8yyWIH9FFdG/C8KngLdkA2NWhi03nzRUk
         LHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608927; x=1718213727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7HSPYHAHlI7FlH7VN49FXeagd5Oowbwy6bFarEtu/Y=;
        b=VDP3xHhIOyq/R1wLV1jH81Hdo3S2aBXy+mObCyw41oWaEX1vtbFdAIvMUEFL16ouJV
         kcysFG6FdUDLrWPDLOTWgrgGbAqweI/EhWQx+Og4pxQzf9UI6/0lGyfcYfEh7GFIjlwK
         BF9OVBrPDJa0yCBHpY+5ZiAJ0qONsP2gyiGF3tHLCI4+chJKddDVx77c+oac2caOLDvX
         kdZ7orfIK8b0uoRv+CAbpGiDb2Dj37wXOykC2ZmnlKWNmKxvxUZt5SVODaBKqIuHo6LJ
         AvervERPMchS28fR1m1dn7g5HHWkj8tj4wOHyGYkfBWpeaD9mIDSlJLcFj6aWyYFvjzb
         t+tw==
X-Forwarded-Encrypted: i=1; AJvYcCXMiplKQHBlydC954X8+afAHQwydAwx9KbSuIxhq5/ZjnvGKuPLRJ9S4hbW8os8RHJskGu8suu/+LfIN4YehMHKu321lH3ZHNAK+JPECX0Y0/BtVZ6BfBVbGCvJ5hUEEaXIJx4KAS2aRHC/QQs7LiyLRJIDJOpfwDAVKWT8WBRt4UwIClBdNqZ2VKdefrcHFcns5zSB3Egh5ofiN2Zc8bIVDdND
X-Gm-Message-State: AOJu0YxWaYa4+hmskzQPMn0xeCLjOzeC3tV3NLZbIgnf2D0g8N38s2mm
	is0/ExPCRaurmp0LYCcrHeOsH4Bjh00PUGOQPx5q36F7V+EYcpsvc7ZU2i2/d//k18BKo+Al6mB
	q0NCG2JAnfOqz7wzFlU8c2zNEywI=
X-Google-Smtp-Source: AGHT+IGrvrcq4dYUuqgkxF8Akh3d8DU+RTqlHicabep/mL3EAOQ2w2XhRyapDzelbBcD2hOCroRgC2Unf0oxQRoyET8=
X-Received: by 2002:a17:903:32c6:b0:1f6:a506:4be with SMTP id
 d9443c01a7336-1f6a590a9f1mr38124685ad.9.1717608927253; Wed, 05 Jun 2024
 10:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
 <20240605-tcp_ao-tracepoints-v2-3-e91e161282ef@gmail.com> <CANn89iLHGimJWRNcM8c=Ymec-+A3UG9rGy9Va_n7+eZ2WGHDiw@mail.gmail.com>
In-Reply-To: <CANn89iLHGimJWRNcM8c=Ymec-+A3UG9rGy9Va_n7+eZ2WGHDiw@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 5 Jun 2024 18:35:16 +0100
Message-ID: <CAJwJo6YVtBaCn+iUEvC7OWa7k9LtC9yReHM=RmuiDUACFympRw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] net/tcp: Move tcp_inbound_hash() from headers
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Thanks for the review,

On Wed, 5 Jun 2024 at 09:07, Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Jun 5, 2024 at 4:20=E2=80=AFAM Dmitry Safonov via B4 Relay
> <devnull+0x7f454c46.gmail.com@kernel.org> wrote:
> >
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Two reasons:
> > 1. It's grown up enough
> > 2. In order to not do header spaghetti by including
> >    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
> >
> > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Then we probably do not need EXPORT_SYMBOL(tcp_inbound_md5_hash); anymore=
 ?

Certainly, my bad. I will remove that in v3.

Thanks,
             Dmitry

