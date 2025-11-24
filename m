Return-Path: <netdev+bounces-241077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEA4C7EA6C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 01:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5B513447F2
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF0B19F137;
	Mon, 24 Nov 2025 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXV/WMPL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2B481B1
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763942445; cv=none; b=U96QEAetN2SJrTRB84vZndqK3fd1NQXC6B7ZhxdQ91er/+JNZWPVY6Flzsbcfeyu1gpkPxw7OC6gSIaUr0BigXN/tFT3MbkgKPK7SnNB7lFQSvogurGlAguqkAiqVg6ByATfZdKZrng7fbsO12u5ZTRSVcdJUbeLbQW5P5+LNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763942445; c=relaxed/simple;
	bh=TK4oHS5lGX/3l2veb5em1qf5nr/+wdYzHOedqH3BL0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4Cdipo90fRPNTYhFb5HosyRK4FFn/clVs0DvyJLJaCNmKmfh8eZGYxF3ehCG56lJfHu0BBJ5VmIAm1EFpMtaHFumOzadI48Db6tI5OAjOvOOdR137CXb9hSsPObywGn1EO0+U+Xj4+k7o/aYDOckttDZaDo76oXpoe8VqxlBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXV/WMPL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775ae77516so38317525e9.1
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 16:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763942442; x=1764547242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TK4oHS5lGX/3l2veb5em1qf5nr/+wdYzHOedqH3BL0s=;
        b=AXV/WMPLAsiRCz2lskJvja3Aul0Fh7XxNJX2E1rCI0v3JWkTue9dsjRDFqJ3iS0r1H
         A8wyRl3VnAa1GOT3scsCBhVck9qgYW+dWVXw70lwB14L2avgJ2AaDV+F/CdDYK9NgJQm
         vZylJIw6n/oIdkNhTrMDOkruvcMbTTLFAJ5R9K7gS+v6ntb24zreO+4nBFZnN2DEE/Z/
         67ul66e8XKcWKpCeApRVLXL9CABadrudXgnCfKOlXMKhTF+tE1rkN6t3LGKpyBQ7XnNJ
         KaOheIbncVhjBl3I+uW9wVVmdLlK77j1jrlEdb70lDpL2O3PKjI4rWC8vz+IF5gIrGIO
         MtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763942442; x=1764547242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TK4oHS5lGX/3l2veb5em1qf5nr/+wdYzHOedqH3BL0s=;
        b=RT+C2mh/C24wsWMjT0F0Z/XOjid/TpONhTBDQXm2JkrbjUKr8/8JZ51tHDKdf/ahUm
         HG5dqtDjx3+PM2Dy8P+j3Vb1vBeic7ufAgTWx4xpSd8PEdvMgbv0SM2SaLCxFw+4cAm6
         Q9ksvbCDel72etxfNCQkSOKaQkfsX2CsfGSffCou7Es9c/KnfBbHd6XG9NHar6tMScD9
         cG1/JlLzWsZTXU3/pEnynH2ILfR9L2+gxq/3/sG3aUTqr7UT9+PKLh60tQ+Kxhj+xXMS
         4/jj9FP8FxbbiZH0WWUq6mEBQhcSG18qgpjZrn8P2J1+lg6tRgQ33kHPjPZzNPkMGxXU
         aFug==
X-Forwarded-Encrypted: i=1; AJvYcCWk11qxeh6NeaypYAkVqb2MQi7+4i7RCwvHzcoQ4t3+NHo0EES8Xklzz22PoUEjL8o2oRGhSRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hnn0VrzBbdOBMLL5CxLjUlR0+itDpr9eLyn6ikKI9wxShcut
	wm17wiZtfz9nkLDZwCq2BHD0ByvNeBDE2O/jafZr1jdBCYklI7bwtX7M
X-Gm-Gg: ASbGncs7F2GL6SMGGKKw4DONLCOV7/uzNI01OPEmFKXb93jYtJtr84wzwqFMWySN6B7
	920kCN9UunOYl6O0FMv7XK2oAlrLrcB/1hS+47WI8zkRy0K7yP3b+/A4Yu4RF5Vc/I9icqpAqBv
	zyeK6nGbe7tSnVuFkgedRhRvMF2jT0WB2NOML6YrUStYwBmUU7HhVSje1hyVC0TN36fxIKMV8T9
	L/+QtBugOWLzhVyHNPGsi4y32C46leJtgwmwE6lsLbS/+DLw2Rdk7FAB5NHfUERn1lOFShf41HD
	j8meELGJl3nDqKOc/8Q0vNnoBa2ZF+Ie/5Bk0qFGonb4q6AYgWMngheHCPvLR+Dkkn/dWfsG3h4
	Hb5lN1MQkErFUVYfQipLl22wwPXhrnbzuP5enS9s/UtblfM9fBzTpXbEEBbHciaQnwZGn0mELJg
	hJUseCWxWSOLaxrd8=
X-Google-Smtp-Source: AGHT+IHw6Zuc5LADCL+PKqpxrYGnAP8kiAHiM4cOeLbIzZZy5iPBeL0Dpxir3Ii+rL5znLU5b+owxQ==
X-Received: by 2002:a05:600c:4f82:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-477c111605cmr74520745e9.20.1763942441984;
        Sun, 23 Nov 2025 16:00:41 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm173603155e9.11.2025.11.23.16.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 16:00:41 -0800 (PST)
Date: Mon, 24 Nov 2025 00:00:39 +0000
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
Message-ID: <aSOgJ5VbluqPjV0l@google.com>
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
 <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>
 <aSDLYiBftMR9ArUI@google.com>
 <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>
 <aSNVVoAOQHbleZFF@google.com>
 <0cacca03-6302-4e39-a807-06591bf787b1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cacca03-6302-4e39-a807-06591bf787b1@gmail.com>

On Sun, Nov 23, 2025 at 11:54:41PM +0100, Heiner Kallweit wrote:
> Thanks a lot for the valuable feedback!
> I added the SDS PHY reset to the patch, and improved MAC EEE handling
> in a second patch, incl. what you mentioned.
> Patches should fully cover your use case now. Please give it a try.

Good stuff, applied both patches, link is stable and link detection
works correctly.

Thanks!
Fabio

