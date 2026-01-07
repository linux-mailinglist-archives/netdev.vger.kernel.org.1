Return-Path: <netdev+bounces-247673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5455CCFD328
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6107D30C9B1B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5653191A9;
	Wed,  7 Jan 2026 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpbbNCJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7631690E
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781505; cv=none; b=tIbcbciUOn7HLazQKx0ulfzlkVrALFGl/d26hkaCVPZdwvPoleuwU0WLnEDfkNOEMd6GiFn+6fxfvMQBrhnN1yJeNyrnQMGUec5AXmZbqXyLFW83jIST/50THT74QNXI/qA+ykOpf/UWhePw1j3xBL95UVomzHhN8JcA7i3cox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781505; c=relaxed/simple;
	bh=cTvGRbomyBZQnV+yZJHifvwVeWf6GxW9l/M7+SaVQ2o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=emjuEe+YwE+bbM1yXvPMEG22tfjjbYhGVR5HwRQloB5+G0yWq2SWFgj3JT3snKqpR9NXYsjkNdF0RDM0Xxq/KowYY/xrs4MvhLssMCw9YJWZu24IgbsXDf+RRkXMJCSrc3hrOSXvWrNdwf+sbdHdfxPk6hphdVVGenwiQcbYTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpbbNCJC; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-430fbb6012bso1440496f8f.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 02:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767781502; x=1768386302; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cTvGRbomyBZQnV+yZJHifvwVeWf6GxW9l/M7+SaVQ2o=;
        b=mpbbNCJCym1xp3J55yz6aR3xDa6yBTQlmdzgymRat9v7XDiycm87DpKC40ci5BCu9g
         ag19P4JcJw1rNVmgTc9o3rQ/ibEf11kcuo6Mm6kZ3o/sdqAWhZoIYLZg8LqeEErF9OKD
         D7YoqWl+LXz8KqCislrZo/b96GooiJOT8HMMUtXFgQ7JdtOZgT7jM9ZWmurhjrdF43WR
         +1QD5wedOPq+k/+L3IQOKJoUanJGnQNjG8Pi+3AIe6v3rV1s3URBNGYy4momShxcnt3D
         O/GCw9lJBMSPwtROFFS97VX7eHO3lAjGwJE4KQpBRDMT/zNVJlYv8/v8aZmeqnJ/KqNV
         TwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767781502; x=1768386302;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTvGRbomyBZQnV+yZJHifvwVeWf6GxW9l/M7+SaVQ2o=;
        b=Nbwj3kZqJS4nUZj/8FyueHV1kDtRhA6Cb3fk/G6RT0HfuSnpBjceX4sdfo0okvFCUz
         vmlWFYU/vDh/UWRo5s3fD/fNroFHeBK9eDjDtU0h4FaLEJY90PqzfRumma7b9p19vr9g
         8Bk/M7Orc8Ag+XmtWzNxqGIR0bloHnxwdvpnw1aJmKSc1p6KXkOAn4yHAIUlmClhBz8L
         Q9GIlZDHds2U2q69OjByoCyAzcGRW+hgYz6pUhhmZlN1yu9ZZQgqpM5Ph584y0VxpLUn
         G+QGkTOGV3IMfwuwiYNVOOadrRho1JRRYCaDYWAgNf18UDWOMeNje5rxp5fNSKVBCZUI
         YwhA==
X-Gm-Message-State: AOJu0YzZd/rVenLs3v7cKHafUYmhgi3QLTm/Nx1Uit6UAJ99f70sXpHI
	u9ZAeadum+QRWecV3zk3ygT8B6HLxGxdGY48YavKsMIe6ySbyY7EzIQs
X-Gm-Gg: AY/fxX4Jznc5d+NLm+QkmT9nJvU0X19/C61ROSjjXf2U+ZzS2glhOQmP1flziIYmJ0O
	ZFM3fLj+mTSnni8KqoBP91m9fjobWyIivEG6FX8XbA0qSDP2NFDq0uajZn1Yweq0KFtcQS8/Y2B
	wFUuHGS1tROi3csSE0IhRDQ3X5Bxp3sjRvM+WP2nB39HRi+558KmtxxoILx83xefVT6Ox6OJcpl
	hYH2uG/yGcEizlbOZzLcbiArsI56TT0XVIv58EnX+bsxObm6c7fSVQ45OdamyfwFBK+vdg3djwp
	bavxyt85wPvx4GdFiXBUwxQitZKoRvO82yDWvyoZGjMAFo8Swrkhn0qC6/S1AIWjEkhKd38VFEp
	A//VnakJeV4tkv3aWjTq8jylIiB0acGR+3cmqiQV0kT3D5qnsR09KrbUkVVAEzfp+ToAM/eWOPx
	s/60YUiDFMhoJtM7NZFlg=
X-Google-Smtp-Source: AGHT+IHjhtmQPgtjUxH7G5aqK4V2+BWaRftwiGSeqgLK0QdYBuHzVzzSrn7JqQF0ls+ysYMxHM47Dw==
X-Received: by 2002:a05:6000:40c9:b0:431:48f:f79e with SMTP id ffacd0b85a97d-432c3775b58mr2421958f8f.25.1767781501603;
        Wed, 07 Jan 2026 02:25:01 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm9351598f8f.39.2026.01.07.02.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 02:25:01 -0800 (PST)
Message-ID: <0ef03e2e1eb383eb0501d000704333f850652a4d.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: adi,adin: document LP
 Termination property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Osose Itua
	 <osose.itua@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com, 
	jerome.oufella@savoirfairelinux.com
Date: Wed, 07 Jan 2026 10:25:43 +0000
In-Reply-To: <20251227-perfect-accomplished-wildcat-4fcc75@quoll>
References: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
	 <20251222222210.3651577-3-osose.itua@savoirfairelinux.com>
	 <20251227-perfect-accomplished-wildcat-4fcc75@quoll>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-27 at 13:29 +0100, Krzysztof Kozlowski wrote:
> On Mon, Dec 22, 2025 at 05:21:05PM -0500, Osose Itua wrote:
> > Add "adi,low-cmode-impedance" boolean property which, when present,
> > configures the PHY for the lowest common-mode impedance on the receive
> > pair for 100BASE-TX operation.
> >=20
> > Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/net/adi,adin.yaml | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml
> > b/Documentation/devicetree/bindings/net/adi,adin.yaml
> > index c425a9f1886d..d3c8c5cc4bb1 100644
> > --- a/Documentation/devicetree/bindings/net/adi,adin.yaml
> > +++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
> > @@ -52,6 +52,12 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0 description: Enable 25MHz reference clock outp=
ut on CLK25_REF pin.
> > =C2=A0=C2=A0=C2=A0=C2=A0 type: boolean
> > =C2=A0
> > +=C2=A0 adi,low-cmode-impedance:
> > +=C2=A0=C2=A0=C2=A0 description: |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ability to configure for the lowest com=
mon-mode impedance on the
>=20
> Either this is ability or you configure the PHY, as written in commit
> msg. The latter suggests that's a SW property, not hardware, thus not
> for bindings.
>=20

Looking at the datasheet this looks like a system level decision. With the =
above
it seems we'll actually use more power and it is suited for designs where t=
here is
common-mode noise reaching the phy. So it feels like something we would put=
 in DT...=C2=A0

But I agree the commit message (and maybe the property description) should
be better in reflecting why this is used rather than just saying what are w=
e enabling.

- Nuno S=C3=A1

