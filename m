Return-Path: <netdev+bounces-201785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9C3AEB0B4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2991C2251F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4002264B2;
	Fri, 27 Jun 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="48NR5Vqn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38332264A8;
	Fri, 27 Jun 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011043; cv=none; b=p/iSacZiQeH13/SaEWTf6X99FISz4L3wRQHrc6kb5eEfjvSVG80DsNH/J22nZ6IvmGDV0lLW+wk38VgpPxAAehrznQlhEGKnZ6MtEZst7hBIFYtXGi2ifGlnsPk3ly3psTIzKqATg4Fxw57WQwTvjwirLllmMDZ7qgYh4M3b+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011043; c=relaxed/simple;
	bh=zal9xn7yxFRR41i1coZhjVOWt6/9KGWg0tYzL5ntrWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIXNFVTfXlhp4imFh2jYt7Lafq1rQ4GkDDhaTXFpDMA95wUcDv53i0XMavmWxmvri+ASxI8Wq6sorq1NBLXPELEh/IFRc08tGk3VGVSwutM4gJtWSYVvDqjsgitMTGD8TV7IaQ9e12Y+Cj6+aoiGIv03DTKmz+cvL5GTOh0JglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=48NR5Vqn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XWoXZ540RK4D7pND3FhRUN0tuRirGRAX3dKRq7hFvhE=; b=48NR5VqnRS0Ppkmzn2y+ANOZbN
	SmXSRHG8weg3pfCCBpdavbsV8doOjDFFWsekMm4vd/S03EMVFZ2k9D+ePD/Fxv+0y34Iu2KXPzfE8
	yZZJM7v1Z3OqHNCRnNEha+uEVxwK+iN6EeQgkzwxSLlbZ2Hw+aDJz9KUsZVl2cazXmis=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uV3xQ-00H7Th-Q8; Fri, 27 Jun 2025 09:57:12 +0200
Date: Fri, 27 Jun 2025 09:57:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ptp: add Alibaba CIPU PTP clock driver
Message-ID: <0b0d3dad-3fe2-4b3a-a018-35a3603f8c10@lunn.ch>
References: <20250627072921.52754-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627072921.52754-1-guwen@linux.alibaba.com>

> +#define PTP_CIPU_LOG_SUB(dev, level, type, event, fmt, ...) \
> +({ \
> +	static DEFINE_RATELIMIT_STATE(_rs, \
> +				      DEFAULT_RATELIMIT_INTERVAL, \
> +				      DEFAULT_RATELIMIT_BURST); \
> +	if (__ratelimit(&_rs)) \
> +		dev_printk(level, dev, "[%02x:%02x]: " fmt, \
> +			   type, event, ##__VA_ARGS__); \
> +})

Please don't use such wrappers. Just use dev_dbg_ratelimited() etc.

> +static int cipu_iowrite8_and_check(void __iomem *addr,
> +				   u8 value, u8 *res)
> +{
> +	iowrite8(value, addr);
> +	if (value != ioread8(addr))
> +		return -EIO;
> +	*res = value;
> +	return 0;
> +}

This probably needs a comment. I assume the hardware is broken and
sometimes writes don't work? You should state that.

> +static void ptp_cipu_print_dev_events(struct ptp_cipu_ctx *ptp_ctx,
> +				      int event)
> +{
> +	struct device *dev = &ptp_ctx->pdev->dev;
> +	int type = PTP_CIPU_EVT_TYPE_DEV;
> +
> +	switch (event) {
> +	case PTP_CIPU_EVT_H_CLK_ABN:
> +		PTP_CIPU_LOG_SUB(dev, KERN_ERR, type, event,
> +				 "Atomic Clock Error Detected\n");
> +		break;
> +	case PTP_CIPU_EVT_H_CLK_ABN_REC:
> +		PTP_CIPU_LOG_SUB(dev, KERN_INFO, type, event,
> +				 "Atomic Clock Error Recovered\n");
> +		break;
> +	case PTP_CIPU_EVT_H_DEV_MT:
> +		PTP_CIPU_LOG_SUB(dev, KERN_ERR, type, event,
> +				 "Maintenance Exception Detected\n");
> +		break;
> +	case PTP_CIPU_EVT_H_DEV_MT_REC:
> +		PTP_CIPU_LOG_SUB(dev, KERN_INFO, type, event,
> +				 "Maintenance Exception Recovered\n");
> +		break;
> +	case PTP_CIPU_EVT_H_DEV_MT_TOUT:
> +		PTP_CIPU_LOG_SUB(dev, KERN_INFO, type, event,
> +				 "Maintenance Exception Failed to Recover "
> +				 "within %d us\n", ptp_ctx->regs.mt_tout_us);
> +		break;
> +	case PTP_CIPU_EVT_H_DEV_BUSY:
> +		PTP_CIPU_LOG_SUB(dev, KERN_ERR, type, event,
> +				 "PHC Busy Detected\n");
> +		break;
> +	case PTP_CIPU_EVT_H_DEV_BUSY_REC:
> +		PTP_CIPU_LOG_SUB(dev, KERN_INFO, type, event,
> +				 "PHC Busy Recovered\n");
> +		break;
> +	case PTP_CIPU_EVT_H_DEV_ERR:
> +		PTP_CIPU_LOG_SUB(dev, KERN_ERR, type, event,
> +				 "PHC Error Detected\n");
> +		break;
> +	case PTP_CIPU_EVT_H_DEV_ERR_REC:
> +		PTP_CIPU_LOG_SUB(dev, KERN_INFO, type, event,
> +				 "PHC Error Recovered\n");

Are these fatal? Or can the device still be used after these errors
occur?

> +static int ptp_cipu_enable(struct ptp_clock_info *info,
> +			   struct ptp_clock_request *request, int on)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ptp_cipu_settime(struct ptp_clock_info *p,
> +			    const struct timespec64 *ts)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ptp_cipu_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ptp_cipu_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	return -EOPNOTSUPP;
> +}

I've not looked at the core. Are these actually required? Or if they
are missing, does the core default to -EOPNOTSUPP?

> +static ssize_t register_snapshot_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct ptp_cipu_ctx *ctx = pci_get_drvdata(to_pci_dev(dev));
> +	struct ptp_cipu_regs *regs = &ctx->regs;
> +
> +	return sysfs_emit(buf, "%s 0x%x %s 0x%x %s 0x%x %s 0x%x "
> +			  "%s 0x%x %s 0x%x %s 0x%x %s 0x%x %s 0x%x "
> +			  "%s 0x%x %s 0x%x %s 0x%x\n",
> +			  "device_features", regs->dev_feat,
> +			  "guest_features", regs->gst_feat,
> +			  "driver_version", regs->drv_ver,
> +			  "environment_version", regs->env_ver,
> +			  "device_status", regs->dev_stat,
> +			  "sync_status", regs->sync_stat,
> +			  "time_precision(ns)", regs->tm_prec_ns,
> +			  "epoch_base(years)", regs->epo_base_yr,
> +			  "leap_second(s)", regs->leap_sec,
> +			  "max_latency(ns)", regs->max_lat_ns,
> +			  "maintenance_timeout(us)", regs->mt_tout_us,
> +			  "offset_threshold(us)", regs->thresh_us);
> +}

Is this debug? Maybe it should be placed in debugfs, rather than
sysfs.

	Andrew

