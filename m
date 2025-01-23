Return-Path: <netdev+bounces-160599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22162A1A7AB
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E183116A9A6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6048A20F973;
	Thu, 23 Jan 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESNr5NWU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3BB21128D
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648942; cv=none; b=Qw2gccmGcHRyKpfa1KisAaKHLDQrpScYy/hOVsUQJ5iP56dso2GF2DrQIdGDfil8Sz4Y4PcB6nzIPxKQw5DpE0fdLK4YzBYoRRejdZ/HQgWvIEy5P393hbM/NV6bMnKFXe1SGCgLLfzeN00u3i2u47l5HDV5Yx9s4HpeuY7grP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648942; c=relaxed/simple;
	bh=9tZTwvGtrFbcipES0puQkHMgI/T5IzBiblEvYyhIkN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQbv0WW06j+VokyG+TztTFzPVvTfxcvuM/vXqFWen89ayl2YZRz8WmCA4+2dqzwosot9N7kf4Dknh40XfbdQlq1CrgqOTXtBZH0HARIjfWcXIkJIvPzBaJVzEWvdQI6jMestwDJ5OnR1xXM6plGKiA9dpJZLoECoSJB8yrWMt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESNr5NWU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54021daa6cbso1241530e87.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 08:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737648938; x=1738253738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeSQ2W+G11CVkxR7Xxg8xvBuhgZ/U8B4DrUyFkVVQcE=;
        b=ESNr5NWUPNFrf1qod5xikXHReTzZhs/f4jCbVe4w7cMhzr1f/sJQb5ePZ9tDWO+zG0
         2fsvPivrNEJFGw/0B1kCGYJOOyoddfRTsOh+2+etNBh/i6uokCxhrOvt3orD+pbqYrDb
         FjSIRLy+3Y8+Hd5N7eeiuqib/0VyA0Umhwf9/60PQtkWZMvosKt3g2IcAsqWGep3LeaD
         OQRNOhoVkM+gc7c7pprpo7pi6FoyRGN41KtSbqPN6qCvGws7eef861lj/2jljCQFMvtH
         7fQsUjeDEDpmoeGRXd59zYEn1mIOBTe7D6r67WaXQRXO1fxojNCNlPETYle3JVxkVk7d
         pv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737648938; x=1738253738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeSQ2W+G11CVkxR7Xxg8xvBuhgZ/U8B4DrUyFkVVQcE=;
        b=dbjE8Fh/re/JTHqLPj59Xxq7/Hodop9RWd8ML4lOlYFweOjAWzWHELPJbppqS1UR1q
         Ev3E8Ir/eAZ4RTIvhHmlNpEC3aVt9KYZL5W8xmCTqDKDU0L+ZVckKIHVkF9pkkmS2LIX
         s4Hl1VJ+oyXGgOavyYolqqLkA3bMjo3bh5zugSzKkDToGnxwjMQ9svaY8rSuWoFTxBhj
         j/CrnuDIzX0sLGvI4Wy43BOHFIfqltojvZcZ+qy8JWTVNJmFjbBxDnNhpHaOn3y3udvS
         5oygV/5m0WKtDKhfWZWp5wer0SZEGKppAjFheu8+baZU/fN2sH7fHr0tqAzVYH4+93wC
         xobg==
X-Forwarded-Encrypted: i=1; AJvYcCVMrk3arAuWRq6mgkbRkRpjZr7YpUOD/0SpSXGhk9+0toMD8WarqPlesGOvTg6ymp0HY/tiX+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5svsWLe6j3ZzFuWblfWqAj5aovTvgvTh9WCmW4t1Zpy9bs1h
	aHJVR3XoIZQpZg86gndsPE4kyjdu8N+ZAFuEwbl/cl4TYcOuNzqhpud10ExR
X-Gm-Gg: ASbGncvrP8jyRN2+atCQOTnh+g2bOH5tzPg17bsjYaaCOrAv8HO87s0l5Vx7SNn20ms
	v8Vfm77w3/NKKuAeGHPrTgnicfN//C2XZgme2oIqIsreGipPuMFmxcPslc/DoqFF6B3owUYwYrG
	sgtM5bNjkmPI3QsCBKmnLOhMiEOSM/juOcykyloYWmSEbQxEzXRDfmlWFdvFZ5TDx6fUKqpnIsd
	fE+UMjpveQ558EYv047pCT0QO2tYowPqtxxUzEVTeXmD+aQOC5dTZDZdUO8JWB1sHFf9IGomO6b
	HxwKZaJCtDWF8u6rm/4=
X-Google-Smtp-Source: AGHT+IEijHZZfQDEkdw3Z3/hcR6NAGod+IsSaNp7AjV0RGiWS4/iEiSyOfxAeGtGjE99ibcgcmDlsQ==
X-Received: by 2002:a05:6512:3f1c:b0:542:2e04:edc5 with SMTP id 2adb3069b0e04-5439c1be1d6mr10534955e87.0.1737648938047;
        Thu, 23 Jan 2025 08:15:38 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af62dbdsm2768346e87.144.2025.01.23.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 08:15:37 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 50NGFY3D007138;
	Thu, 23 Jan 2025 19:15:35 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 50NGFVbe007137;
	Thu, 23 Jan 2025 19:15:31 +0300
Date: Thu, 23 Jan 2025 19:15:30 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
        sam@mendozajonas.com
Subject: Re: [PATCH net] MAINTAINERS: add Paul Fertser as a NC-SI reviewer
Message-ID: <Z5JrItt/Z5RIv83B@home.paul.comp>
References: <20250123155540.943243-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123155540.943243-1-kuba@kernel.org>

Hi Jakub,

On Thu, Jan 23, 2025 at 07:55:40AM -0800, Jakub Kicinski wrote:
> Paul has been providing very solid reviews for NC-SI changes
> lately, so much so I started CCing him on all NC-SI patches.
> Make the designation official.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: sam@mendozajonas.com
> CC: fercerpav@gmail.com
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c024ca276e5c..d97df77a340d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16148,6 +16148,7 @@ F:	drivers/scsi/sun3_scsi_vme.c
>  
>  NCSI LIBRARY
>  M:	Samuel Mendoza-Jonas <sam@mendozajonas.com>
> +R:	Paul Fertser <fercerpav@gmail.com>
>  S:	Maintained
>  F:	net/ncsi/
>  

Reviewed-by: Paul Fertser <fercerpav@gmail.com>

Thanks for the positive feedback on my reviews, I hope I am able to do
no worse for the future patches.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

