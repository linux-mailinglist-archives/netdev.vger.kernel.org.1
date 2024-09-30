Return-Path: <netdev+bounces-130621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7CB98AEBB
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4991C21642
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F211A0BD8;
	Mon, 30 Sep 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTrI058P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8358174EF0;
	Mon, 30 Sep 2024 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729763; cv=none; b=LYm/OXOJfMuVrWq4VTpXp99jswZT1aq5hAm8XaEwecoXPUKzN/8Ik8tM6fN3BBsLlPT3I6H6AsHUE9ZIaivoDdiq9Y8jm8u/ZxrKuSV1YB3DhguZ/Hb2nN6ycTdOcgDzrCqGowh4jVRRiknvaGSvYhhYe2p3/l/30SoagAWfQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729763; c=relaxed/simple;
	bh=y0RvsU7nugqyicUkj7bT+63/7d9kmv//IXedaGisUCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9wX46RJ8y3ooLV9jZoIwnMLDEnixR/hXj37UI2/Hi2Ijk6zeYPf7wExeYT1NO41MlsebhK+9vCt+4W7ltOi7CXHgFhHQQvbIhnGrTnKleWNga9gHCmxLRBlweUrv8jvPZ8cOzikpWTSvIOrV9SqgXd7W+YnnAjeCL1s/H36MS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTrI058P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso38605625e9.0;
        Mon, 30 Sep 2024 13:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727729760; x=1728334560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/wBMiz3BliJwUd9ICTT2Co/DwD6NPT2KvaPvZRb1tM=;
        b=eTrI058PS3h8K21wgV/l80z1GV0ZyjPEcKBrAMBkdNYhHwFebImOMicMg6g4pgs0Ec
         Hu4RphjO6Nd/DU/BowFzX5DYfIaSS144b/tjwNSSGxdivg2n/2NrdGeIvfKouMe1Usk/
         Fgf0HNPCpmBnIESKcvQV4l0HspYJqFGLwzPedqucsNeJ3lXr82oLWcX/i1fw3nqN1nBU
         1s5uV80/8/Sn0YmYmGyn9oX41VBkAU68C3yC1iTIhAG97wX972CuMauNaZr+y7UTzW7+
         nS05jSqPUem12NB5IzP7faZPQs36mIkGXgxGSYkeDWJPAMkueKHHCZwNVQPJpRwNb6F/
         dwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729760; x=1728334560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/wBMiz3BliJwUd9ICTT2Co/DwD6NPT2KvaPvZRb1tM=;
        b=wk2C6A/b73DEGfenpe/jXkf5aCQ7TVpu9S5HkFaR7COX7Kf46pdbgKZ6C7s7nmiDh7
         idg8dWagPIoqcD3aq60Fb/dhwL6Vx4KDV8zLg0dUboMpq78O87ol8CF1SdkOT3PZaJSy
         OUNmzkwO9aY7EFiiG5KNSVSGXofBODNvNynyBdzbYFL0LQjbmeUg7SksFnUWQYA2qyZu
         OAwY9vF7CwiJSAAW3QPjiRlOH/kOj3+JtZZbmeM1J+r4yvDQgjxLeaisTpWCIKWd+4di
         o0CMnzO/PNCiPMPpUnl5ziVRz6kT9YXGd5kye/bH4sP0kppDiV4EBM646c8MhM5I95xL
         DnNg==
X-Forwarded-Encrypted: i=1; AJvYcCUyafOMm7jQMwQNiRcvejTS2gmZweuwH3vMZ1K4UetKD+1pYMAuU2Yd+fDvLdbawf12IWFgLQ95@vger.kernel.org, AJvYcCWK02aMbH4D7o1iHroNqEjnfIcoOR38LzrOUTWFAwno2DVkNieFg6s/9A4CAwYY12NpyuWrJNSzvIjqYaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzthzQtYRwX7y1eFasocGTiPKKofUAys27f4Tj8zdIIgdLnV8j5
	K+iGwXb+YD1PG46UOvNr9mz/SB+KVKYJXifh4NW40bdJLK+TtBFn
X-Google-Smtp-Source: AGHT+IGP0WleTZOClF7vOvSMP1JJiLeakNfDSafe5JVBV8kep9IZqSFC+2JhyH0ul+91hYbFOHhotg==
X-Received: by 2002:a05:600c:190a:b0:42c:b0a4:6b67 with SMTP id 5b1f17b1804b1-42f5849bdbdmr93767275e9.34.1727729759874;
        Mon, 30 Sep 2024 13:55:59 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:62e6:45b0:eada:c8ab? (2a02-8389-41cf-e200-62e6-45b0-eada-c8ab.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:62e6:45b0:eada:c8ab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e612sm10238694f8f.42.2024.09.30.13.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:55:58 -0700 (PDT)
Message-ID: <7364e0f1-9651-40f1-8a6d-7a592f59ae70@gmail.com>
Date: Mon, 30 Sep 2024 22:55:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: switch to scoped
 device_for_each_child_node()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240930-net-device_for_each_child_node_scoped-v2-0-35f09333c1d7@gmail.com>
 <fa6e7b93-87d2-4dbd-a61c-cf1d9e7f7141@lunn.ch>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <fa6e7b93-87d2-4dbd-a61c-cf1d9e7f7141@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2024 22:47, Andrew Lunn wrote:
> On Mon, Sep 30, 2024 at 10:38:24PM +0200, Javier Carrasco wrote:
>> This series switches from the device_for_each_child_node() macro to its
>> scoped variant. This makes the code more robust if new early exits are
>> added to the loops, because there is no need for explicit calls to
>> fwnode_handle_put(), which also simplifies existing code.
>>
>> The non-scoped macros to walk over nodes turn error-prone as soon as
>> the loop contains early exits (break, goto, return), and patches to
>> fix them show up regularly, sometimes due to new error paths in an
>> existing loop [1].
>>
>> Note that the child node is now declared in the macro, and therefore the
>> explicit declaration is no longer required.
>>
>> The general functionality should not be affected by this modification.
>> If functional changes are found, please report them back as errors.
>>
>> Link:
>> https://lore.kernel.org/all/20240901160829.709296395@linuxfoundation.org/
>> [1]
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>> Changes in v2:
>> - Rebase onto net-next.
>> - Fix commit messages (incomplete path, missing net-next prefix).
>> - Link to v1: https://lore.kernel.org/r/20240930-net-device_for_each_child_node_scoped-v1-0-bbdd7f9fd649@gmail.com
> 
> Much better.
> 
> Just watch out for the 24 hour rule between reposts. Reposting too
> fast results in wasted time. Reviewers see you v1 and give comments on
> it without knowing there is a v2 which might have the issues
> fixed. And you might ignore those late comments on v1 ...
> 
> I will wait a day or two to review the actual patches, to give others
> time to take a look.
> 
>   Andrew

Thanks again, the commit messages were so broken that I thought the
series would not be taken into account, especially after your reply. But
you are right, it could confuse reviewers and we are definitely not in a
hurry :)

Best regards,
Javier Carrasco

