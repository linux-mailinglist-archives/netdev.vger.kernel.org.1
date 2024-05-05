Return-Path: <netdev+bounces-93548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69118BC48A
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 00:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6CC1F217DE
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094AF13D53B;
	Sun,  5 May 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn9xj0go"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B113D525;
	Sun,  5 May 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948317; cv=none; b=k6CNHjUkUi0Kzn6v/O9+bqi87QYriyGqYG8nArf7uUh1/GN46X7m2h97E6pEAdIRSWgYHhIQNvtknCFP6+uaEboFSUYBqofAG16LUW0Fc1uTH4MKdEQcaPA7kC4eIxuQruq/5pm0zMYLD+t0fAy/M/D0fn3P8+A5Y+lumuZ4Y+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948317; c=relaxed/simple;
	bh=miIswo+Px3jcF/rLqpKXWfg/6SjGfJWWn7gEvILTj3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaBC/yXda124jpZeyU5kO3iN+xm2IIZng/btcaIAVKnH9SyoZ85bsfGzk1yeh+VJECWaXzsYsnrvQwUMy2F0HW0hyvfbDudGoklY+pwpP9Iqk7XGlOEH7BHx/WwUn5IP8MS0PSdeZA+iQJEh/z+vZHiDqGheWt3pZ3n8VLdRXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn9xj0go; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-618a2b12dbbso2536367a12.0;
        Sun, 05 May 2024 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714948316; x=1715553116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miIswo+Px3jcF/rLqpKXWfg/6SjGfJWWn7gEvILTj3M=;
        b=Yn9xj0goWxy2Rn0pBVREpdERsZucb5VNKMQVIaLhQZoeSA7vv9QEt4wYGQUrUnpcQU
         eiH+58ae3KmCppRjlsddeMw10OO4Pq23yleBqWutMmcNAeqgq5HurwJhCMppE+OwJd/y
         HuOa/bp2OF7+3QKVR6bLcJ4VPe++Qdj6VQCP2CGNlyY9RT2q98nv/RNzOwqh2boXzV+F
         ze1FkdZd5PO+/NE1gE2tu4iRxhS774YpAoA7rmry+YWH1uyUGYx8HXouzBRJAR+H8udo
         P64LOvobKD6jsMHHXWM7tK7OxjVSLrDFYTgypDBioCLCi6uuBct8wIOKg6QRMlBsN16v
         bOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714948316; x=1715553116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miIswo+Px3jcF/rLqpKXWfg/6SjGfJWWn7gEvILTj3M=;
        b=kFP2REjhRHgx+349aGiYueIfXAeBDBYs0wbLkNv9sMUrbRliFvGZdTk9OUMpi1Pj0R
         qtlKd30LFtmZTpohk39x8ANGxYMgIOx/f6NslGalUloH/xGTPBqde9NApDwcazVcFE2O
         3o5Y4pJgmTJi6s38iERYi2VLOTX+09nufVeRFPS1lF5JizSkyljt2eSiO6GFtMYjBRzG
         caZwTUmpr/Na/Enp98JoA0IPhU2XiMAff0VkQ6CaoNE+ZQ/VRso4apqI/pxDtaJrZjQ5
         jrKV17CL0yF6yR9QjdfZPNWQdF7ul1TU5qb3pslbh4QuRnACVvBL6xgnHlSYejZxr4iI
         GBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYEOoxzOdSBmNg9/nQuTODA/NRtqaZqR9NLXkz731Ypey+eUE4GJcwPl/0Z3ziuc42dQtQRftPXkX3vJBub7IjDxRvqnePUP/RUIumcUD+eP6JMIBrH4O6ayZzaJSRtn0R7u6fP6yvLWLTJYW+l9bS74ZZbHTogGzYhDF9xEgiIYEs/i0=
X-Gm-Message-State: AOJu0Yz8N2TF5dJUdoNGXpictKy/U/lwtQ4zOm2wGjEYvwg9qKMJj/sv
	epfasDU3O4VlfMSbzG/2Osv6mtnJUDo37iZw8Nmyx6nrdS8tkamU9MufFv776R0MVJ650z/NQNz
	KC+AadAcJHlWZd8oyadYKM4rFdec=
X-Google-Smtp-Source: AGHT+IGqrVHmi1+NqoSaPMHW0v/eHPpK4TMvupqBWSgZDgOyk03VkDp9z2/h7/RU5PpOOYSmdeNgQGqaJ+8N8h1/w5w=
X-Received: by 2002:a17:90a:68cb:b0:2b1:cf6a:848 with SMTP id
 q11-20020a17090a68cb00b002b1cf6a0848mr16558887pjj.7.1714948316045; Sun, 05
 May 2024 15:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411225331.274662-1-nells@linux.microsoft.com>
In-Reply-To: <20240411225331.274662-1-nells@linux.microsoft.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 May 2024 00:30:32 +0200
Message-ID: <CANiq72nXXgj9OsbFX2c4V2Df18Owphpv0DnoP8MCnAQV1AU=Uw@mail.gmail.com>
Subject: Re: [PATCH] rust: remove unneeded `kernel::prelude` imports from doctests
To: Nell Shamrell-Harrington <nells@linux.microsoft.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	fujita.tomonori@gmail.com, tmgross@umich.edu, yakoyoku@gmail.com, 
	kent.overstreet@gmail.com, matthew.brost@intel.com, kernel@valentinobst.de, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 12:53=E2=80=AFAM Nell Shamrell-Harrington
<nells@linux.microsoft.com> wrote:
>
> Rust doctests implicitly include `kernel::prelude::*`.
>
> Removes explicit `kernel::prelude` imports from doctests.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1064
> Signed-off-by: Nell Shamrell-Harrington <nells@linux.microsoft.com>

[ Add it back for `module_phy_driver`'s example since it is within a
`mod`, and thus it cannot be removed. - Miguel ]

Nell: please double-check the above is correct (I guess you didn't
enable net/phy and thus didn't notice since it didn't get compiled?).

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

