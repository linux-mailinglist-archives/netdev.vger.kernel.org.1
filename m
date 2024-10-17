Return-Path: <netdev+bounces-136456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA59A1D07
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C37B258B0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089651D1E96;
	Thu, 17 Oct 2024 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6IL5xBw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604E31C2447
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153294; cv=none; b=GzXw3iFA5gZzMCSJXFeFUxk1Osh6UNaq9k8Fbq/jXYIkvKKKDh/ePP11EzOFcSlRqQbcrZ74ZyT287lbTjweweLDM6wvMLEZKH5DqLN8KOwmupLpfFV1sCTudAVe3bOSqLO7pZhusVvOFG5F7StmdjFRDiEEjYNe7uD525zezLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153294; c=relaxed/simple;
	bh=mJdwseK+Ihydb0yrZWZ2xx7GAV8K0alZlK6rApkXMP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auf9YdFl0BruajXHKQX/Q3tkr+hZ5yxhDYODHW/mzAHm+0iJfM4lg52ERsQ2LxphyOjD7BOzwuAuRDeikr1Hy5SPFMxx9T8X0o8JfJcmr4uCsLTQluN/SUAHEyQ55bpeFWsDq+FyBph0COwJt53fQgW+lH9QlO3a4CAnj8HmWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6IL5xBw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729153292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sv2elTq+1u5WAiRQ57i5MykcY8IctnIMTtGLiuNcRr8=;
	b=f6IL5xBwGinTQAvqEBLDPlrzBQBvQEAu65AWUnsLBxYjDu+VHb50angknKa7kgNc5k1L3d
	lPfnI2FzNTYvA6xZTNzuiQSG1bmqYNINGkakyhCEnKwzQTt/K+KbXvpsL53xD9muIMpZ7T
	53h9cZQX+sHv2DHFLu4C33cBdW8H9UM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-fJkiBzy3OtCpMnw7XrrR6Q-1; Thu, 17 Oct 2024 04:21:31 -0400
X-MC-Unique: fJkiBzy3OtCpMnw7XrrR6Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso372212f8f.2
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 01:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729153290; x=1729758090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv2elTq+1u5WAiRQ57i5MykcY8IctnIMTtGLiuNcRr8=;
        b=JdvQwEG9OqXDdMiXnaxHVul0OULwUWgMWnzGsoodW6cUOGpYk0qcbYKhnxkdTqiC3k
         50mNz3FUGRCKNVpNxK9HTg57sOsnir3FYkeUfnpz2d4SwryvIJgaqJjLoUKsrBS2c747
         RdM4ek1DwbrfdnJ8kEsmplL1upMUCIcegZS5Rc7VUSrMcJTlVDLZ3vWaeCX2tbOlsscH
         k9M1RAOacV6QKSSal4gd9f8BcK0l+wJ+WhBvoN1g94ihsBWiOBC6FyVcBKYEe3irrqAe
         NF6C4BYcnnUhWdIF+BBQ8EbB4J+eRGL2vWSPr5cwboQPZIoAUakUtAfxrZ5VSNWS8HGM
         SgAQ==
X-Gm-Message-State: AOJu0YwBkEYAGKmc9QPo+3qgdTVB2zkzfs5rt63m6Xps9fG7Kxp1+MkC
	FxzC19o6Di3gziBMIay7tAmpvuepTpcyUJsyqcxcNyTEaeX68UWsjIRvNTh0DzN6+ebzdF7PsfY
	74mphk4cEVNa+7oe2GRwj8s4WMjYbjPU0QoD9GVurTNYSxWUW6+gyag==
X-Received: by 2002:a5d:6182:0:b0:37d:4b07:606b with SMTP id ffacd0b85a97d-37d86d554fbmr4668943f8f.36.1729153289908;
        Thu, 17 Oct 2024 01:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWbT67cXRNKHvT8bjUpe/1XYziYnHsjZYBLmjChrKd2b7so3VlC4Le6iaP/zZPAGC4Jfvqng==
X-Received: by 2002:a5d:6182:0:b0:37d:4b07:606b with SMTP id ffacd0b85a97d-37d86d554fbmr4668926f8f.36.1729153289439;
        Thu, 17 Oct 2024 01:21:29 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf8313sm6450750f8f.66.2024.10.17.01.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:21:28 -0700 (PDT)
Message-ID: <058bb30d-7d7c-4e4f-8b88-32e3ca99e548@redhat.com>
Date: Thu, 17 Oct 2024 10:21:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ethtool: rss: prevent rss ctx deletion when
 in use
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241011183549.1581021-1-daniel.zahka@gmail.com>
 <20241011183549.1581021-2-daniel.zahka@gmail.com>
 <966a82d9-c835-e87e-2c54-90a9a2552a21@gmail.com>
 <43a98a99-4c79-4954-82f1-b634e4d1be82@gmail.com>
 <c32a876f-4d20-c975-5a2f-3fa0ab229f05@gmail.com>
 <e78915b0-aaf5-4c89-b2a2-a2622710563c@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e78915b0-aaf5-4c89-b2a2-a2622710563c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/16/24 18:50, Daniel Zahka wrote:
> 
> On 10/16/24 12:23 PM, Edward Cree wrote:
>> On 15/10/2024 17:31, Daniel Zahka wrote:
>>> On 10/14/24 6:10 AM, Edward Cree wrote:
>>>> Imho it would make more sense to add core tracking of ntuple
>>>>     filters, along with a refcount on the rss context.  That way
>>>>     context deletion just has to check the count is zero.
>>>>
>>>> -ed
>>> That sounds good to me. Is that something you are planning on sending patches for?
>> I'm afraid I don't have the bandwidth to do it any time soon.
>> If you aren't able to take this on, I'm okay with your original
>>    approach to get the issue fixed; I just wanted to ensure the
>>    'better' solution was considered if you do have the time for it.
> Understood. I don't have enough bandwidth to commit to implementing it
> soon either.

I understand the chances to have a refcount based implementation soon 
are zero, and I could not find any obvious problem with the proposed 
solution, I'm going to apply this series as-is.

Cheers,

Paolo


