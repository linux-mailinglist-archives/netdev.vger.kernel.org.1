Return-Path: <netdev+bounces-92330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF9F8B6ACB
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 08:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796BC1F21A93
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 06:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E381B963;
	Tue, 30 Apr 2024 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8Q/ryV9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBAC1B806
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459579; cv=none; b=aTnnOL0XLKF6RfdTinbTN0h1T1J+0F/Ps+JesLZ02fE8v733moRPh2+dp2B48EBhbn64dBgTHrCbdaen14aoRaW9tiSYGf1gkp20siFgqrBCxMz8GoPwBCrYZX/MYK3ncfa1DpYExIhBRcYZeJdxiZN6YN3jH5jp4WyW3vtgU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459579; c=relaxed/simple;
	bh=eomxsH58n2Y7ul46c0ra6SHud53/uQqIv5l6KWdYkvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDlbx5etptV/L7rJYVFT9reFDOqZjOM9UA99GCAxtAOIwx77ZJ6YC3DvHjo/IegIvSU2rQusTe88B+LAesvx+u9l8fEIYNzlzDOFo0C+NHbBKrUKOzG1PW/ts48r7a4GUeYm2xxtM2m/3rQJKqmDi6v1stSgFpjXPTOmzNuiU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y8Q/ryV9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5878caeb9eso652328366b.1
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714459577; x=1715064377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kmtuXvfOzTJE5RofB9OsnXxtdNCBS9vMin6Fo4lqPA=;
        b=y8Q/ryV9UOWp3CoXmlCjKgkWUrLNm4HaTlgk8fKZylGOfOvjSHZ82Te8MIsvaUv2rz
         HEVpbiKhwqpLwOl02BuGaYEMxG73/FEuEmzY12li/q+zBBDPgUx2pSfgXNx8s41woCtp
         mGdTa2fFZEe7/0Ia/gySyhuJSdJiaVImFNQkA7bZ+WqO/6ExXHq0uB+UGfWTb7kZHSDJ
         kX5TnAkCmKkK535E3uRHZUnKhfOSdoStsKF0xDjfgwdGrI3CXzwW4RwzFM7CSmNnQgKM
         BrWWOCMsm4bj8QwXqUo0GKg/4AcqInyGETcOPrHnrFFgyID2GRKU+NtyNnvYLGLJmU4c
         UleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714459577; x=1715064377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kmtuXvfOzTJE5RofB9OsnXxtdNCBS9vMin6Fo4lqPA=;
        b=UJ5wiLIKMdb5NSFrxdIEmHZHSt0dZdFeIAOmX9lne+97KOmJOB5gAVxCrDvlIgDbPU
         DDUyPLdCSOX6EqMGrRyDAXjIgIhLvuC8+RBYnXIi2TooPQrGRIXLXVFaGKoO1CHP0KLd
         sI2Yoe0JdE8XBdsC/tSjm69Re4PzNs6vg0LyIsL/5OWpX+PRBhkUsSWeaVuAX7Dy1muV
         T3TjPMAM6ylcosVolJPOYFq20nbpe1UEVbjUPgFXkSFQA9eTZsp9lXcZIqK/YbdHjG0i
         A8F3P+aFRYeFwt6qzyp8uw3RPb+hD9Ud5EbV2gd5M7V77OEeSsfUwAFLRaKD9Xav637h
         nQOg==
X-Forwarded-Encrypted: i=1; AJvYcCXdmBYJubt64yl01z7YpivtUNmP9PKPy30abGv/YiG8DCgE6v50Bfbgb+WwU6f1yyTTjTknx6hebR99Sk/vgkQURHBSMWfO
X-Gm-Message-State: AOJu0Yz95NFlPBRJVurvQI8u4kaiNWp0Don838Y+QhoVwckugXiwS+43
	GdGkail8ZySIP6ePlKpBlJmRI4srFYk4K0faUqAYntfuFVpRqGRwrCenBlIRXt9usQticNUqLuT
	M
X-Google-Smtp-Source: AGHT+IHfEGOIlAy1q7W+H3NzXIySOqeRKPAtUJlO+eVYUEG6rVWXp/uCTWruXEVrubSQ72MD88Po3A==
X-Received: by 2002:a17:906:ddb:b0:a52:6b12:3078 with SMTP id p27-20020a1709060ddb00b00a526b123078mr1142634eji.55.1714459576234;
        Mon, 29 Apr 2024 23:46:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id la8-20020a170906ad8800b00a5931d77634sm139728ejb.34.2024.04.29.23.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:46:16 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:46:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2] net: ti: icssg_prueth: Add SW TX / RX
 Coalescing based on hrtimers
Message-ID: <183bb17e-8f2e-47d9-b15a-e8b6bfcb7f43@moroto.mountain>
References: <20240429071501.547680-1-danishanwar@ti.com>
 <20240429183034.GG516117@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429183034.GG516117@kernel.org>

On Mon, Apr 29, 2024 at 07:30:34PM +0100, Simon Horman wrote:
> > -	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget);
> > +	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget,
> > +						  &tdown);
> >  
> >  	if (num_tx_packets >= budget)
> >  		return budget;
> >  
> > -	if (napi_complete_done(napi_tx, num_tx_packets))
> > -		enable_irq(tx_chn->irq);
> > +	if (napi_complete_done(napi_tx, num_tx_packets)) {
> > +		if (unlikely(tx_chn->tx_pace_timeout_ns && !tdown)) {
> > +			hrtimer_start(&tx_chn->tx_hrtimer,
> > +				      ns_to_ktime(tx_chn->tx_pace_timeout_ns),
> > +				      HRTIMER_MODE_REL_PINNED);
> > +		} else {
> > +			enable_irq(tx_chn->irq);
> > +		}
> 
> This compiles with gcc-13 and clang-18 W=1
> (although the inner {} are unnecessary).
> 

A lot of people have the rule that multi line indents get curly braces
even when they're not required.  I feel like it does help readability.

regards,
dan carpenter



