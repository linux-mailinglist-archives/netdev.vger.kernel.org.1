Return-Path: <netdev+bounces-152821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3500A9F5D97
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB77A1890A1B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9161369AA;
	Wed, 18 Dec 2024 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqfzLWBu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F34A0F;
	Wed, 18 Dec 2024 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493640; cv=none; b=KyPvQeCvcSzNsnmKFOVjV/Us9l2b6Vo3ScK3+T7wFxVgN/UqF6Dfv6meGRFQjxn9MEo2uuiCq/yW86gJwpmVs+5O1m8bqzD3uVGN+URYkWGc17zLLSTuTn8AflTRE03nga3ikh4upccRF58nMKjvhA6JTPwmEgZuNNX0YixlLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493640; c=relaxed/simple;
	bh=Qli0aiyZlqwqjcXsDDy1P0WPBxNihZz/KtgHkDiN+QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSOCmrwZbY2rH0hZg+ef9NXvCeIowCqnY+vtGsJnmD4ZtCtqiyPjxgOFWJaKBN7L2M8AzuZEqN9a8K9c7kWof9zoxjxqiWVJQxKKa9+Aa7vXdW4ClOfzU9fPVtvdS2FmiMQ5QGbR0Yfvmlv36jIZmp5c8XczeDT1HL3eqViCrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqfzLWBu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b1f05caso55664295ad.3;
        Tue, 17 Dec 2024 19:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734493637; x=1735098437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek8PQozkqnschi9wW2r9MjPK+/LMPGH9A2LPzFSniYY=;
        b=bqfzLWBurBgi9ivVMaHW/XRTyaQQOyiMk+PLYo4fSRX0TPPy6aIz6PcGhdgano1s/R
         L7/pow+loqnDal7a9lE9+Kdzo+0OwM+5ou8kyJZeMIlca8vNnTZ2R1WNkNxN+vDc2A93
         XJ7YOW+sVZm3xp3WUvaNVg4hENmTSspYZN4KtrXAX/OT7f3YO4Xog/sr3lDMHqzfX2ak
         ceJS/IkAQwKYAGKhVVQZpM8EhEIHo7KpBeEzk3NwAq0SbGitvEvWiAVhLF1p4in9cC/S
         JmqsM2hkupAqJpW9f6bEzej08EH4pzeskBFWejc21a/lWC/Xj8kl+2W7LeV8mLnu8hRO
         2pWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734493637; x=1735098437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek8PQozkqnschi9wW2r9MjPK+/LMPGH9A2LPzFSniYY=;
        b=C/oTdyWQYEXxfQ/8fi2eYwxkgRcFFKHcQaJjcx3OAUo2i3zWLcjkTFFuW7ax6Jt4hH
         fg59DNfrd7FEWgEyTnqh87AncWSh3vhHw77YIsZHU8Ip3VuCwTiUU6Pg7hZIt19uLshC
         PB1f/djPJSeF6Tq3SCmz64H0MM5RVxh923pnmYEloJfES/BCADOcIYUEfbmNQ+hkO6wN
         xLTWph1Ok0Uj0q9h3/euGJ3FoT3lufT7o6h/H2iTCpgdO3Xu1UlcrmcTW6Kcbh8jqujN
         W42wJHDQE7/7WIBdfiB9d/7IoPD87yiyqwJjIDApoe/TOyEIq8WVl1ImcKZZiCGaQCDU
         KOrw==
X-Forwarded-Encrypted: i=1; AJvYcCUmbmb23ylfB877Rtu1kitl0OO39vGLpArAu8lYROlRnuxKn1q1jpvFQwZPKNFvIf85UpE5WwB4@vger.kernel.org, AJvYcCVGYAxH8Sxl4zbkcTlF0hbJLCK1wj+KeEA4JMiKEWXFg5Nre0kxRZZ0f+eIaFYMZNmQ91CJH/LglFqyer8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/iAMLhL1RoqYzxiIkeM8q2wZq+/chK0pyxl+IKtHMGoBveIgP
	ONZD8b2MsAMPSEz72UqUzxgXxYpaqnP+Wm+aR9spWkmPZ1HoNurN
X-Gm-Gg: ASbGncs/01bDvHv1ostqo6/L2I4vxL/LQuxdlcH0bzSoqDMuQA7cs2rGbPxA4lLbDJf
	fF2QlSz+P3dEVS2AYlRPJNibQ78ZW4RtfuZjOEXvKpyTMUB2swHdZyPAf5BSVObuiIOdY8VuZTX
	hlKaFvyIYPglh0hOXe9HstJCwwUvQX2hZZOJ9g9rrfsTSBMfotiRPPTEfnHtuX8hmD82j3tMaTZ
	WQ+WmBM54g00wGDiUy1q2tFZs/VBljynZ7nE3Yupv2tqpLN+THw8+UX+/fDEOZGmsHZALbl/Wm5
	/AO/4wqi0BGNC7Sufm8DvbgGJI6PmOfjFdrcJkmzcpKILqE=
X-Google-Smtp-Source: AGHT+IGDZPkspL9bdiYOaPDsI2xJsL0DW3nyCNXTCPqb6Q0GeLid+CbTHV1Xxhu3xcISmQ8WIiEnYA==
X-Received: by 2002:a17:902:e848:b0:215:9894:5670 with SMTP id d9443c01a7336-218d6fe5091mr19543055ad.16.1734493637272;
        Tue, 17 Dec 2024 19:47:17 -0800 (PST)
Received: from hoboy.vegasvil.org (108-78-253-96.lightspeed.sntcca.sbcglobal.net. [108.78.253.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2eda2a98fsm329445a91.35.2024.12.17.19.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:47:16 -0800 (PST)
Date: Tue, 17 Dec 2024 19:47:14 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
	arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v7 2/5] net: phy: microchip_rds_ptp : Add rds
 ptp library for Microchip phys
Message-ID: <Z2JFwh94o-X7HhP4@hoboy.vegasvil.org>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
 <20241213121403.29687-3-divya.koppera@microchip.com>
 <20241217192246.47868890@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217192246.47868890@kernel.org>

On Tue, Dec 17, 2024 at 07:22:46PM -0800, Jakub Kicinski wrote:
> On Fri, 13 Dec 2024 17:44:00 +0530 Divya Koppera wrote:
> > +
> > +static int mchp_rds_ptp_ts_info(struct mii_timestamper *mii_ts,
> > +				struct kernel_ethtool_ts_info *info)
> > +{
> > +	struct mchp_rds_ptp_clock *clock = container_of(mii_ts,
> > +						      struct mchp_rds_ptp_clock,
> > +						      mii_ts);
> > +
> > +	info->phc_index =
> > +		clock->ptp_clock ? ptp_clock_index(clock->ptp_clock) : -1;
> 
> under what condition can the clock be NULL?

ptp_clock_register() can return PTR_ERR or null.

Thanks,
Richard

