Return-Path: <netdev+bounces-134583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC299A49E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689B8282B82
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63046218D80;
	Fri, 11 Oct 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="j5uzEnLP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707A218D8F
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652338; cv=none; b=A3oM3wXObRaWmVN8kZJTaElE5wxEnjIRTRPyEEVADSQZdYHWgj7SpTjFXkbcn2YaArwiv6zwdc9t6iHyrUNlfkzQuwJLOyFWxpWfxNEwlpbKAtmGT4bi6yoJHYXlwOpg4eYjGpLk37BM/wnkPBcuuQ2cNsDpkZQ20Oc267l6jz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652338; c=relaxed/simple;
	bh=G8qGUaGJGZv/c5eUN39o5VdKnPXF7QYCJgzm+5GU8XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQDy/S8tF1DotPm7c79r9SfSDPcBYYtsjaMMJwuUUkgX+HgxvFkNglWjTCOsi+rBTm5oA1jyKRCKveyoVpBjB6XRYP8kGwVL9cvfgb7PXJC9THrZ9RwvlSO242eCs13jYrZ91HS4Lq1NOTYocRR6dXH2kb1OQCtm9pw9ofedRik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=j5uzEnLP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d5689eea8so364388f8f.1
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 06:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1728652334; x=1729257134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rv8NzxNpQPLVEaMv8BkCOMn4dFl6HxQWItjo4gHc8S8=;
        b=j5uzEnLP+NxO2FN1pLSct/PEYg5aXOD/Gidh0A/4nXmKSTmw2lKNacxBVX5kfr+7T0
         aATR7c6z4RokLw9hCkPbT9zK74oaHkrAWRcievEiwPe5T83zQUUN8YvhAZSSRXwzGTDp
         d3b0CBDYix9YtwGJ+/uH5icbPwY04DVW5yMtrvGigdzf9GNHJIJxmPzJcUblhXzE4700
         U5i6s6JK/qp5+RO/a+CYPQsiB3sxc+Vx0043Ex3WArF8EOXeduN3/YpMZJ2ci90nxedy
         R/Gd0gH4doOQ48Yux0QWNDiC2NFJ4rTHtFcWpW6C0AXDKnxnNasmh8b6e0bfhXkuaH5z
         xnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652334; x=1729257134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rv8NzxNpQPLVEaMv8BkCOMn4dFl6HxQWItjo4gHc8S8=;
        b=bhZeWEr1I2Vo6D1SZjKSpvThSVbZA822T3z0Y/FvlbB++JbbkYd7jwJyJVEuZEaTN+
         xw7kAg//7Yc5sDPcmSuo4b19PppahaDbVPG/AeToxG5qIdjyVPcWBWwSngowcrMM+8yf
         ALADc0hApETmjqNqjiInVlY9yX8IFwCL4nP/fmwCE3IBdbkgfoUk0vBlpU3D/CpB2pgy
         eQ2FXFBqRDjiZc5tIyy30WHi5ySMYhIsmetwjCM89DM/VM2duVso8olyqxahpoDL/bkX
         fbck0obCgiqC4IiedwYPQZKIfWG8JpF0Q28CRsvfSqB29upbRkACeqDYKBTLDHo7KwjE
         t70g==
X-Forwarded-Encrypted: i=1; AJvYcCUlfTLCX3gL+9p7YDU/Go00hq1QbogDEUY/qbmz9XNne+UXaL1/LVDiC0yUjmTLuK1eOypzKB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5GBc1hSiO1g7Ihp2+Lxfg8cs7Y+KhC6eGj+XtOwHaHuVygkv
	k+bZp077Z7md2OeMB7pyYDISiesnk8vDjUGtg98BtbYdOzAf9OUaXY9vsSzAhRE=
X-Google-Smtp-Source: AGHT+IFwPySkw7rAoJTYAStSldgDhY3jVOzIh7W2cIvSY2yJOw89fNE5yWdDJXb+a0dmn/DcMb9dKQ==
X-Received: by 2002:a5d:68c5:0:b0:37d:46a8:ad4e with SMTP id ffacd0b85a97d-37d551b9740mr1930481f8f.15.1728652333936;
        Fri, 11 Oct 2024 06:12:13 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee49bsm3909731f8f.100.2024.10.11.06.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:12:13 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Florian Westphal <fw@strlen.de>
Cc: Florian Westphal <fw@strlen.de>, Richard Weinberger <richard@nod.at>, upstream@sigma-star.at, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, kadlec@netfilter.org, pablo@netfilter.org, rgb@redhat.com, paul@paul-moore.com, upstream+net@sigma-star.at
Subject: Re: [PATCH] netfilter: Record uid and gid in xt_AUDIT
Date: Fri, 11 Oct 2024 15:12:12 +0200
Message-ID: <1884121.lUd5UmjTVT@somecomputer>
In-Reply-To: <20241011012713.GA27167@breakpoint.cc>
References: <20241009203218.26329-1-richard@nod.at> <5243306.KhUVIng19X@somecomputer> <20241011012713.GA27167@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Freitag, 11. Oktober 2024, 03:27:13 CEST schrieb Florian Westphal:
> Richard Weinberger <richard@sigma-star.at> wrote:
> > Maybe I have wrong expectations.
> > e.g. I expected that sock_net_uid() will return 1000 when
> > uid 1000 does something like: unshare -Umr followed by a veth connection
> > to the host (initial user/net namespace).
> > Shouldn't on the host side a forwarded skb have a ->dev that belongs uid
> > 1000's net namespace?
>=20
> You mean skb->sk?  dev doesn't make much sense in this context to me.
> Else, please clarify.

Well, this was a brain fart on my side.
I wondered about the sock_net_uid(net, NULL) case and wrongly assumed
that a skb I see in the outer namespace can have a skb->dev from another
namespace.
It would be awesome to have some information about
the originating net namespace.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



