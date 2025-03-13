Return-Path: <netdev+bounces-174663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB02A5FBD8
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9F83A6F1A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A431487F4;
	Thu, 13 Mar 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="x9nbjyFL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7D33062
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883441; cv=none; b=fgdhMiudNNyYqD7HyRni2Qj4YOmsAVXb9iAejcbS0Y/N98erT3ixCK7pSzkaJzHSoBVP5uPiI5ppelhT05q619rOk0Pw4IDywbM/BVGkOfQfXMqY/yOsoOu3PRY4NNFEQUMK6ymgP4Xx8Ne7s2vH67n9nbYcSUSny9qHNb5qZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883441; c=relaxed/simple;
	bh=Y2ENQ6w/pi+aD8u22ER/vzgtyJwm62L6TsKe3L78xgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGFtqfTejFJQcuL//Rd3MayqHGbN7vbVdxpIqKZ+xqg7zsxJu0STZkgdueqT50s3L8zkdJ9WwtYoqAu6RbrkTArJa/J55QqIZMPYfbjOmwtCiliREGzz+Vlfw6G9EiFTZcVNNR9G2rO/M8alvxDfoS+cSteON1DlN8gQKxqtVPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=x9nbjyFL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3012885752dso2668274a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741883439; x=1742488239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eyw3Y0wbOt1BVHpghjZ9htyajO0Bn8dsUk9ikdVt9i0=;
        b=x9nbjyFLVzAw8JKvDyhzlv7oOUpOaNT1beQfmm/raObtKf2xNTfgn2/AT42AIS3bfT
         vBOdv+oxDzAWucDRN3Y4t06JMhQbc0t+P25Zjeb++Oz/eOYAHYBqqi2rb/KGaJ84gv7m
         PxZcJsAZ1C95Wrf5JEY9kJyErf1Un5p+G3HeCYjPXnejEkUQruLhOM+XiQy9Hlnhu5d2
         pZcQVzhKfdAMesr0gyyA861EQnKj296o70KzAyHg9uAbSyIJGOLPbA4mZwBX+BgAG2C6
         fUmDyKLxgmTLOybx8E579WJefXJXgM2VLPZsIA/a/JYcOfRl1bxrefP+jO0dZOhvj4jm
         S7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883439; x=1742488239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eyw3Y0wbOt1BVHpghjZ9htyajO0Bn8dsUk9ikdVt9i0=;
        b=exJ9YVGXdN+T9AGGfu5EoUFRk2N3DlZgcXUM478MX2PrzUHOLi1t0gUApx4QzS7WnA
         g9ovkPnmYo2fbOYEZ0BsWhvZxQcr0+Y0rSKnq/cpzhRrdDFjTlvTqaAK5YlGyM2MG+w+
         krGZO1i4NoQsjb0IKONAroT6lV0MErfOyC+kfs5TZUcDEsauI9V4EscJrfK0Bdv19yen
         lq1lAel/uluBNMXewQuv4lyPeJfHsVd8lkzIGBWXb1Lh4t9SjZ1mjQFa75bmnQ3VO4T5
         W379syyErKeSLvmuYYg2B/XM+55PoyY8dbRVKyhWnVdeqkHYMgfe+OvtBHAk0Lner+fx
         cxUw==
X-Forwarded-Encrypted: i=1; AJvYcCX+YOJtGxuCee4IzES6p0WJlE3fAzm3wfQ+NqCKuv2Y+b+1RQRJMjyjX2/vXmSaaP7A0mLqOwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz66ecHplVkQK0pxNMkJac9Y/MiHYMqTtdl47kTVpLOXPQraayW
	DPQqXl63LIYLsanig7ex94B8p2bPvXnmX5FmEQ8AkZW/TEKJS0DKPMvWomkpB08=
X-Gm-Gg: ASbGncszyXmb7lK9Ida9dHAL2rRK6cIJ4JIza8ENMORMbCVKzyy72ro1YoWwL6dsWh2
	rj4CrcbfFuotEZdyq2E3CEKZq1Rq0aV4FtzEFQXNIknAGbqZ5dYXQMEX/5g0zaAOtl9/PFF4Krf
	JC4pHuBq4rPA0gqk+8EPdJ/OO5YIBYz4gHrYILhwEn0EdfgyohO3t6Ek0g5yibY66natm7tnW1s
	476wcGg9Rm+Dgj3kAToC4aRSBnPK1bveg3uIVKuq2nltJaex/qxnrvSi1saoka0sFVTQYk9z4s/
	2cCHG8fcYqw+PVWYUxKFVIiFumwujjPEDDYcbprTab25KNn0xc5PjSVjcmw70zwf5+pogcK77B9
	IpRVM5UXo0LN3lkQoQWFU/Q==
X-Google-Smtp-Source: AGHT+IF9TfrgVUORykVTce7191a3DVRE/9T4k5TKiO6IPVD0Tcnhqf35JWrHfvRT7hEOp5LlyORtug==
X-Received: by 2002:a17:90b:50ce:b0:2ff:64a0:4a58 with SMTP id 98e67ed59e1d1-3014e8ecf90mr169087a91.22.1741883438804;
        Thu, 13 Mar 2025 09:30:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301390afeabsm1556571a91.47.2025.03.13.09.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:30:38 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:30:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Phil Sutter <phil@nwl.cc>
Cc: Matteo Croce <technoboy85@gmail.com>, netdev@vger.kernel.org, Matteo
 Croce <teknoraver@meta.com>
Subject: Re: [PATCH iproute2-next v2] color: default to dark color theme
Message-ID: <20250313093035.18848cf0@hermes.local>
In-Reply-To: <Z9LJ_zDqy8iKpX7y@orbyte.nwl.cc>
References: <20250310203609.4341-1-technoboy85@gmail.com>
	<20250310141216.5cdfd133@hermes.local>
	<Z9LBZsdh3PsjuB28@orbyte.nwl.cc>
	<CAFnufp0e-GNCsjXw-KUjnTx+A4TP_gQTW4-HK2T8kYxH-PMxkg@mail.gmail.com>
	<Z9LJ_zDqy8iKpX7y@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 13:05:19 +0100
Phil Sutter <phil@nwl.cc> wrote:

> On Thu, Mar 13, 2025 at 12:41:54PM +0100, Matteo Croce wrote:
> > Il giorno gio 13 mar 2025 alle ore 12:28 Phil Sutter <phil@nwl.cc> ha scritto:  
> > >
> > > On Mon, Mar 10, 2025 at 02:12:16PM -0700, Stephen Hemminger wrote:  
> > > > On Mon, 10 Mar 2025 21:36:09 +0100
> > > > Matteo Croce <technoboy85@gmail.com> wrote:
> > > >  
> > > > > From: Matteo Croce <teknoraver@meta.com>
> > > > >
> > > > > The majority of Linux terminals are using a dark background.
> > > > > iproute2 tries to detect the color theme via the `COLORFGBG` environment
> > > > > variable, and defaults to light background if not set.
> > > > >  
> > > >
> > > > This is not true. The default gnome terminal color palette is not dark.  
> > >
> > > ACK. Ever since that famous movie I stick to the real(TM) programmer
> > > colors of green on black[1], but about half of all the blue pill takers
> > > probably don't.
> > >  
> > > > > Change the default behaviour to dark background, and while at it change
> > > > > the current logic which assumes that the color code is a single digit.
> > > > >
> > > > > Signed-off-by: Matteo Croce <teknoraver@meta.com>  
> > > >
> > > > The code was added to follow the conventions of other Linux packages.
> > > > Probably best to do something smarter (like util-linux) or more exactly
> > > > follow what systemd or vim are doing.  
> > >
> > > I can't recall a single system on which I didn't have to 'set bg=dark'
> > > in .vimrc explicitly, so this makes me curious: Could you name a
> > > concrete example of working auto color adjustment to given terminal
> > > background?
> > >
> > > Looking at vim-9.1.0794 source code, I see:
> > >
> > > |     char_u *
> > > | term_bg_default(void)
> > > | {
> > > | #if defined(MSWIN)
> > > |     // DOS console is nearly always black
> > > |     return (char_u *)"dark";
> > > | #else
> > > |     char_u      *p;
> > > |
> > > |     if (STRCMP(T_NAME, "linux") == 0
> > > |             || STRCMP(T_NAME, "screen.linux") == 0
> > > |             || STRNCMP(T_NAME, "cygwin", 6) == 0
> > > |             || STRNCMP(T_NAME, "putty", 5) == 0
> > > |             || ((p = mch_getenv((char_u *)"COLORFGBG")) != NULL
> > > |                 && (p = vim_strrchr(p, ';')) != NULL
> > > |                 && ((p[1] >= '0' && p[1] <= '6') || p[1] == '8')
> > > |                 && p[2] == NUL))
> > > |         return (char_u *)"dark";
> > > |     return (char_u *)"light";
> > > | #endif
> > > | }
> > >
> > > So apart from a little guesswork based on terminal names, this does the
> > > same as iproute currently (in his commit 54eab4c79a608 implementing
> > > set_color_palette(), Petr Vorel even admitted where he had copied the
> > > code from). No hidden gems to be found in vim sources, at least!
> > >
> > > Cheers, Phil
> > >
> > > [1] And have the screen rotated 90 degrees to make it more realistic,
> > >     but that's off topic.  
> > 
> > I think that we could use the OSC command 11 to query the color:
> > 
> > # black background
> > $ echo -ne '\e]11;?\a'
> > 11;rgb:0000/0000/0000
> > 
> > # white background
> > $ echo -ne '\e]11;?\a'
> > 11;rgb:ffff/ffff/ffff  
> 
> Maybe a better technique than checking $COLORFGBG. Note that:
> 
> - This may return rgba and a transparency value
> - In 'xterm -bg green', it returns '11;rgb:0000/ffff/0000'
> 
> So the value may not be as clear as in the above cases.
> 
> Cheers, Phil

Rather than hard coding color palettes it would be better to use some
form of environment or config file to allow user to choose.




