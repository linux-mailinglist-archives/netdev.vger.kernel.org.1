Return-Path: <netdev+bounces-158168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5316BA10C36
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42752166676
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831D1CDA04;
	Tue, 14 Jan 2025 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0ntkZNu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93B1CAA9B
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871890; cv=none; b=afU6fS1qLutAWL7jOvaB6NsiH3jHqaPDnRERFZQJmZbBXG+9Cw/HHGozbsI6xp9A5nV5JjiIvAAcJQngGhsXtVwH+q8rpEqonHTToiGnbXR7FrVRAcO6oVIoujuYS5RkUGeJ53pYokc7hlU07fgEzFJeNCackn2r9Ke6vSSjqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871890; c=relaxed/simple;
	bh=rMAJ9HXZWTUj1oKXY/MV47bY0rxn6TXRXb1AJjI7Kh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhtnsjZ3Vq6eFQPe6K9nIyYe01Y3sTNI2nq9bLxtiJXMFCxoymOBOqUwcx1vncNyrMWzTMEpByCatbPJQk/DjOt0XP9HHOsK2p/WcXGAU5wF2BKScs6OrJJYDuGryED+5+MKsl0a4nO1Sgvrtt3ddA83B5NWlQgu/YPRlV43toE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0ntkZNu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21628b3fe7dso97460255ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736871889; x=1737476689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4YRVzcxNd8FMIfL0bqoXxnU7ZmaMIDDSDXE/dwr1rM=;
        b=R0ntkZNuqPtQ793EoHen8aUfRvDBpba223zikOz264K9Jt/fuHijvI57DQwGRILnKf
         UZV1dzAs9aa1QcBc7tPYn0peSDicAVvDuKPHyMTb2S6lLqAbJJlPktivBAfPyMeHGhbP
         TjYr42DI8uxMwoHZ1hxuKPdPzuy0lezlFzGMW8LMSJbDH5pSg3HBr1nAjz/A0fzAkzFC
         PYmhGVJoGPXWAOcykMdPK48+Fh9bM+lyKA8q2gKeQEeljMKtKGoCbDo0jksXNONDAl21
         zsdpBE0kU12ds3nDNTuzKN7sqKve1HcK50kVfDAMU0L13csjAJAjo+mrDFdr6KYG9zsP
         8AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871889; x=1737476689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4YRVzcxNd8FMIfL0bqoXxnU7ZmaMIDDSDXE/dwr1rM=;
        b=EblbRKnWqtoU/yBmAkYOEmq6eCZPelk/n1UOo5xPJXEzObRVE2puBwxUaXVt3/G5V2
         nIhP+mOrczl6PYjY6D+4e78KLLp+paTkr8UaBfMAhiRPX/riDbKl87WO0b6rtWHf+XfU
         AS0SUnwta5vO1VL9IIKouYHVjxsYC+l4Kc8iOTuBi/6Cjno/mtWhYSnEdZeH41gPSWMd
         d+kUs2wzMVk2kh4vIvyuZ/1B6LP/HeHKgX7Uk4T/wvpjn81O5F4Vy5e0YGU4hyKnwbqG
         E2MCIpnXQBehUrt67YA5RTWNjIMH2SJhydkyik4SOr0L/lQ9AwSKOYI3QW/b4M5gARzD
         3pFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkFOy45peGkVAFvFsQCKVuyVAk8eJQH0rOHBqpSjSlJjN29FJ5SmYZoHHkAppFZ0tlfR/3tmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcFnoBIkNUUJzrC2MwTAOGrshEBBLmN7uAXuG7L2nK8aYrQHdE
	hMVNe5XvNez3nBk70rGY2x1tWQIfFU8+NAoUeTh8oGyywqGTXP3V
X-Gm-Gg: ASbGncugBHCP1nD8aFwpeqiNOWCJvwVcvwB4TDn1cUGCeVTlSfm0geLyvQDDnWKpUpg
	ygyOCD2F3VM7tqxds3V81Mfdy6yfC6WMaogKHp5Yr7KRlIRGQWdp+hTkK+Ekdd5YFKSWFkLE/BP
	Mim5sq9Y6zt9lyEey1L49b+UHdzThST+zYfsjBLSNzjVBl9s8UD4a8iUV5eT8o38QBi4i+6r79L
	B+1lPOHA9grE1H2ynyYZGrvgXuswh6YrIsbucqm+TSPfASccB5O5LonK96T6N7lcdpfj+tpBQ1y
X-Google-Smtp-Source: AGHT+IHlsW5+sqtq3vEOYUqJNMOq7WOIZ6uSjQTvK8l3VzA9K4wIK9PrGg7ZTVMZrXSjVsZsdmAZuA==
X-Received: by 2002:a17:903:18a:b0:218:a5a8:431a with SMTP id d9443c01a7336-21a83fcc47dmr412072105ad.49.1736871888609;
        Tue, 14 Jan 2025 08:24:48 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d0eesm69049515ad.169.2025.01.14.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:24:48 -0800 (PST)
Date: Tue, 14 Jan 2025 08:24:45 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v4 4/4] net: ngbe: Add support for 1PPS and TOD
Message-ID: <Z4aPzfa_ngf98t3F@hoboy.vegasvil.org>
References: <20250114084425.2203428-1-jiawenwu@trustnetic.com>
 <20250114084425.2203428-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114084425.2203428-5-jiawenwu@trustnetic.com>

On Tue, Jan 14, 2025 at 04:44:25PM +0800, Jiawen Wu wrote:
> +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> +				 struct ptp_clock_request *rq, int on)
> +{
> +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> +
> +	/**
> +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> +	 * feature, so that the interrupt handler can send the PPS
> +	 * event when the clock SDP triggers. Clear mask when PPS is
> +	 * disabled
> +	 */
> +	if (rq->type != PTP_CLK_REQ_PEROUT || !wx->ptp_setup_sdp)
> +		return -EOPNOTSUPP;
> +
> +	/* Reject requests with unsupported flags */
> +	if (rq->perout.flags & ~PTP_PEROUT_PHASE)
> +		return -EOPNOTSUPP;
> +
> +	if (rq->perout.phase.sec || rq->perout.phase.nsec) {
> +		wx_err(wx, "Absolute start time not supported.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (on)
> +		set_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
> +	else
> +		clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
> +
> +	wx->pps_width = rq->perout.period.nsec;

This is still wrong.

perout.period specifies the *period* not the pulse width.

Thanks,
Richard

