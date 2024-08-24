Return-Path: <netdev+bounces-121623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5FD95DBF6
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 07:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0311B23E46
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 05:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F8814BF89;
	Sat, 24 Aug 2024 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="SclNRj7v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417DC14D6EE
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724478304; cv=none; b=QtllUL4eoz5NFfOowMLUH8ZvzzdS1nLjXOHmDvrW39ib2qRrwg2rLqpPtxCzYRb9GG68yxNF+t+gPa86kHEdxTC/SOlt/cfDWbqwJ54Jeu3ekxGkxZP2IQCtI8GCFmG4n0eLFi20iTMM5uNf/TaBN9/AY/OrDKv3jJt+dMWm+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724478304; c=relaxed/simple;
	bh=/qKLJ76IUNLPddIr8VugAy3y7N77IqZe6iOeGbTRu9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQOrTOAU44CA9ANO/Bjis8Q6tbxrm+Ub0UVIQ19S31AfwtYaVXRWNw5sznF/bzVcwASdHO0QLl1Butqk91Cdy30WEPBtX1jmlCiKgdapQSNO1UAkckTkBKhkvSlVqnmfFKybXZng7F1MBqA1FUx9oRmuqnJFFi9VPKA/LSHvRFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=SclNRj7v; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-699ac6dbf24so26235237b3.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 22:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724478301; x=1725083101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDfaHiUZUvqLbJKDCnwo4tv7jJFrBMb1nh7MzHWt+F0=;
        b=SclNRj7veocrWP9J+cwS0j8wsL1ioQrrtp1iJDmUmb+/TxsWLzOmrxIPIoQ84QRh9P
         I98sybB0Dk0fu2V/dMxkPMlScAT9eFXdtbV0lGoSZQutDyKsAXzLeGYovMI6GKp6bfQt
         Ifkj1Awmtg5ZFvz8NMgtds6xA11WKc4R6xFP9z9OdiRynudsaEU0apFkHie2W+zzpWW+
         /4+5Q+hQFyuJiebD4B3xZM0PIy3sQbvVnEcBCDxlnXfaRUiwSUV1Foz6M2ruiAtJpVjT
         7dwmzWhNcCwUiBKcjuiSoyjoWtAAv4aI8Vr4KWtGMfRXhn6DaDEy7IeN+l54M3BaI4nC
         UP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724478301; x=1725083101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDfaHiUZUvqLbJKDCnwo4tv7jJFrBMb1nh7MzHWt+F0=;
        b=YJ0MnYFn6G3GVgRAQtHP3M1C4FxQ6HCPn8tAmL49x7S0IxQVADP5vSoc40frZd6imA
         Ua+twimc1vXH8QrIE3aAJk9hMBKw4UgE7QgNjUGwtMaUchNZm9J6/lmMsjsSKxX/kogD
         UUsaIVgLr583FsK6Bp8zPdF6zvvA6v+AKaNr0tbn6dBzlv3RtOxla9S9ecpDgGxRfx8q
         CZX6lbnu3XkcDfQ3afzkmpyb0oMtCkVvVu8PtFiQKIis2ZXgn0feAJN5KaoVPcEyEPZk
         bABgcYas1/RpCCyI/kCSwDZnjdXN7nXMbbCV8JXRszUFn5ot5MAut4tFM6pasI99MY7j
         3FHw==
X-Gm-Message-State: AOJu0YxUeCTsxvlS/t87nwsmnj9BvS4XpKBAC2HVffafE75Ops+IcZu6
	NUP/jyZcm1Q6ysyqWiHFDhEI1ttGu7EN3kaCsFxNXaje3y7fSeKSnayUoHByuYLXoGLvCsF5QjB
	jmGT2pctKJWKbm3wmJVPBcTxNzTUQxmj6I37qMQ==
X-Google-Smtp-Source: AGHT+IHUaLBDk3NILb2neGV/Pvcr7b8KOMb6mjvnbgHK6xZKxU2D5bgqzHhVQhCG/Pq5DLKXDEbOkqbJEVF1VD3yO2g=
X-Received: by 2002:a05:690c:3248:b0:62d:45:4098 with SMTP id
 00721157ae682-6c626109a39mr45246777b3.26.1724478301248; Fri, 23 Aug 2024
 22:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824020617.113828-1-fujita.tomonori@gmail.com> <20240824020617.113828-5-fujita.tomonori@gmail.com>
In-Reply-To: <20240824020617.113828-5-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 24 Aug 2024 00:44:50 -0500
Message-ID: <CALNs47uSeGR_Z_Bor4yKbd848XdohHMam47zwBct39nEmKFb7g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/6] rust: net::phy unified read/write API for
 C22 and C45 registers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:08=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:

> +/// A single MDIO clause 22 register address (5 bits).
> +#[derive(Copy, Clone)]
> +pub struct C22(u8);
>
> [...]
> +/// A single MDIO clause 45 register device and address.
> +#[derive(Copy, Clone)]
> +pub struct Mmd(u8);
>
> [...]
> +pub struct C45 {
> +    devad: Mmd,
> +    regnum: u16,
> +}

Small suggestion: I think these could all be `#[derive(Clone, Copy,
Debug)]` so they are easy to `pr_info!(...)`. C45 doesn't have any
derives.

This could probably be done when it is picked up if there isn't another ver=
sion.

- Trevor

