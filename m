Return-Path: <netdev+bounces-128466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237FC979A68
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 06:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2520283987
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 04:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F101F61C;
	Mon, 16 Sep 2024 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifqusb1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00701219E0;
	Mon, 16 Sep 2024 04:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726461492; cv=none; b=E+I3s7vK5TWlg09IJRi90X6BDpzV8LaWlolNMysPIXMv9KiMhIbgUhBKEu3eYoUnhaY700LlGBs0wykBHdFhAhfyQRQdeCUfh+jvVLlfHbF1zl/T9vZdUK5nUVZw+2MndZNQPa7Q5la6x7XSaE48Qmv42E23R5r+EvcCGaU7u2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726461492; c=relaxed/simple;
	bh=3lBp+2pb1wuUk0nVz9ny6tt2Y/t0MezoihufLcbBgTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOGxz1T2Et00nkuUS0Y/1wCAHEaoHlAUvol42FZvSVjf9Q8PjyyAVmZiNgyCIYeIfBlrOONRFMjhE4tkGmzeviOt6Erba+IRHUfEHtNVVVeke4ytCnB8feRTl8lw/31VoblXmAWkmgF28wbu2EJdotjAw9x7PSDzxZblRLeb2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifqusb1m; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso3141513276.0;
        Sun, 15 Sep 2024 21:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726461490; x=1727066290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lBp+2pb1wuUk0nVz9ny6tt2Y/t0MezoihufLcbBgTM=;
        b=Ifqusb1mkOVjh9lG39hixKPOkRpysOLiOphsYJ3ZP7AV8gzAcl9nBmw2USolmQcFwn
         2K5WgFtZ1lk0KKlrTyWEU0jpPmfg8HxeLOieR9F6DGI/olosPi34JMoLeROBZ7Vm6dxh
         v8BwUwlMfEtku6A0V7E6PocmkL4CJ2s4Bq6TwFK4y+c8fqZ4cOd8KBU54BehXTH+dZPa
         9rfQ9XW09GEFraz4nVM0wsUEnClLQbwGM8/dsHQ8f3j5QFp9B8FsXn9bq12HaT6vMsFg
         aqHLUllsWNrTDiyTekDwLuuwKqDepytfZPeBO61rjTFDwsimOJoXhDf9GHbYicFSaoys
         6Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726461490; x=1727066290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lBp+2pb1wuUk0nVz9ny6tt2Y/t0MezoihufLcbBgTM=;
        b=mAKBrPDTBjeQjNmmfBnTarVThFo4K5fuP6wjVFaqcYZ9+mWKV46/j8a9UlEDVooYmN
         Cok6FTiZhWbDUMKUn/ejWN09UYxgLPajM7xgUTT3vRaua984iYXhxH7KIQblnKG18UJ0
         yON+Ck9c45A7nVXOf2hly83HUux7IEc1BDLY7LRhMbP7PAxCYsw9FinooTYUk7aoxzmr
         W8rlfzc8/UMJNVdQMdk0M50KkwlSCLS9OJ8wus5rOvG4V31rRD6U9+EMP9WKU6Oe1a21
         YuZVZsNA/ZkQY7hpuQpwZoHqTtbdkDqcrxSCoU8gE/L2oYXBhgB9mco+UH4wQtxD/obO
         xHIg==
X-Forwarded-Encrypted: i=1; AJvYcCUq8JBSQoldpa7Ec1cmI9gQLqRWL/I2NaPBK0q/cm5OV29ClrdKoypTedlgK97QVVagEffikot1@vger.kernel.org, AJvYcCW+vlrqgE04t5ZUau5EyetkOxVu4bYIylj94tt1QKt/WgpAnuSECvaSlgdH+pNw90TbsXWWM+2HzyjUqRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyst164eTK/vEpGbHZ5h744/X5LNE7wKQLq7VATFye6UEGqwCZF
	C/Nt5QKIc5PAqHZ0eC3ko7wvC+UldynvEiiHYiesqMIfwuoQBOel0p4SQ93s+jEJ0Nj3Cx4fN7E
	VTo/HfS5x67m5tkOPsEiBgSavEjg=
X-Google-Smtp-Source: AGHT+IFdFxXG4xXzYP4XyT1SVsLgMVXqUzTF5BajwwmdMgRAY3sDuu9X7DcFo6ExslUJuVv9bW4o/BJRgqWe55yZkLI=
X-Received: by 2002:a05:6902:2081:b0:e1d:1c63:e3d with SMTP id
 3f1490d57ef6-e1d9db9bb37mr11580102276.6.1726461489837; Sun, 15 Sep 2024
 21:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
 <20240909071652.3349294-11-dongml2@chinatelecom.cn> <20240914093045.GE12935@kernel.org>
In-Reply-To: <20240914093045.GE12935@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 16 Sep 2024 12:38:21 +0800
Message-ID: <CADxym3YEirW=Rifx9xxBDw+w2KHq74PCdXpahCc1nU+9zR_i2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/12] net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()
To: Simon Horman <horms@kernel.org>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 5:30=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Sep 09, 2024 at 03:16:50PM +0800, Menglong Dong wrote:
> > Replace kfree_skb() with kfree_skb_reason() in vxlan_mdb_xmit. No drop
> > reaons are introduced in this commit.
>
> nit: reasons

Okay!

>
> ...
>

