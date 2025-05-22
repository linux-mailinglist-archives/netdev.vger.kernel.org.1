Return-Path: <netdev+bounces-192532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDEFAC0483
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521E8166E76
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F40221729;
	Thu, 22 May 2025 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF9ByEW4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185D221723;
	Thu, 22 May 2025 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894862; cv=none; b=By7bd7LJtTiKdg0bS4B9o+lmG7g6pkB0fLHBKaKisNuKnyLcg/kDMvjwlNPuuENMu9absanqSJJuKnN1PH8aCJCYG9vXOa54T4E15eX5NzhslRKHgfNhsQ3iUQFv8u5WSgJxfkcQjvSNv18tCvp4cbVT3WIw2SYZfeEA0hmSFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894862; c=relaxed/simple;
	bh=8Gf9CvcRiX0QDzOZJoLJ0kQ8Rhrd0PQeVZLFhyDeOQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tcsccu3dUdfY0Oj7/51YDI+71br96HCCl2/DuS7T/UULD+3yKbmG3YRuQXGfjDZK40JKe12fuJsp9JY06WpZd5QZYsH8WRsE7+XFE5I1IBg4oF4PslucnzRnzZTjOjcPHWCjHyz6aDBzjqYVmQU464f9xZ9NlchikjKnw2zY4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF9ByEW4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73712952e1cso7074976b3a.1;
        Wed, 21 May 2025 23:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747894860; x=1748499660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Gf9CvcRiX0QDzOZJoLJ0kQ8Rhrd0PQeVZLFhyDeOQU=;
        b=YF9ByEW4e0P/m+v5qP7dyIJn2nb1wa7Rw8z0l4npSQ+Ln9mFn98XgNHKcoAWfPbYe4
         wkDUSK2H5GfuRtUn8JXWpHfHqKKyRI0xkPzUHg7ziYFql/TGMskYDDzlgPZWX4cc1lta
         yiaKWmKdSvG6Imd3pdIWTeNfRSUaYlRoim7QFMAeZ2WIJaXPh+1BjTYvxRNZ+p+CahHm
         ogA0Su986KCvbnGsx6WbCiASdJLxXawj00Ttpei20ps2h/kFaw1WDP9YMkPLfhN6AE6F
         7XiorLAOb1Z2q87eQe/RmpnfclmYDmg3gxoRgjGqadRywgqHXLlkJTO6yGXfydeoNrPD
         WQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747894860; x=1748499660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Gf9CvcRiX0QDzOZJoLJ0kQ8Rhrd0PQeVZLFhyDeOQU=;
        b=mZorxcb1LenDEFdioDdog9lrqNRgpCpmB93azRdF3hn7qRJQE4Q7jvYfs123S75S3t
         44DGQvaMOrGMItgETd0j+jKHl/tFYzQDhyHE84onGmAxMylUezBwoH8Nt45RjBQX1ydO
         5RYsT/6Y0Fog6i1BWBOLahTQM2gmULcHeKDk31NbcCRoW1ztupl2abiLDrsMDdMjWGMU
         6omgmubJUVq0QrmflCWHar1Fn9rRxImPAuLaAxgKAOTjechPLMh7U3NLZ1YfWDwLyG+C
         aF/p3573v/+Lf9hUSkQtfi9TbzpFDUo+iJQ0FhOjhTGyp2y7mE3ZuWhsM3iZZGkF1uj6
         fGSw==
X-Forwarded-Encrypted: i=1; AJvYcCUWT0anbX6Qus426spUrK9DYqKvT9G1xhSC7Iq22zTXbvVxPC+TBka+JXMO6PGr4x5oBie8dDnm@vger.kernel.org, AJvYcCWE2haACsDi09alccgw7z6VjjPZFVMJrXW7ntxyC3PW5LauOL+SYEK2GFWkfPSALSSwX2Mf/1fwJdSKZDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUzfm3xKp71qjFfYSAyuH0chnYOMg4O1Guqmz/TX1SO1WOG4v
	i8dTa6nshcqQZ/NuXUHG6xfpjhXnzUxvwKSvD1eDBI3qhQqmhqBbvgFX
X-Gm-Gg: ASbGncvV8OmWtOubNNutXemXtrfxGQhyI+5K0xIEfzfWm2M43Fr4+MUzHfwYoGN1qMR
	hhFOxENrJW6K0Jf5B1qk8osu9U6xFgHFEMZ82Qdpy1UNobElk8AnTKW0IdVeK1BbQ3TYGqhfV1q
	Vn/rn8sfhuCX93rB6OOeLbl6fgjwaIPJvyvrx3fc/K7psVVBmYpD48z62MYBZplspJXGFYHnZJs
	MdGS+Z1xqHjqXKd3wnpywx8fmPbbtm+zAdUyF+SrJ3EnrcMQUn6LDORHIcqBxSzOZaMX5mZcGsO
	B0giAKkyuyRZIaxIMJlflG6NPzyq5RPCaDd26oRT/tFvj9chdg==
X-Google-Smtp-Source: AGHT+IFApv0QadyLlnFK7Jc8zTrCRT6Mn794aYfBhT+1fh5yci/dZulqyuNRKTH4wK4czcH2IicG/w==
X-Received: by 2002:a05:6a20:6a28:b0:215:f6ab:cf78 with SMTP id adf61e73a8af0-2170cdf123amr35822445637.28.1747894860095;
        Wed, 21 May 2025 23:21:00 -0700 (PDT)
Received: from mythos-cloud ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8a199sm9181408a12.33.2025.05.21.23.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 23:20:59 -0700 (PDT)
Date: Thu, 22 May 2025 15:20:55 +0900
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: add Kconfig option for RMON
 registers
Message-ID: <aC7CR1ZTaJ7m_Dna@mythos-cloud>
References: <20250519214046.47856-2-yyyynoom@gmail.com>
 <20250519165758.58157a0b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519165758.58157a0b@kernel.org>

On Mon, May 19, 2025 at 04:57:58PM -0700, Jakub Kicinski wrote:
> On Tue, 20 May 2025 06:40:45 +0900 Moon Yeounsu wrote:
> Kconfig is not a great choice for chip specific logic.
> You should check some sort of chip ID register or PCI ID
> to match the chip version at runtime. Most users don't compile
> their own kernels.

Just to confirm. are you suggesting that RMON MMIO should be enabled
only on hardware known to support it correctly, instaed of exposing it
via Kconfig?

Then, I'll drop the Kconfig option and enable RMON MMIO only for
known-good devices via a runtime check. Currently, that's limited to
DGE-550T (`0x4000`) with revision A3 (`0x0c`).

The `dw32(RmonStatMask, 0x0007ffff);` line will also be skipped
accordingly.

Let me know if you have any concerns. Otherwise, I'll send a revisied
patch.

Thank you for reviewing,
Yeounsu

