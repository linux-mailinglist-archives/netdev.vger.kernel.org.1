Return-Path: <netdev+bounces-225665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E5FB96AEC
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C29416F91C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E426926D4D4;
	Tue, 23 Sep 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="n7hCF2Xt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FC26B2D2
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643087; cv=none; b=XRI2y6qyx1y604w9K4YEfjbkMku1EymJsWn8S90k5iYQ6mjozoXm7u4Pn1Uu1gHhH65qB1rGoeECfDp0A0GM1Ap38hoZc1fHSGRL9XxxjTwMXLkztVJzVBoE5r8/rl/NEtBAW0nV3/ydjotcpoIBpgD5iKGt32yu7iwUcD7HwsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643087; c=relaxed/simple;
	bh=rPlEGrL2pSsOp2Ur1sQTwPfwBtQuV96uTVhhnTcOo34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6FoSZt6r1PMequxxWodDXEmrXXNU+W5kt2haPk+Wel2E+ExUNFXugDuJgrbr/8Fec/69HP+g+1ELfTPecoq1KTsom0I9DYi+tv1T4aNCcWQMhtvflzMF11155LdkcbxFfanlM4VCPvhU1oILQG2yD7kw15MkCPK6CAwkiibcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=n7hCF2Xt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f0efd84abso2964140b3a.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643086; x=1759247886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/JqpgYOrCxMsYzwby8uwVZtPIWnLh7RtxpA1RDm/gA=;
        b=n7hCF2XtSslpOewvTcBasezpcKsQfHWLTBXGygnxA0JTJV3fjO14jhMBusJl0RabDT
         EgCZem37hXv7hqkjoeykfgudItEE6w8DjBwM4hjlsPk8uCAeYUSEaEsmrRK96kQR57vJ
         cC5k0cEbhmVRs8myeC7abPwmDDrlrOS3BAZTUXn0Wp9uQQOtRhP0p2xqBYE3RmQ3OhN+
         UE5fBgGknXIYDRZ8dKjkhIoLXw9MPVNYc4TH6RewJKWIjwvigwwTsMQTpJIZErpee3uG
         Kn8ZR4TD0O1Xua65a4+sxkPextw+hbxIIKrMM/3hvHWJ7ehNhyZp7psqA8HOXjPMGt3Z
         mpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643086; x=1759247886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/JqpgYOrCxMsYzwby8uwVZtPIWnLh7RtxpA1RDm/gA=;
        b=WMMaKhVCmdqbeb9sB/H+yLF7KScBX2LsqOx7huiOAB/6MVHhmMBXLq4XjX4EzlO1ku
         ynWC8RkB9LUGHcHydzr1XhodDPeHkHIrsS6D/JyS1pBpOhn76XdZfPM58hNSF13nZrWA
         /76Vk8WzthPRGzSkKbeyqOWbiZej5AzMfmAdQX56yM0R+ZOAxeLQATxIgEHXYGzoHFHG
         PXjG3Ai0S6NFgRNo7kCkMigAIoS57HyrQQZQW0xVGxkE0/89gbnDnf1e9eXRN8NgR4Dh
         ttCPCFrQESLRbqGQ11SXjOMWw76AXJtAqeuCOyFZrNxq+citFW0O8JLotqtgzoIL/Wtk
         R0Xw==
X-Gm-Message-State: AOJu0Yz5jx7qbZYKkbj8Iny2kSaccbjRkfuhu3i9eTeE21/0w/C+tDcd
	GmLs9uaftNj/Xw9OS1sVgCXm6ngcNbCKK7Gksh3+BrAWlUvT4oceEPHrE7/jeQJpK9M=
X-Gm-Gg: ASbGnctzkUC8B/dRnDOCuCEedesJq/ruR3ag9O9/lCdcbVAmOENeJ9rW/kN8wxAmorP
	1pe7CcnAz4DabCiLEJs54rhqOdqaP+29DgrI39AOBUcvnE5lRsJdS5kYx1kxMMtjUIfk7HSc7bo
	mHo0obPEmoG0IS+dBzb9tE+N5Cvo7NhwjpPZ0Py51aC059Reozvr/R2EYlUtZcS69F2xFNVcDVU
	5NFzw97ay2gRphU4f9/GngoVU5MKgegiTCPT4KCre6DgWNcJlnVVNWXeGbkJMq6ZNjFkSLNOMOB
	4yRgjqMvIVJweQbmft3bwW6DQ+l9Zn6O7GR8s3a/GKfqUdL5US0WfZMa9VuMlK3ZTG8nqrBhTO1
	/c2LmsY2WHy6Vs5jR+3mly/2qcZ7k7qoCAfHsu/DdhxoLomxhw2hsm8ORjy4D8kOdgmt/HA==
X-Google-Smtp-Source: AGHT+IFCcRtj0+HKM0frArQ32BTYMbiJqh2ZgWGCXPfVCoshw0GKNKHvIU5ZFdNPv+sMiGIxtX/iJQ==
X-Received: by 2002:a05:6a00:391b:b0:776:130f:e1a1 with SMTP id d2e1a72fcca58-77f537f4668mr3580539b3a.5.1758643085558;
        Tue, 23 Sep 2025 08:58:05 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f23d92ef0sm8780103b3a.102.2025.09.23.08.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:58:05 -0700 (PDT)
Message-ID: <32b82a8f-2c81-41ee-804d-83ee847a27f0@davidwei.uk>
Date: Tue, 23 Sep 2025 08:58:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/20] net: Add ndo_queue_create callback
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-4-daniel@iogearbox.net> <aNFzlHafjUFOvkG3@mini-arch>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aNFzlHafjUFOvkG3@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 09:04, Stanislav Fomichev wrote:
> On 09/19, Daniel Borkmann wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> Add ndo_queue_create() to netdev_queue_mgmt_ops that will create a new
>> rxq specifically for mapping to a real rxq. The intent is for only
>> virtual netdevs i.e. netkit and veth to implement this ndo. This will
>> be called from ynl netdev fam bind-queue op to atomically create a
>> mapped rxq and bind it to a real rxq.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   include/net/netdev_queues.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
>> index cd00e0406cf4..6b0d2416728d 100644
>> --- a/include/net/netdev_queues.h
>> +++ b/include/net/netdev_queues.h
>> @@ -149,6 +149,7 @@ struct netdev_queue_mgmt_ops {
>>   						  int idx);
>>   	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
>>   							 int idx);
>> +	int			(*ndo_queue_create)(struct net_device *dev);
> 
> kdoc is missing

Will add. This was meant to be an RFC so I didn't write one - then it
became a proper patchset.

