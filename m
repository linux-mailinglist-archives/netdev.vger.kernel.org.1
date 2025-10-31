Return-Path: <netdev+bounces-234752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B02AAC26D85
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B7A64EC666
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7D131D736;
	Fri, 31 Oct 2025 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HCs6CWvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DFA31D378
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940503; cv=none; b=ge+Cd7fkoqEOrm1jnvQoTZhOwkGyp0JCzjlp/LLc6hqrCp1EdoJlOZo1FJI5NySjUgf56T+T3c85d2D7/Nj0zlEExbBPico9BUkc6/z/8CzpjUe1ZhgJYJnGd8w6VOar7zJSrqYDq/+JmnaKRaRd6VGaesyrEILX5w508BbRsoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940503; c=relaxed/simple;
	bh=QPh7e9eiePKDS5Iu1Lnt8GQMQjYknAYedXbsFjt0hLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEva5RVqoc+8veinFsM92P1xgFZvByhVL1uddhwwGuode7cHYMziwvkGOGcPmO4/2W6SSl+UGg3EsAbRjUCwVVrZn2g0Jr3PJUP80VsNdKEMnxhbClucGmh1JucxbaxWqN+2qVO+IfHxnocSZivbtPBDDDHiCOcejFj1mt/n3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HCs6CWvx; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ecae310df8so40260991cf.2
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761940498; x=1762545298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IU/QqETuJdntfBWhKIOrTKQs8Zk0lk7TKDLyBHhzDZ8=;
        b=HCs6CWvxWsN5eHCol0QFylm6MAkrdUaASBUfM02AjR/3sRKgIh8OJg1VG8aESt//8t
         +Wi+bRE/nviI1SfX7B8gMmAJs1DMktc+Zog9vm7vorrs1rAQ053BT2XxZGcISRleoLZL
         6MPmp5Fh8dJqbQpGecjpSLMTZnbv8HQHZ/hV8cxjK48L/VrfThTuhckXuBeKLJFeQL3d
         SpudHeL6f6wP4F1yuuCBsDFMhvcYrf3WG2EFhbL3j3RFWMTPc75rxO9u/7xYrWQi4woz
         lT92kcPOKWgDRKJT2//EcZUq8UcUe5qFjdVDbbZ/vqvmrSaOUsOETjmUFR8W5IlqllF8
         A3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761940498; x=1762545298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IU/QqETuJdntfBWhKIOrTKQs8Zk0lk7TKDLyBHhzDZ8=;
        b=l6oKYwfwes6MNZXEujNjoTY9P6KlK7BykDYSz2Q5KwsTe6GwkVIwcMGqVfINBw1kfx
         RILY3mJ129TMcAGiiQHKj1cYUQxuBneKUKfL8XkHF8bIz4TvBjjYDkJ0ZMcKFd0MOk95
         Mm9QYoSUJTVoN030xEcnyUb238qp4XPFqj+vDZTC+OjjTyg1UgQZ4Qx3M+usfPUIrGNF
         3GVOz4OD3c60U1cJDBt4nKdxfMfVhyQZhZiRLMLrjc4x3nsL2PmMD3MeK3MiZ3OOEAxo
         IGLfjf0spuLPx4p6eM9hvPaDxznxKkKFexN9JHr2nWklLAbgidwxDz+tAZvhlC5rGisO
         kdxQ==
X-Gm-Message-State: AOJu0Yx03P5zUULOYfHQUb4bFP74drJlp5ZdBXM0Wfl4PSZG8X4wPgBf
	2Qr/d3Ku2cN2t1W1aSg3kYDKI5pIpdc8b85yfiD9vek2ViaxcNSKDzHyCWmauemwXwo=
X-Gm-Gg: ASbGncvfU+GrGIx/w25gAleXkqxZUaks6uPNUYqS+xgOAJ6SlDowBgUcbKU5YNn1YMZ
	I7KM/C2lJ5e/R5Rm1Tvp5a0z9AWGsiWKahpnDzur0spx8LL+jMyUUytaCVuL2+09jkS3Vlr510z
	zBbuM9H8Ii2pD2rOFRJTOKQrvACXMVyg4CVeQ6zVJO9KW8SJ5D8N34BF9nf3kDC3xaSWr42I/4w
	q0tYwZuYNtEptv+yqmZUuA5ybrBWqi87IX6OFsSEkIIdusdn7EVxB3EfrpGlQHhT+4b+Cz4KFtp
	4bBBn7b3cOtnllFA1pJzt8ywCTgj+mn8GFP/j253piO2pMKAxIwoPjBo6FZ8DH4qqtIZEBtwxri
	UWk8SEfW0Kt+CwnluY2mouah8hBOVbyRx8XD+Qu9C13ZwRg5vGZLvXGzq1JFYvIgMfoRbPzIItm
	oOalqVS7RZcVQ9y+9vBxaWZ4Uv
X-Google-Smtp-Source: AGHT+IHVhbrE3ikJBlrrfGgOOS+pKyuTjvcc1uOGzO1TVrPWUUF3dyxGkX/Bbt8JKQ8ECCcokkGkMw==
X-Received: by 2002:a05:622a:ce:b0:4e8:a8be:5857 with SMTP id d75a77b69052e-4ed3100173amr55415401cf.55.1761940498093;
        Fri, 31 Oct 2025 12:54:58 -0700 (PDT)
Received: from [10.73.214.168] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac00a9997dsm164052285a.16.2025.10.31.12.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 12:54:57 -0700 (PDT)
Message-ID: <176362a7-5ad1-4639-9690-b6f375daf917@bytedance.com>
Date: Fri, 31 Oct 2025 12:54:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Modify mlx5e_xdp_xmit sq selection
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, witu@nvidia.com, parav@nvidia.com,
 tariqt@nvidia.com
References: <e25c6c0c-1e2a-48c2-9606-5f51f36afbf0@bytedance.com>
 <20251031114058.29d635c5@kernel.org>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20251031114058.29d635c5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/31/25 11:40 AM, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 17:42:50 -0700 Zijian Zhang wrote:
>> When performing XDP_REDIRECT from one mlnx device to another, using
>> smp_processor_id() to select the queue may go out-of-range.
>>
>> Assume eth0 is redirecting a packet to eth1, eth1 is configured
>> with only 8 channels, while eth0 has its RX queues pinned to
>> higher-numbered CPUs (e.g. CPU 12). When a packet is received on
>> such a CPU and redirected to eth1, the driver uses smp_processor_id()
>> as the SQ index. Since the CPU ID is larger than the number of queues
>> on eth1, the lookup (priv->channels.c[sq_num]) goes out of range and
>> the redirect fails.
>>
>> This patch fixes the issue by mapping the CPU ID to a valid channel
>> index using modulo arithmetic:
>>
>>       sq_num = smp_processor_id() % priv->channels.num;
>>
>> With this change, XDP_REDIRECT works correctly even when the source
>> device uses high CPU affinities and the target device has fewer TX
>> queues.
> 
> And what if you have 8 queues and CPUs 0 and 8 try to Xmit at the same
> time? Is there any locking here?

Thanks for pointing this out, I will add a lock here.

