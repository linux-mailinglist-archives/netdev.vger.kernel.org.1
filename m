Return-Path: <netdev+bounces-236699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE95C3EFB6
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0DD3ADDB0
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922B3310768;
	Fri,  7 Nov 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ia1ZK1wV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F74310627
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504639; cv=none; b=QOnY567IO4QjHoWNByo8EPiL7cgKcY+u6IgXiUDR/XgfaYYv/sVgugHjj7DO4CUPZCLJwHJMAmw5JnHhoTnIq2RkhI0zmcp6iJAp34KX96E5gUsvoGwtxOhMgTSFTmlucz31DIRrBpdFNO7L/QbqFqHHBcfPM+9xolZQgNGWEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504639; c=relaxed/simple;
	bh=ZcRp2wy6tbxP6b7VzXvU0rEPtZp5mqsvIIQ2KkrLqEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIAHrK0E5HFDmumSCzl6I+ZXiXpScUxGgA5EifBKYhqrTpNAl6MKnFuG8hncvbAw2VqycEjPQpc05LqHgg29taeYYj3L5gSKzEVcHX/eJLj3u0Lzr1Y/VBDRSJL6p7bTkyuRNu+kyZH3cvHRHfBWR/xe5F1PoooZWCqVZIUG70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ia1ZK1wV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed69197d32so6736571cf.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762504637; x=1763109437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAHo1HzSbo/qjp6ufIhn6ZVedIIKjn3lQbr4hjVkzZ8=;
        b=Ia1ZK1wVRlfMu71FhU77ciP++HVK6b9Kq9xoZ3MJZ0fULs3JF1iVft2Iw8EXFr/dDU
         snBmWdRGrCCpxrTaLiQQhwoFgIIytETk8kEF4Cn+B7TmxGyfCOtw2WVjB8xXGYNNmNJF
         BqMb7Z1evL3V9qgFXIVKefSTamPXj/wqpZd6NCGx96D9ucD4pFzsup35CtheVTF2altB
         FjsaErHWhK1h/j9kNZWfXjjMMJhb6ROIQNKY87tCEZPAPpWjmQ9t71hNiFkiBzF/xPYC
         LNBnRI/P1KM2DfkhWZxwCf3P7H9Hs596aOnpBtYxb8D2wZwy1bmRn3C/8PkANOlMM9S9
         ZuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504637; x=1763109437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NAHo1HzSbo/qjp6ufIhn6ZVedIIKjn3lQbr4hjVkzZ8=;
        b=iNqQ0G34pE7DKLM0nDTOycHtCIZSj36iLXlzwz7N5aCm1SLPc5Ly+dyk6GfyRapwH+
         pf8td4lK7JMPlQiTGADCO4IVdRSyBkGHkmAp8Reuy5eloRHs1KzFBaz6Zy7pYg685KJs
         MiIw1WUMv0BWG0KueUDKX+JBC3a6YQCBGSygB1M4C86LOzKUf6OocM5SyzToBx8/Rai3
         uKc6agFdvwC3rZiWjW8+RgWKkGj2QLj1vZpBRRO2Xlo7GsuRJsBbAugtR8gB1PUFt7Fi
         j9CkDvOyFGyZaHoVj1gsq+Qr0V1847W4EvVQ3K/XbJ8WZ0kbp7UVs3bFqn9zJiJq2zmT
         h4vA==
X-Forwarded-Encrypted: i=1; AJvYcCVDcz+tYW4NY7d5VZvFueoj+0h94qOfgGpcmYEV1tikWntbq/pOS8Wm+5rT8PcN0R8HHLtLSSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKH/8bgv6K11G+x9Zq1LcOvuad5uirBmO+MhjPRUXnEy1ckDuQ
	PzXWAk61UwKpr3zC3fp2O+NtURnSwGD3PRHfWTVO2zys8IZLtiid7VHMJ0wywwEx+PzYam814wO
	7S8/IQush67nprqRnUtPn3ypGgxAqMXFC8dhjCnZl
X-Gm-Gg: ASbGncsvrAW1nRGhonxtZ7GPIXRQHLMQbYLlyOGWwwlMa9E9mG9iK0cAoEzkNfeslTD
	sDK39+JmAhxaIZ0QvTuc+KE4/DXuHXGt4W7klGsSMQtQigSS/stWIFl6w+f9v3dkAZf/RQW7Mvy
	EktDbdA7elPtGM2Mmkl/UTMsbHpfzdI44UoCjg+TE9u3LRV3Il4nQbGGvwFd6vxfzAiz9T737ky
	cYhXYAIZ8UCPJvVymFu2fy43d+248eGTxTUHqkdCPgSkYYDeGF+fMgbeXvf3GgIESMES1Ux
X-Google-Smtp-Source: AGHT+IGAsBRUPSkKmJbr8pafQhg7lmSw2lkFyie4shHo35ZXjciQYO3XM1JIg0qxoIko62h34jnJa962xGRLJCvlpx0=
X-Received: by 2002:a05:622a:1455:b0:4b7:9f68:52d6 with SMTP id
 d75a77b69052e-4ed94939baemr24499511cf.9.1762504636486; Fri, 07 Nov 2025
 00:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com> <20251106003357.273403-4-kuniyu@google.com>
In-Reply-To: <20251106003357.273403-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 00:37:05 -0800
X-Gm-Features: AWmQ_blo9-Y_rIFKnj6lDR4CyGMzE2TvKpqpTpyCsXFXY0i0NFDiKgVmz4i0pN4
Message-ID: <CANn89i+CntWvmzsSVOzUDTw4Cb0cf3-83C8Y7ByPxD7iN38vtw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/6] tcp: Remove redundant init for req->num_timeout.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> Commit 5903123f662e ("tcp: Use BPF timeout setting for SYN ACK
> RTO") introduced req->timeout and initialised it in 3 places:
>
>   1. reqsk_alloc() sets 0
>   2. inet_reqsk_alloc() sets TCP_TIMEOUT_INIT
>   3. tcp_conn_request() sets tcp_timeout_init()
>
> 1. has been always redundant as 2. overwrites it immediately.
>
> 2. was necessary for TFO SYN+ACK but is no longer needed after
> commit 8ea731d4c2ce ("tcp: Make SYN ACK RTO tunable by BPF
> programs with TFO").
>
> 3. was moved to reqsk_queue_hash_req() in the previous patch.
>
> Now, we always initialise req->timeout just before scheduling
> the SYN+ACK timer:
>
>   * For non-TFO SYN+ACK : reqsk_queue_hash_req()
>   * For TFO SYN+ACK     : tcp_fastopen_create_child()
>
> Let's remove the redundant initialisation of req->timeout in
> reqsk_alloc() and inet_reqsk_alloc().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

