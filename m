Return-Path: <netdev+bounces-188244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEF2AABC9E
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B04B1C412B8
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701454279;
	Tue,  6 May 2025 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJSlwgth"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C342A97;
	Tue,  6 May 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746518133; cv=none; b=hYrpxs6iasd4fzKuvE9+8SxJaz6Rgd9Hi4kCBAZ9g0B45eIP8m6lSKHf+gAeVODkCsu7LJfM04bh8KgrBnC3JZJgdIadz1cvIT++2rGqeMZRDThPtIVtyRoPBk9ONp/hnK0O1VkSW0mBBXdbXLa4Io24c28wRbhDBQCZj/gPDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746518133; c=relaxed/simple;
	bh=OPEQGm9twHkeLYvcOQQiJ+q57DW74pMD+FcroAYkp/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRjMidh/cp1Ly3juQo8OYZVXg4cwpvO/Xqss9hzOzVcVncFS2e/GOrs4pMSuHjOtrtsiYzsUpiy6HFeLXpjed96lO+6tWjZkjrh3T7ckRrGgF5a+LCRrJMpg96lD3PpaIrKxt8a+IS7+QBgb+xHftG+j0CuRdnQKkSyxDxbJMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJSlwgth; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30a509649e3so2930433a91.2;
        Tue, 06 May 2025 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746518131; x=1747122931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=66epj9ldhbkZiocYYYQJR85+8m9i5bAmQQnmrLIVqrk=;
        b=aJSlwgth7ryOBpZMtd44sbMnDl3uBenmANNes5w2N9CEaJ/qL0uBVmhvgET4nybt4X
         DqzZnaOQgMzldxy0BjMGB0lR+fEO1JEOjhNd+g1uKTp4AIWhgicpwNNcEcceY947p8sg
         aYaHPdwSuyV7HUr1clgvneLI0HrDHQuEjrbcy/EI1PTdiNAhG3mSkh6gUOPwIYYNruKR
         8dqXlcw8dWsuhf6yO0Q1QTQOIhJdi8VDagCvejfqqQeMp/Qep9vvNOO9o8lyTcQt5uUj
         HfAMOAJ8LBKdKD+sYrw3WrvGABVIux9E/8n4nr3YhoPCQXhYL8LkyqHD+Z4iUF/qZvF+
         Wc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746518131; x=1747122931;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66epj9ldhbkZiocYYYQJR85+8m9i5bAmQQnmrLIVqrk=;
        b=uBaLIvUq2XNhNLsKQGi8A5wkApywaj4CqaXDmAIp/82ygPJDLXq8t7Tza3Yo9jZqO3
         SoLBI8JaUT2ym7fobiihv0INT2DZPzqBiQQlvJj0MWVwjq+Ja5SZrKLwr2qJskl3/Mc6
         AT3tqrtO2B5Oi0GrOGrn+Q78IZJm3ZLT8e/zHkwOASh9IoFjFl3sLTm6D+u+dQIlk8xx
         zyUEP8sAnFcyqPlf2k3l3Dr35MLqaof+h58SgthJKydti1ybfAKGORgFcg0Wa8KIWfWN
         UVS0mDh94BMJqz4xLFhZOkUo+/qynjbgNBroaF3GFpF2UxvRAWICehZUUCo5XsNQOxn0
         jj9w==
X-Forwarded-Encrypted: i=1; AJvYcCVvK+8Yvtd6+t2YqnmpBu2vd6BWEVn+Y0556m/ZAFmKkyb9a/fFYO05YHbFpry/Z6MAqv+dmODJ+t2Z9I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJ8LxeOoS2gZDUaq8njFt+z1R9Pm9g5icm2tlM1FzfEbXrJj2
	I39tvDiJYH4w8K3DoSJrTxT+a64GWjCab70de0SMRIFnQz17i++q
X-Gm-Gg: ASbGnctMen5E1JD5YEmsc6GxkJ/qX05vVvpq/KOrPajvRtaB0d3n6YC1hqfZKnENE2T
	wu1UWEqY90TJ3EHCon1J9cv3ihQrs9drYbJCzXjhlV44FTuOpmzZqTaydQ/ujptyQ/6jyMYHZ99
	UrFM7LT5rlUqYaMzevomq+K0NzJNFzjsOUXlGovOQAoYMRNYXAeRhyJXMahCsz4cjgP3OanNFnK
	Ox7qvn5J1jdDlsjN31xeKgPCPzFwN7nFBF2bl3xfIJ70ppIGnqpYvOZ5L2ndHNqkFWfJg2tf3FB
	Lz7qePGvw15GkyOh9DdUyvqTYDHwDct6tYLllF/1SGbelqO+eg0pq1yl1MUR1HVM5sbRhdlPQ56
	NxI40NMTGrpdjqN0XCWFjvns7V/81BQ==
X-Google-Smtp-Source: AGHT+IF7FCujFKis/lz2bBHgYPvrTrY1yaAzTQ30k/86PIMZ+khZxcJApvcsDO6gUh+aARCiPhJuvg==
X-Received: by 2002:a17:90b:3b8b:b0:2ff:5a9d:937f with SMTP id 98e67ed59e1d1-30a7f32ccd0mr2796932a91.24.1746518130842;
        Tue, 06 May 2025 00:55:30 -0700 (PDT)
Received: from [192.168.1.123] (92-184-98-114.mobile.fr.orangecustomers.net. [92.184.98.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3476f51asm13247384a91.22.2025.05.06.00.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 00:55:29 -0700 (PDT)
Message-ID: <66917c53-3315-42a0-a301-1be2483efd5d@gmail.com>
Date: Tue, 6 May 2025 09:55:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 09/11] net: dsa: b53: fix toggling vlan_filtering
To: Paolo Abeni <pabeni@redhat.com>, Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
 <20250429201710.330937-10-jonas.gorski@gmail.com>
 <89c05b7f-cc3b-4274-a983-0cd867239ae1@redhat.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <89c05b7f-cc3b-4274-a983-0cd867239ae1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/6/2025 9:51 AM, Paolo Abeni wrote:
> On 4/29/25 10:17 PM, Jonas Gorski wrote:
>> @@ -789,26 +805,39 @@ int b53_configure_vlan(struct dsa_switch *ds)
>>   	 * entry. Do this only when the tagging protocol is not
>>   	 * DSA_TAG_PROTO_NONE
>>   	 */
>> +	v = &dev->vlans[def_vid];
>>   	b53_for_each_port(dev, i) {
>> -		v = &dev->vlans[def_vid];
>> -		v->members |= BIT(i);
>> +		if (!b53_vlan_port_may_join_untagged(ds, i))
>> +			continue;
>> +
>> +		vl.members |= BIT(i);
>>   		if (!b53_vlan_port_needs_forced_tagged(ds, i))
>> -			v->untag = v->members;
>> -		b53_write16(dev, B53_VLAN_PAGE,
>> -			    B53_VLAN_PORT_DEF_TAG(i), def_vid);
>> +			vl.untag = vl.members;
>> +		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),
>> +			    def_vid);
>>   	}
>> +	b53_set_vlan_entry(dev, def_vid, &vl);
>>   
>> -	/* Upon initial call we have not set-up any VLANs, but upon
>> -	 * system resume, we need to restore all VLAN entries.
>> -	 */
>> -	for (vid = def_vid; vid < dev->num_vlans; vid++) {
>> -		v = &dev->vlans[vid];
>> +	if (dev->vlan_filtering) {
>> +		/* Upon initial call we have not set-up any VLANs, but upon
>> +		 * system resume, we need to restore all VLAN entries.
>> +		 */
>> +		for (vid = def_vid + 1; vid < dev->num_vlans; vid++) {
>> +			v = &dev->vlans[vid];
>>   
>> -		if (!v->members)
>> -			continue;
>> +			if (!v->members)
>> +				continue;
>> +
>> +			b53_set_vlan_entry(dev, vid, v);
>> +			b53_fast_age_vlan(dev, vid);
>> +		}
>>   
>> -		b53_set_vlan_entry(dev, vid, v);
>> -		b53_fast_age_vlan(dev, vid);
>> +		b53_for_each_port(dev, i) {
>> +			if (!dsa_is_cpu_port(ds, i))
>> +				b53_write16(dev, B53_VLAN_PAGE,
>> +					    B53_VLAN_PORT_DEF_TAG(i),
>> +					    dev->ports[i].pvid);
> 
> Just if you have to repost for other reasons:
> 			if (dsa_is_cpu_port(ds, i))
> 				continue;
> 
> 			b53_write16(dev, B53_VLAN_PAGE, //...
> 
> should probably be more readable.
> 
> BTW, @Florian: any deadline for testing feedback on this?

Trying to enjoy some time off until May 17th, depending upon the weather 
I might be able to get this tested before the end of this week.
-- 
Florian


