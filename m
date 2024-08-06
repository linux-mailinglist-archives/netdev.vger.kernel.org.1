Return-Path: <netdev+bounces-116119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4A9492C1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E931B2DC61
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422441D54F4;
	Tue,  6 Aug 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzvlrRXn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF91D54E9
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952744; cv=none; b=sZDfqDDqeSfuzvsLImxOjSnhxwUYwcTipgOI10ZBPpJWJ5RdjTY6x+8TRb8ioqyy+jhb3wfUGffMJTWBFWFHogarVxztYucMxQmwbc4F6cAZSH71EBHkZ3Uf9RzezuhvCS1a7fHGdjhylOUgRonvxPLGXo5whkIcuNhWiKqIiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952744; c=relaxed/simple;
	bh=NzMSCmmfmOcU9lEnqk2t66zgSYWG2hK2+ARitIdU2QM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l0BKT0KwJwUC04m/9hvtRgP9fkxsdSay9m7fJhUv4iSf60yvigAgVwSc8rGxTirXpOUGn6FpzKx1HhXyJ/nJkTKu4A67+cs9fVnVvWT+3l4TdstPxJMyy+tl3bgerecBIzKPjwpXFXS0c8fVpIneC4fTqzPvz6foKxMoG0ceqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzvlrRXn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36bb2047bf4so394552f8f.2
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722952741; x=1723557541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwS8ZpkRgeLI8ChIDtNJ8bardxm0Lqb4EY4TbyqqMYU=;
        b=IzvlrRXnIViBul6i91DjZ58lYlVfAaWNhyqLGL2M6hYRG5GXDB7HESbHX0NrCMX8/T
         ASekylmFSAS3MiG0rAMzNIOWRIFIpLAH/hfxAK9MhkkYaCoai9mkq2i1aR98B2d8IOWe
         uKJTYG6E0aNGW9V0G1YJM6srR5EiPzf316dyo2DbHEeuc/OPVR7UWs2+VA4LTFxUN87a
         FsLHjqNR7hXGXYlaZineGK4mar3r5+oUVgYla+PmDLqL0aON2V4FFqpmgd4zPgt7VxFy
         1lWY0k6BfEux3qd7aCq2qN7BnPJY926ofO0wwNbI1hIiSsRPzczwbaCgZiLVLauM7uES
         oaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952741; x=1723557541;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwS8ZpkRgeLI8ChIDtNJ8bardxm0Lqb4EY4TbyqqMYU=;
        b=AAz1Hy3UwvCz6M9Yj6AqPoSeLEZXVdCdibxdmq4ybE6dMl348+Jfw3MPIjuJCa2uIc
         SrFgatWZSdpuC83KVSQYkMNrf0J1O6iXvWJ210E6IS/8Wjt3QGl5818iwZDci0CXYGP+
         Z624ljwwijZQ6Mk76aIUFJNcoKYZ8qiYoJMUWRn0F6YRa7Flslsm3+N5wnAtJrkD8Dg1
         nJtH/7AwUs8JfoUT4NnbaDBVl9V9x/etyiBiDQ5MCAPdLFNHlwmEeAO/Jmsn69GCwZQi
         ubS5XgVgyOkoGLs4cLBuycTRKDGVs3HMnR2bQCCb079PQ6eypzmwNqecSk+v+s4SILGE
         iVxA==
X-Forwarded-Encrypted: i=1; AJvYcCUsSUqCmwKkIrNCg320PE6xTYmTcJoHHU4mio97mwLIZZcjRjUqp0i8pfCZ4YtKV8ebkCxm0U7uRFzVjp9bZQKM74WLkYZJ
X-Gm-Message-State: AOJu0Yz2IXBmaa/TPBVtfaB3+RFFg4miQnrCucGXDPVjRM/k93xzZW4m
	h3FNsuKDgZl+PxX1CjLLtn8Kfa6PN01ISoJgIBnszzJL0ts6r7Zf
X-Google-Smtp-Source: AGHT+IHIlGKsEKles/ML+kc62dWBxujqSdKXMT8SmaxhlmsUkddkdr8U9ku+8wok5dSKaq07jvzfaA==
X-Received: by 2002:adf:e886:0:b0:368:5a8c:580b with SMTP id ffacd0b85a97d-36bbc0f56dcmr10783816f8f.19.1722952740603;
        Tue, 06 Aug 2024 06:59:00 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd02a451sm13265058f8f.63.2024.08.06.06.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:59:00 -0700 (PDT)
Subject: Re: [PATCH net-next v2 09/12] ethtool: rss: support dumping RSS
 contexts
To: Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-10-kuba@kernel.org> <Zq5y0DvXQpBdOEeA@LQ3V64L9R2>
 <20240805145933.3ac6ae7a@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <13606f9d-ff3e-f000-ba87-db890c8cfdcd@gmail.com>
Date: Tue, 6 Aug 2024 14:58:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240805145933.3ac6ae7a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 05/08/2024 22:59, Jakub Kicinski wrote:
> On Sat, 3 Aug 2024 19:11:28 +0100 Joe Damato wrote:
>>> +struct rss_nl_dump_ctx {
>>> +	unsigned long		ifindex;
>>> +	unsigned long		ctx_idx;
>>> +
>>> +	unsigned int		one_ifindex;  
>>
>> My apologies: I'm probably just not familiar enough with the code,
>> but I'm having a hard time understanding what the purpose of
>> one_ifindex is.
>>
>> I read both ethnl_rss_dump_start and ethnl_rss_dumpit, but I'm still
>> not following what this is used for; it'll probably be obvious in
>> retrospect once you explain it, but I suppose my feedback is that a
>> comment or something would be really helpful :)
> 
> Better name would probably help, but can't think of any.

'only_ifindex'?  'match_ifindex'?

