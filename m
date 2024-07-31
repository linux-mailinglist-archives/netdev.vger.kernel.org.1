Return-Path: <netdev+bounces-114444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB799429D2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993F21C211B3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B7F18CBE2;
	Wed, 31 Jul 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bxocSUm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D761CF93
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416488; cv=none; b=egjFNsBc490LOav45MGWxdXwXSdyDvAzd8Ug4y6voWSHpCu5CUYfAmX7cqYmWUQKsIPEUzL9NF8i1O+zOTk+sDwxLDGdDkWLuYkQrPdxLUFUWwmr0VaqLYoK4hMzvbhDxVgW1V7uwZHcHiI3IdPBurRvqCLaMPsaA9McpQS9sj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416488; c=relaxed/simple;
	bh=g49UtDI7S6aRa8qTRQvblB0oiSMHX2Qx/NsnAghBGvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET5gq9r+cTfxD0PPeEfNBnVD92yjuH6hdi6YqqNu8DTlZOhhhzDREx07FbJlSqNSrOeebt7E7Ito2INcaLxYALA9YMQzkQSoznRK8eqI87AJekjCTgIN4ultf6EOnLW9j3qG5RS5NLI1aD48e5BLHZTiEIeoekJdKr5vq5fXGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=bxocSUm6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a728f74c23dso732788366b.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722416482; x=1723021282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRDYbaOKhF9NcC676jtWxbzzB32j0WbSctBNrlyRKRA=;
        b=bxocSUm6T6omUEkQBqoCoOlfXprg7rmXalhMh1ppC5LsWAn3MghYWiLB/ZWmrgCc+I
         b7R3dbknX2M9e/LsiL/BCvWLUjsWXZFeIAYjF7EIsBlR0ozsFfrJZdZR8eE3Yjxw9Uqa
         B8YXSLsxR4W4vAGXmUzTfS4p2Hp8DocDD88UBV240YVdNYmi5E364W3Z+pg5lVZfLvgu
         UQkxfjd/9sctnWdnVuZErcJ3QrYnGZx1S1er1u8SR2zq9LQbkDWQ8JsG7CGi11D5Lact
         kSGXCHRPB6nDmbD8XiaNsyfXYjIOTFbb0B9Gl5v6p1Ydga0v/kH7wIVOy2wH5Knbr6g+
         8AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722416482; x=1723021282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRDYbaOKhF9NcC676jtWxbzzB32j0WbSctBNrlyRKRA=;
        b=wMDpFuSUShQhrSKu1fXXy9Vz1dOesBkEx6UzLNFespokfFFYDWJu9BdAuvUw032VjI
         y1ShmE7CrPlst54HNowZRya2uBM0pbPmvT622bewwB+vQv5n4wt5MozgVNO/+MiuSi5d
         WdCdSeQ227Mom+x1WMKZUWwb+qodw8KVu5okT02/0Q+Y6jealBSxQO8QNm/1MFDzpbTl
         WfpvJqW2zqBptgO7NlLlXSIUrbqIPlQMaUbjLCSki6PXuo26Zkdk16uKb8czWDxWkCzJ
         leIUkXfF6YNRMUrIy3NcPHxB0UcOp67MvU453bUMP5QySfgEy9rS+q8F669yqEy6IDT8
         18Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUchBn3o6dz2EhZbsvgniiFwNywHGbznNzBoQgj0wygAO1YWb59uPEJUnPCsoTj6TBqWsJjH4az/HI70qN8d6vlXVA+Vy8O
X-Gm-Message-State: AOJu0YxxZeJ75gOAhVIUn05QlxjU2IWX5aFXAVT0I+J2SvhIECe8RyL4
	uI9/ZfDiiRJsEIcQ9TAAuBSgPG3LJsOuE/QG23GqbkzM9E6uRKwcvVT3EvG1qAQ=
X-Google-Smtp-Source: AGHT+IGbz2BoQV9Ez20Shd8cCQe9nGOKFy5qNg6HM1/3gTdWi8yAkPwGtaQ5JUDDSmT788+wwf7dlg==
X-Received: by 2002:a17:907:e8b:b0:a72:7fea:5800 with SMTP id a640c23a62f3a-a7d401c23ccmr805505866b.63.1722416482031;
        Wed, 31 Jul 2024 02:01:22 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:82d:3bb6:71fa:929f? ([2620:10d:c092:500::4:457])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad411d2sm744488866b.126.2024.07.31.02.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 02:01:21 -0700 (PDT)
Message-ID: <99ab4cee-4b70-4e5e-91ca-4b363cbe5f30@davidwei.uk>
Date: Wed, 31 Jul 2024 10:01:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/3] bnxt_en: Add support to call FW to update
 a VNIC
Content-Language: en-GB
To: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Michael Chan <michael.chan@broadcom.com>
References: <20240729205459.2583533-1-dw@davidwei.uk>
 <20240729205459.2583533-2-dw@davidwei.uk>
 <dc1a31a2-a414-43ff-a5dc-1c75a5a80e2d@intel.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <dc1a31a2-a414-43ff-a5dc-1c75a5a80e2d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-30 11:24, Wojciech Drewek wrote:
> 
> 
> On 29.07.2024 22:54, David Wei wrote:
>> From: Michael Chan <michael.chan@broadcom.com>
>>
>> Add the HWRM_VNIC_UPDATE message structures and the function to
>> send the message to firmware.  This message can be used when
>> disabling and enabling a receive ring within a VNIC.  The mru
>> which is the maximum receive size of packets received by the
>> VNIC can be updated.
>>
>> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 23 +++++++++++-
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++
>>  drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 37 +++++++++++++++++++
>>  3 files changed, 62 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index ffa74c26ee53..8822d7a17fbf 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -6579,7 +6579,8 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>>  	req->dflt_ring_grp = cpu_to_le16(bp->grp_info[grp_idx].fw_grp_id);
>>  	req->lb_rule = cpu_to_le16(0xffff);
>>  vnic_mru:
>> -	req->mru = cpu_to_le16(bp->dev->mtu + ETH_HLEN + VLAN_HLEN);
>> +	vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
>> +	req->mru = cpu_to_le16(vnic->mru);
> 
> These changes seems unrelated to the topic of the patch IMO.
> This goal of this patch is to introduce the new firmware command that
> will be used later, if I understand correctly. Maybe those lines should be
> introduced in one of the later patches.

That's fair. I took the patch wholesale from Michael. Happy to split it
into another patch.

> 
>>  
>>  	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
>>  #ifdef CONFIG_BNXT_SRIOV
>> @@ -10086,6 +10087,26 @@ static int __bnxt_setup_vnic(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>>  	return rc;
>>  }
>>  
>> +int bnxt_hwrm_vnic_update(struct bnxt *bp, struct bnxt_vnic_info *vnic,
>> +			  u8 valid)
>> +{
>> +	struct hwrm_vnic_update_input *req;
>> +	int rc;
>> +
>> +	rc = hwrm_req_init(bp, req, HWRM_VNIC_UPDATE);
>> +	if (rc)
>> +		return rc;
>> +
>> +	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
>> +
>> +	if (valid & VNIC_UPDATE_REQ_ENABLES_MRU_VALID)
>> +		req->mru = cpu_to_le16(vnic->mru);
>> +
>> +	req->enables = cpu_to_le32(valid);
>> +
>> +	return hwrm_req_send(bp, req);
>> +}
>> +
>>  int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>>  {
>>  	int rc;
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> index 6bbdc718c3a7..5de67f718993 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> @@ -1250,6 +1250,7 @@ struct bnxt_vnic_info {
>>  #define BNXT_MAX_CTX_PER_VNIC	8
>>  	u16		fw_rss_cos_lb_ctx[BNXT_MAX_CTX_PER_VNIC];
>>  	u16		fw_l2_ctx_id;
>> +	u16		mru;
>>  #define BNXT_MAX_UC_ADDRS	4
>>  	struct bnxt_l2_filter *l2_filters[BNXT_MAX_UC_ADDRS];
>>  				/* index 0 always dev_addr */
>> @@ -2838,6 +2839,8 @@ int bnxt_hwrm_free_wol_fltr(struct bnxt *bp);
>>  int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all);
>>  int bnxt_hwrm_func_qcaps(struct bnxt *bp);
>>  int bnxt_hwrm_fw_set_time(struct bnxt *);
>> +int bnxt_hwrm_vnic_update(struct bnxt *bp, struct bnxt_vnic_info *vnic,
>> +			  u8 valid);
>>  int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
>>  int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
>>  void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
>> index f219709f9563..933f48a62586 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
>> @@ -6510,6 +6510,43 @@ struct hwrm_vnic_alloc_output {
>>  	u8	valid;
>>  };
>>  
>> +/* hwrm_vnic_update_input (size:256b/32B) */
>> +struct hwrm_vnic_update_input {
>> +	__le16	req_type;
>> +	__le16	cmpl_ring;
>> +	__le16	seq_id;
>> +	__le16	target_id;
>> +	__le64	resp_addr;
>> +	__le32	vnic_id;
>> +	__le32	enables;
>> +	#define VNIC_UPDATE_REQ_ENABLES_VNIC_STATE_VALID               0x1UL
>> +	#define VNIC_UPDATE_REQ_ENABLES_MRU_VALID                      0x2UL
>> +	#define VNIC_UPDATE_REQ_ENABLES_METADATA_FORMAT_TYPE_VALID     0x4UL
>> +	u8	vnic_state;
>> +	#define VNIC_UPDATE_REQ_VNIC_STATE_NORMAL 0x0UL
>> +	#define VNIC_UPDATE_REQ_VNIC_STATE_DROP   0x1UL
>> +	#define VNIC_UPDATE_REQ_VNIC_STATE_LAST  VNIC_UPDATE_REQ_VNIC_STATE_DROP
>> +	u8	metadata_format_type;
>> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_0 0x0UL
>> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_1 0x1UL
>> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_2 0x2UL
>> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_3 0x3UL
>> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_4 0x4UL
>> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_LAST VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_4
>> +	__le16	mru;
>> +	u8	unused_1[4];
>> +};
>> +
>> +/* hwrm_vnic_update_output (size:128b/16B) */
>> +struct hwrm_vnic_update_output {
>> +	__le16	error_code;
>> +	__le16	req_type;
>> +	__le16	seq_id;
>> +	__le16	resp_len;
>> +	u8	unused_0[7];
>> +	u8	valid;
>> +};
>> +
>>  /* hwrm_vnic_free_input (size:192b/24B) */
>>  struct hwrm_vnic_free_input {
>>  	__le16	req_type;

