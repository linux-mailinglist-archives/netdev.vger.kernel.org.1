Return-Path: <netdev+bounces-86603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A8289F8D7
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4AA1C257B6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672D176FBF;
	Wed, 10 Apr 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RM9ATE6g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8816E86F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756574; cv=none; b=Uu2e8G5Pt3AiQJc5yTNpW9+5V8haXojYfQLnBKjzDI0xq+Xvn+DLhBnYVkg2AJOszhrz561pHDwvEOTKushrGADZ5VHX7GrMCjef/EThpnysGoqea/moD+1i2MAXNUvXbj/FvHaEm8ZZqbcUBDNnnBpDuSAOOKSaF/qAPe4rL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756574; c=relaxed/simple;
	bh=eNsHgwnIwZlmukwZMuadRrSLdurGBd0+7MBUi/2z4RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4hW+1cR8HbixeFw4j0mR0uaNmauwIjzhIM2S827hv19CY1uNe4ReDltviaB26KXCWXldVmh5nEF8XUrQRSgNO34xPVwOXP9OTesHoFRzFY5LiYY3fpC1bpj4w/81AIZzjBvooWfKVa9gcPcm3xkPFZTxwHgEI0lcs4qCa/PeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RM9ATE6g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712756571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqc/7GCInaMvbYsjA1Nvc7z+2sGcqlnjfpQ+e04yCVc=;
	b=RM9ATE6gBaCAXH+5pqYlMyKNutcHDF+cxVqV86us15EZlhLmOqRfxUXHZpQwjtyVo11Mwa
	+q7LECMJxOcxeVaqUdiLPWVsIFvVBX47dSFIJO6ogqPF6kBBhhanAJi6hyTTYtbUrXs7El
	jk8WydeURpt811SN9luLl/wBD87hLKE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-SLa2C9mKPGOVk_sEg3bEvw-1; Wed, 10 Apr 2024 09:42:50 -0400
X-MC-Unique: SLa2C9mKPGOVk_sEg3bEvw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78d39e930c7so902461185a.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756570; x=1713361370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqc/7GCInaMvbYsjA1Nvc7z+2sGcqlnjfpQ+e04yCVc=;
        b=afwgpg9l55SvejnYwn6ViLjnnWmjc7p2iwtbc8OJ8TwWRS3k0ND23LAnLtzPjeqd0Y
         sX7wFool0dsCT4SI3gL7tZkTFGr6xiejyJRd/rPdA5KhBJICMDLAISI/eOfsy/DqPrIa
         uSqpuVPLT+tN1l6IBGXQFh0WdDUi4zgqPYmUKt+B4lI+g3CDMfiC3YYUxlQ/AiwNdGrS
         TmVz6sc54Me21yms/ZomOw8sRjVTjVnzuHqt3x5lZ/QVSlXo7X16LJuYl/5TX9AuODtq
         FDiPn1TcjkU8xDEPV2jvjS5j0LAMAuOfkUYEiC7Ys1DEHeHBDhCcyr5mhRCXAo5hGMZx
         9Z1Q==
X-Gm-Message-State: AOJu0YwMfND0XKNSns/rCuYhz/TEI3CdQW87f5zwfPJBUWPoAr+5Btqq
	R6HBsp31jy+LxikfHEGrjHrbmb0M7nh98R5wRS4LzbTaWcqNhGD9Ek9kbexWmpHYkIbznilSNKP
	Z/eURwp2sAWg1l/S9T1UmR8RTQ+4vn55S1e/77ebJa8qOVQqzUs+7Vg==
X-Received: by 2002:a05:620a:479b:b0:78d:5d4d:f209 with SMTP id dt27-20020a05620a479b00b0078d5d4df209mr2856028qkb.66.1712756569797;
        Wed, 10 Apr 2024 06:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe2zO5Q98w8jboI94sej6BzTbZaTerx4ek4c9/bpQg7IGtE7xBdAJD7jgkg/phVKKB4ntcSA==
X-Received: by 2002:a05:620a:479b:b0:78d:5d4d:f209 with SMTP id dt27-20020a05620a479b00b0078d5d4df209mr2856013qkb.66.1712756569531;
        Wed, 10 Apr 2024 06:42:49 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.208.51])
        by smtp.gmail.com with ESMTPSA id t30-20020a05620a035e00b0078d74f1d3c8sm1326600qkm.110.2024.04.10.06.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:42:49 -0700 (PDT)
Message-ID: <bc05f7f9-79d2-40a5-bede-d9ad9d1b0825@redhat.com>
Date: Wed, 10 Apr 2024 15:42:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 2/5] net: psample: add multicast filtering on
 group_id
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 cmi@nvidia.com, yotam.gi@gmail.com, i.maximets@ovn.org, aconole@redhat.com,
 echaudro@redhat.com, horms@kernel.org
References: <20240408125753.470419-1-amorenoz@redhat.com>
 <20240408125753.470419-3-amorenoz@redhat.com> <ZhaO8bOQ6Bm0Uh1H@shredder>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <ZhaO8bOQ6Bm0Uh1H@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 15:06, Ido Schimmel wrote:
> On Mon, Apr 08, 2024 at 02:57:41PM +0200, Adrian Moreno wrote:
>> Packet samples can come from several places (e.g: different tc sample
>> actions), typically using the sample group (PSAMPLE_ATTR_SAMPLE_GROUP)
>> to differentiate them.
>>
>> Likewise, sample consumers that listen on the multicast group may only
>> be interested on a single group. However, they are currently forced to
>> receive all samples and discard the ones that are not relevant, causing
>> unnecessary overhead.
>>
>> Allow users to filter on the desired group_id by adding a new command
>> SAMPLE_FILTER_SET that can be used to pass the desired group id.
>> Store this filter on the per-socket private pointer and use it for
>> filtering multicasted samples.
> 
> Did you consider using BPF for this type of filtering instead of new
> uAPI?
>

Yes. I ended up going for a uAPI change because, since the group_id is part of 
the psample uAPI semantics, requiring users to load ebpf programs for that 
seemed a bit excessive. Given devlink already uses this mechanism [1], I thought 
it would make things easier for users that already just use netlink.

[1] https://lore.kernel.org/netdev/20231214181549.1270696-9-jiri@resnulli.us/

> See example here:
> https://github.com/Mellanox/libpsample/blob/master/src/psample.c#L290
> 


