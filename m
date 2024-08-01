Return-Path: <netdev+bounces-115112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16981945332
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4755D1C21338
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A7C13D62C;
	Thu,  1 Aug 2024 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ1iTyd4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7666132139
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539810; cv=none; b=ruAnl8yTa5+aahWiH/RhdSlTnMRZ7A680HSKMKZRn2SYwCK1W94Eanjf3E/dULny13TF7FBLQqerc51xIEGMqrv0LMLSkP6hS7Vc2ZOBybKhb7eiehR8YOHvdw1Cy1S1BbgBd0Ih8rp3UmK+TPW8b3s8quWjlOQIKrqx7dKV1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539810; c=relaxed/simple;
	bh=fF/e0fzB0/RX4r3Vl5vU0VsI/z92YsSzj63YwfXyNug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VI9dkcK91EmlfrZVe0c2OantzNZl+EnWR4SgXvd/46y1gWoEaKlloqoPal249PezYkUKgQ+1DKn4Qv7JOoSvro0TLf0AKtdYjJO7f8THIA8+xenzUp3cO1380pOjsOaS9vNx3J2hsZNrFlB4zMZZHIfgBiQuOc/5Omo8Hj6PB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ1iTyd4; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso5610736276.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722539808; x=1723144608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF/e0fzB0/RX4r3Vl5vU0VsI/z92YsSzj63YwfXyNug=;
        b=lZ1iTyd4selDSVjnhSxQZE3+HvE4bfcIAncCgvMC7haz30GzOmT3lvnQLu03GjqdbV
         ca4X5HKw8rNGqBIvY0/mINDdnG8N3JGfVSE5z7SpR+tC+V/ayxwOQidBkUzW/79aEvfB
         fR98AyKW1NTonupolSnwMAGiRiN0ljUOE3baNLabjX434w+T2Iqw73ru59HOFs+A+QQS
         ZSxeDKmX7x6rjXnquJgM8zx7D5EAJkqYvZ4swyQFh7IAAa8i22crP+GIyhJXYoG+8d6B
         NPV4C5qP4/v2JA6bo940Lv8wcv7L9p70ryd1+3N5tCk1i0/5VMqgZyajDkOMhoyxFaV4
         jbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722539808; x=1723144608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fF/e0fzB0/RX4r3Vl5vU0VsI/z92YsSzj63YwfXyNug=;
        b=oAX6d8Q6DQrB974mDWjXaHqqdmMwLqvCBTVePw+1sP19Nmovneo27thIUpHz1wEpee
         6enX4R3Op3idcke3NKg7OnXxieHt8JSoQVRdxUxH2Og3Kh9r8LWKaVoLY4wrktBmK3LF
         Jn9ejEOfmJpuwmCJUQyYDF/uOsE28luhuJyKY0pMUvRNL96kCp8SlHoKf/z/hRRlKzfk
         4wNJKyle8PGJRynIx8rXJwE1/TeErFazAjFk/vUSR9HdocVgxEIdMVYn3aG1OhCPcnhh
         ABHbIiiLPyXO5NOW8KLwvR3P/IYhznuxr+ppk90QHPti7n4XUcMUcKXF9XVbMsMBSvUN
         B5+g==
X-Gm-Message-State: AOJu0YzKqKvtgVN6tUcALACnWdURIGC5a6JyQSRv4cVEFpAVz3bXvGDV
	rUVQlIWlDk/C8AqDOsQfiNS80oGZqIztQtExVU5LjStAYhXx6At8FZbaasxFY+fEMGT6xt5B9qy
	eh9E6zRfpm2grXMNiQsdbOFc+yLM=
X-Google-Smtp-Source: AGHT+IGjhSvk/Dvw6Df26mOK5yQgBXmMzhGsdOZRp48b42lC92cFdHQRvD482wDoz1r+0q8W7i6Dnc3csPIG1fq4t6o=
X-Received: by 2002:a25:7450:0:b0:e0b:c002:a982 with SMTP id
 3f1490d57ef6-e0bde4daf6cmr1039988276.55.1722539807802; Thu, 01 Aug 2024
 12:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
 <20240801-udp-gso-egress-from-tunnel-v2-2-9a2af2f15d8d@cloudflare.com>
In-Reply-To: <20240801-udp-gso-egress-from-tunnel-v2-2-9a2af2f15d8d@cloudflare.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 1 Aug 2024 15:16:11 -0400
Message-ID: <CAF=yD-LEYKrZanKb3be=W6K46K9HhdaQxvc8pmtCGVWxJ3x+Vw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests/net: Add coverage for UDP GSO with
 IPv6 extension headers
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 9:54=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> After enabling UDP GSO for devices not offering checksum offload, we have
> hit a regression where a bad offload warning can be triggered when sendin=
g
> a datagram with IPv6 extension headers.
>
> Extend the UDP GSO IPv6 tests to cover this scenario.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for adding a regression test case!

