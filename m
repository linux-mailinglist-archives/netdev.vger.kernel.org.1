Return-Path: <netdev+bounces-169816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A4A45CDC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF8B1881903
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0962AF1E;
	Wed, 26 Feb 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2//44Tq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF62258CD9
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568528; cv=none; b=uEKmaCfG7HAJSoyHuaN9kjiT+6XErun+lforXsvUWBCxnJAJf3pL19yxezxAtqnmwE4la+cwr9+2g7wgXq/eub7IE8jeReYvG2gsQYlJ87XgmFywkECgbzaUtwpH8nvBrfQaMp39WDnrF4wA4HjgQ0kByG+2AVFeNLrw9ez0IYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568528; c=relaxed/simple;
	bh=zNrAcvWyHieDwvp8WQnScl8drC28/08XB6vFqx+fCHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/8EtmQIQQMwJ7CIoH8H1RXaZAaC/qU/XyHjRaLYGuSXJrjYFunm39LexAfgCBj8UypP60VLeFNBw/lT9iJnsYOPrZYCwZfg6/3ofBqMfjwEIGrMwikNOc7ldDFbCo/1SHD9sXvDDjJk8EsQs2BLl6y84HGVsutTpt1lR0mBCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2//44Tq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so10646492a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740568525; x=1741173325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNrAcvWyHieDwvp8WQnScl8drC28/08XB6vFqx+fCHA=;
        b=H2//44TqOCL2pQGMxJHiYfhmLi/j+wiVGQc244aX/Ctdh777oCaYurF9EtqM9P+jdC
         ciUwLA9f0ITwoOF2TkisdRzqCyEie3cp5odnrFUxl0YlOoa+PysWYY+7IikGlvopT5ln
         a54IhNnz3BGjDkefpmnh4GOdWlPEITGpc3qeCRZ36O/zNY7DRwkike49evxL1gcww4pG
         P6yoFHvkXb8/IX8VKeEPXeG+d+H2zOnR2huto1Qv8S4O36IIG7Ig8nJpfnhs9qA77ZaV
         AV+5yTbZbr0kE4i/ghFwlsLAtZEHlnjCmeXHBey2C1NRY/920VdZ3ggFW6roHp990hZx
         Sc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740568525; x=1741173325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNrAcvWyHieDwvp8WQnScl8drC28/08XB6vFqx+fCHA=;
        b=AmZfTbHYBjSKDpUvInTFniER9y4QT8EZiOzttbP9MQNyTarETfJDaZ65qGzayXuVFg
         ecAzCRcycKYTibujYnZpWgg2eXW9QYGy/rDvrN20JAwRDLkCdPxOYIKzQP/DbZBsRc98
         YOSXqUr8jUuB63ftwosLq5OUoZqGUfT7frDFpfrBg4Op4GxHu2ssPSGAd7qMTeS90ur+
         CVIyKXSIh4WYWQOs8FpaisYwV7dmqILtPuR5PQUD7QCbq31CbQVxBQtEt3EdCbOyitjQ
         ssT7Hp8TeLVxLtMqqvG8K9KJ7IKp+1ZeF61LuLb6q5HEYdZ5CKiv1Qd3ZuH9eMUuHhZA
         9S2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSt++uuzBEXmspGbp2CQHBcp2Y5zIAM4b3rEZQaGrcY3cUfivW0DPyilVKt8sFMDeFe/IatfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQfxePUwuVijXkdvMv6PH2gcaqOLu5TLWX9MYAWlnm36+A1GW
	337/TeQHa9kamZg+UVWcEq6RU60S4wWjGPYpypL17/gQEb3jHGDa5yWWJtHAXFnAOhbwJLwjZC9
	vzErths9y6lX+BH3hA4od/FOOqaU4SFDv+3XI
X-Gm-Gg: ASbGncvvzjWMtlSHZ7/fIj/w7qet9Lp6WIboAhMCG0bvqlbXIy2kzzyxhqESHrnb9up
	uHVQGRYJMMS4W3coLR3uEMAvXb0OhPvqjOtfl6L4rsiu4bN30aP8kfM0UWhCPWq8EwFn3WgJ0PB
	mZIrkJeyQ=
X-Google-Smtp-Source: AGHT+IG0Nay6lOTu8YjeaKHOsRla4wo1jUONCLZAii4IBRMximwWLtAPl0nMKc/g5trILMjDrUD5sXiYny9sZiQi8Ig=
X-Received: by 2002:a05:6402:2115:b0:5e0:82a0:50d9 with SMTP id
 4fb4d7f45d1cf-5e44a254530mr7403166a12.25.1740568524741; Wed, 26 Feb 2025
 03:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-6-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-6-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 12:15:13 +0100
X-Gm-Features: AQ5f1JoXmfk2PVeEiSJ0byDt8Yxtt0-3tbMhIMYqG5F8WDJiPLsST_SelYhTH5c
Message-ID: <CANn89i+i+RVHoOa8C_-6GX94Jwmth1jceVDh_uHgKVRJBCTPWA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 05/12] ipv4: fib: Remove fib_info_laddrhash pointer.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:25=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will allocate the fib_info hash tables per netns.
>
> There are 5 global variables for fib_info hash tables:
> fib_info_hash, fib_info_laddrhash, fib_info_hash_size,
> fib_info_hash_bits, fib_info_cnt.
>
> However, fib_info_laddrhash and fib_info_hash_size can be
> easily calculated from fib_info_hash and fib_info_hash_bits.
>
> Let's remove the fib_info_laddrhash pointer and instead use
> fib_info_hash + (1 << fib_info_hash_bits).
>
> While at it, fib_info_laddrhash_bucket() is moved near other
> hash-table-specific functions.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

