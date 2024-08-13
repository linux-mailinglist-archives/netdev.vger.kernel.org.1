Return-Path: <netdev+bounces-117945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5037694FFC2
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832601C22D06
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F69139D19;
	Tue, 13 Aug 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuqSkb1Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A3723A8
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537484; cv=none; b=RjgPhZlrS6E7gyyQo9AcGBnLRipspl1tjVcfh5z3Zm0nvDdgQJ2zk7Bv/1bxePvmddnwngTjKIi4mBQjbrz56IpqBWGw8Iree6Y40kJ1V82O213xy/suLYabzGvnbwBOClwmRyaT47bh5r2rlWylXIJsUwU4tLDUnp9M27MrFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537484; c=relaxed/simple;
	bh=z4rtvyIZeM2sSbiuM6CyC87GfQBM4KB7dKPmR0qpmAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+4SUXB/OaAaP+iB/r8V2JeGTVdgYC/5HffYtTQ1T7F08+/+NPLv+yWjeEJOTHuyuayBIrwICaTMa4XRH6k7t0HuxvuJDvkJn0qg5gVc6Jj4J1p/iXBtFdLNTGy48PNpDGW/IGTgh/R6nblerNUnZwnhp4rC/KXJRQelCMZ4fe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WuqSkb1Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723537481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b64jIQ9/dsxudYx02r74GxC7Cq2xZEg6NH4lDpUYVIE=;
	b=WuqSkb1YeJSIFPWKJG1bh5FJdZoT/HHJXsYvr99cwuSONegsm9IxnsSF2ac24fN+96rPIR
	MSomSsCEg8Rdnm1cbWQ23r78xW7gtumac04S0PvYWxFH/+7nAUZtRggIUJGleKlchHG+Xh
	WpmPScsYh0lVx7YKMzom70Dx9vGGJyM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-lXFTqyN7O5WN0hsn3FA2CQ-1; Tue, 13 Aug 2024 04:24:38 -0400
X-MC-Unique: lXFTqyN7O5WN0hsn3FA2CQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428086c2187so9852165e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 01:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723537477; x=1724142277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b64jIQ9/dsxudYx02r74GxC7Cq2xZEg6NH4lDpUYVIE=;
        b=iIErAkExg8+Ven8vhmgxTC8xQxZTRNB3QQtmHKi8GSQV8iNOPc0nMYFiTZLZY2CnZW
         a2vGmxc5SgVMvwX0DbwkT+HI3GaON1M2G00Zotv4BeLuO6G5l2bNGjigeTlfsSgvxKqQ
         MdylSo+ss6h/qmHKZRZVVgWU3jod+S75/8B2SwM1KqDHXN+ITYyfKGze8cZmDmIW39mk
         dwTbpkiO/PoggEg1WUZcaDN+LWQwuZ1e6e7ZsmJFy9KE1MOpGmCA7UzEr9IbyH0kmI9I
         heokbQP35NVZo0iBoniQb2JCTLHYDwto8/WlVAhhQVdCdcWxFOSRAqdL7hKwwNDvHkfK
         kLlg==
X-Gm-Message-State: AOJu0YzUCMMpSFlvTSbmiSJyZKh7N4XZzt1khPf3Sy36gsokTNyK3ki1
	AmGxe24te0f+D4SLR0pJsWi9l7ZI1dlViqyoASoK2k7l6r0ZfbdZvlBlG7/pUgHdaFtNh+NtvmQ
	NEWNoIwSC5PJhaPlmo2egNl/nLJrvQ69vTPEJWPU/A0hEmoh4pqzfK7ZKtpMOxJ9r
X-Received: by 2002:a05:600c:35cc:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-429d74fd1ffmr6848635e9.0.1723537476766;
        Tue, 13 Aug 2024 01:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH84N9HJbM1nqoesY1oz8ekLNKszXk2J/oURFnOEEvo3S9P+vrBtymevqrw7gJDmUmaBC9QOQ==
X-Received: by 2002:a05:600c:35cc:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-429d74fd1ffmr6848535e9.0.1723537476229;
        Tue, 13 Aug 2024 01:24:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110:151e:7458:b92f:3067? ([2a0d:3344:1708:9110:151e:7458:b92f:3067])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d05828a8sm78471225e9.3.2024.08.13.01.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 01:24:35 -0700 (PDT)
Message-ID: <6517ad52-e0c6-4f68-aa7a-8420a84c8c23@redhat.com>
Date: Tue, 13 Aug 2024 10:24:34 +0200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZrrTFI4QBZvXoXP6@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 05:29, Hangbin Liu wrote:
> In our recently internal testing, the udpgro.sh test reports failed but it
> still return 0 as passed. e.g.
> 
> ```
> ipv6
>   no GRO                                  ok
>   no GRO chk cmsg                         ok
>   GRO                                     ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
> 
> failed
>   GRO chk cmsg                            ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
> 
> failed
>   GRO with custom segment size            ./udpgso_bench_rx: recv: bad packet len, got 500, expected 14520
> 
> failed
>   GRO with custom segment size cmsg       ./udpgso_bench_rx: recv: bad packet len, got 500, expected 14520
> 
> failed
>   bad GRO lookup                          ok
>   multiple GRO socks                      ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
> 
> ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
> 
> failed
> ```
> 
> For run_one_2sock testing, I saw
> 
> ```
>          ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} -p 12345 &
>          ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} && \
>                  echo "ok" || \
>                  echo "failed" &
>          ...
>          ./udpgso_bench_tx ${tx_args}
>          ret=$?
>          wait $(jobs -p)
>          return $ret
> ```
> 
> So what's the effect if it echo "failed" while ret == 0?

It's just pour integration between the script and the selftests harness.

The script should capture the pid of the background UDP receiver, wait 
poll for a bit for such process termination after that the sender 
completes, then send a termination signal, capture the receiver exit 
code and use it to emit the success/fail message and update the script 
return code.

Could you please have a shot at the above?

BTW I sometimes observed similar failures in the past when the bpf 
program failed to load.

Cheers,

Paolo


