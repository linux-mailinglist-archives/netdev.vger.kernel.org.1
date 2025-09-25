Return-Path: <netdev+bounces-226254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C225B9E979
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9C43A9B1B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8777527FD5B;
	Thu, 25 Sep 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GO9eQqJW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB4023C516
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795336; cv=none; b=Zg/N7T9jt1KfgQoejKJRKU5pACWh39FDnenPlA2cfvrHT8UMWo+22hqO0/HEV6skrYH9Gfw2SXy1RQcAQ25lPs6D4L1BeeHK+NkOmK3D9nBPfhIdieJSXodrITsBRAol4xG0GquBPGQjEXaoNCPyH89EVCNhYieMt0Ylis37zFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795336; c=relaxed/simple;
	bh=QyP35LZeGd53K97cVB602RLrZ+mjoe/ln3tSgKWmlyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raLU+plLDRJj5nS5eo+KKJimR7o1w2kzv142yYkX9REm8wfXME/yD0vvGswP9lR0LLMjp+UlRSKas89t5y20omqnIkZIKFUWgD/ogHVvFgMQszLPz/8PNysAv+n1rWJB3ZPZnyYUMvITropki8C8HkCKvFQ1/dUWZwfFiPLTCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GO9eQqJW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758795334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE39AyDI0R2kmOiMdOAVn6YizW+gjTjX7x3iK/djyfM=;
	b=GO9eQqJWkYxkjqzVhHKBzA4vbF0fhs6m4Q8xgMe7U2vrPht2Ml4Ev1IzIlDtgCkrKYrpag
	mhTqaBoNIuohxWZB3R4U7s1pFsQhtHzob5HIEgP+mbNVkJjkQxT60bO48+zJRROzWExCUK
	yUEeZHLhpEWXbQ6XgDs1DRZXTlbETpQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-NuMzKBP7M-ywMDyXkz4xKw-1; Thu, 25 Sep 2025 06:15:32 -0400
X-MC-Unique: NuMzKBP7M-ywMDyXkz4xKw-1
X-Mimecast-MFC-AGG-ID: NuMzKBP7M-ywMDyXkz4xKw_1758795331
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee12ab7f33so501908f8f.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 03:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795331; x=1759400131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oE39AyDI0R2kmOiMdOAVn6YizW+gjTjX7x3iK/djyfM=;
        b=CDrg7IZdF9Qep8bBxWRsUwbN0kAfMoAp86D2weU1sPyW/obkbtzOV3djGq9IRx55qk
         4e2Yino3BIllGlxRksTV9LwLGZDFzx+frnbykEy8cCkb1wJmT/10nypmZcPZW31n0nvQ
         cCjiQGsCtF5t5S4vjKzKAxBmW5p/zCPZhYztDfRKToXrhuKpqINf92HD1IdhxPmLRuc3
         Of4K65niHSr4Pn3Ra+vmab1jnXzMa5di/2Q+oA4IsAlIomoL/89iJd/ih9y0bTB9wdsE
         yBzamyPud7Pms2lfaiTl33nJohetCKpWp4ReKjGxUIDc7A4AoGSvmin0A0c+xNnjGn/w
         Us7A==
X-Forwarded-Encrypted: i=1; AJvYcCVcvvD11Bm0NYDirrdfOpysR3a7t3W0G2un+GhhIcRK8DlrljwQ6zvWvGkWDSdO40Lv7/g0R/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNRpTtOrRUR5pPgJ9mMQyNjz9gjO1IFBgd4XqzWJ2b4lkViei
	f5aGVU5jFyhNn/XKpu5TvKbCOUad3OkNoBiHrxCJMBDWz78sxsCw7pl51DWTwaZYg9DwaPd3z0A
	Kycf1x1Q37Yv+xFDwCNqIlOg/mn2GjkwEnhaAtUmnvDg+o5mBqfsocOlOqg==
X-Gm-Gg: ASbGncvE2Vlgk8GZ0130U4ujcMW1l6xe/bk2jzv8oHvl/P82KjjUK1wrl380YjcLGzI
	XmeF/12HVrU4YYo27Hm1Km2j6WCG9nR7MfQ7Rwgx1bD69bwbKi2p6ma9ge/0gfy5YjO6vdUIfuF
	bI9gEcxONHMH0zbSOBdDG+lf91gkhKG3uCCP8NqQ4pEKtO52BrlGoiTHLGU3oSV9cWCLpZ6/O5c
	KaJr2ZeMKDD6L2VctOqsjiS0iusfCbY/cgiG1aw+M3xQqj/zcbA8TnTxJJdyf5ht2goaC5J/2LP
	Cbr1Z8POXUDJVgYxzoj3B0x6E7OOrkzMp4sLWg7VDACTzCJExggrVvkrH1RM0+8/mpximq25s8L
	1cI9pdIV1K6Qy
X-Received: by 2002:a5d:64e7:0:b0:3fa:ebaf:4c3e with SMTP id ffacd0b85a97d-40e4cd57861mr2736644f8f.54.1758795330773;
        Thu, 25 Sep 2025 03:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQHZVeXB+eszjQtYT/isW1eoe/gKc6xWtsrqDnkgflOXZyLnSBxXzSUX3pKWB9cnoUV6UNmA==
X-Received: by 2002:a5d:64e7:0:b0:3fa:ebaf:4c3e with SMTP id ffacd0b85a97d-40e4cd57861mr2736592f8f.54.1758795330201;
        Thu, 25 Sep 2025 03:15:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fe4237f32sm2256685f8f.63.2025.09.25.03.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:15:29 -0700 (PDT)
Message-ID: <dd89dc81-6c1b-4753-9682-9876c18acffc@redhat.com>
Date: Thu, 25 Sep 2025 12:15:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
To: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, ecree.xilinx@gmail.com,
 Richard Gobert <richardbgobert@gmail.com>, kuniyu@google.com,
 shuah@kernel.org, sdf@fomichev.me, aleksander.lobakin@intel.com,
 florian.fainelli@broadcom.com, alexander.duyck@gmail.com,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com,
 netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-5-richardbgobert@gmail.com>
 <c557acda-ad4e-4f07-a210-99c3de5960e2@redhat.com>
 <84aea541-7472-4b38-b58d-2e958bde4f98@gmail.com>
 <d88f374a-07ff-46ff-aa04-a205c2d85a4c@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d88f374a-07ff-46ff-aa04-a205c2d85a4c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding the OVS maintainers for awareness..

On 9/22/25 10:19 AM, Richard Gobert wrote:
> Richard Gobert wrote:
>> Paolo Abeni wrote:
>>> On 9/16/25 4:48 PM, Richard Gobert wrote:
>>>> Currently, packets with fixed IDs will be merged only if their
>>>> don't-fragment bit is set. This restriction is unnecessary since
>>>> packets without the don't-fragment bit will be forwarded as-is even
>>>> if they were merged together. The merged packets will be segmented
>>>> into their original forms before being forwarded, either by GSO or
>>>> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
>>>> is set, in which case the IDs can become incrementing, which is also fine.
>>>>
>>>> Note that IP fragmentation is not an issue here, since packets are
>>>> segmented before being further fragmented. Fragmentation happens the
>>>> same way regardless of whether the packets were first merged together.
>>>
>>> I agree with Willem, that an explicit assertion somewhere (in
>>> ip_do_fragmentation?!?) could be useful.
>>>
>>
>> As I replied to Willem, I'll mention ip_finish_output_gso explicitly in the
>> commit message.
>>
>> Or did you mean I should add some type of WARN_ON assertion that ip_do_fragment isn't
>> called for GSO packets?
>>
>>> Also I'm not sure that "packets are segmented before being further
>>> fragmented" is always true for the OVS forwarding scenario.
>>>
>>
>> If this is really the case, it is a bug in OVS. Segmentation is required before
>> fragmentation as otherwise GRO isn't transparent and fragments will be forwarded
>> that contain data from multiple different packets. It's also probably less efficient,
>> if the segment size is smaller than the MTU. I think this should be addressed in a
>> separate patch series.
>>
>> I'll also mention OVS in the commit message.
>>
> 
> I looked into it, and it seems that you are correct. Looks like fragmentation
> can occur without segmentation in the OVS forwarding case. As I said, this is
> a bug since generated fragments may contain data from multiple packets. Still,
> this can already happen for packets with incrementing IDs and nothing special
> in particular will happen for the packets discussed in this patch. This should
> be fixed in a separate patch series, as do all other cases where ip_do_fragment
> is called directly without segmenting the packets first.

TL;DR: apparently there is a bug in OVS segmentation/fragmentation code:
OVS can do fragmentation of GSO packets without segmenting them
beforehands, please see the threads under:

https://lore.kernel.org/netdev/20250916144841.4884-5-richardbgobert@gmail.com/

for the whole discussion.

Thanks,

Paolo


