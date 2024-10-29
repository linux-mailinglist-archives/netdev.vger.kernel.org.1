Return-Path: <netdev+bounces-139977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 310A19B4E25
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0A91F21A94
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F12194A44;
	Tue, 29 Oct 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8sBwjPi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20735192D9C
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216181; cv=none; b=lkDq/K41aWBGM1u0tWHB3bNdX9J5Z0l4Yi8+cxysri7MwKUTwNH6MRW+lYQ9Ip2FG4Wfjr+/fjpuKtJ2+cAm9JoOVRELxFK6RYIoYQgk2jb0lQpf7d7k0A+ZB1yKatQChyR9e2ydiGbQv7v65JLb+6NbO8xCguUkzKZiQ/QurK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216181; c=relaxed/simple;
	bh=P+wK6DK+txNkn1mcfgNkL/HRphYkp6nahVmwCklYwBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPLX7mksV2/hCkmbvRkex1Wl23/fE/iMYUMzgl0rVsTAgPP1GTykprghe7lFaVa2WnKH8TeheXxSLrxzXPcRDhlu5FwSpS09JAmweYpG3zZ8yp3eC/SVlu2iz0WPHzIai90RHD7kKUuS504mgqnaI0u2dyVwqVY2Pi0SWScNIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8sBwjPi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d5231f71cso649914f8f.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730216177; x=1730820977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+wK6DK+txNkn1mcfgNkL/HRphYkp6nahVmwCklYwBQ=;
        b=E8sBwjPi4A0EvgsQ9g6Wj/FU7e7/EqKrA3/v93HFaImazedMNnpBCcoCJtUTDhvYl2
         f30cgSaG8cnB6Ukvg1LwBYdae2SQazcMazx3O+Z3NXCMih39ME8ZvYTDjcOsiYafmCgn
         jpj2YF9tl2ghM08zah2GpseP7TLqBFYns55TskB50ybsLq2ydY+1b8fdlT2s7Mjv9jXG
         fGl8kN6+iPAiMZlwDUkSmxkguRx5D3uYH9FyksY06yPLcT2+9xc+WlcTJkuxgq5TRgyI
         BO4g2xyeEpoQlcLUO1NhHI7Pmythuoakt4dfHtOhw2co0hF7HpIvuRrUFUH+n2zGI/0b
         cWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730216177; x=1730820977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+wK6DK+txNkn1mcfgNkL/HRphYkp6nahVmwCklYwBQ=;
        b=oYP5K0ulcPRuCohteoCjehRhxDDegmiOQ1GIjhLYdQaNnS2qYTaqtnI9j/QIaY/EeD
         1s5y3M4sO21s9rXJ3glceDoczITm8DQ8IOPxwnJs+Oi+cRIdoBjjmBQlKAt1TeR1Rhul
         b/cnMvNNp/hAGaT+WnxE7U8Zugh9C9ZA+eDzVjiemdeejPZgoQkuxJaYiQ4SvJ4+wsrI
         6fbLyjdTE9Y2Zi+oozeeww8x+Q1k92fFSKo75XVemIXwbEVWqoXMukige6bGi5hm21qT
         E7pJk6iJIbiM5GodCHGcy7+o3TvGcP1JWnPPernr9eDjZKsOSTvZ3YDSjC3MwCM8Y31u
         kYhw==
X-Forwarded-Encrypted: i=1; AJvYcCXgkeed6T7/pOnMaWvkpHRt7AbKiPa+TKrNlraFPxAYeXbwsxrZr6qVTQxbOu7ZGe0car4PU40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpNe+d+luajkwSow7Tohw6WJkTMNU8elVDJT5XrPeHUdjlj5v
	TI/4gqtdx6jgHRqQqUBsvVHiSscuIj6GMUwP7vQhxQBoZqfYD4Mz7tl41BfY
X-Google-Smtp-Source: AGHT+IForEhTIXvn6Pf1fO2tOWcgwAjpavxfxe5BpSdDyBmoZA7e/HAwnML5RMIAD/vgn7whyNAQbA==
X-Received: by 2002:a05:6000:144e:b0:37c:ffdd:6d57 with SMTP id ffacd0b85a97d-380611b55f2mr3333778f8f.1.1730216177136;
        Tue, 29 Oct 2024 08:36:17 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9294dsm12823559f8f.105.2024.10.29.08.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:36:16 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:36:14 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: query on VLAN with linux DSA ports
Message-ID: <20241029153614.2cdt2kyhn7sb6aqi@skbuf>
References: <CAEFUPH2npsz4XKna0KYjOeU_MfYN-bVTw25jn6m2dS+f32RuxQ@mail.gmail.com>
 <630f1b99-fcf6-4097-888c-3e982c9ab8d0@lunn.ch>
 <CAEFUPH20oR-dmaAxvpbYw7ehYDRGoA1kiv5Z+Bkiz7H+0XvZeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEFUPH20oR-dmaAxvpbYw7ehYDRGoA1kiv5Z+Bkiz7H+0XvZeA@mail.gmail.com>

On Thu, Oct 24, 2024 at 08:15:50AM -0700, SIMON BABY wrote:
> Any advantages of using vlan aware bridges?

Bridges can have more than one lower interface, unlike VLAN (8021q) interfaces.
The lower interfaces of a bridge will forward packets between each other
according to the destination MAC address (optionally + VLAN ID), which is
something VLANs don't do.

I don't believe that a bridge with a single lower interface (port), as in
your example, is exactly "intended use".

