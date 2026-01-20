Return-Path: <netdev+bounces-251401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E2D3C3A2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C1026645F3
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D763BF2E3;
	Tue, 20 Jan 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAz3QCpF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FCC3BF2EC
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900275; cv=pass; b=EQdlLz74MBhIRyFXMZ+7E5tNzBuFm1qfAQoIDreFNRANvQn35cZ3UZ2O7J1cX/0/D31eJWtA/80EfRCjiUlLasrfZJdID0Y5Me5D0nHiD4cMrpsqfT0Bo/mGBSRzJEcydU3T6PVxBehJDJwkyy2cleM6MAgoG8cDqZAcAUcqm2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900275; c=relaxed/simple;
	bh=sr/D3loxcW3zgKxJASxgPSEmEne+stX0kvpMIBGVae4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5Uy6x/BncFDF8AVZ9TmkVeqnQGvnXwpg44X/EgNDhRmC8QZlDYLNJjQ1rhk44dI4Yv0435LwzR2zahgzm4/LkjsC3pdmC5oz2Igu7gskxTtJPfKVct9TWN8uQB+HoEgEx+C1Kbj/oVO/QBj90gxYP6JEAVYzwyG5KzkRLpIBoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAz3QCpF; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014b7de222so51330021cf.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:11:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768900272; cv=none;
        d=google.com; s=arc-20240605;
        b=R9zBz9HEcKb/wote7C410r3FViOtBQIUh5u4kP48M/HLffYyWiDS5bu+OmnzQDYLJk
         O7105Md9KDLPOQCe72PNFxg9wghEuF+GV0Hhwix4kgJfXPrS7ahIutotNCtQYdD+uXBO
         t5v6I2+Pp5x6i5ZunePMqYNt6muutmr1F6cb9QW/j8YGHVZMr7iU6Aun4zVGVWETmEgW
         TdMUiQRvLpqtF6v50dKJMkeIGCnuYTtJ5U1awWUNygd3CqykVTCzwLQ2U1Ir6VInvvT5
         Mcfh/omsDt+kqFQWg0TFjsuHDaz6OUlLHszG7B6YQP0jPZ4RMIDlEXVn+tAl/h5CF1hz
         umhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5WYoDnSFRQEA9MKbDH9fqTg5m/DI0C0n/ySPFiEIq2M=;
        fh=uoSRB19O+ywB4I5CfplegB9+0iHiCG57YKu0RTaoMfY=;
        b=ZbpZQMzJfkv4IcybPFz/Q/YtTDLmN6k6c7k96d9w5AupeQKtktK6QjEtcMoydErbb5
         DhC1N/HMTls7eP1c14gm06DA39z32C19YMhbkqyfS0qA0xpTSQqzS4eVGtSIZjclVaxu
         YpE6SZ7nt8jgBpYmaBJ3BSbiRWD2oiqxv1jQW928eSBza/HZf/TA1J2WQoOQlhA4OhDW
         QRPUKbvlW2k0FAUUcrMY0eZK2WtJmihQzyGzSJZGizoj0gnGFPG80UI61mNptm+9Nun7
         7VLWNeUkM1iWNcnA33OmL9GZhH8S5pOA3ze+ysvymBsV6x6dMT2EqGlmfVy0nr00OLJS
         xj7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768900272; x=1769505072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WYoDnSFRQEA9MKbDH9fqTg5m/DI0C0n/ySPFiEIq2M=;
        b=xAz3QCpFpBOWB6xDPkrlnHBN4jwfUtVHV54ZJWs8tbtNosjbjQNIxD139SMgjLEWos
         sbJ+Sl0Tpp62AK/pHI4162Cawq4DLRHLOjoIz1WR0L1Jp1NRt0BflG8AaWyQNH59zZZ+
         MMRNJRVLKd9kExA6vAVhgpYB+hLOuJpCeNCEdFP+jUD/Pzy8Asm2O5QdmR9or+WM2grn
         pRBbWBGEDEeLpNTdAVBHwMfirNZeyRsw1Th7hYlhZ0yiD9zl8kjXqtMojiHD8I6ImHfj
         LW3lWzBC0BQdSXhedCk2NQjyAKnuODfO6j4NmFUkgrdgnYcv84N4VQAdbag6WmwswsAP
         rrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900272; x=1769505072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5WYoDnSFRQEA9MKbDH9fqTg5m/DI0C0n/ySPFiEIq2M=;
        b=mxtnXT+RKZdahFs/7kaEgJcMImAd4+uw1mXDSHtZpZF2URyG6LGmFCAQ9jhGj0G5/Z
         nn5H6TDIWqi70cFyWzTY6lWc66HCqkVJfp1dnnK8IBne3W4M4g4tNbpqJuQgPeRMdeO7
         JiXzbYJ+w5IJjm/i9MXCxuUjr64STJMaFKrO2vozgfEFGdj+NOguo6cDnyV7rS0HeYiL
         y0/siblFCjMGRIbeCUxuJWbttpA6zHKXO8x8OR+zl0Mm2XB39/lMp+DQFHrV/9bocbfs
         JdUALvSThyXDp2GuQMArkMTqLrebtHF3BdtUyQ3Iz3XjyLpSE8Hjk7W9/MRnvpGnFxks
         lbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTUL52KvptIpuL7Ld0/7L3RLPDr7HFx6NL/p8hLdHDK6ugi2B/xZhd8sZ30rqSYEwtSgvSjzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMwhC/7wwVGQbegI4BXarzwoUer0Gb+ECrnh5PGvciBZa512j
	Y/nuad2khG6wwBxCE8jEcqTdGskY770Jqef0rikqFBX9k8QaX7CPrdLvgw11U7xNMWmOgagVM/n
	nTJn2zAV5jmCBPS+xSlXIR0j1gubsmgesbRGGpLAx
X-Gm-Gg: AY/fxX5ohFY3eeVIOpG6MuJKabYwML6fdnGm3WVsqgahzgYEJBQOxj7Pq7AkcHbe8dc
	C0Pgd5aO+BeVPZZMsheQuXwGr24wnCnvyBvKeeSFSN8JqERMBZu4BwsjRP49d1Y324uqi5ZblwA
	r7pji+dGITC7Ynj2/aUFYzH8FYHI6DdR46YNkSiFJfF8Fo67WK3TgRN7ANQM0jK5Dp3DrQpsWeO
	913BJbCarmg1Dx1/ovUKc7VJVhtNhD53uFkdKkd4cV6i5eQgRyJGBJ7Y9LcW9u6eUyOnbc=
X-Received: by 2002:a05:622a:19a0:b0:4ee:17b0:6261 with SMTP id
 d75a77b69052e-502a168e7a9mr204346991cf.29.1768900271500; Tue, 20 Jan 2026
 01:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129095740.3338476-1-edumazet@google.com> <CAL+tcoAS9u1A9xpsWaAzSojJ7qepWsvF3imC5LtEhu=zD9AjsQ@mail.gmail.com>
 <87jyxc1wnb.ffs@tglx>
In-Reply-To: <87jyxc1wnb.ffs@tglx>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:11:00 +0100
X-Gm-Features: AZwV_Qg6wO03LZww9IwZ7Vwp6PECZdvn0r5NTA_3IV_-b5XyzvnspOrvR7Md6pg
Message-ID: <CANn89iLz=syAMbfEdVXVg_tCwvwWhObRDGk29ko9CkQHhAHWhg@mail.gmail.com>
Subject: Re: [PATCH] time/timecounter: inline timecounter_cyc2time()
To: Thomas Gleixner <tglx@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Kevin Yang <yyd@google.com>, 
	Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 10:06=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> =
wrote:
>
> On Tue, Jan 20 2026 at 16:18, Jason Xing wrote:
> > On Sat, Nov 29, 2025 at 5:57=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >
> > When I'm browsing the modification related to SWIFT, I noticed this
> > patch seems to have not been merged yet?
>
> It's in the tip tree and scheduled for the next merge window.

You beat me to it, thank you

tip tree :

commit 4725344462362e2ce2645f354737a8ea4280fa57
Author:     Eric Dumazet <edumazet@google.com>
AuthorDate: Sat Nov 29 09:57:40 2025 +0000
Commit:     Thomas Gleixner <tglx@kernel.org>
CommitDate: Mon Dec 15 20:16:49 2025 +0100

    time/timecounter: Inline timecounter_cyc2time()

