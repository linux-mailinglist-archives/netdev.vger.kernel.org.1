Return-Path: <netdev+bounces-148188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A549E0C9E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E0FB27914
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E896F1D90B3;
	Mon,  2 Dec 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LXxoGrUy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C218784A
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160854; cv=none; b=YBz2yXzDV0zJANCcDNcP1ibuos7hC/Sfv2tUbIBAgZUenA3GXdI90V6dxKq3ruEccgQqDNNhB1aBn7753VZZIJQnfjBAdOQlimI1cwreHXkQovqT+O95Dw5quKed5MWRZpFLOzoIOilmXQv4rj9AW2eySUvkJ25qGgRyoCgSyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160854; c=relaxed/simple;
	bh=ZcWhmQeTdhzEQEyezGlnWtKSJ1aRtj36eMfuAb5qXpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUALboRcWC6GBhllYj2Gk9TsbZVUvsvJNxLYye+XRvDxXChbpIRepsfaHgIi5c8RVyhgfK4JZPp0CXmV/nJ+McqB20D7r9ZbjwEEXbRuqoGOGA7fhJvUbgu8yfb/igFadtyzwyP30vzBx9mP7mVSiOjwc2j8L7tC0IIB1yImiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LXxoGrUy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724f1ce1732so3531842b3a.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 09:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733160853; x=1733765653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/KBVkQ9WDET0JwE7JbXDlQw4ch/b8XOKIUlHGNDkFw=;
        b=LXxoGrUyVYux4eRfCJPVkd9n9MDdCmUyo/RtxN2bMmr+E2mm70sKBPJ4BHiUMYDiYS
         d/5+SM9usrJyH/4YWn+rruVhNhvvuMWD5B6pDskt1rxBJ1CRvRXyA6CvTwecI9F5/Mft
         vBXvwsVYAtlAS02Zv9DkxEfGKEcU7g3iHWB8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160853; x=1733765653;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/KBVkQ9WDET0JwE7JbXDlQw4ch/b8XOKIUlHGNDkFw=;
        b=hgvlWjz22rGVDuZVaxrQNDzsQLmot3PZh2Bv32HXTrJMW+WFc2VR1F6LCl/EJRyVZg
         gy0BIAGKYo11/nt4CkyeRuFnwJg+gd2CJGiVur013qxU0C8X2Fv33NM0Orzo7lf9vK+H
         yzmrskc+tErMvt1B8vP29R6DKr1g/NuZ538cIUR0zrHG4JwbyRoJ3tNazTDSAW+cqGGd
         kFsMCnPgU+L+1Fd5ErQCjEWuKqaArcD1BOvUstasC9le6YwAnZ9ybx1yVydqldAvqZF0
         AXOCtywpG/hMFSIoiCam5yfr5N4rdDwNUI6+tkkVdBCBGDzbtwwDFlSBoSMpy5mimSKC
         3pPA==
X-Forwarded-Encrypted: i=1; AJvYcCUlE/rOPbKE5IsJ7f1uc6VV8ctohgEzjQcCk8v4elrjh64ya1tmkw21dU9+fjl2QPeXlzxQZW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvbBsKf4I3SefEOznH4ZeOCrFo7I7S24R/YYXk0doVKCITAeOA
	i6uDTK4nFVB7A08G7kkoF2hc2hWuXWhp1MxKNsr/LQuvBH5ZtAZETRBK9M6ULW4/xWVE4uKPuQY
	n
X-Gm-Gg: ASbGnctyDjDbMJIBcBZQsb8eXXq76x2CQkS9jCternLnDD3lv123uPa5s+697DJYmpW
	F4mgsfJ7mumzM64wSjcVDDBGITFkPoQ3Zo20oWb9p9dvD+yIIrS0RORL9oAQE8Fzh/RAp/a8lhT
	hNyXctfoQV0wjbx3dKfUV8ut/C161nLLr28Oy9ThXsz2AfjfLfghhRL56IJhcNz+0RdK6ub57Wb
	qkUbM8h2ekKK77p+8zhUUsC60VQzMtdNYuMRQ9mkOrShzTmiH+UKCtRG6vagSwa7WQMm733iN7a
	a79taDlcAKT4h7NT
X-Google-Smtp-Source: AGHT+IGdA7xHbfKmPdaYXg5efPm8iMgRtys8b0yolqaF3S0/bsz6LSFec8vyOdG86Jxh0+jRfA07Mg==
X-Received: by 2002:a05:6a00:1390:b0:725:1d37:ebff with SMTP id d2e1a72fcca58-72530141196mr32222598b3a.22.1733160852632;
        Mon, 02 Dec 2024 09:34:12 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c31164asm7042249a12.42.2024.12.02.09.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:34:12 -0800 (PST)
Date: Mon, 2 Dec 2024 09:34:08 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	edumazet@google.com, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, pcnet32@frontier.com
Subject: Re: [net-next v6 5/9] net: napi: Add napi_config
Message-ID: <Z03vkLXa-wajZZ8T@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	edumazet@google.com, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, pcnet32@frontier.com
References: <20241011184527.16393-1-jdamato@fastly.com>
 <20241011184527.16393-6-jdamato@fastly.com>
 <85dd4590-ea6b-427d-876a-1d8559c7ad82@roeck-us.net>
 <Z0dqJNnlcIrvLuV6@LQ3V64L9R2>
 <Z0d6QlrRUig5eD_I@LQ3V64L9R2>
 <20241130124501.38b98030@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130124501.38b98030@kernel.org>

On Sat, Nov 30, 2024 at 12:45:01PM -0800, Jakub Kicinski wrote:
> On Wed, 27 Nov 2024 12:00:02 -0800 Joe Damato wrote:
> > CPU 0:
> > pcnet32_open
> >    lock(lp->lock)
> >      napi_enable
> >        napi_hash_add <- before this executes, CPU 1 proceeds
> >          lock(napi_hash_lock)
> > CPU 1:
> >   pcnet32_close
> >     napi_disable
> >       napi_hash_del
> >         lock(napi_hash_lock)
> >          < INTERRUPT >
> 
> How about making napi_hash_lock irq-safe ?
> It's a control path lock, it should be fine to disable irqs.

Ah, right. That should fix it.

I'll write a fixes against net and change the napi_hash_lock to use
spin_lock_irqsave and spin_lock_irqrestore and send shortly.

> >             pcnet32_interrupt
> >               lock(lp->lock)
> 

