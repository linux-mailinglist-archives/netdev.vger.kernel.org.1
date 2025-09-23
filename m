Return-Path: <netdev+bounces-225681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A4B96C52
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9798419C59E9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B102EACEE;
	Tue, 23 Sep 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nrKQX8Ra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6182E092A
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644030; cv=none; b=tBSPfLsH7vEYaV2AoUwOJzyaK5/siR+KNd9OIhD7v1ZrUECZUPphk5xLStrZPp+HOtfwqzLeqJaxCS7ctoxGN3FXw5WvZQFlaEynaNI/74QSKGRun4ERXgv/MddYekbx0Dm0n3xGtqAoHVAejP+KbIyIkpAT+bAdGexlYo+WqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644030; c=relaxed/simple;
	bh=guRLQeQsWS6kFmB8Bg7C/sA6CM0vOmn9YkSOY/l5WDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7bw399RMFD/xXZ2CIZNaE3Fbb6wBZlQj6d/6RpEeRUkCu1GhV6TrXQ+vKQd6CbkypSQwxYMcM3jN2nDIgSl057NXTnwBJLwt2a/5luswATiDYp4VKwl2zdod2U730DfrTZQJKvyZdEoCANTYaCQXlHvynmhs5SjjelIePmvkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=nrKQX8Ra; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f198bd8eeso2345698b3a.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758644029; x=1759248829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhKIiC03x/bFFowHfSrWNW2Fi78ULcqlgNZuGQXpIAs=;
        b=nrKQX8RabJ91elBd0+Km8eIvkurnH74L5kcvbHfCwzRC50Sj6GE4V7e2cVJWhCPIIN
         cLqj32xM8brNOr+QyJiZekLRGZAtGRu66S8/X/nUNcoh8XLbTUFC1HlKjnCAw6yykwqE
         1HThU8JESDM24VD04vAz3mSG+YDd9IOgruSYEji/e8Mhk9jr7t1PojvkI/UXMwLBiJTH
         6aier0UOUs5z8avT4hRNsNfc++nsPYpzAoZjCKMw7eem3KZU0FCokN3L3PeQ7cPkZkjr
         NB1WvJjam5gK9zLXMC/O6n8b/TiW4cU/zq8Ds2WjPCkRshBuRNnfMxGIgz91RBaQ1R5H
         4D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644029; x=1759248829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhKIiC03x/bFFowHfSrWNW2Fi78ULcqlgNZuGQXpIAs=;
        b=FF+M4Njzu8MOMaQdI50R461/rq8xqeUCLRUVfKi3ODGcuyUMefaXuJZg/e/I4i4WHD
         1O4tE4j9ey1dWRO819NbCQ6kTNpVw28NCGHy1JMfMoWcyietF6+f+gAFUPWb6DJY/NIS
         cpfiFAyrvdWaMnksTQu5uLFEMkSGW5qB7DRbrMimWcbXvEfs9Mj7Neu3o0L0nP5TZ1Ls
         wewe+1Kz7f2cp63h5uwls+lf3xy7KKikzBOnwNJDkmJC94awYYD5Qm18zD3Rg7Zi8eQe
         A0AtYIAJFtdRTuepFAwBfrWXPyLpvurB1nPb2c1KP9X4kpTiux/cNqNyGQhZR97H1spg
         Q/lA==
X-Gm-Message-State: AOJu0YxZWdcXRAotKdWH5FJxaLjYqkaqEs1516VrCYTaB8Hixhxe0QdD
	2BYNOQcjsP9cihOK9rASz9FMlQbYVY/CW/j9+uGZQefvHLvZVbm+oIsBEN0YTvgm7jU=
X-Gm-Gg: ASbGncspcvhsD29nctVn+BbcTQ5iCgi/94rPKaM39tb0UM+3JIjLltQNecKxlGraIpB
	fku0+RFJFELBFlio9gH7IiScgRIX84H8H5YU+mvK/BNF0M+hISqTpY762+YoHuf/vi57yy600gk
	z5UCE3z9CMas+vvEORY8L6k4qkGbv38oqKrsDt2xrhyjMXy9DJJMqK6FneqMeHjBvNi4vVdYF/e
	BhGNFoPDL/ixAuhMCKIwb4PP7whaBIavyNFzayBJArCz5Q2EJuvsEqzs77JN7t01lfSudOr+8+x
	JOxvFp7NJnLe3WoC1g6IcK1rQckwY/SAohv+sOWfyyyYP4zmAmkcoRE2veT1IO2aFpdtnHRTtK0
	6nz6YhCYLW6jKcN/AIsSGb089VnHXMpnYt0AfxK9KJb9d9eSugEJdSoartP9peuF6
X-Google-Smtp-Source: AGHT+IFUkImeersmBBFN6zTgf+WqABsEK5LuZ0POd29k47Z8BYCSZNZvo1Coyn/+vMgnP17dqWFJqw==
X-Received: by 2002:a05:6a20:c89:b0:2d5:264c:e484 with SMTP id adf61e73a8af0-2d5266b6b4bmr2513208637.25.1758644028850;
        Tue, 23 Sep 2025 09:13:48 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77ea933bfeasm12741223b3a.53.2025.09.23.09.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:13:48 -0700 (PDT)
Message-ID: <ec3a75bd-8879-4832-aad1-0e2aa096ec5e@davidwei.uk>
Date: Tue, 23 Sep 2025 09:13:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/20] net, ynl: Add bind-queue operation
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-2-daniel@iogearbox.net>
 <20250922181728.4aa70650@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922181728.4aa70650@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:17, Jakub Kicinski wrote:
> On Fri, 19 Sep 2025 23:31:34 +0200 Daniel Borkmann wrote:
>> Subject: [PATCH net-next 01/20] net, ynl: Add bind-queue operation
> 
> We use "ynl" for changes to ynl itself. If you're just adding to
> the YAML specs or using them there's no need to mention YNL.
> Please remove in all the subjects.
> 
>> +  -
>> +    name: queue-pair
>> +    attributes:
>> +      -
>> +        name: src-ifindex
>> +        doc: netdev ifindex of the physical device
>> +        type: u32
>> +        checks:
>> +          min: 1
> 
> max: s32-max ?
> 
>> +      -
>> +        name: src-queue-id
>> +        doc: netdev queue id of the physical device
>> +        type: u32
> 
> 
>> @@ -772,6 +795,20 @@ operations:
>>             attributes:
>>               - id
>>   
>> +    -
>> +      name: bind-queue
>> +      doc: Bind a physical netdev queue to a virtual one
> 
> Would be good to have a few sentences of documentation here.
> All netdev APIs currently carry queue id with type.
> I'm guessing the next few patches would explain but whether
> you're attaching rx, tx, or both should really be explained here :)

Got it, will expand the docs.


