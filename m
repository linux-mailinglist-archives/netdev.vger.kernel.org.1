Return-Path: <netdev+bounces-247344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65DCF816C
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F05F3029D3B
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7984F326955;
	Tue,  6 Jan 2026 11:33:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18892D9784
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699215; cv=none; b=gYvZA5lXkDwUO4csLO9HYUBOJr4SWzVKUi6DqqRTFVLiUIYDzDPqG7VyHKzkqnyH7lpOn+g03Hkqhe1HpRWKzQSHhwshfD75r5HUfyPddd7/TTPHUt1OY0kY0bjs3svmVMBtwSayYIQsZ2/LmvqqPcUYLLVlJiap7XC+jgjSRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699215; c=relaxed/simple;
	bh=A6LqIfDgKDeozuV1RCujGg1NJdi4mYw8+E40Sot9BoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz2r9MkSwCdFGKp44hnx8TovqbpIjHmpKIUkijxylseTC87qDNmUie+bRaWd+wcDY5OWk81dsvzshx2rKeDCqPnBpHIhYylAHWDA7sD1T0HmqhBIbN1R5VwQ62HJd62Z5EtsH2j8ij1XvByXqvy2eof9FzgQrKKIcegGfC00/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-450be85b7d9so595858b6e.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 03:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699213; x=1768304013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aY5FARf65kfsbdb7ftnB/uPYG4AgZz8PgCWDolIuCL0=;
        b=Pw6dbRQ0hW7vbyR9ET0Mmv0bY9t9VPCc+tYqYw/l5ZCljbMvfJQXhcTLeM/sa0t3tF
         iBQkH6brepA7p5pGt7WqjNSoBUWo9L6VSMVS7GRncrt8BV+QujNPZZlKSWvmqfMfOyBW
         EitRCvmd45vDbfkojxtrjUJx4gaz9yAZ4OKW/bo94m/ceSnL8QbHnJhqET0JWjWSgaI4
         55no5Twmu464snfeBKQ4gBuTffAxARxQbEvvfQ6af/ZE1qmUrtF7RJu7/OLc5DiQIMEv
         BbOgj6EHoX2lQKJVFDUDJhekQ3CdMEar28+iuM/ti9MYyoh8zn3M4j8ImeaUTkM7UjJK
         m8hg==
X-Forwarded-Encrypted: i=1; AJvYcCW15rxpSvzhLSqBIdCoEmtth5b6rkBaMBVnEl083mR6+0STAAYwKKg9vZQeU2IEIiq7Qs9cRAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQP7BlCNnGWSh+zae5id88fJ5BLbvYd1Rax7Pd+Wk9eA0xS0ww
	K+DPkjHWNw4ABlg/N9G/o61LO+X/vOj9jrvEXAD2ISJBt3kxhGOVyHwu
X-Gm-Gg: AY/fxX6/2AtFzHNIN0YXrayTQPEsGWy7utYIOZxQM+lOxB/+oGFbfu3Q6i/7OYZ23VL
	PUaZP9/8Tg/QigyLExHMoBS/C/+ZO4np6GXYLGytRzv15Jvln/cuBEA58ovGxAscgPH8fFi9QeC
	ydqfphvuzSWH61TyS4bbaJvIwex1rcIVN0jWgTu2cHgsUU5AFji3vnRzv6FJg2YpjlvOD/zNHh3
	0F3nxKEukfo+1nFtu6i4bRPcsY+09OF2YKAcDDfkav/sNWU6sW9QFr1LQnP1S0hVfkuUzRxd+1Z
	e8mpd9yzCX9o3v/q9paPQ2IHehQbyrtPJaaDwPNDNxMPD6EJSBaYMcHHaMT/JBrqb4jSsA+cI8D
	B6tH8rnN1xD552H64ty4rhia00/0KnfEWv8TWZi6uNEfbeY/YGWKlq2MMfHW8g/4mN+zOaWgIz/
	F0jDtTzSzZFV4bYBDy8VMHaAQD
X-Google-Smtp-Source: AGHT+IFKAjFYphYrDLHhk+T24gU/abKK3UAW6NHo0VX7fL8TrRcAZexjFpgP0TK8XjvR+rJnKRdFMQ==
X-Received: by 2002:a05:6808:bd4:b0:450:b7a0:41d3 with SMTP id 5614622812f47-45a5b1a49famr1581987b6e.67.1767699212842;
        Tue, 06 Jan 2026 03:33:32 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ede38sm1246486a34.26.2026.01.06.03.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:33:32 -0800 (PST)
Date: Tue, 6 Jan 2026 03:33:30 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in
 bnxt_ptp_enable during error cleanup
Message-ID: <eitjt4fn4kty35a7ilfuygdwrpbye2gaz3zu6uoposmtbk52ax@skrxzmvkz6p4>
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
 <20260105160458.5483a5ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105160458.5483a5ea@kernel.org>

On Mon, Jan 05, 2026 at 04:04:58PM -0800, Jakub Kicinski wrote:
> On Mon, 05 Jan 2026 04:00:16 -0800 Breno Leitao wrote:
> >  init_err_pci_clean:
> >  	bnxt_hwrm_func_drv_unrgtr(bp);
> > +	bnxt_ptp_clear(bp);
> > +	kfree(bp->ptp_cfg);
> >  	bnxt_free_hwrm_resources(bp);
> >  	bnxt_hwmon_uninit(bp);
> >  	bnxt_ethtool_free(bp);
> > -	bnxt_ptp_clear(bp);
> > -	kfree(bp->ptp_cfg);
> >  	bp->ptp_cfg = NULL;
> 
> Is there a reason to leave clearing of the pointer behind?
> I don't see it mentioned in the commit msg..
> Checking previous discussion it sounds like Pavan asked for the
> clearing to also be moved.

no reason, just a mistake. I will update.

