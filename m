Return-Path: <netdev+bounces-189132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D9AB090E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 06:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150951B6377E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 04:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896423D29F;
	Fri,  9 May 2025 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="H78EiTAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4751D7985
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746763816; cv=none; b=RkfFYAjNsug0Se+9MPSsc/rZc1um3nXY8uhY5mO0nbHig7ZxFRelXUrglFQFwedHhOQD6/MQbWmWR/t7RQw3n5pXfWvbMtcmJNvcp3clYhg4cfAM9BtF2sVhNcZCLPH3hBvqPQOpyFpw/nZPN8N6Eb+2zdZ3S3JZvnIO5USVwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746763816; c=relaxed/simple;
	bh=qn0j00Q4lWXNjM61TVOR73jQu4hSjMBc//b4ByjjlDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcIsQEACqXxHHGUc7McpjPE71fP4EIEkj5jNqDWTpM8VqBoMfjZ/CMrw58oHJe2KLQrNCaIW5DrINNTi/SjoH2knYCemdI9SuIe1s4IOPNERvyDInJBjuoak4e4gpBp72JvONPYQudz8piWknLQNzgJwgdOEyWe8ULGBSFlufYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=H78EiTAG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b1f7357b5b6so1071691a12.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 21:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746763814; x=1747368614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOPt985lsryufrF2f8Rp/LqwNq9TFhhzPNpr6WI7mLk=;
        b=H78EiTAGBP/eSZtpKU4O7AkmbB7c0NwV4GOoLa6j98Z8i5LuY846ffMW9OvosBR57E
         7pTiLxd5Rcpj7vhvmMtlZsQjGkYA3mpJknQThjvk64fpQQq/MA6wOE4xs1smA37QalR4
         t0YLmgoGt6DYQSrleEY14yvZ9E3tW3CS8JFtThPBb4HvE/c6yd8W33X40gDztNwmHbgz
         KBY8dGLlJQEEmfrAPTkQLC2TRl7bwgL7QONB7DsHu7L/RF2N85KiAdiprebR9Wvc2X5+
         +CUfqo9bFSWXa0Z7xyRrKlSHP5KjjYVyvDsGTCfEtyueRVSBPiAHaKerJ1LIBWIKdLa9
         MrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746763814; x=1747368614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOPt985lsryufrF2f8Rp/LqwNq9TFhhzPNpr6WI7mLk=;
        b=vC2EeyvikVKetgUD8ukC6MHZrfGVdJP2rNO3QHWecaKWK/Syd13JHZkFvCXR/1Pv4v
         M9fcW4OUPZXjUgpvP4ZWnvrVfo2qhgPCwwhffcv5bl0Jg/BtOdC9rVBXBB/jE1BfgGJt
         QJqRzR3aArWVU5yqvASiv5MsxMOi1Pl/nrJYQE/yJcEM/PzTNyI9n4M1S4mb0WvrBrxZ
         F5h+AyjN/qhJcsn+FxdLUF6lQs1GdcFYNio89rJ+9ByoZtl7egfI8DsPUBHfJsnJV+21
         g8YsPA3482J3ol7EwKe3WmHZZqIIeZE27kNqgeNd7+6a1OwNEnaudCiq5FPszOfMct57
         Wkdg==
X-Forwarded-Encrypted: i=1; AJvYcCVUipfgM1i8ZFOKDGHR7FV5IZff2sndj16nCRigVHog28YRst4sTtMg0K4faytMg0JmPEcoQDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCaAkCuRAFoAUpWx5jm+ysuYNcpDHrEvAGAcGe0ur5O6gN3yy
	/dXIFNyx0mOiqXMNGbcqndPsWjI1DBW6zJaKsQKHRWW7mygkp/TvopTklCYcwWc=
X-Gm-Gg: ASbGncsMawqmTySWEQIY7ZkKtrF8qti8yWkDaSsTPZTK5CEon+iZjUG/nCOA2lbkzgW
	ETyWmJun+axuL8VZ4A5L1G7z6XV2IzDS69ZYOA2tAyjaSVFpMf1MUbl4us+HfcoyjQfSGhTuepU
	A1FHuOTP7lL3yeJrW3z8VYWWLpgfZMcgoedMDTsvxntFpy5J/iHo7c2yr0ibnP5CNZwkoghjPmg
	hd11s5YX7eHXkLqLBGbZIFyhmXpDfhaHK2+DuxtSnaz6F/CneFrlUDXXzcGb0PlnMIXGljIfGgE
	iNh1G89r3i6XiXfJ4jpjSIbGeP7h1Nwx6e/NGogCwq974HY=
X-Google-Smtp-Source: AGHT+IGld+rlMK8n8nhzZTd9tL87p1xppP25t3sLIo0ygGvlHlV56UBGyyKEeAa17jr3ahMyKHEBTw==
X-Received: by 2002:a17:902:ea0c:b0:22e:17ac:9dd8 with SMTP id d9443c01a7336-22fc8c7d71emr24684365ad.29.1746763814065;
        Thu, 08 May 2025 21:10:14 -0700 (PDT)
Received: from [192.168.1.21] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc773ee47sm8139185ad.63.2025.05.08.21.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 21:10:13 -0700 (PDT)
Message-ID: <d8693a9b-697a-49d7-a064-fc7349ec2d63@davidwei.uk>
Date: Thu, 8 May 2025 21:10:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: ping: make sure the ping
 test restores checksum offload
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250508214005.1518013-1-kuba@kernel.org>
 <e339c382-c0f5-40dd-994e-34b388c68181@davidwei.uk>
 <20250508183736.74707daf@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250508183736.74707daf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/25 18:37, Jakub Kicinski wrote:
> On Thu, 8 May 2025 14:59:12 -0700 David Wei wrote:
>>> +def _schedule_checksum_reset(cfg, netnl) -> None:
>>> +    features = ethtool(f"-k {cfg.ifname}", json=True)
>>> +    setting = ""
>>> +    for side in ["tx", "rx"]:
>>> +        f = features[0][side + "-checksumming"]
>>> +        if not f["fixed"]:
>>
>> I checked and found that "fixed" is a ternary:
>>
>>           "rx-checksumming": {
>>               "active": true,
>>               "fixed": false,
>>               "requested": true
>>           },
>>           "tx-checksumming": {
>>               "active": true,
>>               "fixed": null,
>>               "requested": null
>>           },
>>
>> Python loads this JSON as False and None types respectively, and `not
>> f["fixed"]` is true for both False and None. Maybe this doesn't matter
>> but flagging it.
> 
> I think so, yes.
> 
>>> +            setting += " " + side
>>> +            setting += " " + ("on" if f["requested"] or f["active"] else "off")
>>> +    defer(ethtool, f" -K {cfg.ifname} " + setting)
>>
>> This does rx/tx-gro too even if not explicitly requested. I assume that
>> is okay?
> 
> You mean because those are automatically updated when we change
> checksumming? If so then yes.

Thanks for responding.

Reviewed-by: David Wei <dw@davidwei.uk>

