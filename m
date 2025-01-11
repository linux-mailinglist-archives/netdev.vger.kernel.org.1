Return-Path: <netdev+bounces-157441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C5DA0A509
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6D33A927A
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DB91B0F11;
	Sat, 11 Jan 2025 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvF0re7u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9F1FC8
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736615932; cv=none; b=K7kzXSGiBzOfbN4tJIL/o2qvAUT6KQUb08S2ShCL7BPVNUGaNY2AHIVDa/oM0K8Dfd5zWy0AvPm3DugVTUJ+DWAc6NbwusYnu2uP7naIeRhcMh6BNBh2dJm2D6/6DGSxM1lmQH10uDHVV+Qvj7JFi7+0QjiiJGGJTez97W1D4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736615932; c=relaxed/simple;
	bh=qAXtfNkFDdEGRZ05buDTU2Jh6emtwrovZPv+pQfbCp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIM/D17DvR3Iy45nndSlmNvkKm3DqIbd/qQrimVqWgrZJ9WIcRX/eu9P7wkZnlJs18tDV8AT3RygzmLw5SAvgeuWwziZdM1H0jgamNST0xOoZu27xHaE/q2xFonD8MeYrE2Ug4eFH+FljI5sXPmfU+YdgaLnkZ7X0sR+4wC3Nhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvF0re7u; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso4130800a91.1
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736615931; x=1737220731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7oIuiBjw6QcfIjg1NRv5t/1n1CzW0SZRAJHpYm/1jag=;
        b=cvF0re7utB0xFW7PSWIIFuRWv1WhqBqFanhnxLMld1Q3RuunZSUc1JYS4z/fJTTbap
         aCg/d6I1wheCRjHjKtYB2LuT8+IRX9lBo1t848voKSL8r5XrWCrWKnkjA4YgbR0/RPh4
         TFSicB/M9ZgN68M/UX+gxOefE/EC3JS29X0dzjrKJkmxgmUAhvrSvaNZm6nN35cXYCdJ
         rBw23eljX+ILx28vFU65h0KsBy/ImydJt6hyL3tF2Q0M+XJvLSSVKEw5iixw6mlHiBr7
         n5v0BOTB6aRBvN2aDE2djv7YnJMAfOY6ky6soVan4BFMkB7a9JtGVu9jy/to52bCr8nl
         W4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736615931; x=1737220731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oIuiBjw6QcfIjg1NRv5t/1n1CzW0SZRAJHpYm/1jag=;
        b=F5cSuF07Kn0XhmVD4ssqD0d8BwD6JXQaWfdt2A431XAbvb+IWIkImbbRk6SZAgEBTE
         LmnAb2TAE5gZUlN5LV5HKpbIc7il/A6hIeuCVlJuPyRVjPWBJBctMBN/ezEG+/SlMaJJ
         UpyJIu7Bj6zgeLI06dUOUHZzxKfA8GKz6SHHAk2qs/r2K29GXJTUc5tczMGfAkf2AFSL
         c2Y6JBZlf0nyOOQoqntvDJTmTwuXzhl8AmJWSGdKYL6HHuXaGrmGNKRNqUCbWDaKhrre
         DSMsKCYJX8EnuXu3Izxmzeow4frusNFDmpyp8GQDGAFVqBPUxO2+rCDCSi6eFSVqff4w
         0Owg==
X-Forwarded-Encrypted: i=1; AJvYcCW5hqV3d71aTOx3IiAFE0kTIZ5iVJxLmP/ol9jQHK/XsAmV5+BfUJXD5AyaW8fPYU/5jflZ/1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaINCmqay4fKe8lXTk+XOST6MsiXvEUyaOiSrmOmiEX8RVSCoM
	gVFJVUngr4AMUt0L1gBnKVcaRbrSgQ6ERSnGsOBkA0LHuiA4zMrG
X-Gm-Gg: ASbGncviyZWXitm0wi7ewUaEy8n9Qn8PG6S6vlt/y4fA/wIRyh0GMeR+gsnAjcHUCue
	dqIGhn2qUYN+LEhBKLqvYKQirUM59GjwUpIOP4lHBf8eWNtew4zWmuc1XE91SbovEA7fBajet0y
	vD3AHd2Vg2miiKmOJWbrjXLnQeZfugWfTKxUb0bAMM/yW8jm6mKwEjeLSzjUC3lL4403Zr4jlHf
	NLloekHtbiQSCUT6bZ4Sk7izI836kfHBW5BKlR5lQWXusJKMyYNcClqTga8WhKW3fbMXBPrLvzx
X-Google-Smtp-Source: AGHT+IHFm7JjT/ELqF/oc+iaKa0kUQXfFNxB9rhJl9eClBEay2aMmFw3qewLSFURnDktUU3VeXF80w==
X-Received: by 2002:a17:90a:d890:b0:2ee:d35c:39ab with SMTP id 98e67ed59e1d1-2f548ecabd6mr18718825a91.22.1736615930679;
        Sat, 11 Jan 2025 09:18:50 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5593d094csm5528166a91.10.2025.01.11.09.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 09:18:50 -0800 (PST)
Date: Sat, 11 Jan 2025 09:18:48 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 4/4] net: ngbe: Add support for 1PPS and TOD
Message-ID: <Z4Kn-OtfLdScC38H@hoboy.vegasvil.org>
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

This code...

> +static void wx_ptp_setup_sdp(struct wx *wx)
> +{
...
> +	/* disable the pin first */
> +	wr32ptp(wx, WX_TSC_1588_AUX_CTL, 0);
> +	WX_WRITE_FLUSH(wx);
> +
> +	if (!test_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags)) {
> +		if (wx->pps_enabled) {
> +			wx->pps_enabled = false;
> +			wx_set_pps(wx, false, 0, 0);
> +		}
> +		return;
> +	}
> +
> +	wx->pps_enabled = true;
> +
> +	tssdp = WX_TSC_1588_SDP_FUN_SEL_TT0;
> +	tssdp |= WX_TSC_1588_SDP_OUT_LEVEL_H;
> +	tssdp1 = WX_TSC_1588_SDP_FUN_SEL_TS0;
> +	tsauxc = WX_TSC_1588_AUX_CTL_PLSG | WX_TSC_1588_AUX_CTL_EN_TT0 |
> +		WX_TSC_1588_AUX_CTL_EN_TT1 | WX_TSC_1588_AUX_CTL_EN_TS0;
> +
> +	/* Read the current clock time, and save the cycle counter value */
> +	spin_lock_irqsave(&wx->tmreg_lock, flags);
> +	ns = timecounter_read(&wx->hw_tc);
> +	wx->pps_edge_start = wx->hw_tc.cycle_last;
> +	spin_unlock_irqrestore(&wx->tmreg_lock, flags);
> +	wx->pps_edge_end = wx->pps_edge_start;
> +
> +	/* Figure out how far past the next second we are */
> +	div_u64_rem(ns, WX_NS_PER_SEC, &rem);
> +
> +	/* Figure out how many nanoseconds to add to round the clock edge up
> +	 * to the next full second
> +	 */
> +	rem = (WX_NS_PER_SEC - rem);
> +
> +	/* Adjust the clock edge to align with the next full second. */
> +	wx->pps_edge_start += div_u64(((u64)rem << cc->shift), cc->mult);
> +	trgttiml0 = (u32)wx->pps_edge_start;
> +	trgttimh0 = (u32)(wx->pps_edge_start >> 32);
> +
> +	wx_set_pps(wx, wx->pps_enabled, ns + rem, wx->pps_edge_start);
> +
> +	rem += wx->pps_width;
> +	wx->pps_edge_end += div_u64(((u64)rem << cc->shift), cc->mult);
> +	trgttiml1 = (u32)wx->pps_edge_end;
> +	trgttimh1 = (u32)(wx->pps_edge_end >> 32);
> +
> +	wr32ptp(wx, WX_TSC_1588_TRGT_L(0), trgttiml0);
> +	wr32ptp(wx, WX_TSC_1588_TRGT_H(0), trgttimh0);
> +	wr32ptp(wx, WX_TSC_1588_TRGT_L(1), trgttiml1);
> +	wr32ptp(wx, WX_TSC_1588_TRGT_H(1), trgttimh1);
> +	wr32ptp(wx, WX_TSC_1588_SDP(0), tssdp);
> +	wr32ptp(wx, WX_TSC_1588_SDP(1), tssdp1);
> +	wr32ptp(wx, WX_TSC_1588_AUX_CTL, tsauxc);
> +	wr32ptp(wx, WX_TSC_1588_INT_EN, WX_TSC_1588_INT_EN_TT1);
> +	WX_WRITE_FLUSH(wx);
> +
> +	rem = WX_NS_PER_SEC;
> +	/* Adjust the clock edge to align with the next full second. */
> +	wx->sec_to_cc = div_u64(((u64)rem << cc->shift), cc->mult);
> +}

Looks almost identical this code ...

> +void wx_ptp_check_pps_event(struct wx *wx)
> +{
...
> +	if (int_status & WX_TSC_1588_INT_ST_TT1) {
> +		/* disable the pin first */
> +		wr32ptp(wx, WX_TSC_1588_AUX_CTL, 0);
> +		WX_WRITE_FLUSH(wx);
> +
> +		tsauxc = WX_TSC_1588_AUX_CTL_PLSG | WX_TSC_1588_AUX_CTL_EN_TT0 |
> +			 WX_TSC_1588_AUX_CTL_EN_TT1 | WX_TSC_1588_AUX_CTL_EN_TS0;
> +
> +		/* Read the current clock time, and save the cycle counter value */
> +		spin_lock_irqsave(&wx->tmreg_lock, flags);
> +		ns = timecounter_read(&wx->hw_tc);
> +		wx->pps_edge_start = wx->hw_tc.cycle_last;
> +		spin_unlock_irqrestore(&wx->tmreg_lock, flags);
> +		wx->pps_edge_end = wx->pps_edge_start;
> +
> +		/* Figure out how far past the next second we are */
> +		div_u64_rem(ns, WX_NS_PER_SEC, &rem);
> +
> +		/* Figure out how many nanoseconds to add to round the clock edge up
> +		 * to the next full second
> +		 */
> +		rem = (WX_NS_PER_SEC - rem);
> +
> +		/* Adjust the clock edge to align with the next full second. */
> +		wx->pps_edge_start += div_u64(((u64)rem << cc->shift), cc->mult);
> +		trgttiml0 = (u32)wx->pps_edge_start;
> +		trgttimh0 = (u32)(wx->pps_edge_start >> 32);
> +
> +		rem += wx->pps_width;
> +		wx->pps_edge_end += div_u64(((u64)rem << cc->shift), cc->mult);
> +		trgttiml1 = (u32)wx->pps_edge_end;
> +		trgttimh1 = (u32)(wx->pps_edge_end >> 32);
> +
> +		wr32ptp(wx, WX_TSC_1588_TRGT_L(0), trgttiml0);
> +		wr32ptp(wx, WX_TSC_1588_TRGT_H(0), trgttimh0);
> +		wr32ptp(wx, WX_TSC_1588_TRGT_L(1), trgttiml1);
> +		wr32ptp(wx, WX_TSC_1588_TRGT_H(1), trgttimh1);
> +		wr32ptp(wx, WX_TSC_1588_AUX_CTL, tsauxc);
> +		WX_WRITE_FLUSH(wx);
> +	}
> +}

So can the trigger calculation logic be refactored into one place?

Thanks,
Richard

