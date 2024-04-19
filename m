Return-Path: <netdev+bounces-89633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE678AAFBD
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 15:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE231C21FD6
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EC312AAFD;
	Fri, 19 Apr 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Va2tBgle"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CD12837C
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534689; cv=none; b=ESmIY4Jk4jZYLJVe3fAww9c5fVM6+xMCjf4NgFh2nhqPZsOMl5jIj/2OIVQGvOXWE2sofT0T2BYyetdG5qOli4VmE/p3IOXQR6bWJzn8u/uU6rEhfRBlHL8Grz+yU9/HPS26ydbzuohaF2PlRG5pmS+RXl7qy8sLFB8yti9RYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534689; c=relaxed/simple;
	bh=i8/VATSt0GkLrzf23bfFCxBGT/6HZDw5j2Jq7a2HQSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlQG4TYMqwsJbBR6Sd6upGpCuj0Whj+32pxuQepEhwV6E+2EtKfkHgBWhXvuF4o1NSibYKOoNZmEOoFlU9SuUVGTipaHK5E+5Vxh670lqDJaJlYRNWa6HzUc0MatuuylpvVtBHmyWJB/pAA280fg2eKS/ZFXLFRXssNT7JnWVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Va2tBgle; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-418820e6effso59855e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713534686; x=1714139486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLc4FIIFN9550m4wWP+Z+BhSWO0cKyHD8mslPoY0CmE=;
        b=Va2tBgleH7kbwutIiUweuuY/dmoK7/3qaiN+qb7bRApJrG/JJapcrwt/mUZCwZvUB/
         d2bodoAslfOnwd+Y+eSEV/BKUSsYCs1c18yMU+jDIikGwScz8cBeDDpZq8QIre79rSzX
         RnrAZ8WvygwD9/mcP5f5X2yXQfxYvuhK75aSOBSLjPii1IDnZbb6+nyt0aGW3bxq5t/L
         5q9JkxT0jSd4fg9VbMewlRwFDrkchAo5mKwPr4gvctNQuilWwZetqCr6ATGeGxLnUH3x
         YrmH5CzN81j3wg2ycnZOYgQ+Me9nhc9bcaGLUkPlU3tqs4UBOm0apPb7t66sgTDhKkNF
         hlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534686; x=1714139486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLc4FIIFN9550m4wWP+Z+BhSWO0cKyHD8mslPoY0CmE=;
        b=BMSwI97bdQ2PqXoNxfTO7rfq/fXnfe8RgZWMal83j6zQb3865Ejn0C7DINskb/jika
         0es2avwiadOoLESbxBbEV7OV/HUFMKFmhP1T/G0pO5yWc7m7qSI/XoCF7P1mgminsVq/
         mCTFU66jOiXmV54tm+sjwGpkWCm8s/Fl79w0Vxv+1gCNnSH2wzhBpP7fPfN56OCVnb/i
         jUergJrk9F+oP9kS456qmcLkOUg4tzOqypy8VKV8+ODJDRhYL+naP1E/GPo6oD99u6Nz
         e7ditSGK12zHpJGZ4MsAhO0DrSV+EM1DcRDNVHvaKB/5XVZSQFv9ZRvvr878hgAoAdN3
         oDeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3HxJwDp9xmxZOUXBOwnJ+1/tPJAnfQG/hVgkEmOl+POynfzyU2W+N3e+kGHbbqrfKlZ9sVzPghOn5JGr6JjpD1dtFWSAW
X-Gm-Message-State: AOJu0Ywl7hsUl0fC3Cvp3HjTgL+IK6IQNNBjAWTK41uYaDdGp05jWayD
	FJBWHIPTIbPGCBkE69iwL/x/G5oe0/SUL+vdT1CWp+2Kmzmnh8p6buybYu6h10QFa2Eka6dv2vj
	pyoWXrO8zRpKMfqfiLvE7yNc9zk2pzJZ4m3l4
X-Google-Smtp-Source: AGHT+IG5DCogTdMbZ5jyM73NW8H930OtCVNmgzVDnuXAnZprpc5U+BfmJP97qmVEgEl4VgURksuwT2xdTIDMVHvQQFU=
X-Received: by 2002:a05:600c:1d14:b0:416:bc07:a3c9 with SMTP id
 l20-20020a05600c1d1400b00416bc07a3c9mr201371wms.6.1713534686202; Fri, 19 Apr
 2024 06:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419105332.2430179-1-edumazet@google.com> <20240419064552.5dbe33e6@kernel.org>
In-Reply-To: <20240419064552.5dbe33e6@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 15:51:15 +0200
Message-ID: <CANn89iKjwOfGTiHjE-JaWaxxDZVfsWzaE7AkVigHGLEPwXaepA@mail.gmail.com>
Subject: Re: [PATCH net] icmp: prevent possible NULL dereferences from icmp_build_probe()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Andreas Roeseler <andreas.a.roeseler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 3:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 19 Apr 2024 10:53:32 +0000 Eric Dumazet wrote:
> > +     in6_dev =3D __in6_dev_get(dev);
> > +     if (in6_dev && !list_empty(&in6_dev->addr_list))
>
> There's got to be some conditional include somewhere because this seems
> to break cut-down builds (presumably IPv6=3Dn):
>
>
> net/ipv4/icmp.c: In function =E2=80=98icmp_build_probe=E2=80=99:
> net/ipv4/icmp.c:1125:19: error: implicit declaration of function =E2=80=
=98__in6_dev_get=E2=80=99; did you mean =E2=80=98in_dev_get=E2=80=99? [-Wer=
ror=3Dimplicit-function-declaration]
>  1125 |         in6_dev =3D __in6_dev_get(dev);
>       |                   ^~~~~~~~~~~~~
>       |                   in_dev_get
> net/ipv4/icmp.c:1125:17: error: assignment to =E2=80=98struct inet6_dev *=
=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a c=
ast [-Werror=3Dint-conversion]
>  1125 |         in6_dev =3D __in6_dev_get(dev);
>       |                 ^
> --
> pw-bot: cr

Ah right, __in6_dev_get() is not defined for CONFIG_IPV6=3Dn...

Thanks.

