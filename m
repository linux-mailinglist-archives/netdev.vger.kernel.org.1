Return-Path: <netdev+bounces-153389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7032E9F7D37
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E587A244F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CBF22541A;
	Thu, 19 Dec 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meVhzx3Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6F224B1F
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618762; cv=none; b=QZUD2l3ppmSjIN6OOlpNp+wXExSZ/Ap8wDw1u+NgNAq0c+mFWTX6HzV7sLz0B+cHcDlsI8mD8V2Ba+SG0EOoSTcHfN8SbRgcVEP394AjqxPv/KfXBJeAKWmEAISnhuXg1MeYHdABohc1pOXK532a1ZGnlOGEvCUlPpuWrJNzs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618762; c=relaxed/simple;
	bh=GDLNBO9KONLxaO/hF9r7/PwCaxFsHJIDi/hWvZHEfsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oApxa7GkdybnA6+rzTqoAQA/AoSQWFFt7bof1iyluskWIP3PYYo/ePiiQxShlDHe4jbrgSzgqqOiMM9RSSl2h/afd4SNGIrWRZ1NI7yZPsPWNlXbhewMcA3Lq5nS6XTLGu9lF8ww4mSmfztybLOG6+E44hg3s3GDiqJFI2JJcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meVhzx3Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43616bf3358so1074295e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734618759; x=1735223559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+dk3N+HHYD6zrrPuhoT8/nZgmXq5JRYWRJpG0/dhv4=;
        b=meVhzx3YvPhDyEhPwF6Fjyyup4L7+VvW2xhL9Yf0qUP+WREHBrttA4N3ZuF+MWcnB8
         gX3enKRk7JsObnT7ok9b4HiAbrohlan8yEhpT157AAm8jTr/Nz+CcW2OX8mH5JVoCAX4
         SpejEspkM1RqZMtKiuNEb/lEZI2TtfSF9bXXoXbEfk4zzGmCqgtj+0hXlWUXwohZZmAx
         TlpW62GY270RJUAexENMtbFL5PDHh8C5AyKm9m8RksxzlaY0kbgfP7h0OMT9f9lLCUoF
         MIyYv8hZMO8PyNKNNrLMhLI4fZFpPrWxLZWvhfsGhcC0SMcEXWCL7F9xboCu3cBEH1R1
         K+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734618759; x=1735223559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+dk3N+HHYD6zrrPuhoT8/nZgmXq5JRYWRJpG0/dhv4=;
        b=DldnOgMiKPaN2Sno5W5rZvuZtwUDeD6627nRM3FPTBN+tsQjNZrwu7S+MXti62g67I
         W5h+otML0JlQNzE8bmroiClB6bisKrjvTWznhfU3eshYRYYGqOuHxm5MVQIzAu8mX6uK
         fGbfVEs1nO1rBjXHktb13iMCIClrZ6DHgmUgPLeCpRzPyGjtrnkdNFQ/Fir6TvZv/wCx
         nXr9fflE6HD7YmTB1BzRuv8174z/PasIDfYQu5/RDYhOL2fzZI/VIHIp2dtJYNNGxFsL
         CQmFe/H6VAbrwTPKKcoSG3E4UDWRfQKKbXbBrybEzzyCVs6GvBpRCXqEmsN4x6gH+k+o
         PTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQqQNJ96XY2sTWcd5ngbvxZa+zDmxEgOIqxAEOnprNn1JVhHxH8sSnwyU/rv5ePWxQUrjlXlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4m9WLsvWHspksnFuOVxECVLIc3MdCUqO30Byti2FCp461excq
	/DOwdRCFcHn4U7yCOIoUgLqRsxe3cf5Z2cVb1RvSeHcnZ78+A9Qi
X-Gm-Gg: ASbGncuVMne26g2XV+nihW6A5ixIyWv7edEtTjaUVjXALRUOWMSnD8PAuUsI5Hg3Ukq
	GylCJJZEJEmsX2mEW6kQ5Ab/13uyLa89dTgIKlylL7bG+D9ObfGWwSgwwH0lGwstxCCt6H1+VH2
	BlTVvVdALgNH90oYjvgbputeaQpzALEuMHYxUXNeORU1CRzx9B/nozNdbwZ3aPQEfGsfEywP3kw
	Gew8MHux4aBdHjidOCSMg4l0QVvJv9as8dPTeZw4zVr
X-Google-Smtp-Source: AGHT+IFv6RdwzM9E8tPoWe1OXaeqKMVFR2ljyeZKhRLx8vftBv+ATwK9WQDG5ZKRj8NMBTNQ/pqGEA==
X-Received: by 2002:a5d:59ae:0:b0:385:f3d8:66b9 with SMTP id ffacd0b85a97d-388e4d92380mr2310185f8f.11.1734618759235;
        Thu, 19 Dec 2024 06:32:39 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847263sm1682892f8f.50.2024.12.19.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:32:38 -0800 (PST)
Date: Thu, 19 Dec 2024 16:32:36 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 1/4] net: dsa: mv88e6xxx: Improve I/O related
 error logging
Message-ID: <20241219143236.udpywj7n56qahfrz@skbuf>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-2-tobias@waldekranz.com>
 <20241219123106.730032-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219123106.730032-2-tobias@waldekranz.com>
 <20241219123106.730032-2-tobias@waldekranz.com>

On Thu, Dec 19, 2024 at 01:30:40PM +0100, Tobias Waldekranz wrote:
> +int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
> +			u16 mask, u16 val)
> +{
> +	u16 last;
> +	int err;
> +
> +	err = _mv88e6xxx_wait_mask(chip, addr, reg, mask, val, &last);
> +	if (!err)
> +		return 0;
> +
> +	dev_err(chip->dev,
> +		"%s waiting for 0x%02x/0x%02x to match 0x%04x (mask:0x%04x last:0x%04x)\n",
> +		(err == -ETIMEDOUT) ? "Timed out" : "Failed",
> +		addr, reg, val, mask, last);

Would it help to use symbolic error names ("%pe", ERR_PTR(err))? You
wouldn't have to single out "Timed out", since it would print -ETIMEDOUT
and that should be pretty obvious already.

> +	return err;
> +}

