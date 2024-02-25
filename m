Return-Path: <netdev+bounces-74779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE59862C38
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 18:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4754FB210B7
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13F017BAE;
	Sun, 25 Feb 2024 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DpqlcBhM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628E18AF8
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708881257; cv=none; b=c98efFJucIlNafjqIoKANHsPw6Qn3x9d+cQBcIO7+o3O2ztC1kq/Iret5oMRXxXYZQx7zAKalIKuK3H8UnsNF/8pFi9pWNWbWNYKywaVmZsU7OxgDTv0SRQGFgZYQJR034Gn6ZdZEwHsUh0lv5MinTt6huC5NlzHRei9PsjaRcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708881257; c=relaxed/simple;
	bh=WWHe62jqpP7qRkfkrLQuEDOnSdiAq/+HGLtVLP+TA+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4goSVlzZ6nguYp+uwVqo/EyW6IsKpekpOaC+zqjNsPOSNH2sW71vy/juLvGG8+/sUTQJqrYnJ2pfum4eV+7rbd5peKxysazVJZVDZIQtQt9YepvpE/Jgh1FYWG7ImBDRRzSIzbeEDJd/8xV//0d5kJjeEsRXgFCTHFiCAIhE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DpqlcBhM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4348aaa705so25312266b.0
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 09:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708881254; x=1709486054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0eZgSeXgV3xfMa5j0GZq4dgMO8aNM+WGN0zJZjS5h1g=;
        b=DpqlcBhMhLvtUpYRG+XScFGBv00VhXEQ5QUMSjnWXs3FaOF6AyB3DWV0wfs2oQbZJ4
         9QRGb99QBH79/DE/uZ7vLv94zt0ApT5kYvA7/znY+RlgUA/GnGFC7FuxIvhHCK/tiFeT
         mymG87sOzZpru/vrlHCq5K2UXkvUqNCWLaeoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708881254; x=1709486054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eZgSeXgV3xfMa5j0GZq4dgMO8aNM+WGN0zJZjS5h1g=;
        b=RboPkIoWARCGoVIWZ5LyZXydgEtE8LnACA2e4J1/rh70O53WSffvpEHbr9aOjcZEsO
         qMofk72fPN24LzqsfrjGo3U0NNFrTTDIOUiaxlekSSBtPdaRw5Wyh/ZBn3LPjrRWkExX
         uOKE6f28ds12lMs2zA4oOsAG7qu6oOkw8q167uN4r5titE5a44KRxfq0bVIneQJZxTEV
         id108v4ouu1EK0lKzloFtNrJIXL35hFLHIaKgEQhYIKvw4QduZL+uMUWikjgmHseC1og
         9ZPtz2K9cyUIHklFaMTbQnXYg2lZnw3vxBeHOSd6Q7dASBmeiBJHeuPLsllzQJI2MG8L
         3yBg==
X-Forwarded-Encrypted: i=1; AJvYcCUMja74hG1T7Qa+g9ZS7Q3aI8XtKp/jhdvRKEegQGLLn0I0+s8h2rBS6D3XOD7wagD8Z9JQl7E4qtp3TU54CG5es71YTmuW
X-Gm-Message-State: AOJu0Ywicy5YVToV0NGrYwT1QtK3yjrZ5r1jrCozw55ZCAjtink3m7D6
	nEeU737BT4NknyNqKogDOP1hZwBS8BllDgnZQIAJSfXMFnFryyvkcL+z3kjTGQAWTM7Q3Iu+MAF
	oEeIeeg==
X-Google-Smtp-Source: AGHT+IHjAiDUw07kuwZvRLHBdDUTD+RWRMtUWNrlKtdka4S8qpnMNu70wv7WysYI1tbBHQLMFZJ4BQ==
X-Received: by 2002:a17:906:cd0f:b0:a41:3950:d11c with SMTP id oz15-20020a170906cd0f00b00a413950d11cmr3454392ejb.28.1708881253995;
        Sun, 25 Feb 2024 09:14:13 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id tb27-20020a1709078b9b00b00a4300fd3a56sm1276899ejc.103.2024.02.25.09.14.13
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 09:14:13 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so2974023a12.3
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 09:14:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUChizEY/UFLilOO+JiFxbp/QiyLKnLkXaypdo7XUMRi+dXqCLYbjbUyr1G/A5UHRyMIKYvl32aDZIZbtfAWVJjmfMlOSB8
X-Received: by 2002:a17:906:4f01:b0:a43:1201:6287 with SMTP id
 t1-20020a1709064f0100b00a4312016287mr1617440eju.73.1708881252681; Sun, 25 Feb
 2024 09:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com> <c6924533f157497b836bff24073934a6@AcuMS.aculab.com>
In-Reply-To: <c6924533f157497b836bff24073934a6@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Feb 2024 09:13:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNh5Gw7RTuaRe7mvf3WrSGDRKzdA55KKdTzKt3xPCnLg@mail.gmail.com>
Message-ID: <CAHk-=wgNh5Gw7RTuaRe7mvf3WrSGDRKzdA55KKdTzKt3xPCnLg@mail.gmail.com>
Subject: Re: [PATCH next v2 08/11] minmax: Add min_const() and max_const()
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 08:53, David Laight <David.Laight@aculab.com> wrote:
>
> The expansions of min() and max() contain statement expressions so are
> not valid for static intialisers.
> min_const() and max_const() are expressions so can be used for static
> initialisers.

I hate the name.

Naming shouldn't be about an implementation detail, particularly not
an esoteric one like the "C constant expression" rule. That can be
useful for some internal helper functions or macros, but not for
something that random people are supposed to USE.

Telling some random developer that inside an array size declaration or
a static initializer you need to use "max_const()" because it needs to
syntactically be a constant expression, and our regular "max()"
function isn't that, is just *horrid*.

No, please just use the traditional C model of just using ALL CAPS for
macro names that don't act like a function.

Yes, yes, that may end up requiring getting rid of some current users of

  #define MIN(a,b) ((a)<(b) ? (a):(b))

but dammit, we don't actually have _that_ many of them, and why should
we have random drivers doing that anyway?

              Linus

