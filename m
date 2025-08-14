Return-Path: <netdev+bounces-213676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B71B2631B
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E181CC2EEF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317142F6595;
	Thu, 14 Aug 2025 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmkJK7hj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735EA3EA8D;
	Thu, 14 Aug 2025 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168322; cv=none; b=kwQlM047wrg6Hvoetzo+YeQ6VZ2zfl6Ex/YibLZLUj4PfhYwaD7vwVsNwEKEA2FcK+d1YxRU7wl8oNpfp+OnnZWhMm5ajJEeivX4ftXALRYbXcTcjyqX+lRuL/fgfwlCB2MhS/bEoy0YtcYvT4HkzaOO11FCejqUfqt+MLW64/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168322; c=relaxed/simple;
	bh=5wla+SYFygHPOOYK3bdjMmq9BL4rphveYhWwS3j9Qho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyBXGGbsP5o/vBZK/JNyMIKyzmAh79NdJ8GhrchE3vNqjtODbhuH40BUk3az0xNF3npBiNNJMXaQz2zZ/AmzMkxeAsNslodPVbSa0iNyZ+bV8/hWhWMNS9c0cvTcEC51CtZAZ3uAjYA56bGfmdods+Za6ji1S0z2UABhmu3P2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmkJK7hj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so3857355e9.1;
        Thu, 14 Aug 2025 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168319; x=1755773119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLrSf+CT0upHixlS7L05hc7uD7Qlt7IiIEETpPbNwQs=;
        b=GmkJK7hjtaJjbA7GbNBev1YL4NHFnzLBsGydLWzt4PsooV2UF74NxR9mS6RZSN6l33
         ELJ+r7dEQ2kLTYuEte1qLkUOWv5M8e/ea26Fs+9612ZcpVGYn1bnTNm3krS9MOd0DbuK
         UBGxh3tcGn7P/9n24MXt7g+gsYRmXQlCTPlG5Tm4YnjHv0rvRGKnqVzzzT29hJVNi/b4
         WoPAQAOtgjbGMXusCFPRCmdZ+u6WunAAjjrveVQhgzmlPouRoJjuuLN3TFyF1shOWBrN
         aHEctSdXn1ypKucZs5CFVXFWrM9B6DWj3QWEUPvc+CGbZ1NTZ0mZnAS+v1XsatxYh6u5
         qjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168319; x=1755773119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLrSf+CT0upHixlS7L05hc7uD7Qlt7IiIEETpPbNwQs=;
        b=Oj3sOLwfIDtNH+Ibq799JdUJOaxf28IMMwo1O9NKCSznnaw4h7C4sOQPGdYH1stZ09
         78+HBacdlmqvnsBjTuxQurIrU2e5kaVyrTTE7Dvb8UHxH3i6KmYoC6NVt3OqKOPO0J9q
         YZWp+iLPseyek9vBOCO7DSVSS1mf2zIp2PHFRJQ28uLU0s9PV0iHCCTngiNg4i6tPV0R
         hzQalJJliGLzDlIN7IIJtK0lcOu9Rp5PF/A/3B8Bdytgn5Yfv5wbRvOh6RMEu6fAnSVm
         Ckkio0R7DxAf0VnZMfis2D/aAYK8fZqNDs+7lzBFiCcfyG7QaBWxldbLLH2a0NlIxBYk
         8hdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnvzpiIb2e0JmuPaen1Qeomhr8IuFxkDgFLNTUMaJ8JXgiLMqsTjcg8CfRK6+P6BX+b37HtQew4hPTYCI=@vger.kernel.org, AJvYcCWpiC1JZx6SiuDmmvCoWHAddg/eiqPXqhj3d6eDspIlxb6Ei8SR24i4RYSV3ug+oBz0nm+Q8Bj3@vger.kernel.org
X-Gm-Message-State: AOJu0YwRetKXqNSnoaV8pbxctQROx4Zixfuc7tyhQKy8vvslDpZPd4eG
	EOE+thlyGlywMXLghZcVOblWRPT6enWANOeALgCRbOfwITFCXMU4eQCf
X-Gm-Gg: ASbGncvcSId/78ZmCd7sEzl2nJSCJ2TGD0bvTGz4IP1rP0OJr1Ptk9Ik0FoRLME2sqg
	dswerH7vD56qD7pEcExnovnoylwQGlu+tCCUeL5sNuva114PobML9hVojTKzqiC4OclIfNSuMeA
	QzYGYdc5ZMih3I5SlyThnXJ4Kx5vmSlYu5WRC9o1TF5jgP90kX0LUVn78s/sZgxnYzunVIgP15T
	ouFZxWchBIYHGNsEwh2VR5uKAM7o1K57nIdlKJnLulcNKbiAFSwN/Rb8zRK/sdRDF5gKGeI+i6y
	9sRhOGaGMTvPt88j0iPyfsQ8Hk2PXmER9+YHwS3qWLZJEsnDl+CeUMhfUUcfB9SdiU3tx+4ekRx
	Wq4XifRnBCTjhi2NsCQ2ndJx5ExoJC+8X03I=
X-Google-Smtp-Source: AGHT+IHta1ZRCtyy/Gl5SkktRxkJK9c4Syn1ByRkfjS8qUsOoJaYOhSRhD7R8MiZOZWg8lysYHn2Vw==
X-Received: by 2002:a05:600c:1386:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-45a1b668fd8mr15606655e9.33.1755168318500;
        Thu, 14 Aug 2025 03:45:18 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:64dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76f055sm16859545e9.22.2025.08.14.03.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 03:45:17 -0700 (PDT)
Message-ID: <dbd3784b-2704-4628-9e48-43b17b4980b1@gmail.com>
Date: Thu, 14 Aug 2025 11:46:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/24] Per queue configs and large rx buffer support for
 zcrx
To: Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Willem de Bruijn
 <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>,
 andrew+netdev@lunn.ch, horms@kernel.org, davem@davemloft.net,
 sdf@fomichev.me, almasrymina@google.com, dw@davidwei.uk,
 michael.chan@broadcom.com, ap420073@gmail.com, linux-kernel@vger.kernel.org
References: <cover.1754657711.git.asml.silence@gmail.com>
 <ul2vfq7upoqwoyop7mhznjmsjau7e4ei2t643gx7t7egoez3vn@lhnf5h2dpeb5>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ul2vfq7upoqwoyop7mhznjmsjau7e4ei2t643gx7t7egoez3vn@lhnf5h2dpeb5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 16:39, Dragos Tatulea wrote:
> Hi Pavel,
> 
> On Fri, Aug 08, 2025 at 03:54:23PM +0100, Pavel Begunkov wrote:
>> [...]
>> For example, for 200Gbit broadcom NIC, 4K vs 32K buffers, and napi and
>> userspace pinned to the same CPU:
>>
>> packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
>> CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
>>    0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
>> packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
>> CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
>>    0    0.69    0.00    8.26   31.65    1.83   57.00    0.57
>>
>> And for napi and userspace on different CPUs:
>>
>> packets=10725082 (MB=1227388), rps=198285 (MB/s=22692)
>> CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
>>    0    0.10    0.00    0.50    0.00    0.50   74.50    24.40
>>    1    4.51    0.00   44.33   47.22    2.08    1.85    0.00
>> packets=14026235 (MB=1605175), rps=198388 (MB/s=22703)
>> CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
>>    0    0.10    0.00    0.70    0.00    1.00   43.78   54.42
>>    1    1.09    0.00   31.95   62.91    1.42    2.63    0.00
>>
> What did you use for this benchmark, send-zerocopy? Could you share a
> branch and how you ran it please?
> 
> I have added some initial support to mlx5 for rx-buf-len and would like
> to benchmark it and compare it to what you posted.

You can use this branch:
https://github.com/isilence/liburing.git zcrx/rx-buf-len

# server
examples/zcrx -p <port> -q <queue_idx> -i <interface_name> -A1 \
              -B <rx_buf_len> -S <area size / memory provided>

"-A1" here is for using huge pages, so don't forget to configure
/proc/sys/vm/nr_hugepages.

# client
examples/send-zerocopy -6 tcp -D <ip addr> -p <port>
                        -t <runtime secs>
                        -l -b1 -n1 -z1 -d -s<send size>

I had to play with the client a bit for it to keep up with
the server. "-l" enables huge pages, and had to bump up the
send size. You can also add -v to both for a basic payload
verification.

-- 
Pavel Begunkov


