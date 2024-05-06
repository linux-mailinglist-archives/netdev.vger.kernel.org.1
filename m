Return-Path: <netdev+bounces-93551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60138BC4E8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264E2B210B6
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 00:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE31FB5;
	Mon,  6 May 2024 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="XnsENh8O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF68394
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714955808; cv=none; b=CGkpqibRcllFnmlIhcWa8ecFiP6FnpIPiVwF7Z8DwNJnzkW5Rr1JyeclpX0j+fx9v9w30hmLVuDDdOs792idHvSF7Yd053js65y6kb/Q2wBxWItJaHlUcQA7qLXm0uLZcVhvg6pMUss8O1dB0X9Y0TfP4l9OURs9EOguVMJTGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714955808; c=relaxed/simple;
	bh=Mom2zBrdqAtoE9CGtbZCH/cSjFy72snhiyq7peqjNM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBvkAwh6yxYHYYvLxd5dLqVoUVAVgI1eN+vBVFTCsUjjphol3kMO61z0mopYoJjDcGe8yJSwbshy2X2+LK0ZNnZRVwsZHRcmnTupvvqjnDu0hQtkXop7985Q0i9WmB2A+HnXZurrIbcbt/NvIEBvDIhbMQaulMgoe8OTGkBgntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=XnsENh8O; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1192360a12.2
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 17:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714955806; x=1715560606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTD29P1atrY1hArb6oAp7xqktzdtyV22n+spdF6+4S4=;
        b=XnsENh8OscrCOSZeMPaXEB2wRe5clzEzu05svfh2F0sZnobDeWs7W0YaPxskF85tB6
         J1L1nRf1B2lqC98WT2+odkRmQoUrIwfa2ZCr8s87LIv26PWlyt49pM4LEKWTxY4pIo1Z
         HomxSyrFw4fV/ZLLLKVVsrQZZzdZhfpn18c3cZwe7J2pInTeJcODb7t8jvBjq7p+Nopk
         dtTFKF1FCUKwf1Vxe8Yd+kILo0j2j8Nt1CIjxBK05aXHynUf99iZxBlg2ufFTa8EX3Va
         L7SbqXaGhTAQSGgpptJvKnoJU6NYzLgz9ucoBnsPCEaSNWNyCNVCFWk1dmzsj/g9TyPG
         zFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714955806; x=1715560606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTD29P1atrY1hArb6oAp7xqktzdtyV22n+spdF6+4S4=;
        b=poPW8J36g0NSKkWPmoc7gTA+L7dMb32QG3o/Q16y3t9y0GBqAw4V2PLChXpLtJdkYY
         /LByDNzsM00tiUZqyfGBDakzdtxEylIEAo67y889EJLU838m9pfZ3nyiASyDC0fTKlt/
         2O6ngsKmkeJLJV5x+TcBLJFSPoDsefkn4cnyMR16lZpEK+5xYaWkFNoLJoiw/RJP2xuV
         iFZ7qK8OxUTttE8FRyjDU2EpXhVD6VoPiWvwv6Iyh2Zp4qFy87YPqhJ/WViCaPMPG4GG
         6KPfOk/gfTrPK8PZNB6wIoxrIcApES5EzT/kXg8gGsehsA1YXzqaFvTq0masKzJgG8+C
         bhGA==
X-Gm-Message-State: AOJu0YxyrAkUo6u7ipJ/ogqxqp/2M3/7X66XGD6TULJ30G8rIXhpn0mu
	zfryCUe6OB/1JCWBzxVL3dNISglgbyPAaXNl5auBggCfVRdsn9rYx7E5Cc5l4NA=
X-Google-Smtp-Source: AGHT+IFDg+2NbHV8aUkkPAb7v9PKWXW8T5Fe4x/1cTfzLZjhvyubuxuL4pHT4dX0JHu11+6LYsr6bA==
X-Received: by 2002:a05:6a20:9193:b0:1a9:5e63:500e with SMTP id v19-20020a056a20919300b001a95e63500emr9746381pzd.27.1714955805985;
        Sun, 05 May 2024 17:36:45 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id m10-20020a1709026bca00b001ecc6bd414dsm6990591plt.145.2024.05.05.17.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 17:36:45 -0700 (PDT)
Message-ID: <4ea91657-2361-406d-923d-c55da89a3ff4@davidwei.uk>
Date: Sun, 5 May 2024 17:36:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 2/9] bnxt: implement queue api
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Shailend Chand <shailend@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-3-dw@davidwei.uk>
 <CAHS8izMcJ2am+ay1xLxZsZFRpaor-ZKPuVPM+FXdnn4FBpC2Fw@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izMcJ2am+ay1xLxZsZFRpaor-ZKPuVPM+FXdnn4FBpC2Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-05-02 10:23, Mina Almasry wrote:
> On Wed, May 1, 2024 at 9:54 PM David Wei <dw@davidwei.uk> wrote:

...

>> +
>> +static int bnxt_queue_stop(struct net_device *dev, int idx, void **out_qmem)
>> +{
>> +       struct bnxt *bp = netdev_priv(dev);
>> +       struct bnxt_rx_ring_info *rxr;
>> +       struct bnxt_cp_ring_info *cpr;
>> +       int rc;
>> +
>> +       rc = bnxt_hwrm_rx_ring_reset(bp, idx);
>> +       if (rc)
>> +               return rc;
>> +
>> +       bnxt_free_one_rx_ring_skbs(bp, idx);
>> +       rxr = &bp->rx_ring[idx];
>> +       rxr->rx_prod = 0;
>> +       rxr->rx_agg_prod = 0;
>> +       rxr->rx_sw_agg_prod = 0;
>> +       rxr->rx_next_cons = 0;
>> +
>> +       cpr = &rxr->bnapi->cp_ring;
>> +       cpr->sw_stats.rx.rx_resets++;
>> +
>> +       *out_qmem = rxr;
> 
> Oh, I'm not sure you can do this, no?
> 
> rxr is a stack variable, it goes away after the function returns, no?

Not for bnxt, where rx_ring is a dynamically allocated array.

In later patches I will change how the ndos are implemented. Next series
I'll squash these intermediate patches that are now useless.

> 
> You have to kzalloc sizeof(struct bnext_rx_ring_info), no?
> 
> Other than that, the code looks very similar to what we do for GVE,
> and good to me.

Thanks.

> 
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
>> +       .ndo_queue_mem_alloc    = bnxt_queue_mem_alloc,
>> +       .ndo_queue_mem_free     = bnxt_queue_mem_free,
>> +       .ndo_queue_start        = bnxt_queue_start,
>> +       .ndo_queue_stop         = bnxt_queue_stop,
>> +};
>> +
>>  static void bnxt_remove_one(struct pci_dev *pdev)
>>  {
>>         struct net_device *dev = pci_get_drvdata(pdev);
>> @@ -15275,6 +15336,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>         dev->stat_ops = &bnxt_stat_ops;
>>         dev->watchdog_timeo = BNXT_TX_TIMEOUT;
>>         dev->ethtool_ops = &bnxt_ethtool_ops;
>> +       dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
>>         pci_set_drvdata(pdev, dev);
>>
>>         rc = bnxt_alloc_hwrm_resources(bp);
>> --
>> 2.43.0
>>
> 
> 

