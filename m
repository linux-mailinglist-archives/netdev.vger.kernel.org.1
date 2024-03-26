Return-Path: <netdev+bounces-81875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0788B773
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56C42E7383
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08247128362;
	Tue, 26 Mar 2024 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0XLuDa7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF383DABF7;
	Tue, 26 Mar 2024 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420420; cv=none; b=RwJfFhrA4l00ti2nokDqwjsu/wnDdzZkuImRUf6hue+ut3cyS9wC8ZDsIt0COsyZgSSX47kYWMW2qtsA4VFXiTisJpAiGu+2xQRHEiAhEegSDuL2wD44iODt+RWMe4/jrEOKw9ogIHDuK+glEJ4b9IhQiY3L8ZO2OYWOfoqBhsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420420; c=relaxed/simple;
	bh=85L/a51HnO6m4QY8aLFiASnw4aQdtlumeIiIvnEDeqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXZL8hVNvQ2KXsjbSW/A9+NsUJPWzPw9vhGnjc1M/aK0wTQukhWZMwXqp28xXcKrsSJgCNV2aOm7W5DHOm3s6umMPjBI3doKnNnrJdjWS1LEP9taW9OsRQ1SWDWyGJwJ7JiF3Rcvb4YgG/h3gDkaC+e+f1Otq6VegBDY+N46qXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0XLuDa7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46a7208eedso685501266b.0;
        Mon, 25 Mar 2024 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711420417; x=1712025217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85L/a51HnO6m4QY8aLFiASnw4aQdtlumeIiIvnEDeqU=;
        b=P0XLuDa7LYPXlm2F6UMi0yC49D8Og4aMKzi5l/aSTLNywg9s2y3kNaCFlSniIGV6ew
         uzrwdd4QVlO1uV/D3xiipN5kHS4l6KWQ5ujGQR+sXvphdsHbsKXWU6NQK1yUAEmPVR3M
         gA6UBhK+o3yH+y9TvNN8Efz/BwISieNmFCXXfLuhdNNutqXBlqeUzOfjiAXMX1kmciSl
         vApsvvB4op5xh0yjXMhFqjgU2bvoHj9Bxg2hD/YU2l6VsAXgSIZfgK2qdjB8ubKJiOPf
         iZWYnDPvxBCFC7T/ORg9D6FMHmDxk7govcMg6qmQw1HG22ty1EIaeXHs2CEir8e/03/X
         GfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711420417; x=1712025217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85L/a51HnO6m4QY8aLFiASnw4aQdtlumeIiIvnEDeqU=;
        b=dxRr2c+2+kUxMYC1SlLYaaLScQt+yWqTLrMMhuQn2ZSfSZSsjdJ0d/+lJhC5RmhHER
         AwdcFDvMJ+/MIDl63UkSbqvAZjN6TD6mme8+lE3MKxfapSBxFodOsi0Iav0fKU8an5Er
         DAKxrppkVQ2FqxGad8ZNg0BVeRTO3r4RdA/PR8WstBN8ydAdYCxVrd5p8mxtBKWr1wtY
         ZALGd3taELES1Q9qmPghxYof2YwiED39Gi28uM4qcijrDoEFGy/9SN0rCQ4a4+6RHmMI
         gC3VQy0yq1Wk9rzfAZqYc3XiGRxKNnLng+GfSmTs/3tep3A7JpYBDInwCZ4YiijqIuEq
         TBrg==
X-Forwarded-Encrypted: i=1; AJvYcCXgsX0+Zy9/6C3404qmnB9yAEGWFXDJ+o2b/y2fbu1cGGu2O/LAmL5CDH6cAS2YojQMCJc+qonbS+DAgSp3gqXTq75NLTY3z/wGynEbiO1+1bXHT6zSd5PfunbSzYG+fWMxsjm3phkvi6lb
X-Gm-Message-State: AOJu0YyCZRe4eVmKebUpCfHhbH55rg+uK44mUOR00WRxCjsd+S610n+Q
	FxyqqKqfUueForheRUy94Rtepw9uTOqV9caG3Eee1sTIX9GytxihhRAsAmT7dRKXSmDYGAQw2Qv
	Fxt9Unb46n01tffl/qrZm8JgZflM=
X-Google-Smtp-Source: AGHT+IGsoM00LvbOckuuEcdVDvseZJWaZUBBrMGlxpcPhn670oKvHDam7dctAr17MfY4maSjCkvPgLlep8d3fCYlT0w=
X-Received: by 2002:a17:907:7784:b0:a45:f263:361b with SMTP id
 ky4-20020a170907778400b00a45f263361bmr5259427ejc.61.1711420417428; Mon, 25
 Mar 2024 19:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325062831.48675-1-kerneljasonxing@gmail.com>
 <20240325183033.79107f1d@kernel.org> <CAL+tcoAXCagwnNNwcP95JcW3Wx-5Zzu87+YFOaaecH5XMS6sMQ@mail.gmail.com>
 <20240325192308.22e6924c@kernel.org>
In-Reply-To: <20240325192308.22e6924c@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Mar 2024 10:33:00 +0800
Message-ID: <CAL+tcoBkbPvkf6PB+gjN=x+DV5Q9AaUXTDP3eg14fjmcoJhnyg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] tcp: make trace of reset logic complete
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 26 Mar 2024 10:13:55 +0800 Jason Xing wrote:
> > Yesterday, I posted two series to do two kinds of things. They are not
> > the same. Maybe you get me wrong :S
>
> Ah, my bad, sorry about that. I see that they are different now.

That's all right :)

> One is v1 the other v2, both targeting tcp tracing... Easy to miss
> in the post merge window rush :(

Yes, and thanks for the check :)

