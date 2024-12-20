Return-Path: <netdev+bounces-153649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA00B9F8FFC
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 11:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3969188F3A1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A30F1BC07E;
	Fri, 20 Dec 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9SNDndb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F9259499
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689764; cv=none; b=oFcuHw4mhsKIdURnx/ziBQIqyj6oVJoLU6QQlrWfDt5w8mcfnpwmctdq8pbOdzlnq8Wt/yyn8DwzKkdicW3t+dQUU9A7moGrE250f1SQzF3+XJj8D+pXYabVOQtE+ZAUoDN8efMgusz8VK2u5iB0D217bHlgkgOWUF0ir3/SbPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689764; c=relaxed/simple;
	bh=zB9oQifUaT90beqFzs4VFjbkUKjGEVbvfgJ3fo7RPnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtTluRkkR6PD28lH8ZL2rS3T29u/LxmddT+VJfZEJilIl89QW8W8PGKsGrDuuAI+ibn5br7+qycMuxVqP9KXr2UjUv1RWkeggoal7geNgiyVwyVzsEVdgaugUro5H1q4K9y6txFh8DbVwbUVFQE1Za0yv91fzLk4e6HkJRoKYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9SNDndb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4363298fff2so1968445e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734689760; x=1735294560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7tuupUq8rip34TLFjzD9JmUZAXLtqbAyEk+PlVXAy3o=;
        b=I9SNDndbPF474wNwsYLRA6YyPgqt41qwjYDYj9rQ4isDPaj3dnJr4ml28G3NibbI/X
         3nCHUScw6lLGZ6rRhiyGnoFq5whaUMKiJlQsVQ/r0b28n1mHwS6LGpPoig0dUg89mPW4
         lYxy4Wl1jGSwGO3xzv2785/fS9SLEnVjN0gOTIQYgUJ5uGgEKI5X/vzQJ+fFWqhpr8iL
         IyGV0K9nvsRxvqluOFoKWODanSgqE2TRJ+4q6lWEFUsCJYGTIZizIYlVg6IUz2JPFP7o
         v+App6buoSNXHvNpNtPRuE/6J7xIzIEZQF9/EhmQaoLgK+JDOPmMhFAVKH+toST5U7ht
         HFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734689760; x=1735294560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tuupUq8rip34TLFjzD9JmUZAXLtqbAyEk+PlVXAy3o=;
        b=cZYb4TMUbFFi77k1tjhLvzX/GQtZelsMtKhj4vPx40Pil1rRR4S7hWXMGtU8tEYZn8
         K5MUQZLu2TPukNJ1RebuxdrmeasQZT5O5uYl1UvNLbr5k+aT0ZK5zgfwT3pEfk2LTXVn
         Gx4jNq/art0Sc74nCdFGTjSv2quWsz97luxknaW4670yPN4ZroIPn3dzIhrlrkx0xv1l
         s75H4u3x4Nm8cJpdcNhZLdV90mtHSk+7wn5R5TZfVJPLPXhzmmLkPvZMu4lS50O+fQ7M
         XKPbhjJX+m+lRXbVPDlvDANJQvfV697osJosRUVSmU3+LkMXUTJly/LT8htTITTqcLzt
         7bJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnlOn8KY3rGMzjs1/LRn32gxjKWvn1/VxlIFORcrG+NwqppsqiA5PPOXvdsCnGstKyVlnFR3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpvKvbBZVGdbobjsDKp463wGBrs6SSSdfBaz07IeOIH0bbWLm
	whyxVshv53k+ZYbL6CXFiBsK1O4dIg9hrpzdhtZVdJcxKsqllFPL
X-Gm-Gg: ASbGncvSM4h4sBB6mDlfq2C5YMtmffKLSYUIh+7hqcw0mS1fsbvZvPrfnv6oqobcsNQ
	vzkaQG5hLvG4vxiF5KyAyvFXwzQWCRP2t7+TjuIl1hNjV6bB32D+0gsoY6yXbW5/pM44GUj3Grb
	mTxpBztGAhbKLSn+coN+6ZRsIeS4MrDvfOkNqnv0iuorWyJ1eMN5/YVr2zbUBZovHXEjuQbri7Q
	Zx1NEkbxQAHrbOCH6EG0s1F3e6x1ki/LgaoO3EVeakB
X-Google-Smtp-Source: AGHT+IHYqJklE53JGmPaiYH/VsTlghccj6R6oOIemmoDB4x3nqLt0viT7nIVQhHJnfLLZhf70qxgag==
X-Received: by 2002:a05:600c:1d1f:b0:42c:c0d8:bf49 with SMTP id 5b1f17b1804b1-43667921f0fmr8202115e9.0.1734689760201;
        Fri, 20 Dec 2024 02:16:00 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b11d1dsm76233925e9.25.2024.12.20.02.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 02:15:59 -0800 (PST)
Date: Fri, 20 Dec 2024 12:15:57 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs
 on user ports
Message-ID: <20241220101557.t4fcic457kbvvcol@skbuf>
References: <20241219173805.503900-1-alexander.sverdlin@siemens.com>
 <20241219174626.6ga354quln36v4de@skbuf>
 <eb62f85a050e47c3d8d9114b33f94f97822df06b.camel@siemens.com>
 <20241219193623.vanwiab3k7hz5tb5@skbuf>
 <b708216ed804755678f01f62b286928763a1f645.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b708216ed804755678f01f62b286928763a1f645.camel@siemens.com>

On Fri, Dec 20, 2024 at 07:17:37AM +0000, Sverdlin, Alexander wrote:
> Thanks for the references!
> 
> I've complitely missed the story of
> fe7324b93222 ("net: dsa: OF-ware slave_mii_bus")
> vs ae94dc25fd73
> ("net: dsa: remove OF-based MDIO bus registration from DSA core").
> 
> But I'm still having hard time to get the motivation behind removing
> 2 function calls from the DSA core and forcing all individual DSA drivers
> to have this very same boilerplate...
> 
> But well, if all the DSA maintainers are so committed to it, this answers
> my original question... Please ignore the patch!

My motivation is that as things stand, ds->ops->phy_read() and
ds->ops->phy_write() are just too attractive to implement, but lure
developers into an OF-unaware internal MDIO bus model which is just
redundant and provides less functionality compared to its OF-aware
counterpart. You can surely understand this if you look at what prompted
you to submit this patch.

As for the OF-aware MDIO bus, the idea would be for DSA to focus less on
imposing a device model, and more on just the Ethernet switch component.
I'm yet to be convinced that it's exactly DSA's business to assist with that.
Being slimmer helps. For example if somebody wanted to add ACPI bindings
for the DSA core, not having to think about MDIO as part of the core
bindings, but as a device specific thing, is a simplifying factor.

You're also exaggerating that all DSA switches have internal PHYs.

