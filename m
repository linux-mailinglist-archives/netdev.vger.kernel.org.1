Return-Path: <netdev+bounces-85978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75589D2DC
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559032851E5
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD0763FC;
	Tue,  9 Apr 2024 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDc7Gocd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113D537E6
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646795; cv=none; b=B9i3lF+yilyIfKVnhphADkfTfJaY7G/FhsLykv+c6eo8J5Uj+LhJDiXog4QSEJOVBzbV6OZIeCIq/ZTltgU6+ghZ3flVpHvXXITl3DE4FufpPC/V3VPn6MZkB2GhbjEnaVQ5Es0JnilF7Y/OPZbR0yWbYDf/je9cQOyFwG/fofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646795; c=relaxed/simple;
	bh=O/+lv9xKYS1TjaI4TFFN+HVxO8K7p0kncTwAGlXat20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g37yZkDUNcbRMrOa2h75C23Sq5uJKjTflM48HHk0nvgd0DHfP+XU8HB/RLV48GASFanG7Xdv2Iu2eh4F5hgOHt7Suyt3td1TqhxtIYB64dh/Vf5j9IYa26m5zUfxCSQf4rDNQxotxuxmWriESE6LdZBnxya5XqMEelEnqwTmDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDc7Gocd; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36a2825cdf7so85545ab.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712646793; x=1713251593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/+lv9xKYS1TjaI4TFFN+HVxO8K7p0kncTwAGlXat20=;
        b=LDc7GocdCa5PVaJgDwIECuSkfN6eNlpiBfymVAve6WG7kdHdv8HN9m2FEDRk1tHhbs
         lYDInBu6gaHUSg8UsbuoKnU74fHrRGSdeAlmS3LdpqlU0BVhqEqAj2XL/Ri+dlNIKpao
         Z48cd/l74ZHgGnUdqPJUxClLlnaRvoSgL57KScMaeZtl8ucY4KlV9jutqpO5RgQ4mffc
         0iLdAHcMw1Nw44RbxWtFa8EoYKyuKzbIJg6oalB/Bl4iZ1gih1rsLRfC8aCYnjqdy01N
         h/bH3qaVtXGtCM8cHvg75F/tuEIV3zIZrGrFwPSJrXY7z/lTylY0X7rKKDsAn5jE8h7C
         pjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712646793; x=1713251593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/+lv9xKYS1TjaI4TFFN+HVxO8K7p0kncTwAGlXat20=;
        b=MjeDr0EGjd0M9FiMBmbB9PH/uYgcRX7VSCHwGwz4bc+Ql1x76jBqV2EFEi5Ab7wZ4z
         kyI7QgJmvyor9U+tWWqRkB3KOrc3HoFi5OS7mtzf1cJijy8/7yJ2y4v1H7Q8ai5kf3h7
         PeDdMw8+tvNTEgYHiDbxxVyRmz6FcUOgGwKje3bOx3m8z12bUPwCyQq7ufWxiLySUJPD
         q7NKcHWxfsdqksPpMWEH7/cizXMGvlwQgvJvtJ/cu+nQn+/K+3sdHr3jN2LYnnxPz8q+
         yIAB8O+lRUbi6+CENpdM7PxwHm6G7A3r5CkCIfg+4iN7pjD6swQpAZ+xtFkq9GioE66m
         sOcg==
X-Forwarded-Encrypted: i=1; AJvYcCVry4JnTj0Py/y41bRQ6ev8C8kWMz1HhgUj1LSZ6/Nj68bw70D3nF1j4LouvetiGTeQOm0V2nJ+VD23otsl5S71IGByuuSt
X-Gm-Message-State: AOJu0YxZ3j3MPKA8wotvnBGxAmgtSouZK2lskdsr9nklqiqf5/foSZ5q
	Wzeohww3snO06u2v+4DN1WriYanYxPX0eI1sALV++JXyHUe8mn15RpV79b0oe9mqXCyh6Gqpehe
	RaCj3CBM0koAAkvnr2EDpFUG3BijEIv1MbPaw
X-Google-Smtp-Source: AGHT+IGWf6qkNiqVm6LYYI4on3p94wttDCDx5SLbMV8f83CFxbAhdenIa+ftysHDaX8f1u2OvlJaPaN52bKLJF0WdiU=
X-Received: by 2002:a92:d346:0:b0:36a:19a6:bc78 with SMTP id
 a6-20020a92d346000000b0036a19a6bc78mr102437ilh.1.1712646793192; Tue, 09 Apr
 2024 00:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJgr3f23-t2O+cMcyQixNhcTGVVwp3m69J3G28zW4MPkg@mail.gmail.com>
 <20240408233200.1701282-1-hli@netflix.com>
In-Reply-To: <20240408233200.1701282-1-hli@netflix.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Apr 2024 09:12:57 +0200
Message-ID: <CANn89iKe=GCvSp1u5=6F+NYNUoGeOLyp0-ce8_Y-z8Vo=6-xMA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: increase the default TCP scaling ratio
To: Hechao Li <hli@netflix.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:32=E2=80=AFAM Hechao Li <hli@netflix.com> wrote:
>
> After commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"),
> we noticed an application-level timeout due to reduced throughput.
>
> Before the commit, for a client that sets SO_RCVBUF to 65k, it takes
> around 22 seconds to transfer 10M data. After the commit, it takes 40
> seconds. Because our application has a 30-second timeout, this
> regression broke the application.
>
> The reason that it takes longer to transfer data is that
> tp->scaling_ratio is initialized to a value that results in ~0.25 of
> rcvbuf. In our case, SO_RCVBUF is set to 65536 by the application, which
> translates to 2 * 65536 =3D 131,072 bytes in rcvbuf and hence a ~28k
> initial receive window.
>
> Later, even though the scaling_ratio is updated to a more accurate
> skb->len/skb->truesize, which is ~0.66 in our environment, the window
> stays at ~0.25 * rcvbuf. This is because tp->window_clamp does not
> change together with the tp->scaling_ratio update.

< when autotuning is disabled because of SO_RCVBUF >

Most modern applications let the kernel do autotuning, and benefit from the
increased scaling_ratio.

 As a result, the
> window size is capped at the initial window_clamp, which is also ~0.25 *
> rcvbuf, and never grows bigger.
>
> This patch increases the initial scaling_ratio from ~25% to 50% in order
> to be backward compatible with the original default
> sysctl_tcp_adv_win_scale.
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: Hechao Li <hli@netflix.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.pizza>, Eric Dumazet <edumazet@g=
oogle.com>

This tag is not standard, please use one line per reviewer.
Also please include the link to V1, for further reference.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/20240402215405.432863-1-hli@netflix.co=
m/

Thanks.

