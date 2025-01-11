Return-Path: <netdev+bounces-157438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A43FA0A4E8
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C811162A92
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E981B0F11;
	Sat, 11 Jan 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3XDqWl/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0410F1
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736614619; cv=none; b=WnEdSTwn3LRq/+PvP7PZYATGMhcrQjRFJBqFJoTnIMbvGxcdtd3RVol1+r4NxyOG0OmmTRytfiwsszvDi6Z//HJboNaoJriVeuKbwpduSKjkxJAxY7EdozrYQGPAxtiWQGQ1r4XAVYAgUf/7ZiC+6/II4z7w34H2P0NTZ3fjOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736614619; c=relaxed/simple;
	bh=HRwtumMcWB5+UKIg0/TtrPC/0CkHOe/h0vSP0PU3oOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICrPKJqWDoE7Qbmq16cMMdNeyOF//UoinEuocv8yG5Key9Hsj9oYSMUyHRlMP4gwdkI9fLX0R+jf2HZMX5yg4ivn8h+IxN42j3NU79d3RBxNusI8T2XbtRoU4EJSZ5ocfVofGS3s/PxEzA22HkpD8MDZUukaWoCFUAE29ZNeA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3XDqWl/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2161eb94cceso36774185ad.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736614617; x=1737219417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvb9q+wNjZvuUYt2kF6D/x9omVb/I1IV5uZ8S2Cr+nQ=;
        b=F3XDqWl/AbcEgRpS4yNxbzoxy+8VP4Q34o29ChIfw3/0rL3lhqQsh1kNGSymmREeZx
         6qwuwOsrX7SUlkUSBMom8XKi+OUNoAwH4jGCkt5fjtbcKaiay7gAlH63GJy2poN48pgr
         HS6Vv3pyExjlay12shewvwA+0V1blRVO4QiyVWJMn+Eh+sftEllfSGyE542RQWgbXs+6
         uPh809fByYHGT2v8xVFnGlmJdCc1JPaLWP6WUI+K0W3c1L5VYnu3qkaDnOR8oKPcQkgx
         KQraFlNpIfcHXZ/2XEnumLXOBP8Wvz5VJW23YukOVRByyZ81V1Qcl3tbAPbBeUfe/Vfz
         cxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736614617; x=1737219417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvb9q+wNjZvuUYt2kF6D/x9omVb/I1IV5uZ8S2Cr+nQ=;
        b=Pp0lwPmDMbYWqe3suCtz8PXRXyk27G36443Qj87GiO+4PMki6zD6TbuNXAIFTh4/1W
         PiKXylPlL/mDPkXAKNiYduGHXKeeByMJsSQ5v9xoORS4wZITURiXOqDwSUls4lYcKSpK
         h0whW5XzYkALSReIzMcWJzt+NIGx/+h1LFb77m1GUnaOrpbE3bn397fhOJC/UBQTA1eJ
         AVR+Zs55ly6uE6zhjqpFlhloeQwiZXDWO7hjPpK/idOTRL1QF4uS7pQnbUfsLB0V9cca
         bVnMTZR6Bz6tVna8McIgHFGRUbA1sdWjRZCzGHxEbHwNyLW/AgnYGbtaTzg9Yts2vB/c
         3X5A==
X-Forwarded-Encrypted: i=1; AJvYcCWMYTV4YPwuPVkNQTz6TnckdD0OjoJD0UF3XwPWi3EFG7R5O149cRVVt3mZMCSZNcAikETDCSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLFQln+YCsOhRSP/UQgeZk4jOTppHbA10Oer5RJIVe2n3tblh
	qHwgK0RNbd4ng58bYGPROK4feic6rF72yRfkK55k9GKgUF7rFpvIU71TP58H
X-Gm-Gg: ASbGncuAVWbcQFemCaIKDN9GHhiZsOurnVN/o9IWH0lxRHBQZoZRSrkW5gfZh1DqBRM
	GHU5pWI1R09pt4rWELNgN1RRrSB///TUng/M2gqyvfmxFO7aAMMthSpv2mvpfk7b6QpxvggqdSn
	mSGX37AEoVZBI1cTThbjQ8UuVtzl1Mk4KC2hfeP07qEdb/tDTq0lhTedz7cvnkk4D8xzEljUTrw
	4t0GLPRdMthykuKPfL0vbF3o7ywQQW366Df2dnXi5GH21hSgLNklMtJklbyZ/mgNNbDFhT3aO1V
X-Google-Smtp-Source: AGHT+IFxKeTRxNGQUfIuXoSiSb6XAYrjAFoRACf3BUReNSakql00po5u16PL70wappOwngMKDesUig==
X-Received: by 2002:a17:902:ecc5:b0:216:45eb:5e4d with SMTP id d9443c01a7336-21a83f4b29dmr212876055ad.6.1736614617177;
        Sat, 11 Jan 2025 08:56:57 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10ddbesm29677655ad.2.2025.01.11.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 08:56:56 -0800 (PST)
Date: Sat, 11 Jan 2025 08:56:54 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 4/4] net: ngbe: Add support for 1PPS and TOD
Message-ID: <Z4Ki1h1h0OCxHfsb@hoboy.vegasvil.org>
References: <20250110031716.2120642-1-jiawenwu@trustnetic.com>
 <20250110031716.2120642-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110031716.2120642-5-jiawenwu@trustnetic.com>

On Fri, Jan 10, 2025 at 11:17:16AM +0800, Jiawen Wu wrote:

> +static void wx_ptp_setup_sdp(struct wx *wx)
> +{
> +	struct cyclecounter *cc = &wx->hw_cc;
> +	u32 tsauxc, rem, tssdp, tssdp1;
> +	u32 trgttiml0, trgttimh0;
> +	u32 trgttiml1, trgttimh1;
> +	unsigned long flags;
> +	u64 ns = 0;
> +
> +	if (wx->pps_width >= WX_NS_PER_SEC) {
> +		wx_err(wx, "PTP pps width cannot be longer than 1s!\n");
> +		return;
> +	}

Instead of silently doing nothing, the driver should return an error
if the dialed period cannot be supported.

Thanks,
Richard

