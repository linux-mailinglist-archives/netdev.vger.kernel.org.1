Return-Path: <netdev+bounces-227899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64277BBCDCD
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 01:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1992C346FB5
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 23:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94621F428C;
	Sun,  5 Oct 2025 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inzZ60nb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331821E47A8
	for <netdev@vger.kernel.org>; Sun,  5 Oct 2025 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759706229; cv=none; b=SG5OD5384ilrcsbPtF4aUhdaJP6zw8I30Fwc9YIE++yyJ7o7x0wO2lL9o5y3rJREYBN+CE1riD1hI1fMo1sPF50QM2yMa4o5uRud6C5wmmJUe0TCkJPObH9fVrAAvj805quJ3E8R7MUbLA/0fa6Hw3utKMZKvRZdANlq3bSZ5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759706229; c=relaxed/simple;
	bh=KrrXqdXW2fhh4Fjd5JBDFKjxV94MvA7vO/p8Trro7Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjbFvgTe4Dqq3ekNRANxsDQrzManyJH0aRkg4jVmyRyft9uvH7HRQtkfd670n2SpJWmXrVC/FOhLzOcus1+wKtJqUfY9N99K/l6YHeFgVuKzNNdCvPrfvmGeLsJorVUDUfOZGJ9XoAt+OGfRwvb952CZBnJNpwsENjGGs2f4fKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inzZ60nb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b609a32a9b6so2818326a12.2
        for <netdev@vger.kernel.org>; Sun, 05 Oct 2025 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759706227; x=1760311027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrrXqdXW2fhh4Fjd5JBDFKjxV94MvA7vO/p8Trro7Ko=;
        b=inzZ60nbFVpCYTyCN6csdwDDz0uC/bNwUbKtWAZZ4Z46EiXVtD7kCyqZBF/ZT2xks1
         nYCjFoBaGBySunFRzR3FWpQlxTLYy/J8r9o1xmDeFCZmJiU/RhE66WI3Cx/5/RNY6Uhu
         B7mjDIFsH1zOLYApBEJDBbux+/YpjR4q9DoQa9C/e/7n2pgHaOR+45INwYOUT+IS46wv
         PPLyL41KRZlqRJIDuVyfc93nZTYVrTU/MJIldvs6/PjeV5box++PuX6hBaS9v/4ghGx6
         Ylk4onIL663ntB4lO1YNuHjxl32GU6poXL2ZeLN4BRStk4BW0hKBsisDv8RQfx0V+0Y3
         ssEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759706227; x=1760311027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrrXqdXW2fhh4Fjd5JBDFKjxV94MvA7vO/p8Trro7Ko=;
        b=Wtpith8Fe6cuvkdlFeUl8RgWuPwrG8Xme8uEim9LvpIg2qMYzvelgx1spGqinkmS7w
         EKlxNnTJcAGfneHXgLBvQasNZ1t1DIK+rxjbcR0mclh+UV8Z7Spmpd8YbYx81wDNqHzA
         3GR2XAIHffpuYB7BMgKNy8EqDAvPN1fv1hKuxKnMfch7Yz128ayoYpZKm0Kys0Ql5DCM
         Azw8usYtAPd3HQnYBRq13zd6QNSToPFINPaflR1hdMvarE1cRC9dOreb8XP4xTHyVA2Z
         CWpnMhEWmBSBiLyd3Vdsjz79LvClna7Eeba1+ikX6DDbis7qxuzrqZw/xzdExsJLcNvC
         Dcaw==
X-Forwarded-Encrypted: i=1; AJvYcCX0QRvS5ms4L5cbbFEiciMJ+4jU4AJRzFYBRpyFyA/moZa3/gitUXPstx3TgP37bhy3EwYJpXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO6POi7cD+FDug7qnWZCww4bTueADtvf+maQ45KXYEKq/9joVY
	zi5xxTvenAcKlg0HmXmbAo/AWz24vyG+8eXlHIDd4UbP5qNMlGpOAGu+IQS9UMRNIV29Si0ip7l
	mI4bcZu6zTocF0JKZ5nfSNsct2Cprp/FnQ+RNbGCp
X-Gm-Gg: ASbGnctZNyikqmQkMXo1aOlqGdToktiRAvASIX8dTjeu0F4y0l0APc08c5MGsW0w9LV
	CALq192Ez423taiQeKzri8exjF0gmiJA9DdEPaMJUL4kXcVN6Tb2DxP5NQ/hrtdTQpEtar6TpIU
	iVSodo3q7tUWQlOM6ORSJCx7949cD3nuT9YUgEd0N5EGY6sRIFcNZfE/PUICAhZAmlrFRc4gD1R
	wkaT7YR+Cbk1BAEiJO+uOItuzWJKkxGpqRfgqPvgaiUqEuKA6VtTwU/CU+GfgnpELh+B8w=
X-Google-Smtp-Source: AGHT+IFo20lh5Y3E61hV0VnnIgR/RLR4gBNddl0+XR01WWF8xQmrc2UwjGAnXB7q6fiGWr/LY0TKPeNtfPDA1u4rEpE=
X-Received: by 2002:a17:902:cf04:b0:267:99bf:6724 with SMTP id
 d9443c01a7336-28e9a61a8c0mr132924505ad.31.1759706227210; Sun, 05 Oct 2025
 16:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003184119.2526655-1-edumazet@google.com>
In-Reply-To: <20251003184119.2526655-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 5 Oct 2025 16:16:55 -0700
X-Gm-Features: AS18NWBbkHc1D2W-GvtGBKo2yWq6bGfUNmmlbZufB56Uoic-O6plmnDjTVgV3mQ
Message-ID: <CAAVpQUAcJZ76Q87zTSBuBTS733-h2jC0qNN5rh2F7hoaFaOMLA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: take care of zero tp->window_clamp in tcp_set_rcvlowat()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 11:41=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Some applications (like selftests/net/tcp_mmap.c) call SO_RCVLOWAT
> on their listener, before accept().
>
> This has an unfortunate effect on wscale selection in
> tcp_select_initial_window() during 3WHS.
>
> For instance, tcp_mmap was negotiating wscale 4, regardless
> of tcp_rmem[2] and sysctl_rmem_max.
>
> Do not change tp->window_clamp if it is zero
> or bigger than our computed value.
>
> Zero value is special, it allows tcp_select_initial_window()
> to enable autotuning.
>
> Note that SO_RCVLOWAT use on listener is probably not wise,
> because tp->scaling_ratio has a default value, possibly wrong.
>
> Fixes: d1361840f8c5 ("tcp: fix SO_RCVLOWAT and RCVBUF autotuning")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

