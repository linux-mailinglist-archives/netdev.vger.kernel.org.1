Return-Path: <netdev+bounces-174177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2271A5DC18
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E492C17A1C2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E823F422;
	Wed, 12 Mar 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brsC5YRq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D673232
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780653; cv=none; b=Weh/cvytq0THTytPisfpgOdExY+Qw9Li2MRL+/9isf8alraA1aqwf19RBBSb+BrHFjdhVbRJZO844Lh3M9jArwTxB+dAqNGDD07a9Oed5MvgxDReB018aYQg1F5czl7mEJ8JDB5Xc2NEluJsgbXN3Qiib/CWbCwHGjzSky9r7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780653; c=relaxed/simple;
	bh=Ux4Z9udS5X1wLR/aiZDS/xwwVTLceGrRKCic4IFxWI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBWIUF4pan4E35PiAcpogL4NQ22kxAlr0R5xtQFn1eDm2BcQKIMeYp1q571EIC/V1yfoA+sW3RetKFD3RuW7TwbThD4txeMtSV9I/37xGbWInmfwUdyCtzS301P6XM1xbBUBDS07+zqhqbOq8Fllhj8EdcVc5qyNfYBtagYC2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brsC5YRq; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d450154245so28169385ab.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741780651; x=1742385451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux4Z9udS5X1wLR/aiZDS/xwwVTLceGrRKCic4IFxWI8=;
        b=brsC5YRqTas9vJXNEKvPbqqrwXzBITOhFNtsX8HWJiuUG9VQt1Yb4w7OPa3TiJ/76Y
         AAgf3xZMmIXEzDSWzyqMLSeHjj7/zY5uPhj3HPfSlZczf7ZWkOtNJilBP1ykw4FdOU+b
         2RWAtIC8+Xk/X9mScnJ3IybhEYpFxbYkunHZI372GtiXpQwagqGZmL4IEFrfZ6OH962c
         y0lAkgUdhfpJ/og3iLRsyWyfNP/DNg3hrUANiti7U5/XSDiZbk8INhZbeXmEd6j0SyOO
         Z4ZsC9GzCeEkxHJTESkqK/IGsQwodLiBM05AggxzoR8oFuDYjtGy3pcJ3naV/EoMpEZg
         +w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780651; x=1742385451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux4Z9udS5X1wLR/aiZDS/xwwVTLceGrRKCic4IFxWI8=;
        b=ITiib4kibZVkXBfbDgBuCQPx1RwPsTx3jvwZBJxuRZwS77RRZ/shT1v5tX0exHj9pe
         8WgLCeKevEeeulNlEzhBM0p4+eyd+VK94hxQXWzZeXt0FAOa43E9+3wHFihjPwiNLUwp
         hz3rChCq1tf/ov0quXycXa71pFad962n3bq7GIrY6KoGN2ZKI4FFVfjiJjX2j8IMe3XC
         vRbclslf0bpKsfpQRPaoIEcJSAAXILFNcVgufjtDTzqwUdOKCQvrAAG7qjeKaiBr1m13
         NuKE/Yk/tAOm5c6vkjQ8sPM12peg83EYcsrNrMxTz4/ziZq8fqXacXaJKjT0JjEh2Ho7
         rJFA==
X-Forwarded-Encrypted: i=1; AJvYcCVIBIuRJ9G1JtEmn4apyHXb4GcIPuzeYzloqghL68n4RmBTiNBepwN60dT0M/M4CGEefnj0SkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBEp929QE9gRrUVWcaOwPprRyjly0hUTpR0rJtpf+NXwB8n/t
	tx0N91g5HvywhEYuy7NjAmhPSfQRk/xOcYaZd2udbHJmsjulFmsOfY22v47GsGJNyeWY/iwwy1R
	9vPeQXMSttTlP6hNT9tIwowmCNnc=
X-Gm-Gg: ASbGncvUjNdez6FnSOC6iRr087Xko+rgEQfNHjLA9alA/j4Tipn32M5KNMPFBAoe5Lx
	AYVhR2y0R63n77tZDGV/TIOKVG1nAM3C/zyumwnXrCtRxjElPnAHEibagpZv96Biyp5X8mxwBTt
	o77mG2edNxD9kKM78hhE8zGSMxPg==
X-Google-Smtp-Source: AGHT+IGXqQbwK7FnOMSVa5rLYnXEDYO6m7yHTw88OTuu7MJeh6yTAdpQI+N0uzGhpfchkmmaPWuz582OsS54i6wDck0=
X-Received: by 2002:a05:6e02:219c:b0:3d0:10a6:99aa with SMTP id
 e9e14a558f8ab-3d44187c249mr234713375ab.4.1741780651468; Wed, 12 Mar 2025
 04:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312083907.1931644-1-edumazet@google.com>
In-Reply-To: <20250312083907.1931644-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 12 Mar 2025 12:56:53 +0100
X-Gm-Features: AQ5f1JorSxVH49LDP8dNtc_cuh9O2hgX3WTkcvJySQMZv1NrFzxgKHBmQNzZpfk
Message-ID: <CAL+tcoCpkFJrQzq+bVFbst1uoyUF0x1CcD4g2LshuZtF9MzyXg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: cache RTAX_QUICKACK metric in a hot cache line
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:39=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
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

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

