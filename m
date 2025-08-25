Return-Path: <netdev+bounces-216359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB94FB334DE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 05:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A8A7AB7BB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 03:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E7C23ABB9;
	Mon, 25 Aug 2025 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3M5AnoM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF245009
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 03:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756094251; cv=none; b=ardga2esS/krIA7PqZhng/N0F76R+iXDkynGx4Mq3QBjv6P1X/1OZKtjsDi1LqYzdxkyOLYPPfIu41YXtC27FT+zEEc7+ucT2A9mVNV+uqDhRrZ/I92VFfINlO3Eeg7G6e0JRC0utzN/oEFA/iIfgfs/uv4ukZIqxpiImHeqi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756094251; c=relaxed/simple;
	bh=6RsV5IrIyDS2gLriR8TPkVgC5+V6HePLKCfB94rWHiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kw2L94tYYGkPFEjiRvyXATj/Ooc8e2mMXd/SDre+bS2IGd7pu99dPsnldqrc0BNmOx+1W2MapRw5Nw9pOB2m5xllsB3K8l2NRxldJNd05WqPy4t4sZDaNKNj+wXHK7OJZeOWS+qP6oA2dVJxCI2cDLv78m5sw1C3OEri9NS0Fdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3M5AnoM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b6278893eso118185e9.0
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 20:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756094248; x=1756699048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdvrA+fmAx9tDB4YXzKcx06J6nPqB19xgW8zBcX4SNw=;
        b=X3M5AnoMjC83JLLm3TPO7vnamtAI6v9hL5md4BDxPmJ6ObKDKRMjxaaOhZ4+6ynHTa
         EBAxxL/ttoh19Yy4x+UXMWijV8ERysHyapheDHdGXmdQqLVurpYlNi9r3N5AK36nJk6U
         d3gwz2ewEbpfIEXT8HdAmptdv4mlBYf06IkxrC16xwxWnrLWqYIDjd+A5M+qFKF7FH6k
         uUnKcMLHo6frALMQZ9w/OxRyDTr9c0n29qaxmnhpbsMAO8E4eqNdz5xWhSUi2AMOJP/+
         7cJqcBbBcyo9of09/Z+nIa7bMGeyOsBf+iHBfMWD0Y+KswdpK1BSv+r3eRB1ST6Uenqu
         0pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756094248; x=1756699048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdvrA+fmAx9tDB4YXzKcx06J6nPqB19xgW8zBcX4SNw=;
        b=O251HP5DLlrCTzr1PunloRs0VvhiggdV3hJ6wv83ATb8fVuslxX7DW5wtcmbHxIot9
         oEVIg4/pNox7QC2luukPyZJbv5kQGI9nz+Svs+YnLF4cY3LFOapudXmmmJXkewHsC8D1
         mNXO0HZ94Q6hWtUtnRMYVJiR6P29kUhdDIOyqj0ZeG0HThWfHpi5u0LTerP434zvqgI1
         /XtO3ArujtU6+W2mZvtyg6p9vJnCzplTkSaqs7auuelNlzduzDgz7/glcyEDcjm+7ziX
         bZYL3MEYPipzKuFiPTDp8XfAzSUvxKqSs05wX2EMKUJ/+MxwhM7hucso/jS/nxvC0Ujb
         bSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlTuNgG3CMmc6glDVnj2ZF7oFSC1zC6KQFZ+Jn4Bem4Ti68Ct8xljh7e44+1ErL88ck+gkzEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGa+RF/9f5uiT3auiAkxhnxkiqoAVIvLzWUFZmo4vSmeyrMxEj
	VOCAuUwHsWSLmizwJOdh6UKxP76ygO7nQciM0OI7/7MoDUGajhG33yRG
X-Gm-Gg: ASbGncvIxMGBfCYlGAYwsXj8GqxXRzAE9RmQmf1aFl++9o9oysPICk7hjCDdkn7pOIW
	w6c/b92iBQ4CW9PJ5tIHbf/vOkvgeydfIC3C5RH7zR7jSXnY5fy7+sFjGicXWGZRuJObZfZKROJ
	FcYosK/QPl4YGpVKNH943I5Z1jR9DdzXfVmf5HHl+aob1a7wh91XsU/akSHyIuRbVm+gvrq9G+B
	qjqsmpBxnWvLy6RhKYu10Ud1fcgKpx8wqlz1if0NwL4Mtl01QwvMTkpcNUWIPiI7hPLGrPy7Ln1
	4Hif37DD4giI+DBmhEvj1W+pg8ggtcKkyF6U7WNWWYjuuZ1/KyHlepjuRshyj8IPX4Li1iNdsrZ
	3fsqjh32Wz+b+JWYU2vhfmphNTIm2Qon9Z6Yn+Hk3CqWa1MyYtEAAvvgndIN4edu3
X-Google-Smtp-Source: AGHT+IGUKGcI+jjSNDWl/BEWwMZ5pr0bNIEVgLt6ITa6vDSVsXobaDsEKpyitBtNav4Ch9ldWdjyzw==
X-Received: by 2002:a05:600c:4f8b:b0:459:e398:ed80 with SMTP id 5b1f17b1804b1-45b517e9de7mr80617245e9.32.1756094247792;
        Sun, 24 Aug 2025 20:57:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b60ab957bsm20212715e9.12.2025.08.24.20.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:57:27 -0700 (PDT)
Date: Mon, 25 Aug 2025 04:57:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Antoine Gagniere <antoine@gagniere.dev>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org
Subject: Re: [PATCH] ptp: ocp: Fix PCI delay estimation
Message-ID: <20250825045711.7f4ed42f@pumpkin>
In-Reply-To: <20250817222933.21102-1-antoine@gagniere.dev>
References: <20250817222933.21102-1-antoine.ref@gagniere.dev>
	<20250817222933.21102-1-antoine@gagniere.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 00:29:33 +0200
Antoine Gagniere <antoine@gagniere.dev> wrote:

> Since linux 6.12, a sign error causes the initial value of ts_window_adjust, (used in gettimex64) to be impossibly high, causing consumers like chrony to reject readings from PTP_SYS_OFFSET_EXTENDED.
> 
> This patch fixes ts_window_adjust's inital value and the sign-ness of various format flags
> 
> Context
> -------
> 
> The value stored in the read-write attribute ts_window_adjust is a number of nanoseconds subtracted to the post_ts timestamp of the reading in gettimex64, used notably in the ioctl PTP_SYS_OFFSET_EXTENDED, to compensate for PCI delay.
> Its initial value is set by estimating PCI delay.
> 
> Bug
> ---
> 
> The PCI delay estimation starts with the value U64_MAX and makes 3 measurements, taking the minimum value.
> However because the delay was stored in a s64, U64_MAX was interpreted as -1, which compared as smaller than any positive values measured.
> Then, that delay is divided by ~10 and placed in ts_window_adjust, which is a u32.
> So ts_window_adjust ends up with (u32)(((s64)U64_MAX >> 5) * 3) inside, which is 4294967293
> 
> Symptom
> -------
> 
> The consequence was that the post_ts of gettimex64, returned by PTP_SYS_OFFSET_EXTENDED, was substracted 4.29 seconds.
> As a consequence chrony rejected all readings from the PHC
> 
> Difficulty to diagnose
> ----------------------
> 
> Using cat to read the attribute value showed -3 because the format flags %d was used instead of %u, resulting in a re-interpret cast.
> 
> Fixes
> -----
> 
> 1. Using U32_MAX as initial value for PCI delays: no one is expecting an ioread to take more than 4 s
>    This will correctly compare as bigger that actual PCI delay measurements.
> 2. Fixing the sign of various format flags
> 
> Signed-off-by: Antoine Gagniere <antoine@gagniere.dev>
> ---
>  drivers/ptp/ptp_ocp.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index b651087f426f..153827722a63 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -1558,7 +1558,8 @@ ptp_ocp_watchdog(struct timer_list *t)
>  static void
>  ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
>  {
> -	ktime_t start, end, delay = U64_MAX;
> +	ktime_t start, end;
> +	s64 delay_ns = U32_MAX; /* 4.29 seconds is high enough */

Isn't this the only change that matters?
Changing from ktime_get_raw_ns() to ktime_get_raw() is pointless.
Both are 64 bit and are not going to wrap.
(This is ignoring the fact that I think they are always identical.)

>  	u32 ctrl;
>  	int i;
>  
> @@ -1568,15 +1569,16 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
>  
>  		iowrite32(ctrl, &bp->reg->ctrl);
>  
> -		start = ktime_get_raw_ns();
> +		start = ktime_get_raw();
>  
>  		ctrl = ioread32(&bp->reg->ctrl);
>  
> -		end = ktime_get_raw_ns();
> +		end = ktime_get_raw();
>  
> -		delay = min(delay, end - start);
> +		delay_ns = min(delay_ns, ktime_to_ns(end - start));
>  	}
> -	bp->ts_window_adjust = (delay >> 5) * 3;
> +	delay_ns = max(0, delay_ns);
> +	bp->ts_window_adjust = (delay_ns >> 5) * 3;
>  }
>  
>  static int
> @@ -1894,7 +1896,7 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>  	int err;
>  
>  	fw_image = bp->fw_loader ? "loader" : "fw";
> -	sprintf(buf, "%d.%d", bp->fw_tag, bp->fw_version);
> +	sprintf(buf, "%hhu.%hu", bp->fw_tag, bp->fw_version);

WTF is %hhu about?
The varargs parameters are subject to integer promotion, %d or %u is fine.

>  	err = devlink_info_version_running_put(req, fw_image, buf);
>  	if (err)
>  		return err;
> @@ -3196,7 +3198,7 @@ signal_show(struct device *dev, struct device_attribute *attr, char *buf)
>  	i = (uintptr_t)ea->var;
>  	signal = &bp->signal[i];
>  
> -	count = sysfs_emit(buf, "%llu %d %llu %d", signal->period,
> +	count = sysfs_emit(buf, "%lli %d %lli %d", signal->period,

Use %lld not %lli (and below).

	David


>  			   signal->duty, signal->phase, signal->polarity);
>  
>  	ts = ktime_to_timespec64(signal->start);
> @@ -3230,7 +3232,7 @@ period_show(struct device *dev, struct device_attribute *attr, char *buf)
>  	struct ptp_ocp *bp = dev_get_drvdata(dev);
>  	int i = (uintptr_t)ea->var;
>  
> -	return sysfs_emit(buf, "%llu\n", bp->signal[i].period);
> +	return sysfs_emit(buf, "%lli\n", bp->signal[i].period);
>  }
>  static EXT_ATTR_RO(signal, period, 0);
>  static EXT_ATTR_RO(signal, period, 1);
> @@ -3244,7 +3246,7 @@ phase_show(struct device *dev, struct device_attribute *attr, char *buf)
>  	struct ptp_ocp *bp = dev_get_drvdata(dev);
>  	int i = (uintptr_t)ea->var;
>  
> -	return sysfs_emit(buf, "%llu\n", bp->signal[i].phase);
> +	return sysfs_emit(buf, "%lli\n", bp->signal[i].phase);
>  }
>  static EXT_ATTR_RO(signal, phase, 0);
>  static EXT_ATTR_RO(signal, phase, 1);
> @@ -3289,7 +3291,7 @@ start_show(struct device *dev, struct device_attribute *attr, char *buf)
>  	struct timespec64 ts;
>  
>  	ts = ktime_to_timespec64(bp->signal[i].start);
> -	return sysfs_emit(buf, "%llu.%lu\n", ts.tv_sec, ts.tv_nsec);
> +	return sysfs_emit(buf, "%lli.%li\n", ts.tv_sec, ts.tv_nsec);
>  }
>  static EXT_ATTR_RO(signal, start, 0);
>  static EXT_ATTR_RO(signal, start, 1);
> @@ -3444,7 +3446,7 @@ utc_tai_offset_show(struct device *dev,
>  {
>  	struct ptp_ocp *bp = dev_get_drvdata(dev);
>  
> -	return sysfs_emit(buf, "%d\n", bp->utc_tai_offset);
> +	return sysfs_emit(buf, "%u\n", bp->utc_tai_offset);
>  }
>  
>  static ssize_t
> @@ -3472,7 +3474,7 @@ ts_window_adjust_show(struct device *dev,
>  {
>  	struct ptp_ocp *bp = dev_get_drvdata(dev);
>  
> -	return sysfs_emit(buf, "%d\n", bp->ts_window_adjust);
> +	return sysfs_emit(buf, "%u\n", bp->ts_window_adjust);
>  }
>  
>  static ssize_t
> @@ -3964,7 +3966,7 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
>  
>  	on = signal->running;
>  	sprintf(label, "GEN%d", nr + 1);
> -	seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%d",
> +	seq_printf(s, "%7s: %s, period:%lli duty:%d%% phase:%lli pol:%d",
>  		   label, on ? " ON" : "OFF",
>  		   signal->period, signal->duty, signal->phase,
>  		   signal->polarity);
> @@ -3974,7 +3976,7 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
>  	val = ioread32(&reg->status);
>  	seq_printf(s, " %x]", val);
>  
> -	seq_printf(s, " start:%llu\n", signal->start);
> +	seq_printf(s, " start:%lli\n", signal->start);
>  }
>  
>  static void
> @@ -4231,7 +4233,7 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
>  
>  		seq_printf(s, "%7s: %lld.%ld == %ptT TAI\n", "PHC",
>  			   ts.tv_sec, ts.tv_nsec, &ts);
> -		seq_printf(s, "%7s: %lld.%ld == %ptT UTC offset %d\n", "SYS",
> +		seq_printf(s, "%7s: %lld.%ld == %ptT UTC offset %u\n", "SYS",
>  			   sys_ts.tv_sec, sys_ts.tv_nsec, &sys_ts,
>  			   bp->utc_tai_offset);
>  		seq_printf(s, "%7s: PHC:SYS offset: %lld  window: %lld\n", "",


