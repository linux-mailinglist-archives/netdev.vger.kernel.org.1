Return-Path: <netdev+bounces-118097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F89507E0
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426111F220D7
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBB919E7E2;
	Tue, 13 Aug 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChaVxT6u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98BB19D886
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559848; cv=none; b=VJJCuzOXRjcdX5Vk+RyFGW3WwNKGtdJFR7tvUE2Kxqy29Ix+2zsV6IpsA4X0xwjlgpFbXO/VBcWYGLh753z77K0b06XsZsBxGsKBLGWNvvhKeRt1AImysRF6shGA3L24chJHZ0fmsUZR1rfiASTkYWUR2yGLynwOTIfNcURenfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559848; c=relaxed/simple;
	bh=QTWc8QMhM7XyEOOCVmUjQbDmK4QOaCbvxlQx9bxMZHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFMC66/7PMtVSJhs5wN2NYm26qmnqdsIXlT5g1on/d4VIZ3AKaYtajTX4rjvy9lr3WjqoF+gVdJPMD5oesYorEFDnu7jJ6Yx3gkWiE2ZOprbwRlvjMzA2931Xf6H9K0O6C+j5PXOhib62ttxmj4g25R1Q+EA4D2KDcUNi4eWlpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChaVxT6u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723559845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnc+Mt7JINCA6toGia9SEoMUZgrMcU59J+EczN5Rq+k=;
	b=ChaVxT6utvdOC1OvsJGXBDLau4ls2D+wQiPJRCfG2yT6hQNLiOXIBNN2NObOzXOstnsHoh
	KAhCdfeYae8PQ3HEJ6U/tt85UCcYWI0tfEUg9xGfMHiOZ0lZT8rh7i23nU6MOiRX5+NKSe
	O17XAzWzwKQ8useAmWbXrK7f86pQGys=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-xh4XOQZLNZ63SXTWIbhXGg-1; Tue, 13 Aug 2024 10:37:24 -0400
X-MC-Unique: xh4XOQZLNZ63SXTWIbhXGg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280b24ec7bso10367635e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 07:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559843; x=1724164643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnc+Mt7JINCA6toGia9SEoMUZgrMcU59J+EczN5Rq+k=;
        b=Ezsc+DHX/ws/+pSmZgIpSnIRp+frcoZWWup5znAsUGDuvEkT61eTdbspFf5qT1eOdI
         /6htc0Xker12FeZwmnwrEFZUx2lLXMB0KtOow0QDmTKHzTWskgIO4udFclDaakQ5KCMa
         R9L0vdalkDFbkqXaVBH/ksbvbdPExWXQWYEBglBaKnC0Bq3TQw8FPZ0pO896bNLtn2Cv
         Cg1nQPsSEmpcRjloxNRhi9Kk8Vj7A0YlKpifVM/joIpHrrAgsctqYYkA99oU8kXW3x/V
         nCJES/svJfmFs8WDyEil0U7XX3m2zIIMJ2WuR3lOn955Pumx3hYeaV/qoivnGYMHnYks
         phXA==
X-Gm-Message-State: AOJu0YyxcRgC+Ru/Mlx2gu/cY21KAFOof7+xz/6srlidfnZYyq1zs7Xs
	+EShsrJ9OYlUkMlw11e5ssC/hixK4YsoMp1WRblaVIjpArjF5uO05hGpLiYJAB0+PGbwHcJiT5V
	cu8TuE7KWENSU4Y2TfctSlzMia1HZ26f8S0XfttwgchW+wDhb535vYg==
X-Received: by 2002:a5d:584e:0:b0:368:4c5:b69 with SMTP id ffacd0b85a97d-3716fcaa1e4mr1019778f8f.10.1723559843082;
        Tue, 13 Aug 2024 07:37:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQsXQjQyqGi4iScVhjH/OPOB3Ypzu8x3qCIoDkdwf/OlrFFRwP4Gxn6txfZQ7wkuldEULTSQ==
X-Received: by 2002:a5d:584e:0:b0:368:4c5:b69 with SMTP id ffacd0b85a97d-3716fcaa1e4mr1019774f8f.10.1723559842542;
        Tue, 13 Aug 2024 07:37:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110::f71? ([2a0d:3344:1708:9110::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36be8csm10574173f8f.4.2024.08.13.07.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 07:37:22 -0700 (PDT)
Message-ID: <e12744d9-00c6-4c56-955e-cfdb44cd7066@redhat.com>
Date: Tue, 13 Aug 2024 16:37:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [selftest] udpgro test report fail but passed
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
References: <ZrrTFI4QBZvXoXP6@Laptop-X1>
 <6517ad52-e0c6-4f68-aa7a-8420a84c8c23@redhat.com>
 <ZrsuG2KK9jkQOd9e@Laptop-X1>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZrsuG2KK9jkQOd9e@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 11:57, Hangbin Liu wrote:
> On Tue, Aug 13, 2024 at 10:24:34AM +0200, Paolo Abeni wrote:
>> It's just pour integration between the script and the selftests harness.
>>
>> The script should capture the pid of the background UDP receiver, wait poll
>> for a bit for such process termination after that the sender completes, then
>> send a termination signal, capture the receiver exit code and use it to emit
>> the success/fail message and update the script return code.
> 
> If that's the case, we shouldn't echo the result as the return value will
> always be 0. Is the following change you want? e.g.

The below example captures a slightly more complex case, where there 2 
sender/receiver pair.
> 
> @@ -115,16 +113,14 @@ run_one_2sock() {
>   	cfg_veth
>   
>   	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} -p 12345 &
> -	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} && \
> -		echo "ok" || \
> -		echo "failed" &
> +	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} &
>   
>   	wait_local_port_listen "${PEER_NS}" 12345 udp
>   	./udpgso_bench_tx ${tx_args} -p 12345
>   	wait_local_port_listen "${PEER_NS}" 8000 udp
>   	./udpgso_bench_tx ${tx_args}
> -	ret=$?
>   	wait $(jobs -p)
> +	ret=$?
>   	return $ret
>   }
> 
>>
>> Could you please have a shot at the above?

I think it will not be enough. We need to check the exit code of all the 
involved processes (2 senders, 2 receivers)

Thanks!

Paolo


