Return-Path: <netdev+bounces-143438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A51C9C26F5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EE81C218C5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134E1D0E04;
	Fri,  8 Nov 2024 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHiceaR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3A1DF977
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731100437; cv=none; b=GFcswT8O3AEzjHblKNIV3qdkTLZwW+kSWGPtOQmOidmFcmsAbDTVVzYUxMatMQv2ZqXASvMHb4nAGGx+2xebk7sHoG/QBNVw/ftsjOEXDbjRFV4EmhWbvE3Hhx28rK74SEKJbx97sapkwljs2PsyA5Kuv3wg0qnjKnbKK1t/8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731100437; c=relaxed/simple;
	bh=dmZcozFXIwrWIglv6ehNVJzskFQe2KMvR8UN44nraQw=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ILHxO+l05D+dFS7U2VPV5qY7zWGlD2CJ22k5DA6URLI118SkCXi0lEdJYNsgt8qKNrtcrePSr6DET8TaldBYv5cduW7QqKzbGTgBJ3IlVR38dINgJeaaSnzgM8vAXcA0hJTLanRe6aWD2xaD1ST4WATFYgwzKZvbX+zQlfL3UWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHiceaR5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ec86a67feso431035566b.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 13:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731100434; x=1731705234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wBmcQNeD+UdodxSOQnZD/sFV0XL4QmuclbgKN0z1xE=;
        b=jHiceaR5/tKgooVypOq1At99+z9mguy2iBOFknskCfXNbX1QoXqk2etFc2zF7cXJuO
         TGi2eUgVwwbKMZAKEiszgEH6WjO0+Esrl/suUFMPxqIMHzc2J9CBLt4IA2gdyJgOCRjk
         nTvvhKCKRHomXFmRPqSVCAz99lTzhvYgXwSN7boms/PUTwJ0xj0zGu1NkSrYi4+mnP41
         ICMhO6HUrO2EpmgjWg9RHUycqQ7VYI9rLQqpcBuzzxH3mJX2/A5arZ/q93Yx93PP8sUM
         3r2GqBn96YrfrkOCUNF0NpoZcN5A6Pec9C4C7AUHPKADW5Y9JzmGshXc1wkVdJFisnTv
         IPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731100434; x=1731705234;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wBmcQNeD+UdodxSOQnZD/sFV0XL4QmuclbgKN0z1xE=;
        b=s4vio6YmNIWCAZ8xcCRWo52j7zUI1eQoia+SWeLV4qnWZERCIVx22NXwGBK43qpg1t
         gGefk6HF8xSGehdg0o+cTOJUyBbDLMU0oTP2W4Vn6RMwMb5tARXSIM/G2g7UTs69/KAF
         HcSViJBlyDMf5aETeopGKQueClI74mkqplmHVXWzdxJysdDNbXu1ju0cepm5u054d/Gn
         pYsaCYqP/UgiPZVzSPtyksg1/b7aNHv0WCW6+c7bn2KMStqzBlmjSRXshVw4xr+t1AIK
         yTri2nu0H3HBpwVCbfgyzKPLnAj5ebI0mdTlNroWlqzIo2/+UUzp7LVgGjMej+8WjNFu
         GUWg==
X-Forwarded-Encrypted: i=1; AJvYcCWMIH7686TT5eZg2I0HBdnUTwxF7wxGbISttYXCuLn5evhIQMVHceqfBP+/Tp9uQufABgBTnc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydMq8CXMhpuAPMHbcrw8o7MUxSqOoVptBedkf26dLMHew6luM2
	InbcFBeXHevP/mSAHNyky8LMSKsjC9X7av7YopoWzeDJeV0QCtUp
X-Google-Smtp-Source: AGHT+IHRAOBI7nSaGoHS5jc/izL5OFXvwZCNn8DKqcXFgw1tuRrMQ67cKGZGFIWEoRmVC7FOztfn6w==
X-Received: by 2002:a17:907:944c:b0:a9a:8a4:e079 with SMTP id a640c23a62f3a-a9eeff44660mr433872366b.31.1731100433299;
        Fri, 08 Nov 2024 13:13:53 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defba9sm279641266b.165.2024.11.08.13.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 13:13:52 -0800 (PST)
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context action
 explicit
To: Joe Damato <jdamato@fastly.com>, Daniel Xu <dxu@dxuuu.xyz>,
 davem@davemloft.net, mkubecek@suse.cz, kuba@kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, kernel-team@meta.com
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
 <ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
 <Zy516d25BMTUWEo4@LQ3V64L9R2>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
Date: Fri, 8 Nov 2024 21:13:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zy516d25BMTUWEo4@LQ3V64L9R2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 08/11/2024 20:34, Joe Damato wrote:
> On Fri, Nov 08, 2024 at 07:56:41PM +0000, Edward Cree wrote:
>> I believe this patch is incorrect.  My understanding is that on
>>  packet reception, the integer returned from the RSS indirection
>>  table is *added* to the queue number from the ntuple rule, so
>>  that for instance the same indirection table can be used for one
>>  rule distributing packets over queues 0-3 and for another rule
>>  distributing a different subset of packets over queues 4-7.
>> I'm not sure if this behaviour is documented anywhere, and
>>  different NICs may have different interpretations, but this is
>>  how sfc ef10 behaves.

I've looked up the history, and my original commit[1] adding RSS +
 ntuple specified this addition behaviour in both the patch
 description and the ethtool uapi header comments.  The kerneldoc
 comment for struct ethtool_rxnfc still has this language:
 * For %ETHTOOL_SRXCLSRLINS, @fs specifies the rule to add or update.
 * @fs.@location either specifies the location to use or is a special
 * location value with %RX_CLS_LOC_SPECIAL flag set.  On return,
 * @fs.@location is the actual rule location.  If @fs.@flow_type
 * includes the %FLOW_RSS flag, @rss_context is the RSS context ID to
 * use for flow spreading traffic which matches this rule.  The value
 * from the rxfh indirection table will be added to @fs.@ring_cookie
 * to choose which ring to deliver to.
The ethtool man page, however, does not document this.

> I just wanted to chime in and say that my understanding has always
> been more aligned with Daniel's and I had also found the ethtool
> output confusing when directing flows that match a rule to a custom
> context.
> 
> If Daniel's patch is wrong (I don't know enough to say if it is or
> not), would it be possible to have some alternate ethtool output
> that's less confusing? Or for this specific output to be outlined in
> the documentation somewhere?

I think sensible output would be to keep Daniel's "Action: Direct to
 RSS context id %u", but also print something like "Queue base offset:
 %u" with the ring index that was previously printed as the Action.
If the base offset is zero its output could possibly be suppressed.
And we should update the ethtool man page to describe the adding
 behaviour, and audit device drivers to ensure that any that don't
 support it reject RSS filters with nonzero ring_cookie, as specified
 in [1].
Does this sound reasonable?

-ed

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84a1d9c4820080bebcbd413a845076dcb62f45fa

