Return-Path: <netdev+bounces-111527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 938BE931755
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8901F22094
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840B418EA98;
	Mon, 15 Jul 2024 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIFeUjOg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE13A1A0
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055901; cv=none; b=IbuzJGg9u1VXXl+V1r34XYtNxgPbOE95eRHXdVBQ2lM05tSVNCQwOmt9ey85mwX7T3+azJzpo3Za9sGYnyuUoT7WWvnIAOh0X8zeW2fas9RqdPNMfF386f2xZw/5jcLuho5HMfh9EzP8kgdbrCba0iDOpg/K7tdCreLFMi0Zslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055901; c=relaxed/simple;
	bh=7fUIyzS9h5+N+kA1EwKhH9uBB/8XyxxUVqyQCRLGvH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6uSUh/UjfffroBgR1kujemkYKzjR+epfSxYzoqnZNDW4L18Keov75awWfNOs/u5axawCUYJkCIbbHTQ8FK82jq0hPHpLkYtNhfUqw3RWaitAOi6O8pAth7LmVwqXrhAFxM573DSz1eAbj7ArOwHldDWpjqZxReMY3lMEiDAxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIFeUjOg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so19730a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721055898; x=1721660698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqA+QTqRjOHztntrQ0pa3cpC9c0CF50wS5rmmdFhgaA=;
        b=LIFeUjOgARIiGli2C0nMi9rRVHbZQrKWsUoxTkLMU0I8UBRgUxLLi6IPOA+0AE1SL/
         Rb4YBoLZ7W+wrSFfA+y1iluKilj6tdQESpNGQJWOMJkHIc6ST54hlsO3mLe6eG01g4gD
         YdpLBa5vKuv2Qz4JvvTObk8Ks9Pbfo8YAD2tAQZcUn6Ssq8lFUAWvEo3T/vV3xf6mtoE
         oxDOkII4z7TLrrhMDwVs99ZUXM28YcwDG1CVEXNsJWCpd3du8cqRq8OHRvVd+GYrttAx
         APPiTKbO70xVxUL9A2djGkFCcxUvKVFCBhKVgsGRYyTgwb5E1eVHLlwM9O6CpeGIXNjK
         lTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721055898; x=1721660698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqA+QTqRjOHztntrQ0pa3cpC9c0CF50wS5rmmdFhgaA=;
        b=T0f1HrLqKrtgoGFsULQeXLTZqNuaurelAyrN1OGY/z5JuKsc8jz6NB8MVpQMX9Enx2
         tf+9FY6rCzFtmYX/2718dCZYxy5yWeFO4R8fovbmbyX5LEjxCuahcHQ+ZT7BY+Dpi9BU
         0eXDf7sSmhgSKZTyLMqxj4D50iwPwFv9p4kw2xBl1yWLvimoaaZ8F2YmqOObn0v0LyA6
         VpgBbvdk8bV440EvXKfjYaLT/c99lID3shcpXO81hGeyHxa28diyPgm1Row0gEMljSgg
         zDAeMSS8he8UrcXPP7aWXR1WNdXmI1FYD+TqkHbiB5iED78qiMkNKXWObKg8S+HketPO
         okJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSZUnbtLYv4Gx+JbejpDBvhwvHEvSe9EIKqWwSaERHwsIA9Go1PLWnPsVsyU3P/HvbsUfo7bAQYYzyaCqGEhMfczyy5S0o
X-Gm-Message-State: AOJu0YwpmseyKYu6Rnc3XicISWS75g2Ve358eS2VVMl0DS7svVpigZCw
	l03kxabma1Jp5MyhQ/UBLF3evRENDXO1pfYKviyls8zyF1jaiWUPBQ/adY+J8jMwDg3BLq5OC7e
	PpaUV00SqPq3nOpevLkGsPzB8UPvsnS8hWwZ7
X-Google-Smtp-Source: AGHT+IFhG2FAs3zNT7qos4x059Oc/6HgIAM3yNi/CmeFRunzEQa8u2qOF12lxCcVWjasyVkEs6955BtRnr54PBHtOd0=
X-Received: by 2002:a05:6402:51cc:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-59af1981c8fmr289635a12.3.1721055897882; Mon, 15 Jul 2024
 08:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714161719.6528-1-kuniyu@amazon.com>
In-Reply-To: <20240714161719.6528-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jul 2024 08:04:46 -0700
Message-ID: <CANn89iLXPQhCsnO6o6Kvaa3Hpftdp7k77Fsa3o9fns0xfXQWQQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't access uninit tcp_rsk(req)->ao_keyid in tcp_create_openreq_child().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 9:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller reported KMSAN splat in tcp_create_openreq_child(). [0]
>
> The uninit variable is tcp_rsk(req)->ao_keyid.
>
> tcp_rsk(req)->ao_keyid is initialised only when tcp_conn_request() finds
> a valid TCP AO option in SYN.  Then, tcp_rsk(req)->used_tcp_ao is set
> accordingly.
>
> Let's not read tcp_rsk(req)->ao_keyid when tcp_rsk(req)->used_tcp_ao is
> false.
>
>
> Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

