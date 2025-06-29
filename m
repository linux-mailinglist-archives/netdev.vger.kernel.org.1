Return-Path: <netdev+bounces-202250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35820AECE60
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 17:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3963B5D3A
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804B322FE10;
	Sun, 29 Jun 2025 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cYvThIfx"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C219F11F
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751212236; cv=none; b=DdnC08gz1YWAhGdOu2yjrANQyLoVHGlUkU/ShpbRS1afCaT0Zd7N4/ja7WwRIOKZTtNd//p480iLCjEBlCeDGWinmuSxdAO2QJumE9hBsPv+wakUWg2YLsS8B/RvapnDNFcae4eXTS6KEptXntTDKm4bF46cVh4IRsmGAoF8uw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751212236; c=relaxed/simple;
	bh=KT8g8Bw1owXEvwn0Tk2kW5OTQlifVrUmfkl4rFs0248=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWO3dLTeFNdJmGGqGLRlcXVMTbXkgv+CcFKtaTINrGJIz/aunULBa+aJZ7uwTlMshphF04YXK4TTz7o/rImIsXHdYBuWMSES35+Ee/8EQg20Dz0+V61EFZhtN0heZbuGfWdPFUbtpBAz8cjbkHdtB2TMs65nFQLdVB14L5dn/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cYvThIfx; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <37183532-54ff-47c8-9955-af97005e0d46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751212231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DhXfNtBI44OS0VREs0SvVlwWF/37NFzPbWXKchhDyc=;
	b=cYvThIfxx52o8ysqPTITrwI2vWVQ4gptMZBBYLFkThncA14xEWbDOsjBVNf6IK5XX8XA+o
	tNycs4PYY0eQsrambkS4oxRDd3t6xUy/WJHnmMRBDVLstnljo0xaBkFXuqiiywLij2zF0J
	GP8r/+j4oJyhZslphe1RgpjQRiYrhhc=
Date: Sun, 29 Jun 2025 16:50:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 2/3] ptp: Use ktime_get_clock_ts64() for timestamping
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>
References: <20250626124327.667087805@linutronix.de>
 <20250626131708.482362835@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250626131708.482362835@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/06/2025 14:27, Thomas Gleixner wrote:
> The inlined ptp_read_system_[pre|post]ts() switch cases expand to a copious
> amount of text in drivers, e.g. ~500 bytes in e1000e. Adding auxiliary
> clock support to the inlines would increase it further.
> 
> Replace the inline switch case with a call to ktime_get_clock_ts64(), which
> reduces the code size in drivers and allows to access auxiliary clocks once
> they are enabled in the IOCTL parameter filter.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/ptp_clock_kernel.h |   34 ++++------------------------------
>   1 file changed, 4 insertions(+), 30 deletions(-)
> 
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -477,40 +477,14 @@ static inline ktime_t ptp_convert_timest
>   
>   static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
>   {
> -	if (sts) {
> -		switch (sts->clockid) {
> -		case CLOCK_REALTIME:
> -			ktime_get_real_ts64(&sts->pre_ts);
> -			break;
> -		case CLOCK_MONOTONIC:
> -			ktime_get_ts64(&sts->pre_ts);
> -			break;
> -		case CLOCK_MONOTONIC_RAW:
> -			ktime_get_raw_ts64(&sts->pre_ts);
> -			break;
> -		default:
> -			break;
> -		}
> -	}
> +	if (sts)
> +		ktime_get_clock_ts64(sts->clockid, &sts->pre_ts);
>   }
>   
>   static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
>   {
> -	if (sts) {
> -		switch (sts->clockid) {
> -		case CLOCK_REALTIME:
> -			ktime_get_real_ts64(&sts->post_ts);
> -			break;
> -		case CLOCK_MONOTONIC:
> -			ktime_get_ts64(&sts->post_ts);
> -			break;
> -		case CLOCK_MONOTONIC_RAW:
> -			ktime_get_raw_ts64(&sts->post_ts);
> -			break;
> -		default:
> -			break;
> -		}
> -	}
> +	if (sts)
> +		ktime_get_clock_ts64(sts->clockid, &sts->post_ts);
>   }
>   
>   #endif
> 
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

