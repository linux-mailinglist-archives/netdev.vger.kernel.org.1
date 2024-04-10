Return-Path: <netdev+bounces-86701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A88A0002
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 20:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56951B260BB
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 18:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EAA1DA4E;
	Wed, 10 Apr 2024 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBHov/ny"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D018E0E
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774858; cv=none; b=sN/FQ4K6/Hhapvvvd2gpSoItsnZdeatVAIazeWcH/JmrOeKvrGMGBLHtmqSlytSHggQ3pJ4v8YMmMESJk3uWObGoa2uxhhXhXZ2KKUeIEWs5ob7mf4ozuDJGIp5Jqa23Ea57qrVzFVhxl3uTeb18POr21UVkWnlqa6BSUj1P8ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774858; c=relaxed/simple;
	bh=w0X4sTmyEpI9c7VphNyk9ayngZscA9wU7oQNQZuy81o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/pUzWaj6bnFZCm/xQtGbo/ggiNZw/lPMFzZFeQe53jZkdlRFzInljqAhSutzTuew6dJmFlHrLbENR+NLdN9x4n25Mw3SmMio0nhtNJzVzsl6C6YQlRw+2u70dbXl/7jMZKwh9X1hWmxqbboM0upcYTAibb3GEeSKA4UviPsfnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBHov/ny; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so2804a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712774855; x=1713379655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0X4sTmyEpI9c7VphNyk9ayngZscA9wU7oQNQZuy81o=;
        b=NBHov/nyG4DySMFkxB82f7YLam+B1+qarmp5j/ws7DhMpyyINBRpk9VQBw697TuviU
         CMa7EH6xDqBQJNGpfTIJEDJPd3zFvo+Osn7KIc2qSd+3ZUqsOF3dJtgl0uhXfQP5aZN9
         iDwU+rEAQxUmY+muMbv/VHQTNjtciTqyQEJhglyLrRGiQn1CeatigMNfm7/BFrGQK7gp
         ZzBhLIdVzY7aFynGVyzvVtT6OaHtg6w2RptxN00baw0JMTXLacu+JYh8eUTIkJnaJ9/6
         MDpItoKDwihMGL66rx77Afc5OAQufiuBAFEIF9uZoSnpmKh+h8t96OaKsR1vRdc7t6Tq
         d93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712774855; x=1713379655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0X4sTmyEpI9c7VphNyk9ayngZscA9wU7oQNQZuy81o=;
        b=Cvlg73aod8NZJ5/P4IT6Df1MGAJa/PPRK4MKvcdZ4gdloExg/4ofTyhqsyFgqprU8N
         jvLs6S2O8D1ViWpv2egYrzm6WaBcXCEmvnUtp5Tcp6mit4+XQxjpP86USlhkdhw4RJda
         LjppASj2aZ4NGugogtQkylX7z2maLcTAT9UQQsgaVZ8gD8QEOGOJLDtZUBkibsa2M1N4
         QGCO53ogCw9g9aVUPnMBYEJYCA2F2+yZ10yilnm+vjsBZNO+PSFUhEwmqeXwXVvB/2Mj
         Ik1VxokGzGN/DrOpoMOuIjma+hcQft0EuB2ZMpj8q5x3QL+zSzU6eiBQV0utjAJocZoE
         QdCA==
X-Gm-Message-State: AOJu0Yyk/89V7vI6x8HjnpF558kxEzrFod8JaecwJTX/WWIKfcHfw0wl
	xnoaQWRtq6eDs4dm2j8bT+3Fym40LJXqrhJd8S/6ri1CMNSd1hk8VGIJZ5Qjm79Wptzg7nXB+9c
	2PQQKWkqJeb//x71Mej/OCHBgmWrmLrGUT8hq
X-Google-Smtp-Source: AGHT+IFvQgbHPnB80hnfLH8RVlBOV21iMT1tCzqGSPiSVvekCNpfZjPR6kmZgmljs5IeNNTavNCA2/ticTtl7xAQlTs=
X-Received: by 2002:aa7:d651:0:b0:56f:d663:cfd9 with SMTP id
 v17-20020aa7d651000000b0056fd663cfd9mr9578edr.1.1712774854847; Wed, 10 Apr
 2024 11:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712711977.git.asml.silence@gmail.com> <a887463fb219d973ec5ad275e31194812571f1f5.1712711977.git.asml.silence@gmail.com>
In-Reply-To: <a887463fb219d973ec5ad275e31194812571f1f5.1712711977.git.asml.silence@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Apr 2024 20:47:19 +0200
Message-ID: <CANn89iJf8JCpKM4kLx=mW5Hs3nyEKoK+ranqvTxjgE61YqtBPw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 3:28=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> disable softirqs and put the buffer into cpu local caches.
>
> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
> throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
> I'd expect the win doubled with rx only benchmarks, as the optimisation
> is for the receive path, but the test spends >55% of CPU doing writes.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

