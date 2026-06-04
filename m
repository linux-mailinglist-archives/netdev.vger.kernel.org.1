Return-Path: <netdev+bounces-295046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zQNAJxAJIWox+gAAu9opvQ
	(envelope-from <netdev+bounces-295046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 07:11:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6CB63CEB8
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 07:11:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Wfj5/olb";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295046-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295046-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E443301FE7A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 05:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4243BED70;
	Thu,  4 Jun 2026 05:09:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128C93BD62C
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 05:09:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549758; cv=none; b=l7ngO4odjJqQL1H5XD+U/b2UTeTxKm1AHHLOCKOdBGwqnktNFqotdiFB3H3BIUFC6X5bvsGyGa6RfGvcmvF63pqSaxqZn/oCXoihWf/icXXxHHt57tuHz8P9kQeo3EfnIppuJuzJt6B8Bq9KDM9bK5egzrUHeXAo04c/d6sUWRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549758; c=relaxed/simple;
	bh=Av1frBjcGBjlzFynU2Hy7rkXSpmEfO68DCNBSYURblM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzDx8MU3fBWP3yly/ql/k0srFHGxKL58QR+/i9HihOUJNzss/1WGaQNgKWQzXIaQl/tyYH/l8tX5sy6veG+ysdqiRvzCD+680Cn6ueNOYhKGwcHb6kTQkeJweIvFin/KEqKLcONi31+KQFTmKLHoOc/Ia7gSsKT1BoCTlKhJoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wfj5/olb; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36f4773d7abso49615a91.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 22:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780549755; x=1781154555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+vy0QPkbgBGQCp+nbHU8oM3LzLFEBCDA4xt5ygdBfo=;
        b=Wfj5/olb/9nGiV8QqwNuMpzRQsqb18H9713Cs0ytRcaX6COoKQox8ltM0esz5CKpq4
         NF25W7Ro5GRSmIa9C6KVDg8W0FZZ+tOKHvf0Zkz5xsglkahxjTJAWqy4zh29M5b3Wtif
         7StVzLcsrk9eg9/p/oduv0LrOtwVsR5vtiHQpDEoTahE06rjAbTocQQaK1a23kkvo35D
         Mw3viVXOmuZ7zuIqGKeBMKHAzgKuWoDcfkWyRAFxqmEM9lH33TJbgcBl1iBBa4fgP8vR
         z57bYXJMxNceX8iMrvqV97EWdlhwRumfKDSa1KoXOEnbE/9rN62yV5I489uZd28iYkRR
         jbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780549755; x=1781154555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+vy0QPkbgBGQCp+nbHU8oM3LzLFEBCDA4xt5ygdBfo=;
        b=GH/a3GgB3rAqe1DebMImkI3HFd1XQcQD13C0Vkl3oJBYOcpMJIHIuWPIQkO1DRfstU
         u4LJQdR0vCmNj7WxTntpl4+3STJs6vzll0dGWGGrJy9Cp9yBqCZVJ5qe/1fqqCvr95yD
         ooeeaWfiaZ/NF6WRvH5/7tDuJk43ea5Cbdoa5JNug+OACFhI8jgMT8NKXNpgbTSvTnMB
         eioe8QbhIXA6GuXUqGFZdZSQSTes62+j6FQrRGXjPqNDvMjRNh0KDylNYnFiSxRYfdNv
         dnwSzPKk8mf9EuNpBH779/SjneaiDUQPjhV4Z741j00CJqHtr8O/wsSsmEPgT+tFgJm1
         RE+A==
X-Forwarded-Encrypted: i=1; AFNElJ/9hlGa+2FVbDDVSUKNNmJtVVtt3RohlYcwbjnmQiNyZ0Rs37cexUnmJ4/Ang+5SG1NXjb0kks=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2NvRiFzGcur1ulzH71CMyoQq4T9XR3NQF1Y30yFUxqAZc716
	lFyTSOIkW0RGAMWP0PVJkdYr6qE4iBMQbcYRpjZfDXVXsavEfWK3qb7f
X-Gm-Gg: Acq92OGxcIpUBl6aUVKDmGQy7ETeXfkKwu1g+UYDfXcG8DyCceZW9O1sWNoET2WBo2w
	yv0RzATQBAAbgP+EXBZ3GvTMPg1LXCKXPn2v5xpwMnEOuKAYSh/LwlRDu7qKufui4Jd72UNYh5/
	j8/xSAKpMSe/1hINWNoGG32ytMOQ0vVRFVQ1l125OuXIYVVB/f2Ul7XpJsoxH24OX09yVwGFgnX
	jcUQZm8iz3HV0NdXaK2e4j6CRq2Kxsg25r8ZxHSkOcyupCOAwxzSykQUWL84Za/ZHjT4c3AkcHc
	RhVk0r5evQ6u4v4PZG1w3WbKyRUAj8NzMQ49w3n6wyticQwEZ0YHnTYLyYCbufD5LKppeZne9SW
	vu1bRAN6Epi8dtRY+xtznVIPj6Let8bq2s4REplGUqHaXxv3D/azccjMmvFJs6aVyWBMgQ8v1lM
	UCV9FxEYISPzojCyo8859hMw53RCznm51s1pnLvO5vg6Rv
X-Received: by 2002:a17:90b:4b85:b0:366:2b56:3ec2 with SMTP id 98e67ed59e1d1-36fbd7cbd0emr692507a91.1.1780549755227;
        Wed, 03 Jun 2026 22:09:15 -0700 (PDT)
Received: from [192.168.1.7] ([159.192.166.161])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-36f68bf99dcsm1595578a91.0.2026.06.03.22.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 22:09:14 -0700 (PDT)
Message-ID: <f5fe7d26-4467-4015-be65-f01d7acda213@gmail.com>
Date: Thu, 4 Jun 2026 12:09:09 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] bus: mhi: pci_generic: add Rolling Wireless RW135R-GL
 and RW151 support
To: zwq2226404116@163.com, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org
Cc: mani@kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 Wanquan Zhong <wanquan.zhong@fibocom.com>
References: <20260603070608.309114-1-zwq2226404116@163.com>
Content-Language: en-US
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <20260603070608.309114-1-zwq2226404116@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295046-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zwq2226404116@163.com,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:mani@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:kuba@kernel.org,m:wanquan.zhong@fibocom.com,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER(0.00)[larsm17@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,gmail.com,lunn.ch,davemloft.net,fibocom.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larsm17@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA6CB63CEB8

On 2026-06-03 14:06, zwq2226404116@163.com wrote:
> From: Wanquan Zhong <wanquan.zhong@fibocom.com>
> 
> bus: mhi: pci_generic: add Rolling Wireless RW135R-GL and RW151 support
> 
> Add MHI PCIe device configuration for Rolling Wireless modules:
> 
> - RW135R-GL (Qualcomm sdx35): MBIM, DIAG, DUN, NMEA, FIREHOSE, ADB, IP_HW0
> - RW151 (Qualcomm sdx75): same channel layout with adjusted ring sizes
> 
> Register PCI_DEVICE_SUB entries for vendor 0x2099, device 0x1300/1301 on
> QCOM 0x011a (sdx35) and 0x0309 (sdx75) respectively.
> 
> Enable the ADB MHI channel in mhi_wwan_ctrl so userspace can access the
> WWAN_PORT_ADB port via the wwan subsystem.
> 
> Tested-on: Rolling RW135R-GL / RW151 hardware (MHI probe, MBIM, DIAG, ADB)
> 
> Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>
> ---
>   drivers/bus/mhi/host/pci_generic.c | 100 +++++++++++++++++++++++++++++
>   drivers/net/wwan/mhi_wwan_ctrl.c   |   1 +
>   2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 0884a384b77f..ad166de2d0f3 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -902,6 +902,94 @@ static const struct mhi_pci_dev_info mhi_netprisma_fcun69_info = {
>   	.sideband_wake = true,
>   };
>   
> +static const struct mhi_channel_config mhi_rolling_rw135r_channels[] = {
> +	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 64, 1),
> +	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 64, 1),
> +	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
> +	MHI_CHANNEL_CONFIG_UL(14, "NMEA", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(15, "NMEA", 32, 0),
> +	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> +	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
> +	MHI_CHANNEL_CONFIG_UL(36, "ADB", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(37, "ADB", 32, 0),
> +	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 2),
> +	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 3),
> +};
> +
> +static struct mhi_event_config mhi_rolling_rw135r_events[] = {
> +	MHI_EVENT_CONFIG_CTRL(0, 128),
> +	MHI_EVENT_CONFIG_DATA(1, 128),
> +	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
> +	MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101),
> +};
> +
> +static const struct mhi_controller_config modem_rolling_rw135r_config = {
> +	.max_channels = 128,
> +	.timeout_ms = 8000,
> +	.num_channels = ARRAY_SIZE(mhi_rolling_rw135r_channels),
> +	.ch_cfg = mhi_rolling_rw135r_channels,
> +	.num_events = ARRAY_SIZE(mhi_rolling_rw135r_events),
> +	.event_cfg = mhi_rolling_rw135r_events,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_rolling_rw135r_info = {
> +	.edl = "qcom/sdx35m/prog_firehose_ddr.elf",
> +	.name = "rolling-rw135r",
> +	.config = &modem_rolling_rw135r_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.sideband_wake = false,
> +	.mru_default = 32768,
> +	.edl_trigger = true,
> +};
> +
> +static const struct mhi_channel_config mhi_rolling_rw151_channels[] = {
> +	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
> +	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
> +	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 4, 0),
> +	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 4, 0),
> +	MHI_CHANNEL_CONFIG_UL(14, "NMEA", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(15, "NMEA", 32, 0),
> +	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> +	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
> +	MHI_CHANNEL_CONFIG_UL(36, "ADB", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(37, "ADB", 32, 0),
> +	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 2),
> +	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 3),
> +};
> +
> +static struct mhi_event_config mhi_rolling_rw151_events[] = {
> +	MHI_EVENT_CONFIG_CTRL(0, 128),
> +	MHI_EVENT_CONFIG_DATA(1, 128),
> +	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
> +	MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101),
> +};
> +
> +static const struct mhi_controller_config modem_rolling_rw151_config = {
> +	.max_channels = 128,
> +	.timeout_ms = 50000,
> +	.num_channels = ARRAY_SIZE(mhi_rolling_rw151_channels),
> +	.ch_cfg = mhi_rolling_rw151_channels,
> +	.num_events = ARRAY_SIZE(mhi_rolling_rw151_events),
> +	.event_cfg = mhi_rolling_rw151_events,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_rolling_rw151_info = {
> +	.edl = "qcom/sdx75m/prog_firehose_lite.elf",
> +	.name = "rolling-rw151",
> +	.config = &modem_rolling_rw151_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.sideband_wake = false,
> +	.mru_default = 32768,
> +	.edl_trigger = true,
> +};
> +
>   /* Keep the list sorted based on the PID. New VID should be added as the last entry */
>   static const struct pci_device_id mhi_pci_id_table[] = {
>   	{PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0116),
> @@ -909,6 +997,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>   	/* Telit FN920C04 (sdx35) */
>   	{PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x011a, 0x1c5d, 0x2020),
>   		.driver_data = (kernel_ulong_t) &mhi_telit_fn920c04_info },
> +	/* Rolling RW135R-GL (sdx35) */
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x011a, 0x2099, 0x1300),
> +		.driver_data = (kernel_ulong_t) &mhi_rolling_rw135r_info },
> +	/* Rolling RW135R-GL (sdx35) */
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x011a, 0x2099, 0x1301),
> +		.driver_data = (kernel_ulong_t) &mhi_rolling_rw135r_info },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
>   		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
>   	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, PCI_VENDOR_ID_QCOM, 0x010c),
> @@ -941,6 +1035,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>   	/* Telit FE990B40 (sdx72) */
>   	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x1c5d, 0x2025),
>   		.driver_data = (kernel_ulong_t) &mhi_telit_fe990b40_info },
> +	/* Rolling RW151 (sdx75) */
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x2099, 0x1300),
> +		.driver_data = (kernel_ulong_t) &mhi_rolling_rw151_info },
> +	/* Rolling RW151 (sdx75) */
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x2099, 0x1301),
> +		.driver_data = (kernel_ulong_t) &mhi_rolling_rw151_info },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
>   		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
>   	/* QDU100, x100-DU */
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index fa73861db6ad..c0bba94d5c3f 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -264,6 +264,7 @@ static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
>   	{ .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
>   	{ .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
>   	{ .chan = "NMEA", .driver_data = WWAN_PORT_NMEA },
> +	{ .chan = "ADB", .driver_data = WWAN_PORT_ADB },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(mhi, mhi_wwan_ctrl_match_table);
> 
> --
> 2.43.0
> 
> 
Hi,
does both the sdx35 and the sdx75 device really have the same Rolling 
PCI Vid:Pid (2099:1300 and 2099:1301)?

thanks
Lars



