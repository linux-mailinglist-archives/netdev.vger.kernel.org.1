Return-Path: <netdev+bounces-150990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824AD9EC4A2
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269CE188AC81
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AD51C4A20;
	Wed, 11 Dec 2024 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="PrvgVu7w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B01C4A02
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897570; cv=none; b=nbtpiunI5Rvfn0FQGSyWOvZP6Iic6d+KLkv/UDgbqmXk3/Mg1Jk2UhZ9WV4JQeIaqLSDIVtBne9Qb4hfnhCznL4Z6aFytLznesTOU2CQ/jGIoDz30RZQlkigXI+qfxDuyDXu/X0mo8UyAZFPhUqGIYR5loNAjGKJ+ykFSzN5bf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897570; c=relaxed/simple;
	bh=tV4UQ+BiBM0LFw+r6S1cE2/jM0gxNLnQ+tmkcQGE0Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEBIHoZkJmNJdkOsbIDHk9v0JY2LPbZqJNld6qDxHtWmYidQ5CbQULxdIUgJ977jdUTbVx7DkZHIXMzNDAzju4RwBPd4NDPd8QC815Fwupwg3sR32CnaUd7b2rwCKs+2hn07+t663koie6gdHemtNuiXibTvnm56BLQzyU7mi6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=PrvgVu7w; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3985aabf43so4845749276.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 22:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733897568; x=1734502368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tV4UQ+BiBM0LFw+r6S1cE2/jM0gxNLnQ+tmkcQGE0Y8=;
        b=PrvgVu7wsI1loz/dG3lnzHdrm1DtWCDMfnrK6lZFlAUphoeyoufOxyNG5BLQTXu0kO
         /nvX7I3Ndni+05QL3bzVbw0FRrzWHJHP8x0MfTYaJX3OehF0Ek2F/P0N6joFjytyXMq3
         GXDdfdisx+tfFE0uyFy2rkEyYBzKtZ6vqps/1CL/i1G587YZjE2oZdOQnacdosWVp1YE
         O2fXV+5sMJv252UspI/82U+efCtCbJI/wzQe2Htt0/ZotKmhTex1f57mrZwc2xzUk/0C
         sY2BpyJuoyED6Mquyg8zZqYd+T2vOmXiC5ArdwC8B5lAHD0Xx0M6ZMxu68lJi2htMG4+
         c2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733897568; x=1734502368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tV4UQ+BiBM0LFw+r6S1cE2/jM0gxNLnQ+tmkcQGE0Y8=;
        b=s2NzmQ9BIziSiyh+h4YNQP3OD1DUKZXtnxfx70FTNA8wBYnH1V6ZiMA3uhfzRkkafL
         xlNYquNVF2vu1EfBoGxZxv3Bk3PNL3DV9wOe0/vxp9aN/G7wuS42wm+t4zx8GVD94eej
         uftYfz5t+t/yJaZLrYBMVUM4xkLTsBcm0hDt9aC4FPUWm9lgfOThI8/hUeNKNJpHdBdO
         v1CUDe0OOQg2mYYFVM0M9jWvGiConnmbKDP7ZbZQZwrf0fVposhgTv3Phj5cXc/OlWhr
         6OkEJutUYx0WbWIavBy0IJy96Qejnxl3WpH2SZ3nshok1SraD2BW8HRAT7TBo8HOK2VE
         tuEA==
X-Forwarded-Encrypted: i=1; AJvYcCX3zEHHqk0nakE/YRtK2XyHjiMsaqTe2wF/c0x9Nwf38sTtdpDC2uyQKKsQyCEgtUNGEmqJ7Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUYgKgvSIJNFrgZ402VdjckzAB1W31swHJ43Fum1i+9o+Y4t1
	dR9cnInDPprFke++vakSTRWLqSLvKidBVryx7TcjSs8tCTyXnX4hdWL4dqQrkJ3hER1KS+BoiSp
	+oX+NdsFkR1rm0YUS+/dO5y5dQJz9nAXgomTVNA==
X-Gm-Gg: ASbGncv/jwQ1SZSBtwSOUM9Oq1VHHaqTfeznRP3420wu7NxCnQ/1uTE92KRNNxhTbBE
	xJlwxknOvS9g4Nl/mt91y86BzCaSOW87ZWeo=
X-Google-Smtp-Source: AGHT+IHtV2VjryMZleS2mRSEmzy29u4HImGox+Xi3owB9rCNEZ8dtJvHQ7OnZGiommLp2qXb62xl05JUYnr18r9opE8=
X-Received: by 2002:a05:6902:70b:b0:e3a:398f:6720 with SMTP id
 3f1490d57ef6-e3c8e67c3cbmr1977245276.38.1733897567797; Tue, 10 Dec 2024
 22:12:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201074212.2833277-1-andrew@andrewstrohman.com> <Z019fbECX6R4HHpm@nanopsycho.orion>
In-Reply-To: <Z019fbECX6R4HHpm@nanopsycho.orion>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Tue, 10 Dec 2024 22:12:36 -0800
Message-ID: <CAA8ajJ=UYjqVkvxKDTQNpSWpz7+p0+0Ckavpotkh5qUzd1qc0w@mail.gmail.com>
Subject: Re: [PATCH net-next] dsa: Make offloading optional on per port basis
To: Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

 Thanks for the review.

> Why is this DSA specific?

I can make this more general. I'm not aware of potential
users outside of switchdev and dsa. Are you anticipating
additional users outside of switchdev?

I could make this more general, and just implement
for dsa for now. Then later, if someone else wants
this functionality for switchdev, or something else,
they could implement that part.


> Plus, you say you want to disable offloading
> in general (DSA_FLAG_OFFLOADING_DISABLED), but you check the flag only
> when joining bridge.

I think it's only required for joining a bridge because
that's where dp->bridge gets assigned. All the other
offloading related code paths check dp->bridge
either directly or indirectly, to determine if the port
is offloaded or not before continuing. If you see
an offloading related code path that does not
consider dp->bridge before moving forward,
please let me know.


> I mean, shouldn't this be rather something exposed
> by some common UAPI?
>
> Btw, isn't NETIF_F_HW_L2FW_DOFFLOAD what you are looking for?

It sounds like Vladimir doesn't like this suggestion. So,
I considered introducing another netdev feature for this, but
I noticed that we are currently maxed out since
netdev_features_t is u64 and NETDEV_FEATURE_COUNT
is 64.

I considered changing netdev_features_t to a bitmap,
so that we can keep adding additional features, but
there are users doing bitwise operations directly on
instances of netdev_features_t, so that seems difficult
to untangle.

Do you have a suggestion about how to proceed?
How should I signal that offloading should be disabled?

