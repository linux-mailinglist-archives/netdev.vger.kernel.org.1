Return-Path: <netdev+bounces-145347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5529B9CF27F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96451F21F7F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C71D5CEE;
	Fri, 15 Nov 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqsH5gTV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6081D54FA;
	Fri, 15 Nov 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690753; cv=none; b=ILN4aLjCgGwBG0gCxcJZsb0XQ/JsCH06nDyTO7G8gf8oZwjGKX6wFjuwcs2hCgRWe9Ft+efD5cLKiExCCHvMUulyUMGYHNSb7qa+ARP2x8ZSEcEVV7C5NwyQwJ3Z2VMR47an+KwLG9dpKkL0a6Z9mgiRAfjfR3GM/v4faTE/z5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690753; c=relaxed/simple;
	bh=bhB0gzg7ULcR6uels+MV/k4I/DvKzdJ2mBUQeZLSbjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9Ok79LFIN0X6MMH2YWOu5yGIJ0aHFJDK/8zz7CG4+BKfgGM5WMrtO+/o9AQzReG5si+iG3YxhXr0ayOMVvuN8QPhOQj9ZBc1HSqHV/ANILI+grLVXB4HT7sGqEEjriKREVifCpO5NVtjipvxLwwQYNtm1KRHVZXe4kY5zBe07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqsH5gTV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so3377290a12.0;
        Fri, 15 Nov 2024 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731690750; x=1732295550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhB0gzg7ULcR6uels+MV/k4I/DvKzdJ2mBUQeZLSbjw=;
        b=GqsH5gTVn6yJG5A5kmAXPChmPtowGIHck1UBUvyqYnyxCyJvh6G4abiM/lbpoDRPlR
         lmYZO8hJqD5y3NrSp+WiwLLj7UJzJDVlvsBNlbUGsxQguEUi8dMw8pBYIgApcATbxv4A
         8sDB2E+589J2rmZEnE+rSboQNAqlxoBQ7M7Hx899eLXe0aInrq2q6i2fNWS6Op5uweai
         zPic6tjD4JsbUhChXgLaVm8JMhkCDcD0GwMCu7dRG1wzayMPLsAYxmJmuI6BXBrosdXR
         AeehMZrUpt5FcpkuFvn0axgi7QFGOn+OP1bCCuhsYF3YH9EMCY6nitSYibECBP5pflPu
         tRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731690750; x=1732295550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhB0gzg7ULcR6uels+MV/k4I/DvKzdJ2mBUQeZLSbjw=;
        b=q5tvM+Q5M8DUKj6chx1ctW236G6/R2GcXP6axK4pf68O1VaiW59RdSuj1SojBlr3n/
         ac9tqueD5bKdLfJcr8sg+97cOdnZ20dHVGMQY1FrtI09nkvRIATC6Lb2XBMMX2feRxLs
         yvRvEPXhblBOpm4pTpeMPK2/hWqyUz0JpocBSB+mbxG2JHpeAfytk1e+92jHk+FgnF5P
         d3egLw8sTfVkWjrFpVgODqQrYZZjdduZ79A0NdPGlPfBh07GZcsMGXAOipCF767mHSHn
         O1j82jpa5nNniwdxGyuMo0m3/eJBntL+xPds0i/8nwGeE3BNmt+nD9EL+bQczAIFlo5U
         rHFA==
X-Forwarded-Encrypted: i=1; AJvYcCXegcTgjVOj5tDJYR9Qqg04Qkz3GyCWbDepw3Y2jr/2BSYHcpaCkQ8kOSb/FCY9gMNXY9qVr+wlHWk=@vger.kernel.org, AJvYcCXtx4Lz6w/kWXOdpWfplMW8u1pI6Nt8ab/kk8MiDoPnI89jvIISB8tWVdm7ZyJiYGwoztph17ik@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHm8RxVLBFiwKidG4CtzDn4qLXkcYYTHFiCPU8UOxBnh8mMwg
	EWlLbcWXJ/T3ZU5q8//3UP7OnID8GLXxhwL3L53noH7ZFN2mFPeBNCEdJlp+8uAQ4FmkSFT+Zi9
	I55QnKKsca8gsAXi2+datv0aVkI0=
X-Google-Smtp-Source: AGHT+IGeQO9JrkrdGz9qSWb0eysHt0WKJLPy+8e2aMyIG/zcrHg2ZdPgrY8XJzyo6tnNEBbGGetATPKg9ON+TfTyF+U=
X-Received: by 2002:a05:6402:2807:b0:5cf:8449:e757 with SMTP id
 4fb4d7f45d1cf-5cf8fc8b6d8mr2585660a12.13.1731690749470; Fri, 15 Nov 2024
 09:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113173222.372128-1-ap420073@gmail.com> <20241113173222.372128-4-ap420073@gmail.com>
 <20241114201529.32f9f1ab@kernel.org>
In-Reply-To: <20241114201529.32f9f1ab@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 16 Nov 2024 02:12:18 +0900
Message-ID: <CAMArcTXP0PWw0DEXzW5u7to8S9rUbcyc5dLOR_ZSE1H2VzBXFA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/7] bnxt_en: add support for tcp-data-split
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
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thank you so much for the review!

> On Wed, 13 Nov 2024 17:32:17 +0000 Taehee Yoo wrote:
> > NICs that uses bnxt_en driver supports tcp-data-split feature by the
> > name of HDS(header-data-split).
> > But there is no implementation for the HDS to enable by ethtool.
> > Only getting the current HDS status is implemented and The HDS is just
> > automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled=
.
> > The hds_threshold follows rx-copybreak value. and it was unchangeable.
> >
> > This implements `ethtool -G <interface name> tcp-data-split <value>`
> > command option.
> > The value can be <on> and <auto>.
> > The value is <auto> and one of LRO/GRO/JUMBO is enabled, HDS is
> > automatically enabled and all LRO/GRO/JUMBO are disabled, HDS is
> > automatically disabled.
> >
> > HDS feature relies on the aggregation ring.
> > So, if HDS is enabled, the bnxt_en driver initializes the aggregation r=
ing.
> > This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.
>
> I may be missing some existing check but doesn't enabling XDP force
> page_mode which in turn clears BNXT_FLAG_AGG_RINGS, including HDS ?
> If user specifically requested HDS we should refuse to install XDP
> in non-multibuf mode.

Sorry, I missed adding this check.
I added a check to reject setting HDS when XDP is attached.
But, I didn't add a check to reject attaching XDP when HDS is enabled.

bnxt driver doesn't allow setting HDS if XDP is attached even if it's
multibuffer XDP. So, I will reject installing singlebuffer and
multibuffer XDP if HDS is enabled.

>
> TBH a selftest under tools/testing/drivers/net would go a long way
> to make it clear we caught all cases. You can add a dummy netdevsim
> implementation for testing without bnxt present (some of the existing
> python tests can work with real drivers and netdevsim):
> https://github.com/linux-netdev/nipa/wiki/Running-driver-tests

Thanks for that, I will try to use this selftest.
I will add a dummy HDS feature for testing on the netdevsim.

Thanks a lot!
Taehee Yoo

