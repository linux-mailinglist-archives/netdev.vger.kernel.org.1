Return-Path: <netdev+bounces-226177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B3B9D6FC
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529381B24492
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 05:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574B2E7F14;
	Thu, 25 Sep 2025 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlK0h7Ed"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39FC2E7F00
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758777287; cv=none; b=FhtGgwHR8ttn3kao75XQFXUC60/BLGKXCaFjCq7l0WTagUQ5feM9S3nNxtIuqlyxv6SakoEXiTD4xN1Oh9Us3onEROADR4unp/5/ITSMAITGEFXCPr7n9vBKrT3X3EOn2WR9LsoTvrsbZAUHiJHGav0VrStTSp6vvJJZga4ODhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758777287; c=relaxed/simple;
	bh=XDVRyaYnXKKycev3/t7FTDub7I7o2+r8+Rxfj81zcOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBI2oEDB49m0bf69vACKLuzpN7GoVNF21vjKgDznxc0SCAYMKHvohgTWVm59D2pjpmLkdXgaI4Na+KTiS0q2eq9Py8ahobuGg+1n5DJFDpnSGK1Q8JVFVBMaTHAFsqHuGwUYXvScI+7j8xtZPgrvmsvkg4QsRyVV2cA3dm7G+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlK0h7Ed; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758777284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMYv4Lo109kd+3Z+DJmx3kyZNeT9AZfs8068hkBvsCk=;
	b=KlK0h7EdVxPI0QGUzUTotaj92YY0b0KDW8PBk5bXptgkVVmYK6CVjYD+WSbwYJcyS8soJA
	nrBRfqQedjtykX8Gp14zDrjGmf2hu1ZQ9j1hpS9KDycDAurMisG1j/kQ+EP+bTp+I76c0g
	g24cUmXlEzFfGMom3WGV6EDMHf2Vh4I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-WNGaSNz7ObenzyN_I3L6_w-1; Thu,
 25 Sep 2025 01:14:39 -0400
X-MC-Unique: WNGaSNz7ObenzyN_I3L6_w-1
X-Mimecast-MFC-AGG-ID: WNGaSNz7ObenzyN_I3L6_w_1758777278
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB5D41956054;
	Thu, 25 Sep 2025 05:14:37 +0000 (UTC)
Received: from [10.45.225.74] (unknown [10.45.225.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70A7F18003FC;
	Thu, 25 Sep 2025 05:14:34 +0000 (UTC)
Message-ID: <b288c52c-a3a6-4665-a777-2eb8464e883d@redhat.com>
Date: Thu, 25 Sep 2025 07:14:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dpll: zl3073x: Fix double free in
 zl3073x_devlink_flash_update()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aNKAvXzRqk_27k7E@stanley.mountain>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <aNKAvXzRqk_27k7E@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 23. 09. 25 1:13 odp., Dan Carpenter wrote:
> The zl3073x_devlink_flash_prepare() function calls zl3073x_fw_free()
> and the caller also calls zl3073x_devlink_flash_update() so it leads
> to a double free.  Delete the extra free.
> 
> Fixes: a1e891fe4ae8 ("dpll: zl3073x: Implement devlink flash callback")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/dpll/zl3073x/devlink.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
> index f55d5309d4f9..ccc22332b346 100644
> --- a/drivers/dpll/zl3073x/devlink.c
> +++ b/drivers/dpll/zl3073x/devlink.c
> @@ -167,7 +167,6 @@ zl3073x_devlink_flash_prepare(struct zl3073x_dev *zldev,
>   		zl3073x_devlink_flash_notify(zldev,
>   					     "Utility is missing in firmware",
>   					     NULL, 0, 0);
> -		zl3073x_fw_free(zlfw);
>   		return -ENOEXEC;
>   	}

Thanks, Dan!

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


