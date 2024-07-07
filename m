Return-Path: <netdev+bounces-109667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDB6929781
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 12:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7191F212FA
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C64182C9;
	Sun,  7 Jul 2024 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EspN0yDo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2781CD00
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720349498; cv=none; b=QQci0lojAjNZ0StciwT8WsZidHBo1EXgFRbLMhSrWuBgcYg8RzUKL7A3peiFxZyan7JpCRZ1y8x/VQbLGV7tkUCzLXOC4eleWUhVBviwbun+06ZZ9w3CDPWzDs4cZ9EqWiFBdth48x1GtihQYFNz0ZY53RX82Mc4nZYJDJ7+5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720349498; c=relaxed/simple;
	bh=I0QP/BSA0qH/a6bTtPGLK7xuowrPFrNhl5nZkgXg+Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAoQGC3MW/WGqYvXAP3FuPDI05pEi6kvBJaM4z7ow9CvMXiciOtm06+iTINhQdJfL/nCeryyNTJKdh8k57i8kpKsUMNPlbC5R76JURLNYdBCDln6wrb0HXULQgalUuevkVn6HtFCC5J4i8eFUrd6MeByv4YypivLlQeZ0uovGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EspN0yDo; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea8320d48so1235396e87.1
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720349495; x=1720954295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t1forCYzIsKZCj8ttfj6l1hwMZiFQymEma2EUi2mpOk=;
        b=EspN0yDo9FWNfGbqujGa1g1gHkyb0C+vq3cHF25dbgXshwmrNqigQLp7V5WtvSr/A/
         3l5DfpxPetCc7npI1gCIlv5s0IoCDkSexMYiLca67I1vaStIq/UI0QnNnqxA/sbJGNKH
         LRHqOXuqQKcFOaPI9Ute1z5HhOFtrOUgRE7Sz12LBUiXxMQ0yGMrhsVCTJFVfBeTc7ft
         F536olc6PUFRDHdTh0cEpI0X90uS6lGoPyaw+nU9LNpmhHnchVLiNou1X5ZeBXah/hPo
         vMF2Mb9zPZMFyKhKXjnxPbUaGtrPuQod58bE0VghVF20hT4GaLksjk4Kz1pGyj0v2PxP
         KzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720349495; x=1720954295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1forCYzIsKZCj8ttfj6l1hwMZiFQymEma2EUi2mpOk=;
        b=YH9WpAwtZJXKuxsDBdYLkBX2npmyHtN0C8MQZEO+1adputFO9iT8gRtGpWaRqPn+V3
         4PsuKXDqwm+O4OfLog0t9AfgDKOuSxWuV0oUPAHEMgM39aXCgEm5XDhEDvdigVEUAa/e
         cyoGIVlRK3wuGAxGK3U8dLsSOYetkaJtUq3XbWoUIwYJiqrod79fg4SIEBgoeScVzQ62
         5CeoxkLSFzz38YBWewqH+1QGjhyve6adv1rGg0K4ohDeQt14s39pXj/3nW94TyspLyRS
         LzxRC28XkZ7CXHMtiBPVAoUyKOsWb3qooGGQ43kgy3Ez0Nybe3sTSxw+zb20VUVjG2WA
         2GAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJi4+heEpgK0DaVjX79k6cRNYR67uRdGAW9MwTFaCiMm0+w3+vz9rTiSswjZXGc6R7Iu1xq2dx5JGNGSx2sbG/jHIRjVK4
X-Gm-Message-State: AOJu0YzsDj9PS8TzdNZC5WgRvFRehpyYks7U/kLdCrlx3bApaYcyxDbr
	qkTliocic9y0+Zz8KAWs1RHSI3RaE73pFIBKbR9695FyBFqqQnMj
X-Google-Smtp-Source: AGHT+IGAw3DOztfr9HZ2IobJr5mBwC5bfK6AsJq95aooT1a//7p8f753zqpyJuzIG76U9zfOwk/JLA==
X-Received: by 2002:a19:8c5b:0:b0:52c:939a:d709 with SMTP id 2adb3069b0e04-52ea0ce3a38mr2532440e87.0.1720349494656;
        Sun, 07 Jul 2024 03:51:34 -0700 (PDT)
Received: from mobilestation ([95.79.243.20])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eaeca60b7sm168933e87.195.2024.07.07.03.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 03:51:34 -0700 (PDT)
Date: Sun, 7 Jul 2024 13:51:32 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <d7s5plkdd2ihxlhnvpds2r4dywivkfkszew567uevzkfv56ae2@r3p6asvdyu3j>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <16ec5a0665bcce96757be140019d81b0fe5f6303.1716973237.git.siyanteng@loongson.cn>
 <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
 <CAAhV-H4JEec7CuNDaQX3AUT=9itcTRgRtWa61XACrYEvvLfd8g@mail.gmail.com>
 <yz2pb6h7dkbz3egpilkadcmqfnejtpphtlgypc2ppwhzhv23vv@d3ipubmg36xt>
 <8652851c-a407-4e20-b3f3-11a8a797debf@loongson.cn>
 <kgysya6lhczbqiq4al6f5tgppmjuzamucbaitl4ho5cdekjsan@6qxlyr6j66yd>
 <2b819d91-8c2a-4262-9cbb-c10e520f10c9@loongson.cn>
 <CAAhV-H6ZzBJHNqGApXc-5wiCt9DqM51TMkC2zmj5xhoC-rfrnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6ZzBJHNqGApXc-5wiCt9DqM51TMkC2zmj5xhoC-rfrnA@mail.gmail.com>

On Sat, Jul 06, 2024 at 06:36:06PM +0800, Huacai Chen wrote:
> On Sat, Jul 6, 2024 at 6:31 PM Yanteng Si <siyanteng@loongson.cn> wrote:
> >
> >
> > 在 2024/7/5 20:17, Serge Semin 写道:
> > > On Fri, Jul 05, 2024 at 08:06:32PM +0800, Yanteng Si wrote:
> > >>>>> But if you aren't comfortable with such naming we can change the
> > >>>>> macro to something like:
> > >>>>> #define DWMAC_CORE_LOONGSON_MULTI_CH    0x10
> > >>>> Maybe DWMAC_CORE_LOONGSON_MULTICHAN or DWMAC_CORE_LOONGSON_MULTI_CHAN
> > >>>> is a little better?
> > >>>>
> > >>> Well, I don't have a strong opinion about that in this case.
> > >>> Personally I prefer to have the shortest and still readable version.
> > >>> It decreases the probability of the lines splitting in case of the
> > >>> long-line statements or highly indented code. From that perspective
> > >>> something like DWMAC_CORE_LS_MULTI_CH would be even better. But seeing
> > >>> the driver currently don't have such cases, we can use any of those
> > >>> name. But it's better to be of such length so the code lines the name
> > >>> is utilized in wouldn't exceed +80 chars.
> > >> Okay.
> > >>
> > >> I added an indent before 0xXX and left three Spaces before the comment,
> > >>
> > >> which uses huacai's MULTICHAN and doesn't exceed 80 chars.
> > > I meant that it's better to have the length of the macro name so
> > > !the code where it's utilized!
> > > wouldn't exceed +80 chars. That's the criteria for the upper length
> > > boundary I normally follow in such cases.
> > >
> > Oh, I see!
> >
> > Hmm, let's compare the two options:
> >
> > DWMAC_CORE_LS_MULTI_CH
> >
> > DWMAC_CORE_LS_MULTICHAN
> >
> > With just one more char, the increased readability seems to be
> > worth it.
> If you really like short names, please use DWMAC_CORE_MULTICHAN. LS
> has no valuable meaning in this loongson-specific file.

At least some version of the Loongson vendor name should be in the
macro. Omitting it may cause a confusion since the name would turn to
a too generic form. Seeing the multi DMA-channels feature is the
Synopsys invention, should you meet the macro like DWMAC_CORE_MULTI_CH
in the code that may cause an impression that there is a special
Synopsys DW MAC ID for that. Meanwhile in fact the custom ID is
specific for the Loongson GMAC/GNET controllers only.

-Serge(y)

> 
> Huacai
> 
> >
> >
> > Thanks,
> >
> > Yanteng
> >

