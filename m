Return-Path: <netdev+bounces-223385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052FCB58F2B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B81522E6B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467382E8E1C;
	Tue, 16 Sep 2025 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0Bk9t0E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9E2E8B84
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007859; cv=none; b=cqCglibpj6gL2Yql0X26TcdtOXHBnP2PqEjMwVpED3zNQ2RT2Iq814wzAdm7TU5ZLUtLdfjfghLIly/YTzo4312F7L8ZApi4VX+uiRV4OPCegZrHSyCBhtWm5FL8ZoOBoG7s17pfzAO21G4Ngy3lTMrfmJ14gj9GvHEm9NmyFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007859; c=relaxed/simple;
	bh=HNBZo6YmtOvoklO/9TNn2nUgKlp09Byr2dJuH6nrM6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nx48SM9BVW+tLq7kKFuzm1RGqRCRCUg1y81RvRlQa0xxkcTXYxXZJB3FO4jn7nW3OG87THVf4h78BAbH1oXeYQ1Ky+pdbzR4yy4icpI6d5wsHuDSLy8iRS1i4byf88IyYgb1wDrr2A0gdp3ADevc7n4lfSYCVw62fw3yiKatCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u0Bk9t0E; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b5d5b1bfa3so45781271cf.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758007856; x=1758612656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+KYYSsasADpLxsCi9t7AMiqgPbIRGaMguUdJ8zlhTk=;
        b=u0Bk9t0EeJEsYMoOAjIRlCcGIgiezX+h91THe+6nX9+AjoDap2H1MlkgONlI1mJ20U
         pw0xF/aHQdvqb1ARH3XfJBFNCUof/HGosXaMI21tKjkvno4vJQ+7pXsZbhOft30Lnw0e
         LtVKJ4iWQ6c008YXP8IsFKWzgvOXgSoX7jDJvd7ZamthpkKqgCIGdBNZmb7veT2C3GCQ
         qWr19CgDNTETs12b91qY5hzhUHlgoZDGDkxyf8OHv5E+Fxp+NwnHVLZzTHv3A3mTMsJj
         vj/Dg1qILTe1ZsaA4um+pfdSqDMaAWmLlVLnibbgWcpnkGCdhZiF2JzRXMVBrUNhT/VZ
         FN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758007856; x=1758612656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+KYYSsasADpLxsCi9t7AMiqgPbIRGaMguUdJ8zlhTk=;
        b=NcdhBktQUsxqBc0bq+Pv0qinnW1IwGsXoToYfJeanc4bwqBGa40tfEuOBPdD/McAwo
         o5HOm34iil1ADZ4/8xQ6mtQxF+ZIkSxuq/DabKaDOrmmS5RcBYW8GD43BYbSOiwW/5A8
         xyGNT/Q0JVAZCj7iY1oe6VwbGkpXMSj8m5tTjA5m+X1hxKbVFJ+sYBfZAe8a5RfMgnGM
         eGJuXhJDPQQjiUKDH/fUky6YD8ZuyCJFMzm+xAJnTmEAjVyTLyn6M+irEpAhyQ9uKxmO
         kGWFnzkS8EiNP00jEYopCdeNZ1ShtBZTQDRPM5N5IaG3e7u7eLg/Gq1ONrN7cxWrMZ4C
         Gv7A==
X-Forwarded-Encrypted: i=1; AJvYcCXIY14ms0/QcedU6XdMwyFpBl95ZN5PpRCsDlyY2hzMeoy/vC26xJtXTj06NYxTDhkv1uNcS8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLzFrI3gF1hj23Ig3DQz1NNUTvAiYeO73Uj/mhTN+1zAjx8pO
	BLEMXIl/AhDxBodv5KmQPuYUfjp2TMgUW2aaQmz+hwYFEDqT4Qpg4j1kOsYK1zZdbX6pAOp8U9t
	ePKE/rbpGrzHAtUn3m98X38J7aSjlDX9m9JoSo9Lb
X-Gm-Gg: ASbGncsXiC6HqcdQFe0DUQyV9JGvcRtkmiSYzDgxthmKQOvJljtYEbhlcuepJ7y62+b
	8HxtqqzufHEIh2KdJVedaEv0AI4itUeTjcmyAtOSql0gD2tt52P0BQJTsN9p6QRbcCC8pNrsLfp
	vtLPKSFqgVPXVT9UQgYgCA57fjAHqN/iTLICK8skvOinVRRzsscZuHmiD+ho55BzapmqJyzxIsI
	Oufz4o6Em5Of34uJKUfpXLO
X-Google-Smtp-Source: AGHT+IEELxqlTNuXChT+lpcimkJJDsX8mW+815tWWCNb8fL/iwJbIl86hrMCdWh/xiN97MN1s1Aon5sXyGjmCJpPmX4=
X-Received: by 2002:ac8:59c5:0:b0:4b4:8eb7:a45e with SMTP id
 d75a77b69052e-4b77cfd7c3bmr184461691cf.35.1758007856110; Tue, 16 Sep 2025
 00:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916064614.605075-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20250916064614.605075-1-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Sep 2025 00:30:45 -0700
X-Gm-Features: AS18NWBEu9CHVZddnyNNHIxHSzotBe8l2QeZa79QRVH5M-9yrw21laO7YOXggoE
Message-ID: <CANn89iLC6F3P6PcP4cKG9=f7+ymW1By1EyhFH+Q0V6V-xXn7jA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] net: Avoid ehash lookup races
To: xuanqiang.luo@linux.dev
Cc: kuniyu@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:47=E2=80=AFPM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> After replacing R/W locks with RCU in commit 3ab5aee7fe84 ("net: Convert
> TCP & DCCP hash tables to use RCU / hlist_nulls"), a race window emerged
> during the switch from reqsk/sk to sk/tw.
>
> Now that both timewait sock (tw) and full sock (sk) reside on the same
> ehash chain, it is appropriate to introduce hlist_nulls replace
> operations, to eliminate the race conditions caused by this window.
>
> ---
> Changes:
>   v2:
>     * Patch 1
>         * Use WRITE_ONCE() to initialize old->pprev.
>     * Patch 2&3
>         * Optimize sk hashed check. Thanks Kuni for pointing it out!
>
>   v1: https://lore.kernel.org/all/20250915070308.111816-1-xuanqiang.luo@l=
inux.dev/

Note : I think you sent an earlier version, you should have added a
link to the discussion,
and past feedback/suggestions.

Lack of credit is a bit annoying frankly.

I will take a look at your series, thanks.

>
> Xuanqiang Luo (3):
>   rculist: Add __hlist_nulls_replace_rcu() and
>     hlist_nulls_replace_init_rcu()
>   inet: Avoid ehash lookup race in inet_ehash_insert()
>   inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
>
>  include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++++++
>  include/net/sock.h            | 23 +++++++++++++
>  net/ipv4/inet_hashtables.c    |  4 ++-
>  net/ipv4/inet_timewait_sock.c | 15 ++++-----
>  4 files changed, 93 insertions(+), 10 deletions(-)
>
> --
> 2.25.1
>

