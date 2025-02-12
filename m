Return-Path: <netdev+bounces-165565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FC5A32853
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1183A72B4
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D78520FA9D;
	Wed, 12 Feb 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNpujEEW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA720FA8F;
	Wed, 12 Feb 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370278; cv=none; b=jm/wI3BN9HWgCvb7r+LpKYuPMZ/FgutgRdaMmA6xDA+5AVLsI7tEWE0DGsZOxguhyskVnVKPjnTzrEvfVjkYt1+rg4TD/DPmfkmpijXJXvZqlbdsZkGqk8dis6m98MjUGxzeBQGMIq388m0gBGatf49zrVxPvHHIK0gyye2yUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370278; c=relaxed/simple;
	bh=cR9X5BupKAbq9ymgmU6c27WeLJYXqmjnqMN62pjhDeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIQlcQbDJ+XtiRG+eT8lcEJAtmX35kkcxt84KvzuR+XyNu0JxWBfpxmNzjSSlLbFlI8UB5flVXT6kob7gOkhohawludI/ZUrmq9cZ1jL233faZapb0XRwsEHjw4Z1HnycJLwrck0FQ3rO3DJ85nv69lTIi7cdDuOAggD6h67I0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNpujEEW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f5268cf50so77244065ad.1;
        Wed, 12 Feb 2025 06:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739370276; x=1739975076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MJlkv5BW+hkpm26jUOV2x9Tmovy8tBNUXrBN32ipwM=;
        b=GNpujEEWHPzpqWSJ6NNHwtT6UjMRbaH7FVH3frD3LZcLEXQJ/A7pErtSHlA2zzyT9P
         4J+rMWo147Y14cSK4nsy8y54gTjXWKhe3KQw6ocFmcUkP74j95nJmAGU1K/KWKL7dYpn
         nsbXA9kQM+1bibLcsyuf43o2GnXrPw+iEZExn2+6NI8v5OZVVc3z6Oo8V+AKQNR8VJlB
         zFOls3SbDg3FsLVs/hzu1pl98vgAjWJDyrTGmhXTmchYi/LplOUtphMo+DO0ixPqF/iF
         QT2WG3Tgzi+uIvgCZ/4Pv4YBAKkSasWNKtT0UUexmJNsFpcN349hg3Mast/iewX9amms
         8qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370276; x=1739975076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MJlkv5BW+hkpm26jUOV2x9Tmovy8tBNUXrBN32ipwM=;
        b=vk7HOso6UvlbKcj4x83ygLNlWqo+nE7y0nPGPiaQE0JghNgMgIZInI9ii6y3wZ+K+z
         R5oCJox5nMA6UGEPvhNJ0nnGfgqURoyhnKiNUDaI/X2V/9c5yYdnUgFTsWSJ9HlNzK6q
         wLiHs2GeTPen40AgoVutCCZCJ5PnEShKOIGtSzSVf3hDWw6Tlsz3NsyMWA3DEWJ7QDv3
         GZaD2a2Z9514RDkoxYX5Lvdz2L/Pys9rFUMACYV5EE5p8cDizZ0du+wC+b5+YAmtMhNj
         EzpXJwJcOFkNGciaRUu/KKCmHcWbOWfTgfhJX/4flJW0/h4493E6vEeuCsgY+i3HJ7WN
         0AeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi7JpLKLSqOs8zjXHENqe6pSpDSbvWYWK4XTJmV5CJPinvDK6yq9YVYExexfDQrshVhjG+xglEpEGEulQ=@vger.kernel.org, AJvYcCVRNRC8f+KLoLpOZWMGdMCL7ze0QRnyTZyj1WJWTQsvAtqH3uMu8ojPqOWyEdKsWFtK6jRuA1Jm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0sNOP4GBDATp3ZLWTeCrB2bPMfBenHW5RQK5NrhigzPv+NIZO
	T9M6mkfD36Df7WOvD4rFNHyrfmMepLkdsPhhQMzdhDf9ia/UmgwdaV3RDQ==
X-Gm-Gg: ASbGnctqkyKI7UmWjsQUbVI2kvsaAyT7Q9R1IpChRpXYCx0J/FRbHS4EUN8yjx45OTu
	b58LlXYSCTZiVAB4SL8CxiKTq3K87KgkZS/wTE+eXRswfibNnBsS0JKOyxCDIegH4b05cfAxwX2
	IZmaKAPtMQsD+1O1vLdz9xzRd2BQ3TBN3FPVUlwXF2BdECfbio6XgeX11agZ7zbOdoEfFpM+rEB
	afehqocmR9Mcsja/kx0xt+n+fF+do5AVC3vuek9pHo5IwBzDxp+4SEzPNZaohpG6uMv2tpUxDXK
	tkv0ULyzkZIqUODDy+dLtMinJqM9PrJIlgPUjtfxWty1uWvIE3CASSeafNdihA==
X-Google-Smtp-Source: AGHT+IFztfme4Du4DXZpf9oCTSfwAAjYVV0nbvMr6vquEQGAi6dv2b2oSXr1ORZCJwRUm5iEwxW+uA==
X-Received: by 2002:a17:902:da87:b0:21f:6be1:97c4 with SMTP id d9443c01a7336-220bdf3d4a2mr41812335ad.26.1739370274894;
        Wed, 12 Feb 2025 06:24:34 -0800 (PST)
Received: from ?IPV6:2409:40c0:2e:ea4:a251:12db:9bc4:5019? ([2409:40c0:2e:ea4:a251:12db:9bc4:5019])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220c8982d79sm5589185ad.194.2025.02.12.06.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 06:24:34 -0800 (PST)
Message-ID: <dbdcff01-3c46-47f2-b2db-54f16facc7db@gmail.com>
Date: Wed, 12 Feb 2025 19:54:16 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, skhan@linuxfoundation.org
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
 <20250211003203.81463-1-kuniyu@amazon.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250211003203.81463-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/25 06:02, Kuniyuki Iwashima wrote:
> From: Purva Yeshi <purvayeshi550@gmail.com>
> Date: Mon, 10 Feb 2025 13:20:06 +0530
>> Fix issue detected by smatch tool:
>> An "undefined 'other'" error occur in __releases() annotation.
>>
>> Fix an undefined 'other' error in unix_wait_for_peer() caused by
>> __releases(&unix_sk(other)->lock) being placed before 'other' is in
>> scope. Since AF_UNIX does not use Sparse annotations, remove it to fix
>> the issue.
>>
>> Eliminate the error without affecting functionality.
> 
> The 5 lines of the 3 sentences above have trailing double spaces.
> You may want to configure your editor to highlight them.
> 
> e.g. for emacs
> 
> (setq-default show-trailing-whitespace t)

Thank you for pointing that out. I will ensure to check for such
issues before submitting future patches.

> 
> 
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> 
> Otherwise looks good.
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thank you.

Best regards,
Purva Yeshi

