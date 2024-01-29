Return-Path: <netdev+bounces-66695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0356840514
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B991F21534
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5C60DE6;
	Mon, 29 Jan 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/TARmz4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2D5B1EE
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531695; cv=none; b=Tyg+ivMU0xUcDagx+ueM1ubjPHgmE/w4RhgqiyWZXMWF2cZUfdbsHzIQq4Wji2gQVRzGxvrKVZcUD5EUH+7JDhRZb6fIc5XZOihqND7jKkWPCc/NDf2wLXkVBSJ05khp8zFNNvUAfCVirwz0yRh+my1inFCxFqN5+4naruRsxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531695; c=relaxed/simple;
	bh=WCznlEBsDcJ4w6nek8MJ0Kte80pdPo1Tji9v/NnQcTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBK/BG/4ytTWd9hjxitT/TFHgiUVXEgst4xj/axOWgHhNWhPjrEQJZg6AF+gmiZXKUNvVKi6oLIiIc5UL8uKt06p1eFPOjBLxInp3HkGUoIsm8RppHOA2hErTGURDvyQMmQ1R9HiZfEQ7ZX//QfAikPLiyWLl43RlC2j7CUGwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/TARmz4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55eda7c5bffso8015a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 04:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706531692; x=1707136492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtTiJ+l2KgzEu48Tog5tRcF/hIqq1A5D/kAMV4wmY9g=;
        b=g/TARmz4LR3Xwd3PzoSQmEoaZ4J0ZVoLVZestpvQ3DPoTsxciQooymtBDL9aaq8caB
         tahQ5Tqh7kW8OLEGzYiVvYtuKl+IWf7rpdTX8XlE2D0ANMCNwigcidXgeDwobige/KSc
         0j9tBhMimPfdloj4oPwtviy22YQUkW3nHUw1rCzHobjXnwsBw7BTEFxA4OlD+hCXtADJ
         naltRW8YILSSpO5aC+unaGZxgb+N/TG8BXnyiTGwu5raIQ+/zgIn6ietWYYoo6FcHzSS
         d8SU41kvqeDa8rkAARCwdasAm3hPr9MaAMnrxhT17+VmbOkvDkHb3mCA3LTpfBJtrZLO
         qdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706531692; x=1707136492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtTiJ+l2KgzEu48Tog5tRcF/hIqq1A5D/kAMV4wmY9g=;
        b=md74ZBtEayOAGnpkHHOGyKkohqEzA5f7jKNfLW2N8+mWCJk/JJSqUQUUCHhSTdJfgU
         oiMxKsuQSul6byqP4evvfGV+jw8QjjaTTo4ETV/RnaVtXgMfib0WR60kgA+YRq1InGhr
         BxBe5MunQKHBjMo3qUBiXBe6391KQw1BwRrgViy/nJ3scpTggiGRRE5GNvF72P7W4fIW
         z42uL9mH4+sDuL2Wz78l+uzlTQh9H3OzEkdksVxwG6lVqORIL/eX8HqmgUu+Qu21q8yv
         lapZVOWW20Oxc0i8OvQiySXSPJNQYSBRns94Bp693QVeDf6PaxN17dAgFC8INQMJ9QFV
         Oxdg==
X-Gm-Message-State: AOJu0Yz/yQ0PHjZvXPeaDroZYjfZ9kUOyScGFMYG/jhTlwW7HOKgG653
	IRbiRpgMni0AJ0bIKO+Or6wR2l03C/f2I4FiIHf1ejXTPZH5kFyeTSmPhWPEBVQGDRPQHLC90Lg
	B02RoJ7eMK75TwTAhe0Nvtak+GCkqUeNnhNEH
X-Google-Smtp-Source: AGHT+IFac2cOSYnbtc5nL6f/ebKgEFYhurJcihUOwmwj6XVYapzlZkuj7gCxrZxRlkGppkax+HRVY5uuR0k9jncBC8U=
X-Received: by 2002:a05:6402:22cf:b0:55e:f115:3a95 with SMTP id
 dm15-20020a05640222cf00b0055ef1153a95mr141763edb.0.1706531692260; Mon, 29 Jan
 2024 04:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126040519.1846345-1-menglong8.dong@gmail.com>
In-Reply-To: <20240126040519.1846345-1-menglong8.dong@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jan 2024 13:34:38 +0100
Message-ID: <CANn89iLOx0R62gkTmk7Wq9OwnfB25a4xqtYkw712sqZeNyMRQg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: tcp: accept old ack during closing
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 5:04=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> For now, the packet with an old ack is not accepted if we are in
> FIN_WAIT1 state, which can cause retransmission. Taking the following
> case as an example:
>
>     Client                               Server
>       |                                    |
>   FIN_WAIT1(Send FIN, seq=3D10)          FIN_WAIT1(Send FIN, seq=3D20, ac=
k=3D10)
>       |                                    |
>       |                                Send ACK(seq=3D21, ack=3D11)
>    Recv ACK(seq=3D21, ack=3D11)
>       |
>    Recv FIN(seq=3D20, ack=3D10)
>
> In the case above, simultaneous close is happening, and the FIN and ACK
> packet that send from the server is out of order. Then, the FIN will be
> dropped by the client, as it has an old ack. Then, the server has to
> retransmit the FIN, which can cause delay if the server has set the
> SO_LINGER on the socket.
>
> Old ack is accepted in the ESTABLISHED and TIME_WAIT state, and I think
> it should be better to keep the same logic.
>
> In this commit, we accept old ack in FIN_WAIT1/FIN_WAIT2/CLOSING/LAST_ACK
> states. Maybe we should limit it to FIN_WAIT1 for now?
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

