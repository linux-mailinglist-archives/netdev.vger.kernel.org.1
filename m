Return-Path: <netdev+bounces-198777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E996ADDC44
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF5402522
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142282749E3;
	Tue, 17 Jun 2025 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="B1k+Yql2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9E2EF9AB
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188382; cv=none; b=c1Uq0Uun4WTLItKHl45ZI7TYbBBZUSTOq6fdHnYWTqVqU5+EH16fY+A6mZPIHzqIxKGj8baTQ678b2D6S05v894X5x6N30GYdLhuWOGqiLmxU/6F1PAtj4UYYe4OCP/M3iV2gNCd5JoJCy4nAHxxnYzurtx6DVv+NbyxWfvT40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188382; c=relaxed/simple;
	bh=+31dUO4rcjtMUUXlzCOwSbICZRCgSREkXuE/8AbR9bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h29z2mMe4nWmovGy2EjlV5Gwzc9Ta27gigK3iuEhvFahDphL7YmQFz/Mp+8RuvFus9dWmf/64wLuxWCktphw5261VzstywestSzFjMsD+MVsPcXbnfsmrWAu9dhRORFUl3miTFxSRzjtbkgTHmC0x7Dw5XWzHhRQQX80bBLwIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=B1k+Yql2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so4855662f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750188377; x=1750793177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvnXcvh1RDi1+5VWy9Ydtg9QLom5lQfOR2MBAJMdxUA=;
        b=B1k+Yql2b8Fd7ekBfssb4e6wF+hMGSMOTsp9U9CJ+/JQ7tQfRoYJmMoxqTDpR3/hb6
         Q1fqQvUB8Txa1bG7TT5Yhow/Go4b0OiaCdy0xhmajjJxvuWCJ5bRBjZgc4Fnbw+I3maF
         0w74nKa2sauk2fOo5KHRXAAbHHW+kQ5Ujpkph/E68y9r5xCS1oEmtgLqilr1Wc3AWsBD
         wCiJfvYKj7+X242t/zxh73ygleJIgKuP4XdCRKjGsbmNpWl7gpEnHvvbSqwCjD1WEur7
         3MVYK3RH0Ch/EPaYM/p8To0DSuwZUUHI4GjP8G/iVbnqOZb+olFXBzGdmMI7pfYYOT8t
         Qpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188377; x=1750793177;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvnXcvh1RDi1+5VWy9Ydtg9QLom5lQfOR2MBAJMdxUA=;
        b=fdmb+P01VW1r7Eqej26tV+67PbcE/CwOhKEYb2P2jR0G65b699AyQAN42fVwlDzscU
         BdbYSLsvqjo8DzTR842+s70ub6W6+EdMyNgI69jYS1epFxOHijjc8Pgsy2c933NWO/X1
         KWDvD4pU+lGXXC+/fbundhfQVQrRogFJrMF7FCNen8LtCKN8ZD1TNI2XJvQP+WuaJtZr
         pGlRRaROvmhqLtEFI+xs++cEW8QwuJ19b7huXxtywb3LKfUjlrtPwu9ZdBvs0duAfLVY
         U1M7tmfnFNXbMH2WQc8sbTVMm5GfuLfVYh0P5HALzvItvAHFTRJKolBVSbjc1VFhqnFN
         sMZw==
X-Forwarded-Encrypted: i=1; AJvYcCVMsrRr69pwrfF8fyBFR5Wyboe2HNbHXrC4FX5+qcXnJLP3QOnztTVRkHyL5rJ4IP7xDgubKJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAniHq6EgUUd8UfFKQnldLH+L1+PUQT3xCJ9E85B4IUmjontD
	LhjE/zY4yAK1mH/iXDyGwQrCeFPS/qOvSHmWROggEfnGD2kRKW9ueg0pxNXuYSHzgsc=
X-Gm-Gg: ASbGncuZOAYskXRoz7CY53s9vCa24nMNrasYi765jU0sBOy9ZQgbRSg9n8q7KSxD/+E
	pkHYOahqFJNHCQVGffcZrQCRYMGyEaXsFq4AmWjkcIUta07Aedm8bET4lkljIeYues82yQDotHD
	lSOetPdRqqVuMNPGqL+vr6yGIQgLsVkIwVCrXfGRLeNQ2+ki22o72RgfF1RpG0hm+s3t4bXsRzW
	AUcjWdyydSIScd3Pi258dW87Q3qwHl3qScohsby5VAdmeUchqdD4r1O0YskX3B3mrFImZ4Kegqy
	tL2fh00JdZSwqsYrktfSW6okdhuKB91Ca40MiVtsBz7GvUpwBfHeULGsns/HNJV7elk=
X-Google-Smtp-Source: AGHT+IEUiFIvXyhet/bWWALSq/YNlwF+5E1UarhiITN4eCcgAJUZXGX5Wkp5HghStLLkR8vQrVz6xQ==
X-Received: by 2002:a05:6000:41dc:b0:3a4:f9e7:2796 with SMTP id ffacd0b85a97d-3a572e7967fmr12282440f8f.35.1750188377495;
        Tue, 17 Jun 2025 12:26:17 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08c7csm15015583f8f.50.2025.06.17.12.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:26:17 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:26:14 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	madalin.bucur@nxp.com, ioana.ciornei@nxp.com,
	marcin.s.wojtas@gmail.com, bh74.an@samsung.com
Subject: Re: [PATCH net-next 3/5] eth: dpaa: migrate to new RXFH callbacks
Message-ID: <aFHBVrtj_venh576@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, madalin.bucur@nxp.com,
	ioana.ciornei@nxp.com, marcin.s.wojtas@gmail.com,
	bh74.an@samsung.com
References: <20250617014848.436741-1-kuba@kernel.org>
 <20250617014848.436741-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617014848.436741-4-kuba@kernel.org>

On Mon, Jun 16, 2025 at 06:48:46PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> RXFH is all this driver supports in RXNFC so old callbacks are
> completely removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../ethernet/freescale/dpaa/dpaa_ethtool.c    | 44 +++----------------
>  1 file changed, 7 insertions(+), 37 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

