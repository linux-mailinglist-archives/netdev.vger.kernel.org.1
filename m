Return-Path: <netdev+bounces-125489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A04E096D590
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D382E1C25036
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F801990DC;
	Thu,  5 Sep 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alFW4iyX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BE1991C1
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531134; cv=none; b=ZDHMjz+AB16HS6kYJkYHP5MU1mi/32uMp+pdaDDoE2va2av3xzrEb81pmWl/VfJjcq//2gHFzDSSU2UdHXWbUNsuAZg5h1Pw+ZrlnBy4N00knOIDBVrwvLSZGH0s0ZKhE6+QkgNSM35o5H1KirUpcIfF9D8z/XA4Fdvw5ZWBcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531134; c=relaxed/simple;
	bh=7O87r2xMseHIGhzfoVzmUdZJllmHu+tBeIofr+G8mzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFOoGCU96eHmQGuh1t+JcjaT68fq1MaUStzQjYH+84FSGOgiVSO4TFmkXJU3LZwvzyJrfL1/trg5qZzxzpm+far97/7TA87X/8mhI+vadE+PLLF8LZxXETQpO32xJtH8gArYeM0dnG5FcaB10k1nbHhdaetUwfZfITECO47MPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alFW4iyX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725531131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YS4mx7hdPez9NNqAo+k0RYNNkOOS0sGEzzyoKK9JWk0=;
	b=alFW4iyXoY2k5ddKlVehC6A4IBrHuGgIVFcZdvYGaMH+Vsrh8nwonJIOyKC4yUrndKLgz0
	m8M0203lNWg6/MpwfpbKlLpsDzfIdHi607LMRR6HWYzrEYekHQMf5V+a1R/POAfAlg1GVt
	JSBcJG2s/nArwlbmnZtI9I5rSzwial0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-I_fwQXXMNTS8knNlFvy0cg-1; Thu, 05 Sep 2024 06:12:10 -0400
X-MC-Unique: I_fwQXXMNTS8knNlFvy0cg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bafca2438so6035365e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 03:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531129; x=1726135929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YS4mx7hdPez9NNqAo+k0RYNNkOOS0sGEzzyoKK9JWk0=;
        b=MV7d0YqYqDoZ/X81bGPJ98+8aaQnMCn2YAS0YAHe39gR2ZTrmJkR7V5Hu208iemGt/
         kcTx2s/e3lctjRV2vZHaQnpJvYy8sxgg35I2gAI2X42RplPWZ2nGcDubuFVO3tQxqza0
         pBuC45/HEYtoJRdKtAXfeqL97kB0k9LsvwsjIAenw3+aWEMpAtiHvDJHtih7bTFYlVdO
         7UArAJJYoxHERkfy5YFY//p5TvmbEFsI8v1IKEmnGf27AT+X6WUcZ3qBfxjib65YWpo/
         4soY1n3M+yeoZsyhHqDbA43Ux6ug4l3SoKbHGicfUzVTL3lXTEt5ZOwlX7Jo55JjqfKK
         YL+A==
X-Forwarded-Encrypted: i=1; AJvYcCWM8DBvBIweVPUEI1K334V0b+ii20Y9dHPPnwAiCWeJu4n2UqiPSAKlzMgJ0lHniPWG2xx/8i0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl3t1tER/mHknmYd7igmmQq1U8cDUcp3QomAdjHYNQgmzsSL2o
	tM6ie4A1MNXX5L5JVUf0PwOYG3rV1szQLSFxkQ1s6gsE6WUxjMAx85OwY2ruCq3vsMQDb8ueJJf
	dwO/vq/X+SIfoAWkl0Bx+HdnSi06CB8gsTPAgT6MCSLXGj9qqawQ1fQ==
X-Received: by 2002:a5d:668a:0:b0:374:c11c:c5ca with SMTP id ffacd0b85a97d-374c11cc70cmr12421489f8f.46.1725531129231;
        Thu, 05 Sep 2024 03:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6NTbwAh/E1BRBZJNBYvljuncF0WzhSvs7OV8kHiq8uftKn+7VbZFSaT7QMvQPBxaQ/UkiBA==
X-Received: by 2002:a5d:668a:0:b0:374:c11c:c5ca with SMTP id ffacd0b85a97d-374c11cc70cmr12421448f8f.46.1725531128703;
        Thu, 05 Sep 2024 03:12:08 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c0f6f4c4sm13588410f8f.44.2024.09.05.03.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:12:08 -0700 (PDT)
Message-ID: <2a44050f-89f8-446f-aa5f-3101ae46f314@redhat.com>
Date: Thu, 5 Sep 2024 12:12:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 4/8] net: ibm: emac: remove mii_bus with devm
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 sd@queasysnail.net, chunkeey@gmail.com
References: <20240903194312.12718-1-rosenp@gmail.com>
 <20240903194312.12718-5-rosenp@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240903194312.12718-5-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 21:42, Rosen Penev wrote:
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 459f893a0a56..4cf8af9052bf 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -2580,6 +2580,7 @@ static const struct mii_phy_ops emac_dt_mdio_phy_ops = {
>   
>   static int emac_dt_mdio_probe(struct emac_instance *dev)
>   {
> +	struct mii_bus *bus;
>   	struct device_node *mii_np;
>   	int res;

Minor nit: please respect the reverse xmas tree above.

Thanks,

Paolo


