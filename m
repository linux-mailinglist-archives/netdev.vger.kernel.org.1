Return-Path: <netdev+bounces-208109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB7FB09EB1
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165ED1C446D1
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE02295531;
	Fri, 18 Jul 2025 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAKsCNRb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852D293C71
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829778; cv=none; b=mzT/PEVWeEvLJ5nLzNVEt5SDOSZd3v074PMYkR8c0QwcktMK+hMSKrp098/MtK5DVi+v1PzJV+C1zJJkMuqofd4BvqGBFh2s3kZPBEgC85wnozOMLpJjhpejo9w6Kqto5TyCLHrLPUo6Cv1llNMiZLnxd2/qFbRwrFF3FiQa+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829778; c=relaxed/simple;
	bh=UtCb0XEENQrhwIrwSyIf3fzwd5mpbrwW2EYLLnWjwOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDQHVapqLDMhFyJNbki2N82jXgvq3PbYqJepPTaYOHBfWjq0WqtNN8Dx6ILDJpmbsh6yKos+rkDGfHIdPIccmv5Dre7LiWqt8QsSHQ+4oPGFnrunhuPBkKCRmZsacHRsU27TanXi0Fc98HBy8nrtv6JM2P6+CbeLBMXFUqM54pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAKsCNRb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752829775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLyNWUZYLntH6kzg6fsWrkbR7v6uvcRiHtF10eyX+X4=;
	b=PAKsCNRb7DyPDRIesa5Ups8UWhE+kn4UMy1OuBKP+lWtuqHqN9Kw3WW9el71bnVatjt36V
	dLaNuM/t6FR91CPw8258Ikr8GYbBvozv780ELYDYO0SA3d7xbp0816X2lriwv0mLTMuc6U
	8jb5W4CSyonFcwOHgnUcNtjbKj4n4bI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-hyThFg0SOjybrtKaiCdWUw-1; Fri, 18 Jul 2025 05:09:32 -0400
X-MC-Unique: hyThFg0SOjybrtKaiCdWUw-1
X-Mimecast-MFC-AGG-ID: hyThFg0SOjybrtKaiCdWUw_1752829771
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-456013b59c1so11441405e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 02:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752829771; x=1753434571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLyNWUZYLntH6kzg6fsWrkbR7v6uvcRiHtF10eyX+X4=;
        b=bGb97tbVqwZTlMNW/72qbMSwGQeNTBZkE6ynZnCXX5//D24i1DKsPhREA7zycwF/xO
         MVVKAa6qZBZwZ0239dfRq3cFgDFdUOPwNAyhi9T9pg/gEFBuAIkUubX0tJrU1Lhf3mjX
         ReuAqg5Uk/7m3ASQ1gnCbKZz9mAE+Nq8uz5zyx4h6qjfM1Y/Cg/9cHUC1GroVt5e7vwv
         +S7fR1dMSpdP1EFL4GxeBDVgXYV4sbgCzhXaCCXXtpUiofQpm56joE9Z+63F6n0u4Xmh
         tgGMVJOYSp07UqcCAyQPomwH2icXyHvZxT5NEQWOz99F52X4eRj8dsCKGM8/5Og4TQep
         HrIw==
X-Forwarded-Encrypted: i=1; AJvYcCV0lBJQPYNCS4AHSNcEdOhdL+Dp8rudU8V7oxHwbC2tlJZhv5wDIKVei4en01JYE0XzOSnLQRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMPIM8uGTAhrFYDRuNl0xleWy5CGamkcIKANvn9wYpkIn2Ggq
	CkoI8I8ptOUSZDdlnEHQKB7x6QDuhg/O+G9QlWm0aRlNWh0ww+1H6etQYNyCIVSXZf5zYUZRAR0
	BsJFKv2/nV3xUsJPSfDTIN4GdOWO49w2X1YNIpjgQqSUmQ3hIIMn8DLOX3w==
X-Gm-Gg: ASbGnctbiDrDF1KTkRWpUCCRQc5DuO2ZpilwtPc+qBJfxdzQi/pLvQp1dtLMOemKXyf
	kSdmTuteTi2/CZXwog/LwYjUbu8nd1A6A8Gqd5Pj+8gaOFpU3djX1XUl3WwClNfGNXerkNNrOYh
	PpVsuWS7fPxELTNFE51yk3bS7XYT6Sscbgm6kdfxjte8tuKiebe1V06QpGfWMaoREk5nimT+YxS
	mIG9CK887iQldsPkjF/NjXYehua/trGml32a0V6LZmbmgTuNhu6fu1K+67AVjsTBeKPFTG6oWPa
	1cqRPYWNu9vxLN36MlTLTtf78MQXPkwXn4i0z+3Lz2TuCYgMiFgqGojouf3cyXhMhVhkh2BhyYl
	A1ShldAVeQ0g=
X-Received: by 2002:a05:600c:4709:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-4562e32e598mr89675325e9.4.1752829770943;
        Fri, 18 Jul 2025 02:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGN/Cv3drNsF8UaKNdX/NfxKGTgGum22Q8FGNtEDQQFlxthmY+ud4BApn5/n0KWmB/pCzOcw==
X-Received: by 2002:a05:600c:4709:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-4562e32e598mr89674875e9.4.1752829770415;
        Fri, 18 Jul 2025 02:09:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e818525sm72859355e9.16.2025.07.18.02.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:09:29 -0700 (PDT)
Message-ID: <0becc009-68a8-452f-9115-a5df3ca998ed@redhat.com>
Date: Fri, 18 Jul 2025 11:09:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Support getcyclesx and
 getcrosscycles
To: Carolina Jubran <cjubran@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <1752556533-39218-4-git-send-email-tariqt@nvidia.com>
 <650be1b7-a175-4e89-b7ea-808ec0d2a8b3@redhat.com>
 <4b81bea4-ef05-4801-8903-2affa02d2366@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4b81bea4-ef05-4801-8903-2affa02d2366@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/17/25 5:56 PM, Carolina Jubran wrote:
> On 17/07/2025 13:55, Paolo Abeni wrote:
>> On 7/15/25 7:15 AM, Tariq Toukan wrote:
>>> From: Carolina Jubran <cjubran@nvidia.com>
>>>
>>> Implement the getcyclesx64 and getcrosscycles callbacks in ptp_info to
>>> expose the device’s raw free-running counter.
>>>
>>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>> ---
>>>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 74 ++++++++++++++++++-
>>>   1 file changed, 73 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> index b1e2deeefc0c..2f75726674a9 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> @@ -306,6 +306,23 @@ static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
>>>   	return 0;
>>>   }
>>>   
>>> +static int
>>> +mlx5_mtctr_syncdevicecyclestime(ktime_t *device_time,
>>> +				struct system_counterval_t *sys_counterval,
>>> +				void *ctx)
>>> +{
>>> +	struct mlx5_core_dev *mdev = ctx;
>>> +	u64 device;
>>> +	int err;
>>> +
>>> +	err = mlx5_mtctr_read(mdev, false, sys_counterval, &device);
>>> +	if (err)
>>> +		return err;
>>> +	*device_time = ns_to_ktime(device);
>>
>> If the goal is providing a raw cycle counter, why still using a timespec
>> to the user space? A plain u64 would possibly be less ambiguous.
>>
>> /P
>>
> 
> getcycles64 and getcrosscycles already return the cycle counter in a 
> timespec64/ktime format, so I kept the new ioctls consistent with them.

Ah, sorry I missed that context. Looks good to me than.

Thanks,

Paolo




