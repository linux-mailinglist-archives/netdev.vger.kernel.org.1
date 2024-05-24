Return-Path: <netdev+bounces-97978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A1C8CE6AE
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 16:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336021C21E04
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE312C476;
	Fri, 24 May 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="fFcyELiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65D12C475
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559723; cv=none; b=Z78EZAv8+pN+KC8Eem7BCoVMNWsmakeYwUR8y5RYv5anyzJL89oNWfkx6WQh59Vnoou0T9me581Th6xSegnaJAnsVmZOa+EUQO9gabiLmerHMGtXX6Q38ohFFdQ/grYBOfYDB678ZTVgRTn0DYE0riug0wVMaC+XIRd64QhWOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559723; c=relaxed/simple;
	bh=q9tnOQooe9PI7e3SjCezUK1kAPk/OmZWIxtU+okF2KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6zyBRjnbwy1cC7Lz7t3Shstr6YWS/7T1HTSptObkgUhMS/G4iKxAwi+HHrB4qCSXDvtftN5JkfCoE7EkKjorkre8I+cIDBgH2wcROJNkZalczCcGCAbc1MxSeR1vi0ceTtOHfEHMAYpn36hgRm0LyZL7pGGMh7kbv9ht29becc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=fFcyELiR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso6366433e87.3
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1716559720; x=1717164520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99TECQ1cUmwOOxSZm3rzy2IiUVEnNv83aOFAXyx4tTo=;
        b=fFcyELiRTxN0+t0yEgV5M2CO5+epbYmMVqwZ/YtS+HK0PQvd8mBwwUzHIY2R1Hf4z4
         2regZAwF3Hk3fgjQoQIwuwI5g03F/MJOOJ88HVDVIQ4eEjIQaSJhwfS0k0o0CQaomaV5
         JxUyQmn6Qg/zHZlh0Rp5ynDzzdFlz8uCkbrqrbDhSDU7GoMD5Jz0+tXLWrVUGvJvX4GW
         ul49Ij838tg7Big/QNG6d1iFbunEAADPsixQyaIPOXec0v710dHZBg0PVzSqAbvXlBbN
         Ex0MhAZp4yzWpszqnTWNsXvAOwSbMT3bZn/NuDvjKX5qXJn0lhp8Qr85CEmV1iBtRFVS
         fssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716559720; x=1717164520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99TECQ1cUmwOOxSZm3rzy2IiUVEnNv83aOFAXyx4tTo=;
        b=dtzVcFLvWVganHMXB3koDacw/TWcXtkHVGsxzG/rppj5LrWULndbzZ5DfLl5Auoy9y
         KylUIdLvOYGbBmNw5FgL9v6VhEojhrVp/rnDcO/D5ImchK0x+1f6jvj+xfbCv/J34BFg
         EhbMD2rWBnGZu53mlqA8s+pkKpa+haFtRD6dlstlKeQC3iFRfd/1qathsVKKMSPNLklH
         CXG8DZPbzk0KPH2U3wvJptxVBIz04HPGlVi9z9mQZdrFKvLX3wxA5ikhOHfGK19yS41k
         UXu8Oo3Bm7mRoxQEzQZK4hZ/I67urcxMPCJMo6OOfycRLcupbrKZ3TAOX7ljC4SnDzib
         EBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb2mwdIp7fRftaJRaszrzWvroEHRUbuHMMpugiKiTvs7ewXqeoGue+leWLpY5feqYnAzMKXteeygAZ1L3YVjitrKCkoLZJ
X-Gm-Message-State: AOJu0Yxxt5QVDgdYUw9o8NQkjhlRVnD2e60FqV1wNNoGd5muOVMwL5Al
	cy2izpi6FhDvuUOy0/c3STDxGQ3KCI7QQ5C8CodZdzgchn1VUeahAU+dxfX+PuGFnN4y80PJwv+
	dsC8=
X-Google-Smtp-Source: AGHT+IHaoO84vz3MtS9f5/n7iE1AYo8TY+HFLolwK1jCye8w2lpMjpCuhp0rz68bNAVsIVjObv2MOQ==
X-Received: by 2002:a05:6512:238d:b0:51e:7fa6:d59f with SMTP id 2adb3069b0e04-52966bb200fmr2245358e87.53.1716559719426;
        Fri, 24 May 2024 07:08:39 -0700 (PDT)
Received: from [172.20.4.8] (92-64-183-131.biz.kpn.net. [92.64.183.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bae15sm1769721a12.86.2024.05.24.07.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:08:38 -0700 (PDT)
Message-ID: <39211313-38e4-400b-96cf-46fb5e82c5f0@blackwall.org>
Date: Fri, 24 May 2024 17:08:38 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/5] netkit: Fix setting mac address in l2 mode
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240524130115.9854-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240524130115.9854-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/24/24 16:01, Daniel Borkmann wrote:
> When running Cilium connectivity test suite with netkit in L2 mode, we
> found that it is expected to be able to specify a custom MAC address for
> the devices, in particular, cilium-cni obtains the specified MAC address
> by querying the endpoint and sets the MAC address of the interface inside
> the Pod. Thus, fix the missing support in netkit for L2 mode.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/netkit.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



