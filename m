Return-Path: <netdev+bounces-204194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3831CAF9748
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A6D5A05C8
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F14501A;
	Fri,  4 Jul 2025 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7lpAEdK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1861E7C1B
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751644250; cv=none; b=TCR0/KL7DtK31gfU3jSvwZHqOz29unhKDkuu7IQ1tZHqJxHgapTFwMdpiORrFuZBPXoaVKKrnhsdWfJ0vINTsb6u3jr77rk/NTjlx7hq47PD0rlTsstzcYayd+upMFV/QDh/DORy8U49LTwAGgwCO3O38R12fPTQhdV0Y9EGJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751644250; c=relaxed/simple;
	bh=v4y9hjaECbxJ58t1a+ljNIGNGmARQwwnjn74YOZRZ7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYuonfNqOTtr5TXMlSOF+x2UZZjWmmUcdpdTex8bVl/eBYMSYJlSeeAEmhZQeJlmIyrTjjBLqp2XM9RVTlwDjvIgGg1FQ+3+MhRdXI9Map+eGY3PPIfb2xNIH+P1TLdm0mURygNMOTQS62IdMNRXG9ScJ30rBbKbqZdI/jdpFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7lpAEdK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751644247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIlXKRuex4Uektqt8RduXNnmtT2T4T8FvbHA7xmItfU=;
	b=E7lpAEdKB8RTih+uOrvl2UaEyqU+CQ6GwbNOl4X26f/ZaoftWNDL1BzgS8FXFWRZU8Lscu
	zBDGcCX82pO5O+G7x7AgNlRRkOjOojx3LAiXSlY3nhnvHTNnUaRv2KPcz+5xNSeRW3c202
	mN3xriy2u13pMZCWr0IskbTcTyPx1Bo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-9OJapzdeOBK2eK1Nkg6Mdw-1; Fri, 04 Jul 2025 11:50:46 -0400
X-MC-Unique: 9OJapzdeOBK2eK1Nkg6Mdw-1
X-Mimecast-MFC-AGG-ID: 9OJapzdeOBK2eK1Nkg6Mdw_1751644245
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d290d542so6324605e9.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 08:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751644245; x=1752249045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIlXKRuex4Uektqt8RduXNnmtT2T4T8FvbHA7xmItfU=;
        b=TpHr0mGC9IcZrwseD4QU+6q5bAtfYAAn4W8OCA2mnICzn+yPc/Z1d687ih8wKl4iMh
         LNP6uOShfTs4QcadqFclDA60W8QwttAFvWbwRtk0rKj8lmwh/cgRqOeRgY4TFjqyZV3x
         hV13oc7ZVtkHU4nEvRvuUrcC5FWDtJ+WxTBcx0ZIP1cYFZPJtptVeFFJhYhRKOEYRrkv
         njisFZDR0yakCcP+Km6c4rZfF5lkt6Jy4bsLRIr1nwUtiZvn0x4w5A1+boLusx543Xrb
         I2mTH0f99ehIS738qFQn3FTcjDQ2OpOnKvNfSWySH0EhGen08u03ic8gbILlxyNl2TIa
         rB3w==
X-Forwarded-Encrypted: i=1; AJvYcCXxG8DLo0nV7KDYLrTW87wuF8q0idwlJJQPhTKxbrfOb31yz3HbV5euMSKCEGuygqNUZBkHEZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7iBbvUgIZy/H25+m7M7Yk7bRSd35/AI13UVLzjkbpWM9xCEe1
	0YmLLFET4+nHp3zVaWViZVa2XG+8DKRlvRgLj7zlfG/IRKhtSPDquroBJIRrrobJxpriupnINuF
	+k60NVjMVXpwbVOkHCPRbp4p8tJQteNa5iaEowqTsUE7veZd31H/kei3P2A==
X-Gm-Gg: ASbGncvdoXwWwdXm8O3UpR0F4K3PNq/iHQ2X/Go2r7KyoONo8FCI+gZsjAG9Uv+kf7a
	aY7drzXmRPAdQdLi5EqrmyL71UYJOnfQoxs5fkc+sQaHHxQR/zF2R7cccSbjDheSXehz0oZyzoC
	FAe+Gs8zMQTTp/B5aGlCf9oi6AxhMcKJamcRdG1BdtS4wfB4aJSEZwLdc6gJ/D2W9ZUSk5m5NIp
	EVZu1pZ8WZg17ZGy+F4+wnPeG7XNrYlvh4QQ6nG6cf6DJXdngqwYY9aE+hTc5t1iXZZc0YPYz+J
	t+pf0nDpns4lZTXW4AzX0K1hUnTv4yN5uPfX9HmAqqTSDCmy338iGlrj3LTib6xlOcI=
X-Received: by 2002:a05:600c:620b:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-454b306c152mr29742535e9.6.1751644245132;
        Fri, 04 Jul 2025 08:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsgA7XYKBBw3EQMZa8JF43UMRxcEZOtJQKdgaXLw7ik/LQ3Jo+Cs4zNGNdfG3jrlZYiq9/Fg==
X-Received: by 2002:a05:600c:620b:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-454b306c152mr29742215e9.6.1751644244687;
        Fri, 04 Jul 2025 08:50:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1685499sm29511905e9.22.2025.07.04.08.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 08:50:44 -0700 (PDT)
Message-ID: <1a24a603-b49f-4692-a116-f25605301af6@redhat.com>
Date: Fri, 4 Jul 2025 17:50:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] skbuff: Add MSG_MORE flag to optimize large packet
 transmission
To: Feng Yang <yangfeng59949@163.com>, david.laight.linux@gmail.com
Cc: aleksander.lobakin@intel.com, almasrymina@google.com,
 asml.silence@gmail.com, davem@davemloft.net, ebiggers@google.com,
 edumazet@google.com, horms@kernel.org, kerneljasonxing@gmail.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stfomichev@gmail.com, willemb@google.com, yangfeng@kylinos.cn
References: <20250703124453.390f5908@pumpkin>
 <20250704092628.80593-1-yangfeng59949@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704092628.80593-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 11:26 AM, Feng Yang wrote:
> Thu, 3 Jul 2025 12:44:53 +0100 david.laight.linux@gmail.com wrote:
> 
>> On Thu, 3 Jul 2025 10:48:40 +0200
>> Paolo Abeni <pabeni@redhat.com> wrote:
>>
>>> On 6/30/25 9:10 AM, Feng Yang wrote:
>>>> From: Feng Yang <yangfeng@kylinos.cn>
>>>>
>>>> The "MSG_MORE" flag is added to improve the transmission performance of large packets.
>>>> The improvement is more significant for TCP, while there is a slight enhancement for UDP.  
>>>
>>> I'm sorry for the conflicting input, but i fear we can't do this for
>>> UDP: unconditionally changing the wire packet layout may break the
>>> application, and or at very least incur in unexpected fragmentation issues.
>>
>> Does the code currently work for UDP?
>>
>> I'd have thought the skb being sent was an entire datagram.
>> But each semdmsg() is going to send a separate datagram.
>> IIRC for UDP MSG_MORE indicates that the next send() will be
>> part of the same datagram - so the actual send can't be done
>> until the final fragment (without MSG_MORE) is sent.
> 
> If we add MSG_MORE, won't the entire skb be sent out all at once? Why doesn't this work for UDP?

Without MSG_MORE N sendmsg() calls will emit on the wire N (small) packets.

With MSG_MORE on the first N-1 calls, the stack will emit a single
packet with larger size.

UDP application may relay on packet size for protocol semantic. i.e. the
application level message size could be expected to be equal to the
(wire) packet size itself.

Unexpectedly aggregating the packets may break the application. Also it
can lead to IP fragmentation, which in turn could kill performances.

> If that's not feasible, would the v2 version of the code work for UDP?

My ask is to explicitly avoid MSG_MORE when the transport is UDP.

/P


