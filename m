Return-Path: <netdev+bounces-215501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B41DB2EE0E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFDB1C2326B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CDC25EF9C;
	Thu, 21 Aug 2025 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPHMcxYK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EA25BEFD;
	Thu, 21 Aug 2025 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757117; cv=none; b=RT8wyrPjyjoQ8nbCBa/359j3K2/Q0dcfFVG1sxozRlWlTRgeWtUCcZWmPfg4BZ3yGp7RarRtdiActB11qLWj+l5Fhuvcfj+bwKgklNqznkIcTwrr9JR2c/aXtAu1LMyerR/PSMtZ7eSucpddTJN6MA3AGFpcOZKJ1DJU5s+e8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757117; c=relaxed/simple;
	bh=Bi1fwnl9yUGn7Fca+mMWIkXWwgXtyoTjKasK8Wa5i+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rv6UsfhIU7H4ngnbF0YC0HQpND6S3NFYRJPiQKy7r87Y2ATxXoO2GPGWLSfO2nrM7ZdrxsO2cO/3EyUOVmM/kBrAyAQT7pcjxb9ZuMu4Jz6sJsg4ekpc+F8kbgcDjU7oszRENFd+f3b876sDGX3R4tpwbUaosF/d9fluRigZVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPHMcxYK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e93370ab8so699953b3a.1;
        Wed, 20 Aug 2025 23:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755757114; x=1756361914; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zztoWmaSBvqb0v836T63J5CDKtmGeRpJXnzAG/6LZ58=;
        b=WPHMcxYKgtSdcDVZKxRt8c+Cm5la+XpvdfcAxgmIAFbUYOaijbMxKSeUaUNYFHPDMs
         pPtbKXmfy/yFpBuTddS5i8kjxdNdnjpNkREfaIgUyUS8/2NQ8B40cCjdOgWCTKWw9Q5+
         +Y8jjaBXB8oYtYuXiY2nD98Xtv/ibhcr1VQkrmbkQQ/rNjLPlVd68jH/Z6xbTl/sm5NC
         FOiO2zfgiqS4OeSd+zmzvLqKefiVYMBYcFFSfPxLEsPKl7FCQPmbLdiJBa5uPNlZgDwr
         pYSIoOwBF0oOSZuPFujEKAZG7t7GpKaRbEBmsJSnuG74vDU8yGRMZFfOeaDWvxkRnaZ6
         JD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755757114; x=1756361914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zztoWmaSBvqb0v836T63J5CDKtmGeRpJXnzAG/6LZ58=;
        b=TReoyyccjHPx85eE5e1kw9oUXFyEyEPWmYogggZhrYPYQAxIAHuVntruEPSd0RnaBL
         FerzpVcNmmrLcHnN5DwPLOD9w/Up5nHeVwB48nZaGTDS1ZZYtJSFL/bC9/P/51YBXQuF
         Ky3z47utKSmcUuRqYL6oe+ukfXfSilXQQFBbR9Ibn6tbDwBGBuQF1O+UFFHG9s+sZJoS
         iidLPw5/H1eTV3sOjYKTUAsXJKtBCxZyAJYmweqa2HSX9DePnxBqSuyAJsqUDW3z85wu
         DOJHvLnXAKmUAkOhloj/GgtwDvUFrRjLlZS8YVMn87i33y0/icUnzMDhUpfZsjFX3SoF
         3XRg==
X-Forwarded-Encrypted: i=1; AJvYcCWjD0vkgI3aoOXqPmlgpTa4WkaxrrX7WKKBRcan5dOch9VERVqE895QDk6BDMCYZ/ABy/R3LlBwYn9T/KQ=@vger.kernel.org, AJvYcCXB0T/kMivcvLozUaG4TDVmzDDCvx0BEnJbIlKkBz1ctYqf5z9xMubsibRHRhdO4N9KWpj/y+f3@vger.kernel.org
X-Gm-Message-State: AOJu0YxH8q8pSjkuyIFtksrIdJBnrtjrhzNLRuKB55DFufgAhNkHDamh
	yfigmTmaT2L3zlrL7skgGL55rz3IorzeH4KL+vskTnQ/lQNuHZHu2II9
X-Gm-Gg: ASbGncs+S6l+OBdGxepdXv9ryE9RK46j/DBhaUz69Q9x3ZljyzpKhME3obh8CxwtF3B
	wKBgOdjK686niHxT+PHqmSCCjAAEobMbXqIbCjhi+VF5n4tCT1RYDc00rEbJ/OVOAOW+h0ugwav
	ZbPwVIIxw0xsV82ihxQVStnZgJvrB5YkN8ggdKoGRPo5aciygUpmu2AJ+A/W7CPvk9Ife1yf/px
	o0SiSwjHJGZ7cDJdPmx+hUu+5b2LZoV4D72CubsOnBMS9/p4FT/I1YaMF1dsT+bHuT+LSo74y/W
	yblEybOmM6mMpxXfDcrIOsyHRBCeBRR2BEqf5uLfMdq4dRM+uYuFtpxF1yhQHRQ24GkWa1m96W1
	cxb+KH5pMFAaoTflzrlvesq+6JJjjQMe5NbvH
X-Google-Smtp-Source: AGHT+IGs7MFSfbXvQy8Flp3Dq70Rfkp04rNwWT4c3+yfMUrn/wBHUprehQHinYmoPC+kH7sQIVsbmg==
X-Received: by 2002:a05:6a20:2586:b0:240:cd6:a91e with SMTP id adf61e73a8af0-2433089f7cfmr1826634637.20.1755757113567;
        Wed, 20 Aug 2025 23:18:33 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fba4cesm3900670a12.9.2025.08.20.23.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 23:18:33 -0700 (PDT)
Message-ID: <90cc9b71e356a94e593b66614bbb28a542ca204c.camel@gmail.com>
Subject: Re: [RFC v2 1/1] net/tls: allow limiting maximum record size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hannes Reinecke <hare@suse.de>, chuck.lever@oracle.com,
 davem@davemloft.net, 	edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, 	borisp@nvidia.com,
 john.fastabend@gmail.com
Cc: alistair.francis@wdc.com, dlemoal@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 21 Aug 2025 16:18:25 +1000
In-Reply-To: <a9ea0abf-1f11-4760-80b8-6a688e020093@suse.de>
References: <20250808072358.254478-3-wilfred.opensource@gmail.com>
	 <20250808072358.254478-5-wilfred.opensource@gmail.com>
	 <a9ea0abf-1f11-4760-80b8-6a688e020093@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-18 at 08:31 +0200, Hannes Reinecke wrote:
>=20
[snip]
> > --- a/include/uapi/linux/handshake.h
> > +++ b/include/uapi/linux/handshake.h
> > @@ -54,6 +54,7 @@ enum {
> > =C2=A0=C2=A0	HANDSHAKE_A_DONE_STATUS =3D 1,
> > =C2=A0=C2=A0	HANDSHAKE_A_DONE_SOCKFD,
> > =C2=A0=C2=A0	HANDSHAKE_A_DONE_REMOTE_AUTH,
> > +	HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
> > =C2=A0=20
> > =C2=A0=C2=A0	__HANDSHAKE_A_DONE_MAX,
> > =C2=A0=C2=A0	HANDSHAKE_A_DONE_MAX =3D (__HANDSHAKE_A_DONE_MAX - 1)
> > diff --git a/net/handshake/genl.c b/net/handshake/genl.c
> > index f55d14d7b726..44c43ce18361 100644
> > --- a/net/handshake/genl.c
> > +++ b/net/handshake/genl.c
> > @@ -16,10 +16,11 @@ static const struct nla_policy
> > handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 /* HANDSHAKE_CMD_DONE - do */
> > -static const struct nla_policy
> > handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] =3D {
> > +static const struct nla_policy
> > handshake_done_nl_policy[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT + 1] =3D
> > {
>=20
Hey Hannes,

I did consider using HANDSHAKE_A_DONE_MAX, but wasn't sure if the
existing convention is there for some reason. But I can switch over if
you think that is best.

> Shouldn't that be 'HANDSHAKE_A_DONE_MAX'?
>=20
> > =C2=A0=C2=A0	[HANDSHAKE_A_DONE_STATUS] =3D { .type =3D NLA_U32, },
> > =C2=A0=C2=A0	[HANDSHAKE_A_DONE_SOCKFD] =3D { .type =3D NLA_S32, },
> > =C2=A0=C2=A0	[HANDSHAKE_A_DONE_REMOTE_AUTH] =3D { .type =3D NLA_U32, },
> > +	[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT] =3D { .type =3D NLA_U32,
> > },
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 /* Ops table for handshake */
> > @@ -35,7 +36,7 @@ static const struct genl_split_ops
> > handshake_nl_ops[] =3D {
> > =C2=A0=C2=A0		.cmd		=3D HANDSHAKE_CMD_DONE,
> > =C2=A0=C2=A0		.doit		=3D handshake_nl_done_doit,
> > =C2=A0=C2=A0		.policy		=3D
> > handshake_done_nl_policy,
> > -		.maxattr	=3D HANDSHAKE_A_DONE_REMOTE_AUTH,
> > +		.maxattr	=3D
> > HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
>=20
> HANDSHAKE_A_DONE_MAX - 1?

Shouldn't it be `HANDSHAKE_A_DONE_MAX`? Unless the existing
`HANDSHAKE_A_DONE_REMOTE_AUTH` is incorrect?

Thanks for the review!

Regards,
Wilfred
>=20

