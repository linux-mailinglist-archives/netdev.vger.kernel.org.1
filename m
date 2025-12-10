Return-Path: <netdev+bounces-244234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913F3CB2B4E
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 11:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22D95303E04A
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484E3161A0;
	Wed, 10 Dec 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhDcGuxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065B31618C
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361928; cv=none; b=c5McPbvl/KCEpX9dqsn55nOGxRvs/gInNv71Ins8OiL5Njvun9/HLLGbBG1Yk8zxEexper6TOdZo0S6749ZXtafSoNKrvO4XJwiCk46Mic3x4X7TXx+5vqeJ1kUoh0X1Wa6dQSb3ZH7oBUvieQ22Rms0VgI+oadmDXkrv3IxF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361928; c=relaxed/simple;
	bh=I/JMNNp1r55UL6QKtwkNR+AyEKT986MddtqR5zGlc94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iR1lFdgnsN3jQcydjaLuOjQJMcylDwN2rbEcw8yFU8dnZJ7HqzA2539iSngHWcAWc3JEun4T64Un0Pw/6yNzxX/Mj+niNYzzKt8qq9flD12TAyLL2XA+bGQ7o4j2e8JI8Lp3Fylic4Gdw1a8znDouuCScH3zO3/v2meE4kpye24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhDcGuxJ; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42e2e628f8aso3140957f8f.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 02:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765361925; x=1765966725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivJBwP5GNe4rsrKX30pWrsmTA+5ClhNGxoBEPh+DS3E=;
        b=JhDcGuxJoSfUxR7CjDBVcePFgl7mIlIgVNM+ZlYC0d/guoykVKnfcRUyM/pynYzusZ
         TxL5tihTds4nAFseG7GA/fpk+4wyFQGb5LVl9VhE8zmpRkPXyPb1enDa6+VpVs8y47UO
         qRmbv4xnMfyBkJseULJm3hWsqbAaSfNuA7SIup3Ii//TW/fZAISQuCZoBduMHO1u7E1x
         3Q/IHLu3w02yJL/ny11hvpkI+IylQIqCs3cF7ixmWQNYfoPXrAG+aVoRX0ghjIrrO2Gg
         Ieo5xVrRZYhfBl1RNIo/qiLaJCt6XV5pAdLXH7eNl/ZHLa5OCHTmBYRjLJxxUFKzgfSk
         KotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765361925; x=1765966725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ivJBwP5GNe4rsrKX30pWrsmTA+5ClhNGxoBEPh+DS3E=;
        b=ui39jwhprdtzlXMxSe94rIkuFOHCe5koNShzoCuZW5ZubwI+AIcy5xkbjJEkFI3i9W
         j/witz5vGh12aRu1TaK0AKmAsGEDUM6l8acBioZRmVrdzsk7Gjn+eRRpXADf0aOMkvsc
         WxEBbkusWMpTBWdTgFBC5MNoq8xMosmzxNKXLtqZVAeoHIITX5QbE0BSq7rgQvjeWCty
         bHAlBALNMiFN4sf7TAXV7H6REamzx3+c3TGWJ+tO1ztVVoaxBWXXFrSauOzGgRu9Atge
         A0ofceuZ/Qake7QvnJRV51yyIjUn/UTv3x8epIPfoP9NZhsNsm/wnKRQqX2fiYdBw3b5
         pfiA==
X-Forwarded-Encrypted: i=1; AJvYcCXGXH8GA0qC2x7ZsaxqWjmyy7pAJfScCMfAXJJwRrd5ikUdNrptTgCtf/rn0etQrQwmg6toIbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkfJ0oArJxXqKFIU3r3zRKIoxxntKZLsV7wxocuuULMGT+a8XM
	y2G8H8LSDY37wLRMvIWnH0iimy+I8y/2eK1YBoPJU2pl/iT2GWdiz7XL
X-Gm-Gg: AY/fxX61BMZbhp7EKVZ+vje1HOcFH3wnr0httj08WQ+Vid8Bs4r0TALF7AQJeKyMyhI
	8/E+WThmWDkVdgZjBioo+Vb5nw5Y0bsstyVAF4HsjaO0tncdkFePfZciZq/J3Pa7GsKV04MYexT
	Vpqe+YRWrb8pj3M5ViTf7Q03YHstrDnUR+K22mxKV8g+eA13QKrLfrtFy69XlWkNzbdF+GUkQ+B
	oLYHac8KcjKliRaH1egMQt3y96quGi9BKgyOc0fId1/SBZ3AjzLj6s9NWAj1n7Ke6K7jTT297ia
	T85uAvuPOp2nOcVpXmnHg9x8IG8dVSNO4NOtD4TsXrGFnZOwJ6JyAYQlooCPiG0hruyAiAS1iMI
	NH6J5NuKpfLAFCqeZMo4VAUv+spLWkZMpjcQoB3uNRhqzzDy4PsBwUtvXgyTV8pal5Ptd4i3H/c
	mOt+8fo8JDOZYtkPzxHK+6mGDJYrAirwRwG2emY/xM7o8P4/ak6cv3
X-Google-Smtp-Source: AGHT+IHnnDz/LzTTRTNEb7lg6Qv9pz02shzN5UFCICKksM96FcH+4Cq+vdcgE23tcA9uj4y82edHXw==
X-Received: by 2002:a05:6000:40c8:b0:42b:3bc4:16dc with SMTP id ffacd0b85a97d-42fa39d2c8emr1581708f8f.21.1765361924693;
        Wed, 10 Dec 2025 02:18:44 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeadesm36502473f8f.10.2025.12.10.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 02:18:44 -0800 (PST)
Date: Wed, 10 Dec 2025 10:18:42 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Simon
 Horman <simon.horman@netronome.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 2/9] thunderblot: Don't pass a bitfield to FIELD_GET
Message-ID: <20251210101842.022d1a99@pumpkin>
In-Reply-To: <20251210094102.GF2275908@black.igk.intel.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<20251209100313.2867-3-david.laight.linux@gmail.com>
	<20251210055617.GD2275908@black.igk.intel.com>
	<20251210093403.5b0f440e@pumpkin>
	<20251210094102.GF2275908@black.igk.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Dec 2025 10:41:02 +0100
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Wed, Dec 10, 2025 at 09:34:03AM +0000, David Laight wrote:
> > On Wed, 10 Dec 2025 06:56:17 +0100
> > Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> >   
> > > $subject has typo: thunderblot -> thunderbolt ;-)
> > > 
> > > On Tue, Dec 09, 2025 at 10:03:06AM +0000, david.laight.linux@gmail.com wrote:  
> > > > From: David Laight <david.laight.linux@gmail.com>
> > > > 
> > > > FIELD_GET needs to use __auto_type to get the value of the 'reg'
> > > > parameter, this can't be used with bifields.
> > > > 
> > > > FIELD_GET also want to verify the size of 'reg' so can't add zero
> > > > to force the type to int.
> > > > 
> > > > So add a zero here.
> > > > 
> > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > > ---
> > > >  drivers/thunderbolt/tb.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> > > > index e96474f17067..7ca2b5a0f01e 100644
> > > > --- a/drivers/thunderbolt/tb.h
> > > > +++ b/drivers/thunderbolt/tb.h
> > > > @@ -1307,7 +1307,7 @@ static inline struct tb_retimer *tb_to_retimer(struct device *dev)
> > > >   */
> > > >  static inline unsigned int usb4_switch_version(const struct tb_switch *sw)
> > > >  {
> > > > -	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version);
> > > > +	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version + 0);    
> > > 
> > > Can't this use a cast instead? If not then can you also add a comment here
> > > because next someone will send a patch "fixing" the unnecessary addition.  
> > 
> > A cast can do other (possibly incorrect) conversions, adding zero is never going
> > to so any 'damage' - even if it looks a bit odd.
> > 
> > Actually, I suspect the best thing here is to delete USB4_VERSION_MAJOR_MASK and
> > just do:
> > 	/* The major version is in the top 3 bits */
> > 	return sw->config.thunderbolt_version > 5;  
> 
> You mean 
> 
> 	return sw->config.thunderbolt_version >> 5;
> 
> ?
> 
> Yes that works but I prefer then:
> 
> 	return sw->config.thunderbolt_version >> USB4_VERSION_MAJOR_SHIFT;

I've put that in for the next version (without the comment line).

	David

> 
> > 
> > The only other uses of thunderbolt_version are debug prints (in decimal).
> > 
> > 	David
> >   
> > >   
> > > >  }
> > > >  
> > > >  /**
> > > > -- 
> > > > 2.39.5    
> 


