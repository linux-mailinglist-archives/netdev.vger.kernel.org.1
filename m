Return-Path: <netdev+bounces-185583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C4A9B002
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795927AC450
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FDE157A48;
	Thu, 24 Apr 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0ithJRE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A21F5E6
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503313; cv=none; b=UZaw3qGD7bZR1YyY9+kxbp5V0PZxuJ4vlo2q70hNPwHPNqJVP5EA8MqocUbZzCK4gf66Uv4/RgOz+NxCFmf8vnLAb94JkJQAq2V7lIie8dN0DcGLhmxCyswlIV9dvaZP32P8vduompJiwml3FJOf+iF4YvjMF/1lc41xvRVsNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503313; c=relaxed/simple;
	bh=iHaWxkVe1jcDxmKjyeB9B0qxKJcGSLsOrxx7NcTKk5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDCRRbD9TMWamzM1o23rG7b0IF70xv3E5+bbezpP7Wkr9+g5hrzn5JSJIEfH4OT05w3AAcY1UEl7dzQO/TT42vMLgeiSvNlnClLrCXoIjQYUN7kfPgTZBey4I9q5lmXtIKmx6h5Kf/HgX/wEH7VtoRkvdH+UjUUc49CMBIb6wZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0ithJRE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745503311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOKnMgaGWgwdR2hpccH9xono9NECksAJCZVK7cynoA0=;
	b=R0ithJREy+tv6dd8NQbVOK63megnEVsDNn3yXJV0WCmw0IFDjUHAG3WPGXbMJJHmYKsvUn
	DIYunwNXce4HYKkydmv9l0B5xpeKq+DrU1WJvinZMsNXKS5zTibT3iA6s10XWLnLoAuqwd
	vG6cOvPtIXXukE9HbobjfMqkocoAclM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-SWF_ymHNPVej-C28Py0DBg-1; Thu, 24 Apr 2025 10:01:49 -0400
X-MC-Unique: SWF_ymHNPVej-C28Py0DBg-1
X-Mimecast-MFC-AGG-ID: SWF_ymHNPVej-C28Py0DBg_1745503308
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39123912ff0so351012f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 07:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503308; x=1746108108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOKnMgaGWgwdR2hpccH9xono9NECksAJCZVK7cynoA0=;
        b=nyH0KuQX5EyfZgb+22YjOUJmMXRIFJhg0ALK5iS6E4CJwPGVPYgE4Rn3fuVijsCAvj
         07cA/+uDDtKi7FCmPX77OldUwcjVAFHCuyO5frMW5YqSMMvWk/MOZFEoeNHnJft3Wski
         GSVblIek2J7rtPmxtvORcAfTb5Yeock2KoP+GgAqYIPUnKnSiLXIDZFmXawVrEXLr9bY
         Wb+nhBbs2MqAmr4+8sTYzAw09bVPgrDBTDuQY7qItPpK7+t4lH5FX5gLRRAmDMubLywO
         +1mZTODa+TT96z7GX0Nh44pdNgXOz6gSPWMXbAJSJo066PKMvvcSohbdvf6DcXtwicX0
         LEsw==
X-Forwarded-Encrypted: i=1; AJvYcCUIn7SjHyOpivdq5uoso9W8Wc9ykCfcj7N+7R+YWFIXHxcjNtQeFmoOY6eL5c867sv77VyBEGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEXGiBOdtbPRYgPAqw/pGiR7Cn1asRsLLUNfBf6kvtf/Zexxjw
	7MTWevwer+bBd7eFVknuANX237xtY46BNrDhyV4O4yVbErRn8XivQPxsjvETYOfo1zvdsNNwPyq
	1kJI7DbCagDgv8n4SHxVQElBk8dkyhcWcsQqQ3Zoqpkgj0nFX3oM2TA==
X-Gm-Gg: ASbGnctnmelj9ETIVD85MSARk9ypHTiFQsyiWcIxXMPONLWjpLHfS5s4/zWNPw6DZiN
	29JGezxXj07MBNBjF6vj272kkVFsgjRrnvMtECRfHgeLg53vUNdaOgxS92koy0KOQpTxzrLMlSq
	xdnEVyOnlutbFdv1SdbqenfMsTPQzHdIj/wdYaHPhtzSnih68y47vqo7OnJSyMvIIGvKiYni20l
	SEUnWymKLzQhBgQBYLpbvjokWjZC1FghQAybhuGju4amZDlpSkimWbxge8494APUv/TPQdiUd1M
	kj6O38rhVR0JTeA1gF2SAMcQwAJq462oGSl0iccKO3f5
X-Received: by 2002:a05:6000:2913:b0:391:4674:b136 with SMTP id ffacd0b85a97d-3a06cf6372amr2063596f8f.29.1745503308330;
        Thu, 24 Apr 2025 07:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAR4VGYC0YQuh2Q6vs1FL6y3b/l/flUzkaCaAOT3x6mMafccI1LU527lzjQS8Ouuqipao9Iw==
X-Received: by 2002:a05:6000:2913:b0:391:4674:b136 with SMTP id ffacd0b85a97d-3a06cf6372amr2063535f8f.29.1745503307570;
        Thu, 24 Apr 2025 07:01:47 -0700 (PDT)
Received: from [172.16.17.99] (pd9ed5a70.dip0.t-ipconnect.de. [217.237.90.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d5328ecsm2193910f8f.71.2025.04.24.07.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 07:01:47 -0700 (PDT)
Message-ID: <c2729303-8ee9-4fe3-9755-2b6d0d0d7b97@redhat.com>
Date: Thu, 24 Apr 2025 16:01:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] selftest: can: Start importing selftests from
 can-tests
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <cover.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqK8TdzzMW645OLq5tbkyQdYW+tGGVcr7vsRBE81_u4W4Q@mail.gmail.com>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <CAMZ6RqK8TdzzMW645OLq5tbkyQdYW+tGGVcr7vsRBE81_u4W4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.04.25 09:45, Vincent Mailhol wrote:
[...]
>> Felix Maurer (4):
>>   selftests: can: Import tst-filter from can-tests
>>   selftests: can: use kselftest harness in test_raw_filter
>>   selftests: can: Use fixtures in test_raw_filter
>>   selftests: can: Document test_raw_filter test cases
> 
> You are doing a lot of change to the original to the point that this
> is more a full rewrite. I have no intent of reviewing the first patch
> which is just the copy paste from the original. If no one else has a
> strong opinion on this, I would rather prefer if you just squash
> everything and send a single patch with the final result. This will
> also save you some effort when migrating the other tests.
> 
> I have a few comments on the individual patches, but overall very
> good. Thanks a lot!

Thank you very much for your feedback! I'll silently include most of it
and will only reply where I think discussions are necessary.

For squashing / keeping this as individual patches: I usually like to
have some kind of history available, but here it might not provide a lot
of value. I would be fine with squashing as well. If there are any
stronger opinions on this, keep them coming.

Thanks,
   Felix


