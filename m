Return-Path: <netdev+bounces-192995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA249AC2111
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 12:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B27B72A8
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0C22579B;
	Fri, 23 May 2025 10:25:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858C2F3E
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995955; cv=none; b=nVrVWfa8AqkO45TCKuQxxGd3A90ARoftAqB7eo5hhAVaglSVKVpQ0d2bIc01z5dmq7MWxslXHHdTHgNjXvr/9h2AfPHdNB76c4IgNxepWtrG9WNXbBvnFUK64c1kOPDeO1tTn7nFieIEWYdGERjGgemuaE1uA3vDFZCP8UtGFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995955; c=relaxed/simple;
	bh=nphHpGn7OGi6lB1RlK4SWQv2V/Vz5t+QsvXh93O9tds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCdZMXqGgnf8WCO/85VlTI2mcQq0V6LCVFtk4Iy4LBJojLqdbhLoIrHGoXETBpZkR/dc/Cp2KcP5YTEmwM8+FBygqnKRdriHxMiVD2Pdtz/eT997khfwzox/7Mb3IKqaKU6kRHE0443M1bC6lYWyqyD+aUc8h8+VPG5uR+wYVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso7902803276.0
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 03:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995953; x=1748600753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxeUkqjUyPgr+JT7pOszdt0RVG8U+b2cFawKuITYbzE=;
        b=wNmP4CYf3l1teKwvIk8hYiOWRGIN/lMXwcVH2J0FFdUhMmz27KWcHxBpegA2+fI9Ek
         1ugHpqb1reJ1L7XKBjbPCNQpRt5TJGuMAcDwNyUXrHP1u+71vNS0mqf+1FvXWRV0RuyZ
         7tykhoY82fwA/gwKb/ffv15zoS2ZO0ovDhdzDrzdAXCLXz3vZCf7TtJkVOnOrZbg1Uto
         kpqns4KFXj5G+HIlZHypM2BoKvTBfhPViWjU/UUbsALLO41XRa/m0JtrNv1DnPBP46Ux
         TjUEkFsQ7KnLEj53Ji9Wf4o8GrcP4LvabuCtYCImWpo5DfHg5fLVZZCy5EfC1SeecuUq
         N5mA==
X-Forwarded-Encrypted: i=1; AJvYcCVG2bxSeJ2Y1jDfrXmUCIF4BVtS2vfOxulmhvbBTv1MQC7bkoGJfoC7QHG5uziMSiiQlVsGbm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMRLL3nvyRO7WqMw0J8JUZtzIxkGi79UAKgbW4si0B4kTSiY8Z
	4ud11GM8h0UMr3+XBuCmPagG6bI5bCzRQ1B6jK+90g3rXquXpTXag9LSS9oChOj0
X-Gm-Gg: ASbGncvofBlon0QFNapDr86jC1hyYje8p/T3E5YhSXM4cYVKrOhzrQ1uImPm3aYbXhx
	G5iELgWe8f0w/es+YI3kbrXd0VfqkmqIf1u36ilofjS4thJcdHyGMWm0prjCmqWkYg7LMQyHbWM
	ATSgdHtORISD1IXlpLh2Ow5YPFlhwJla4mUqguaDTUmSIIhuQHRa3KSmojKx6WuCJ40x61k1hX4
	kcTY1JLnulWsTJFKppG4Cv4EvflgO2QQp/CYdbKQfBnJ8Ig6DMzWA4jIFX6XqBaohbMNHjlaqX7
	QvvuD2+N6uDYHRc0VYYk1yZuVNGCE06bzt6yd5FptSsmSVmOcLJxbCngrbVfPVtyWPlQMJVSdfY
	TvWEBm5Hr+TVh
X-Google-Smtp-Source: AGHT+IGeysGoKPUqwbc2mJazT2q9u8CZ/Q1xOJLk3gKx1PXg0Q5Jr0BjxaHgEYdJ9JCwsvE6Aj4tOQ==
X-Received: by 2002:a05:690c:6405:b0:70d:ee3b:bec8 with SMTP id 00721157ae682-70e19650a13mr31734977b3.16.1747995952906;
        Fri, 23 May 2025 03:25:52 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70dfc9b9ff2sm8772127b3.125.2025.05.23.03.25.52
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 03:25:52 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ff4faf858cso63344257b3.2
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 03:25:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVP8lhyljXMajIZE1dMeOqQ0a4hpO68LxucUw85mPmxMx5OIkLJ+uIG9/HIHWLiTcV0pMZ8eEk=@vger.kernel.org
X-Received: by 2002:a05:690c:61ca:b0:70c:c013:f26 with SMTP id
 00721157ae682-70e19908bfcmr26395717b3.33.1747995952483; Fri, 23 May 2025
 03:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032518.251497-1-yuyanghuang@google.com>
In-Reply-To: <20250523032518.251497-1-yuyanghuang@google.com>
From: Luca Boccassi <bluca@debian.org>
Date: Fri, 23 May 2025 11:25:41 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnQwuZm4jtJNSYzn5Nf-2dikvFWb2dt4ubX7nuFsCdgDqw@mail.gmail.com>
X-Gm-Features: AX0GCFvKZMiqR5zSYTwT5bPVxYjaI4EQVjLtSIHtzmKe44EckVUskXD0JKGsz7I
Message-ID: <CAMw=ZnQwuZm4jtJNSYzn5Nf-2dikvFWb2dt4ubX7nuFsCdgDqw@mail.gmail.com>
Subject: Re: [PATCH iproute2] iproute2: bugfix - restore ip monitor backward compatibility.
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Adel Belhouane <bugs.a.b@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 23 May 2025 at 04:25, Yuyang Huang <yuyanghuang@google.com> wrote:
>
> The current ip monitor implementation fails on older kernels that lack
> newer RTNLGRP_* definitions. As ip monitor is expected to maintain
> backward compatibility, this commit updates the code to check if errno
> is not EINVAL when rtnl_add_nl_group() fails. This change restores ip
> monitor's backward compatibility with older kernel versions.
>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Reported-by: Adel Belhouane <bugs.a.b@free.fr>
> Closes: https://lore.kernel.org/netdev/CADXeF1GgJ_1tee3hc7gca2Z21Lyi3mzxq=
52sSfMg3mFQd2rGWQ@mail.gmail.com/T/#t
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
>  ip/ipmonitor.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)

Thanks, can confirm this fixes the problem and ip monitor works again
with v6.12.

Tested-by: Luca Boccassi <bluca@debian.org>

