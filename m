Return-Path: <netdev+bounces-179420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4182BA7C863
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787823BAF2E
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10311D6DB7;
	Sat,  5 Apr 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZdypMTR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AE1D63CF;
	Sat,  5 Apr 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743843486; cv=none; b=QMJHeBpqKpV6OAdY2IoFTLm+UdLUaxCTFY7/N6WN9nSB45mG8msdYDAqOvE1yr8kDZ5Tdhna4JwTxWLiGsJkoB5e4E7yVwqeyYdqe3VxmfAYzESUyG0hvUa0RVLfcfpxzBQKpEjiasa5L7mG3O/AsRzsnciB0my+UGrP5Kg/cLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743843486; c=relaxed/simple;
	bh=4B11vuoLMqSqCKCDLheQ3yvoV6EToF4tR4XWH1h7miA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFhjVhrJz4iAZF3ubnzAqi0p99q+m94VxRy/Kj6EPQTBePoAKyHcgcCweN/KHQ13ZqCw76abmdJk8QRCLFNAPB8Yf4+8+h6OxbogXPh8zd7MyW08PgnmZfQfJXTrRzItAY5PDgfk2DGNu9Kt4frB16Ysow5ru8LmKobT2q/nrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZdypMTR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227914acd20so35966425ad.1;
        Sat, 05 Apr 2025 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743843484; x=1744448284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpj+U6LiNLvKI0gORxBfuo1ew0BWKjiW55LLe8Lju64=;
        b=AZdypMTRWKvjCEEUGFrTCy0Zo6JS0BJPwF4O2FpXWk6p4gIwMIDZ2q2ZLk7lsifBbB
         dvz2tM5G71y2rEglDNu8+QGDK5NBhXRS1/RfxYtWNDhBt3AkpCgbxmsQxXu9i/DBPQL9
         gKM+cS+3o1VRYYVVqckaRZmnatrzStvc/1Wm9D8NAbAwG5ZMuvHYsL48iKWomMuaS8U+
         VQbvYmAApuVWFOY9GlqUajoSC8LEc2zbD5zM+kuLzcCb1h1s7vDVvYhx9/yMkCnmF5hu
         fpLkMBdVPesRqX3DD9DAvmAc4el9hYnW2pcDbW3dOle6m/qenBC0zG4AeSJ1SOpD4tWx
         4TIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743843484; x=1744448284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpj+U6LiNLvKI0gORxBfuo1ew0BWKjiW55LLe8Lju64=;
        b=samBYriT68bD4fSqYLwHIRWe1eNLApZtjryZ8/eiNnknfHR3cnqj2+d7x/OlMlDZum
         a/w4rsCotOSLM6R+p1+bxo0vNjuus4rO7eA5UrylOUQxhb4xHnNmr0cVfphrPFy53HTy
         eMTzEo4XM6i88Jzc8u/UFr84vZVdkFVuUyZuGf1JY96cN+ZQFHGVNaZ9rC5XzNlRY6+k
         NiHFzPD+L2QJ1ZABC5mphPfwMGaUgHuY8fZsTEYccCj0agoIukccOIcbbKyo1hS55+bS
         wU9AUR3I5HFZUspGzpEuX9+bRZsJJehSQpLyzF5h9o4BPC+2ZOo0BGwPpqErZJJ1q+o+
         hwww==
X-Forwarded-Encrypted: i=1; AJvYcCW2KehZJ81zbKo440oZVfRPPsWMvH5XpRFFO37yJX1MYFs56CrC8OwdD1kP2WDF03HaOqxo2jk8@vger.kernel.org, AJvYcCXYVlE/sY+Hhnz/6cPlaOf7QOoFqramQYjTor8Xl+biDlKieP9nYRxigGHzaUNIWO/1YdJ8nuXZP+a0+qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDR/oWkCcE4n/LspK73ZsVGQuQhYuoHRQAcyBuxITZmpA0V5KN
	5OYY7hVdhulJYmklbpuv6MMQbCOXpZq2ohin9sQkhm9wkyYcT+2y
X-Gm-Gg: ASbGncvHtSznJ+1B1UTlPu3tGAexXsOAkM9Kjt48gJLc7SXQcDrYkPdEBS/NTBPg+nM
	jSr87IdvVmbS55rSTn0bWR+QrxufmZJvyCHTxmkdR6yram9piaXhfGYFnxxXQbi/n9L6eL3EL0J
	2KKzFVWayXuUXrcGvbi/BuoSj2Y/axVtOVMW8xrNAAHcdS7fpwTCOYps51Hx/MIUk6hCvL7mjRv
	8s5Kb/iCGBJWcmakWJ2kUpZ4+UvG7KGetRqc6qMULtfPINxeze+r5gQ08gKIBuMlimtQGU5vI/L
	aujw+UVoqcT5kPdrsekJt8s9e2YrWKvWaaW7s7/3LdKFkpAEbIn+jaZGLT3mvtw7JisyxWQz
X-Google-Smtp-Source: AGHT+IG5yymPElohyIpCvRwLjjd8mcIsrLt6BLzCEe2+J4N5vd5JyR9PUE7RxV9on84tC2TCWuScEQ==
X-Received: by 2002:a17:903:8d0:b0:224:24d3:60fb with SMTP id d9443c01a7336-229765bdf6cmr148765415ad.10.1743843484445;
        Sat, 05 Apr 2025 01:58:04 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:fb4b:850a:b504:c8c8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785aea7fsm45347855ad.2.2025.04.05.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 01:58:03 -0700 (PDT)
Date: Sat, 5 Apr 2025 16:57:58 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [RFC PATCH] net: sched: em_text: Replace strncpy() with
 strscpy_pad()
Message-ID: <Z_Dwlvrvwzq0ZQv7@vaxr-BM6660-BM6360>
References: <20250327143733.187438-1-richard120310@gmail.com>
 <20250327162325.GA30844@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327162325.GA30844@breakpoint.cc>

On Thu, Mar 27, 2025 at 05:23:25PM +0100, Florian Westphal wrote:
> I Hsin Cheng <richard120310@gmail.com> wrote:
> > The content within "conf.algo" should be a valid NULL-terminated string,
> > however "strncpy()" doesn't guarantee that. Use strscpy_pad() to replace
> > it to make sure "conf.algo" is NULL-terminated. ( trailing NULL-padding
> > if source buffer is shorter. )
> >
> > Link: https://github.com/KSPP/linux/issues/90
> > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > ---
> >  net/sched/em_text.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> > index 420c66203b17..c78b82931dc4 100644
> > --- a/net/sched/em_text.c
> > +++ b/net/sched/em_text.c
> > @@ -108,7 +108,7 @@ static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
> >  	struct text_match *tm = EM_TEXT_PRIV(m);
> >  	struct tcf_em_text conf;
> >  
> > -	strncpy(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);
> > +	strscpy_pad(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);
> 
> Please drop the 3rd argument and then resend with a fixes tag:
> Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")
> 
> As is, the last byte remains uninitialised.

Hello Florian,

Thanks for your kindly review!
Sorry for the late reply, I was on a short school vacation.

> Please drop the 3rd argument and then resend with a fixes tag:
> Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")

Sure, I'll do that and send v2.

> As is, the last byte remains uninitialised.
I see, may I ask the reason for the last byte to remain uninit? It's not
going to be used so we can save the time to initialize it?

And why does dropping 3rd argument can make the last byte uninit? I
think "strscpy_pad()" always makes the trailing bytes in destination
buffer to be NULL, so it'll always be init, shouldn't we use "strscpy()"
instread ?

Let me know if I misunderstand it, thanks!

Best regards,
I Hsin Cheng


