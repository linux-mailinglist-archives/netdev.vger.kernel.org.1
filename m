Return-Path: <netdev+bounces-244441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 856FCCB7658
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 00:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54D7D300AB29
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D1A1EF0B0;
	Thu, 11 Dec 2025 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojxj9Glr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11525188A3A
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765496339; cv=none; b=NSeawE93NlMDjdeiPWG7reBI0mLWMEayLhX7+ojx7wtOYsF7EC8+hdrY0WiYtD84t0MvZQQSmlA4xjN7ddgWDj3pN5B6KQhN1aEc4Yf5awHY28KAja90IT8NY9C9np05Ad8V6Nhkb5PrNEH/e/syGmcT20K41mIBGtebdWB2I9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765496339; c=relaxed/simple;
	bh=9k8qzTRHgI6vW3hS6hq1K9YI8Nw7ToTV2aqvDKr86vg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePTFtftUcLZmk++CEvh3WD0D3tPYIr+GV8r1t1zUs8uySYyNCV++x9TL3QDRECwrNLZcGiKmBdKLKcT3ayUh4QUG2/g8dh2hXWGKyTUkR0V9q4sscJBIzymx1SZoNL6CPkbgH5qHltZnO1Ocs+ml0UNNLomuNpBl/opOuUrSpaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojxj9Glr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso365145f8f.2
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 15:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765496336; x=1766101136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sLzSFs0MJxQDJjFwVuf/bDXQYqX67MjeQEOeVTpOYYo=;
        b=Ojxj9GlrQGB1UFvkV+FW7Cto7aKaj/motJZRN6WDX5y23DW7aT9cOj2VkDB7tUo/Qm
         avrF7Qm0s3p5OniiqXiR6lz/Yv67y0WDq4tz1FBHnyidA9AveV/xVYbrnp4VeiE0VxX3
         0HByPxXdlies3/YjHGlRrgrfFmp2AbP1ynLqy8jCnKwUtUou67lcvN/dt1IAxZhTz6d+
         4xWyo+k7rynmG/MnqGz6CY2c4avQIp/3mvCZ+nyUtWDM4KeXVnjk1x+S+63WJsfgGSqO
         RS740xslc8Pu4a0dKR7PAr5GDxl9EBRhDCiSx3erR7e9PTKw+7jrkCZnHYYPUn8VkwhL
         hqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765496336; x=1766101136;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLzSFs0MJxQDJjFwVuf/bDXQYqX67MjeQEOeVTpOYYo=;
        b=nH3GXtKhvvxtBu9MzLUmtYzVVCpV3JO9Auk3XgDyskljbQGxs9IJk7ZWxp2bplKSqI
         T8mJls+zdjNanoLmhN1NCoyaa6BcIcd67E3gPMi0nFonsqEtUR9cXAU6gEhhF64NBeB5
         xGcd64laUS+AUS1KUD9TPINg7KFqM7TyvFvNmTEIZiuGYdMnG62+viuDBGcBeIjsmFca
         Xaes4M0smaJ9Z52Un5Xw/Qiwwc9m7P+D5ncSKGi4PK+cculo64GR/nhsrny3dtLOX+cl
         p3C0krFa6Au/ezeQf9DoI69VtI31x9JBUo2WSSRQOW1IxVPlGt0K9DszRCf1O5EmQVw0
         x/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWqKB1QdvKGLFcrPhnPXpAV1ICfe8JTeaMIHVoI78i69/b2ykiL5zkOSH0ZhAO7tY1IelDpWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEUcOTVSgu2gS39dQhxf5QdOX5HqIAzsPGeaCSm/7zAvC3oQP3
	3cRTFg3CUFXyKuVdkYyerWQlTvPmcY/x73pRzbLOGFY13bAfi9RyFpOq
X-Gm-Gg: AY/fxX6SjkSeFAyb0Ct5Bv3be0Jf0YfRloqVx7sLJysgsYJ+6gZ0/56B5+fpvEuhsPC
	UuOT8jG7OHKn4jjygVL18gBNViCo1Z8ZFNfRnSt4j1Zk0xvUg8NMrfIWkCtbfHySEwpLvJhIE3j
	TeY+KnJXodElQEjszu542EpiAYWsbuaU0B2V8/M3nOIPtj+PaAFSPw/65OLbZtpXusmAimq0MZU
	DUSFJchKAyFtLPKgMDrBN7tjpUD3pgUBuhwNkBsRvHK/RtOyLXAaEd8yRewsjv22ZewMjpHog7M
	tKRbVf8tmqkfI9YZzM+yoAUxDd74Za9Ec07WG+5Lbco4zbnnuxKeon9NApnQs3FS4JQvkODHXid
	kOqNJZHrz8zJkgMNwUFYCxLp90pgR6o/Nqy15CdDZOg8AEPpbYFNeyzV5bvKjOB9nB8d19nzJPp
	aYlvBAu3M4rQ==
X-Google-Smtp-Source: AGHT+IE45H/GVFC3P8L28cgs8pfNb+tCesFLvYyFT0QSpKSxkTAM+g/9RHIHCke0HEmegsX96vFTcA==
X-Received: by 2002:a05:6000:1acb:b0:42f:9e75:85ed with SMTP id ffacd0b85a97d-42fb44a373emr113309f8f.11.1765496336192;
        Thu, 11 Dec 2025 15:38:56 -0800 (PST)
Received: from [10.0.0.157] ([37.186.169.145])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42fa8b8601csm9467910f8f.22.2025.12.11.15.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 15:38:55 -0800 (PST)
Message-ID: <1c8949c99d61ebf9f3882397d146213c5c519a75.camel@gmail.com>
Subject: Re: [PATCH net-next] net: reorganize IP MIB values (II)
From: Thomas Haller <thom311@gmail.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Date: Fri, 12 Dec 2025 00:38:54 +0100
In-Reply-To: <20250320101434.3174412-1-edumazet@google.com>
References: <20250320101434.3174412-1-edumazet@google.com>
Autocrypt: addr=thom311@gmail.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-20 at 10:14 +0000, Eric Dumazet wrote:
> Commit 14a196807482 ("net: reorganize IP MIB values") changed
> MIB values to group hot fields together.
>=20
> Since then 5 new fields have been added without caring about
> data locality.
>=20
> This patch moves IPSTATS_MIB_OUTPKTS, IPSTATS_MIB_NOECTPKTS,
> IPSTATS_MIB_ECT1PKTS, IPSTATS_MIB_ECT0PKTS, IPSTATS_MIB_CEPKTS
> to the hot portion of per-cpu data.


Hi,


the patch

 https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit=
/?id=3D652e2c777862c869966082fec98174640ab20dc9

reorders the enum values in the user space header.
It's not only done by this patch, for example also
b4a11b2033b7d3dfdd46592f7036a775b18cecd1.
Similarly, the `LINUX_MIB_*` enums keep changing.

This seems problematic to me. For example, iproute2 does:

  https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/lib/uti=
ls.c?id=3D24a5a424e3a0b3d85dd035540d874dd769ecb2d3#n1536

which only works as long as the kernel headers (at compile time) are in
sync with the running kernel. That is often not the case, for example
with containers.

libnl3 also is affected and tries to (badly) workaround this:=20

  https://github.com/thom311/libnl/commit/5981a39583ab65dca230a8ee70625626d=
9ec9fc8


How do you suggest should API users handle this? In the future, would
it be possible to keep the API stable and backward compatible?


Thank you,
Thomas

