Return-Path: <netdev+bounces-84580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE7D8978A4
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735EDB3E0D0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07131552E9;
	Wed,  3 Apr 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAMX5IPM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5D14E2F9
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166969; cv=none; b=fTlUQzWoQP/NJCCSwE2x86T7EBsM3rY5JHiiUYPrAkh+aro8VwfE9vKmw/8ieD//h4l452pLAemotEH+6d3n7jO8mT8G3OW5orJboIBCytNsCu5Sd94AaHaT/CUoVLVLXdvmiL665aBAPONK7A6rnstwB6SYoGGlGJvOwSqHIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166969; c=relaxed/simple;
	bh=ObkVdJwv08ivHFCrYweextytvPQ0aeTOy2nxjLDjHmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1XzzcrltfxKLll6Rw6zk0hs9f3z/3YgmUAvZJAwrXtdj/pZ7yzXskza+lyNz0X91NPR2A9//khPC4STBEpy6aEXkcjwz4fgN9dIBpCyJuj37VHrkWL6EiU50Xr/HwyVC1xURg8ic1lKLcyrAQHCD1blX/Ebx4eE08LhGcodf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PAMX5IPM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so1460a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712166966; x=1712771766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11xHFtwF7q3QiLeNEMN61tjdixRYKBFWfF9ZOhPQfUs=;
        b=PAMX5IPMcmHxciRkgEOFQw5qs0v/hpsytIhJO2k0hhPdyZ+KLkI8mwvz2OQJhWa/IM
         UjbC8PMhrVknH1eBSrZspFDA4Ej+gPRN7ay+rPvllHUo0i49SGiop1GbNWwc329B/UNp
         Uu0XXIsQ2M7Xg8pf5bfHUoZsibFI1KF++H8aaMnXpYN0bLJZAAoBTbi+/9XL8nzcFsvk
         DBZuekRiIeztRwSVggI2PWiCuwI9gRoKYgFSUHep6lHt31Owvs5evMVBHripxhcb9aOi
         ZqMF5KhHpAAQVZyJSeYZA12ASCZg9lrLtRuCbEGUkVNlx2u8Fd4kYLxrcxC6kGt24J8f
         bKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712166966; x=1712771766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11xHFtwF7q3QiLeNEMN61tjdixRYKBFWfF9ZOhPQfUs=;
        b=cTf8jOeM8DtGE93mF+Rc14vuFyFdBKPHNyCtZoYA+Fn7f+TvpS+ITSbiRWEtKcinBy
         TB8I9NSrT3z8r10YAS1CR9T8G7oU+HoMW5aaivQ0XOy7qyiWu/UVxzVUDEB+W9OubGVk
         D59kWdBROGmWiukq74/hnCs5bmw1jOjugfSQC/e/GmRFda3Fk5gJ16UQ9cxwuDO5I0Ai
         xnT7B/PqkHpc2HlJSXHab3ONfBCJavfJ93afnJlEf2nv5MVLRzqvOH33RVYU5l38mOkt
         HLUq98aitDpFgFO1pVtCehP7P+Xi/wYi7TSBIb+l1uZ5YL8DwSmwuKWf2iNpGvKwhsJP
         WPeg==
X-Forwarded-Encrypted: i=1; AJvYcCUt5U8RLgZmQXyg9t/ID1Lh7nHIM/nHTGNTDl7ykxxE1Lgq+QdImQMJvtRAlUckNVUs4mrIggpRRN6MTqyrbmygCpObCk8U
X-Gm-Message-State: AOJu0Yw4JpHAspuoqN+XtZsolrdpTwLqYO6s3qwDF4WM8288fmYzy3hV
	qnPJC3kvKi7xrICjo0n8ojhzMNfEojuOAeAAZG3xcImJ8BXQVjL9zoEp3L62uIXT7YOQMeSqx9A
	f0rl+YkJ3nmaCoAf0dwKsG52RUmA7GX33szPl
X-Google-Smtp-Source: AGHT+IG77LqOz1rKLl1usZ0hkZJBuy0HNLyyG0Tl2Mu7s9l3L9PapmOi7p1Xzkwxh6hZU77AQmWbrlFY6VZiU2+Fh0c=
X-Received: by 2002:a05:6402:3591:b0:56c:5230:de80 with SMTP id
 y17-20020a056402359100b0056c5230de80mr336611edc.2.1712166965977; Wed, 03 Apr
 2024 10:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403123913.4173904-1-edumazet@google.com> <67f5cb70-14a4-4455-8372-f039da2f15c2@kernel.org>
 <CANn89iLQuN43FFHvSgLLY+2b-Yu2Uhy13tmrY_Q-8zX7zUcPkg@mail.gmail.com> <64ba0629-6481-41d2-ad99-38d296e93206@kernel.org>
In-Reply-To: <64ba0629-6481-41d2-ad99-38d296e93206@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 19:55:51 +0200
Message-ID: <CANn89iKsJdDgoVbukfDObR=qSQ5T_93zV7-1C+BBWb_-ks=+xA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: remove RTNL protection from ip6addrlbl_dump()
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 7:49=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:

> Since this a known change in behavior (however slight), it would be best
> to add something in the commit message or a code comment so if someone
> hits a problem and does a git bisect the problem and solution are clear.

Ok.

The cb->seq  / nl_dump_check_consistent() protocol could be implemented lat=
er,
if necessary.

