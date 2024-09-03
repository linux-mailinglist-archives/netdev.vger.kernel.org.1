Return-Path: <netdev+bounces-124430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31467969781
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6251F24998
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3CD1C986A;
	Tue,  3 Sep 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alGuxbQi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF721C985F
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352894; cv=none; b=b4msTt8y0O/m6P4YcM4ZOGdVesRHINWjA4KU/Rayf3mMzLBpYHk7KQd68+jKf98xeC29vU3NA8+mK8VlwK4aIQ4M932QZCsxrGFZMpwPTAgnuzx0CAzA6WFxnHAT9FqUf+3AVy+6F4wxQe5OCaB/Qnp9z4npfz+GJAezXWdmgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352894; c=relaxed/simple;
	bh=GcsHOfPjVD1Tsf9xv7NQ/ggipDQui9jg84eq37UAxeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMZ8h2kyvE4b2e7Qvif8pInaWtWvAMRQTph2UPDEHZt05g8U6i2pJO7IaZh66NmXxi6iXBnglLGH8RL7IkqQMtpFJFyw2wl5XOBvSvYdQrMoxfvbR0v7/8hIdzkRTkjcZH2eQIkrfx8WPSbgiXrnhdkAodX0jkSBU+xVuEcb0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alGuxbQi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725352890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIyFkWntwYJHuCFsPUclu0LiqtlYkXUwoVXphp9QG1c=;
	b=alGuxbQiG4VRWsZwxX/9Dq9pjZeRtMUaALQGIAkNcJAAFlVWxzVQUzLlQ14/tYOqVJ7UGH
	c5h1ql1BLuWqONdCqg3aeu7bby551zkNHFVXn2AmAk6Oz4vZ8Cwhc7A+FFT73MgLqdnTUD
	RI/GodYqtlUkS9bUR9qYvAzHRVsQRf0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-X-IeIphMNFCqJ7nCt-zndg-1; Tue, 03 Sep 2024 04:41:29 -0400
X-MC-Unique: X-IeIphMNFCqJ7nCt-zndg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367990b4beeso2877952f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 01:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725352888; x=1725957688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIyFkWntwYJHuCFsPUclu0LiqtlYkXUwoVXphp9QG1c=;
        b=LBME2YYkN0WeH7gJcmjBvXHbzvxkRGc9KrBw9mSIHOKHmnPxajcKrDlNSWWZbJDqqN
         1sHL+sgQ31ZK/5rlZFANZv7wQyrQSlaP3VsR22YQlFlaJJZtIns7scVeDLLfXeMP9q6g
         QBhKxuNL/IfcXGpNia5uVhqjQWr/R3gldGsZBfjpEWvYh1nrrigaKlrJPahL9bYBF4MR
         dP6xGwynPGEkdvux2JBbQxUBN8kd/JPQ3pLz6OV+eUq8tTI2bYsIMhuACVlVmYodAmz8
         WRDWMSdKpwys4s5CZ59bum+3t8djgK6VSMvt5svi1luxTahbvHzg2ongkrR2AYRYBP88
         0ujg==
X-Gm-Message-State: AOJu0YxwsHNnsn5ML+rYNTLTsY3Ok5QcTthSHcA3uPFIUAxef9ErYvGw
	TAASkJAZGxfYKLWpPzGzzaBDNtHBB9OOiN3bS5qAlod2x5usVuXHyZNe6NqOUKuivn0XBhft8kR
	1onL4HGxhHh2hq5JC0FmhtfazsFRlVcCL5ZYxwSH8CFpuIKCP9HXejg==
X-Received: by 2002:adf:f68f:0:b0:374:bcc7:b9bb with SMTP id ffacd0b85a97d-374c9460ff1mr4030009f8f.35.1725352887949;
        Tue, 03 Sep 2024 01:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgwmdCy4NUtWdtKm1Q+pyYuJIGnQfjLhCqesCGn2S9nUYC6eJTestPhcYKIh6CvSMf76smYw==
X-Received: by 2002:adf:f68f:0:b0:374:bcc7:b9bb with SMTP id ffacd0b85a97d-374c9460ff1mr4029982f8f.35.1725352887452;
        Tue, 03 Sep 2024 01:41:27 -0700 (PDT)
Received: from [192.168.88.27] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c15705easm8227536f8f.33.2024.09.03.01.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 01:41:26 -0700 (PDT)
Message-ID: <f55302d0-4b16-42b7-9f19-420de2279d7c@redhat.com>
Date: Tue, 3 Sep 2024 10:41:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ipa: make use of dev_err_cast_probe()
To: Yuesong Li <liyuesong@vivo.com>, elder@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, lihongbo22@huawei.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240829030739.1899011-1-liyuesong@vivo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240829030739.1899011-1-liyuesong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 05:07, Yuesong Li wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
> v2: https://lore.kernel.org/all/20240828160728.GR1368797@kernel.org/
>    - fix patch name
>    - drop the {} and fix the alignment

Meanwhile Hongbo Li's version of this patch was applied by Jakub, this 
is not needed anymore.

Paolo


