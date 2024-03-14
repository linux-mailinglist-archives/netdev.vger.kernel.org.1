Return-Path: <netdev+bounces-79921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792387C0BD
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 16:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6475282BDC
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C3871B3C;
	Thu, 14 Mar 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d64tRXuD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30AE5C611
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431803; cv=none; b=SHAqVV8cjRSWIWmh/OfR+dV5pYVNjxsCnPiYf63o4CDAvk3ZdrW1dpm3FiyqsNIpqW+G4D3sI8oaEegCXaP0VUTO7nIcUZVFO/0tdr1AnuAK5jzKDHS6QEkM4kl6Bp2Esk7MrGmG37o19tLawha9ZzJoboqROPK+zKSgB+tC+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431803; c=relaxed/simple;
	bh=ZmI2FwtVxhizi/aVXNZmngvE2Mq9lBQj5crTBmeXYTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hskc4L7wWtalq8+N5hzgkmy4nHWWML/wP2GgrOI1q//+p0g9Y6ZTYQ4M+F82GzDSWJ1REZRfxanf60mGBpHsqR81Cc6eHN68EF+QxgiKxBpjUbSaSmWK2aS99Djk/rNJAU14sVDFZ05u5tNVmnwjGUofvPOuVpb7OMEdZCCo3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d64tRXuD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710431800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=raY59pnlJKW7cbwoKHkRYsm22tGbdRck+G1yUBJSQ7g=;
	b=d64tRXuDN6XHFiI4n8x8ICrPy7EhNv5rzg+b6l/uq1Elh29R9kERPWbekKZ/C3SHO4+F7O
	SnBRffSdqYbgOrAHpo3+2VF0t84fH4U2L9XyB3FuLiCh3ymj9ee23eiBm/vWf8wIfV8pRs
	QM374J735GWdNZd5aFRUcqvajJ3KRvU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492--JNSKld4M-mdCvrX2dqwRw-1; Thu, 14 Mar 2024 11:56:38 -0400
X-MC-Unique: -JNSKld4M-mdCvrX2dqwRw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33e70016b4dso632687f8f.3
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 08:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710431797; x=1711036597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raY59pnlJKW7cbwoKHkRYsm22tGbdRck+G1yUBJSQ7g=;
        b=Buu5bc38mTP6f52ewh2wNhiTAWUkkkqlx9b5HpbnJppmt93a2FbkKzTabxE5dW2IoB
         F5PunkFbcAgObGzToOq4+nwdadWw3C2OIMbbMk4I85sNCLmX7NwOEEgbBhI22tTFd7qU
         L0hJ3f6eYaO8bZOg+tFp7C0ckiRQSFXafe7XzMv5KIaw5kol02pU3gpHF9i1tih/hrxy
         38rqxooxEm7ebcJ+W2/ErRra1M2SOftQGMk25OGKl30Gycm5H5pV3mxlepla6hJIyKby
         yBPi6Fo2WhhVF1gv4/NoTPjeiJiv0TaEfo4YSRdkl0y8HCzLKar/HuMsG0O6Bo2J/hT2
         jXEQ==
X-Gm-Message-State: AOJu0Yw6mrv8NPOtbDHYKcHlpeJvLPUBx/Ku1ajES47U1iMshEEPZRfT
	7HvBtEWvPo8r+kKD53lK0lwZbXPeRrFR99lsJzPh/3iPsuk46qIDuwRX9G+wc5Z64gwlQznq+Eu
	LxWFF2vt9VcG+ZgDqvJYwLq0hMgQmmcnGs3bwZs1RP+3kyUafV9PiqQ==
X-Received: by 2002:a5d:67c2:0:b0:33e:2a74:381c with SMTP id n2-20020a5d67c2000000b0033e2a74381cmr1489506wrw.71.1710431797570;
        Thu, 14 Mar 2024 08:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4x6eTU8teCC6CGJ52QOp8mBuUEuR7Eq2nl61GhPUb0gW3f0ZBDe+8DgwfB56vKRQvpNDc3Q==
X-Received: by 2002:a5d:67c2:0:b0:33e:2a74:381c with SMTP id n2-20020a5d67c2000000b0033e2a74381cmr1489495wrw.71.1710431797184;
        Thu, 14 Mar 2024 08:56:37 -0700 (PDT)
Received: from [10.32.64.123] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d2-20020adfa402000000b0033e99b339a6sm1019851wra.62.2024.03.14.08.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:56:36 -0700 (PDT)
Message-ID: <bd03c79a-39e9-4eb0-97b2-4ded536f8eb4@redhat.com>
Date: Thu, 14 Mar 2024 16:56:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] hsr: Handle failures in module init
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <0b718dd6cc28d09fd2478d8debdfc0a6755a8895.1710410183.git.fmaurer@redhat.com>
 <ZfL0t5v3szkhEhiN@gmail.com>
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <ZfL0t5v3szkhEhiN@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.03.24 13:59, Breno Leitao wrote:
> On Thu, Mar 14, 2024 at 11:10:52AM +0100, Felix Maurer wrote:
>> A failure during registration of the netdev notifier was not handled at
>> all. A failure during netlink initialization did not unregister the netdev
>> notifier.
>>
>> Handle failures of netdev notifier registration and netlink initialization.
>> Both functions should only return negative values on failure and thereby
>> lead to the hsr module not being loaded.
>>
>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
>> ---
>>  net/hsr/hsr_main.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
>> index cb83c8feb746..1c4a5b678688 100644
>> --- a/net/hsr/hsr_main.c
>> +++ b/net/hsr/hsr_main.c
>> @@ -148,14 +148,24 @@ static struct notifier_block hsr_nb = {
>>  
>>  static int __init hsr_init(void)
>>  {
>> -	int res;
>> +	int err;
>>  
>>  	BUILD_BUG_ON(sizeof(struct hsr_tag) != HSR_HLEN);
>>  
>> -	register_netdevice_notifier(&hsr_nb);
>> -	res = hsr_netlink_init();
>> +	err = register_netdevice_notifier(&hsr_nb);
>> +	if (err)
>> +		goto out;
> 
> Can't you just 'return err' here? And avoid the `out` label below?
> 
>> +
>> +	err = hsr_netlink_init();
>> +	if (err)
>> +		goto cleanup;
> 
> Same here, you can do something like the following and remove the
> all the labels below, making the function a bit clearer.
> 
> 	if (err) {
> 		unregister_netdevice_notifier(&hsr_nb);
> 		return err;
> 	}

I usually follow the pattern with labels to make sure the cleanup is not
forgotten later when extending the function. But there is likely not
much change in the module init, I'll remove the labels in the next
iteration.

Thanks,
   Felix


