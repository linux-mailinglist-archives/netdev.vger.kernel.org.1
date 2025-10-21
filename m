Return-Path: <netdev+bounces-231124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEA6BF57C3
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F49188829A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0945328B67;
	Tue, 21 Oct 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Waxd1GKO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACA246BD5
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038714; cv=none; b=W4kSm57S9rwxPKhAkIiMAq0TcrHp7a6OVnIleRGTU2upPAfyB+EVQ16pk6XRO0l/WPrBWRAt5I2DYDalBVM4Renw3LnPFfnIPEXIfwvj+14M+onUx6Ytii4+GKYClTp0uwmdYSZjcgJBwyHhWAoYdJ8oTHidZJpWmUpr8eewecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038714; c=relaxed/simple;
	bh=70fh7l0TLwEingT0Dlsm17GX58QH+efSGCknR2mPUfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOlBcxEj3OK1IkNbVMJdsPM9UUghBLcCW5cTQkngZ5df3C2eFXqPBSjPbh81biyW0d6Rsd47AOfES8astCVbt5230tsWDAw2mPSd9oH57r55u+pPsSWUckZM7p4LlcLxVESKc/y8zCoyVj3ioM73iAj2iFqkNJbOgsSl3Fr9KFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Waxd1GKO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761038711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RANMdE5VJt3ZJzx3yGMY3tj7r6cm2tCoc3fFUR1o9c=;
	b=Waxd1GKOmZORm9wGxuuEenpLRd2wDC8mu12YYx9O64VnlQmArRyZP/38VnH+9QcmD1ejBF
	wVVFwo9qQw+Gk8hULL+UHrAKCLqwUEFyhxfweH3nZtxRq7XGYlYiDDq4W2TTzyppgwI3+i
	FDXLq/h0uoF/SAtrHp8q4asvx5CPbM4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Uyz1ntC5MhmcCOSnszimYg-1; Tue, 21 Oct 2025 05:25:10 -0400
X-MC-Unique: Uyz1ntC5MhmcCOSnszimYg-1
X-Mimecast-MFC-AGG-ID: Uyz1ntC5MhmcCOSnszimYg_1761038709
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so6132189f8f.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 02:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038709; x=1761643509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RANMdE5VJt3ZJzx3yGMY3tj7r6cm2tCoc3fFUR1o9c=;
        b=FZGF18Jz9cZBEm3u5NoqF64iSjBd8jS9hx0NGi1XpuXqb89Gl+e5Nbbx8lgHbjefah
         pmIQpcigJja6yWBcpwt/fwnNVjN7UNTcRVTSiMfiAPyOm4qz3W3rbVesag2rmMT7/uim
         iOmyJPTTC+fnY4FXgdwlUeZSXbf4dRqstOEF4zabsCUkEKOnd8opQaTKNN8mR5CLqJyz
         r27poEBIydPterQeaXuKqk6rpyzCtCSDgmdN8mT31DN43xn9Mu0dLI1NIlyLIfRvf0Qq
         WOXvpau2669H9hzJtTY5920phA5jtUm3dtyDIVUNCZo9CafdKXlwX2bin31YW616pUIU
         Mxvg==
X-Forwarded-Encrypted: i=1; AJvYcCX5J9htCBTN8MQkg9oyj9QEXYAn7O/tiAY07EXgHM7O50iuXma8iNp/viAVAnP2qm3XDsgg6MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+2bxP+ohASPNhavBTZZiYpId0iNI2HPv/Bcl5XyipeDrZcbk
	NsdZYigmrco/eh8KgycJCrg9O/TaGtiG7xtJBXk4XnSueE3NxTnJDS+4wClgCsZnnwdXHeJnLN1
	h0RibNukI50nQoEi3fDndHmYQBH7/jDuCaecKZI88mUWXuPNjl9VwG85SaA==
X-Gm-Gg: ASbGnctcoIWw/gXtNSRQAStxhtH6CQQLLbzZaLNBrxqjTCuruW5c1vPK5y+m/tcNgfA
	FA0jzQGDOeAocd/fs34ndyyc4LekOZCuymafG+jaTgQbJa8PWGGqN97RUIqdIxEUbLGeVmd9CpP
	CVFVSVdNzdBMiX4BrGYBUNdcL4IfKOMFJruyfyJ9ouUHJbk6+w1/jmZq0mY6WGcst73Y6/0+umG
	tozts74jviu/dMbLcpLFCcV6AeXmjnK5HhyX2GE3+azkwhOlEcCg/UH8kK4Hc3X9/PAvE1/hOPM
	hpzXQ6nRHq9SEehr8Dg13mUEgkE67j3OcydT0bXAa9x0624iR085NQavK5864ikDGQ6/woR5bX6
	l5scUdxrJZgeeCb/gRk01YZFI+t/gP982b7zpIHW1nV2itcw=
X-Received: by 2002:a05:6000:22c6:b0:3ec:db18:1695 with SMTP id ffacd0b85a97d-42704dc9395mr11530731f8f.45.1761038709182;
        Tue, 21 Oct 2025 02:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW/8VpN7+oRVVI2gacXOhu1lhYOkSBU8WbVYkhEZvqfdiTjdCOVwmyWkwuv1K6C+wnD9GcTg==
X-Received: by 2002:a05:6000:22c6:b0:3ec:db18:1695 with SMTP id ffacd0b85a97d-42704dc9395mr11530698f8f.45.1761038708787;
        Tue, 21 Oct 2025 02:25:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f88sm18692002f8f.7.2025.10.21.02.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:25:08 -0700 (PDT)
Message-ID: <c2534ab3-a843-43db-9447-19954467e2ed@redhat.com>
Date: Tue, 21 Oct 2025 11:25:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v02 2/6] hinic3: Add PF management interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Markus.Elfring@web.de, pavan.chebbi@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>
References: <cover.1760685059.git.zhuyikai1@h-partners.com>
 <8ad645360ce86569ec9c2c6532441352c06bc44a.1760685059.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8ad645360ce86569ec9c2c6532441352c06bc44a.1760685059.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 10:30 AM, Fan Gong wrote:
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
> index 78cface6ddd7..58c0c0b55097 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
> @@ -39,24 +39,25 @@ struct hinic3_pcidev {
>  };
>  
>  struct hinic3_hwdev {
> -	struct hinic3_pcidev        *adapter;
> -	struct pci_dev              *pdev;
> -	struct device               *dev;
> -	int                         dev_id;
> -	struct hinic3_hwif          *hwif;
> -	struct hinic3_cfg_mgmt_info *cfg_mgmt;
> -	struct hinic3_aeqs          *aeqs;
> -	struct hinic3_ceqs          *ceqs;
> -	struct hinic3_mbox          *mbox;
> -	struct hinic3_cmdqs         *cmdqs;
> -	struct delayed_work         sync_time_task;
> -	struct workqueue_struct     *workq;
> -	/* protect channel init and uninit */
> -	spinlock_t                  channel_lock;
> -	u64                         features[COMM_MAX_FEATURE_QWORD];
> -	u32                         wq_page_size;
> -	u8                          max_cmdq;
> -	ulong                       func_state;
> +	struct hinic3_pcidev         *adapter;
> +	struct pci_dev               *pdev;
> +	struct device                *dev;
> +	int                          dev_id;
> +	struct hinic3_hwif           *hwif;
> +	struct hinic3_cfg_mgmt_info  *cfg_mgmt;
> +	struct hinic3_aeqs           *aeqs;
> +	struct hinic3_ceqs           *ceqs;
> +	struct hinic3_mbox           *mbox;
> +	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
> +	struct hinic3_cmdqs          *cmdqs;
> +	struct delayed_work          sync_time_task;
> +	struct workqueue_struct      *workq;
> +	/* protect hwdev channel init and uninit */
> +	spinlock_t                   channel_lock;
> +	u64                          features[COMM_MAX_FEATURE_QWORD];
> +	u32                          wq_page_size;
> +	u8                           max_cmdq;
> +	ulong                        func_state;

The above is a nice way to hide a single line addition. Please either
avoid the reformatting entirely (preferred) or do the re-indentation in
a separate pre-req patch.

/P


