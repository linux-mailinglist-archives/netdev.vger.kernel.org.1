Return-Path: <netdev+bounces-114531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8E7942D4D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337211C21609
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1141A8C0C;
	Wed, 31 Jul 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="LHkz8Rdt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5B34CDE
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425716; cv=none; b=Olf4gtHhMruXY65y1gacwzsDmmgq+gZNBAfHJXRForHr7EE4w1lnY+43ZbW3Wh5sH7OglTM5GvK2COl2OUddZfOjE+XbHpvdCTr8vSISVWmh7h4pVvA2d/4+UBVSmS76GlHFbaMOkiVHTFeJk8QqbxLZeG93HKa6iTHt8QxllVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425716; c=relaxed/simple;
	bh=2KLlYSv2pqCjLyymLPqt9+aVQWowB7gktb1jU/vjTs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sT+PayLv5IX9U5cC7xdur95ePa+ohzNUrMLccMAGk6LCJa5/BAqyxcpoiRUmTf2RFf66zg0K1DP3LeJBJ/6NWfwuzJrFnWg2I/mFmazFFh6oo996e3TffPmXoQd5n1NaPishEWnQ13d33jiMZzGXgZBQb4TlgYW7dA75a4/nPj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=LHkz8Rdt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a843bef98so590799666b.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722425713; x=1723030513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boFYO0r1hfN8XIImPghehk1SbXzMdtypod7bR6Zqvts=;
        b=LHkz8RdtBDFJNSPPJdR4ZXAtvgRjf/NYOYCUf0/Eh71WPlQ/PY9h/FMqdoyXk5ZeB6
         Ik+xl7iyhaArnG1jq+AoP8uXRsptEQ2f2fVC6za73qCJszi9n/8rXYzjrhtDfHI8xNMs
         Vbxv4EoTluuc48cYgd+iNtFyMyDtX+m59XBOrQff/EBxGN+rhsEBfYEglpm6RrS+xe66
         pGicdiMFu7gaSyuTtILRhz5gsBxvWEjRazyma6UFjsQWtnsuuw+B+mBA93fZd6cURiF6
         mWeogAM5Up8v2MplKfSV4y5HJJFbKuiZWgm13MbsCt88TWy2JfKpQZgcvU7zXP+qMYOv
         tgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722425713; x=1723030513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boFYO0r1hfN8XIImPghehk1SbXzMdtypod7bR6Zqvts=;
        b=Hf/PNTrd4Fqil7ds/dMdhu4PoExQhNjMwnLxsooVfAE/x1tiBZgUo5Ru8czUmn5wsR
         eMjR+Vv8LcDy15EPBo26jPUyKs7vMCKMVGXq9VUcFecQ42hiOfFTQci7wfQ6Os5Nu6iK
         iNyUHreOczkrxhG6gLviVxLBhxXrw1ip7DxjKthWcT9uRy8DrRfRT5vMfW4C5Sh/6t6a
         KNk0i3vdZdmObcYEl6lIyH+hRAbxOkM7V/AnBh+V+mDMsjcxYZgpFItuQsqwHkYh3eGU
         12hdoiV1H2JLgEO88/7++teHTh8QPL8xQBcx0yuDWQMo4DwKjiCzQHQ9dW0haEvrXfXd
         K30Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSuzM1yI2uACOpv9qbrM84bd5MjWRFApInZ2co7U+Gcsnb6YxDeDnlNY7KwLMOlpQn/wKeqdMC4WMNW0jntxNbjo3DFoWd
X-Gm-Message-State: AOJu0YxY0wzyqsvr7A6uiLBQm3SLyXsXq32h+IxwRDCfqruwznFf0CWn
	J4ug34MvWqe9V8kzHIPKctCRPRzLzlQLrHY7baifiFCfVGiDNRtSr8xkfWuYxhk=
X-Google-Smtp-Source: AGHT+IEvJOEARdvbqpGR9nmQAAhomQBNUEx+q+w3HuTQ2f1O0Lujw8IC/OmYSg9E2m9M2T3RRVdS4w==
X-Received: by 2002:a17:907:7d86:b0:a7a:929f:c0cf with SMTP id a640c23a62f3a-a7d400461ccmr948857166b.21.1722425712416;
        Wed, 31 Jul 2024 04:35:12 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:82d:3bb6:71fa:929f? ([2620:10d:c092:500::4:457])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb82d5sm754695366b.199.2024.07.31.04.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 04:35:11 -0700 (PDT)
Message-ID: <6a6b3aff-c00c-481b-9a83-7dfc324d6b02@davidwei.uk>
Date: Wed, 31 Jul 2024 12:35:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/3] bnxt_en: stop packet flow during
 bnxt_queue_stop/start
Content-Language: en-GB
To: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Michael Chan <michael.chan@broadcom.com>
References: <20240729205459.2583533-1-dw@davidwei.uk>
 <20240729205459.2583533-3-dw@davidwei.uk>
 <7b27e95e-85a7-43da-a06c-4ab56eccf5b6@intel.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <7b27e95e-85a7-43da-a06c-4ab56eccf5b6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-30 11:31, Wojciech Drewek wrote:
> 
> 
> On 29.07.2024 22:54, David Wei wrote:
>> Calling napi_stop/start during bnxt_queue_stop/start isn't enough. The
>> current implementation when resetting a queue while packets are flowing
>> puts the queue into an inconsistent state.
>>
>> There needs to be some synchronisation with the FW. Add calls to
>> bnxt_hwrm_vnic_update() to set the MRU for both the default and ntuple
>> vnic during queue start/stop. When the MRU is set to 0, flow is stopped.
>> Each Rx queue belongs to either the default or the ntuple vnic.
>>
>> Co-Developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
>> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 ++++++++++++++++++----
>>  1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index 8822d7a17fbf..ce60c9322fe6 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -15172,7 +15172,8 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>>  	struct bnxt *bp = netdev_priv(dev);
>>  	struct bnxt_rx_ring_info *rxr, *clone;
>>  	struct bnxt_cp_ring_info *cpr;
>> -	int rc;
>> +	struct bnxt_vnic_info *vnic;
>> +	int i, rc;
>>  
>>  	rxr = &bp->rx_ring[idx];
>>  	clone = qmem;
>> @@ -15197,11 +15198,16 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>>  	if (bp->flags & BNXT_FLAG_AGG_RINGS)
>>  		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
>>  
>> -	napi_enable(&rxr->bnapi->napi);
> 
> I get it that napi_{enable|enable} isn't enough but why removing it?
> Without it, RX will not work, the poll method won't be called or am I missing something?

From my testing removing napi_enable/disable() is needed for reset to
work on a queue that has traffic flowing.

Let me edit the commit message to make this bit clearer. Thanks.

> 
>> -
>>  	cpr = &rxr->bnapi->cp_ring;
>>  	cpr->sw_stats->rx.rx_resets++;
>>  
>> +	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
>> +		vnic = &bp->vnic_info[i];
>> +		vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
>> +		bnxt_hwrm_vnic_update(bp, vnic,
>> +				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
>> +	}
>> +
>>  	return 0;
>>  
>>  err_free_hwrm_rx_ring:
>> @@ -15213,9 +15219,17 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>>  {
>>  	struct bnxt *bp = netdev_priv(dev);
>>  	struct bnxt_rx_ring_info *rxr;
>> +	struct bnxt_vnic_info *vnic;
>> +	int i;
>> +
>> +	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
>> +		vnic = &bp->vnic_info[i];
>> +		vnic->mru = 0;
>> +		bnxt_hwrm_vnic_update(bp, vnic,
>> +				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
>> +	}
>>  
>>  	rxr = &bp->rx_ring[idx];
>> -	napi_disable(&rxr->bnapi->napi);
>>  	bnxt_hwrm_rx_ring_free(bp, rxr, false);
>>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>>  	rxr->rx_next_cons = 0;

