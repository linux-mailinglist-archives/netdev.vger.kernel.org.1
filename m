Return-Path: <netdev+bounces-76961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC1B86FB64
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5066F1C21ADC
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27316171AF;
	Mon,  4 Mar 2024 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0qt9aiB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB4171BA
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540003; cv=none; b=Rl37tXTnaDMUHjJa7jWCfvu44gwk03fZ4td6nLNVkPLKWoihAu2BIiDwFmBrmGXixebVl3/jx/LgEi4qgKxAQZONewe/9+8T9r/VdCDtxlG5scvUvk8GSYN9naStsayrcp5rIGf1IDp6Mr6pFTTEw2VO5Ym0ngsh1nueynP6IzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540003; c=relaxed/simple;
	bh=4t0p8fRfEFH8AtnVja0S+UMsbXd66Z0IS78pE3ll0oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FtGdUaa1rclCqUBG6naqELMqCZhKzCWQ0VXCJEkSOnuEUNm6se0xY6xMy5Pda9E72wo+NMfzs/a23hzmjyFoMi0NFKfoVmSq+wIHHJ58unB3AaJH1E0CrASOvUtGCLrBPtPxe3b/NZ5HAdd3lK/MVE0Qy9LTVI0CfT+jCqmBSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0qt9aiB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso21720a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 00:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709539999; x=1710144799; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4t0p8fRfEFH8AtnVja0S+UMsbXd66Z0IS78pE3ll0oY=;
        b=w0qt9aiBR9tUq81QkwVtLbFS/NfedDF3dFMR9g4YqLjU7+x/C1u0My3Pxn9fUUTrTA
         9UyIeDmzDv31u/jKiv1TTDSAgvG8N4jYr08xtPMsZdq2BL3ob6g+cCJ7ijNaH4CtCnSC
         eyeZ7Jh3jlburXwO146WARBnRmL7bEhp/Ul4rXZd9kNSPiEYk+NCkFqO1OWQ9NAVFtmj
         1XHV05ybPq5ik69tndpGm8jPpX5XZlGDjDljK6Vrj9LNrj8v/YELOu2bz/VVU5utPJn6
         0lwKmefMnPrh7qhNJ0p5Ro/etJb0favMsd/LyYawi7jReO8BJxyF6VGSi72n+TNwkhX8
         JYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709539999; x=1710144799;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4t0p8fRfEFH8AtnVja0S+UMsbXd66Z0IS78pE3ll0oY=;
        b=wrJNjTJOqgXv9jkp4qKKjWFN67kiTDxeHQtHGjHNvu8S3NoNQQ7R7nHPtLYM4VqALl
         Lbv20we9FZOjNSIEw1xsOdxSmkUgyAGUO7zwNc9C1jlPlUOR9MIDHWKO5J1ElRmtUP2W
         jv6NBagUV2k8J7H+Z7a5xYwshQKW9RMLoayes0UF35p0kznDKgO+OHp142FJNSnX7IR4
         EjSPJA9umM4qkzWzyaY6PI8YIJtaRyf5ArOdaWFBZUzgAopSdpz86JxNDvPPcwd5ENqC
         a2BRnFSE6wMEHRK/ITxo0W63WiXg4/Iy59Qv0HnbEpJr4CdrifBwYCLfCijehWp4K4uG
         65GA==
X-Forwarded-Encrypted: i=1; AJvYcCUMrPwK7n6YgRT6mojzpO2fjvE986A4LcMedapiDaqxvzE4vYCO0TKUnlH/s0PpY8OEdqMXjBapJVveEwnsXZgY6LpQlsB/
X-Gm-Message-State: AOJu0YxpBhu11Ua/PXe6tJQHi4YYGvO4Hp67K3yxNxTPt2PenvT6NkaY
	5FZzh77HWBOpzp6S0u/HfyVtPb/zKZFCVcQYzLkAleV7bJSOHVDXf8ZNu0Fb4WqyvLj5hJjA4dB
	JaY8XE96472doSY0ofw9C9RiNXLHHUr8in9sf
X-Google-Smtp-Source: AGHT+IFURhXGlP23AfBP73eeZ3jVdVKOw/QcQFPi4UL3YUIEMqBJf9SDBOsSV9UvqLTiivjkUj1SkyMyY3MCNRbV+Ko=
X-Received: by 2002:a50:cb8c:0:b0:566:306:22b7 with SMTP id
 k12-20020a50cb8c000000b00566030622b7mr287915edi.1.1709539999391; Mon, 04 Mar
 2024 00:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304034632.GA21357@didi-ThinkCentre-M920t-N000>
In-Reply-To: <20240304034632.GA21357@didi-ThinkCentre-M920t-N000>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Mar 2024 09:13:06 +0100
Message-ID: <CANn89iJ0yBH3HskjzFUANeTxso5PpihxZcQ4VudzmfsKC-8kDw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Add skb addr and sock addr to arguments
 of tracepoint tcp_probe.
To: edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:46=E2=80=AFAM fuyuanli <fuyuanli@didiglobal.com> w=
rote:
>
> It is useful to expose skb addr and sock addr to user in tracepoint
> tcp_probe, so that we can get more information while monitoring
> receiving of tcp data, by ebpf or other ways.
>
> For example, we need to identify a packet by seq and end_seq when
> calculate transmit latency between lay 2 and lay 4 by ebpf, but which is

Please use "layer 2 and layer 4".

> not available in tcp_probe, so we can only use kprobe hooking
> tcp_rcv_esatblised to get them. But we can use tcp_probe directly if skb
> addr and sock addr are available, which is more efficient.

Okay, but please fix the typo. Correct function name is tcp_rcv_established

>
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> Link: https://lore.kernel.org/netdev/20240229052813.GA23899@didi-ThinkCen=
tre-M920t-N000/
>

