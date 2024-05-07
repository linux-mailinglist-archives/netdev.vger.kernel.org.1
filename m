Return-Path: <netdev+bounces-94244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8C8BEC18
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 21:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA8B244DF
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E416D9AF;
	Tue,  7 May 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LA0YijEL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197916D9CA
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108440; cv=none; b=DSN+mOiAPNMw1ohDvtsBnij8sLd4xwGNP4abRx+Jm3FoVrVoI8OcZB5gchTGMpGDGQ+HZ4v2U0rC/7/ApT8OFOAmhSJacDXsdvjh7ZB0m3hggs7CZ4j/81atmtxtkRGkOZFEFrzYFNR1RDbAlYEeKEzEri6K1oA2cU7nwFn7nZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108440; c=relaxed/simple;
	bh=7s3oPGkGLzvOuGWVPAZcFf2NPdjW/ND+O4YOkgFBmXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdzXJv/Jd5OY3QXW18wvKT03IMxXqxJjib23PS3IxOmcHrtUvgXuR41Aew5axj77NiVmk5hmABQtU6ExR/bfWNi6Bcet4hoHS0pBVhMWjQl02eKooyKksryJE7dixbgpooP45KjB3lGAKKkW5tWpwR3FkWerc+ylqQj1l8pjA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LA0YijEL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b4a7671abaso2371420a91.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715108431; x=1715713231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52/TiGb0pRp1cCi0WAvKTSl0Kx/3b9XgA1N/tzA4luI=;
        b=LA0YijELBhtbFqj+kYPDc723zkxRrJQ3jYMZ0vaTfNAwYtW6HXeuX4RFhLCzYOpEkQ
         785nJ1jvgpc+famATuw+rdHQIGH9byxrsSf1tZpq1u6G88HVqvyTuHbdjwXCOBGVru17
         1T+bXwloEsbhpsaKeVAYI0tLCUxkhoQuwpgy6Ix0Xx5qvBQWh/AGzfnu1seyJkVcLHkT
         sBV02UO974N1BVr/BqsESwQCLOizTJ/472GNVbbtQKbuuVnf0nRPmPZU7Kt+LhpNnpbz
         i504WgCmYZeN4tpe4oKWCWqrgU4mLmaCXleke1TW9ydjdViNTC+x+uWmCJzBAa9rPngj
         imrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715108431; x=1715713231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52/TiGb0pRp1cCi0WAvKTSl0Kx/3b9XgA1N/tzA4luI=;
        b=qR111bTxCx+iajJdFke01jj8jXdhFvBDaz/Fd1gNHm2Rd5cvnJSE4KLRpzOjPL3MUL
         hZwHE+5Fij2GpZ4ApzznpaNOZM6chNQcEeTqi3v+Y/4tMOADIjMHCokY9beINCr2KKnK
         YZuAsjrqwesRidhvEf4p64I40e5s8w0sM5hPB+nygRRRKuxXJ5x+0YQS+Ra74MWw22xa
         QxRAd1+XNMveZDf0Xgp3OL9QJ/O+Xa3OLfBJOKGlitLlEaYTPDr4WjPHzrqMZ26mGsd7
         7FtCh980PJWExv08YCxwVy+opwr33sFYqcqb4aHIA0US80HD1e9jhQVnuay6r2QZp9DQ
         8Mcg==
X-Forwarded-Encrypted: i=1; AJvYcCV+BumznuznKRPAD5b3XsVXEuzek9OB2ef0ZTlsWHZP0POMzrBQfRYkWHMs6uVAxXpHor0iIsw1I5Imo1Oza3mPnBJ0tewT
X-Gm-Message-State: AOJu0YyKSKgrzlTMVbAcrWnD92hE2NTiHunhyKKt3Zw/wOdQnZ2wkHWg
	AuNoITk/jNY3asn9o1tGE/6oFPcgd/lla7hM1QWIvlfZ+lomCnC8601+S57q1/8e03+mmHOZxo9
	k314oNIgGyUSq3DYU9Ywbsdz1WaxmoiPtpTgp
X-Google-Smtp-Source: AGHT+IFdufqWMf0KRyS6ONQjfkqedO80otF+5gAkHmdq5Jd6uIJPgZyn9Nvw+Eax/axJml6eRyADco7/lvarEj7yCXU=
X-Received: by 2002:a17:90b:4f46:b0:2a2:70f6:8f67 with SMTP id
 98e67ed59e1d1-2b6169e318cmr418365a91.30.1715108430851; Tue, 07 May 2024
 12:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
In-Reply-To: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
From: Shailend Chand <shailend@google.com>
Date: Tue, 7 May 2024 12:00:19 -0700
Message-ID: <CANLc=ata9H4ZTN92MhQ+P5bTBo9grE7sP1_JDk5MdzaCOhXOGQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] gve: Minor cleanups
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 1:31=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> Hi,
>
> This short patchset provides two minor cleanups for the gve driver.
>
> These were found by tooling as mentioned in each patch,
> and otherwise by inspection.
>
> No change in run time behaviour is intended.
> Each patch is compile tested only.
>
> ---
> Simon Horman (2):
>       gve: Avoid unnecessary use of comma operator
>       gve: Use ethtool_sprintf/puts() to fill stats strings

Reviewed-by: Shailend Chand <shailend@google.com>
Thanks!

>
>  drivers/net/ethernet/google/gve/gve_adminq.c  |  4 +--
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 42 +++++++++++----------=
------
>  2 files changed, 19 insertions(+), 27 deletions(-)
>
> base-commit: 5829614a7b3b2cc9820efb2d29a205c00d748fcf
>

