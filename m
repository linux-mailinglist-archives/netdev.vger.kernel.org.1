Return-Path: <netdev+bounces-153281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518E9F78B2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD339166E4E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639C3221472;
	Thu, 19 Dec 2024 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dB51tcvx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F643222564
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601321; cv=none; b=RV2c7aFQBiuETg6To6F0SRK69C8W/XDOcitQO3Lzg+rSFKbtZW4FXZak5kyRqglHs2f4BgwGgp2d6oUKNPGpK5KZJLJGm40mObejcKKPRypNFnkEmdjvsvgreHzxzQQ69/2Jnpv3XOez4X/i8YDOkQnDsJBdQ+mzi348//uUzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601321; c=relaxed/simple;
	bh=hdp4spXp/2/zcBTurghgqS00k0uxvco5aCwl9iIT51U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJA0XVNYfSbIhHHQwmrfI+amKNAUzUuTaENQxJfFTTHMXWOlIBKR6Icz22zbOQPOF+wFeLPAidppRn/BnuPBUUQ+NpqbXCAWmvcySQQ3cYmXCZPY1qFaSWimrOisrGdxaKE8mo22SQPocmqPRloKgGW6wzq1B3tL8bebR3tX2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dB51tcvx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734601318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tOwvSdF+qmldOL8MB6NtY8sLxN453oRS9gZskeqpyo=;
	b=dB51tcvxJHOT0ZD8Hc7TvqXRz8XYnD1GEh+VsdfXpAGmsEoSNng3jr49WpaFudJvSD/oBp
	0vG1fVKh54GwnDU4195rAqgARmahBR/SkHo5YtiXqBSWkG/Z+htic2qU1ICrp3OhjJ79g8
	S4mEHngN4PonvWYXRcD8umRcmyQceYk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-N_glDRU5NISDiH95PM99PQ-1; Thu, 19 Dec 2024 04:41:57 -0500
X-MC-Unique: N_glDRU5NISDiH95PM99PQ-1
X-Mimecast-MFC-AGG-ID: N_glDRU5NISDiH95PM99PQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e27c5949so395637f8f.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734601316; x=1735206116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tOwvSdF+qmldOL8MB6NtY8sLxN453oRS9gZskeqpyo=;
        b=ctSkdTsCaRM/mFxMWCBjj9TPMtmSRW8N7QAmudz+XMuTuXmf5wOoKmKMauyL6fM6Hs
         nvCTQfyAHVdQZhwdttEbHY2h+Vv5IV+JKBUVb8aZkmpMPoExwrDdCN9QSHvI25U+xc+F
         G9vGDL8ruZpZWpML81CDzk+PpnE5Df98sqyhlkKBz5aCxebNvzE4ETfKA6pKCmOGUyb6
         +f/qJnw8wbdlABnHs9afGsDjWzdNZK7uiyJDO/tU3h22EHFuPZXwBjsT90SDDhgD5E96
         u3v85+clZaOcQH1sc3czGKQ9D2N5wereYNxNUcWCi4evQkLdbHopG/+JJLtvu95uLrxS
         1PVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7zMX78mk5BD9I3m22CcsLqVNTjVGGQrtAKbLYj4ijyDwLkVYpjxWPqI0HlptmSosg2OiAOWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyvDHhs6stffhu37u7Ls4x8Uo7AaYvi+JCiMRi6UWxukO75U4J
	DKfvY+H/fZ0RtqYg4pWVIHCYusRq4rcYjeCIlAy41rOMoa0eSVrY+Jhb4A2o1nDHy9+62wOFBDY
	puE+/96+kQFstx9VNaCkE1i2djaqI7w89o1y9k+sKovwKEuha9zchww==
X-Gm-Gg: ASbGncuaq6zOAXW8CmyrpXg6YUjpWbZuD7lzu8GKZnrz8uhs3jzmWdRldhuZ3+FUFXi
	cpmJ+fsVSoMn8pdj0sB3Yb9EmNx0/e0PaXOknBeXhv3EXC9Filg7pS8t6lYdCIxmlp2jINM6hie
	3hecwyQqxTn0ErCbsfgl2dzOqQBcndpeIzTmt+WO1uPVGp0qVQAainFlysKoHTN7h/OryPSRQaX
	5OMt6/cFvVnHxWIEEZ2GaOnRXFp69fuvMZpr+fiRMTVn7AhLT+CscaFiXrbUMaNQ6LamCf40GL2
	Divrv+YnOg==
X-Received: by 2002:a05:6000:144a:b0:385:ed16:c97 with SMTP id ffacd0b85a97d-388e4d9aab1mr4719041f8f.49.1734601315670;
        Thu, 19 Dec 2024 01:41:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7EeWzAfoVVVhCPJj0ClUy5P2YL/B/JgQGOCnw/9vJ7tKY4RPxEfDlD1OKLpyVNJV6UqRj2w==
X-Received: by 2002:a05:6000:144a:b0:385:ed16:c97 with SMTP id ffacd0b85a97d-388e4d9aab1mr4718992f8f.49.1734601315221;
        Thu, 19 Dec 2024 01:41:55 -0800 (PST)
Received: from [192.168.88.24] (146-241-54-197.dyn.eolo.it. [146.241.54.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847513sm1135038f8f.49.2024.12.19.01.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 01:41:54 -0800 (PST)
Message-ID: <8a789f23-a17a-456d-ba2a-de8207d65503@redhat.com>
Date: Thu, 19 Dec 2024 10:41:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND V2 net 1/7] net: hns3: fixed reset failure issues
 caused by the incorrect reset type
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, horms@kernel.org, shenjian15@huawei.com,
 wangpeiyang1@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-2-shaojijie@huawei.com>
 <Z2KPw9WYCI/SZIjg@mev-dev.igk.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z2KPw9WYCI/SZIjg@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 10:02, Michal Swiatkowski wrote:
> On Tue, Dec 17, 2024 at 09:08:33AM +0800, Jijie Shao wrote:
>> From: Hao Lan <lanhao@huawei.com>
>>
>> When a reset type that is not supported by the driver is input, a reset
>> pending flag bit of the HNAE3_NONE_RESET type is generated in
>> reset_pending. The driver does not have a mechanism to clear this type
>> of error. As a result, the driver considers that the reset is not
>> complete. This patch provides a mechanism to clear the
>> HNAE3_NONE_RESET flag and the parameter of
>> hnae3_ae_ops.set_default_reset_request is verified.
>>
>> The error message:
>> hns3 0000:39:01.0: cmd failed -16
>> hns3 0000:39:01.0: hclge device re-init failed, VF is disabled!
>> hns3 0000:39:01.0: failed to reset VF stack
>> hns3 0000:39:01.0: failed to reset VF(4)
>> hns3 0000:39:01.0: prepare reset(2) wait done
>> hns3 0000:39:01.0 eth4: already uninitialized
>>
>> Use the crash tool to view struct hclgevf_dev:
>> struct hclgevf_dev {
>> ...
>> 	default_reset_request = 0x20,
>> 	reset_level = HNAE3_NONE_RESET,
>> 	reset_pending = 0x100,
>> 	reset_type = HNAE3_NONE_RESET,
>> ...
>> };
>>
>> Fixes: 720bd5837e37 ("net: hns3: add set_default_reset_request in the hnae3_ae_ops")
>> Signed-off-by: Hao Lan <lanhao@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

I haven't signed-off this patch.

Still no need to repost (yet) for this if the following points are
solved rapidly (as I may end-up merging the series and really adding my
SoB), but please avoid this kind of issue in the future.

>> @@ -4227,7 +4240,7 @@ static bool hclge_reset_err_handle(struct hclge_dev *hdev)
>>  		return false;
>>  	} else if (hdev->rst_stats.reset_fail_cnt < MAX_RESET_FAIL_CNT) {
>>  		hdev->rst_stats.reset_fail_cnt++;
>> -		set_bit(hdev->reset_type, &hdev->reset_pending);
>> +		hclge_set_reset_pending(hdev, hdev->reset_type);
> Sth is unclear for me here. Doesn't HNAE3_NONE_RESET mean that there is
> no reset? If yes, why in this case reset_fail_cnt++ is increasing?
> 
> Maybe the check for NONE_RESET should be done in this else if check to
> prevent reset_fail_cnt from increasing (and also solve the problem with
> pending bit set)

@Michal: I don't understand your comment above. hclge_reset_err_handle()
handles attempted reset failures. I don't see it triggered when
reset_type == HNAE3_NONE_RESET.

>> @@ -4470,8 +4483,20 @@ static void hclge_reset_event(struct pci_dev *pdev, struct hnae3_handle *handle)
>>  static void hclge_set_def_reset_request(struct hnae3_ae_dev *ae_dev,
>>  					enum hnae3_reset_type rst_type)
>>  {
>> +#define HCLGE_SUPPORT_RESET_TYPE \
>> +	(BIT(HNAE3_FLR_RESET) | BIT(HNAE3_FUNC_RESET) | \
>> +	BIT(HNAE3_GLOBAL_RESET) | BIT(HNAE3_IMP_RESET))
>> +
>>  	struct hclge_dev *hdev = ae_dev->priv;
>>  
>> +	if (!(BIT(rst_type) & HCLGE_SUPPORT_RESET_TYPE)) {
>> +		/* To prevent reset triggered by hclge_reset_event */
>> +		set_bit(HNAE3_NONE_RESET, &hdev->default_reset_request);
>> +		dev_warn(&hdev->pdev->dev, "unsupported reset type %d\n",
>> +			 rst_type);
>> +		return;
>> +	}
> Maybe (nit):
> if (...) {
> 	rst_type = 
> 	dev_warn();
> }
> 
> set_bit(rst_type, );
> It is a little hard to follow with return in the if.

@Michal: I personally find the patch code quite readable, do you have
strong opinions here?

>>  	set_bit(rst_type, &hdev->default_reset_request);
>>  }
>>  
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>> index 2f6ffb88e700..fd0abe37fdd7 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>> @@ -1393,6 +1393,17 @@ static int hclgevf_notify_roce_client(struct hclgevf_dev *hdev,
>>  	return ret;
>>  }
>>  
>> +static void hclgevf_set_reset_pending(struct hclgevf_dev *hdev,
>> +				      enum hnae3_reset_type reset_type)
>> +{
>> +	/* When an incorrect reset type is executed, the get_reset_level
>> +	 * function generates the HNAE3_NONE_RESET flag. As a result, this
>> +	 * type do not need to pending.
>> +	 */
>> +	if (reset_type != HNAE3_NONE_RESET)
>> +		set_bit(reset_type, &hdev->reset_pending);
>> +}
> You already have a way to share the code between PF and VF, so please
> move the same functions to common file in one direction up.

AFAICS this can't be shared short of a large refactor not suitable for
net as the functions eligible for sharing operate on different structs
with different layout (hclgevf_dev vs hclge_dev). Currently all the
shared code operates on shared structs.

Cheers,

Paolo


