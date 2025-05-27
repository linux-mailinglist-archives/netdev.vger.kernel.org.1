Return-Path: <netdev+bounces-193691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C2AC51E6
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B73165688
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD30714AD2B;
	Tue, 27 May 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ua+wDP1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21C3C465
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359400; cv=none; b=RGw83rpyVNEUJkNsAtRz8opbjJC9XmA9tMd29FEfTZ8i6LoySly2B+Eu1X+RtxqAkGN0aYK4HNdxNmHQWIY2EzpovQpv3HOSUroHWsep1gk1/WZUZYwrUfaKXLA6IKDpgdDiLOTsQVAOzuZ0k19qVH52nUKPfOlK/q0He5LItIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359400; c=relaxed/simple;
	bh=RrW9Vp6jByN3ukHBhVbFI1Z3VSTH7gZOrqieR/+esik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W67Nh8m+4QrIjQhFZ2rVAyX22e4LI2pWHXwTBifJ0/XRsJT4ZoU+sQNtCneRImEd74BCfHZjSXGBsRujj9G/nxNmEvnZZlo9BjrPq98/Cl4C4uC2wvwCGBUjAhQp9UsgEIWfpn+Q3D85DROHi6dRODA824w5Sx7goN6IN/jC8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Ua+wDP1f; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-445b11306abso21862675e9.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1748359396; x=1748964196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkNV2b4GsC190w6aBvVu3RRrMYJ3LAoxWvUxcWbyVwQ=;
        b=Ua+wDP1f8Cxx0VQV6XxfyZ5DLCKUtfnxpf4XXhVpTAgms5qPGGl08a7pqCoeeFNFEy
         uMrpqOmQzKgP+1GRhFnjma+Ys/MAddNHhfk9nM/FnIqVLeysZIvAYKCy18G+p90MlgTC
         tzvgWI8YUz7qyUu9gGHbRn4t1Cowo3+3EwWCFfNsBjrfU2Pe7RWkFUJJRKx+oHi8bvMK
         sG0cgFH3OflLWBn9oCSQj3Q+SC7V4nCDkDwFFjj9/dFkAK6/C+JrVM57FWRMdwf73Law
         iW/HvSbjfvgIh7rkMYHr/QAGESump7EjJ1VqfhsQglELECZZrNIxZui4SrBoXKB9SnHy
         59Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748359396; x=1748964196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkNV2b4GsC190w6aBvVu3RRrMYJ3LAoxWvUxcWbyVwQ=;
        b=mtQEUCuuJptyn9Zbf0NOaa3GAATh6qastcqryGNkXJNQvpr7k0Aw4tIu5OGy3BM7dZ
         xFb9HBW2wr/7xQZvyCC3tyhIbGa1YZ5x8i9vfrGHxqQEB1UjdzRb+Q/XPKyOmkmmZ/Po
         KooCH9wdQ75VIenvbBOnqd2zn+Hi5qhtzOIchz0/RcXW0C6+GlBGf8XJSxX3MxG8oclc
         ByU0ywJOx/NwXY5Q1gnu3orughjKwwucaltWiHde8OVTHQIzkQ0I5GYxiZPSiHxvcj9Q
         n2IBh9BCb4ugdLmzH3lwETy5UUhjcDYIjaL7jiWSnGC2tu+ZyY7qE//Yy0k2rwIsBgYp
         YBpg==
X-Forwarded-Encrypted: i=1; AJvYcCVO3YXxTwAhkmURewhxJfcs4tck1U0bItDdYEv0z3YMuFvEsh2yXNceArZJtzU/Ujis7px6+Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmCzHMhnaEJgRIRRq7K2N2OMXs3R/eIrUkZPXL+JeX4/Zd5W/a
	vQbvDVQI/1eGmYrMqpTI69Z6rLpqluVECCoQF566UgO34pbRhaKPoXmD3k1ednI/3gM=
X-Gm-Gg: ASbGncug4+0N7RR91VSlz3mRVHnGPl+1sJ3csEmQ10w5N5RAgwpTN+YgsIJzzpscfzv
	2m2/O0xzFtJ+MbM6PJh9C/aoXkBMXv/uCaQisiIpjLnUkzz100fsOxb8a/azcEpqbMBpqLajmNU
	OaI23JHd/PLgqPQzYksgFLqu8oS5ml/28R9caS/QJeKYOVSSlnBHwDaWrNOlGWEi7ew6cmeKeZC
	2yQhClWtFIk2L1udYlGI7I7EBNf5tjvkQZOyxuC6RYEaw5UryzFBte2QFGRL42MbWl9QLqqBNGZ
	YzU0AEUi3fw8e27oaeWG25f+ajPw0O3T6uXK+/f0V3Omqu9vWu5IBEQcUKj5DROSaDrlT8cK3pV
	qduY=
X-Google-Smtp-Source: AGHT+IHGbk9pahxUaJo22PGKpwqXK2/4eW8RJNAHiDt+ZDzmDHRNj3SyM/0B3tpzypHLST2RnOmmjQ==
X-Received: by 2002:a05:600c:5011:b0:43d:fa58:8378 with SMTP id 5b1f17b1804b1-44c94c2afbbmr114781765e9.33.1748359395627;
        Tue, 27 May 2025 08:23:15 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f74cce5bsm266937635e9.24.2025.05.27.08.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:23:15 -0700 (PDT)
Date: Tue, 27 May 2025 17:23:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Arinzon <darinzon@amazon.com>, 
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>, 
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, 
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, 
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, 
	"Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, 
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>, 
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, 
	"Bernstein, Amit" <amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, 
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, 
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v11 net-next 0/8] PHC support in ENA driver
Message-ID: <rvulfy3bl3htcp2r3kbpzourftvgcu7647dw6msxc363qe4khi@kbl4bevmrkq7>
References: <20250526060919.214-1-darinzon@amazon.com>
 <jdkiblbwiut4x7t7gtpiatdbiueehvhuqdhn5caoj2ijiil2yr@6xof3oyhruxa>
 <20250527074419.40163789@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527074419.40163789@kernel.org>

Tue, May 27, 2025 at 04:44:19PM +0200, kuba@kernel.org wrote:
>On Mon, 26 May 2025 11:53:14 +0200 Jiri Pirko wrote:
>> Could you please add very simple devlink_port instance of flavour
>> PHYSICAL and link it with netdev? Having devlink instance without the
>> port related to the netdev looks a bit odd.
>
>'Physical' seems inappropriate for a "host side of an IPU".
>PCI PF if anything, but also I disagree that we need every devlink
>instance to have a port. PTP clocks use devlink and are not networking
>devices at all.

Sure, but here there is netdev. That's why I think it would be good to
have the related devlink object created as well, for the sake of model
completeness. 

