Return-Path: <netdev+bounces-140655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717179B7708
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA66AB22D86
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42C18C325;
	Thu, 31 Oct 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2OTRXgN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3AD1BD9ED;
	Thu, 31 Oct 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365492; cv=none; b=PDQd75xBIctby2TSd6ti/BD41RwJ4j+Avg9SGT73FB3io359BaqswtvfcGPizIuVNXOEhtix2DyAxdSCcIevUMd0pMcj6pGp4L+Wd3N0rbPLwa5O8EdHdDCAEnRRSEUzbC65mFbR3UKGpoDo+GbGAVk0d7mB4z1I8gfDYryXb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365492; c=relaxed/simple;
	bh=Ey3Nir80ipbi6aEqJTmKEXKmtI3cKgTNpdgc0Wv4xOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZB1XURBEMpgm+JFgfOxKIRdCs75PE74LrHTs3BNUYXULWZS9MfZDGZyQA0X4EU6gCLv2xtr5Vclg9d+1TfB0/sw9LWuQ3uAFHNo8Btb88vzrePe2jFVNBdomJ1A1JuHFH302mN8zt6e2VtPKO9Hs6sRMFp+y9qXGPo7pD83XXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2OTRXgN; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e30cf3ef571so107732276.3;
        Thu, 31 Oct 2024 02:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730365489; x=1730970289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey3Nir80ipbi6aEqJTmKEXKmtI3cKgTNpdgc0Wv4xOA=;
        b=M2OTRXgNJSGHzumM2Ekw9o2jBOVUIpKTsiZmJitPGQ6nF6B+KunElzh0sPwTfmvsCe
         4TEsASc3naTSsYeqcNWsPvGIw9hWqW+MbuKIfIZfMP1BYS9JjF1AoYSXXuRu44sSLJX5
         dJBWTYqjwQiMWj/mnCjnkky0s3h1q3vKHOF8i4UCs5JDkJPCbQdvsx2YQFMrqhR4WIau
         gwWiY1pvgdLPgMttWyD6yrwwCcB96uegK/4BJ4VoDHUxxK6hYV+ycSVKAiMtHgbAlOv4
         bvnsQkpRAyjFn3HnTrHja7y7XwLYRNVA7vyg7I0/Dg0N8/dccy3gzVkbtkNksnbKYecx
         q7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730365489; x=1730970289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey3Nir80ipbi6aEqJTmKEXKmtI3cKgTNpdgc0Wv4xOA=;
        b=JMZZyuoEhfmKhHqlNjBFBEC4zBBYiINMhFRktPrYUl/wIIKNjD/neX7HtJSrSPJnKX
         FckXn3JPXOrQEMg+aWCEtvnepxWHQEt4B0ggEf6gzROuBtFx7VboQ04o3BBLCWg/T1sV
         UiBHLyTtp+gaQgZBZ7IifXeIzYQPhWqm9O6sRVS1Tlc0z4iFJRfP5N6qHwoS5udPivg5
         4LVCsDSWRHtOATf1AZjPiYHW68iFHKxzYBv7LJFX1io6XZPB1fM+t+J7qu+eE/scKsO7
         acBdwIvds7D6emR8O64O/llN+WbO9pWOXt0SGNJ7qANFlsGTcZfjQ2FsmGpYx5jbcNsb
         TdaA==
X-Forwarded-Encrypted: i=1; AJvYcCUiY9oGwWg81J8V9MZSxrOrUOKS7SQvYcmRjP/NiztkpRwgkS4i3pNp+t9erCPMnekH7lyClxrIOnCM@vger.kernel.org, AJvYcCWYSe6mp0IAsR2NbS2v/W3PWBVnJV8TMHsb3ZeQgnn8MqVTxbhzOGPHtdNxg7vdbrm/fFaxjcrj8fePVumU@vger.kernel.org, AJvYcCXcy2CD7DTiODJgL+Wz01bv8+P7vudIH/7LppEGOy36EE6uR2UUa+PRPkCGyrgsfMNz2mHeaoPQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGsRajzX+0P2VmGAIsYbAFGJmLDz95+W6QuMHYEfQt4ll1/SR
	ZeNFAqkGS69EFIodgocNrr0ujJkZy7OqHMVPlOM5iRvv0cVEUQj1Lu27jP1iz8eaj8CBI/PTY7J
	d7722leYpTy3lSJOKznoeL6xGd2Y=
X-Google-Smtp-Source: AGHT+IHZguKS/F1V9AJj+A9lEBmF80qUzVmVIz8k06olAGMVP1Gm5twS6Ahy8M35orW4qXtccoTRMk9rczRRsmL94jQ=
X-Received: by 2002:a05:690c:ed4:b0:627:a25d:6e76 with SMTP id
 00721157ae682-6e9d88e7719mr79156307b3.2.1730365489324; Thu, 31 Oct 2024
 02:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029202349.69442-1-l.rubusch@gmail.com> <173030774932.1269076.14582772234717243392.robh@kernel.org>
In-Reply-To: <173030774932.1269076.14582772234717243392.robh@kernel.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 31 Oct 2024 10:04:12 +0100
Message-ID: <CAFXKEHaUO=Xo9iGYfUbadQPbi1Sepv=GODoRabQ9qP5PC-MRpw@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Add Enclustra Arria10 and Cyclone5 SoMs
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: s.trumtrar@pengutronix.de, joabreu@synopsys.com, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, marex@denx.de, krzk+dt@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	alexandre.torgue@foss.st.com, davem@davemloft.net, mcoquelin.stm32@gmail.com, 
	kuba@kernel.org, netdev@vger.kernel.org, a.fatoum@pengutronix.de, 
	dinguyen@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 6:04=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Tue, 29 Oct 2024 20:23:26 +0000, Lothar Rubusch wrote:
> > Add device-tree support for the following SoMs:
> >
> > - Mercury SA1 (cyclone5)
> > - Mercury+ SA2 (cyclone5)
> > - Mercury+ AA1 (arria10)
> >
[...]
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.

[answering to this bot]
None of the "platform maintainers" gave me feedback so far. My
intention is just to upstream the mentioned .dts and .dtsi files. I
checked my files and fixed my obvious bindings mistakes.

But, bindings for platform socfpga are still described in (old) TXT
files, not in YAML. So, do you want me to write the .yaml files, too?
Or, are my files acceptable by "the platform maintainer"? What is
missing here? Should I try to fix every error of Rob's bot? Are the
boards / is the platform too old and you don't want them anymore? I'm
not complaining here, I may try, but I would like to know what's
missing.

Please, - Rob, Connor or Krzysztof - can you give me feedback and tell
me what you guys expect me to do now here? Thanks in advance!

> If you already ran DT checks and didn't see these error(s), then
[...]

