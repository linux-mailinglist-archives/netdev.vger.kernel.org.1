Return-Path: <netdev+bounces-145635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C766F9D03D2
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 13:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362002877FB
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC817DE2D;
	Sun, 17 Nov 2024 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPJzqAbx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D113A26F;
	Sun, 17 Nov 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846706; cv=none; b=cFlnWTWk7Rx6HLZf7ziqD4BcUKKDQfz6GcYkiZ7p7urT07L3IQPFK+qnU5jPMDQ0k5ZzFXb5iGQjLiGWGbecIau/YY/BjL6llkaGVQdtmvnGHXVEhtvr0MVn3LX9H0QZwGb0ta6+/nPyE8ECedkgXNz2WhR+F6a6CdjQbHtUlEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846706; c=relaxed/simple;
	bh=8mpy1YFpUhZx7lRctNz/c9Ycj0Tpag55lxJw5xXfReE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo6GoaIh5grSGXt+MqO0llzRIYfuHEoJ/BYIBra3jkWoxflQaoaCptXg79FuHaJHDfh39ixFa10l+KxXa6rXrKnRsK1EPck9jAFDhL6HtjhcU3DMf1SBC9+KKyoWty3742chNZbLHJv574+5DiOz8E7F66xTnP/y7Nl+vMhz8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPJzqAbx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso396753166b.1;
        Sun, 17 Nov 2024 04:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731846703; x=1732451503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mpy1YFpUhZx7lRctNz/c9Ycj0Tpag55lxJw5xXfReE=;
        b=iPJzqAbxL+Y6QpOMk7io9ADxUfALO5AnKa2Z6nwn2MkvMRnwbhgzydSG5W4y88f27z
         54HbHPLKmxQxNOz/bwPbhAqoPpiPQdYhzmOTTEeHcKchVev/a1fQW9McAvtdLJWkXV3T
         k/r3bjQjETrGc+4tpUEUWlc94uegcnTZByTCqDYlb7Dc75L4mMIJVgAZmxntoCXKkvb8
         OveHEroQgCKjFInhB9WCDJiW2TR+bPzAMOdLxXs1+RqBnsE99fvdchMGJ7k85HuPP5xV
         /QgSa/aAQ/YDuQag6HtzKNUjRdRhrassTaHlxVsGwPmaNaQcd6IGjcqseBlajFMIX39N
         iGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731846703; x=1732451503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mpy1YFpUhZx7lRctNz/c9Ycj0Tpag55lxJw5xXfReE=;
        b=sFhvxibKtTJrLm+krWaiNiD9DiOfvyEu9R5AEK1jOsavyme+G0WCTnKqzDnqPFNd/U
         7ZOAA277Wg1e+PtUtxBs7Qs45QdlaXsWwDYqTmXrHpzr7mFD4+ufHQABrcPHCJXLVByG
         NXwL4GE5TxjrClr94IUPVMmL+JWN1Y/3/r4zXolF4lVg+II9A/1/wZKXP4I+1i0oTwyf
         13jS8TSzJoE5GEDGkXabBQFYkFhtRU5QLP94Iqkbl20dmk3gyFC9mXLQXPNyG84HZuvk
         S0G1HFXvf91qQHtrB3Mdtq8Xodivoy0peW6nQ2Xir82ObMBqMPd9IeArJ03dmzpl1Iyo
         ZySw==
X-Forwarded-Encrypted: i=1; AJvYcCV5/1ZBjfhbhnkaEuzMPtS2pTc6HUKtr5vimjG38+vzDc4J22qFnoOFa5Kyd71PMQYTDsz5JP1+@vger.kernel.org, AJvYcCV8HvdGNLVstLl1D6JtSQZVXwGNvDlSVBAjTo3f1che7/MxyrjtEinGnL03XdUC0L2EuAmoLoXXruM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUrVJBOoGZJ9gqhUa+Kg2INC4jgCmrbpUzd9vcQ4uZ0n5ltLW
	zbuYmtRGAc5xSEnuEW3rWfk3cbo4h6aFYMe2133L5ENyx0LzQWQV4vmiYUfSZzn7glPhi1pkx9Z
	3YHPnd653dBbXPBgwZDPdOVgGRr8=
X-Google-Smtp-Source: AGHT+IGx5svWJev5BcS2Idk9LLR+jvZi5g+xp8T6kZ7lH8xCcH4G2a2VX8hG46BdY0RbaZuB0VtIsAyS48JVY6mZHBc=
X-Received: by 2002:a17:906:da84:b0:a9a:14fc:9868 with SMTP id
 a640c23a62f3a-aa4833ec172mr932783566b.4.1731846702657; Sun, 17 Nov 2024
 04:31:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113173222.372128-1-ap420073@gmail.com> <20241113173222.372128-5-ap420073@gmail.com>
 <20241114202409.3f4f2611@kernel.org> <CAMArcTUfGp0SEm=w3dg=GHd52w4zw2kG7mGLsaP4b9NjTYMTrw@mail.gmail.com>
 <20241115111850.4069fdb7@kernel.org>
In-Reply-To: <20241115111850.4069fdb7@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 17 Nov 2024 21:31:31 +0900
Message-ID: <CAMArcTUt9fuWy0BB3o35COr4ToDDtaAHB8AT-3sB+L-6cCyUgg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/7] net: ethtool: add support for configuring header-data-split-thresh
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
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 4:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 16 Nov 2024 03:05:33 +0900 Taehee Yoo wrote:
> > > nit: s/_HEADER_DATA_SPLIT_/_HDS_/ ;)
> > >
> > > We can explain in the text that HDS stands for header data split.
> > > Let's not bloat the code with 40+ character names...
> >
> > I'm not familiar with the ynl, but I think there are some dependencies
> > between Documentation/netlink/spec/ethtool.yaml.
> > Because It seems to generate ethtool-user.c code automatically based
> > on ethtool.yaml spec. I think If we change this name to HDS, it need to
> > change ethtool spec form "header-data-split-thresh" to "hds-thresh" too=
.
> >
> > However, I agree with changing ethtool option name from
> > "header-data-split-thresh" to "hds-thresh". So, If I understand correct=
ly,
> > what about changing ethtool option name from "header-data-split-thresh"
> > to "hds-thresh"?
>
> Correct. And yes, you'll need to change in both places the spec and the
> header. FWIW Stanislav is working on auto-generating the ethtool header
> from the YAML spec, hopefully that will avoid having to change both
> places long term.

Thanks! I will change both things.

Thanks a lot!
Taehee Yoo

