Return-Path: <netdev+bounces-166441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F8A3600D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C108B16F500
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD17265637;
	Fri, 14 Feb 2025 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfldtZ9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDEA25A645
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542563; cv=none; b=ogwi8k6IzHdL4KCPbhD9tqghxkUKVZhk25UZX6tv/+13wnqE0DiR97XPUbspxJqXcv03rQ6qrhgcb7K+RZ9+qjuRVWl2aQl/jeHj8BYVO/HPVwrZiaK0ehGk9P47c9Uk2LciUlgH//jw9vOrUo7nQ84Ar+lJ7aJBvaygETpSQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542563; c=relaxed/simple;
	bh=bdWpZ7zeICeJwSZs7Sq+iETodmYOR/0+PZr+SrMWFCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRY6w0w+9j5S6OIF7rCES8lECo0wPyyDJEjFew/rXPzN2dTX/iQ5djm+U/daxkN5NyvIFgbmDl0G9FiZMs/nZu7j2UBBhPvAWH2mbfOUw9mLYie3iM0Lh+zFJqeZ5pLKNE35FJAqvOYyDj7iAA1bQBMu/+ewD/jeuB5bqB1F7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RfldtZ9Q; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so1238303a12.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 06:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739542560; x=1740147360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLRVCWrxOw3czTbnoXrUYVv+b49FI3ouuyEQgHZTyVw=;
        b=RfldtZ9QBUOdtPVDsMGrIzj+bcIl5/4lVsBQ6gmSiMp11vG/YtoCvOkClic6fJYRNh
         gmy19gzvjAoDx2NDj+rvZ2Gpljm/VcrjNqVYutZGffojo9V/mmTbD+QPnXwOziEOddm4
         g1/UE2Q9xKZv8GGcZiFqVvdB7acswXQjc2kvNsLy4S/8BjiUa2s6TfV9COzdP93Vptwv
         BlheHihU/QlrwCO92/YCqFOIuyTPYtPwecqDDFseR2Hr6y36xTUtx8smpLvnGtv7LKgV
         hG//Ec3G4pN1d7VvHe1GN5fBYucV1XYRr+92TgfY8aepUmMQfLdwJpjKwhtUQtRSvs43
         94oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739542560; x=1740147360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLRVCWrxOw3czTbnoXrUYVv+b49FI3ouuyEQgHZTyVw=;
        b=PiVj9gjh18nugTYvc36sgMpJ/pbnX4E/QJ5pIRuQZ1LWuLsN5q42uwGEdEHpmweKcz
         98YN+wdT9wcq5/JGXz+qf0WlxzLy/DoeYqvHLAsNRRQJtk8ymHclwnCERJWHjgkGa2SY
         Q2zBFSNys1kVqh+tczF4QnuwRL8UQIjSrHSIeYBGXTNFp5XawOeF6l6qlyB0sIee/mAQ
         sS76EDt+EGrPU1xAbNi/eGLMY2dXrt8H3P4ZvmCw6nNkv1ejeAl3pQzduCdEq511QRao
         3vZGDtm2ZgDCv3eI949ND9MaHaUOfxngsKqlrp/jhZLxg/+STwONLfcxqddWEJpp0NaF
         ii1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbU3vWKgD81DfRQE8OX5wkjLf+h3LKK25qCrUromyS7DFRq4B40AIdCX/nNu8RPk0SzhTUsLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFhN9T++iIWtnf3UT/sEtK7YJ102bryu4EYJBMDYKd7nTjNRnV
	Y8UD8jio31yArrP0TmZEXATXk/c/gYNuDTbFltoM9KxKzjlsTL0zxDTURrLDdTuHvnkM9etxG/W
	/+n2o7jkbMdio1DHtsRUiaXY8WLOi0Wef6YPb
X-Gm-Gg: ASbGnctahplJ3bTG7BJDx12vNLk5+wLltHYQE0CaSGeufToQ3th3+cgm2qduwf8dEGA
	CUXR/wsQcM05/rViAQxYgq9qdvl8Z/sS6pN9crLwny5yHCUE5Bt8sIsIOzOH/Gxqz4DDMl1Vcog
	==
X-Google-Smtp-Source: AGHT+IH2av6U3WuBZtAedsZeDY7Dw2iatqoTQl9zAS50lisPIi8WTBSTTmIGKVaS52CXHmgvS0YLQK5hZR0e/SNe+NA=
X-Received: by 2002:a05:6402:3589:b0:5de:5cb3:e82a with SMTP id
 4fb4d7f45d1cf-5deca86c698mr8067441a12.0.1739542560068; Fri, 14 Feb 2025
 06:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214045414.56291-1-kuniyu@amazon.com>
In-Reply-To: <20250214045414.56291-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Feb 2025 15:15:48 +0100
X-Gm-Features: AWEUYZkfFVgdNONaP42Z8vshZmXhHhP55I8n3Uovu07QQrg80_--5duvdd0-hvE
Message-ID: <CANn89iKY8V7jj=JkZpC2YuKtiUMr9-mDoJ7g7+0G9ppdOXo8ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] checkpatch: Discourage a new use of
 rtnl_lock() variants.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 5:54=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> rtnl_lock() is a "Big Kernel Lock" in the networking slow path
> and still serialises most of RTM_(NEW|DEL|SET)* rtnetlink requests.
>
> Commit 76aed95319da ("rtnetlink: Add per-netns RTNL.") started a
> very large, in-progress, effort to make the RTNL lock scope per
> network namespace.
>
> However, there are still some patches that newly use rtnl_lock(),
> which is now discouraged, and we need to revisit it later.
>
> Let's warn about the case by checkpatch.
>
> The target functions are as follows:
>
>   * rtnl_lock()
>   * rtnl_trylock()
>   * rtnl_lock_interruptible()
>   * rtnl_lock_killable()
>
> and the warning will be like:
>
>   WARNING: A new use of rtnl_lock() variants is discouraged, try to use r=
tnl_net_lock(net) variants
>   #18: FILE: net/core/rtnetlink.c:79:
>   +     rtnl_lock();

I do wonder if this is not premature.

After all, we have nothing in Documentation/ yet about this.

