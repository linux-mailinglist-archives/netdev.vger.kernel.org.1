Return-Path: <netdev+bounces-168621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37652A3FBCC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871B77AF48D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3525C1E7C24;
	Fri, 21 Feb 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahp+d+ko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CECE1E9905
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155929; cv=none; b=nnYPBESwmJ5kY2RiGfKaodv/XYzU98jL91ubmINUjm0gmF/8pZ13CTJofdvt2bW8QSW/MWA5fLIIfqkgwYLbOX5D4O8Ph0B/jb5rRinS4TuPYJa914LajJpWevVhj9HRySxl3Qts70bpYlPZyLeK1mBTUIeAYvoay4w5eWT/rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155929; c=relaxed/simple;
	bh=eKXiW2IirJjdnv3knwWIVSTxx8r3WUYzTIIbrQ2JFy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vE8ZGaQuroOfOpSoiX8CBsisnNchVwWMLu5O/QDxeVj0o87AbtXcQ6h3/YC07SinG0kG79L8LVyT0Di5MnfxEMXAM6te6tjc0vRDJoQM585PACFBUCZ7+NmAjGZp4moaLfCJp+/EbhAcd9ZWPP3D1m5YkmMlirZunkt4m0YIQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahp+d+ko; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so3238949a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740155926; x=1740760726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKXiW2IirJjdnv3knwWIVSTxx8r3WUYzTIIbrQ2JFy4=;
        b=ahp+d+koYARZDwstdcOqv1BH3jmLl0YChxdGmNxS36+JVkjXr3w9b96ypY+1bYKpwR
         83h+7QjLrhGcqwQjftm2fElNz3noItMbLW+mi8F4VYtxzua9Ahrmdm5+vwWaoLC2fbKt
         0b3Ouuthsg8nh6F4pks9+VJlp3PhhGSBhSqFax5u69ZYBWzG/bZEJzG8vTtylCrHM8+l
         +EROT0PDw/uucCVz7hJcZ8/PevfjYdceX4MM2ftm+fVOdCZRElu8IGfR9q/sA0LqslsT
         QDyYhvhsquA8BHoGLcOMehL8xAl7B0ZBwW/2Q0xdcy90sC40RPwGQMxOZpUTPYm72vb0
         u8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155926; x=1740760726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKXiW2IirJjdnv3knwWIVSTxx8r3WUYzTIIbrQ2JFy4=;
        b=H/3fHfkJ/FEoIV0pDgBReuFAQR9rYa5VXXGJoau7+8eU5QuOQ+RtwuJ5f6gV2sDIwS
         eOyEUA4bZ+CNTXlopmK28LelQ++OZr9HCP3dZ7KVC4yv/kwGMHPmKc5bD4ppzbIUYqwY
         M/kn0Km0/nAePYU0tI7z+H8qxbNt2zIiGlegd/dmEoPXUbKF4X0j+UzH9OZSJ4zvuopO
         m6TMLAhlKYhKR7VZcb11bMqdgAjP715DdcLgFra1L8bK6fjN+rkgtrh6g6dpe8+eMVhC
         JsoX0a/PknHdpbJ4KlzkQTg/yUIapCmHu0UKZD4VVK4rbNop5cP/eZaCQPBeOllR2DfW
         DMHg==
X-Forwarded-Encrypted: i=1; AJvYcCX87FPPaDxfRPoEiNsvondz6bDYCNS/LJiOF8QN9OjPxaKTf5Uxo7qSdIrnikYifF5fH+rh5Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGubW4RfBKJEcQROQ1cRVlo3Xu/j7PHhIrNVBkIjlt5qXlCvY
	O4v5ly5nqXstZ6hVeknj4Md8wEcfykr8Zq97wuB/G+tg4z3Gh+bvZv/CcxFJK1z8cpAxr/qOr8U
	fNH5lWhnaLPZ/kWpCkTS3QX8rhcTJXwLxav0k
X-Gm-Gg: ASbGncuxVfrPozKep/QjBLrCxzZUGZW+YFgGPWI7T4zYI/GdP0FD4ou9PJ9S1uA0+gV
	tbmGkGp4sLJfD3OnIwytBImSB9CKtv+nMFE2ClqBSmJinIj3Y/Gf/F60VNe0GCO+LqFNWLSFw1q
	lDY2xWb6E=
X-Google-Smtp-Source: AGHT+IFy85mxPwZaOm4Xc5BpvAw4HTV/r/m/3BpPkV1Pjv4idQR9Fv2yI0EywB3A3UL558T2kGwf6PwzKtYlqg9Z3bE=
X-Received: by 2002:a05:6402:3585:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5e0b71124e6mr9524228a12.17.1740155925588; Fri, 21 Feb 2025
 08:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221051223.576726-1-edumazet@google.com>
In-Reply-To: <20250221051223.576726-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Feb 2025 17:38:34 +0100
X-Gm-Features: AWEUYZmWZ9fGPQBWWgEb6_JKE_YIfeT0U4tWykfRoeh9ANdxNVrVBt0swfHjgEU
Message-ID: <CANn89iJe9SJztXHQE6a3JGGSeMp2TLAQX8bE-cggWbxv7LeEjA@mail.gmail.com>
Subject: Re: [PATCH net-next] net-sysfs: restore behavior for not running devices
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Antoine Tenart <atenart@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 6:12=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> modprobe dummy dumdummies=3D1
>
> Old behavior :
>
> $ cat /sys/class/net/dummy0/carrier
> cat: /sys/class/net/dummy0/carrier: Invalid argument
>
> After blamed commit, an empty string is reported.
>
> $ cat /sys/class/net/dummy0/carrier
> $
>
> In this commit, I restore the old behavior for carrier,
> speed and duplex attributes.
>
> Fixes: 79c61899b5ee ("net-sysfs: remove rtnl_trylock from device attribut=
es")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

If possible, can we add :

Reported-by: Marco Leogrande <leogrande@google.com>

Thanks !

