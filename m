Return-Path: <netdev+bounces-118350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A954F9515A4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F58B21C1F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2760113B2A9;
	Wed, 14 Aug 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hf1QrPtF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFB67F486
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620911; cv=none; b=jXYnX0YkIJhzX/GeWAiGIwdxSJoE5wzWF7QFibfLIjbGfFSSXsRo8vvFcx8tMECc8pNYUSr2a9xJeCfJV6+6DT3qMRN1u8pBEDu6Vei7VwWG8I+mFFIM8zJtZh6j0j1W9eSofRIHac8PYe6EgTk0Y569rI4aFtF8pxjxxplVzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620911; c=relaxed/simple;
	bh=dn+L6oAUJ8ys/t5tJ3WejzYSbtBeeeBMxySZGq3wZzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8y1cdSf1IAQZ/G7DpDR/WShtpyG69rvmyKuHQG+6spdwqB1HDx6l1owdA23Zqo41TTk8i78DbwfwUauu7NIyaHucZgVBTc01lhprSslC6perf98KU5WcyVMoRpXQwfRym0JoqD0FIlmlNLCA5lUekYVPr+qWYc6Nd25hZMAf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hf1QrPtF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9a369055so495652466b.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723620907; x=1724225707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYvlbKLns5cdVvpTzIYsdMbPag5YJ/RZP19+Oopz0OQ=;
        b=Hf1QrPtFntJi4a2ZUMCqHkYbjRfgDaYdnELk/ST0tj2n2bhNMiC2yr5OjMKOaQL5Qz
         wz9NJDyR7OyTXR054sl+dzNVWi57GRMfsiVWJVlt+y/7aIoslcijL5hMPF3vlGFuldHf
         S8IEy120eJK+N+qp5PrDKTkQvZv+dfq+ryIuvA7maRF1PjHGngJgrZWxRpVGQ9XgHZ4Z
         hVtnVRAFazpi/aSMClpfP2Xbg1wtlzu6VHGjHNCRNOnRoTU+9ftVhHUHRjuFR0dEJhkE
         YYR80mv/M1ugp1md05ADOa37hJAv59x53GY5bL3t7Jobj4dtWHasTu9cacx5Iktg2ULX
         5D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723620907; x=1724225707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYvlbKLns5cdVvpTzIYsdMbPag5YJ/RZP19+Oopz0OQ=;
        b=fpGzSR92DNB/qad0S7/63pGlHx/qJnZUD+kUd/yISysJTY040VmcWPAfZ6XtIAlcF9
         sHyVvPXkm9MXc4E0udYqQkh0Mz0p7gwJx6EJ4H76sUNWyYQrqA518wbhm3teB4uBreRn
         mdgzcYNDr2JJl2MdELjkMzkVROWJCmhmZhSMkrZu907qBSemusvP7j46Xov16i9zYwGv
         YxHhlON9qUT208UVjj3yFYM2/HWT/LFGDLDUv8ixhHyAhmKShrGa2AwbE3j9BCGdrWZt
         r98AQh3hc/7Bu0/+4fJlS164vw44qaczXdfl0esx1Aa7EpDftzS/X/uvM7KxDrNpLKDy
         bGZg==
X-Forwarded-Encrypted: i=1; AJvYcCXaeVEO1fcsSWv0oNiTI98wagq15YsQbix63BmHNrh7xuJXK8U8IUjspmEJ2eevB+75QkvucfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GQV8EZp+nbcXkDPz+m0ppHiSZE4OLG+UT9zeE6AF+UpBPNkx
	aZeNNwI2acQWpQkExhE1pahwa5655g0yhRLQo3qE0dSG5HzJpjleIetBaS8PazLLrDsqkisWbcq
	Y5lby22iufh9leL7wyAmb7+pacVKSiyGUWHGz
X-Google-Smtp-Source: AGHT+IE/CG/1vgT1Y1n6PG7T2xGjZvOmrCdMCKO7yg5oBdpqAfSoZGVyiIo9FT8otgRh6yvRXfQeu0fk1v0Z/6Ec7BU=
X-Received: by 2002:a17:907:f155:b0:a77:cb7d:f356 with SMTP id
 a640c23a62f3a-a8367087b2amr110481066b.51.1723620907107; Wed, 14 Aug 2024
 00:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812105315.440718-1-kuro@kuroa.me>
In-Reply-To: <20240812105315.440718-1-kuro@kuroa.me>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Wed, 14 Aug 2024 16:34:51 +0900
Message-ID: <CAKD1Yr3i+858zNvSwbuFLiBHS52xhTw5oh6P-sPgRNcMbWEbhw@mail.gmail.com>
Subject: Re: [PATCH net,v2] tcp: fix forever orphan socket caused by tcp_abort
To: Xueming Feng <kuro@kuroa.me>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:53=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wrote:
> The -ENOENT code comes from the associate patch Lorenzo made for
> iproute2-ss; link attached below.

ENOENT does seem reasonable. It's the same thing that would happen if
userspace passed in a nonexistent cookie (we have a test for that).
I'd guess this could happen if userspace was trying to destroy a
socket but it lost the race against the process owning a socket
closing it?

>         bh_unlock_sock(sk);
>         local_bh_enable();
> -       tcp_write_queue_purge(sk);

Is this not necessary in any other cases? What if there is
retransmitted data, shouldn't that be cleared?

Other than that, I have run the Android tests on this patch and they
all passed other than the test that checks that closing FIN_WAIT1
sockets can't be closed. That's expected to fail because it checking
that the kernel does not support what you are trying to support. I
uploaded a CL to fix that: https://r.android.com/3217682 .

Tested-By: Lorenzo Colitti <lorenzo@google.com>

