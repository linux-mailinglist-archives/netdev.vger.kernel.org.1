Return-Path: <netdev+bounces-140427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2349B668B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629251F21AA1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EF51F4277;
	Wed, 30 Oct 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn1XKgFN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A511E9071;
	Wed, 30 Oct 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300005; cv=none; b=Dv9424s148gQQP9NCtgXpLIyEqioguMtJwZgKvFclRS5rAtNAr/1aNyz57Pl8fNqO5OUWlGnC2w6GRyfe/sa/LA+79ioPughrv5FlWwDnEL5frfhRbxDYEO4M6rGcQcgMPBPwDKh8M+BJaVZvSHpxZtLTwuRtrZu10E3/5Ya7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300005; c=relaxed/simple;
	bh=0KmdwmGaHffLEA6SPWvkmiakFdh9J6nLYLces2WeUnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH1XST4xYnsDa6BB+JdD+XFS7v1rRc/mi2zri5ovvIwn8XTtBchj0Nx+BVY0pwc0+LF4UDvNxb/jqri5JMwBs5KO7C1dbVqtmGvBtkqM79vyCVSzXLjNN7oGtb9iIyLaTf1TJLrDr9APaj0dTqkbcbxj95y7RE2mJZPrcDa6mwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn1XKgFN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315855ec58so8215785e9.2;
        Wed, 30 Oct 2024 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730300002; x=1730904802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlskkeRUwtNLu3nkD9yQJXhTHloOmWBDLcwuQvdxQuI=;
        b=nn1XKgFNGkPuYE7PALv0SBEFU/8wZpr2m/Mzu9c83uolimxqRaBLUvZcqgIElWJv7i
         smuV4X5BEppGS4SMlBaiFXL3Df4GMi8auQ+BOwNAjR+L3aderpXh4zjJI++sHyu1HP6E
         mdNk/ae5JoGBN64380qrXhc1ubS5z7OtHiw+O5WmEnZ5uZyVZm1unPXFRUAv8qc14FlQ
         KF0jL2tw/7m69iX2H+KRzfCepbbGZZa/ip4hee5SlQXa4OW/mNIZkSxw+P4Vpx5P744F
         yQWf/n9DQxUD16Dy2vPBfXk8Hr+K4D/cetsbJkT4te6wwFjS4g+4jHaybNF4NmXiKpLx
         QKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300002; x=1730904802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlskkeRUwtNLu3nkD9yQJXhTHloOmWBDLcwuQvdxQuI=;
        b=ZWSBt6rpqVI/NcLAOqH+StgzyUNv3jiDTaGDlFZ1rS7jGPrNaT44cPwJy+JZiaSRbD
         ZpY5+Sxv/Q3gmwJU6tvWdpk2h8IxfRUk3ANY4vYz9gB8Slzv4+wEsdWB1gjuChWTzhUU
         /8iCn/1CqUpRUS/93o1gmHWSyCk2p+5T+iN10bHLWAVskDgyVJ6yKG2yvRLzLvy/nrBN
         syu7+dRMzneK77E3kO9sSxsSYPD46gkVo7nMbE4uGHBx4ZlbapNEBl+ES8DXgyLwxwYz
         VEaQAdu11w2ekvNVQXlcUnfdJQ/hxSV8oWNbLyage7v88nSqRqShXBW6xdciRta3vjvb
         GdUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFk+oz6CbkqdfYBv6NoeJHdUerm1n9kt8Mof+L2wMLer1ROuG0OyCLGDZOVkMS5m4MnXFBst1RKFrrpT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWql2h+DU7pS9COlFIoukFHfGWC39qzTdyjbGO2to1QetDgdNn
	xL4YgC7uFCbfVVPZriv5h+kwQc+aO5S00HJjk/5r8fYNBqEFpq/awbS+0JTuaI8=
X-Google-Smtp-Source: AGHT+IGg3ns6Q36hude1m8Kr+AgT0zYbZ+xfg23M/+7x2R/Akg1gbAmCiIcDBlWMFI0hRGHfSXfWgw==
X-Received: by 2002:a05:600c:5121:b0:42c:b63d:df3 with SMTP id 5b1f17b1804b1-4319ab9776dmr58381655e9.0.1730300001577;
        Wed, 30 Oct 2024 07:53:21 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9181e7sm23692315e9.1.2024.10.30.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:53:21 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:53:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: Remove self from DSA entry
Message-ID: <20241030145318.uoixalp5ty7jv45z@skbuf>
References: <20241029003659.3853796-1-f.fainelli@gmail.com>
 <20241029104946.epsq2sw54ahkvv26@skbuf>
 <20241029003659.3853796-1-f.fainelli@gmail.com>
 <20241029104946.epsq2sw54ahkvv26@skbuf>
 <d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>
 <d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>
 <d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>

On Tue, Oct 29, 2024 at 09:05:51AM -0700, Florian Fainelli wrote:
> On 10/29/24 03:49, Vladimir Oltean wrote:
> > This is unexpected. What has happened?
> 
> Nothing, and that's the main motivation, most, if not all of my reviews of
> DSA patches have been extremely superficial and mostly an additional stamp
> on top of someone's else review. At this point I don't feel like I am
> contributing anything to the subsystem that warrants me being listed as a
> maintainer of that subsystem. There are other factors like having a somewhat
> different role from when I was working on DSA at the time.
> -- 
> Florian

I see. There's nothing wrong that priorities change. Thank you for the
benefit you've brought to the DSA subsystem with your journey, starting with
transitioning non-Marvell switches to it from swconfig, to papers, presentations,
being nice and patient to newcomers (me at least).

I kinda wish there was a way for people to get recognition for their work
in CREDITS even if they don't disappear completely from the picture.
Hmm, looking at that file, I do recognize some familiar names who are still
active in other areas: Geert Uytterhoeven, Arnd Bergmann, Marc Zyngier...
Would you be interested in getting moved there? At least I believe that
your contribution is significant enough to deserve that.

