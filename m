Return-Path: <netdev+bounces-95992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46F58C3F4E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D861F245FD
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D2C14A60A;
	Mon, 13 May 2024 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dJsFNyAh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D15101A
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597513; cv=none; b=BGK0rGl5PnM5JmZhBs43TqD4UoElUq3FYVbIQLN8zC6SsoMm0FcwaSMQpY6zNN5eJX5x3TPkHwaCzgqhN7P8mtCujEPv4BPw8wCt4kItyspZgjCWiPvuZL0BBlrdTm0sgHjYrE2pHG/ElkXGayqwXaUHtTy1x2lA9dTT0aP9YYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597513; c=relaxed/simple;
	bh=1Qb4y9KwfDjz5C2p7HhgTy37x1fJFHTTR/oVxADpdCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQt+dMUVjjTjjHQORFrv2AgYv09UNbns1kvGQS2oCz7p1hu2xq5L0TE3t3jf60KT8WtsFZI8PGXFCbaIijakw8dKZFRZ9OR9Vy9z9HHFUty37dtnfJRMlcZCgOpw3iYJvS+hhkkuL4V+em6kojX2ovFgJJwCUs4jY3rcw+Qofa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dJsFNyAh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41fc53252ceso29569175e9.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715597510; x=1716202310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ooLyHZAkmsKRV9R63t2It8AbJ0+ym+g9+imdoyexSk0=;
        b=dJsFNyAhONyM1gDrD/eg4i4ma4Csmxqx7q775P89IQCVGTBOw9Ac6CYWDk6BWpi5yy
         4X0leSK/QNCvfbgiY+OA/af0RxfYZt0P2Rx/VPGHjkkxV9bEeu5pisAbqVHFNKF05KXJ
         +YvURdMkRAa6WKo1vqQeM17OWn40UgXTOnnA1xeFKD+hcBASACS4zBt4zxBVt6bkYoq+
         Mfak/SAzrsxBhTNw4TTPef1s/012vH2kd/MlV7CIhKFck6R3Qea0/ow4FUihjB3AR3mC
         uTLm+Vf8Pm6yB1HMLWac3uVe08bis+NlJZXlyFWU+ZC1RsFuJdrjg8mZIn13xS2p+YEq
         aHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715597510; x=1716202310;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooLyHZAkmsKRV9R63t2It8AbJ0+ym+g9+imdoyexSk0=;
        b=LxkybfjRM7zZ1LRnPr7aP6SswKtWq1P2qKrORIvYWUQXDPAF2lvI4ZB7WXlrRK5CH/
         WO7LFe7p3jNX9/X8q/mtCe1BSxOX3/h7LGih/I33UHibJIW+L6KioacPGxZVLBPZ2mGq
         9VTJGHjxAOOY8Qf1t1NpbFeRu9SiENWT3CWaYrCggAddEuzPDxIGQBXvnd9IliLckQ6a
         NEgybkkClUAAuLmp8saZnFwnH3+qVcGXts6+EG6oejeeCfJxQ1K1X9emn+pnpEN0AuZV
         SH4CGdnRtbVYbfHhdh4EdbefNeFET3yttkX/loXNnex1xmrzrSCf1fys8p8kNHG5wug/
         R2KQ==
X-Gm-Message-State: AOJu0YxSyiNzdd7u8SAzSmSdCYf4GD8LGW0f2KThqEfyauKfG+TONLIi
	/g6TJ9eZcKjgPFd+vaYg4iFNO9rPoIquk0tdJGzcV7VpUAz4prFFEl6mBuVepn97c1lB1M9nj+J
	5
X-Google-Smtp-Source: AGHT+IGXxHdkozw2iof6M5X1m6ZOJ3mDvv3s1TilhrHOMZzWSKCGrwe22vUDqT3fhM66LuKPHHtr8g==
X-Received: by 2002:a05:600c:4754:b0:41f:fca0:8c04 with SMTP id 5b1f17b1804b1-41ffca08dcemr62578465e9.11.1715597509834;
        Mon, 13 May 2024 03:51:49 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:b0a4:8921:8456:9b28? ([2001:67c:2fbc:0:b0a4:8921:8456:9b28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff7a840d2sm113247285e9.39.2024.05.13.03.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 03:51:49 -0700 (PDT)
Message-ID: <278eb5bf-0c47-4a34-94f6-ee62cd74ea1f@openvpn.net>
Date: Mon, 13 May 2024 12:53:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net>
 <20240513100908.GK2787@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240513100908.GK2787@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2024 12:09, Simon Horman wrote:
> On Mon, May 06, 2024 at 03:16:20AM +0200, Antonio Quartulli wrote:
>> An ovpn_peer object holds the whole status of a remote peer
>> (regardless whether it is a server or a client).
>>
>> This includes status for crypto, tx/rx buffers, napi, etc.
>>
>> Only support for one peer is introduced (P2P mode).
>> Multi peer support is introduced with a later patch.
>>
>> Along with the ovpn_peer, also the ovpn_bind object is introcued
>> as the two are strictly related.
>> An ovpn_bind object wraps a sockaddr representing the local
>> coordinates being used to talk to a specific peer.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> ...
> 
>> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
>> index ee05b8a2c61d..b79d4f0474b0 100644
>> --- a/drivers/net/ovpn/ovpnstruct.h
>> +++ b/drivers/net/ovpn/ovpnstruct.h
>> @@ -17,12 +17,19 @@
>>    * @dev: the actual netdev representing the tunnel
>>    * @registered: whether dev is still registered with netdev or not
>>    * @mode: device operation mode (i.e. p2p, mp, ..)
>> + * @lock: protect this object
>> + * @event_wq: used to schedule generic events that may sleep and that need to be
>> + *            performed outside of softirq context
> 
> nit: events_wq

Thanks for the report. I fixed this locally already.

You don't know how long I had to stare at the kdoc warning and the code 
in order to realize that I missed a 's' :-S

Regards,

> 
>> + * @peer: in P2P mode, this is the only remote peer
>>    * @dev_list: entry for the module wide device list
>>    */
>>   struct ovpn_struct {
>>   	struct net_device *dev;
>>   	bool registered;
>>   	enum ovpn_mode mode;
>> +	spinlock_t lock; /* protect writing to the ovpn_struct object */
>> +	struct workqueue_struct *events_wq;
>> +	struct ovpn_peer __rcu *peer;
>>   	struct list_head dev_list;
>>   };
>>   
> 
> ...

-- 
Antonio Quartulli
OpenVPN Inc.

