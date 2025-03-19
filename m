Return-Path: <netdev+bounces-176290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902F2A69AC0
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FC53BAF84
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB101213E79;
	Wed, 19 Mar 2025 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/gyro8O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCFC20E024
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419323; cv=none; b=AxhPHG05fij3bO5i7irE30Or9QEYSjIcMLEH1jfNvuvZbW0Xr7pwHf+2f64IKf/PKHDvYPLP965lf/x7flz2DIpeYsoVxT6oBCXqjNkUIoqd7pYxuvU/BzygBvmlhEo2UAL5DFJgTBizNiqvABNRt787VMBcbcg7iLh/Fa7nE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419323; c=relaxed/simple;
	bh=e04yedQXmFV0fUEoy3MX7U7nXzBv7zCj3PD8JoIkGng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzFCFsqWDT/X9R/Ik2EHfEkTrzTJzIfZ2NujfP4C6vZ557ralkRELSGcB7mI9QgmHO4wXLba5MF7ivqCo6+4Vtu3FtYV4HxSPOkgdMaDOM/FBGkBUtQYBO6ne2mBwo3/dY9YchA37rJhRqxxXB648QPCkYLU49PmyKO8kXE1sZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/gyro8O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742419321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDWNLxb1CzYSCvOOKpH+bW9L/oTxpk65TwCMBk+ej2A=;
	b=Y/gyro8ORdUl0DefHG4FlGzvqdQzyMo62IWcZ9CBnJQz3wOtoR0lj2dJIKfKFnEitNbpe3
	60thfEwYVmwF78ktX/E3wR6zunuphy22QghUeEqHv/yWn0P/HeixRGDuAiubQtFeAM/4Nq
	VaZOW0QXr028/U3e1vEzK7oHdBY9E1o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-U-0hzIeiPwS8E_Gmxz4Scg-1; Wed, 19 Mar 2025 17:21:59 -0400
X-MC-Unique: U-0hzIeiPwS8E_Gmxz4Scg-1
X-Mimecast-MFC-AGG-ID: U-0hzIeiPwS8E_Gmxz4Scg_1742419318
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c747c72so428045e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 14:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419318; x=1743024118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDWNLxb1CzYSCvOOKpH+bW9L/oTxpk65TwCMBk+ej2A=;
        b=ApiX612OXXvfLiP3pThj9n1KJcSeTLf/gREBrii4xlnu5TcFL7ga+cMGZ4ZzQK5O3r
         VNMi4wQu9zA9SFwV/0NmHdwjMTBHJEhCXa2vd3gufFneERDy5PVyoCBLPNYQxmR2T2pA
         yQeuAiMqSW3EPee4H2LVcLP+BycXax+fiAhEdtKHAHZeVkbER846jnUQHIJx6ikHK8pM
         OPfvVEdP50pR8azkHEtOm+9238oOC1ESJMVdc6s8RCJgAT+U9DPjm/daMKQRRbuRn6Vo
         otKXj4znGQXp9HJPTrrJPZPU4v7pcbu51MRGOHdiYnDpQ4ebz11ydgYeekdo8SvpIAtR
         M4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Pl4CR99ITSm0vh+93vp386h/0D8noecWrG8fvgbfGYYsvQIu51nN9xYU2pUz/OI04ZlkcW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2d2FP/qvqXyLPPdPU/0tNCLZKAafVHjImhjWbvXdwrfI+ond
	Bo2gZVN2Ugp4ZeLBiis4LBfntxdAxk9fTrWcRI0E9jqNBnZnelOz5+WUsryUIRf150481YUsXil
	/wUasTW6mBX0ZHuxfDkGFAY01uHHYNFKI4aKZeaZmxB7YyX01qgJ5ew==
X-Gm-Gg: ASbGncvpjxtN4EjVFQ6eKRUjOIih7AJU7yHb4v0iTXOIx6F5GldbehzSaZCdS+EL5bg
	KVgDYd+kHtPQnfcr0t4wA4PxIbXYYSFHVvMkDK71SHFa4HuBCcnWBNDzU3YxC43kgUOuQOCgCVU
	kBrQFkUEIprUyL1L7vs/+OJvhDJsx+NTHzC6ryvKLAraP1TrPYpwbP7b2EzuNlDZpGB9u/DOmtF
	2ffH0DrkkV2K8KeZWDYd8BhZxSbwAr6X1NUIpTWwOG4evwIp8PM4jvP0xj3j94iwc2CMLr6HYBi
	UoCCHK4Qfu04ZaP3aBESCfKPdZ5UynHKoLVHcylj6spDGw==
X-Received: by 2002:a5d:47af:0:b0:391:10c5:d1a8 with SMTP id ffacd0b85a97d-399739b4417mr4041368f8f.6.1742419317807;
        Wed, 19 Mar 2025 14:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaLSnhNgHajpagGDMQ1+5o7+6Po7P4WxyuDoDHztzaTcHpWdvzD63DxuxxFMe7m0VyNcvBCQ==
X-Received: by 2002:a5d:47af:0:b0:391:10c5:d1a8 with SMTP id ffacd0b85a97d-399739b4417mr4041347f8f.6.1742419317363;
        Wed, 19 Mar 2025 14:21:57 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7e9f8asm21826669f8f.81.2025.03.19.14.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 14:21:56 -0700 (PDT)
Message-ID: <4cfeb80e-8799-44dc-9b8b-7b7e0e329541@redhat.com>
Date: Wed, 19 Mar 2025 22:21:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/5] net: ptp: fix egregious supported flag checks
To: Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Ruud Bos <kernel.hbk@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 UNGLinuxDriver@microchip.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Lasse Johnsen <l@ssejohnsen.me>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250312-jk-net-fixes-supported-extts-flags-v2-0-ea930ba82459@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312-jk-net-fixes-supported-extts-flags-v2-0-ea930ba82459@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 11:15 PM, Jacob Keller wrote:
> In preparation for adding .supported_extts_flags and
> .supported_perout_flags to the ptp_clock_info structure, fix a couple of
> places where drivers get existing flag gets grossly incorrect.
> 
> The igb driver claims 82580 supports strictly validating PTP_RISING_EDGE
> and PTP_FALLING_EDGE, but doesn't actually check the flags. Fix the driver
> to require that the request match both edges, as this is implied by the
> datasheet description.
> 
> The renesas driver also claims to support strict flag checking, but does
> not actually check the flags either. I do not have the data sheet for this
> device, so I do not know what edge it timestamps. For simplicity, just
> reject all requests with PTP_STRICT_FLAGS. This essentially prevents the
> PTP_EXTTS_REQUEST2 ioctl from working. Updating to correctly validate the
> flags will require someone who has the hardware to confirm the behavior.
> 
> The lan743x driver supports (and strictly validates) that the request is
> either PTP_RISING_EDGE or PTP_FALLING_EDGE but not both. However, it does
> not check the flags are one of the known valid flags. Thus, requests for
> PTP_EXT_OFF (and any future flag) will be accepted and misinterpreted. Add
> the appropriate check to reject unsupported PTP_EXT_OFF requests and future
> proof against new flags.
> 
> The broadcom PHY driver checks that PTP_PEROUT_PHASE is not set. This
> appears to be an attempt at rejecting unsupported flags. It is not robust
> against flag additions such as the PTP_PEROUT_ONE_SHOT, or anything added
> in the future. Fix this by instead checking against the negation of the
> supported PTP_PEROUT_DUTY_CYCLE instead.
> 
> The ptp_ocp driver supports PTP_PEROUT_PHASE and PTP_PEROUT_DUTY_CYCLE, but
> does not check unsupported flags. Add the appropriate check to ensure
> PTP_PEROUT_ONE_SHOT and any future flags are rejected as unsupported.
> 
> These are changes compile-tested, but I do not have hardware to validate the
> behavior.
> 
> There are a number of other drivers which enable periodic output or
> external timestamp requests, but which do not check flags at all. We could
> go through each of these drivers one-by-one and meticulously add a flag
> check. Instead, these drivers will be covered only by the upcoming
> .supported_extts_flags and .supported_perout_flags checks in a net-next
> series.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

I admit I'm the most significant source of latency, but this series is
IMHO a bit risky to land this late in the cycle in the net tree,
especially considering the lack of H/W testing for the BCM phy.

What about applying this to net-next instead?

Thanks,

Paolo


