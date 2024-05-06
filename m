Return-Path: <netdev+bounces-93550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F568BC4E0
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA1928184F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C721FB5;
	Mon,  6 May 2024 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KXy8eWhA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838E394
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714955673; cv=none; b=WJ4PEvsqEAT/03a/rX0Prgukvw6DowOcyd6yvKOW7X2jj+cKleon15407fYV/fSFJFlga3Vn/ipP4aL7f1UGTP5Ww8RJYeieKiEc/cxihKnX3FnfM1ZaeY3ZL+rcmt4mDg2Dlrlnj2QTE5UsW7LTdlashgXjcQgDsN5YFptxD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714955673; c=relaxed/simple;
	bh=AChhY6Myt2pb74qJtHVyBe5JqImoAm33aR0NbEtiqYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFpMmc9g5jfXuq+uBTKojZsRhlLeBxWNo/qvCERsB4XeOuo6lP1XilgBbX9Wwvn+XceJZh9IxhAY9cWbPGmUYEQGlISwTSH7UkdoK6OjW3WzyjdDWIQv6y0S2U++m+wChxuAQsrU2ySexqny18uy17g/7D9P/vLKwC2p1H5mIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=KXy8eWhA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3ca546d40so8916375ad.3
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 17:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714955672; x=1715560472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+Cu/MT7DpQXuRb2kGF1GvRQ7Ne4HnhFHxyuoOlIMyk=;
        b=KXy8eWhAZjJP0Hee9Grnlf3SYqkMMweA+LLsTnIPv7LK9yuvofgD7s/ZgScULL8G4a
         fthPgtRdzldclN7DNCWIYMcJyAvvPjLBW/oUxXvABdUzGgnAVl5lp1qr2WNUNRTm8DXS
         irZam093g/pmZLVMy5u1QhyVg86v1jF6jicz9OPzV01rgm7xCZiYUD8sTr4ncQl9kp0O
         MTjpCCxrFCV4mpeXrDOrJxe4PKhk/QLs0H6K/BXx+huXUxK7t/7KkTy2m1C9FLBR3cU6
         8WBYn3bcPS9zZMVnK9JdAYRnmlnsQjcMke0YivDnQpzSBGdEh5N5Fn8xma+rnnXCs4vN
         DI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714955672; x=1715560472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+Cu/MT7DpQXuRb2kGF1GvRQ7Ne4HnhFHxyuoOlIMyk=;
        b=Ietil0N6+5/qcP1H5jw+YfP9Uv9iGK4PExLzKkZcf8g+zlhBo4/rRhCpPU/tbtEkh3
         07HOReaBMfjiuicfyIig2/KLyuUMnX3tC3PPnVBEEUzdmw5Y6qP36mvvzQSoJ3pcqeOZ
         /FAJtTaQ80nwERmsIYRSb0hKeGFXcMUNgvio3NR3aLDiR/C+bYrNwMuJWR+djgxIxBYQ
         hpzGXoatescWpzIy59ZUaqzH4BVf3iibL7od5xf+EoXvwwGY/s9YNaf40gi/OJ2SPEFB
         uSt55b0CHNSvxw0/c6LCmDNOTtk9NCxognXqcQZSfWeYN0gGmkcUBxxj9IsfYs7ghRR0
         BYiQ==
X-Gm-Message-State: AOJu0Yzvezmz68EJY7mjM6xha/X/LcjNPCAkDti+23EpcPHND1qkXy+c
	6I6d2zJhII1g38PqJjy8G97pEJhT6zHI4K27QF7nBXE7s3uEHnuxVJPybQjlv/I=
X-Google-Smtp-Source: AGHT+IEbOa9bCGo2jWicKhu9CfyxIFpniJoiI9MMTA5hN3bQm3MkHBPRtVhbmfNFS7PjwvplGG/lVw==
X-Received: by 2002:a17:902:f549:b0:1e3:c610:597d with SMTP id h9-20020a170902f54900b001e3c610597dmr11359574plf.60.1714955659760;
        Sun, 05 May 2024 17:34:19 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001eceeaaad08sm7019238plg.5.2024.05.05.17.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 17:34:19 -0700 (PDT)
Message-ID: <4f8df603-7385-4771-ab78-24e701eabee3@davidwei.uk>
Date: Sun, 5 May 2024 17:34:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 1/9] queue_api: define queue api
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Mina Almasry <almasrymina@google.com>, Shailend Chand <shailend@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-2-dw@davidwei.uk>
 <20240504121154.GF3167983@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240504121154.GF3167983@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-04 05:11, Simon Horman wrote:
> On Wed, May 01, 2024 at 09:54:02PM -0700, David Wei wrote:
>> From: Mina Almasry <almasrymina@google.com>

...

>> +struct netdev_queue_mgmt_ops {
>> +       void *                  (*ndo_queue_mem_alloc)(struct net_device *dev,
>> +                                                      int idx);
>> +       void                    (*ndo_queue_mem_free)(struct net_device *dev,
>> +                                                     void *queue_mem);
>> +       int                     (*ndo_queue_start)(struct net_device *dev,
>> +                                                  int idx,
>> +                                                  void *queue_mem);
>> +       int                     (*ndo_queue_stop)(struct net_device *dev,
>> +                                                 int idx,
>> +                                                 void **out_queue_mem);
> 
> Nit: The indentation (before the return types) should use tabs rather than
>      spaces. And I'm not sure I see the value of the large indentation after
>      the return types. Basically, I suggest this:
> 
> 	void * (*ndo_queue_mem_alloc)(struct net_device *dev, int idx);
> 	void   (*ndo_queue_mem_free)(struct net_device *dev, void *queue_mem);
> 	int    (*ndo_queue_start)(struct net_device *dev, int idx,
> 				  void *queue_mem);
> 	int    (*ndo_queue_stop)(struct net_device *dev, int idx,
> 				 void **out_queue_mem);
> 

Hi Simon, this patch came from Shailend and Mina which I applied to this
patchset. We'll make sure it's formatted properly once we send a
non-RFC. Thanks.

>> +};
>> +
>>  /**
>>   * DOC: Lockless queue stopping / waking helpers.
>>   *
>> -- 
>> 2.43.0
>>
>>

