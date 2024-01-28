Return-Path: <netdev+bounces-66516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987C83F9A0
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 21:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7F5282A24
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989236138;
	Sun, 28 Jan 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QM5LSs+2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65B4C3BB
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471990; cv=none; b=HItpQ/nUCehfJsGtVY5O98F8Z18Nvb9qCqcH3sFZrJoZJ0vq3GOCQBv62UG7Ag4qKtvqS85ReeNpVmVFiLByrxWkh5QrxMfTot3DaQAyfs+BbJuNnjLJz+W9TsxiH5+oKApj1hoeSsj2PUAjySmkiZPu1CGhPv4TzDAlQcOA1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471990; c=relaxed/simple;
	bh=RQPBgjqLxVYa9z7DAN4AMZv6aMuk7G/qW9fdGyDL5MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHNYd1qVzQzlZNzO2PGtiyC5zA2KQUpbYDfV9Zfn42qfa7E8dUrAEfSrk7Y9WjLBTdXzRmVw0w0Z1p+or2ERXbUXjJTWJYpyIPhErQPaggm21KyZcAUDbmvlxVteGOgFWYzpb1WHcYDO60eYAaq1/LBiui8DBQyI6EAOb8x6X9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QM5LSs+2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf588c4dbcso12617341fa.1
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 11:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706471986; x=1707076786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvgl07qLmO97AnDOonOYaDY55AuzJRLfRUuCExUHbJw=;
        b=QM5LSs+2kxc6YxNXaar8rJ66JYx+Z+C0zfV9y3lGZK5AdhBl8ydSUDBIQdB9XmxgWL
         EgWH5Ut9SeH/XAvbH9hXCb6+YNZ7LelCOMjP4/HJZPDKJxhXODnNYPzk1XZyc6ZhSBzE
         O6dK0sHhOU7yOWIG9cdBTJICv1zO4R09T5V+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706471986; x=1707076786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvgl07qLmO97AnDOonOYaDY55AuzJRLfRUuCExUHbJw=;
        b=U+mzpLgrVZSnJRRgRZEcz6ODxHECJ+pgj+w2QDiMQfUxPcKp7LqFOltVO5xlbIe+Xs
         Eq1OvKv1sLd6jaJ3n4oO5Ks1nloRaYuVgi5xciIzdZ3HJ8ufDMQOXgECK2qysgJcMkck
         XR3TXKWNeQO4o89cQde8wfRQaaaqw/Qp/JHKn3iCyzwNjVRkX99QyzokLLZMogTWYLdV
         Fkh8WDLc1DmnHkTahBWFW3PeGUscRriJtk4kR5BpYHcph6iSSRKPKsBPtENJWswfMz4m
         DqIol0c0i0H/fgJSR0vGQHOtfHo/b5AFsTOW2uZk4JL6TOcrAELD92ZHdHJWC0OLKRbl
         g7RQ==
X-Gm-Message-State: AOJu0Ywo252PbOn5IOd92UREUZNsOrsMwltDnkFq+bcKrXzx/ZuIvIWj
	9fmT2JMxJQPqLMoesbpIqaYwSNiNyZ6oPOh5JZFqgpY9VQuKagMDg7705ZavGkXzh8s3AI63LKy
	lONg=
X-Google-Smtp-Source: AGHT+IFEFDp2Q1/j6dKb2s6PiKE0KN/KZcSq2o5nu8QNGWcxq4PU10wCQhSTNYfCDIb2nwRHcLXWUQ==
X-Received: by 2002:a2e:3501:0:b0:2cf:2d44:ee1a with SMTP id z1-20020a2e3501000000b002cf2d44ee1amr2851645ljz.36.1706471986414;
        Sun, 28 Jan 2024 11:59:46 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v13-20020a2e7a0d000000b002cd0435c50bsm938589ljc.72.2024.01.28.11.59.46
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 11:59:46 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d03fde0bd9so10063471fa.0
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 11:59:46 -0800 (PST)
X-Received: by 2002:a2e:994e:0:b0:2cf:1a11:ea87 with SMTP id
 r14-20020a2e994e000000b002cf1a11ea87mr3234050ljj.39.1706471985664; Sun, 28
 Jan 2024 11:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com> <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
In-Reply-To: <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 11:59:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
Message-ID: <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
Subject: Re: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, "David S . Miller" <davem@davemloft.net>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jan 2024 at 11:36, David Laight <David.Laight@aculab.com> wrote:
>
> However it generates:
> error: comparison of constant =C3=A2=E2=82=AC=CB=9C0=C3=A2=E2=82=AC=E2=84=
=A2 with boolean expression is always true [-Werror=3Dbool-compare]
> inside the signedness check that max() does unless a '+ 0' is added.

Please fix your locale. You have random garbage characters there,
presumably because you have some incorrect locale setting somewhere in
your toolchain.

           Linus

