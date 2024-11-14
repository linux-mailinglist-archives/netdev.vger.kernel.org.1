Return-Path: <netdev+bounces-144773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F5D9C86AF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC663283624
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DBB1F8F0F;
	Thu, 14 Nov 2024 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QngmeC78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C11F757C
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578256; cv=none; b=malt6JD+NXfLByuuU5BtES+bHbpG1nzj44xaclsPeG1TgSSwCokgUG1ZnOkYkTf194ujZlH9VTeHBB7usq2WnzOHxp9FLu6IR0mjHoEUPmRrQEgaAecdsbjUMVHmP9WtyOK9NMIGwn2mSLIg7DWY9nQ5TVU6MSZ3fr3jOQxG4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578256; c=relaxed/simple;
	bh=ZkZhMBuYEetRs8RLxyGo7ZfE2c9wP9owZXBO19EWV1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLcxJ2+IRKbXoyLJbZMtPuUZutSLg6MZMcQXuwTYs7wok3I15kKUWul0vXbTPL98pm6kBdK/Ae1wxiAtF8PZps6nPQIXTXvVQAcL6aqNdU3PKYe2tRcczn96ytzbFw2SS+O47gEXFXhCOyVxdCR6hWFnTIvirSvAPLyuub46j3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QngmeC78; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431688d5127so3892655e9.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 01:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731578253; x=1732183053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/MzeUno5ssgaxfmpObuz1vMLdWwk1h1FEXNkZI55Ovw=;
        b=QngmeC78/e3RSOyQ9AxrLGU/phNx350HU8LF8H2bIjzoFaiOnSmli6Z7WEZufcPNNE
         KWRKk8fmrsZtnvv7HstLYAorfx5LCgd9CU/KVHHO1IxYp0ATyIXQ6bLjeInzZaR1LCKm
         1/JLNiaKhnuyQN48FVKV4QHKOUlCKogiA2iQ10WnBFX3cWDYxAb8RD+YFgmH+k5/dxXY
         Myrf2nbWp9V49YE0d59YOMtBShgdAxQ7+W/q/HSNND2n8YeDaKXGG/er9juTBMiZ90J9
         ylKElteUHxu5lJrqU5EtgKDC3fv6Jo8Ne6nEVV1vFNzuexWw2Ztlb31TGj5f/qc/eOJ+
         Qu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731578253; x=1732183053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MzeUno5ssgaxfmpObuz1vMLdWwk1h1FEXNkZI55Ovw=;
        b=lCKIYvTKdDIxwrYon8h++lhRIkDPKPuF/YWyTobbjPGz/HYbPF0BtU30NY338GWmfr
         AcvpEEGJ3Cn6MjC/s572Lerg4C6Mp0c1fAFTzJw5E3MFW1/xavTUy9wEodjnpxdptm/u
         +IGMFCshvseBaI7LrF2DhjRk2umQCmfPcpiDktXyerbo//LeMRp1yeikkXMezq4KmCbU
         Ep3XtCTlrJqIwcp7OPN10N7f+wIP1RTwvwgamrSRkxRMj9swRZ05pIoHhOI68TgI6GF8
         6RQ8MesV+f+Knm3G3F1o9oSHSliayI0iqfz5TbD531z/+vIkwHUZKJUffYiPO+YY/Olu
         ipeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3jyTM5Oq0yKsUj76Txi8X1/fjFFe1cVSJ01ha0x4+SZQEdBthVuTMuosjuuzEvCaC5A+1AP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzs6XflPvd2QVeBWu+ln2x1+05A5WXJnIRX/J4APqv/VQt5ryd
	nEAZd0Vt6Tb17tX5W0G0GnpqMTMfXAdf+U/KSB4nZNVi+NSzjcTN7PJDynpF/14=
X-Google-Smtp-Source: AGHT+IG7x6fyvPJ2miRZp7ZOwhGxaCAKWIfgA45HLnQT8w8JmbciTFyDzjsHotb1zRcVAPKjbtwtBg==
X-Received: by 2002:a05:600c:4f04:b0:42f:310f:de9 with SMTP id 5b1f17b1804b1-432b75099c1mr188268385e9.15.1731578252912;
        Thu, 14 Nov 2024 01:57:32 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbd6d6sm1001814f8f.55.2024.11.14.01.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:57:32 -0800 (PST)
Date: Thu, 14 Nov 2024 12:57:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Max Staudt <max@enpas.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Message-ID: <4ff913b9-93b3-4636-b0f6-6e874f813d2f@stanley.mountain>
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <6db4d783-6db2-4b86-887c-3c95d6763774@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db4d783-6db2-4b86-887c-3c95d6763774@wanadoo.fr>

On Thu, Nov 14, 2024 at 06:34:49PM +0900, Vincent Mailhol wrote:
> Hi Dan,
> 
> On 14/11/2024 at 18:03, Dan Carpenter wrote:
> > This code is printing hex values to the &local_txbuf buffer and it's
> > using the snprintf() function to try prevent buffer overflows.  The
> > problem is that it's not passing the correct limit to the snprintf()
> > function so the limit doesn't do anything.  On each iteration we print
> > two digits so the remaining size should also decrease by two, but
> > instead it passes the sizeof() the entire buffer each time.
> > 
> > If the frame->len were too long it would result in a buffer overflow.
> 
> But, can frame->len be too long? Classical CAN frame maximum length is 8
> bytes. And I do not see a path for a malformed frame to reach this part of
> the driver.
> 
> If such a path exists, I think this should be explained. Else, I am just not
> sure if this needs a Fixes: tag.
> 

Even when bugs don't affect runtime we still assign a Fixes tag, but we don't
CC stable.  There is no way that passing the wrong size was intentional.

regards,
dan carpenter


