Return-Path: <netdev+bounces-131910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A598FEE0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7772D1F21B66
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C013CFBD;
	Fri,  4 Oct 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYdlAZ7G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B9F6F305;
	Fri,  4 Oct 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029979; cv=none; b=Ufr25xnhFQCg9ExMvlKX3dv9RPSy/tYl+2Nm2UIIvHCmkW8oFSGW5VMZ1CXXs3T+jRp2PkaEOKlbM7yXVwwuBLeneP8FvalHj84r/F5D/XVGXnPvA70RP/QQ0Eeg+WR+S2mIGRmuTmxoSQTAeg6inEDYVGNGRIQGdt4MZJwmmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029979; c=relaxed/simple;
	bh=4UTXZkIFGFbc0k5aTW5Glndm6A1FS4TT2eFG8lT5SOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwrag+QVCR0QobqJUxjqFCphCbaUlEaqjTlGFzRrDDmtUscK/Uk4wIv0o/dqGv+3xlYzR0gzmYA0Ejrxz+sOlizDqrMomONIJDpQDHlTGru4FyoGblfh5EDKma11cILh7hZJxuFqLBHEnqq444bpTqz0X61nHvh7Q0n7rsMCCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYdlAZ7G; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ccbd93c48so141030f8f.2;
        Fri, 04 Oct 2024 01:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728029976; x=1728634776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LImwOZEfhpoMkP1/IM/x4FXT4qsuxZjmY2D85dNagIY=;
        b=IYdlAZ7G0vl6UtLrKY3rlscM74RhsEsSyIXYpBZbBAj36oluquKcQ1pwTWAo7MJ7C3
         MImqFi25Rso2zaZA9aIYukyL62+MvMP3M3SyXUNBwvVvTUPe47p7RzwXt/gVYnJvcZwa
         RBf6Sv0ucGYQwqt3mPD9tusFtQ7X0+2KHbm2D+KKI3r3//Rmq8r4FjtKxfsHXpiQqNem
         0zysv0DczLI+X/U8uO5hi7Ce9+gff1gfWHY48P2rOK9Su6UEMyAvMKpBp6C0ksh71pa6
         0dTJp7zGzQTBBY9z9S5P2z6633YNb2Zd4pa02w+6/8D/PWlTVJdEiht8zk+dXoUUxMVR
         CSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029976; x=1728634776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LImwOZEfhpoMkP1/IM/x4FXT4qsuxZjmY2D85dNagIY=;
        b=pHZMbVpObuM/AHDqqftcciIs+IYDyZNvc+Vt7jt8Sju8SH+bLMblURz+hAf4UGqVt4
         JeoYFzGtjwhP3girn5UGVUEBw7jhRxtYu1+vZYzSOKtIJFHCUdKloAZjnoUO/7wo5eh2
         2l8C+LOo2/y7m2YoDV9dlqc5pRCjaZZEjWOW9hORRgOGgX18yv8rUSsB7dwoOfddVLeF
         M2HtCjGptWuGmHlGELG/iAtoSdOaDThcBotefKj2qr8YFLNatUM9LL8xj5Qkc9eF5Fbe
         sJWZQXZwYIF9JaR6uM9MRvY5gD0V60sht2+zzbnaUuBZa4gvnqt1YWzgB+FxawUkRpUj
         HAfw==
X-Forwarded-Encrypted: i=1; AJvYcCUSO1UP4uEFtU3gLgiyTzxbk1UF1929Ls/TibSyQFDTdz0nAXzZR4XvTLGg0tc/9HcP4Plm6bUu@vger.kernel.org, AJvYcCXTD5wed+zgMl+Smoj1BgRPM0BKZLOJl11be4nH0XTprBqUThyvcmrmhK61rEL3dZqDMlPlYFllvbHwdEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysKf8f78orocVxlEDnGhB00fMjGuZIaedRCvTvq/Xiz5wYrMWt
	SxtCmONhyD7YsuhaIZOB+qbNnKwNYFtyS9zSopviM1dJ7Ye6t1TQ
X-Google-Smtp-Source: AGHT+IHBkTy0pN3h3HdI8NlpobpwEHwPrlOrqbpXIGgda96ZwkIm8ybi7xMUbmCvfWiQRaWpeOpm+Q==
X-Received: by 2002:a05:6000:186c:b0:374:c800:dc3d with SMTP id ffacd0b85a97d-37d0e6f362fmr595966f8f.1.1728029975832;
        Fri, 04 Oct 2024 01:19:35 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca4f6ff5sm1584702a12.88.2024.10.04.01.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:19:34 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:19:31 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: Validate PHY LED OPs presence before
 registering
Message-ID: <20241004081931.srnluq3f2gma6ohe@skbuf>
References: <20241003221250.5502-1-ansuelsmth@gmail.com>
 <20241003222400.q46szutlnxivzrup@skbuf>
 <66ff1bb3.7b0a0220.135f57.013e@mx.google.com>
 <f275660f-79cb-4044-8f02-c4341bdad6e5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f275660f-79cb-4044-8f02-c4341bdad6e5@lunn.ch>

On Fri, Oct 04, 2024 at 12:51:32AM +0200, Andrew Lunn wrote:
> On Fri, Oct 04, 2024 at 12:33:17AM +0200, Christian Marangi wrote:
> > On Fri, Oct 04, 2024 at 01:24:00AM +0300, Vladimir Oltean wrote:
> > > On Fri, Oct 04, 2024 at 12:12:48AM +0200, Christian Marangi wrote:
> > > > Validate PHY LED OPs presence before registering and parsing them.
> > > > Defining LED nodes for a PHY driver that actually doesn't supports them
> > > > is wrong and should be reported.
> > > 
> > > What about the case where a PHY driver gets LED support in the future?
> > > Shouldn't the current kernel driver work with future device trees which
> > > define LEDs, and just ignore that node, rather than fail to probe?
> > 
> > Well this just skip leds node parse and return 0, so no fail to probe.
> > This just adds an error. Maybe I should use warn instead?
> 
> Yes, a phydev_warn() would be better.

I'm thinking even KERN_WARN is too much. There's nothing actionable
about the message.

