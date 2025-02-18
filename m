Return-Path: <netdev+bounces-167310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F786A39B88
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2453A7D9D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC5241133;
	Tue, 18 Feb 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWMwMv4/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE224061A
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879816; cv=none; b=cZA0xyAlnBrg3doDOo1IP3OhB7goGdf3se+bLpOtXtVo9+1subIGOI7ddLEG7J97G6PqDoUNg7yd7l9zB3NFNpR45tR8puU9MluMdN4pa6sAs5apz0t9LZUWzp8zxjEEkBtoV34m8VsVWvlBEHz+HWGSfKRxkVTZDWObKu2Wlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879816; c=relaxed/simple;
	bh=gAXwPuiNBK1dQQARUmBF+Uah6IocUUDBSdAdkYR8jYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeGagFfkkdfFMWndOYv5EO3mBJrAicSKkFnXUEFt7a8ak6h6ZmkW1taVQNZZV7aZyQVxN84IMMe+uX8/ZVN3JezTjm/lSf0+31IsYuSAUV2IsJP2SyhI4Buv4dDyoO4HOVeKzXaMQ4lJgaksBAjmiOCGGVeljD1NQUPJ5T+3sNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWMwMv4/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739879813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TrCtp+1xjh5ECHhMj/v9NbTv4+B1oGX05rEY7hSgbk=;
	b=HWMwMv4/UmMoPkwxykgNsguIhtQeLNprFILlFlLiVPMrrBzJUtmIh0WeOXSxt61ojRvJoc
	9DAYKB1ans7jThPt+UxNxePbWLjB89Dq9E7wKfWjP3UplPADZXWXQ6Y4pW02LFF9YBAxVI
	BkChx3/2SZBf7TBRbJ2NPWphbZb9u6I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-sURrVfCWP3OmGE7oEP7Fyg-1; Tue, 18 Feb 2025 06:56:52 -0500
X-MC-Unique: sURrVfCWP3OmGE7oEP7Fyg-1
X-Mimecast-MFC-AGG-ID: sURrVfCWP3OmGE7oEP7Fyg_1739879811
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c489babso28738375e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 03:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739879810; x=1740484610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TrCtp+1xjh5ECHhMj/v9NbTv4+B1oGX05rEY7hSgbk=;
        b=mG9E0gfVI4bgju9VAPCjKeBw3yz05h2i5sJZL0FM7H+tUkUOb8dXM311kOnczSo/6j
         ll7NIubNPqgPIB03tnNROHRAcyLx6dNRq52/ewmwWhSPih0AebWlUqzVy+U2UN0HY07v
         AUTcOmi51tqHQBKOlPYoSze04HViAIQdP4Hl/eC9QFwABYM3+eIHCD6htZnP4aIM2ADK
         OVd3H3kfFs8X5Y5mkIcBcNZcEaQnLqe9i/2sVr4I/VLUbjfOKJZhnVQiBjqId2cRCD4k
         rPr9/35ldNyMnptMy4psQL4RhNr05rF9UWpcqJxBZPohMRpNBRYORFc9N/YtSxLEducm
         uUWw==
X-Gm-Message-State: AOJu0YwiilAKubBv1DoJhSMHt743lCo6io31Paapp9I46ydLOMdoODP/
	286vMMy9dl23V03d/l3pYTIg2sq047me110CcQRW3Ex+2YfCYOwT9t6myDTUDZwH0weovcy8Ztk
	Hr8L+Jnor045lnivoPMTLqum3EXfyBlBFGySVbTHqMadWfQi15XDh1rZz8Q8ycQ==
X-Gm-Gg: ASbGncuWYiocsMD6uDvMoSYofJFEtRNHfIjzXc6+Cpkwio7G4guEZlCXCfxhwQCaYyn
	7omvNAw1Tv9tDpKgdJ+2fED0f/9SdNwEE75DZgxh1sn8uYomm/Xk76vmDvieTdQ7U/4OrghD8Lq
	+Lm8a91UAqpLYHZYf/i82h2SOcx7irJwdJw9FB2GHwT53XRtV16C0LvIGkrYiByaoJAK/NXqIKC
	35FU+vw3TaTf1oeOKNANx7Xpyz4aYyYNvhM/4i9419nJz+fSQMAcJSYsM/2naVrvk2+nFygZhmh
	EukEo4afPyKpqFkoC8U2eBTFRMip8zMmBHw=
X-Received: by 2002:a05:600c:1c28:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4396e6ab033mr118563185e9.4.1739879810605;
        Tue, 18 Feb 2025 03:56:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuDzlIj4+ZcRmIQiX4dfMOAndYxXFCRpJROCQqnYKyVuVPRTXAGHtiMD/UZkOEzuvtbMkUPg==
X-Received: by 2002:a05:600c:1c28:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4396e6ab033mr118562955e9.4.1739879810205;
        Tue, 18 Feb 2025 03:56:50 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f8a2sm179399495e9.2.2025.02.18.03.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 03:56:49 -0800 (PST)
Message-ID: <c22f5a47-7fe0-4e83-8a0c-6da78143ceb3@redhat.com>
Date: Tue, 18 Feb 2025 12:56:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, pierre@stackhpc.com,
 Dan Carpenter <error27@gmail.com>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
 <Z69MESaQ4cUvIy4z@mev-dev.igk.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z69MESaQ4cUvIy4z@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/25 2:58 PM, Michal Swiatkowski wrote:
> On Fri, Feb 14, 2025 at 02:44:49PM +0100, Andrew Lunn wrote:
>> On Fri, Feb 14, 2025 at 02:24:53PM +0100, Michal Swiatkowski wrote:
>>> Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
>>> from xa_alloc_cyclic() in scheduler code [1]. The same is done in
>>> devlink_rel_alloc().
>>
>> If the same bug exists twice it might exist more times. Did you find
>> this instance by searching the whole tree? Or just networking?
>>
>> This is also something which would be good to have the static
>> analysers check for. I wounder if smatch can check this?
>>
>> 	Andrew
>>
> 
> You are right, I checked only net folder and there are two usage like
> that in drivers. I will send v2 with wider fixing, thanks.

While at that, please add the suitable fixes tag(s).

Thanks,

Paolo


