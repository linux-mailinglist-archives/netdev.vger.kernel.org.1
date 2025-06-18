Return-Path: <netdev+bounces-199127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9366ADF15A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494E97AC98B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA122EE981;
	Wed, 18 Jun 2025 15:25:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC293B1AB;
	Wed, 18 Jun 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260355; cv=none; b=udRLWg11wo8+vb3TciPI+Gz/dtJevYbQubgVKPuwhPaZkkYGy4Icjr9sJj8O15CiyBxO9y9oXU1RvU6RB8SCt7oWLIwzIW/cbcs4KvGx3vaafwUzE24DwfUxrM5hOeat8EklvJdr9rSpaoM8V7Tay/UlgWDpzDMVN8TaUA3od+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260355; c=relaxed/simple;
	bh=eFZ/sqa21sKc6Ge5IXkmbRjMhwMMJzGBEsYsQtXPzKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNBPPB4Upf0VJt4zj2IIUIx6FSonb7iU25Fi85WIj1eZRq6m+5BSJlljGZZBPd0TTWdvml/ju4LmcZT3VeYW4TfX38wuDxZFGZv9I0WTn1Dc1U5S5Gu6CeHcyPjDHb3hL9C9rJeUmSxmW3Xvulxvfe3PL5+kOgA9ofJu3E2A06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad89333d603so1314352366b.2;
        Wed, 18 Jun 2025 08:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750260352; x=1750865152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq7m9IS8p14EPIGrfqxIFsGHm8joQIBWc112DHyDAtk=;
        b=XQeLzhOBWvywcdAm3sz2Fke8i7KzCm+oRwnUS+vF9sE275EJf1bhATe2kyNmUVnj2J
         f90Tnmc+4CMM3cpMRWaRz+GYMp4ZEOR2G/POECmaP5ZnqzHsVnXs06RZy5KQZ0PKR+oT
         tFM+wO3uPIDDx0WpJKf3FlzuVLHKVE5HUg1mtdFevNJKRFLCf7zcDaD35vode9ZYv3iA
         m/uZI0VIwOudOYYTCLYYQEHWqqoBDE/xKcGmaS8WDIM8gJ263LxXue5uq2g4d9AE5rVl
         x3VW6ezVFV6Pj0KAXb1DXn8PqEo9Q6MNI5munBU/qHOz/wo3gMF82xhx/gV814/k3zAk
         7DEw==
X-Forwarded-Encrypted: i=1; AJvYcCWNQK4ZlCYihndmf7JL3sqLR8w0IAG+sKFYcxaLFefI0hU2m0LpLMKdmU3fVQv96NSdgQcI9jvMVmZhjPM=@vger.kernel.org, AJvYcCXfBOJzuuc08LROl8NS6FAW5yyidt0C6IMs/MFaxHlzqSiGvdy/Iq7MH/GiQhu3WgLv7JykqnDE@vger.kernel.org
X-Gm-Message-State: AOJu0YxAKHjJVEWqZLpxxvOjn20avnWf56eIRkZ93PAjnVdJA6EJddsR
	KTJSbN5SvxIegIzFTt5g8k7lGY3alL6kZrzCTvLMGyTeThB4P1xfagox
X-Gm-Gg: ASbGncuCcNT0y/jvmzZlaDyHkAj6T7XQU6Oe9tHpeo7Gq07fky5a0chmHQamg4DcHxO
	i2/GdYkT0QM7J9A+6IZA2OevS43L1ctI3Ge4en4b8Imumt/iKhpmDU2WbKe6Hqb13qImLRn/B8o
	j/Z+Gl8trouDBs+unXk/me9Tbp6lImW3WWC7i4ztskyrUfENbN1KV3R4FizeQbMl6m+4K1GqyZY
	E76KhgNS5Oh32rJo/AkBwOy1EONuqIOUwVgJE05ndoNOBx0V3E72Ibsp3/eik/6t56SVGcwyIc8
	+YDD35iA68/ZNLrwy3Mj+jkZBN+qIjpd3dPD+E+I2/irQvv7BDvp
X-Google-Smtp-Source: AGHT+IHQ65bmkOQlqEj2tfoxP0LnFcT0DoyRBrbOlacDA5FPJp2WGfaJE846fmhjixPNE8XgGVyKmw==
X-Received: by 2002:a17:907:7e92:b0:ad2:4b0c:ee8c with SMTP id a640c23a62f3a-adfad53d5fcmr1630723466b.35.1750260351821;
        Wed, 18 Jun 2025 08:25:51 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8900998sm1063870866b.88.2025.06.18.08.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:25:51 -0700 (PDT)
Date: Wed, 18 Jun 2025 08:25:49 -0700
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: jv@jvosburgh.ne, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	gustavold@gmail.com
Subject: Re: [PATCH 0/3] netpoll: Code organization improvements
Message-ID: <aFLafR/RJqJFf8D7@gmail.com>
References: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>

On Wed, Jun 18, 2025 at 02:32:44AM -0700, Breno Leitao wrote:
> The netpoll_setup() function has grown complex over time, mixing
> different error handling and concerns like carrier waiting, IPv4 address
> retrieval, and IPv6 address retrieval all within a single function,
> which is huge (127 LoC).
> 
> This patch series refactors the netpoll_setup() function to improve code
> organization and readability by extracting logical blocks into dedicated
> helper functions. netpoll_setup() length is reduced to 72 LoC.
> 
> This series breaks down these responsibilities into focused helper
> functions.
> 
> The changes are purely structural with no functional modifications.
> 
> This changes were tested with the netconsole tests and the netpoll
> selftest (WIP)[1]
> 
> Link: https://lore.kernel.org/all/20250612-netpoll_test-v1-1-4774fd95933f@debian.org/ [1]
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

I forgot to tag this in the header, but this is against 'net-next'.

I will send a v2 tomorrow with the proper "net-next" tag.


