Return-Path: <netdev+bounces-129906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56183986F81
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4084B232BA
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDFA1A4E81;
	Thu, 26 Sep 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilYAMrmW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA70208CA
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341427; cv=none; b=Fq8IUsUVerNWww9FGOslV3xl0aL/7iywEk7aWh08qYqEujg5vSjCdfHkbyDz2bQqSs9sJG2+ojgykjWqNRgpSL8Z9ZV354lUJr4fyRPH6kKwkMH78xKRQtrj731mSahtMRaaL+G13CX5VFvradW0v498tgFfuH6ZG5RrRxQD7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341427; c=relaxed/simple;
	bh=5b9mweUAaDSj84VvXz+F6ZWoArtYwfW0voyzXonEC9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3zdJOyYDieAYhx7Sv0DJeeLM0Wrsb1Dyeuss09JH/E5L3wL/nsva9TVucbOBhK1YoooLvGtk0xoQ/gevQvS5u6t9Ag5WzZSsF8FHfQreCG3FcQxbAYhOOSvRjb+Iqbgb4qdOs0xQXAqgIajK9F+rkjjL42K2MRel7Z4suBqT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilYAMrmW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727341424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeYgnZ1NLeFfc15a27WcTDPKUY4Xom7TLrWj14jy8pE=;
	b=ilYAMrmWqoWjzZNJhDWWWojwONBr0h7DsFcx6Z1gm7KrIeaN5G5x0D/aON/MCnoAqb5mAJ
	SuNlOXZAzF6+Q7KogUT53vrcwxERRHW6R5TP7EZ1lGfbTC2kSaN26um39ThZDAr33J8SLq
	xZs1MyosyAikFYX0W7muD/I20rDThdg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-V_UYsF0xMECwE4GOV0kOgA-1; Thu, 26 Sep 2024 05:03:42 -0400
X-MC-Unique: V_UYsF0xMECwE4GOV0kOgA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37ccbace251so363501f8f.3
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341421; x=1727946221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeYgnZ1NLeFfc15a27WcTDPKUY4Xom7TLrWj14jy8pE=;
        b=fMaZpXCXQVTSbxhNAhQb5Anz5yUEDPQ4rn25//3PXiDJhvhFDvRRJNtJwEDZ67JfiV
         nazDddouqCgWX61gyxUeacOcf3dOqiTlRWxea7u8aUNPA8W26jnJQsID6s+u2nMWiObY
         KjiKzC9QKVtPe+gV6OropBUctdR958jAjNP+vK+Peh+ZGO0WDeybEqGgFb8L+zB0o/q9
         Cfwc8oNwPeKU1iMw9nHjTTqhb1/IlSdW/GDUIilBD5MGW5DkTvECFg69NfskY4f1UUsi
         +mhG2XbKA+Y7x3/wDYFdCmFXBwy4SfV56YL3AaLgXXhkGnS1z/7ajXp/CEFx0fgCdY1O
         REgw==
X-Gm-Message-State: AOJu0YzT3SzsI8quTZG+k7oAikaylgwsEq9gP7dfX85g44zr8rDskTOb
	zy/718Kp8Rp0hcouTKexc2coRd3WycFx8ziXHo+OtfCYoKS70NWrpEQXilIIZFWLC2NHr7V963i
	sqLMBDd/k9GdSBtKUOnTF4dYG+I+ydi3lB7Z0DFfN+4t/f/lSOc4YjQ==
X-Received: by 2002:adf:c04c:0:b0:374:c8e0:d76b with SMTP id ffacd0b85a97d-37cc245b083mr3770706f8f.6.1727341421613;
        Thu, 26 Sep 2024 02:03:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk2ngBr1QbZQb/K4S/LQ0JgJDBPWxzQZCoDjZ0iQBJMVTjcdGhO4Q3QhXtAkiHpVsmTPOlPw==
X-Received: by 2002:adf:c04c:0:b0:374:c8e0:d76b with SMTP id ffacd0b85a97d-37cc245b083mr3770685f8f.6.1727341421145;
        Thu, 26 Sep 2024 02:03:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ccc93f115sm2469665f8f.21.2024.09.26.02.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 02:03:40 -0700 (PDT)
Message-ID: <fd29c5e5-219d-44ad-8403-1abe4015f75c@redhat.com>
Date: Thu, 26 Sep 2024 11:03:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests/net: packetdrill: increase timing tolerance
 in debug mode
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, sdf@fomichev.me, matttbe@kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
References: <20240919124412.3014326-1-willemdebruijn.kernel@gmail.com>
 <ZuyR0JuU_H3MvEmX@mini-arch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZuyR0JuU_H3MvEmX@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 23:04, Stanislav Fomichev wrote:
> On 09/19, Willem de Bruijn wrote:
>> From: Willem de Bruijn <willemb@google.com>
>>
>> Some packetdrill tests are flaky in debug mode. As discussed, increase
>> tolerance.
>>
>> We have been doing this for debug builds outside ksft too.
>>
>> Previous setting was 10000. A manual 50 runs in virtme-ng showed two
>> failures that needed 12000. To be on the safe side, Increase to 14000.
>>
>> Link: https://lore.kernel.org/netdev/Zuhhe4-MQHd3EkfN@mini-arch/
>> Fixes: 1e42f73fd3c2 ("selftests/net: packetdrill: import tcp/zerocopy")
>> Reported-by: Stanislav Fomichev <sdf@fomichev.me>
>> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Thanks! Should probably go to net-next though? (Not sure what's
> the bar for selftests fixes for 'net')

FTR, we want this kind of fixes in net, to reach self-test stability in 
both trees ASAP.

Cheers,

Paolo


