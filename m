Return-Path: <netdev+bounces-128089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C82977ED8
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932651F213CF
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E961D86D8;
	Fri, 13 Sep 2024 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ga7NCVno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721631C2DCE
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228161; cv=none; b=k0OoN/qTBCMbje2Yd5ytUs0PBGHOFMp+dS9ysC16Y9Eyi6GGnsGKxkY43cCLZt1LoTs0AnZCmVGjVuoXSs1Q50RJFr5EJKCCQNtMbGh2SVEUHX9Y5p9mQhBLCK7GgLqkswFJl3UhbotSRXgq6y8sMjDHjzkmd9JbHYlQqZ4Y/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228161; c=relaxed/simple;
	bh=DOZoBosCeMh6lcjsaLisPvkvebY8PhnMy6QisARmsG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHDTdikUNXC17IyOHqnBiwsIqjWxEn5zg4pOZTdDh9pspkTaECzy9n1NujCPuFiPnRow8kzkOBrX45RBLjXRPh5PLpgLfyHYgdoGIW5PhD8WI+9DzpLpLnWnESAqDpbQc3VKYvc30lC7yslGLOa0VdpYJQoEB2YxyyVF9QV/INA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ga7NCVno; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c3ed267a7bso2295284a12.3
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 04:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726228158; x=1726832958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOZoBosCeMh6lcjsaLisPvkvebY8PhnMy6QisARmsG8=;
        b=Ga7NCVno1knAafqFVsV1fcxCxJTN/AawucGy7AGGASyP6qkYdNTkhlOxLKNFfLZUJM
         o59WbA+/nFRkpcGvxhSK40ZhiXbcZfJoKhcmv+RfVSMGq8A2LObv14TILymhiKii67x0
         Nw/MPFqhykc/XlF57G+bU4hI9OumIbAT5q/3zcqG55e1WLFyyVJv2ybXl73ecG2fvwJp
         N4MfTg5KQOGtbB0lpOR9VYTsquit5oMpbi1R+YRAVYs4M4jCBapuZSQ8KGCI151Y3K+b
         2OeDpunTzl+ndrtB+dMq9UFyC3YG2vTptHptqXQUaY6k3zidR+nhPrAO42C02FPeib3U
         HxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228158; x=1726832958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOZoBosCeMh6lcjsaLisPvkvebY8PhnMy6QisARmsG8=;
        b=T5qXjBa8vIZC3IqIyltg8D1UL2iLQ6vMQly5QzZqZHqoOO9B89bEmdQ7P7vHsgIr9J
         6uvT8bLamTO3K1pfQhFAozbsduVqk9OHc8ciJfp912nZFWO9ym7fRRfKMolf6zrytwz8
         ltGosMbtCpccQPqo+FyYRi7zL1zb6s9GvnqoTVGVSNcH3+52H/sL9hvs7WlJpxHjj+X+
         7+LH4McSZ3Nie/tuqOkRdPZAmUqW/hYudTA6jaV/s+Af4dkXgvlGaYZxasnsAp5aMpDi
         UYP59wmVvpEddbS/385R0M7YnGEqFMSPQHF15HU+yaQlxW9fPbQGnDOCyzIdKw0ehVfc
         TKmg==
X-Gm-Message-State: AOJu0YzF/dm7IysAo6MYsC6TWZns3JT92AY+sf4rWWy0PIOf3SK8LvaR
	V2iHVFjC4GnlIjoGGFp460rH+ZX8kpLs/pn6jprhszsqRZl4hSShQaqb+85p5xQVW97uk75w6TR
	yBFT3tTxYpJ97kufefcdhzoO6pAAM3Ms/gSsc
X-Google-Smtp-Source: AGHT+IESZg/m9zaQbfQTNo5adxWBUHn08uc3PmIIB1PTyZGkRQ1LWlVVw96G7RtzqSGXFUaMEP3gCDwFkYnSt8FWKFY=
X-Received: by 2002:a17:906:d7c7:b0:a7d:e5b1:bf65 with SMTP id
 a640c23a62f3a-a902943596emr526075766b.21.1726228157431; Fri, 13 Sep 2024
 04:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913100941.8565-1-lulie@linux.alibaba.com>
In-Reply-To: <20240913100941.8565-1-lulie@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 13:49:03 +0200
Message-ID: <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net/udp: Add 4-tuple hash for connected socket
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	antony.antony@secunet.com, steffen.klassert@secunet.com, 
	linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com, jakub@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 12:09=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com>=
 wrote:
>
> This RFC patch introduces 4-tuple hash for connected udp sockets, to
> make udp lookup faster. It is a tentative proposal and any comment is
> welcome.
>
> Currently, the udp_table has two hash table, the port hash and portaddr
> hash. But for UDP server, all sockets have the same local port and addr,
> so they are all on the same hash slot within a reuseport group. And the
> target sock is selected by scoring.
>
> In some applications, the UDP server uses connect() for each incoming
> client, and then the socket (fd) is used exclusively by the client. In
> such scenarios, current scoring method can be ineffcient with a large
> number of connections, resulting in high softirq overhead.
>
> To solve the problem, a 4-tuple hash list is added to udp_table, and is
> updated when calling connect(). Then __udp4_lib_lookup() firstly
> searches the 4-tuple hash list, and return directly if success. A new
> sockopt UDP_HASH4 is added to enable it. So the usage is:
> 1. socket()
> 2. bind()
> 3. setsockopt(UDP_HASH4)
> 4. connect()
>
> AFAICT the patch (if useful) can be further improved by:
> (a) Support disable with sockopt UDP_HASH4. Now it cannot be disabled
> once turned on until the socket closed.
> (b) Better interact with hash2/reuseport. Now hash4 hardly affects other
> mechanisms, but maintaining sockets in both hash4 and hash2 lists seems
> unnecessary.
> (c) Support early demux and ipv6.
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

Adding a 4-tuple hash for UDP has been discussed in the past.

Main issue is that this is adding one cache line miss per incoming packet.

Most heavy duty UDP servers (DNS, QUIC), use non connected sockets,
because having one million UDP sockets has huge kernel memory cost,
not counting poor cache locality.

