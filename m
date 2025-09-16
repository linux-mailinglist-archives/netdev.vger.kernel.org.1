Return-Path: <netdev+bounces-223763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952DB7F6D9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5CB3B8CF4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FED2EAB66;
	Tue, 16 Sep 2025 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RaJg9tNr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610A2E92D1
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063566; cv=none; b=P+KnXyeR+/b2FwmCmr1SKI8lpHW3/bJssVVkiASzTQh5j/xsJY+SCivFyAJyVEsmVqfg6y9S2/LlEyYuzFLlj6E5dt+NBHW9M/34SC1YX17bXXNkRo79WRn1LB1wzdMjma6aNzQk4y70kp7D5pCNBluVjBLBOIY+rkqmcsYWIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063566; c=relaxed/simple;
	bh=kYWD/1pnHOiVcV/86OAJQo2hlBq8UVutDfZZWO+nnUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SX9ASY7Awq+uOm3JFuMUsKuW0jkD5cdHNMyzqHHxCB5po5f3U/dBwMlqlVTjAOquGIdXQqX01sXg9H6UeLgW+B2XJdpicovUDJR8bY4qje/fx8fFLUE6rQ4VSLG5pC/tzXhAgAotZJnsZdv73SU5ntW51SwUVAPt0l2c93k/Uiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RaJg9tNr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-827906ef3aeso341191685a.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758063563; x=1758668363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2Sobvr9+5pGFbp47+ByPtEfYFFz5lnTSyJG9VlL420=;
        b=RaJg9tNrYLCV4vFhW3l2kOjm8ZyYitbIFQi0+ddGYWu5r/uh7Ql4Hl+ELB4YG/pyim
         UI25Iza0iTfYwvoIZt2oallEWaQPBBYeD59UWr7EEpS5LkNz9ogLH9GKDBvj/jxQv4+E
         wIiBtp9zLKtjp8+tyAOulREJoddlqFqOTF6z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758063563; x=1758668363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2Sobvr9+5pGFbp47+ByPtEfYFFz5lnTSyJG9VlL420=;
        b=FMmhCCZZwhoe+S4vgX4i6/xmUNENmfkI+7jNrajXmel3bQIUdcujdAPrG1kxd47WK+
         Qoai7V8S5VGOYNB9DSK0xcqOYy96ByLFCzyYGtovi97E8OZWrZJaTs9q/rpdtAk7hu8D
         eJaZOe5jrVNOG5BNKDDnRwaF/MRRJYjJnuKslDPiB4lRND0R95/RuFCK1XggezR3UVjq
         mW1819JVrqAaDe9I5AXgTeEVTvqpml5zSuLsQxOPnwrVl7evo7SsiqWdOvnupdkRX/K9
         IJuaI4Yh/lb8PRMzSa+XmqFnEG7dHf7PfHmNV62iONFx6v7h6l9ipccPa7Yo+B5hxBNj
         3LAg==
X-Forwarded-Encrypted: i=1; AJvYcCXS5FmVng66a8QzDFgiLSBF+6k1KGYve4o6p6qfokmPUaAIFaTsyqR6vpHQ84RTPfciptGTEBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRbV7xsfd8NRgg2nogJaeLS2XXHaaRsp1gtaFOuan/ufYvt4F
	NBF7IGL+Iz+NiqQc8MW9mJT7E6+rYgNkXEFRJ4K7+NhdKzwlwMEeeTMAx+Bm0gUBvUU=
X-Gm-Gg: ASbGncuXeyt7YuSgwRADzmcHY0CnVPoAVdL0TXSRFL8jsKuxHD1Aq7Gypsv0XfMjUfT
	3aP0CS7qDH4i++LXKwOyvt0Of/mRPS+LO/tb+JoG9SSPxmGR8+yOmnnDjEeANfoX5aZeGTrwuYB
	sml1qXu5DxeFJ/XTnkmGQSz10RULRo3A/LPw3O4CLPz/rCLNeoqrgS9IM67jZCVPGDF544s6VAa
	bnVM3dY5CAN/uC1D+PT/75Xtc0IsUKHEZyB882uS7DcWqQYCZDlo3volvtpDFNDX9pu1DC8Ku0C
	aUGNSVpLfK3iCZSI+bg4QYe2Tz2ByqFzDLLQJBV/gP6jf3vf/YINXqgEt3quQBzEaljH9By4cpW
	5XJk6MRS3R2s4RBxvqmc+GhUT0Imfbyv0jUVVQ3amDb6loG+mvD8j6jUXC9cqtPPwz3LC4xH8D8
	nfZtoLhE4rRcGR8EXqoNyzETCIenkHr7H7E9ADykMxz6c=
X-Google-Smtp-Source: AGHT+IHPewFSAtglBYb72x7KGBoL3MPQo1PXWAxums+c5Qp8pXMLQan4rC8XJhOv0uEYkxN+tL5s9A==
X-Received: by 2002:a05:620a:4629:b0:828:ee0c:64da with SMTP id af79cd13be357-8310f02c9fcmr5639285a.43.1758063562631;
        Tue, 16 Sep 2025 15:59:22 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8281e956653sm613334885a.32.2025.09.16.15.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:59:22 -0700 (PDT)
Message-ID: <fef87364-80e9-4cbb-909d-22b1af0e9d3f@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:59:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/Makefile: include $(INSTALL_DEP_TARGETS) in
 clean target to clean net/lib dependency
To: Jakub Kicinski <kuba@kernel.org>, Nai-Chen Cheng <bleach1827@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com>
 <20250911164137.29da651f@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250911164137.29da651f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 17:41, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 19:30:32 +0800 Nai-Chen Cheng wrote:
>> The selftests 'make clean' does not clean the net/lib because it only
>> processes $(TARGETS) and ignores $(INSTALL_DEP_TARGETS). This leaves
>> compiled objects in net/lib after cleaning, requiring manual cleanup.
>>
>> Include $(INSTALL_DEP_TARGETS) in clean target to ensure net/lib
>> dependency is properly cleaned.
> 
> Shuah, please LMK if think it makes sense for netdev to take this
> (net/lib is the only DEP_TARGET today).

No problems - take this through netdev

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

