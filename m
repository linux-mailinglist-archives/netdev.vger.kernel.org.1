Return-Path: <netdev+bounces-72322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCB38578B7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7331C212BF
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794A91B951;
	Fri, 16 Feb 2024 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SaNn5Rfu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53021B949
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075189; cv=none; b=s2dw5kPjJordY/tphqZoktKdNJbAeCwobsCDNLfdGfL4msmiUmMDhQGDtDv24SO4mJcOSbgYIe6hiJQHThCcq7267XQ/W3bGM/8ikhOlPAeUBuWQm4ICdGqTdpyelwI0/BB7EvRDqd3otUzED+052MZuynkkvZxRwmBJ9Ee7tPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075189; c=relaxed/simple;
	bh=KxKiUxBJfzb6ymZJcXmprLmCZIQPuc2yeSX5IUSJuTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nX3M1oRUw+6UIxQAaLqa6WlSwsKgnBAgXv4cScyH3ZRvbpFeHA5jNbftrofUvSjFfFk21+kDaX4N263kGpz+7H3cHq3nPe+EQC1wISqCyF7yVyCLLE0AC88FqbMYEjlI0OS5eEXgETUyhtiwn85nsfCrOguBbJdEHmZ5Ugxj0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SaNn5Rfu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-410c9f17c9eso37405e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 01:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708075186; x=1708679986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxKiUxBJfzb6ymZJcXmprLmCZIQPuc2yeSX5IUSJuTI=;
        b=SaNn5RfuWemZVwNwIvU32ypf6lEjW9MzKrBF57Xciv8z7F33idoumUqsIZzzl7UOxH
         rWGGTyhVlXjUnvuuD+yzmIVSVkQgNpE58S00y40Fku2mXqq/8X9+wOgnFCM101iBz+Bd
         1y3daI0XUA5sevFTTu7SyegiWDqKMOY/nKZiUfZx2xoA0tjdPmv6QEBMHc2usjAe5MqO
         O62OmRg3KC0IUXFr4cMPFVQaOokBdKCaWIi87zZMdBnv8S4ro5GQW10Y/pSybngTi7L5
         9Jt0lCiYB0yIC8eMsmRx2+nSaHWsGuvAbHXv/VFAd5cZyJ36SGHjFCJGVAhWKjWJ1jdh
         JZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708075186; x=1708679986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxKiUxBJfzb6ymZJcXmprLmCZIQPuc2yeSX5IUSJuTI=;
        b=t9inTxyLWQgIgarCbR8/7ykEZnn84DEEMoHJonaUbitnqS+sHen6wSS7Diy2Rc2V9h
         k4nRqXQTvLrXsWqyUY1LhbLeRJez8OK4rn6xvi4CUVP6Ou6olvrDTeRWpU+DcXub5tkb
         krWU577mFAVRW5jfZalwJfUwLk+zeYOoDMJf9xxH/mSCEJfp7BXPwlD06K4ul/qBD8Rr
         i96VExp/zx5cXFwK8M0AuVkoEHKf+buI9c2sPLr2hqhv19wH1ZlBSzJqtvYAOnutp9ZX
         uSGq3yYN+DuC7vxxR3j8Ty9+kJHT53Zdwvdr5ttnVMP67T/mFoUwWP1X4hgkdBmvT6JE
         1PNw==
X-Forwarded-Encrypted: i=1; AJvYcCXeQWBMel/occQvnm9ynqSrFLYgYV1H3Rr4KbXxQaVaeh0VYdlAusAEAVWiYYGkEUbdq4kaw4inFmElU31dcRbLF/sHSUvo
X-Gm-Message-State: AOJu0YyMFFXiG+1OF8PE23nvVq1cfBSwJ0XSpy5IxF2mCQItybuGrXeA
	8gD/rWrP2HkY5PBEgacMzo15mReXNTXcuYlNDXQU2TwilBze5oWaa/yo4RiruCVvtvphrCsezzj
	iBn9huCM4309MmuhFWVaD4CSPGdWlWAbtqR6Q
X-Google-Smtp-Source: AGHT+IGqAmL0vaLPO/kgYbpyX5UyF5WRD7LoFrrR7KJZX16vhjPMfzxHyIb7oybbQKKmcpolEv5HActMVfsfEdGldzs=
X-Received: by 2002:a05:600c:6010:b0:411:d4df:761 with SMTP id
 az16-20020a05600c601000b00411d4df0761mr160121wmb.0.1708075185595; Fri, 16 Feb
 2024 01:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215172107.3461054-1-edumazet@google.com> <20240215172107.3461054-3-edumazet@google.com>
 <c59b80a8-cf9a-4e16-a298-6bb9b4b367a0@6wind.com>
In-Reply-To: <c59b80a8-cf9a-4e16-a298-6bb9b4b367a0@6wind.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 10:19:31 +0100
Message-ID: <CANn89i+iBdq4v5ctrycvoB_yd0mqyzurWvR7DnqHWjaZd9oRSg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid
To: nicolas.dichtel@6wind.com
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:17=E2=80=AFAM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 15/02/2024 =C3=A0 18:21, Eric Dumazet a =C3=A9crit :
> > net->dev_base_seq and ipv6.dev_addr_genid are monotonically increasing.
> >
> > If we XOR their values, we could miss to detect if both values
> > were changed with the same amount.
> >
> > Fixes: 63998ac24f83 ("ipv6: provide addr and netconf dump consistency i=
nfo")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> The trailers are mangled, your sob is put twice.
>
> Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Oops, copy/paste error ;)

Thanks !

