Return-Path: <netdev+bounces-117294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8670094D7E5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 22:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90431C22A72
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 20:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036316133E;
	Fri,  9 Aug 2024 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIN07nqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D341D551
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234264; cv=none; b=brgpUL+fd3wakMvS3fg0SqkKe4MSpMlScJCGP7q4tEFsDZrox93h1k9OVdAuOMcIHOxTHMzimIpAISiBZxB9VDrrEZdJay57hPk1lNp/Ugq7ecJYlDBpS0P/5I1IYmOic3HRSke8PABfec/A42xMtoaJnnkRpS22JxTeGTRaXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234264; c=relaxed/simple;
	bh=RXZf7vkTwdMNMIB1Lg640qcRRptGXyS7Rvi9NC+WScM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmME3JWJmHqhGqGFb28cFWqyGBxIxpVSzM+jhqFncz0bVa2p3g99hFmWYj7aa1bf6US/L+hbr7TyP7uvenVO4YEBf6gVPtWL6pRM9cryesTOy4/bAgdSdjMRyrTjgVLz595XrqvYs11TRVpvUplFhR/Ghid8GU6+7TY+syVtKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tIN07nqO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04c29588so3247291e87.3
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 13:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723234261; x=1723839061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj1EA6fBIZmJ4OF0t8kLT/cba5XWiaDdw7BLVxTuH04=;
        b=tIN07nqO0JSLBMlzs7u+WKqOUHnwFr3i00aDNxn/oOSEq94jwIPcwOZBrIhRRL+6zT
         GWe8orSwgMlv+sFtqJqsy0b2Qa5DtElrNxtKIun8Y/EzeUssJfkxgRdzhwS0T0UzGAFQ
         gLfbO3n7YAsuFD5QWxe/h4FD15ZKIT+iFcarP1MC3lftsOAptFDs+OI6/IVyspJnMGxg
         u04nDYtz+D8m08DLuZ1VYJeZhigEBiQceERsr18cpxsVGJZ4c5i+kTrln0eYKZtvaQI4
         nH7e0eV5Fyt6Wq3fHk8hoh2U/1Ty0fHm8GhGfxwRUiLyiNPZ2Kf3pw/P0QnNasOeM4KK
         XPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723234261; x=1723839061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pj1EA6fBIZmJ4OF0t8kLT/cba5XWiaDdw7BLVxTuH04=;
        b=t0poCx0wJCSQzeV5IeMXfNJJdGMzsk3dx6Z64BNzxDYN74mtmnXrfxwswn/foJUcLA
         budcEG7ky1c04/OF87KNuQ0KnJE91qqbLoh7ZeNiu9JzwR+8ALUzpE7Nu0HfMS/CgObj
         cE8McDg2hkg6GTD51yG9mxwY6altti549XBZpx6Gh9X+xUIutdpsKRWgkjPySPyAbYbz
         Mj9CmvgZPil5mdkoPREoBF6M6yqTmAsabbfcR5oeTyyKPSpH7fbKehjof0s5i/c9j/3V
         XfxrocaTkq4tRLT0HzLgLP5mcL21pktLqHo7Z8HJ4lGqLcRCKfrtM+IwRwxCsFUZCR0o
         F+eA==
X-Forwarded-Encrypted: i=1; AJvYcCUcjdE0uffR9msI7VqQXX/V/tUHXeZ02Xb23Vg9iv7EgZdtfqp1bNcKfeRybBMX1xdHLbzVTbFB0LY2REF5ASo6Q9D3P+UH
X-Gm-Message-State: AOJu0YyFW7TJAcY7ynUfvVj+cPCmfLwLgd2/jRHLG5dLb+tO4WSaVRXp
	uo0uS4CKiFOOx3KtgKmao59kRpnAWRnKcrHYM9YsXkJecpr/sYOITHolqIa7euE=
X-Google-Smtp-Source: AGHT+IH/LnHxFTHPrshu46vY7c7WkYZl+9lpQ1usrc5SQkzFaG6QQkaJPPpkMh/UODiY9nwCiBZmfg==
X-Received: by 2002:a05:6512:10d0:b0:52e:9f6b:64 with SMTP id 2adb3069b0e04-530ee9ec4f3mr1766990e87.34.1723234260740;
        Fri, 09 Aug 2024 13:11:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb08f6a0sm7187266b.30.2024.08.09.13.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:11:00 -0700 (PDT)
Date: Fri, 9 Aug 2024 23:10:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next 5/6] net: ti: icss-iep: Move icss_iep structure
Message-ID: <6eb3c922-a8c6-4df4-a9ee-ba879e323385@stanley.mountain>
References: <20240808110800.1281716-1-danishanwar@ti.com>
 <20240808110800.1281716-6-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808110800.1281716-6-danishanwar@ti.com>

On Thu, Aug 08, 2024 at 04:37:59PM +0530, MD Danish Anwar wrote:
> -	struct ptp_clock *ptp_clock;
> -	struct mutex ptp_clk_mutex;	/* PHC access serializer */
> -	u32 def_inc;
> -	s16 slow_cmp_inc;

[ cut ]

> +	struct ptp_clock *ptp_clock;
> +	struct mutex ptp_clk_mutex;	/* PHC access serializer */
> +	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The patch adds this new struct member.  When you're moving code around, please
just move the code.  Don't fix checkpatch warnings or do any other cleanups.

> +	u32 def_inc;
> +	s16 slow_cmp_inc;
> +	u32 slow_cmp_count;

regards,
dan carpenter

