Return-Path: <netdev+bounces-223365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C470EB58E09
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED152A27B7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 05:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678782DF149;
	Tue, 16 Sep 2025 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3Rc5ZBE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B42DF125
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001560; cv=none; b=bNilgHv8jK6N1Ajm3aGcLbKWUstppL9cfz2yu2fwGWSNZKqTZXXAqHLfyAgJCE8USomRkEE70xpGto666ayxgxIyMwSlYah6bOzowghUtzkUPbAlk+qR9HQ8RwjM1F/m1CZR1N5atJAXaVT/T2dWcjuaOB34gOUGmWk4b7Zq7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001560; c=relaxed/simple;
	bh=A13MkdRWtYEoGnVQtmR4Rh4OuvVy1425Eajd//TFG4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfdD9q6UqEsOUy60aNBrPYFscqslaxga/kKPZlxvKDCb25gEp4PQlqwVNjgJ0kQ59ggxrR7tKLMO8WXiAP3ke94aX6Q0m9W+wfTEL+tqzEtDK+e/Gz2ul9PxzrJhzZzjr7t1Wwpon8ZKMKiQHfU+7KA0CYfLSPJtFdzJbkOXEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3Rc5ZBE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2570bf6058aso66061925ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758001558; x=1758606358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A13MkdRWtYEoGnVQtmR4Rh4OuvVy1425Eajd//TFG4E=;
        b=B3Rc5ZBE5pC9eI/nHkU4JMcyoLtwLvkAgbwMbaI+3FfE3MJIDZoQx+zQN8Ptg2I5Rc
         B30JPyhsfZYrCsW4Zpe67ly8iYZBfxTwKqGnW9dhSIX3A2z8Z/VE6py30X+w7E4m0BGg
         ZRvZ1GUFrLUx3FqWAT5bNAk5BKLprJdjQM4G+AO4MMe2USANgDKLngqEwgFaJyAZ4VD2
         KKLcnHK8sDNcdmNGRnO/+gOJ9mhRIpvd44o6MTIwLpStnEeopXuU5kDa+Lz3vfBI8Cdv
         KNjn6HLcL7pxzLxDjYMXJyxTHzDtaZVymYzV/9Q1c7lxRsZuP9nzZxZPnC8LfZQsuxu3
         elqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001558; x=1758606358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A13MkdRWtYEoGnVQtmR4Rh4OuvVy1425Eajd//TFG4E=;
        b=DTjmQkllJWSaGhhZYNWklgy1vAnvUpLdJUwMPIfqpp3clHTzLzl92+BGJEbIdMNc1Y
         tykrv+8td9QwuURs+v06e7jb2vuiL3X9PE42FdvRfS/dji4EAEhBfjZHgJVNToiPtEne
         1zrpA8hq6A2IsxI4eLMvIE7fzFB+kdqxQS5I/Wnue+FONu8+q/gLgfKje4WSLWp00EF3
         LRAanOCrate6tLcBWQtz4k8VvPXwX7CFbr8mzFnf5ZReGnjc+W8UXSeFCuNi8Cger2iz
         yZPY7MjEitrvddl4T2c/JLAAV88JKu652roqDR/5lYxIP0pEJd7tLKUdh9jRq+un69L3
         HEaw==
X-Gm-Message-State: AOJu0YwaeI65uTKkG3Dp0W17FskuKWvsH9/AxjHh7+epQMiasSWVy+Pe
	Jbg8hwEICkEPZ5rdlbbFZ64IBx5s1u8Mhw+42hiimojzJt7oodXH4fcZP+ETtImjyYXkrRg5o87
	/iKO8FUt971N3OtyXPj2FqczajCSrVYb/0l0atdQN
X-Gm-Gg: ASbGncsjyAUmFDb0fgx+/heESFjHrSd64sE99Z4XqCYuZPlZwY0la726+QPKHRI+iQf
	Z7vXorT8885AwuTlRWKefmVLpW3Ffn7TDgZYGUBAx/sd2RrAGSbKkjmrS0NrDLU4lraZNY9rePH
	XR1RgxD/OyhWz/jvXwdXSU9QU2Ybvysvcj/QMt7XfeX16GA9+gWig9HTb0kRo88YRJmAbcJ0rjx
	nCX1uXEzfVKguwYrQrKwLTYIgJ4GD2lRGlv2N7xIztSVBE40Pzt5C6cQw==
X-Google-Smtp-Source: AGHT+IHY5w3Oc3NFOJMOi8eRlyuHJUpeK0esdxyvf7SakcPihGOVGm4QvA4sKPnrtOoJ+M7i/HFV6YntdozcvUJmUWU=
X-Received: by 2002:a17:902:ebc5:b0:240:a889:554d with SMTP id
 d9443c01a7336-25d26a5ac8emr186490495ad.45.1758001557993; Mon, 15 Sep 2025
 22:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com>
 <20250913-update-bind-bucket-state-on-unhash-v4-1-33a567594df7@cloudflare.com>
In-Reply-To: <20250913-update-bind-bucket-state-on-unhash-v4-1-33a567594df7@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 15 Sep 2025 22:45:46 -0700
X-Gm-Features: Ac12FXy3FrCKhwYNn7AA2ebaq3APOssLKI1yVfAo1Kze7nSIT980kRvBZQhdtgM
Message-ID: <CAAVpQUCiH6pE9zG_iEfFGNrXW=+A3rLT-JLe0AaBqpu0Q43Pew@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] tcp: Update bind bucket state on port release
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
	Lee Valentine <lvalentine@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 3:09=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Today, once an inet_bind_bucket enters a state where fastreuse >=3D 0 or
> fastreuseport >=3D 0 after a socket is explicitly bound to a port, it rem=
ains
> in that state until all sockets are removed and the bucket is destroyed.
>
> In this state, the bucket is skipped during ephemeral port selection in
> connect(). For applications using a reduced ephemeral port
> range (IP_LOCAL_PORT_RANGE socket option), this can cause faster port
> exhaustion since blocked buckets are excluded from reuse.
>
> The reason the bucket state isn't updated on port release is unclear.
> Possibly a performance trade-off to avoid scanning bucket owners, or just
> an oversight.
>
> Fix it by recalculating the bucket state when a socket releases a port. T=
o
> limit overhead, each inet_bind2_bucket stores its own (fastreuse,
> fastreuseport) state. On port release, only the relevant port-addr bucket
> is scanned, and the overall state is derived from these.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

