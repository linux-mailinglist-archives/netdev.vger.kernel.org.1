Return-Path: <netdev+bounces-111509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B5A93167C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2091F22149
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A583318C356;
	Mon, 15 Jul 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raBh8GWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863818D4DD
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052962; cv=none; b=mB6WzqaDcerqgw9ZYeqw9xvUaPR7dIT9cziNnpNPP9TYzXVudoUkruY1ThotCFNdaJ7RfDzkWC3KXKy8YhyG7r7MIIXkNtQ9a7CCdTLg/oB+ekie4Tbf2FycooB5tewAGOxnH3uT/12qOq4C0ff/h8L9QBOXCLt+1L+R0Eg4v4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052962; c=relaxed/simple;
	bh=zPrpwQlL2crmjNa4smp42LfL5xsAOvhXZdKXxy3/kok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yx9q+1720wEJhn7v4knJW97Ej37uy7fwhEomtNU+bw/6bRE2dqERk0wvq1rSXVAMZJFx4IV9dPIbsH803Q+pLCMiRlTHUOIQaeTTAmI0S+oGdW9Czp2x2is968+uBGmJFsoxlgHFazpFs5i/29uDy2dtbSGnW0C8ugLjoZS6EBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=raBh8GWe; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e03db345b0cso4142567276.1
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721052960; x=1721657760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zPrpwQlL2crmjNa4smp42LfL5xsAOvhXZdKXxy3/kok=;
        b=raBh8GWeDzPOe1Sf7/OA3W/diJOEBNaYEAIoWdVRYZHHbPW1+kvl6LSaSpeL48JV6G
         mi6AGA5Yy/ctGWqR2Dx+EY/Ux4Lz23RE2Cs/jxXZoCKJQIF8ZHSkRS2Bx2fapzeCUuZy
         eOlfPeT4RKlWBTQrFtOFKZrdz7e0P/Dm/sO+DB3nf2Jx5LB7AN0atnFG1EeKK+bbQI1R
         0nnX09NjI1y2Lha2g6wyyIa4stoD+KLkZLtiZ69ojELTRUSnxBxPGa6CD6qZyoo9w5k6
         mnlR60Fw5oJtJ2QCXXV0Kwq1AK93HBHttF8aar6eUnVjkzs8BqYthM5xQoSgsE8+I50F
         J37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721052960; x=1721657760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPrpwQlL2crmjNa4smp42LfL5xsAOvhXZdKXxy3/kok=;
        b=hxcGQleA2gTj9dZOMX/n11fuuWF1Rs7M5nn7eR489e/6LwKbOxOyYiNdsDf3vrjjgs
         CrCNzLiR8OohGcyR3kTo7slWH5uy8+sgY2pbAIGJ+2N21ZmB3L/LbNvoBhPlvM7afYmo
         WqBf/+eb4FDdf3wcG3b7gxCfg+zik/IziCwZAG41dryO8CeL0HuprB3uUvIFnXaB/x+j
         5v+Dmfd4e0msmVegEQ7apNEdqY5AhBZbj2tAA5ZpqVrkDBd5Vp5c/TAqcEx35DE7q+ha
         s6ZET0dFDW7lijYSu+UyCK20AKJVtYAUmuoV94J1B+3njGh2113try/WoTyxIZqPx+KD
         GBSg==
X-Forwarded-Encrypted: i=1; AJvYcCXYZbpZXruktpBVVgrt1ZJDWaufzz62IJ3m2tzxDweVuVU3y6wNy30ryL+asTPLdUS9G6gJdW3u6F1KfIFiutS/wHAUo8wb
X-Gm-Message-State: AOJu0Ywf7cPogenJeLYQsyn3uPzXUpjBEOun+EGC5WKtaF6BcBsyyuPG
	VN+IkV+wRixKNQM+Zdvl/njVd7YBH1tKqmxBcFHWr5E0ynvcTYTNuY2IzbZ3kH6TvCTBFNDabkS
	uEWojKNDoiSE/3SV/r1t3riI2i+E6pCKzX7r87g==
X-Google-Smtp-Source: AGHT+IHb+gxnONbxy8xXZCJ33d+B6X9hNWCDsDZDbco0SUpBCc4PyUSEL4qETxb9/3bZVvm7kgJWWoBjZ4eb5yfwpaQ=
X-Received: by 2002:a0d:fc82:0:b0:65f:9f0f:7912 with SMTP id
 00721157ae682-65f9f0f793amr74093307b3.20.1721052960083; Mon, 15 Jul 2024
 07:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
 <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com> <20240715070133.63140316@kernel.org>
In-Reply-To: <20240715070133.63140316@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 15 Jul 2024 16:15:49 +0200
Message-ID: <CACMJSestJBr=yXgEXDrZj8djZP6G7udOjCgUpwZhgfowgQGbww@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 16:01, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 15 Jul 2024 15:55:56 +0200 Bartosz Golaszewski wrote:
> > Luiz pulled the immutable branch I provided (on which my PR to Linus
> > is based) but I no longer see the Merge commit in the bluetooth-next
> > tree[1]. Most likely a bad rebase.
> >
> > Luiz: please make sure to let Linus (or whomever your upstream is)
> > know about this. I'm afraid there's not much we can do now, the
> > commits will appear twice in mainline. :(
>
> If Luiz does rebases, maybe he could rebase, drop the patches and
> re-pull again? Or, you know, re-pull in the middle of a rebase
> so that build doesn't break. Should be pretty.. doable.. ?

Oh, I thought this already went upstream to net-next? If not, then
sure, Luiz can rebuild his tree.

Bart

