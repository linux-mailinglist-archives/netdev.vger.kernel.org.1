Return-Path: <netdev+bounces-131616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC2D98F0A4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4961C2176A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BB019F107;
	Thu,  3 Oct 2024 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYEkpzsK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2919F112
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962764; cv=none; b=iEi2feOTzlvcm3H44QKG2Vto+qhJpiCrliWcFsfTmqqNxjvpFRL0y+k4UfTAMQmzgLdk7KqNwg61m9DZvhuy2E5z4EKnUTacV7ha+7vsqaY/j3eLjRmfSP3pLLou/REM1dkIZL2IhS4KdbsKLZL2HrV3X4Z+VBM5a5iKnkuNWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962764; c=relaxed/simple;
	bh=dkAlcixsI/EOQjZqix2UpB0Wt/GIgPriEA2EMs54W8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN+PEmu7OSofW79OCfWGPb7Qe7eHoK28gwmaZifEcFS4Y8N4Aqe1xFIoPim/ItLKK+97B1L1oTyPgKeXtKlV3Tpqm1bUUncPVVvF6D2G4vGdXPD5eyeanBolf3WOrMFyCiokeTnPJuzKKliowCvkuB9k2pFjHwenzIAC3hKp1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYEkpzsK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727962761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QK8hm5+Vg9MDEFMOGKSlZYpSx5pMmRJAduOgz0G0iRk=;
	b=CYEkpzsKM56JRyWSy4eV0iraeVrl013AwsanVqRKsfuESBTrLmjPS8nFZ5BMvtTUpHZWoU
	SUpiD61o9paet+r37lOX3ty9ahLtbbi+MrztSUefhgK9vb3i4VXX3LkRdpIJKhCPsifdug
	JcHp5Kzn+r8fJX6OBvZR0Q0NpgE4BXA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-y6fSk9KTN7GScbpTmM8ngw-1; Thu, 03 Oct 2024 09:39:20 -0400
X-MC-Unique: y6fSk9KTN7GScbpTmM8ngw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb08ed3a6so9328035e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 06:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962759; x=1728567559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QK8hm5+Vg9MDEFMOGKSlZYpSx5pMmRJAduOgz0G0iRk=;
        b=rKqoY8jqRZo/9SB5tkYMkRzfY+SU9GjxXSEELAj+93va3EPLw7JYmqZMstJlKv8+rx
         SANx54BEYhNYWL2ry72KkQjkStxFW3r04/S7mFZB9jhQEpWckhYTceY45jw4LcxLhyU3
         2EJaopBpcr+Fhw3yVN+ouiPi7OhCXsRk+ZXMzEl+edYcIh2wWXKMq7RVGRThSB4tfMZs
         0Powwh2F+DJermi9ao0mPZr5DKLGR+CesE8yzSOF98lWMscfZoDa9q4obZCXUSkyfbmL
         73jyyIzs74uLho3vMlx0/924UE/0tAusAiZsS2CIwRIVl1WGQN4eVyf18X0Ff+86BRCV
         73oQ==
X-Gm-Message-State: AOJu0Yyg8mbr3qpn8f2/h9ZZIw/D2VoHoSQs8j1XNZk2H+EygOijMyK1
	WI/P5CRWoD2fJj7KdcAtKW/3M1ejVPTHBBSiRYZMqjPkqVyJJSxulxxd7BQo19qRnnvw7Z+vTEW
	7wkf2Z0az7OG8SfY8k+eoL44VgV1lNon90Ka2BIPqUzXTI0xEyTe3QQ==
X-Received: by 2002:a5d:614a:0:b0:37c:fbb7:5082 with SMTP id ffacd0b85a97d-37d04a3eac2mr2007337f8f.25.1727962759142;
        Thu, 03 Oct 2024 06:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2kvnFrrY+007ehLYA6J1WbNZw+e6r/KuUDJql4NxTAgg0nSMsQ8fV5b06JpXy6tE6CypFDQ==
X-Received: by 2002:a5d:614a:0:b0:37c:fbb7:5082 with SMTP id ffacd0b85a97d-37d04a3eac2mr2007313f8f.25.1727962758636;
        Thu, 03 Oct 2024 06:39:18 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f737asm1300421f8f.4.2024.10.03.06.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 06:39:18 -0700 (PDT)
Message-ID: <308126dc-1a5d-480c-b8a2-053f73865f86@redhat.com>
Date: Thu, 3 Oct 2024 15:39:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v5] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
To: Zijun Hu <quic_zijuhu@quicinc.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <zijun_hu@icloud.com>
References: <20240930-qcom_emac_fix-v5-1-e59c0ddbc8b4@quicinc.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240930-qcom_emac_fix-v5-1-e59c0ddbc8b4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/30/24 13:32, Zijun Hu wrote:
> To prepare for constifying the following old driver core API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to new:
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> The new API does not allow its match function (*match)() to modify
> caller's match data @*data, but emac_sgmii_acpi_match(), as the old
> API's match function, indeed modifies relevant match data, so it is
> not suitable for the new API any more, solved by implementing the same
> finding sgmii_ops function by correcting the function and using it
> as parameter of device_for_each_child() instead of device_find_child().
> 
> By the way, this commit does not change any existing logic.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> This patch is separated from the following patch series:
> https://lore.kernel.org/all/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com/
> 
> This patch is to prepare for constifying the following driver API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> How to constify the API ?
> There are total 30 usages of the API in current kernel tree:
> 
> For 2/30 usages, the API's match function (*match)() will modify
> caller's match data @*data, and this patch will clean up one of both.
> 
> For remaining 28/30, the following patch series will simply change its
> relevant parameter type to const void *.
> https://lore.kernel.org/all/20240811-const_dfc_done-v1-1-9d85e3f943cb@quicinc.com/
> 
> Why to constify the API ?
> 
> (1) It normally does not make sense, also does not need to, for
> such device finding operation to modify caller's match data which
> is mainly used for comparison.
> 
> (2) It will make the API's match function and match data parameter
> have the same type as all other APIs (bus|class|driver)_find_device().
> 
> (3) It will give driver author hints about choice between this API and
> the following one:
> int device_for_each_child(struct device *dev, void *data,
> 		int (*fn)(struct device *dev, void *data));
> ---
> Changes in v5:
> - Separate me for the series
> - Correct commit message and remove the inline comment
> - Link to v4: https://lore.kernel.org/r/20240905-const_dfc_prepare-v4-2-4180e1d5a244@quicinc.com
> 
> Changes in v4:
> - Correct title and commit message
> - Link to v3: https://lore.kernel.org/r/20240824-const_dfc_prepare-v3-3-32127ea32bba@quicinc.com
> 
> Changes in v3:
> - Make qcom/emac follow cxl/region solution suggested by Greg
> - Link to v2: https://lore.kernel.org/r/20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com
> 
> Changes in v2:
> - Give up introducing the API constify_device_find_child_helper()
> - Implement a driver specific and equivalent one instead of device_find_child()
> - Correct commit message
> - Link to v1: https://lore.kernel.org/r/20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com
> ---
>   drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> index e4bc18009d08..e8265761c416 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> +++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> @@ -293,6 +293,11 @@ static struct sgmii_ops qdf2400_ops = {
>   };
>   #endif
>   
> +struct emac_match_data {
> +	struct sgmii_ops **sgmii_ops;
> +	struct device *target_device;
> +};
> +
>   static int emac_sgmii_acpi_match(struct device *dev, void *data)
>   {
>   #ifdef CONFIG_ACPI
> @@ -303,7 +308,7 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
>   		{}
>   	};
>   	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
> -	struct sgmii_ops **ops = data;
> +	struct emac_match_data *match_data = data;
>   
>   	if (id) {
>   		acpi_handle handle = ACPI_HANDLE(dev);
> @@ -324,10 +329,12 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
>   
>   		switch (hrv) {
>   		case 1:
> -			*ops = &qdf2432_ops;
> +			*match_data->sgmii_ops = &qdf2432_ops;
> +			match_data->target_device = get_device(dev);
>   			return 1;
>   		case 2:
> -			*ops = &qdf2400_ops;
> +			*match_data->sgmii_ops = &qdf2400_ops;
> +			match_data->target_device = get_device(dev);
>   			return 1;
>   		}
>   	}
> @@ -356,10 +363,14 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
>   	int ret;
>   
>   	if (has_acpi_companion(&pdev->dev)) {
> +		struct emac_match_data match_data = {
> +			.sgmii_ops = &phy->sgmii_ops,
> +			.target_device = NULL,
> +		};
>   		struct device *dev;
>   
> -		dev = device_find_child(&pdev->dev, &phy->sgmii_ops,
> -					emac_sgmii_acpi_match);
> +		device_for_each_child(&pdev->dev, &match_data, emac_sgmii_acpi_match);
> +		dev = match_data.target_device;
>   
>   		if (!dev) {
>   			dev_warn(&pdev->dev, "cannot find internal phy node\n");


I'm sorry for the late feedback. I agree with Greg, I think it would 
more clear removing the get_device() from the match function and add it 
here, after the 'if (!dev) {' statement.

Thanks,

Paolo


