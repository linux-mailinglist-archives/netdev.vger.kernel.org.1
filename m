Return-Path: <netdev+bounces-153356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A69F7C34
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120E7188FED0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DDA224B1A;
	Thu, 19 Dec 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nql0yMou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42259224AFB;
	Thu, 19 Dec 2024 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614679; cv=none; b=aH2o1Rc4dlTOMZAulwH1HGjm799GXkaJIC2Q5mxKuggCJ0Qmhxmu+NFf9nZq8FJF1QRR+xnS/0RboY80lOUd2D8vKry9xa2yZXlKgDLFKsI39NMxNd09Gnb/xyqnYTdhUxqHFHt6oewubsX1yBXAFO6LcAkbpXIucLmF2ziPQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614679; c=relaxed/simple;
	bh=008Cuml4VV0XwHTtpe/8/yoaehcR1dfBgfpnFS4iO+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pp/dNSzwcUDyRn3wTev8tiOGUdEfguzeo4TMGT3aEfjtX/jyJP45Y9DC12S45qb0aNBVR4rEzm+df3b81eUVBJq1b+8JYCniHPVuYp6w9Zkt5VQHHbI6JAC8m0xD9l4nUnD37jQ9k0JkJEqc7SP75HBbxI9BPpBGvKJoaQQJ1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nql0yMou; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so1344595a12.2;
        Thu, 19 Dec 2024 05:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734614676; x=1735219476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeDNOULIpeV+rcdYvftKVOa2BlVHQXHEyE5QaiwBOAY=;
        b=Nql0yMouGbYYKhyt2HUwNpzmYuF7Xz+ntynZRRjRS67XSLral/6rqXeuTsOJSMAjQV
         gurQckoTJvwl1C782q9OewHQde/v6a8iagc3AHsBAXUtAPLTSy83NLJyEsUjedLq/0V3
         CXkAK7V4wBvDDQUMtfK54COsQ+ofy/84D2mc4ZpIM5yDuJ3Xyi7wI6tymZXbiuvUAOII
         1TzLxAdOb4R5Fic3bWMhg/4WfALLd3vnevI7954Ffi7B6OgP6W7+ugZcNap0Bjiq5Sna
         /s9iYLMgWHzgEoG+A3Nygm6IhQUbtqCoIrwkVIGnusApl5Te2csjYDF3ftoyKaLaDRvX
         s1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734614676; x=1735219476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeDNOULIpeV+rcdYvftKVOa2BlVHQXHEyE5QaiwBOAY=;
        b=FiSXNEGZMQyuCfE1loEaImuJtp6FCFqmyOY0M64Wp7weS8iI9PWlJ7s+mZCezQjmr4
         PzzHSLgqXXDsagLTHU5ZbLOmPg6eIVujtEE5WuPLGGg7zUT8pyx6llGfBH0yyHElcPMe
         /l9QxwXyCd1aqRXWSapFAG163Y6+g6SbXXBYcxQVsh/SUEYm8V0CrNxTcjBD3uD3dT7H
         Nv79862Ce/hFB9awboYvOrtDk5A0QNBJosTSXi6mP7boEr64yP4K80HIxNs2wS+0Jd2y
         t9BbRF3KqHlzAroH5naLNz6iM6d/m+vivOblh/5723H3IIsIHy3xaVHB2IFzp26Ls0/A
         Ot+A==
X-Forwarded-Encrypted: i=1; AJvYcCW+l6h/x4FjdHbtPbzyqbXwjj9fj81wfpDL96UHfJ9tuAGIfFBHyA8rbf/1ZGdAIEZHJLe612s7GVw=@vger.kernel.org, AJvYcCWSa3SFl97Y1RbhsH9meZ0tbO4LqCVuYK/o3kXKd3EF2NRoy58PrkmT0RYYcHTh75B1c8xZjhgj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz189ZCJFewB3M/0KO3C7wFHIy8fxCJs+ANrSR8kkCuCU1Xo4j5
	YA1cJG66xnyrpfR4APh7E7+1MTpvgsb33DkvDhxa0qF9SiIuhYCyN7VUpwLh78BFuoSkuAMKn6F
	DwFJbJLyI7nOL/1Dzg0Fj8VLIt8E=
X-Gm-Gg: ASbGnctQhUtcCaFw3BSh21XPViw1m+YG6ZMPHiR5qfesEgNdiXa4abkhJVNZak5AzBe
	kdwA3wLAQQU5lXy+grwwM9NEX2659plNGNuPsA+s=
X-Google-Smtp-Source: AGHT+IEfarcEFPeyiK+8xrhOtld6iHFTaJceEIQ7GIAwZAzOISdIVEOnPv0cEmt8NMfi93SWIQvGXg3ZOKSbLsYNJ+8=
X-Received: by 2002:a05:6402:2709:b0:5d4:35c7:cd48 with SMTP id
 4fb4d7f45d1cf-5d7ee390bb7mr5500754a12.9.1734614676252; Thu, 19 Dec 2024
 05:24:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218144530.2963326-1-ap420073@gmail.com> <20241218144530.2963326-2-ap420073@gmail.com>
 <20241218180747.1ff69015@kernel.org>
In-Reply-To: <20241218180747.1ff69015@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 19 Dec 2024 22:24:24 +0900
Message-ID: <CAMArcTXfNwYRxA56OCBgGe8thXMMFS-8rD3RYRUERccrvBuMZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/9] bnxt_en: add support for rx-copybreak
 ethtool command
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com, 
	Andy Gospodarek <gospo@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>

Hi Jakub,
Thanks a lot for the review!

> On Wed, 18 Dec 2024 14:45:22 +0000 Taehee Yoo wrote:
> > +                     if (netif_running(dev)) {
> > +                             bnxt_close_nic(bp, false, false);
> > +                             bp->rx_copybreak =3D rx_copybreak;
> > +                             bnxt_set_ring_params(bp);
> > +                             bnxt_open_nic(bp, false, false);
>
> We really shouldn't allow this any more, we've been rejecting
> patches which try to accept reconfiguration requests by taking
> the entire NIC down, without any solid recovery if memory allocation
> fails.
>
> Let's return -EBUSY if interface is running.

Okay, I will change it.

Thanks a lot,
Taehee Yoo

