Return-Path: <netdev+bounces-105261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0981910459
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9718B1F21AF3
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBF11AC45D;
	Thu, 20 Jun 2024 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjBfPUmu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEE1AB535;
	Thu, 20 Jun 2024 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887467; cv=none; b=T4U9yPBkhHqIztvSq+jQKartltoYSUw/c2izhMgFPMZ/LaT8FgBM464p5wNqPG9mMx+pR9ugnczC8T2+CUlWePQ10CEqhxBKcHi5g/HfYqsaWoMpbb2YzbH23yabPPIu6eyVFHXmcN8oXyLQ50aqJkEUheugV7CA9pFcSE5DGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887467; c=relaxed/simple;
	bh=aSC5gAEuo+17AApFM02LMGmVjewHh4JOENAxGeAwYrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwV/i4Kvwk9BqdMKnFchMn1JH8MAt1Zi7D5RuSheYOya51i8oni2NYZU8S6UY0aYZMz/q7XTiAZnfRqsluTkzZZeok6I4AlZnvU9FCxU/4Y/4Z4xX5t9ELPlrono06JIlXcNeSJSg7iwcKERee1gYjdEP1n+Xej4PgRhSgaIbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjBfPUmu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6efae34c83so90322866b.0;
        Thu, 20 Jun 2024 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718887464; x=1719492264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5hZUtf18KnDSlJi3/uUhCOdxjhDpRWrJDCPpp53S6Wg=;
        b=cjBfPUmu7q2TT29GBmFqibOBG3avbMe2vunvcLJ9IUtxBbXsF12UqS+ngdQQHbd9Pg
         w7bZ+7OzNeetC0BW0ekH8G9uwCVZDEAPW+fqi+NkaRsQvOOU5bdgfsXtRF4X38LZurDy
         E8Hnqn+gjMDQxVwlX/+yyH9yxcT4l24SIMoCq14HxiW2D2Zqj2vnVhiosyXb9KpFLCgL
         XA1N+pZMoNPxwQT9aGGPjQQcPF6GteLPRAMyTlK/wvQBYC4JdcGXf42ib02F808TjH0I
         By6gPtsZsVVhUbjRsrx4oBtcXmEbibuI0C23Mkb3VJQR8hPZcl2uFRbQGjUMgd1sxlXf
         mn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718887464; x=1719492264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hZUtf18KnDSlJi3/uUhCOdxjhDpRWrJDCPpp53S6Wg=;
        b=B+GVCBnar7H8V8tBHxB8eLITQjR1SKMDJy1d9cwoKIeZLQjhnTk7f2gFum7aXxVXIN
         iYZhItX7pgLvYpMtb2OwpNA4Qa6nFNaIUAYc9l0pYDIj9369Wp4Ta9b3VZR4l285MutK
         zX5n1GAomwb57FfJGJQ5M03far/b0LPPw5fzsz3Y+LVZeHRFhvc899kyqeInReyx3J8T
         IxV3lnhkojT1X4DJQWfCph5ODnuyzlkPjZpI5hzpmiB1rSv4fjCf5zDQO9p1q1MX0N0F
         g6XVAxyz9ovX2FnKo16WIrT9wiu6M3X/n1rHUChNIKvuivsxPvnLP1kZo+lncDVz8/Ah
         vJlg==
X-Forwarded-Encrypted: i=1; AJvYcCUHSD+CK7o5o8K+Cn/ri7bYiWuyQfdCcaYECHbG1Qc5MZPIDaouHaNzC0iUsQGeBDN81qMX7J0dHiV76j1+Dtv5pSUTTtisAbPGOF04
X-Gm-Message-State: AOJu0Yz+G9FHJhQ2xkOAmCAT676eoemr4h8vofkhTL7gYt72FiAtITAW
	br8znp+GlX4YpocR3pgku75U6Uodsd0eiRY+88+0+kyN503FVhyj
X-Google-Smtp-Source: AGHT+IFlQjLQI+Zt+NYhzRC2Z9MC4pXCM8/A3YX9ZeK1C6MNL0AwMFiRU3qgP3G8MWu+pCBxU+WwiQ==
X-Received: by 2002:a17:906:2602:b0:a6f:4de6:79f with SMTP id a640c23a62f3a-a6fab648b9emr246779566b.40.1718887463592;
        Thu, 20 Jun 2024 05:44:23 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f5731cf4csm757579166b.188.2024.06.20.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:44:23 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:44:20 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 11/12] net: dsa: vsc73xx: Add bridge support
Message-ID: <20240620124420.o5hlhuhidx4tmdhg@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-12-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-12-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:17PM +0200, Pawel Dembicki wrote:
> This patch adds bridge support for vsc73xx driver.
> 
> Vsc73xx require minimal operations and generic
> dsa_tag_8021q_bridge_* api is sufficient.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Other than that:

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

