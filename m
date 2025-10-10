Return-Path: <netdev+bounces-228541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239EFBCDA2A
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643443A6053
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C18D2F7454;
	Fri, 10 Oct 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnHU/lEU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A42F3C20
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108197; cv=none; b=FhtUaPbOPWGPo1+G/O3Ll+sxgIsh1Vs4Vz+iz6uaomld8IHqJi7QrK0wNBaIq/cQOPm9DSuTgpnm1YtKLZnKyod13AhFL9+6QUnE2e1nalGQz1HW6wcFbNyZJqq1AxHc+RDtx/lEx5sM/Kzq4swQbmgoasoIzIaqftOdvaO/ozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108197; c=relaxed/simple;
	bh=1Jhcg0xv8VWaEgihjzPeUziID4oG3ExKtqP9zC0KWCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4ssGmjA5s/R194gK08tpxWccjvqzCKIG6tx82vzBEmRh52b4M94SMVfNh/KcpwwFwTg9y/RenBEa6gCUr+43HMe+7QGmMY12HKxODS9zJ5ZiIWLq54vBGJq0MDPVDQvdv8ty7uuxmlM2CTr2JY03RDQFRWz/b8BgSpwHK9jdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnHU/lEU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760108194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1P5X+NGWefQQJqZl15++e1LnM8GbiR8ChaM6QOBRs6E=;
	b=VnHU/lEUMarqMKZGXISFJSNs2O9utbb6/GGG4sc5Ki79q0NxyDtacUfTW1bcGJLZxAZ8Md
	efwJ4EjDVs66JreqLFc1uggKTJBDiWB9CfO/uKJbRopTZZyIQKRpIaIH/LCCK3ClHiie1s
	u9zbFUbl7fPGd6qfgQQJwosp3h37rTo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-iv7ZiMsEOvWdOMWj-62oyQ-1; Fri, 10 Oct 2025 10:56:32 -0400
X-MC-Unique: iv7ZiMsEOvWdOMWj-62oyQ-1
X-Mimecast-MFC-AGG-ID: iv7ZiMsEOvWdOMWj-62oyQ_1760108192
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b4068ff9c19so370096866b.0
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108191; x=1760712991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P5X+NGWefQQJqZl15++e1LnM8GbiR8ChaM6QOBRs6E=;
        b=GZyukpvCRbZnn5s0xxAamka1mdGrPGtayGK7L9Fv1LSnx8LiPWxO0F1cZse6mG8V4i
         Ah7gi60B0itlh44+YoBgXrZla8NM1ydPo1hNWYCA6Y6mm/Bz0mzSqimb/8TsGGnBGnBl
         Svr7AfAFcRvv6Dgop/f15bBmzwZVAiD67xm+3lUnBotonWX891zItdS3aaGEPMmBfo7i
         NipVie/4xUZAAxixfm1n5suim3RCe1MoAp5xNKY+FkdhDf1uZ6+RzwOvlxx8Oy/yPNDJ
         iMpVm8/ilC1VPUCbejyMnTyA8NS/DTIuDRQ3gYWN0SjlA4JUzvIb1Mp5tnAtt3z/er4U
         yVKg==
X-Gm-Message-State: AOJu0YySztKi8WxKMLED75bs3q7P3vNol+lExoqxh3SoactTzx/HPl90
	m5tmMmu2wiksAN67He7Sj4KdvYJrbrO10TRrvLyoYUfZ4ZBu5q8RXf2CMSMWNK9r86KRGEwDZnf
	AMwI3mg/25vpYuQYxjdJo2H2AwKJ0ZlCPpLjxNlTQLztf6NQP9F2sZykJeg==
X-Gm-Gg: ASbGncuK/ipmf8Zj3Sr8c5gOPz3StJQClg7WVqFbu9lPM18F7C1PNYgkkdW8aH6Tlsl
	0GQjMLxQiZRO6uiM82aFQnaHl04hCC8VzPUA26u5ZSH9lKLYj6iepkfDmRnkIkIztkQzxubE2mo
	Xu+7acZOf/on7mKwVBJYei3McAg6JDhfus+rotUA60nyPdHKneSLzA1dUIDIGtL09EmCFEeYQWz
	37+hV0/kPV7Z7vt4jn5ADxR38U30jFf2r4UFkK7tAQ2KSVOnD2ZF6Tk18HG577J+9R3EvSYfVDy
	cCXkkTiLQFRaGE5EHV9zbp7qXSJfIaZd1uvEKjke+BXgfA3eCiAtF8DVqFOKa+bXGvUJO0ZZ+1j
	jXhlcklIjzpES
X-Received: by 2002:a17:907:ea5:b0:b3f:f822:2db2 with SMTP id a640c23a62f3a-b50a9c5b35emr1276357666b.11.1760108191619;
        Fri, 10 Oct 2025 07:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9U3OHPHv03/njQrGc9l3W5M5GCK0ZytbxV4E62A/ghGcguoBHcO5uBfWotYvFJEwS98Ry+Q==
X-Received: by 2002:a17:907:ea5:b0:b3f:f822:2db2 with SMTP id a640c23a62f3a-b50a9c5b35emr1276355066b.11.1760108191199;
        Fri, 10 Oct 2025 07:56:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacbeesm240224566b.15.2025.10.10.07.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:56:30 -0700 (PDT)
Message-ID: <bd3149e8-e213-48b0-8f8a-0888d1837b84@redhat.com>
Date: Fri, 10 Oct 2025 16:56:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: check jq command is supported
To: Wang Liang <wangliang74@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20251010033043.140501-1-wangliang74@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251010033043.140501-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 5:30 AM, Wang Liang wrote:
> The jq command is used in vlan_bridge_binding.sh, if it is not supported,
> the test will spam the following log.
> 
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # TEST: Test bridge_binding on->off when lower down                   [FAIL]
>   #       Got operstate of , expected 0
> 
> The rtnetlink.sh has the same problem. It makes sense to check if jq is
> installed before running these tests. After this patch, the
> vlan_bridge_binding.sh skipped if jq is not supported:
> 
>   # timeout set to 3600
>   # selftests: net: vlan_bridge_binding.sh
>   # TEST: jq not installed                                              [SKIP]
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

This looks more a fix than net-next material (and net-next is currently
closed for the merge window).

Please re-post for net including suitable fixes tag(s). You can retain
Hangbin's ack.

Thanks,

Paolo


