Return-Path: <netdev+bounces-272509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EIgCENrxmmkJwUAu9opvQ
	(envelope-from <netdev+bounces-272509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:34:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B02CC34388E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AA8330774F5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB0534D905;
	Fri, 27 Mar 2026 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="UWnmksaw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA061374738
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611112; cv=none; b=QWYGQsC9K+Tq75mK+nffe3Htg9fqHJZKmQo+BAxsJ287YKDMHOBwv9cGbnJHt7coRIciI46Ofx1pgUo5lhIsSq2u+YvyOuzCLpAr8wXgVX3mB3nPFf0g21Hm+bpvp+bxAtmBK9KCh3lYdWtIXEfx9AIfTiSdXDaa31mAqJgM4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611112; c=relaxed/simple;
	bh=RfemSCYO7Qpo6eUQ9+NOWyXgL3/HYNFzcucOk9JKzpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HtEu2hL0o+gHdYiqM1kvp0Oc2xDKILA+Q72p9/q17kkingOKeTrekUonhHeJNlnHNepIz6C0qkJga/8ynmhf2TpBjfyaVX/0M7TTEoXuqu3OeQ+yOIT4doqYzqpV9DrqjtQXwTlzbClhhj1eSa6+KY76nl8/9TTLN7Yu5FcKnEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=UWnmksaw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439bcec8613so1491915f8f.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 04:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774611107; x=1775215907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=77K0V4DrQKU0I/h2znnukzMgi4FIv6qKk6d+0fvRL7M=;
        b=UWnmksawZP11TxoB6p353NaGdheXSqeIqQ1w332YKgtftl2CFmoPddlQyPhOkSKCEr
         AXt1qG58uF2RYeIA0fQX2CP3zVFmq5Dzsx8yT4y2mWIcUx+ZbuZqQPQKt1ehwDoQoQfJ
         vZy7kLbRBGPB0T3Z3OurJif5z3YHBs25qpCCvUaSyVhSUTIbVJEzjiqPBFsDzZhMqffv
         66pNFCuByMFWPJEG20V++p+PmYN4QoOXX67twHDy7hsPAxmf6Dz7Dwj/UwtEQ0MmkAxH
         sxF62V2oaCQsu6G2LgvUXlaJsiOC2i+dYmF8HA53UkCYad9a65lPbtC860wby5A7K3oU
         sVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774611107; x=1775215907;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77K0V4DrQKU0I/h2znnukzMgi4FIv6qKk6d+0fvRL7M=;
        b=iI1ipgSEhLP7znySC93GupocVm4e9NJ6+xGSDl5Bh4aw2uEPgoKKShKQkBMrJStv16
         0BW/mfXuac9F8JnaezHIFg7blLgzOfxdj0sG87bpf58Hqq+stEpCGVGJKF6epAz3C9QE
         I8v9DTQoMziw3k2oqx7MfvMHQyAcTDZr3WnOJmXZdrYGKGz80bVOctzesLzUbvMo+FHC
         1MbtPzw0mkBlwk/NDllUkzBh1gaA8Jhv9hHiEm+3ESO9j8UHdp0G02Yj1QTbSF/C0n9o
         EHW4DtYv0cdODhxK3983IfA8Vr5rMvrdjd5XrFc+pBFuvYqYgJYUH5roo4utv/alXGoL
         ZbXA==
X-Forwarded-Encrypted: i=1; AJvYcCXd0ohM8jo3CPrToK/bo8jRXc6S+ZsNV9iCBlniixvxz9QZAFbNr+sV9nlXhXwB+66O0cY5ogk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQqxLCqzUe8/nPoPVMF+uVuXoTfd+Zxt5vOxOoQGFyBTanxIv
	rOklbWHdCn1G9VnmbYPogbQmj1+hTCaezUnpzs8x4AHDWbmXPEmwx3xZWv4YuQLCy34=
X-Gm-Gg: ATEYQzy823PAjLI48rIqaSeCJagpC3Q0y4Ej5f7C2xu4P/8vEVEnMP7jKU/KrEdEsu8
	hyiV0k8t4N5XoxSSiK04prcIxxj3VwyavWOQvjUGBgK9dHQKe2Ac7H9XBrKj+oyFSYhdawNd71D
	5CHmbyOFUx+583X30RnEyF9n5wAvgK0vJdciYB7v2ipilTFNFJ9RaUhAMgvDUso1B/h0yrhX/cL
	q0HhlMG1iQ8ZoJPBVYgXgyr4qQ/+v2HG2G208AkO8NORwt69foFI94Y3vRWbr0jH9abwNF7kabw
	4vV7yVvjavQcS4I+ZNpaVdtSV2uj5jr57hazKmEUPXsbKOV/50abXjoTyS+nWoMt4l2rDjDCaP9
	8yCOWrmb0/zBYsjzKLhEploU0WVST+Yz9VFKYs/vneMnBCWT3FL8Kj6aL2O0thTyMzYuAfSnAIN
	SGOgIfGLfMBlCzRSpMIerSa/p06+jh7DltJhmgz+RSKQxl9xVZux4N0Q==
X-Received: by 2002:a05:6000:4013:b0:43b:3e40:2223 with SMTP id ffacd0b85a97d-43b9e9e8a0fmr2968001f8f.19.1774611105996;
        Fri, 27 Mar 2026 04:31:45 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2b2sm15558913f8f.18.2026.03.27.04.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 04:31:45 -0700 (PDT)
Message-ID: <e78472a1-f11d-42cf-9c34-9fc5479db1db@blackwall.org>
Date: Fri, 27 Mar 2026 13:31:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: bridge: mcast: add multicast exponential field
 encoding
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260326150742.50289-1-royujjal@gmail.com>
 <0e8a01b0-9b83-405f-a0ad-7b335135962f@blackwall.org>
Content-Language: en-US
In-Reply-To: <0e8a01b0-9b83-405f-a0ad-7b335135962f@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272509-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B02CC34388E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 08:41, Nikolay Aleksandrov wrote:
> On 26/03/2026 17:07, Ujjal Roy wrote:
>> Description:
>> This series addresses a mismatch in how multicast query
>> intervals and response codes are handled across IPv4 (IGMPv3)
>> and IPv6 (MLDv2). While decoding logic currently exists,
>> the corresponding encoding logic is missing during query
>> packet generation. This leads to incorrect intervals being
>> transmitted when values exceed their linear thresholds.
>>
>> The patches introduce a unified floating-point encoding
>> approach based on RFC3376 and RFC3810, ensuring that large
>> intervals are correctly represented in QQIC and MRC fields
>> using the exponent-mantissa format.
>>
>> Key Changes:
>> * ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
>>    Removes legacy macros in favor of a cleaner, unified
>>    calculation for retrieving intervals from encoded fields,
>>    improving code maintainability.
>>
>> * ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
>>    Standardizes MLDv2 terminology by renaming mldv2_mrc()
>>    to mldv2_mrd() (Maximum Response Delay) and introducing
>>    a new API mldv2_qqi for QQI calculation, improving code
>>    readability.
>>
>> * ipv4: igmp: encode multicast exponential fields
>>    Introduces the logic to dynamically calculate the exponent
>>    and mantissa using bit-scan (fls). This ensures QQIC and
>>    MRC fields (8-bit) are properly encoded when transmitting
>>    query packets with intervals that exceed their respective
>>    linear threshold value of 128 (for QQI/MRT).
>>
>> * ipv6: mld: encode multicast exponential fields
>>    Applies similar encoding logic for MLDv2. This ensures
>>    QQIC (8-bit) and MRC (16-bit) fields are properly encoded
>>    when transmitting query packets with intervals that exceed
>>    their respective linear thresholds (128 for QQI; 32768
>>    for MRD).
>>
>> Impact:
>> These changes ensure that multicast queriers and listeners
>> stay synchronized on timing intervals, preventing protocol
>> timeouts or premature group membership expiration caused
>> by incorrectly formatted packet headers.
>>
> 
> Can you add selftests which cover these cases?
> 
> 

Forgot to mention - for improvements and new features please target net-next.

Cheers,
  Nik


