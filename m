Return-Path: <netdev+bounces-111478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E6931469
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038B01C216AC
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DEA18C199;
	Mon, 15 Jul 2024 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diP0rJ8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE54C66;
	Mon, 15 Jul 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046988; cv=none; b=I5+gTyrc/BXIiu3HN+NaBaMjDS/rD1vH6IevHM94Ty5zEZ4/HLnkQwG9Gg9V9lADU898Iqnps9urYjddx1BwyPh8zfS5O9tamqZvuB9g5xwvX9Uz8HV5r7MO6+hbJ2SQRXY8NdjmTqezz9RP0htV54uQI7ZGs1AjhPdZQv4KH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046988; c=relaxed/simple;
	bh=OCLY/jJSo4MO9ry1TAWphgYOa0L1YgPDk0Dml1xnlEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLOCWGrNS6pqfyeUKPObt0qYzU41hZVT07PryyxIKazHh8Ma0+5z7MgA16E+RbyfZ/qH65BJEJq9qjPNMqSg+k/3i0baI/rOe4Bnk7YjpVkn31Z7T7EpJ7/gVvP7dNCMsel5Fd/ZvJXRB31QmoPc6opfp2+wtzrxhxxwHOlGx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diP0rJ8c; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-426636ef8c9so28351745e9.2;
        Mon, 15 Jul 2024 05:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721046985; x=1721651785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt7ZxLBac9YIKiH2x8RSDRfj7SUv5FljeiparI/YinU=;
        b=diP0rJ8cpEsxmnSNVTdKuQuK4xTV/z38iWlZBnLxaMdIJhY/EZgQ+ujoK7zYyM6BGy
         TE2GSPbb9pFjFJ/OhVyF3bqo5EANm/CXwQ8f217wg8TDFUL/qjrFFwqZ6XzQT9hyxccd
         yaz/oGDkiJcLmwDb1J5u1r/hk88ghRgtfgn3BZrFt0Rz/L+/Oxiigp11F+0YwhZz0YqZ
         A7K1koZnRHzKbyvyrwQqyDwT6y4eOAsVbgCjwNXCm75Zk/jqMGkUOVEFnVWvsIoJYN2o
         9bdbcVw9v7f4VkbOA+uH5zfbDjLbvqiDrV75kWQiMFLNVcx1tCa2TXLOB7/65qiigTtW
         C1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721046985; x=1721651785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mt7ZxLBac9YIKiH2x8RSDRfj7SUv5FljeiparI/YinU=;
        b=RI+40UvRSx8LZFVrhaCzSji9y1TFegWiQYO5oI/GXEH0PaGyb3PnfDbGCoMnlzKqai
         cb4e59u8b0yjANu256FLg6cKaPDniM3uYue8lorqP2jJ7QDVpC4bFSGPjTmTZaB/H79Q
         XEw0WTz/mwTCb3z2Z/l1iietETjwFkj5kfOGi0YbXNGj2etiVnljBu3m41ZGpuYHvdAW
         Js9CkgrcwJdupqUvfrKaFk4CpKpyYWgrV/apKdeJ4hgHKPgDrZpnU42I1XrFBuiAs/6x
         Yd+1BjoaVE32iB3492NMyeGaDMeT37mGNUuB1mNYTuo0xZar6mWI8wNcJs4dB1zx+WpV
         FT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNfusO7wni35Op8WqqBeGIXd4sy8mC56UBc+RwKTkuqVc3R11K8trt4qRHJbKZhNe2tA6TYpKX9qQ4Kw9+vkHXWgkggjq0ywU1NoeheGz29neORS3HkIVdRjQj050YZIa4XCKX
X-Gm-Message-State: AOJu0Yz6ezoNcaJTFQr6oay5ZtY/Vf3YghrqH7W5MjekA0IX3vnltxCb
	nqstIKaAXxcMQXIvtTnVzjH1kLqFVXrsidI7nQX+lW4RmqHJ+ufu
X-Google-Smtp-Source: AGHT+IFObgaoMCVQ/7Rh8cF8m1esPsmMeRw5gzaOD+nzocKyphjJOBG5NBKaJox5FN9hDrA3hRg65A==
X-Received: by 2002:a5d:50ca:0:b0:367:926a:7413 with SMTP id ffacd0b85a97d-367ceadad63mr13076108f8f.63.1721046985221;
        Mon, 15 Jul 2024 05:36:25 -0700 (PDT)
Received: from skbuf ([188.25.49.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccac2sm6257558f8f.56.2024.07.15.05.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:36:24 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:36:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Eggers <ceggers@arri.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Juergen Beisert <jbe@pengutronix.de>, Stefan Roese <sr@denx.de>,
	Juergen Borleis <kernel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dsa: lan9303: consistent naming for PHY address
 parameter
Message-ID: <20240715123621.hkb7ntjcigxdkehn@skbuf>
References: <20240715123050.21202-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715123050.21202-1-ceggers@arri.de>

Hi Christian,

On Mon, Jul 15, 2024 at 02:30:50PM +0200, Christian Eggers wrote:
> Name it 'addr' instead of 'port' or 'phy'.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---

There was a small time window in which you should have sent the patch,
after the 'net' -> 'net-next' merge, but before the 'net-next' closure.
https://lore.kernel.org/netdev/20240714204612.738afb58@kernel.org/

You missed it, and so, you now need to wait, according to Jakub, until
July 28 and resend then.

