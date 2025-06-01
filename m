Return-Path: <netdev+bounces-194534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC0ACA054
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 21:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3AA3B348E
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863515666D;
	Sun,  1 Jun 2025 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x877uQBK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560C383
	for <netdev@vger.kernel.org>; Sun,  1 Jun 2025 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748807371; cv=none; b=BlFQ+qRbzwo1VgoW1PsRgSwdTaWe1rJ6VFjasy8AvEayivYXOuX4fCvFRqGT+OcP1EtQzLXqJjQsv6bF5nAwoTadD6uCN8dBiOiUVI5Z9JmbaReLVkAOqCKYsXFMiyUsbJDOTLluEGg2w4cDR9uHMP+b/ANVJIfSoPOIiWeSIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748807371; c=relaxed/simple;
	bh=OA6gnjPmGrHTq6uMjAd4+9GuNtdx+SupMKZyX9oyrQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiFv/0oc/x7R7lg5dZW8k8jQDMPDztvAMzHQuhWWopRgDPYAPmh91PFHUi3xhZM79Mq4Zp8D/MAN0ywkS+dSjUSkjBXbm0f84y1FB1V1WJZjQKZcL5KmKjrtT5vETtYG7EexlYIb3LAqU7I25mYNP4S8ln6Ywu4qIo+82bR2MB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x877uQBK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2348a45fc73so215205ad.0
        for <netdev@vger.kernel.org>; Sun, 01 Jun 2025 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748807369; x=1749412169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA6gnjPmGrHTq6uMjAd4+9GuNtdx+SupMKZyX9oyrQU=;
        b=x877uQBKt6Z89z/I7xaEt0rKdGbBrlP7i9Ge8lnBJpz/pmxxoSmKjMz0mOZOd77Tfu
         dtg9McayivDTDhygj/57mB6WregKQsdTYPGTn0zlcuOuPMjwWqd6q8pSVsUq3mFcXEwo
         7Pkw1M1ls2XK2OHAjoF0qp/IzCBOIraFjklF/azMmjy0GE7uVO84B3gvZPmGyKfnmlk5
         KiGj7rC7jX76AZXg+8j7EIJg3RJjTYVIN9RBmjACJtJX0Y5TgskkfrjSHTDMkSqzKgPr
         k3wN8xw7PKrjdq2vF0nh+IiiJWDtYMs9kvHkSydf+WXUDz6v2inpXXhir02SN88cn4of
         yK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748807369; x=1749412169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA6gnjPmGrHTq6uMjAd4+9GuNtdx+SupMKZyX9oyrQU=;
        b=bTIUCZBjM9oEMKquf1hq8YP41UZTvDRMQ6pbnoJwO47KUWNShvdzsDEobKLVuW97/X
         NavSqVJ4sWRjjVCmifF8i9kL2Blkw8aRlti/NQ+1CJum19iDKiHQ15ERKGujxMP1pu4J
         RC39mrcy1Crc3KhbYb4oykzczyjZ4KldfjGbuFni4w71ztXeRHBa7ayQsKuPF7G6Fz7S
         mRHC9+CUoiKW5E1beVerdCcWWc+vnN1htMeGfRxD+g9/o2/5hY2DoJFAQlCvMZeSeS/4
         iFubnwZjQHMJ/2jTBE1qAlUSH9bFst1/3uHpMz5vaQZ8woSM5DIuZixna3m5lWrzl2WI
         3vUw==
X-Forwarded-Encrypted: i=1; AJvYcCUjWX5oUcbkZZd5zxdvFrc4NI4rAJs376o9Oj5+LZw2oB95UW+VefEls4pIJvReGvm/YVaEErI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKO8wpydHBegKV95fLQDlIDmcdk0BCU6hwEZCsGBM2C/YokLPN
	mFQUfmJsdKD83j98u1RXbC2sKYjK9uIArzaLZq9/iHeE9e5aUxcx6fJAYs+IhtfGt6NqIMeR/q9
	8Jrr0DkaDQG/Y5fUO463yAP743tI6RPNC/8RGphWC
X-Gm-Gg: ASbGnctvpshJvZ5GEUcOLizkaLufL+A31CDWSBMo+zl9szY3+jBZ0ZtBBU1aTuNQxxX
	aOFAwJ8IXCtUIGtLGlYKSEWvxSI/gqAbD/GZlbIyGyQGFOa3oGmfsOwQ9EIe3zVwNL/xo0ItZmk
	ffCh4GeBOjLTpWdFcdG7A2LBiK2QxxgEgD33XpxFmeEzza
X-Google-Smtp-Source: AGHT+IGuKYuACePHASwBc1caQn32lBjaqHshQBYH/h8PHU3WssUdv4MSjw2rLAjB+qZQfYRgGCCIAw3qrXEIS+kGKHg=
X-Received: by 2002:a17:902:f651:b0:234:a734:4ab9 with SMTP id
 d9443c01a7336-235568f2761mr2930795ad.20.1748807369084; Sun, 01 Jun 2025
 12:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601193428.3388418-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250601193428.3388418-1-alok.a.tiwari@oracle.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 1 Jun 2025 12:49:15 -0700
X-Gm-Features: AX0GCFsq2stzgpUbglrlQlKkYoMupX3j2X7PTQqh_PILem3fYMMDPTQUNWueH7k
Message-ID: <CAHS8izOqWWdsEheAFSwOtzPM98ZudP7gKZMECWUhcU1NCLnwHA@mail.gmail.com>
Subject: Re: [PATCH] gve: add missing NULL check for gve_alloc_pending_packet()
 in TX DQO
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: bcf@google.com, joshwash@google.com, willemb@google.com, 
	pkaligineedi@google.com, pabeni@redhat.com, kuba@kernel.org, 
	jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, darren.kenny@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 12:34=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> gve_alloc_pending_packet() can return NULL, but gve_tx_add_skb_dqo()
> did not check for this case before dereferencing the returned pointer.
>
> Add a missing NULL check to prevent a potential NULL pointer
> dereference when allocation fails.
>
> This improves robustness in low-memory scenarios.
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Patch itself looks good to me, but if you can, please designate it to
the net tree by prefixing the patch with `[PATCH net v2]` as mentioned
in our docs:

https://docs.kernel.org/process/maintainer-netdev.html

Also, if possible, add `Fixes: commit a57e5de476be ("gve: DQO: Add TX
path")` to give it a chance to get picked up by stable trees.

With that:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

