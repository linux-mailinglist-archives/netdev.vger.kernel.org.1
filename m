Return-Path: <netdev+bounces-174221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD15A5DDDF
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6514516B26E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D9422ACD1;
	Wed, 12 Mar 2025 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zF16JTIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFBE78F32
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785885; cv=none; b=IZj9NhPKoEv7tZLEzGRv2/53OVWkT+fh2tMUCZLT+JJLjBnv/Aa3P2UrXiNAwKSw4csudkPuexHVHi/AGK4C04djgUK8MnpVifRD5+MFCExeQkMQdu5fFkRcImsAAgVARogGQ33z874G1rL5KUR/IqAHXB2fQl66yzO2hCVxQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785885; c=relaxed/simple;
	bh=dhWDCw//UU5tFEqNZ4IuoDRVBakDx3j5bKosRjrQ7bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i510rqBkrKcFbLm1PU0YtRwBPjTzKZLySgmHaUp7KGdDlfCSjf5L+sjQz0G1oyqGcWWXWIK4L8haD2QNvv8VXFf7sbf7IPs3lD6p7hu+svpuTgnKsmYm10tbnnCe7R7GzOfHUfxjfUwRMuKIEblwAi/gpzcWDRWu66KVGf08CN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zF16JTIX; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476693c2cc2so241381cf.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741785882; x=1742390682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhWDCw//UU5tFEqNZ4IuoDRVBakDx3j5bKosRjrQ7bs=;
        b=zF16JTIX5hkbUOdzzaL1+FZskKZFH60LRX/auRiFIEfrVzLiaVY6eN1vaWt6QDFfhz
         YZBO4Rpca8hMA9ZsHKUWAvOpGbjYnxOkoLO/EUohnP6xNDRj7jeN8+On24MvFAlC1ghx
         tswLv3/3KsDds7dPsdf1DQjjOghDdcgkUl3527gyiL85HiB5Jk7rJFGXA02Uu5lMVlwb
         vrojhD3xUbKdkMxeNUms+Q7p7zbflhc3+Lfv6c/WhR1rpVO2MhGjXkX9z4WvZO3KtsDO
         JwaJGgG6e/P085dGjDf63C08QSTDv5Ly7r+mpZGWNaukWAc6Jc1pFVuNnidemUY+ZZuE
         45Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785882; x=1742390682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhWDCw//UU5tFEqNZ4IuoDRVBakDx3j5bKosRjrQ7bs=;
        b=BDbhC4UB+H3omR/pm6rA7zcrlqUfmwJ1VxjRFlQO+7wYngGaBv3XjSe4KZJwlWgj6w
         3Q1pYw8Ay1Tq3dOtH3UHzswb7k/tGmKMm/Q39q+zc1EwvMVCd+DpZqVGV0ezEKqGIa8i
         kuJxjlox4Zs7CUiO8gCOXnGEHtObDx96RWtRU3ZFQokfqBDSgyHr/lQe2eayhHVt5In4
         IibP2NnK7qDH2CfFgCs3SyRSt59n0hwULB+1Td9G8bu3rX78JM/gtNh3F2KC7g3JIc5q
         zwuZFXwNuQawdLnxiYkosMdXX0vBtmUg5lKcfvd01qLiS1L0g/AekDK86VvdwD2uBOOS
         IpEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwAZN/219vXeZeT51lpWamq9WzIdgr/L7jp3i4DqemJTTMDKi5qnzHQFabzclWV/xgY7OHyBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJh62Fb6e30gosD1wPwV/KrU/R2Q623NI1cOUrN7OESA1O0Mov
	ZzEeKocq8r/126Mttx0dMgRPfnERacavus83aiFCw2PgcpnQVM3kmAmRTkBzgVt+2BkCOS7/byv
	PYdB0G9fKU+FcANm/6S5WOZathqUWT/YWe2Rv
X-Gm-Gg: ASbGncsZU7aBXhuTDSqAy2g7t8v7vWrIvZCjocNzOUCdQsjCQU2vSsBXiEZ4qq5kwRJ
	HU6IbvjtRxUAH14zQYiJLCa2H/yr1aznAGZGIY1ehEOXVl1mDU4w2COEGzZbeARmy7zF8ahZytQ
	/2H9pKkV6u1hr7yU2kMselVj5bUwOPFcWUTYbOBvmgbefNPv/iFQrITchFoXg=
X-Google-Smtp-Source: AGHT+IEoANF3HwHcaOVyW02qYgp2agFW/LQo+xKvF+eq2cARNNMdqSd3bTj2btO3SFTcPG8Fd/ZjgPUVVPhwmFc2STI=
X-Received: by 2002:a05:622a:190e:b0:472:915:a200 with SMTP id
 d75a77b69052e-476ac709dedmr3560691cf.28.1741785882305; Wed, 12 Mar 2025
 06:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312083907.1931644-1-edumazet@google.com>
In-Reply-To: <20250312083907.1931644-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 12 Mar 2025 09:24:24 -0400
X-Gm-Features: AQ5f1JroLQqmf2dTxGvy_w0mtaZpuT7JWOo3K_pE0LpSOXK4xw_rD-VdLXXnyXU
Message-ID: <CADVnQynrSn-oJ4tyhXkZScEirnsd2n3PJeJgG5NFhuNiKjy5Fg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: cache RTAX_QUICKACK metric in a hot cache line
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:39=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_in_quickack_mode() is called from input path for small packets.
>
> It calls __sk_dst_get() which reads sk->sk_dst_cache which has been
> put in sock_read_tx group (for good reasons).
>
> Then dst_metric(dst, RTAX_QUICKACK) also needs extra cache line misses.
>
> Cache RTAX_QUICKACK in icsk->icsk_ack.dst_quick_ack to no longer pull
> these cache lines for the cases a delayed ACK is scheduled.
>
> After this patch TCP receive path does not longer access sock_read_tx
> group.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Great! Indeed, from double-checking the code, it looks like with this
change there are no fetches of dst RTAX_ values outside of the
connection initialization code paths. That's great. Thanks, Eric!

Reviewed-by: Neal Cardwell <ncardwell@google.com>

neal

