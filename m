Return-Path: <netdev+bounces-146576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7489D4708
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 05:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CC0281332
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 04:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251B91411DE;
	Thu, 21 Nov 2024 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il12IJKd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F2849C
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732165110; cv=none; b=HoNArmBtQOYa5n/SjLJIGZb9nbu+LWYvAckMen9QUa9h5YGAxzCz6+E2Tr+Le8woHSJp9aq/XkaMUN/E0RL5uUaftoDBLpWBEcmM6YSTYqpact08tjul+Q90UykRoQ5/4FZYRrV+CxgXBdGyjbN+1gK6rEdbzquhq37y2D6+f20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732165110; c=relaxed/simple;
	bh=jd9VR9kwUAUlDyU3ZZWr95z7iG3uylbRLLQCjk0YB9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNjET254WPtLM023EMX8T34/lEhdiKY9J29Bhg6vhLK7Kk0icL6N5lPk7SPWok1BwQuDnWuYv/tYo1SRNQhvU6wWBWVrdpUAD1tQkxpCdh3EYVTi94RZ5I3Fgr8DHawQ5U3OW2m4nkS9rWQFzY1sxsD/ym0q7B9hOuRubNMvJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il12IJKd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7206304f93aso432817b3a.0
        for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 20:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732165108; x=1732769908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t38JzZNVNU7VvYF+d3r0gv//b+iC3D2gcOAlwvni3CU=;
        b=Il12IJKdG1Njpkk921iSpT5SN2o3AC9RVYRntZPSHAPCnRbmiN0BwDer2v8Ds0cLaU
         qYZbEEtiSec2qOxgpyUjMXrMu093uo2nuCReDDNwF2kw9P5goR0aJQICxxZGoTspBCFF
         lZ+mWDbNkcC3E25xCn8K9hC3c+4YQ9mtfXFD8Z4gWW0Djt1j7UuzsxgMHWnQuy9JV+IW
         xwKhHK9NrD3t2Vg0hRryjHdSnCfwybqvc4EGpEqB/wtxqFBgswNqwx3CSrU+mH+GnOSs
         iwaJ2/hbmkGuk6smB8XSLYUG3tQCKM2Rw1SN65nnel8tQgw5jZy1bDuS0aNQlcNph0oo
         V+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732165108; x=1732769908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t38JzZNVNU7VvYF+d3r0gv//b+iC3D2gcOAlwvni3CU=;
        b=TmOSXyHBINwJA0DEfBUsoDwjBrIJfWWHUQcgLaE4UtnUHU31jMiFp+h7u+ngBm54bq
         c+G0wrjzCegZpGu2SqqYKHTGTbtes3IjVcBoV2tqatkPh5LV7ra0BfZCKmS6o0xmgWc7
         V4yxRO+Iiy+l25AUCjTasMo8DcyskxtDAQW/YWopBOpClwe3Lm5s1mtwAaAn+9B73t8U
         Ln5YVBsSpZ+4o4f+iPJMZNNIOfY33WrhDWN3YqauClYd43cDmAivyOZx27UaHnV5F8oP
         LSvVatIl+/58zS5fg179XbHQ4SAdNP1X9bzs0N0UGpo41uAhtVCADrT7gA7FvOYamrQi
         /xzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0PndWcRFRk0Ir3leE0xuuaXUKAddkbGUxdZqxwE46rgHBjaVIHvBdrhUaytRVukmiotQFQ0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvTyxU1nTzbxOnHum1MJOq1/nr7oNIZaCcjEE3IEeog5lUQYX
	vBPym4vCzKKRYYwaZM6mgBgEo2Rc8+op/pnWT3GrfO518SO/wz3B
X-Gm-Gg: ASbGncs/kRJhpnS9xmvbxoDnhcf2WtphfI4//687cXVSvtV7z28/Mehi10XK/13cLlA
	Gu5yF0TXfmFQCJtoGXlbtWdad7KCtM7pvGPNr6xOtXGmS+WkvcnQXpjC0oO8qbQ4w3DoU6b4LkH
	A2c19Lgry85KpYV0pEFf4KqHUS433w86JqbOVhekQptPxLnsZ7sUm9dZymuCrlkmntWuyzfbT7x
	GTs9J7fg37Muc6/EHKSGpuggWr/0p6UAGPDlTMVszr52iRc2oxdBdwtfBJFSldptdJhlQ==
X-Google-Smtp-Source: AGHT+IG1aWYfnAyiNXEOBKzkVb25Cle6WAFYA4xWoGzL4hCHXinTdwIHMr4jzwD+xdAdkLaYTpfY1Q==
X-Received: by 2002:a05:6a21:6801:b0:1db:ec3e:c959 with SMTP id adf61e73a8af0-1ddae8c19e4mr7859039637.10.1732165107745;
        Wed, 20 Nov 2024 20:58:27 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befac404sm2657335b3a.148.2024.11.20.20.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 20:58:27 -0800 (PST)
Date: Wed, 20 Nov 2024 20:58:23 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH v4 net-next 3/3] net: ena: Add PHC documentation
Message-ID: <Zz6973UqdRO1uV8L@hoboy.vegasvil.org>
References: <20241114095930.200-1-darinzon@amazon.com>
 <20241114095930.200-4-darinzon@amazon.com>
 <ZzlMlnDvhBntNkDS@hoboy.vegasvil.org>
 <ZzlOPEyFxOjvPJd2@hoboy.vegasvil.org>
 <a86eb32a374d4853a409c02777e71501@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86eb32a374d4853a409c02777e71501@amazon.com>

On Tue, Nov 19, 2024 at 08:45:52AM +0000, Arinzon, David wrote:
> Our device limits the number of requests per client (VM) through throttling.

So it sounds like this device provides time to VM guests?

If so, you might consider generating an interrupt to provide a
"virtual" PPS as some of the other VM solutions do.  That way, you
avoid all of those unwanted gettime() calls.

HTH,
Richard

