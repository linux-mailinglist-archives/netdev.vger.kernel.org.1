Return-Path: <netdev+bounces-151264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBE19EDCE2
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 02:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE741888E37
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 01:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE8BFC02;
	Thu, 12 Dec 2024 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI9Jtogc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5E4A29
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733965268; cv=none; b=YhAmvDQWXA5W9WLi2BkCkGl0wohG/e/iIgNVhCEc2HoKd/S8jbEKfs8T1ypLt8EFKWHteDi8oN8IKMbxzOxSQHtABaKC4lXWrB8sGhj5/chUy5V4PrjyaAgDZZ+1N8hkXVYyc+MBra+erHywXYYxvpB15uMe5SGGHiWHVLv+RC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733965268; c=relaxed/simple;
	bh=M3g1B7AOnncBaEqpzP4s29l77Dc0sy57EtqDKKlKagw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUcljG+7J2SKrTuG55XH87PKGHczlnFnDt48OWNDQpta0s6HzKUlGrrVonfemZ2+Mya+rDPNDKE1dwvM8U6pun0MuFY/pUR7arKazL3Qvlh6fRXDD2od5nVkOjoIcZPzithPDBEayeqScdBm1wABjgkcxE2Khkpof4fA/yrOCPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI9Jtogc; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844c6b3e989so3972439f.0
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 17:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733965266; x=1734570066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3g1B7AOnncBaEqpzP4s29l77Dc0sy57EtqDKKlKagw=;
        b=XI9JtogcVy/jfjKWiUHaArKA5JYNbIztI9CzVJgQN15IE4ni/8jeC2s1ojeX2EUp5I
         cFMYbfGQNzlKpsZ6mAj/UFzJmS+unX3KXEs2IJutjeZSiu17YBApkxIJIdTP/OG2Atrf
         PiExtlpA5DK5pdLRD3bgfvQAVwD9J2dnlSxQCwJ4Sl65Dd+N1P1cHfsAwg2IvnERY/Ta
         baxSzNHP/OVU0E7fY4KfbKnFIKcZNfrgBYwwcGNZq9lfITxomfOShwIhTzas6Wr2N+Np
         kwycMPw2Ls3EMB02U7+H1uySemkubo6GN40WrdJM/BxrPlMH5pOY44Ov2+pwFy/KusIb
         US9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733965266; x=1734570066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3g1B7AOnncBaEqpzP4s29l77Dc0sy57EtqDKKlKagw=;
        b=ONJDrYasHopaitRNxRAYt2Il5vXr21vFLK2PY7ClXG49pg0rWd2mWiOQKYJanBLrIz
         gUX03w69/lvsVeRt+mB1Ej96bE6Niq6yt2eXI8+vr8EFUPnDWMSlvkno34SPEdNndPJI
         n5Y+PLhf55LymNv6ClG15xo/4Zxp1k5mlswa/ud6duhUPVaKLVXb9r+IQ7j/YgIx6pAg
         ZB6E8AmanDLtgovo4IzPYDvMTkBw1T821RThawPX9Eh39gxYlEhttjBzWuYq7sYdUtS3
         1L/gCpa7+mAHiKXz12sycaeZJYpEuza9WwMWozppXpvg3xMjfMkotm947PCDw2L5VlgB
         FcHw==
X-Gm-Message-State: AOJu0YyFxAF5SYeRqw1LzaST5sAIbqwEqS6T1fu5GX1Tdh7Lp1+TzILo
	jkTqcEDe3o6QifMLXakSAILmQxqy4xGTWeAI4sol6WtgtWzJW/luYyJx6lqaRyQgrLarXPlc53D
	yJ5JnLbR4aoYLopOeCmNQYPxWKGM=
X-Gm-Gg: ASbGnctzu+aDAK6/XU01RfPuNfBwfqcoLe1DXoEVuCH1yMYQVm6e6gA4oNIEYE3wSxE
	x+VzuvEfkUPItk4Hn12FrV17t60l7Icn/j4LF
X-Google-Smtp-Source: AGHT+IHgO2i4FHG1d0lZEoVh6UgtxQ4hJPRuFTd3SLheVnzoIsTlJ1UgQ0OA3MqJ4J5NdlamD+DwKcAPcZu/QaVZp1Y=
X-Received: by 2002:a05:6e02:1c41:b0:3a7:7ee3:10a2 with SMTP id
 e9e14a558f8ab-3ac4b909086mr15788425ab.19.1733965266223; Wed, 11 Dec 2024
 17:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
 <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-1-66aca0eed03e@cloudflare.com>
In-Reply-To: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-1-66aca0eed03e@cloudflare.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 12 Dec 2024 09:00:30 +0800
Message-ID: <CAL+tcoBC1Zr+u30Aoq-UqJB2xc06SjuLzqeWBSySrUBMhs8=MQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Measure TIME-WAIT reuse delay with
 millisecond precision
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Adrien Vasseur <avasseur@cloudflare.com>, Lee Valentine <lvalentine@cloudflare.com>, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:38=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Prepare ground for TIME-WAIT socket reuse with subsecond delay.
>
> Today the last TS.Recent update timestamp, recorded in seconds and stored
> tp->ts_recent_stamp and tw->tw_ts_recent_stamp fields, has two purposes.
>
> Firstly, it is used to track the age of the last recorded TS.Recent value
> to detect when that value becomes outdated due to potential wrap-around o=
f
> the other TCP timestamp clock (RFC 7323, section 5.5).
>
> For this purpose a second-based timestamp is completely sufficient as eve=
n
> in the worst case scenario of a peer using a high resolution microsecond
> timestamp, the wrap-around interval is ~36 minutes long.
>
> Secondly, it serves as a threshold value for allowing TIME-WAIT socket
> reuse. A TIME-WAIT socket can be reused only once the virtual 1 Hz clock,
> ktime_get_seconds, is past the TS.Recent update timestamp.
>
> The purpose behind delaying the TIME-WAIT socket reuse is to wait for the
> other TCP timestamp clock to tick at least once before reusing the
> connection. It is only then that the PAWS mechanism for the reopened
> connection can detect old duplicate segments from the previous connection
> incarnation (RFC 7323, appendix B.2).
>
> In this case using a timestamp with second resolution not only blocks the
> way toward allowing faster TIME-WAIT reuse after shorter subsecond delay,
> but also makes it impossible to reliably delay TW reuse by one second.
>
> As Eric Dumazet has pointed out [1], due to timestamp rounding, the TW
> reuse delay will actually be between (0, 1] seconds, and 0.5 seconds on
> average. We delay TW reuse for one full second only when last TS.Recent
> update coincides with our virtual 1 Hz clock tick.
>
> Considering the above, introduce a dedicated field to store a millisecond
> timestamp of transition into the TIME-WAIT state. Place it in an existing
> 4-byte hole inside inet_timewait_sock structure to avoid an additional
> memory cost.
>
> Use the new timestamp to (i) reliably delay TIME-WAIT reuse by one second=
,
> and (ii) prepare for configurable subsecond reuse delay in the subsequent
> change.
>
> We assume here that a full one second delay was the original intention in
> [2] because it accounts for the worst case scenario of the other TCP usin=
g
> the slowest recommended 1 Hz timestamp clock.
>
> A more involved alternative would be to change the resolution of the last
> TS.Recent update timestamp, tw->tw_ts_recent_stamp, to milliseconds.
>
> [1] https://lore.kernel.org/netdev/CANn89iKB4GFd8sVzCbRttqw_96o3i2wDhX-3D=
raQtsceNGYwug@mail.gmail.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Db8439924316d5bcb266d165b93d632a4b4b859af
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks for your effort!

