Return-Path: <netdev+bounces-237941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005EEC51D95
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C253ABC1C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250003002A9;
	Wed, 12 Nov 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLdAT8aH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnKeUs6D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF22D29AC
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945318; cv=none; b=Rah5W/0GA0Ou5Cuhsa6c/C6QO49yUyd6LiIgcisEMuZjFErbsLXs4w1IVzaKpQVOlFaiBlUSkVPN/2So4/2oACV90v5gj5tlI3BjInYpnhrdwQf1NQ8727JV0Evsb0rNCxz1sP05ktgPm7tifrieN9HSOZ78pX/0G9GUPvxhc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945318; c=relaxed/simple;
	bh=Rix2gXstzQVRwOGYgiRM4iKbc06GNtYlO3k6N6sx0es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8y8Fo9HU7AEFDtAZbGhONXLPFnF4Vfs6W4KWxkvR8jqf9KlkBu9mruVIwKqEwWDYbdXSICyV3pCtkkC/IHIgFw9lDPEyGYY7iUnO3wTOiuwr62+BoLf/jjzIEzO+CviBpFjxpBdgxH7/AcrKVwNxpTb2tUe170raKxzxWNkBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLdAT8aH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnKeUs6D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762945315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cswzeVpxbdbCvh5KzTG9nqWXaEdEbGjvIsS3PCeAQjI=;
	b=RLdAT8aHzZCw4c0Ybp1ZpbHyEGqFs1ovI9R9UKD48HCPN9JGjntKURDThfw4loJYIMICuj
	Z9i4/UnsiiYsRxGNNsb5LUjvWEi5IfDJ1j44uD/68nrWIS/42giwuwSFOUiYsj17xW07hB
	uSlkfCAJ2GCxXYBevkMzbIB1eCdCRSI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-j8RnuzIRMpOERufEKttJZw-1; Wed, 12 Nov 2025 06:01:54 -0500
X-MC-Unique: j8RnuzIRMpOERufEKttJZw-1
X-Mimecast-MFC-AGG-ID: j8RnuzIRMpOERufEKttJZw_1762945313
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775d110fabso7307865e9.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762945313; x=1763550113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cswzeVpxbdbCvh5KzTG9nqWXaEdEbGjvIsS3PCeAQjI=;
        b=FnKeUs6DuZzNuR47IVo0jorH+O2Im0eTJyMLIeP26Rjqez7035wfLjk/iyo9X+jmVL
         yqX7m79YMDPSXdA/6H5jHCmk1mNmpFXlvOTuUrCj50RiAA2CyW/S+N4GRYGRYtBQmdju
         zggh35ZXThJi68hCqV9+N+i1XRM3MvqRkcBbCwcx/4wGmDfmERlZ17+dbHpEaMPY605M
         Zyuz014BrsMyy/EOuzO4Rz5ccBXcu0pa55K5WHfIUtN0QHN52/pTjv/iJDY5nx9thjlk
         f3AfLK/QYA6Ljd4DZAV7IK7Ufktm4j92/IvjEkZCP2hRKFdjcvqQlZZ4DbiAlMzMnboH
         u/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762945313; x=1763550113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cswzeVpxbdbCvh5KzTG9nqWXaEdEbGjvIsS3PCeAQjI=;
        b=MGqflnyCRgJREt8z2h5o1VXLfrLaPi2VeiRbeZN1CAnMED94rWV1WwWjZqAipumFPf
         71iVld/92xYg9vfs+BYspV1DKZviJ0ZK6vpI6o6ySf93fZKJFGvEYzo2+Zktaci08Rzh
         CllK0YvF+EpSiSpqBTeKjvVdVrpxvo7yG+esDuIJifCIwuEMCAIkWf7uRhCEDdohaiXD
         Grl1+GAKwKU++vzEp8KuUIh8Wj3vAXU/sLVT8rvmhalUXzoFISoMi61ekLsOZYed5gQQ
         Sa4N3cJuzKlwPEOKL2F6ksIUrBlT9L3MFPznVdpDXMGXNI8WxG0Tbom2WaLZ0yq91hPt
         /3uA==
X-Gm-Message-State: AOJu0YyV0q3a2VlghtoxxchPTOheZbAtI6Bihy2FYMxC1svPNLPaPTdn
	AQ8MdRDMdyaPbeac+Bnb1kYhQiVWyvoCoIDmviQoMJXAl0pftIazlOOE5DMJ5zMQ5TgjQVNU7qg
	/8fDp/2SHvdFf1610Ct4j7rnBKg2X6bJ1TzZcFDKHfSUTBC6xzuzPReMXjg==
X-Gm-Gg: ASbGnctu8wwgEtECB3syIwYMdElI4e/9O8QZ1tiTIuTbCGG/xAld3GzGZmeySPL1dVz
	QUULVUXwE75UmHFG6YjDkyNDD20Pup0SoBVe0VufveyJjKYoW0p6XZppTSpdb6+ECYPrrfHO/uX
	rg/Zv0h3agwjFH7wWighYTCcPzQDLnXPntZcqU8J/JVnyeuWSkBT4cfhfL7zcsdNRCQ6pRrHO8o
	HHBy6s3jD66xjOtq/N5wKgt3j6ZoFu2e1x6ldUf0XZKgNljwoX+iSMnAAXOFewniYhpJO6zK8Ry
	oOYwKFcxXY0JCmlEUjZUPJUbQ75xGMMsLXVdwIRhgM5lJpZ8AHN4kah8Dhknmt65lvlmU60F3Ps
	3e/uLDEz4Hp1l7fIDJHQSQskZfG2IZlu6ZwjS4RjEwPVUerdsbYby/5sjGimasWS/OjE/ycuoEs
	ARr4Dg6j/v5K5xYs+jm8DlW3moJIUy
X-Received: by 2002:a05:600c:4fc9:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-4778704a06fmr22996155e9.12.1762945312921;
        Wed, 12 Nov 2025 03:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXRgReKc50wSF4ICL66IGbn/jrWNevyyfHDJ6IgSi6BNsvLdnT/6VUyKWvleSg4ag9ik+zfg==
X-Received: by 2002:a05:600c:4fc9:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-4778704a06fmr22995785e9.12.1762945312413;
        Wed, 12 Nov 2025 03:01:52 -0800 (PST)
Received: from ?IPV6:2003:cc:9f0f:f0f1:37d7:b7e5:eda1:1fa0? (p200300cc9f0ff0f137d7b7e5eda11fa0.dip0.t-ipconnect.de. [2003:cc:9f0f:f0f1:37d7:b7e5:eda1:1fa0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2ad4csm29921335e9.1.2025.11.12.03.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:01:51 -0800 (PST)
Message-ID: <4cb6fcd6-4e0f-47eb-a826-c1af712d33ab@redhat.com>
Date: Wed, 12 Nov 2025 12:01:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] hsr: Follow standard for HSRv0 supervision frames
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, liuhangbin@gmail.com,
 m-karicheri2@ti.com, arvid.brodin@alten.se
References: <cover.1762876095.git.fmaurer@redhat.com>
 <ea0d5133cd593856b2fa673d6e2067bf1d4d1794.1762876095.git.fmaurer@redhat.com>
 <20251112102405.8xxcDBuT@linutronix.de>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <20251112102405.8xxcDBuT@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.11.25 11:24, Sebastian Andrzej Siewior wrote:
> On 2025-11-11 17:29:33 [+0100], Felix Maurer wrote:
>> For HSRv0, the path_id has the following meaning:
>> - 0000: PRP supervision frame
>> - 0001-1001: HSR ring identifier
>> - 1010-1011: Frames from PRP network (A/B, with RedBoxes)
>> - 1111: HSR supervision frame
> 
> Where do you have this from?
> I have here IEC 62439-3:2021 (Edition 4.0 2021-12).
> From the 4 bits of path_id, the three most significant bits are NetId
> with 0 for HSR and 1 to 6 for the PTP network and 7 reserved.
> The list significant bit for PRP indicates Redbox A/B while for HSR it
> indicates port A/B.
> 
> You say HSRv0 while I don't see this mentioned at all. And you limit the
> change to prot_version == 0. So maybe this was once and removed from the
> standard.

My description for the path_id is from IEC 62439-3:2010. As far as I
know, the HSRv0/HSRv1 terminology is only used in the kernel. AFAIK, our
version 0/1 refers to the value in the SupVersion field of the HSR
supervision frames. The SupVersion is defined as 0 in IEC 62439-3:2010
and defined as 1 in IEC 62439-3:2012 and following.

The definition for the SupVersion field also states: "Implementation of
version X of the protocol shall interpret [...] version <=X frames
exactly as specified for the version concerned." (in IEC
62439-3:{2010,2012,2016,2021})

I read from this that if we implement HSRv0 we should follow the latest
specification for this version, i.e., the latest specification with
SupVersion defined as 0 (which would be IEC 62439-3:2010). This is also
why I limited the change to prot_version == 0 (maybe we should have some
helpers like hsr_is_v{0,1}() to make these conditions a bit more self
explanatory).

> Since this is limited to v0:
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks,
   Felix


