Return-Path: <netdev+bounces-113995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F3940918
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2D8284429
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 07:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9DF183098;
	Tue, 30 Jul 2024 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKgo+mic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4054774
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323398; cv=none; b=a4D5pI02wQ41yp4FGX5LDhF1K9BRGgH8fYjdRJnVVNcVho+X5cSVM14JYeqriNcp9zck4IlyRj413PM1Nlx65/qTX5o5zF8QzoITylVqa7rOgURPdbTpNnwEAyP8W/ZF5KXsQGdVgT9in5TiOL9zpsq2ZOzpdU2wQiPrxI+uu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323398; c=relaxed/simple;
	bh=d0y4QXIkiZNf1vnItVja8bgl/mGc/L1F3AsnHCDoiis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hN/UhSOPKR6XxXEF/fhcaMP09YwFF87xdh6heT/rslgLmQ2r+HNxEJioesvL73bF2xj5iELJGPwWgSfqBBH9am24ZLKi0JBlDRgtnpGDda26FOO2xDHS6pXcNc6Pkfj5VT9jQKaLT0Sa5MyiWjveMa+ppw1EhJLqqOQ8qYyPufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mKgo+mic; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52fc14aa5f5so2441e87.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 00:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722323393; x=1722928193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXG6a0oGKPwIK4GfP8Gj2jZz6AjFrRuVf6tyZiaRYmE=;
        b=mKgo+micEzg+GluRu0gGrk2s1Ajr0rwOmYWdBORJ7eri97tyeN+W/Q2je/qOLhsW4l
         OQFbKPWQVbYsq4v8ltFlI1c3LRmJ25cQuuwXa8HQIF45q9dEOMIni0303oKQaSVuUOmI
         nynF9q+3tR87fwbEnAr6zMFu5f2euJs4wmSttmctG8bzR13N6B74wy+uffBEMul9P0Ou
         Hzr7FQ/xet8LUz2AXyYgaRF6YvXno0DMRllKz+lV3Y7krylwuaCkQFJLqD2VqsJ5a+KB
         mv+qSoJKWF7/vtjDGlvNmZxwoGI5S7kGJtcpMgjk7XORsXzZ14i2299WreFtsRxunASd
         pSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722323393; x=1722928193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXG6a0oGKPwIK4GfP8Gj2jZz6AjFrRuVf6tyZiaRYmE=;
        b=fTLbu1UuKnMZ7JhiAtQizwgoRIFpaexx0fYZKixil9ovIjaHcqlpTEsv3IOAu9aNL6
         yPhkmgEuunc2QZNOKGLKoRh2buRHCtAVm03+B1iT/Oy24j81aKBxDFIgCGpj8dxixVCE
         rXAcTbAYXHJSqsp2S41e6Q31P11MUXpfAwKiuaqaHn8pcj0MZ0F7/AUeMeXFwCgCNEjy
         BHU6aLkbsJ/ZkY7fBvBWTCypoR9HPJqeWFqVCa6PpPXxBec5doqyJibAMjtnvgThixsg
         8RUPKvtBXyxsKPfa7APHEsDBsNn8pte7NWEdBoC/Ae6OTlgOEKMHnITUMsjM25NY6Cdv
         QSoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV70lSdYbb0nSWB75G/TwqmkzPewvBuuKN3n6c7v6n5YcVMx3WEAaWNiSdYwsfPOYwY5hQ37ttEFcKgDTa2bX2iq1tKzjlr
X-Gm-Message-State: AOJu0Yz265BolXlgl+hyIh35b8cscykqwIjFoZ6Q44PaZvp2pWXEHTU7
	gZUY6Ms/8va06S7cxb3KBLK6jTKBM9nbIRkQnmZGVOll6nUBvVAFdUv9b6UpgFz2Ks6y0R3UZOL
	cJhn/sXwFf5qCTOXxofwK3ANhL5sISp1c7rtO
X-Google-Smtp-Source: AGHT+IF1WQM4Uc9NF9W753lmdk8j+sAZ9ahOz9oqvielJrO42kGV+lTVrJ777DB3F1N94vzNtrSUnwb17NhQG/JxyRI=
X-Received: by 2002:a05:6512:3e03:b0:52c:d9fa:c3e with SMTP id
 2adb3069b0e04-530aa70a68dmr76747e87.4.1722323392896; Tue, 30 Jul 2024
 00:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729095554.28296-1-xiaolinkui@126.com> <CANn89iKxeYhqO-zNG5cTxw_o_3ORhcsXN7OJvFbhxPUEcoB3nA@mail.gmail.com>
 <57d2dc8a.5613.191025cae1d.Coremail.xiaolinkui@126.com>
In-Reply-To: <57d2dc8a.5613.191025cae1d.Coremail.xiaolinkui@126.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Jul 2024 09:09:41 +0200
Message-ID: <CANn89iJP84M3Jj0=6-dhsSMDnE8Wj7M7QwcMa3qbpqxbS-CfQw@mail.gmail.com>
Subject: Re: Re: [PATCH] tcp/dccp: Add another way to allocate local ports in connect()
To: xiaolinkui <xiaolinkui@126.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 8:38=E2=80=AFAM xiaolinkui <xiaolinkui@126.com> wro=
te:
>
> Thanks for your reply.
>
> At 2024-07-29 19:46:38, "Eric Dumazet" <edumazet@google.com> wrote:
> >On Mon, Jul 29, 2024 at 11:56=E2=80=AFAM <xiaolinkui@126.com> wrote:
> >>
> >> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> >>
> >> Commit 07f4c90062f8 ("tcp/dccp: try to not exhaust ip_local_port_range
> >> in connect()") allocates even ports for connect() first while leaving
> >> odd ports for bind() and this works well in busy servers.
> >>
> >> But this strategy causes severe performance degradation in busy client=
s.
> >> when a client has used more than half of the local ports setted in
> >> proc/sys/net/ipv4/ip_local_port_range, if this client try to connect
> >> to a server again, the connect time increases rapidly since it will
> >> traverse all the even ports though they are exhausted.
> >>
> >> So this path provides another strategy by introducing a system option:
> >> local_port_allocation. If it is a busy client, users should set it to =
1
> >> to use sequential allocation while it should be set to 0 in other
> >> situations. Its default value is 0.
> >>
> >> In commit 207184853dbd ("tcp/dccp: change source port selection at
> >> connect() time"), tell users that they can access all odd and even por=
ts
> >> by using IP_LOCAL_PORT_RANGE. But this requires users to modify the
> >> socket application. When even numbered ports are not sufficient, use t=
he
> >> sysctl parameter to achieve the same effect:
> >>         sysctl -w net.ipv4.local_port_allocation=3D1
> >>
> >> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> >
> >Too many errors in this patch...
> >
> >Lack of READ_ONCE() when reading a sysctl.
> >Lack or per-netns sysctl.
> >No documentation.
> Yes, it was my negligence=EF=BC=8EBut do you think it's necessary
> for me to send a v2 version=EF=BC=9FOr should we maintain the previous
> state here and put the sysctl setting method in my private kernel?

I think that adding a sysctl because some applications "can not be
changed" is not convincing.

Another useful socket option is IP_BIND_ADDRESS_NO_PORT, which also is
a choice made by applications.

