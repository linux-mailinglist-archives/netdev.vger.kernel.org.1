Return-Path: <netdev+bounces-225664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDC8B96AD4
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFEB3BA6C2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF3526A0DB;
	Tue, 23 Sep 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="gfzEc6Sz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562E2638BC
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642987; cv=none; b=sKiUphga1VTTSJzNA0KrUofYCJTEMFng0kml4k06uQKAo1Ml4AY1PI6q+0VAlnZE5Q8cZjlsAo4HcA+E1/UCTDqHJRFOOGr4U3KV2psJ4T242W2IYYBqY4LWDhrz3erUkqOCvHkeh+8aMns71iuquOcYbOGmvkmZev9uEJ+feLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642987; c=relaxed/simple;
	bh=24dum0ijhJnu6ePvSmObRqgFJHuL0BLgVAjytG32+7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akbJEQolKmm6ndVyQNRZzUFP5j1F3jTJLrHcnBWPTCgifVoDb86nhRkR4ehSi74s44SILimCiCv4FSBZnWz0RTE0ORRhlIoAKNPcMDPF/jsLJdCbPbxDZs4aGRvDSar3Wgd9mJsCKPK1DZG66dXX+nOEoAtOc8IEqktUMWJj5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=gfzEc6Sz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25669596921so61956575ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758642985; x=1759247785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nwSrTvN2VNXYHNmWzJtwrK6x+LOTPWaZZ6+ulddIfs=;
        b=gfzEc6SzY9UnlrONyrMESsg6uUhnhFAPDSY0lH3B2BNQQTwhHtshKR59Ar0J8dq74I
         E22wFJIvk2qOIe37v61+Gr4XEzR5sh/ZRBkMgjAgHrUAmoNuKd5h1NFz1YLBl8nAwaxM
         wT4ZiM0FqAOaa8I2Vd/RX5OOTJN0PFUIyW3IkMltZsHpDBilhN+JNw5mY5nrIUqV+0MI
         jazbt9bzKGk0v9nNnxbnZrVn6odbgwK8GXHVhboDbUwrSN1fOmnJBQbgQxicjvBst1c0
         X1SF0IARBGv7EqbzBL0nqmAmvDihgNplS5JJbscxxlpJTJ7/OzqWWJx8FtOhBdXCJui/
         86lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642985; x=1759247785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nwSrTvN2VNXYHNmWzJtwrK6x+LOTPWaZZ6+ulddIfs=;
        b=bWG248xyevC8+trNG1oDQ8KvxP0xY3vJxLfZ/o5BDQ+TKTKSnknmSaKMUKeShCTDWs
         vvgE2Sj1bgYNlN5Q8xPibNjXs67hMEwY2pkl7pQLPeAZ5XFzpl8TNSLWkTuo0f7hRc8t
         mMjxc2MYtXSxU2TvBc4HU2C5Kr0cPiDpTJKUcytw1VOL9wmwtArAFBWr5jfNjBq0BRVP
         PpFMp8+rjWfipZdGA9V7u6+e8ZiNXLBeJ8GetpFlqBpvgL4/xFBghxm87st3y9QukOhL
         bYI33teCtM7HJCQ9tFN5JTWWMf+Cc94AHnjO/VkDwmg2zt1hvnfII5spnYCI/UYtIzT5
         1wnQ==
X-Gm-Message-State: AOJu0YyBCmrlbq/N260FY477lBY63Zv75pG/2uNn8MIKVpViV6/aBYKC
	SQp16qFWLDQKtWmZzFx7NsVvaXvmGZH9pCp7qqFaNJ6OgcxAI3jKFviPahL9Eq3rids=
X-Gm-Gg: ASbGncv0JeTBxLRxl22fWlXYT0F2iGqW6ahEnL4J7vuOH9UlxsZuutzBqbbXXO0eFPA
	ncn5bR8aMwxjLQSMOnr1R4RfAOvXmVpfAu/7SgQjlviOGHlY9m89gwGyDqBZqxCaGRXgrNX8vBe
	ior9Jq/fBfk+O/Kf2bCb3W8vTdgqlp/YV0mUvbmMo+Bl/q7uhVNh3AXVm51O2gdaPNkOmiIsCzG
	onoru+ND9yE+Npbx/DRDM4Q5iJQfVIR+HVMnWV8WM2v1ah9UO4IsZ33OVAZrN/nbbuwEoJ6yARU
	nrV2+ypOph6CcKgB5PYHJ072ZaBOaqcDSH2XOXwwGsXnPun9rPCE2w9tMwYoqfCCJfoHc4MPJTP
	kkAy6xE6JLvP/HIPX3Ox7ZSoulVOFDv0Wxor4vpfyyRR33fx1tFfAhVqt657nZ4hQ3547ow==
X-Google-Smtp-Source: AGHT+IFt/lLckbXIk4AhQ3RI6D1iZSj4v6/TAAq2BXRQ0ewdQQB8SsyJRKxkDgxe+L8RmLxPzQkRyw==
X-Received: by 2002:a17:902:f541:b0:264:f714:8dce with SMTP id d9443c01a7336-27cc48a091fmr44137135ad.36.1758642984930;
        Tue, 23 Sep 2025 08:56:24 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033d788sm166660495ad.127.2025.09.23.08.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:56:24 -0700 (PDT)
Message-ID: <edc230c2-1079-4439-8bb8-ac73135c8f7e@davidwei.uk>
Date: Tue, 23 Sep 2025 08:56:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/20] net: Add peer to netdev_rx_queue
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-3-daniel@iogearbox.net>
 <20250922182207.1121556a@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922182207.1121556a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:22, Jakub Kicinski wrote:
> On Fri, 19 Sep 2025 23:31:35 +0200 Daniel Borkmann wrote:
>> +static inline void netdev_rx_queue_peer(struct net_device *src_dev,
>> +					struct netdev_rx_queue *src_rxq,
>> +					struct netdev_rx_queue *dst_rxq)
>> +{
>> +	dev_hold(src_dev);
> 
> netdev_hold() is required for all new code

Got it, will update.

> 
>> +	__netdev_rx_queue_peer(src_rxq, dst_rxq);
> 
> Also please avoid static inlines if you need to call a func from
> another header. It complicates header dependencies.

Didn't know this, thanks, will fix.

