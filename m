Return-Path: <netdev+bounces-240869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F19C7BA2A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA83A607F
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113EC2BE7A1;
	Fri, 21 Nov 2025 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgQT5LRH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53C2264CB
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763756905; cv=none; b=ivRYpq/z9E+3W+obUonsXQonnD3Ij5lX5cmk3KJtVWqN61zvp3Yg0KaIxw9sg8FeNbQRsXtvz6RaOYp4qWB84amBh1FOZUBjMLqJO+SCB8Q4iz0NOfUZpR7o0YeU5Zq8SVB7hdJok6uvK8dcGwdrU5AUQrKM3IPyb6mW9Xv4hQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763756905; c=relaxed/simple;
	bh=2XFkgRALMikYgKkPTNP0T2lw6ZMn4sAbpWoNiXULhnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY66GEBOlTvi1FlAIVeRo/9Fps2giza+KIFy07oQVI44Hm1EW6qSuuzqQ4USjtBa1yOYWxNCyFNBKz1p+38A611/Ys82vYwZ1kzUFry7Q0va6kr7FeJTt1BOiGL+3jFohL9pylyZstBbvNrjvr7DnKH+Lqt2cvQYv4tsQXM06b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgQT5LRH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779a637712so15694295e9.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763756901; x=1764361701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XFkgRALMikYgKkPTNP0T2lw6ZMn4sAbpWoNiXULhnc=;
        b=YgQT5LRHTr8gGnY75/PdwVi2DlV5/2ME0/QKmNN1vQxQcYED6A2+chJaFUsE3tLMD9
         tIYaApSRpJ5KXu48peWJrxfqu+79MV/SJ3lpdhhqk2kFrStHGJNndosmNUQiLWeXrFX3
         tesvlZImAkrlDVnRTNIMEXU3AL7hcbzzvcbvBnmF4lFVwUqMR0z1q+pjiiuXAFFinLug
         ABvxiLVyfukO0FwGy3DaVLBFigW7wufWQvCvE6m1qjN00sjGbmAyRNEW3f6DZQ/UTv+B
         VPsN4gWIeJ/QKo/A/jLjCuvcTuKYNrDIFIvXP8SD+CpaRIw9binLGRbA1gGYDInkl9Ii
         3usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763756901; x=1764361701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XFkgRALMikYgKkPTNP0T2lw6ZMn4sAbpWoNiXULhnc=;
        b=Lp1aVfEC3C5+XWdsxE6KS7X7hPSb8DLxzHkyrGNaSjbcj04L41EFPP1kgfZOC+nD8C
         iGqauR4s0Jk+egbMNJ7pk3h8A59MmEDw6Ew2bBnf/InvM5+MfYlxw/QTeA4AATCcVaA3
         w5G2isk+27SlPM4kraRHV7Ml534G2PC7tOMAt6YfOW8VitD6lFi85S04vMIABaCt/fO9
         TnN5yEpjx1cgtfx77G9SIo4iqLldMC68jR2n/MTbqPuwR/coFY1iZBleKdCswz1fWuYW
         S6W0XaqATeoBr9CT6eZrwKWOCjC52n5VA5y+eTjdZw+xcJyU7UTjqThOYmhFdK/nACC1
         j0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWVcK6MyRrbvDtT65mkgZF0fQmAsNXYK4wCW1L+WylAFp2NRUOdNZyObt6cBNieE6rQRjR96aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7nIZLmhfAEncz8uT9z9hmqQIpjUCuYYOL07G54M1m0sJ1LIc
	8i3HVg5Jw5jGkZSy1Hs6x+3QT17rfucELzOuWqUyRLgR+OOnMiMLSiMFkb3GJsxyWlo=
X-Gm-Gg: ASbGnctVjNHZJrlyXRsu6cOqSIOXmKNH0LGEu62TRFebyx3c2HAMpmQQTRH7BwCiCqs
	IJMueIMgthezyEXvw8Cyr1861YijUbDm87r2jGhUqLPAUwfhprqeCl57WkYntDleIxDdMBf7oJ/
	CJSvA4l+w6ZdKOUUfDDzWcSxyz8V6KKpVQXceflVMkSW9nX9Zi4GvMZpguvJm87jeT3PnMKXXOq
	HbXCbmfAuN5IEUheOws288auROdz0axtBOPq6rWfpe407sZzc4D5lPppB+No5w8NF8TPAwEPNc6
	RZw0bIZrYOMc7JSQN1VqjYjrExrWrUIdERUrb4TNP00kZaC2Q9YapHiYxuAMiyKELP1/cnlBecS
	CuhnBSox7m+QJiZwClX0PKLEJILXmiiclKjnZ2IbNJDqeJKNV6Bua6buzdkj00OQAROLkhypFlT
	mETnxZ3sxN6TYMj14=
X-Google-Smtp-Source: AGHT+IH/1dYnUeO60+G8Asp3F/IIVjiGgcjy2aei3hVULt+G/4kGGE/Wlu6XZNs0JqhuzRfjY0BGDA==
X-Received: by 2002:a05:600c:4f88:b0:477:af07:dd17 with SMTP id 5b1f17b1804b1-477c01c3721mr48448255e9.24.1763756900910;
        Fri, 21 Nov 2025 12:28:20 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9de46cdsm89816815e9.8.2025.11.21.12.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:28:20 -0800 (PST)
Date: Fri, 21 Nov 2025 20:28:18 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Zimmermann <sigmaepsilon92@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] r8169: add support for RTL8127ATF
Message-ID: <aSDLYiBftMR9ArUI@google.com>
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
 <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>

On Thu, Nov 20, 2025 at 09:55:26PM +0100, Heiner Kallweit wrote:
> Your patch is a good starting point, however it needs more thoughts / work how to somewhat cleanly
> integrate Realtek's design with phylib. E.g. you would want to set 10G and aneg off via ethtool,
> but that's not supported by phy_ethtool_ksettings_set().
> I'll prepare patches and, if you don't mind, would provide them to you for testing, as I don't
> own this hw.
> At least you have a working solution for the time being. Thanks!

Sure thing, that works for me.

Thanks for the help on this so far.

Cheers,
Fabio

