Return-Path: <netdev+bounces-114863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D494473E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D451C203D7
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7EE16EB5B;
	Thu,  1 Aug 2024 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Ssy3XTfe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A7B16DEA6
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502794; cv=none; b=p1F8b2FD3DezynV2e33hAlMJM+6GCxJ0Ld2xTKPEkGVGxirM7NUUm0Q/5znz1VwLahNW1ljDfhAjhSmaq0VoPY/PpRDCaWfu87zjRgXNI2Z7n05rumOIJE9pKDicJPMGZg4nPVBXf3QHroUszH4rEcGAh8Nn5wG6EHSPEHgjgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502794; c=relaxed/simple;
	bh=tUXuWtqCfGVZ6buMwYN2ghbvX0BVcto6Ls7Sslt2RvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gn9Bh6iobWxUTzeHYiteIyvbI27ljP7DDRAswAYj5JFIP7W+J28i0Dn0kDRAaBUMtKIe3yVA/C5J5hRSb/UcqMXhcVqWTZSdlSHxfx57stXaIfQEIGKg9dkCawGZyagKB27syrEHl0VOs6YveW8nzgPKHzwegxIZlypl+tWFY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Ssy3XTfe; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso552434066b.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722502791; x=1723107591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qj48FrXpNXB2q8InuOJzWKvcAtG06rAViWDcN3Akq0k=;
        b=Ssy3XTfewAY7Wy2eJV2Feie6gah91rJGs7MqSNNNRFdzGF8m9aI5gKD3Adc9kYp/6m
         ZIyo+M9/hSe0FTp/e1p+Jv4NjrCAJhJmP53gC5yRwHYobnLZ39pBveVkzhbiULfY/sU2
         seUux9PRqYBuAa9Sf020rNHIlp7c4cpvkg0BP6qPRXsPwQR6N0Di4getjpgh7ZlXIISA
         3lRx7ZO5B/XF35+po0a9XMfxqyPcLHtM0cgboSvD0UlkTNomcZk8DuIYXJP4yKJH3cS4
         Pf5AIbmQrFehVXPPh+kex44RWG5q8U44s7cNVKzS2tJ2UAgclspnLaQ9Rym+Cdg9B0C0
         HlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502791; x=1723107591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj48FrXpNXB2q8InuOJzWKvcAtG06rAViWDcN3Akq0k=;
        b=fnZ2ADUB9AMBG2jJb0t8ZWCEGeNZXWpXL0Ptv9OtI9uUQ89vK57QOPru+xNPlrTc4J
         w5qSNd0kSgf1/vFWC4aU6RMUAyASjh0AJpzgz8LlKuQOt9jqdx9ODY++OKdYV2dSEB0Y
         +iQ+Fs7MXf5Lg6kBsu+e0wAv2V5NvA59v5NaelShKriCl6AAQAEoaW2m+H7AZeAx1ZDo
         7A8SXvOzAh9lMsaebZwhd4RZa1hJcMp0ps745MZC2J7vQj8x41uJMb1ibZhJ45y5WXSS
         URzAuHv3TBao2oS5kt7FUJjI1Vvgu++Xgy2Xu1TC0+bYjB3GQrdBFjAnMFsavqrmy8dA
         lHyw==
X-Gm-Message-State: AOJu0YyDC8E18vA6sMuldU3OKLbNd6JmUTUGM8fcO/IMy2cBUMHQLFWK
	qrSbUcytsR0iggHHceZ5xvQ0igI7Ce/1sLGW0bwcer3E22YrmqP7FGIsTgx1N0U=
X-Google-Smtp-Source: AGHT+IGkWbqqkn5fj0AF3HdFoNTC2r28Ni/qPjnJRVjqFG2pRpUtAJjsbQQwPouIIoGnLPl+KocwVQ==
X-Received: by 2002:a17:907:7249:b0:a7d:a00a:a9fe with SMTP id a640c23a62f3a-a7daf52fd04mr137641866b.17.1722502790917;
        Thu, 01 Aug 2024 01:59:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:82d:3bb6:71fa:929f? ([2620:10d:c092:500::6:c612])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4dec6sm868995766b.61.2024.08.01.01.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 01:59:50 -0700 (PDT)
Message-ID: <3cd7c1c5-3e84-44f0-8552-ea5d95aa6b7c@davidwei.uk>
Date: Thu, 1 Aug 2024 09:59:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] bnxt_en: only set dev->queue_mgmt_ops if
 BNXT_SUPPORTS_NTUPLE_VNIC
Content-Language: en-GB
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Somnath Kotur <somnath.kotur@broadcom.com>
References: <20240731131542.3359733-1-dw@davidwei.uk>
 <20240731131542.3359733-5-dw@davidwei.uk>
 <CACKFLimCkpVn_U40i_r9-5ORQT733Mfku6bmPX2QiyBGfELjTw@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CACKFLimCkpVn_U40i_r9-5ORQT733Mfku6bmPX2QiyBGfELjTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-08-01 02:33, Michael Chan wrote:
> On Wed, Jul 31, 2024 at 6:15 AM David Wei <dw@davidwei.uk> wrote:
>>
>> The queue API calls bnxt_hwrm_vnic_update() to stop/start the flow of
>> packets. It can only be called if BNXT_SUPPORTS_NTUPLE_VNIC(), so key
>> support for it by only setting queue_mgmt_ops if this is true.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index ce60c9322fe6..2801ae94d87b 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -15713,7 +15713,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>         dev->stat_ops = &bnxt_stat_ops;
>>         dev->watchdog_timeo = BNXT_TX_TIMEOUT;
>>         dev->ethtool_ops = &bnxt_ethtool_ops;
>> -       dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
>>         pci_set_drvdata(pdev, dev);
>>
>>         rc = bnxt_alloc_hwrm_resources(bp);
>> @@ -15892,8 +15891,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>
>>         INIT_LIST_HEAD(&bp->usr_fltr_list);
>>
>> -       if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
>> +       if (BNXT_SUPPORTS_NTUPLE_VNIC(bp)) {
> 
> Thanks for the patch.  We found out during internal testing that an
> additional FW fix is required to make the ring restart 100% reliable
> with traffic.  FW needs to add one more step to flush the RX pipeline
> during HWRM_VNIC_UPDATE.  Once we determine which FW versions will
> have the fix, we can add the conditional check here to make this patch
> more complete.  I think we just need about a week to determine that.
> Please hold off on this patchset.  Thanks.

Got it, no problem. Let me know the FW version and I'll gate the ops
behind it. Thanks.

