Return-Path: <netdev+bounces-168135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A531A3DAB3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D5E3AAF29
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE41F55E0;
	Thu, 20 Feb 2025 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="HeH2DRqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE79433BE
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056530; cv=none; b=MNLwaRr4ka/w4lg8O8SnFfOxWl98W4Zu5Nc1jT+rzzAIlAhXLwiPF5CuQeBW7hcvxq64j3+uKJ58JotrvjmSrx9eMATw/usK1UndooZpcYWzBnZbJOEeU1jm4Bbv54fKDe8f4kbanAe/BjEICCxXBvbpQB5k74Fp3UN7S3KneK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056530; c=relaxed/simple;
	bh=fPEKYb7POeoAa+JS2ileNKtIzm9dI2wbiof52r2hOds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGf8NZc4BArLKsyL1mnjDBE+jwnnqA/5Nu6u+htn4wYZ7JWOKk2vU8Cd5eBPL0y8Zhw0JtvO7CWtDcUSDbnI7VbLFQTHjQ3V6mwTmlHUc1qRkE9RGVr5lOVdJsERXLIjx5E2lbzVmCAclQTkeISkZpPwA6leX3kSld7z8cE6m5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=HeH2DRqs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f20fc478dso81959f8f.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 05:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740056527; x=1740661327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I7f96+isOBNDOEKb8C11FzTGqFWH2WNKEBa53qWqzXw=;
        b=HeH2DRqsyasHhl4z2VkgZIgAW9SVbdT9ST0xc5ExnmnFQM2q446CNQ35lOBlRoVfvg
         dfPN/licXllYrPj6sVpm2ESZtDA5jaTSbdDGa3ysWxUQLygO4WuXfkWUdx5lgI3eUMJ4
         u2FBLcPatb4yTH/06CL9N8apGXI1gtnLkzcHaAQwnVTv/zi7frdRb0ND/Pgqd3+qqIax
         mMtptEmg+PWpdYswzjlp7JA8ncggwHfqINcWtH5ulBPLRRzEnAnPmgWlPb1Iax+k2Y7P
         m8QIcZem0qOnIykgR7oVCwu7L8F0BssDt7qVoHy91xQUiigFT8y2DHcfE2JeNapzQcdh
         CzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056527; x=1740661327;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7f96+isOBNDOEKb8C11FzTGqFWH2WNKEBa53qWqzXw=;
        b=DFkrh/bXN2V0XglIdjLnD2dtQa/ftgRWGHwmzowcU1MymMtcD4kEb/bxO6dfNI9asz
         g5Il+P6ztLtntxKZ8N71mYbmx4lLSyelB9xHQUbq0anIx0r6KQbyMfp/5ACfq3fz7yUG
         U/xnGltyaRLsZd9k+pnGRiYh4A6uuFjPPkKNqcJLbTAG3h4JfttBUg99rE6XJP6HjVT4
         QYu9VblPssxp4bRU6zZrh5Qub+tgbTKyi8TSfqlWV/FOsI3kArZs8wgZkUuQSSQCLs62
         lnhDUiqtpHkf0kx3ybNNljT556acfUUMeDM3FMQM9chh+u+6sf6Khr1DKHgKeem7T0Q4
         FZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXfphWVOULo/FGPByQ/iAUQ5xHAzzsHJ3rv300Ixjwlot5EYGShydUuynvPUqqW5N/pUoD8Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXXx1tRSaLxFylnAfgT0faXPqSK58H66Of4jhNycAC4M+1zsOY
	HUWTuyJ895tlBi+yPLQfrm7Ab7yDS9kXWx/cgulaLFF6Wza+kkyHOI831xzpptA=
X-Gm-Gg: ASbGncvV27FP8LK7hSe49GgW62zug/PVCIaFbVYoqpTUYknfXunefrAlKaN1D5BwjWD
	s2PAWSaox0hbY1V7zpL15CCXb82c2Kv0/DtFbm2hqSKs8i/cO3HNtK+w67bOZkNxOnt1e3g3Ftf
	OczSWnWzLnTWtTvaqT53xxlweEGwFVUZ6MIzyj9PKmvARsea6wLy7u5aFxHETadkDlyp7D4LBsA
	8KiVp+O7jJtiiMXCjE3gURxzNbxmeNK5++gB7cwwvW/p8WXPUTxVfqF96s/t+sdjEZc0g7kR/fL
	1vrtpa0ykseOa/babsby893JVZGPGCrXG44q6GxmXsjs2msHsdohrO6V2MzoeNz0Rwi4
X-Google-Smtp-Source: AGHT+IEU0VzlzQXaPx5+s/q5phDBqjPww+rnTaFEqyxCvK7ytkXZsCNBowF9wkRopxbtTSnp46VmxA==
X-Received: by 2002:a5d:5850:0:b0:385:edd4:1242 with SMTP id ffacd0b85a97d-38f33f50c0fmr8798257f8f.10.1740056527149;
        Thu, 20 Feb 2025 05:02:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:eba1:dfab:1772:232d? ([2a01:e0a:b41:c160:eba1:dfab:1772:232d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f8ddbsm20640840f8f.47.2025.02.20.05.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:02:06 -0800 (PST)
Message-ID: <556b48d9-f502-4b02-9131-fbb13cd111a6@6wind.com>
Date: Thu, 20 Feb 2025 14:02:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] skbuff: kill skb_flow_get_ports()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <20250218143717.3580605-1-nicolas.dichtel@6wind.com>
 <20250220105419.GT1615191@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250220105419.GT1615191@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 20/02/2025 à 11:54, Simon Horman a écrit :
> On Tue, Feb 18, 2025 at 03:37:17PM +0100, Nicolas Dichtel wrote:
>> This function is not used anymore.
>>
>> Fixes: a815bde56b15 ("net, bonding: Refactor bond_xmit_hash for use with xdp_buff")
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> I guess the churn isn't worth it, but it seems to me that
> __skb_flow_get_ports could be renamed skb_flow_get_ports.
> 
Right. I can send a follow-up patch.



