Return-Path: <netdev+bounces-219087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F38BAB3FB8E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68C22C36E7
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3AF2F0C7F;
	Tue,  2 Sep 2025 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+CUt7cM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E02EE26E
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807071; cv=none; b=JsWM/pFh6f18FGqdNujyXWLWlFJSwwmJ/Rq6GnUn7OMbJIrwEhWgi3AZk7XdpkLpZWXFtG+0Rcosu4WRWaFT0bmWq27DECsWgz2ZhaWv4bWlG4ji/AlERMlN0wXe3aIqnlpZqp03qDdaTjR8JXPLDwUdBi2vnv5BVNxeXfwYVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807071; c=relaxed/simple;
	bh=z8gMwvXA44Wodi+hSnmRdnTeDizAmm+mkq0BLF6OVgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd4g4uNd5zA+AIXfk2VXrFL4R44FtvcuY7cUPVOGQ/lHiW3YHsIj6FqITb92oO4ZwyE4vulhWAZ0r3F33O/ltKVcjv7ohVmPL7ELYhAs+UTC6v2JROFpvcEmIU0PHbvFV8uPB26ctTCkhS1NTsxjOX2Play1caO9CHWtomm6078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+CUt7cM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756807067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZc4GB0/gNL5X2pnt5xZy0Mk61OX021O6i+im+Ocmjs=;
	b=B+CUt7cMXGpQqV4SQOaohkzFP47F46tf2Ebpe4tNNQknYsEGafcloLJ2N4LUy09hRlZYlE
	0ezBykE1cGV1vFB5/itmPklPN8deGBA81zwVKtdmin71sylB3IZ5zbR6JOqZjvTxTyBMIi
	pHjkanh6OpMfrc12lPXBRrZnBr70Be0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-skEAl2iuMmSUSsrDDLGsrw-1; Tue, 02 Sep 2025 05:57:46 -0400
X-MC-Unique: skEAl2iuMmSUSsrDDLGsrw-1
X-Mimecast-MFC-AGG-ID: skEAl2iuMmSUSsrDDLGsrw_1756807065
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3d226c3a689so1121446f8f.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 02:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807065; x=1757411865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZc4GB0/gNL5X2pnt5xZy0Mk61OX021O6i+im+Ocmjs=;
        b=t2KNLor9xbWNmbpBZlzhx3Uo0sH+ly4ZAz5MsEdXGjMjm/ofUVVSs25GnM3KPLBSGe
         2u1dyPJ7TlH7X0tM2cxPR3HyMh2rHl8yc/9jPKFroeRfBUi0J3x1WiPNEa6zG3nww0FY
         yPJurQtlOb2dNdFegfymLerEnzi1A/Tl4O2bc5BmcR/00Cxx05iGWqxxn+ZK4CLbOcGl
         BGg0CUeandgUtSCJ5sjbNaLGdrOss+v3XP6ZkkIzpKC+DeLoz5VQYcyLuPUOsLutjUl7
         3DP/PHEZ6UzgTs0t/JQ8PYBQrtYFdCpvfbUZB4rDrtGQ6otoMATUmzFgkDzzf17x92ER
         bTCA==
X-Forwarded-Encrypted: i=1; AJvYcCXlB7BttGv0wxdkv6+EVTmnERvcyvg5BSEbU0MP5kQixCzRytvL2TYAGq26cwiqo+l3PbVEiuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQxDpbzy8/Q46Be085oR/YP3xA2lSXQwKR3WIZzIKPWpzH0t/
	W2+nOJC+r6zWLG84bUwdQcl8sEJ/BqT94tuQWo24ayfCnkbBi92ToDwXv4EsT1zonj4fUyBt+dw
	S4mHWUOVwTiiDYOizA3YUBvRPDZ7uY59ApHTz12bxz8nHA6zgMLKqH7n5gQ==
X-Gm-Gg: ASbGnct9WDl40lkBtDHdrqqpGcXpE5fB8tKw1mNZivx6x/QNs5tx+IYcEH6XIa2D0Xs
	kkHgiAEgspbkSie2qLsW0MWDeA2XBb5ePtSaWUqsyJP+XkS1Mhpk11GGmMfRFvzJDom7n31OX6s
	vfE7hrbaQjabBJa1QXhsj2CkzaH0JU0ZfvMjjyRs+oIGUhqSjRZsAUtHwduxb+N2/n4Ww/MTiSu
	Dw75l9zECiJjEyToP1+wCVttTeUU+SgH9IcWwkkuU+0633zlGuXDr3loELLPCzahJHl73i+YOAn
	IBTBIGh/V7HytXitXoJmcq8b9qRugcmrdX8BmxXR96HmE4Y5++++Phrzrb8IPLLotLKzrykG3K3
	2VnNr6SOCmEc=
X-Received: by 2002:a05:6000:2110:b0:3d2:52e3:9220 with SMTP id ffacd0b85a97d-3d252e39a50mr6205387f8f.5.1756807064877;
        Tue, 02 Sep 2025 02:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBBKawshRRcWgMajhrJGR9pfMn2+8pBgJ1J6VR2pISIYxt4qBpwtVugddscbM7nf2wPfGedA==
X-Received: by 2002:a05:6000:2110:b0:3d2:52e3:9220 with SMTP id ffacd0b85a97d-3d252e39a50mr6205351f8f.5.1756807064174;
        Tue, 02 Sep 2025 02:57:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a80c723sm14068985f8f.9.2025.09.02.02.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:57:43 -0700 (PDT)
Message-ID: <a46cca6e-5350-4ca4-ba17-bf0f89d812cf@redhat.com>
Date: Tue, 2 Sep 2025 11:57:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
To: Brett Sheffield <bacs@librecast.net>
Cc: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 stable@vger.kernel.org
References: <20250828114242.6433-1-oscmaes92@gmail.com>
 <03991134-4007-422b-b25a-003a85c1edb0@redhat.com>
 <aLa54kZLIV3zbi2v@karahi.gladserv.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aLa54kZLIV3zbi2v@karahi.gladserv.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/25 11:33 AM, Brett Sheffield wrote:
> On 2025-09-02 10:49, Paolo Abeni wrote:
>> On 8/28/25 1:42 PM, Oscar Maes wrote:
>>> Add test to check the broadcast ethernet destination field is set
>>> correctly.
>>>
>>> This test sends a broadcast ping, captures it using tcpdump and
>>> ensures that all bits of the 6 octet ethernet destination address
>>> are correctly set by examining the output capture file.
>>>
>>> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
>>> Co-authored-by: Brett A C Sheffield <bacs@librecast.net>
>>
>> I'm sorry for nit-picking, but the sob/tag-chain is wrong, please have a
>> look at:
>>
>> https://elixir.bootlin.com/linux/v6.16.4/source/Documentation/process/submitting-patches.rst#L516
> 
> Thanks Paolo. So, something like:
> 
> Co-developed-by: Brett A C Sheffield <bacs@librecast.net>
> Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> Co-developed-by: Oscar Maes <oscmaes92@gmail.com>
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> 
> with the last sign-off by Oscar because he is submitting?

Actually my understanding is:

Co-developed-by: Brett A C Sheffield <bacs@librecast.net>
Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>

(if the patch is submitted by Oscar.) Basically the first examples in
the doc, with the only differences that such examples lists 3 co-developers.

/P


