Return-Path: <netdev+bounces-190746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD3AAB896E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29198166C66
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCFE1E5B9A;
	Thu, 15 May 2025 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFuuNM4d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC91DE4C2
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319255; cv=none; b=ZS6S4tJSyx3p1m+azIxbmMTtfUT2VXT3HwsFOfasuM0Pk33Fd54dckMK/P/eVexYo2Ex6bJm/nBBxQBtCPGF7cIGufReu+4HdaRLpmosbilTTwZGuvvbp4TwzQ1hArBpoS6+FKO3ENRoFgzZ95iljdcAua229CKcAHikAlvlpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319255; c=relaxed/simple;
	bh=CrapUCqtIZ64bZ3SgviGRhkKvc64KRNrgaWs4qmblys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6MFPG7p8/J/8jcI1qAOGCFjEGnIoDcTMfCpIkepN5qYjZuuhMRmvTBSlr/5vh8sKinx9IejaVwEpoHvN280xiyr7oxbSjPAUEZA+1bXBXEeMF7+eJyQpIEPbolsVD/9prYaVzR42cb2xQyLPqpVi1cuKKdLxROha9JiQFVV5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFuuNM4d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747319252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huz51ddnBUzqXDXluJaM4urWwAvADCicLLosUlW1Gco=;
	b=hFuuNM4d9gax8uVsZbO4hvOGAvmmswSF4gk8EAeXisschrx/KBpM9+/eQkT0e/qmy8O8e9
	zeHOStxfjLKLVnGRAqEF0OmK0fqQjG3HXRYGY1KK+eAnI9185sgZu/r5G/OAFYRk3fEoxS
	FDSc7IDCR4pZ4t6+AAeECM9N70rR7lo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-D8LZddnFNPuR4lYwP2qxzw-1; Thu, 15 May 2025 10:27:30 -0400
X-MC-Unique: D8LZddnFNPuR4lYwP2qxzw-1
X-Mimecast-MFC-AGG-ID: D8LZddnFNPuR4lYwP2qxzw_1747319250
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0b570a73eso632402f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 07:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747319249; x=1747924049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huz51ddnBUzqXDXluJaM4urWwAvADCicLLosUlW1Gco=;
        b=kdadNqP/9BK96UJ5zzXs6fYSrWbt7ou8mBiO8cKSssbL8+ZRmtkKSDGgt6Mkw+iPrF
         RxK9OyfXYLNN8QXbyHKI38EEhwIZpAoM5+JvZGuwz50F9mjUQ2qvk5V9krnG+COz25I/
         bAwQ1yobEIaMoWuLf3ZVQhGz32vSaSpfCFjDxTwOhm3z8cilrED5/b8Lg07OYjToKl2N
         AnadHCcfqDbJz1Rltmy8W6UCt8UBvqoN6CHMRpHVEVWYEBtY8dvfFRt6/s1ME/yuHUO9
         uZae6Z02V8RZVYIQsdr9eeOS6fcQInu85c+fl3CuCiLujIav7gNEB0XrdDI/wR/Jdi55
         v/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1swEoXF3p0ZRroH25ktK0HpesLoBDkU7/55HhNfkB8KXAG2pVrngR94hG72+aQAeHQWoY0Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+ulhqGYUrxd2Xl1Cog8obTiLUq41BvSw+BrW65TDcJvnoH8Z
	4TUeMiTeNZUKVcgP21PCwL7EKSDN6V4+H0abYFQPs8LxwWMWojggwrRfBGGWuOpCw9Uf32hNFuU
	fsNGrSbEMeClBcBAYBJGNKlGXe3blmznBjY8FYSZIT2z8ersleFlvIghOYqW5eWki
X-Gm-Gg: ASbGncsYjM+RNF6r0ETq9aBQCLj89j1C9tRgTG6h/uhFSBO6erw8ShyyHyg2A2ht+bf
	QbYEpHdoZurBmRZyFGB7JJHk1KP9YnVmUs4oxnH1pmW2up7Ngj4nCgda3PKUaRtrOg5g6TdH3RE
	XEoTJ22z7m4fjxk1v4GWNpqT13tGhChEMWdwAxsHfq2XxkCUmmzLcQlQF8SE9E2mFFy2kr/imbr
	DjV+OFF3NxR5+J7xIzgJFvt8tyin6kDzukqWGPFwJ0IdxGYY+hWRQWGusSujwOlpO9GymrzqXWZ
	yHqOiyMiPVSDnRq0POU=
X-Received: by 2002:a05:6000:1a8d:b0:3a0:b979:4e7c with SMTP id ffacd0b85a97d-3a349699b9bmr6954410f8f.3.1747319249245;
        Thu, 15 May 2025 07:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqqzNDS8gHcKXPhus7Y5b5W05r7fTBd+OoE1w+5qSXRDsxkK+I6bPjSes89yOPcONJkNsChw==
X-Received: by 2002:a05:6000:1a8d:b0:3a0:b979:4e7c with SMTP id ffacd0b85a97d-3a349699b9bmr6954387f8f.3.1747319248915;
        Thu, 15 May 2025 07:27:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010::f39? ([2a0d:3344:2440:8010::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2ceccsm23174624f8f.64.2025.05.15.07.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 07:27:28 -0700 (PDT)
Message-ID: <9d16bff8-1a8f-404b-a5eb-6da5321a3bb8@redhat.com>
Date: Thu, 15 May 2025 16:27:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] WARNING in ipmr_rules_exit
To: Guoyu Yin <y04609127@gmail.com>, davem@davemloft.net
Cc: dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAJNGr6tmGa7_tq8+zDqQx1=8u6G+VtHPqSg1mRYqTDqT986buQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAJNGr6tmGa7_tq8+zDqQx1=8u6G+VtHPqSg1mRYqTDqT986buQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 1:37 PM, Guoyu Yin wrote:
> I discovered a kernel crash using the Syzkaller framework, described
> as "WARNING in ipmr_rules_exit." This issue occurs in the
> ipmr_free_table function at net/ipv4/ipmr.c:440, specifically when
> ipmr_rules_exit calls ipmr_free_table, triggering the
> WARN_ON_ONCE(!ipmr_can_free_table(net)); warning.
> 
> From the call stack, this warning is triggered during the exit of a
> network namespace, specifically in ipmr_net_exit_batch when calling
> ipmr_rules_exit. The warning indicates that ipmr_can_free_table
> returned false, suggesting that the mrt table may still have active
> data structures when attempting to free it.

Thanks for the report, I could actually reproduce the splat. I'm testing
a patch I hope to share it soon.

For the record, the above analysis is incorrect: the warning is
triggered by a netns creation failure, not at netns exit time; the
problem is that the running kernel has:

# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set

and the ipmr_can_free_table() implementation in such case is
incomplete/wrong.

Cheers,

Paolo


