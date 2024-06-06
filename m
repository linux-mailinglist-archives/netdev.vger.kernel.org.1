Return-Path: <netdev+bounces-101305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FDB8FE196
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D826283838
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E9713F00C;
	Thu,  6 Jun 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="RjB119h3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C713EFEE
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663821; cv=none; b=TIJYc1bC8f7HpAEQ96St4KI/+UD1GQHCSi3J6j9cwBqmEw60bCPbpuyXcq8LHdPfsRWo0oZf/IzPbbaIUxvIoWy5ieCp28Y9ocpeESZBU9ziVwvSrm57OsCsUeAc085uA3A4DmaWXqXMtx5bZBFrV398CDBwxBfotgH97SvEiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663821; c=relaxed/simple;
	bh=fKeTjAPhpgPsWq4GdMDq38rg6e6BMr9O/N8udZOSBeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMvqLp3eVxFkyFhEq/QIfK4z2PqjrMOWCKlHaq/OBEadvY8/dXXMchfwUmqkL3KR99z8LYpIV6tGgKbX4bQnz4WhZPw1ee2UpkOwDhvsIjIutRVnvjVkFbJtNUDYmQJOfcljC9cAWK1P8gcYiJ3lA6IMB+fHM0Jhb1uLhW8Q+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=RjB119h3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-354be94c874so510281f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1717663818; x=1718268618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PxWU+9lYozj5DWkx+LLQsi+O6+PPAo2sgtQziLiGW4c=;
        b=RjB119h3lE+jbnoLKkJJyzXGKfuNmA4cmtc1uSv1Vs4Sva45ts2eFv7ik/P/NkPmx9
         nsYdpCM9CExk12MCu5X/oJ0d+AbMMm5jam9wAbf15WaPFhvqLUNMRutJdk0Oxxp88+Z+
         E5CROUIQkfc+hmMcV3xDMODrMblXrbH/dr/KHBmGv0yzD0gW6M88SYRoR5Y3rIwIdAuU
         /G5RATHXafzuJsx4wQ+WrGz9B6EvG7L7HHqgTM6yd848UxZWp8vOZuoFUYb7iUsK2cVR
         oQ2lA1+uJyOwRTRmQwoA3hoSiZKVc0UTEBZXIvcPZMxdJDickFmnKxTyEZtrMIsqpgtA
         xeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663818; x=1718268618;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxWU+9lYozj5DWkx+LLQsi+O6+PPAo2sgtQziLiGW4c=;
        b=i830fx3k2k6hhJUoe8wA34cbtj8gFpQ7N+lTGHr5yruzlnfSbssdU/rvhsvs2/7K4F
         KCCZcvj90uymYd0WUlvWECXb8sKwfN+loydf82V/2Prx8OOZl0xzh9XMEcs4dPi16N4J
         tzrA7iHwA/URPcszI6wyIJSahFtIDNEEgqVTYbP27RrzkMzV+Wc0sbjrrxxTR+A5agLr
         PTaN8yK2dKPWddeEUc1KFFIzgX0Nl/mZoeTus5bnUOsG1CBKPCM5FpdFceQ9KhkH888e
         D14M4GVaFQttYeB2aWWm0RlKRJ69xi8k8+tkn3ft0Bodmc3de9m+lHrpF5iChc8Fn82M
         pO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCoF0rjiEV/+aW9xSEkN9uoU2LG9u3zYR33qG5e1NNx6B/kDRUokFSkW0+LE9MniDcFDpvklf7Zu04IBfc5Kg8XkpA/m6k
X-Gm-Message-State: AOJu0YxNOQv5gOURCfthrcWFTi0cbgAPV0qHGfecITlvr23huRUSfBXE
	cgVoeOJklNAMBcpWeQd1kVVhw9iS3+A8XaRSdbjYpzOYQNAS9KU5OzqLw4v/8x3vfDTD5Sc0YuT
	G
X-Google-Smtp-Source: AGHT+IG5MkXgNS/PlTXWd7WIctKvTQ9YsLcsO10D9pz2VhPV6GzPkSdc37hUp1xcFf2HLsrgiA5Epw==
X-Received: by 2002:a5d:5547:0:b0:355:3f6:1ba4 with SMTP id ffacd0b85a97d-35e929c891bmr3913879f8f.64.1717663817968;
        Thu, 06 Jun 2024 01:50:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:ff33:6de4:d126:4280? ([2a01:e0a:b41:c160:ff33:6de4:d126:4280])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29a85sm983551f8f.10.2024.06.06.01.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:50:17 -0700 (PDT)
Message-ID: <1eafd4a6-8a7e-48d7-b0a5-6f0f328cf7db@6wind.com>
Date: Thu, 6 Jun 2024 10:50:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH nf] netfilter: restore default behavior for
 nf_conntrack_events
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, stable@vger.kernel.org
References: <20240604135438.2613064-1-nicolas.dichtel@6wind.com>
 <ZmAn7VcLHsdAI8Xg@strlen.de> <c527582b-05dd-45bf-a9b1-2499b01280ee@6wind.com>
 <ZmCxb2MqzeQPDFZt@calendula>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZmCxb2MqzeQPDFZt@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/06/2024 à 20:41, Pablo Neira Ayuso a écrit :
> On Wed, Jun 05, 2024 at 11:09:31AM +0200, Nicolas Dichtel wrote:
>> Le 05/06/2024 à 10:55, Florian Westphal a écrit :
>>> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>>>> Since the below commit, there are regressions for legacy setups:
>>>> 1/ conntracks are created while there are no listener
>>>> 2/ a listener starts and dumps all conntracks to get the current state
>>>> 3/ conntracks deleted before the listener has started are not advertised
>>>>
>>>> This is problematic in containers, where conntracks could be created early.
>>>> This sysctl is part of unsafe sysctl and could not be changed easily in
>>>> some environments.
>>>>
>>>> Let's switch back to the legacy behavior.
>>>
>>> :-(
>>>
>>> Would it be possible to resolve this for containers by setting
>>> the container default to 1 if init_net had it changed to 1 at netns
>>> creation time?
>>
>> When we have access to the host, it is possible to allow the configuration of
>> this (unsafe) sysctl for the pod. But there are cases where we don't have access
>> to the host.
>>
>> https://docs.openshift.com/container-platform/4.9/nodes/containers/nodes-containers-sysctls.html#nodes-containers-sysctls-unsafe_nodes-containers-using
> 
> conntrack is enabled on-demand by the ruleset these days, such monitor
> process could be created _before_ the ruleset is loaded?
It's not so easy :) There are several modules in the system.

I understand it's "sad" to keep nf_conntrack_events=1, but this change breaks
the backward compatibility. A container migrated to a host with a recent kernel
is broken.
Usually, in the networking stack, sysctl are added to keep the legacy behavior
and enable new systems to use "modern" features. There are a lot of examples :)

