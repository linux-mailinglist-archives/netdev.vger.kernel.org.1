Return-Path: <netdev+bounces-140571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F79B70E4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9004B21299
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 00:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F10328E8;
	Thu, 31 Oct 2024 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZsDbNY3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C1256D;
	Thu, 31 Oct 2024 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333438; cv=none; b=u8/xVJR+c/LbDwApmRDHXvVPbOg3NL1A6I2+BGDx/loKk/lEXiV7FT6jd880KxaIxPU29PjUOi1ntfgZ36zvesGcgLQP7RSjodQ4dhLaXVHgdLMEBAREfdqkvHhHfj/MY0X/E8MjkA4vn06RV/LzHcSXNyJIauUIFQTCTPhnLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333438; c=relaxed/simple;
	bh=YKX3zhBBU73yHk5ja88AV/5BL8bsP8RZQSJ4nv2FJdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iY5sqoI8g+Vx+WbLP1Y3idweoDZ2FIBSXf8IGCpFVH6y7pRA1RlQCr/E7s2uMxv3iK7KekZ/ZeQvt3ZOo6On96P4Z4r/P+onM5Y0ZvfuUw6PPGewLc6DxF69i3tLJm17ao06U3tp5R7PydcWAycf6LVogQUQkFTMKt4be2vI91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZsDbNY3; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e390d9ad1dso3035917b3.3;
        Wed, 30 Oct 2024 17:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730333435; x=1730938235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKX3zhBBU73yHk5ja88AV/5BL8bsP8RZQSJ4nv2FJdA=;
        b=ZZsDbNY3q9PysemmQyY2djrEobT0Aw2TUDPnEl7HtCqr+lX5rUybtDbiLZA1MO+KdU
         04miHaKw3YVCZkG+KOwx6TBIuv53ngTlJpoJff3d/51qIT+MvPcMWPYjSbkoqLViGDxG
         vxRrPR4mlw0fWiLQ68jt0PBmJYaHqgWt7ZRcfUuJBFK+NjvAsEnmwUV4luQVltlCF/4Q
         vLSwtXR3zDPNy1hidR0UzQg9lt5dLXeTmhOJXkquhMSMPNB9sFZxVlvzpCZlw2iAZ9bW
         5NSMkmUb5IuOsqO7OxwWkkeBNNc+39CWxHBWHgz4AT5AtZ9fUkzIzEnu+skJIz3mf00x
         cGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730333435; x=1730938235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKX3zhBBU73yHk5ja88AV/5BL8bsP8RZQSJ4nv2FJdA=;
        b=rgOMePpBfJHnVww/dA9BA6/8ZFvAkGCK2UQ5ZG8rBw0y5Ep+jxWTEoa3Qnmui22gsM
         sxwu/81HzK+uLi6B4W64KaVA0UfqzmXEW2DAEKx+m0Sk1KmkH8sftrqYJeyvdUFNVDSf
         oaeUPHRQXIuQGgzbL6QdUQy8fuFrUQVO+DbjZlP3x7JBQhUaFTEAX7OVBmjw0MNn/X64
         hu1BJDJSLtfPcWh2Kji9+wtopJhTGoLFVOBPPbgh2zEIB2vzqFL715KBWGRAKwW2X0OF
         a44M2UXj/fTrUX198cnztfStHEkVxXpLzS6VKOIzoURAsIchzzAR8yEhOz6/eGIN+YXm
         wnjw==
X-Forwarded-Encrypted: i=1; AJvYcCWKhv/KBgLjJBkBqXNBaX7dT7021OdLA/8cJrmhLb3J8NBv/1PN47ifq5O5ITIDIUXst+cufzUBr5seKjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8eADm9+pL2VVtRa087arQuf2kfUfL1z06i29GOOALiUBJ0QCp
	5pR9uwgmP/+lemszz4ZDei1+XvvGOb8t9DUY674ghQ1GpjwevD/Ydu4AWH7PvOXN9hDDe7L8dkV
	CiPaSqVq8EZgkpmHQP9eKnyq9FrQeoLaa248=
X-Google-Smtp-Source: AGHT+IGyA35r2L12BOIjYwbZ1SXMmVEf2xOo2igBIoj6gOnybla138Fdo/ngnRmyiAiAAyBizAzOBmAQbdDGAwvLbBU=
X-Received: by 2002:a05:690c:3807:b0:6e3:d97e:848 with SMTP id
 00721157ae682-6ea52374741mr16537907b3.10.1730333435574; Wed, 30 Oct 2024
 17:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030205824.9061-1-rosenp@gmail.com> <20241030165204.1c803b60@kernel.org>
In-Reply-To: <20241030165204.1c803b60@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 30 Oct 2024 17:10:23 -0700
Message-ID: <CAKxU2N-=-oAkSKcPOZ-dHuZ6Wa3mw=0vfSO5zyF=gSLEoD0BmA@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: mellanox: use ethtool string helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 30 Oct 2024 13:58:24 -0700 Rosen Penev wrote:
> > These are the preferred way to copy ethtool strings.
> >
> > Avoids incrementing pointers all over the place.
>
> 24h between postings, please:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
ah yeah. 4:54=E2=80=AFPM vs 1:58 PM
> --
> pv-bot: 24h

