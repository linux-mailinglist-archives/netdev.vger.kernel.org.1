Return-Path: <netdev+bounces-108577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1B29246F8
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B191F262E0
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6291C230E;
	Tue,  2 Jul 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Sp69Hvd/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862B1C0076
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943537; cv=none; b=Dc00/apce0N04Qco/Lb4qlfN0jA4FpW2d+GEeuXEqjaZ4Q386abMMyZg9Gh0EYEImwEVevIG6qYCpszMQot8dLoInH7opiHhJJ4psZWiAq8sXrtKbkgXqURjsLIHISiKIp9BumolqyAFcGatUX5Hb4lEib3ni5VWnOZf1HbN5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943537; c=relaxed/simple;
	bh=twNVWEayUkj90VygVSZhIjfJscirXHatl+SKyPaRbL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+Ia/o+1w1hyqDvmnCkg6Cb1iJJqsdKCMDMHvKZjyO11szHuBw1ZQQoP03q5yUFIR060+UdXgNvzAivqoY+1tXXcJ5OfRVXrPaBKQnibX23a4D+LhVrKfWkT3W74KjMYiVF6rA2zcIxq0WEF9Sy0BbvCOUuGy8lvklDeiv3ex2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Sp69Hvd/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70673c32118so2965714b3a.3
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719943535; x=1720548335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K390XL1xyu+DrkN3gpF/Y6Fi3/0zSj6Tg0Yhqbkihg=;
        b=Sp69Hvd/GeF5AXq+3xQGPDO3MD9ZHN/Y0OApfI1QQ/zoRTZf0UPL7KZl3rhN4s21k8
         uofY+bPQ/T7xkGbPDsW9NfpHAqjrc5IBOVUf6si4OoxsAdHB7yk+YE5RuesFaMkf0mho
         PkL29vbASVA0fS7+Nk5+JIRjZQkyMnLrxsYTedP7VIJclJ5qnrwrFjuM+FMMNkBFWAs9
         0qGWwAB4Vdrald42/s8YBOS2ZpHDR7tkPbgQKYlfyGTyUBPJp3i1YQpIAAs8P1W5UiNa
         UzVd+jP805C0h6Q22BiOsIrzh7awnmsessrQS31fLkkAaBQMjrSQWsm/BJelWQH4KHGH
         uZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719943535; x=1720548335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6K390XL1xyu+DrkN3gpF/Y6Fi3/0zSj6Tg0Yhqbkihg=;
        b=k4uoEytj3eE/0vmfCqxWxx9aoIQPoiga2c+WAseScrenK8xmhgkHQ/hTEntMujtJA4
         LRjleLq5LUG/IJWeZw4Fn6OgBX8llSGWnnU0YA4j7nidurkgmRlb1frO3GzHvFHo0arR
         VYP7l/VTwQorbNQXJW5UvpnZP5d5hgMH8Xl5B2vy4aq+Mhbba7bYihrH1bVtDnTZAij2
         uR9wF3YU28pd2u0LUaavjmsoPV1SKo2yAzW42JUMJkWs60p24+Ziv4fmvZkDtjFjSSUx
         sE1xCXntbr+fHJrwdX2UvBRJHK0P0xM1ed0kerLwUgUVfyPsh2cp4sGCizZH6UOlumXS
         ebOw==
X-Forwarded-Encrypted: i=1; AJvYcCX1X6Io1e7vTtSysoSrDlp8f1jABGhsNneTPflIzLI/gyInF3AP3mK8RkjjEcpO57o+QDtHAz016xU9S6xgHoXiJcztye7R
X-Gm-Message-State: AOJu0YztsHXQlo63FMtwuWTZsuJIQWB295fzq35OlNBVOk8MXdb32lY3
	EBpL9EjMGxIM/W53afW5NSUst4TaFpLJ8iFxDG35tPhBfVODLkzZ5s5i7PCg5aM=
X-Google-Smtp-Source: AGHT+IFwdpGD31WgrlXa3ffeeu+Yb9KxkzL0V3qaLfz8hWj/4aJp98GJR5X0V0XEMlQ0E5NjXh8Hlw==
X-Received: by 2002:a05:6a20:7fa9:b0:1be:c3c8:10f3 with SMTP id adf61e73a8af0-1bef611cf07mr9998846637.9.1719943534749;
        Tue, 02 Jul 2024 11:05:34 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce1f18dsm9278022a91.1.2024.07.02.11.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 11:05:34 -0700 (PDT)
Message-ID: <4de9f008-ccb1-4077-b415-d7373caeb3cc@bytedance.com>
Date: Tue, 2 Jul 2024 11:05:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: make order checking verbose in
 msg_zerocopy selftest
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240701225349.3395580-1-zijianzhang@bytedance.com>
 <20240701225349.3395580-3-zijianzhang@bytedance.com>
 <6683fe2acbe92_6506a294e@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <6683fe2acbe92_6506a294e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 6:18 AM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> We find that when lock debugging is on, notifications may not come in
>> order. Thus, we have order checking outputs managed by cfg_verbose, to
>> avoid too many outputs in this case.
>>
>> Fixes: 07b65c5b31ce ("test: add msg_zerocopy test")
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> 
> Why did you split this trivial change out? Anyway..
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> 

I am also conflicted, this change is trivial, but I think it's unrelated
to OOM, thus split it out. Sorry for the confusion, I'll be careful next
time. Thanks for the reviewing and quick reply :)

