Return-Path: <netdev+bounces-57992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC0F814BFF
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 16:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109431F21D1C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D3937169;
	Fri, 15 Dec 2023 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUCNOhRg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A137163
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-552eaf800abso899a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 07:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702655020; x=1703259820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx3/YsZ+IWUjkas264EbDNziHfU5P+VY8sq6LNXKLsI=;
        b=SUCNOhRgC0iI28PJsvyFBAs+4ip5Lj60Pw4YsSz6Yq/k+dhZ1kIohk67yO5gIGMuXk
         PF2X1cn/BDeU1TFlyIXPYdSZIdM73E0tomjqrS0IKXb0sGsHcYrwO2B1pQl4zhGDYYPW
         khyB0ZSlII+zjBfWzVfp7bsNTaRGytLx1BqkNZ4Y+b5WzipMNRo/zp8lBuE3ASPb2ARg
         W//nMaCyQTkZWb2zyKUnXn4uOMrqFLrIUYKQTJ+e9bSzy12yzHHr0rXGIZwxvrGWzASD
         lo32QiGLKLO/fD1h4HqVAZ12li6Q7PP3uAGS6RnsfkrLtPdbwVcqr65xsHVAA498mGXm
         RRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702655020; x=1703259820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fx3/YsZ+IWUjkas264EbDNziHfU5P+VY8sq6LNXKLsI=;
        b=EgRLyygQhA00KjlJjGcf7fHGi0NCDZYtnGSY2GgHW/a8qRkPufPh4a4U6cva9nDhQe
         3c60ibb5EGydm3scR2HWrLX43Qo9vJ7Gpp2i12JAyHuG+GMxW4M8YI5/fEnqhW/31f+W
         FJAyYeKRvzSlIm95NibKTdhy7njAdhqweu9qmrnMuIfVb1UqzXHT4oeDoDwY4ifX3cAu
         TOPRsIkgWdItjL/S4okZac8w4cBic73KOyYFBpc/MHLjx/9HsKZFoUrMBDuQILm+LQ6w
         SwEazl+tw2NSVz2TLpiJz05iNB3Yx+MW+KQo8oJ5Iksb1YAzvDMekcuCV901I/1oTFi0
         oVFw==
X-Gm-Message-State: AOJu0YyK+ajsFkM2o0y44WYR7xOAmSjST189Z5Mjq8NJt7PgtIaAGnBE
	ZEhT0BiFWsjhhfd+XwxKESKMZWoyC9oPVhYlgprL8A==
X-Google-Smtp-Source: AGHT+IHr36DvHEz2+85x5LNLKCHnUoyFV1x/uPPYlL7w1fGwOWTD05+e+bHbErJVkFvTLK5jfDs20ZiXmHIMBKJeHX8=
X-Received: by 2002:a50:d097:0:b0:552:e6a0:cddb with SMTP id
 v23-20020a50d097000000b00552e6a0cddbmr20296edd.2.1702655019497; Fri, 15 Dec
 2023 07:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213082029.35149-1-kuniyu@amazon.com> <20231213082029.35149-4-kuniyu@amazon.com>
In-Reply-To: <20231213082029.35149-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Dec 2023 16:43:25 +0100
Message-ID: <CANn89iLz+D6NTnNcX0WdXkMx5=c2yr9q6AP3gS7XYzYKYqrCnQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/12] tcp: Save v4 address as v4-mapped-v6 in inet_bind2_bucket.v6_rcv_saddr.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 9:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> In bhash2, IPv4/IPv6 addresses are saved in two union members,
> which complicate address checks in inet_bind2_bucket_addr_match()
> and inet_bind2_bucket_match_addr_any() considering uninitialised
> memory and v4-mapped-v6 conflicts.
>
> Let's simplify that by saving IPv4 address as v4-mapped-v6 address
> and defining tb2.rcv_saddr as tb2.v6_rcv_saddr.s6_addr32[3].
>
> Then, we can compare v6 address as is, and after checking v4-mapped-v6,
> we can compare v4 address easily.  Also, we can remove tb2->family.
>
> Note these functions will be further refactored in the next patch.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>


Reviewed-by: Eric Dumazet <edumazet@google.com>

