Return-Path: <netdev+bounces-244288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A39CB3F3A
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 21:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B733080AC0
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 20:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D335032BF24;
	Wed, 10 Dec 2025 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGUpH0OK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE432B9BD
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398232; cv=none; b=FeVpqEr4Tplz8ahwKORe+n7YwdOtubaGZ4zHwmIdGefzF5hIVHYQxy6lRIR3sNSHfcAgYiktLucOX1wYOGDHewqtMUczzM8v9z5a6BR7uZPdvuue62n9dwIjdY+WVgQsg7A59B9Clq57ZyQ30MTQ3KQiUZN8vj8ele1CX6aDzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398232; c=relaxed/simple;
	bh=Xkp2ztF/WLqLLEEOjJNjmUCQbM4bisOn7lYjEwpDaQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoD8SpRj6uxs0BP7l5y3Wzhrb6+rgcAbL6qEHD6lIqw780wuZ1hjDhonVfJdhwWbHpCQ0rj78yxO6I7hJTgsMH4yKNjUwE13Q6Xq+GXbtvdfrANECeo5LGVAtMNYndaq74UGVESV4wGa43xBCxYkLlm6dBVNFUAwRMS1MMtAosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGUpH0OK; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-477563e28a3so1547015e9.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 12:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765398229; x=1766003029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u062iQEuovwo6zUqu/O7EkP7WT8CbsZ5+gioYjPqoyU=;
        b=DGUpH0OKR7h22rQroctEiOctsBN6+2OsGavEXBUUS1Cu/mo4l9ELp0cSmQQBFgeNTH
         GPoC+l9XiAtEtusIQ5mbIkGiLVszd73MmwrfcytUOqbJ4ORGYqVlgHP8i7GqQbqfDpbQ
         z/dVeJSbLg64GZ1+Dwe19HAGWHTr+ED63ggwb1NUINUFexFpIvbi8MYtS/AswZKiNMNh
         r1a1hNkzmN1QsEqKcHQgK0mt6AnU21N7xlAdPS2mniM4Q3Tyfej+vM1FP7vdnH05F1ns
         oYpNKOckhZ2rz7aLNo2TBGVMoebbJSzpOqdyqJLCdKSndztFRR4npYyTKFDMVyfJ2pPS
         +y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765398229; x=1766003029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u062iQEuovwo6zUqu/O7EkP7WT8CbsZ5+gioYjPqoyU=;
        b=WvyybdvGEK0y5ofG5XMqovB1xcZoJumCnRasJyPl4PZIl6Io3cJMSnKb+NWfVTed0I
         ljxclxCKc8onrTsofoTwW6n7OXXSH/zzIsqh865RSNtur4OMhQ5V6VPAaERsLMPrn7sO
         iipKxwacI+Bd82xgysw7nDa06JZoOHmDbIMd4PfTXe/evvf7Wg5yys/x4+vyLCH+4hYF
         Ex1tQmk9UA7n38vxO8qJDNrV5BcW/ODX7IKJq0+/53DjvSwDNXtBwuMCcpJohNvQCMG6
         yniBppPKDPj5VRVZ2l+QuXkoBlJAsaC7X5tRmNcF1i3KfB4wTI51E2d3LMq5FJugwoQ/
         jOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+i6PVguczupqLf92qffbzpA6PBQLqjtZDC8WkV3vKucKJklHoDDZg6RuDbMEnwBkOtFG7870=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcfRxV8rvlo2G8nOpEhxTDSG1rXw9eRmRGItNmerbDEMjPCpf
	+wklL+iXxQqtEf7SGji0xugdWNRe2oh+A3HxOZj88hxjpIJRdIMcCiBM
X-Gm-Gg: ASbGncvj6XYhzcj9eSayJCXuaa6j6DB4fIMITjHWE/XHlTxQAJsnbp2JcZAJP0TZhtD
	EWsxl4bos2quWM4N3n8UCq954wjUyAJ+MGhfZ7VX4412RNr8bZ0dIEQeBjvSs4MsPRdBlDlVl+V
	mszQzpYLUE7oEYuLHpEWCKTK8/cOIUaUPdvgVmt1mT0japUgNmZ97Hjq6WCza3Has73HdbsD0V9
	yuRokHsmLQwrXuT51l07PVf48Eq4Wr1d4TUimyqOBes2yGVJh/+4zs3tpzOcjWX2aGoCqnAa9Re
	JYAeU9u794ziQn7GVI9Ln40XrSNhs7IMtuGNYzhx9k4Zj2nYVqJinxlvcMzZ0jhdARYZggii/4M
	/Aq3FcILdrzLTwSSEK0iLjhmGuut4ahYhxNp0dGmZY4bjZmrtw/252ixCRNM43bofs47GFqmGIi
	sMTDptfqAQouAWuHMGxfelyA/e8qKw2VnnwkWXhM2Dfn14+GnWx1u+
X-Google-Smtp-Source: AGHT+IECXiRyTvyughOZ385ChJyIGPXYYRRTCEwIU16ua79rRSK1ielTpHqLT+w4Y1HkWvXA4V++mg==
X-Received: by 2002:a05:600c:230f:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-47a888dd26amr4204965e9.16.1765398228969;
        Wed, 10 Dec 2025 12:23:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b8a97esm1087769f8f.31.2025.12.10.12.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 12:23:48 -0800 (PST)
Date: Wed, 10 Dec 2025 20:23:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Rasmus Villemoes
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
Message-ID: <20251210202346.669c8c33@pumpkin>
In-Reply-To: <aTm4Y-avX8qoLLoe@yury>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<20251209100313.2867-3-david.laight.linux@gmail.com>
	<20251210055617.GD2275908@black.igk.intel.com>
	<20251210093403.5b0f440e@pumpkin>
	<20251210094102.GF2275908@black.igk.intel.com>
	<20251210101842.022d1a99@pumpkin>
	<aTm4Y-avX8qoLLoe@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Dec 2025 13:13:55 -0500
Yury Norov <yury.norov@gmail.com> wrote:

> On Wed, Dec 10, 2025 at 10:18:42AM +0000, David Laight wrote:
> > On Wed, 10 Dec 2025 10:41:02 +0100
> > Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> >   
> > > On Wed, Dec 10, 2025 at 09:34:03AM +0000, David Laight wrote:  
> > > > On Wed, 10 Dec 2025 06:56:17 +0100
> > > > Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > > >     
> > > > > $subject has typo: thunderblot -> thunderbolt ;-)
> > > > > 
> > > > > On Tue, Dec 09, 2025 at 10:03:06AM +0000, david.laight.linux@gmail.com wrote:    
> > > > > > From: David Laight <david.laight.linux@gmail.com>
> > > > > > 
> > > > > > FIELD_GET needs to use __auto_type to get the value of the 'reg'
> > > > > > parameter, this can't be used with bifields.
> > > > > > 
> > > > > > FIELD_GET also want to verify the size of 'reg' so can't add zero
> > > > > > to force the type to int.
> > > > > > 
> > > > > > So add a zero here.
> > > > > > 
> > > > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > > > > ---
> > > > > >  drivers/thunderbolt/tb.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> > > > > > index e96474f17067..7ca2b5a0f01e 100644
> > > > > > --- a/drivers/thunderbolt/tb.h
> > > > > > +++ b/drivers/thunderbolt/tb.h
> > > > > > @@ -1307,7 +1307,7 @@ static inline struct tb_retimer *tb_to_retimer(struct device *dev)
> > > > > >   */
> > > > > >  static inline unsigned int usb4_switch_version(const struct tb_switch *sw)
> > > > > >  {
> > > > > > -	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version);
> > > > > > +	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version + 0);      
> > > > > 
> > > > > Can't this use a cast instead? If not then can you also add a comment here
> > > > > because next someone will send a patch "fixing" the unnecessary addition.    
> > > > 
> > > > A cast can do other (possibly incorrect) conversions, adding zero is never going
> > > > to so any 'damage' - even if it looks a bit odd.
> > > > 
> > > > Actually, I suspect the best thing here is to delete USB4_VERSION_MAJOR_MASK and
> > > > just do:
> > > > 	/* The major version is in the top 3 bits */
> > > > 	return sw->config.thunderbolt_version > 5;    
> > > 
> > > You mean 
> > > 
> > > 	return sw->config.thunderbolt_version >> 5;
> > > 
> > > ?
> > > 
> > > Yes that works but I prefer then:
> > > 
> > > 	return sw->config.thunderbolt_version >> USB4_VERSION_MAJOR_SHIFT;  
> > 
> > I've put that in for the next version (without the comment line).  
> 
> FIELD_GET() is here exactly to let people to not opencode this
> error-prone bit manipulation. So, let's continue using it.
> 
> David, can you explain in details why this code needs to be fixed? Why
> and when typecast wouldn't work so that you have to use an ugly '+0'
> hack, or even drop the FIELD_GET().
> 
> My current understanding is that the existing FIELD_GET()
> implementation works well with any data types, including bitfields,
> and what you suggested in this series - does not.

The underlying issue is that FIELD_GET() does a check that the supplied 'reg'
field is large enough for the mask.
In this case the 'reg' is a bitfield and you can't use sizeof(), typeof() or
__auto_type on a bitfield.

I don't want to (for example) add zero inside FIELD_GET() (as is done
for 'val') because that would promote u8/u16 to 32 bits - making the
size check less useful.

Ok, the current version relies on how the compiler happens to treat:
	_Generic(foo->bitfield, ...)
clang seems to treat a bitfield as 'int' (so sizeof() the result is 4)
regardless of the width.
OTOH gcc treats 'u32 bits:8' as 'unsigned char', but bits:7 selects
the 'default' and then __unsigned_scaler_typeof() fails.

I don't know what the standard says - but at least one of the compilers
is buggy.

So the current code doesn't really work with bitfields at all.

An alternate change would be to make the 4 fields in DWORD (sic) 4
just u8 instead of u32 xxx:8.
This would be similar to the two u16 at the top.

Perhaps that is the best fix.

	David

> 
> If it's correct, I don't think that switching to your version is
> well-justified.
> 
> Thanks,
> Yury


