Return-Path: <netdev+bounces-143435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5839C26D8
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F566283ACE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2062E1DC06B;
	Fri,  8 Nov 2024 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1JIwwOr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1A17A5BE;
	Fri,  8 Nov 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731099238; cv=none; b=VNYH3DrvmwIG132lUlOjHdv2BMxjS1hQ6YcIK8oiCdEH8ojNA2hU1rvbvlQ67BT6qvL8STDXKHOimFUES1HEuA0QLg1OkQHO5oXisuFtiWQpDYjRCy+GVDK9Xd4ZD9xbDO23ToD5g8pdZ857uo887ZC3UynnHK7o9MKd064yb6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731099238; c=relaxed/simple;
	bh=rGZElNXOLpm86tYiYM3pDUvc0HnWSlCcfHDqSnek0x4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWK9gyMaHSXtYv+Aw4jGDxeOjiuwg2WkbSgEOXyizLkxWY3CZY8gA8Z5SMLl8Ob6kRHwQ+nuI6JfnVKyhMRolD7d2cOFzowUGoiv1dlmEYeQSLIamjnY1SpqN0xyhENa10/QfYa/mPH1IdwAmVlGr0T4foJinbekftRwEUzTsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1JIwwOr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4ba20075so1731705f8f.0;
        Fri, 08 Nov 2024 12:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731099235; x=1731704035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=brPQjckqtPW3AO+5ZbnscRXvIgv3Drh3lT0oN9Rl9jY=;
        b=F1JIwwOr1zYUSqKzweU9yWya0cDt019kJXxINf9rxNGMLPfqPQAofwikihh7r4TcmD
         DnY5WVbCAUDipZL015VYEOqVNhTwEfpITt2zpSTNt+VPpT3eVQ+C1aS7XDg5O+S/j/Q2
         9bIspxOzj8g+TghLsBwUfi3wSjmKLPTNIgYHs5VJvBCpSCRAyJTxMLAkqS2gZbPoYxc3
         fi2X4A7x5hixG6kZtdVfjKpY/4f76PfcY6+dAvF7NBd40OLIEC6leCVnrVDSDrN/KpGs
         NcnuISAwNuitXSKXOU9ERlFgX0mqtw70J2Uyy+GZ5w1EY1DZ97vV1Rg9bsCbp0hLd+hP
         nRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731099235; x=1731704035;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brPQjckqtPW3AO+5ZbnscRXvIgv3Drh3lT0oN9Rl9jY=;
        b=skXUxn6HiV4GDb0tCM1Xkf/Z8SmYDHxb+NpAyWO+2NAJCjR9nfA8YYf0HXbTcHjg4Q
         NfuzVLyxGlUTkyZ+sENESqAnjn0WFndwrWbRjcq5GeTNepcY22NSaj9I6uEpoBqXnZFT
         YrGFfEWUlityy0ZPtd0bzvW5cxRtL11SiQ9sruVj2DbSlIHF1bumEIaVkDRLgUUopptr
         /3YDxghChEujtFWsghEGwHiqOl3qawGryym3erJDNkxeVam9JH2nl2S55CoL4PUAa9yz
         ujQfav+yAu7TwFX0Sh2eX3hao5rl1dJjy1E9n7VKLeGPY24ELsVJ3Lc1Tajzzb2JTS15
         vZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZIHSmU9xl/laWop8V3dWXLPnyuSlIeW/varfoyEoXXRsznI+q6Swr3IeoV6JZdGqQXxt0QZwp@vger.kernel.org, AJvYcCVYfaaFbg7dSinNSqKrYQoA9V8jMiWZKFiX5gHGMgVKZUvJ2nDJSH9raAzDwouOOT6osVRGMgGoxWKJteY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9leqaOwroa4LjQRxQroyy546snssFNtk50vaK0fMDWdeSqwD
	OHNW7irwIXzMQ/r4nAsfoimsuUsUNiMtn8Rb+WyKQ4F4k1WeozAd
X-Google-Smtp-Source: AGHT+IFpl5t82Llfc+XwQullKIKrtWSYhB7FoN7oNzFVb8p5u2cZzFnTNTkybrMau3k93tTb8+WvyQ==
X-Received: by 2002:a05:6000:4213:b0:37c:d1e3:ebd2 with SMTP id ffacd0b85a97d-381f1823488mr4020744f8f.29.1731099234516;
        Fri, 08 Nov 2024 12:53:54 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0530694sm85649655e9.7.2024.11.08.12.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:53:53 -0800 (PST)
Message-ID: <672e7a61.050a0220.1d1399.6d31@mx.google.com>
X-Google-Original-Message-ID: <Zy56XC8ipzb8Qpdu@Ansuel-XPS.>
Date: Fri, 8 Nov 2024 21:53:48 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [net-next PATCH] net: dsa: add devm_dsa_register_switch()
References: <20241108200217.2761-1-ansuelsmth@gmail.com>
 <af968377-d4c4-4561-8dc6-6f92ff1ebbf4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af968377-d4c4-4561-8dc6-6f92ff1ebbf4@lunn.ch>

On Fri, Nov 08, 2024 at 09:35:32PM +0100, Andrew Lunn wrote:
> > +int devm_dsa_register_switch(struct device *dev, struct dsa_switch *ds)
> > +{
> > +	int err;
> > +
> > +	err = dsa_register_switch(ds);
> > +	if (err)
> > +		return err;
> > +
> > +	return devm_add_action_or_reset(dev, devm_dsa_unregister_switch, ds);
> > +}
> > +EXPORT_SYMBOL_GPL(dsa_register_switch);
> 
> This looks to be the wrong function name.
>

Ah... Anyway aside from this, is the feature OK? Questioning why it
wasn't proposed early...

> 
> ---
> pw-bot: cr
> 

-- 
	Ansuel

