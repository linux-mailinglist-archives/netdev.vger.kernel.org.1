Return-Path: <netdev+bounces-292639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LStCYUQGGrmbQgAu9opvQ
	(envelope-from <netdev+bounces-292639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:53:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9625EFF9E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B72C30801C2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7BF3B2FEB;
	Thu, 28 May 2026 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1sVsqbv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkdPAyRh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756A3B2FC9
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961828; cv=none; b=MtAVjXer3o/DmBIalqpunF+viwdzfvjCiiW+wINTrqPIlbT+RXPJh7nZ2OaiCYSrKbqtIyKTA6clZn9gE54ixvAP8zzNPFduarwo3bapN7Hvm5o7l5xyMVD6mIHFgOOM0nLANmianntn84qj8BoW0TGP4pnibfc7bTqaKyVp71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961828; c=relaxed/simple;
	bh=bdsXWGJhUs6JDDm8gke69s5CG3isXTKgYUZ3zq3EULE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0DcUsuZD5L/JInGPP60A7BrhFlELRnRjZcldnBQyXnO8D5843kFA5L3x2dW4tmkF7g5+3kE3W+3jx4oelbEq52+Q49/KCqdWozxXwJdwwzHzxfdE+Kd1gYkHhhQXiL0eJDjtmltCNW+DvJuGkWZO2h3pM97SyGG0EtHQY/9Gjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1sVsqbv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkdPAyRh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779961826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdVzHsDJy0935yJCy8z3AeQh4RKD4uBZVeTQ9sKVsGs=;
	b=g1sVsqbvcsabRvcqZcr8EpEcjy0uoBQXp5SzQfxnVamNVZwb4/UlHg4qQohXuUq/uasqPT
	tR3r4in2G3YXf6pk3UFTHpxUW9iUuY1d/EwhqTCu2HB+K3kJUnn2zulMgr4OA62CvLqtxe
	kw/gvAS/PyqF1bGesOgc0Ob60iudMKw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-ZdmJO9lOMYaIKfaSlD0xSA-1; Thu, 28 May 2026 05:50:24 -0400
X-MC-Unique: ZdmJO9lOMYaIKfaSlD0xSA-1
X-Mimecast-MFC-AGG-ID: ZdmJO9lOMYaIKfaSlD0xSA_1779961823
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fde68e420so97458175e9.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779961823; x=1780566623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdVzHsDJy0935yJCy8z3AeQh4RKD4uBZVeTQ9sKVsGs=;
        b=DkdPAyRhzui+arwO2YF1VUiBQ1/vU/P2O/G157BGzS7LAk2Eyf10TJbyZEKyn4FLNQ
         ymqgkJnAthRfulpDOAgbLAbiOdkdyHFOgMX3IeUVY/1ObGW3NkHOO+ni8xOy3hS3cOh6
         Ts3dbfpsq9GS1sofnU4SKeVSKNKILIqujDmOfZdK1z6ZKVunIT4xIuewJXaNN7W3xSyz
         z4204DdXwu3LYU2czDUMKgEJLo+RNxj4TFrlBm/8lK5KJW88vvyPZ2A6zcyyncvFhRzg
         5ai47kOJmc/WqHGD9b2fhfszwi4f50pWZ7F+GkBbyq3hYkBGr2sysAg9rWbFJ6FCg8z+
         KY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779961823; x=1780566623;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdVzHsDJy0935yJCy8z3AeQh4RKD4uBZVeTQ9sKVsGs=;
        b=K2ab8McCgWF3Kj/zMFDXOOqHZIIcYE4qnF8ME3dQrXdFhAfVKX32VDxjVjCakrqeJD
         qWX/kjblWgIa+6CyhueCkhCEPunOwW3H6Uj+LOhQ8JKbUKRFiqWGoZsXkmMLmjOhoOww
         27rXUatK2mNd0JCKyXjrmYDRNUBSM5I6PiByNZmoCrRqK99Ij+TzBqv8OETGwp54XaQo
         oYj8TC5oqDjxoVjW9dkGJNVPi3vGUtQWbrvSpmGALMZ5+6g14VQ9kdoAHNXb3hBxKRGR
         LnzCRTg7fi+vKWV4Lj+6VH+/sQjAsz1dMNWQKYCreKbo+grRZm8jwAIEt8Vyvlcer/hA
         GlIQ==
X-Gm-Message-State: AOJu0Yy5/SAP9hdtrczePV7POW5MDqLFLJQTkWh0/GZNfccBt3q8LjP7
	vwYkgZG0CoMSMwislbVXfI1ukqO64Ki0dk9+0Eaz+XNKpwwXWQXah3FJ4015csivyQhf9pLJ/ZK
	KpArBBqbFWRdx7Vnmm6YSza3O5kZQz9Dg7NuhZ0jVkMJnQ1+O2jRVAQdqKQ==
X-Gm-Gg: Acq92OG9hTy1IoxrSYbgngXG4mU9yF8OW5ZdG/W0TEYaE2VC1fpBJCDk79qKxOfwm6s
	aqtoOXJ1EsyzjShmeuKfrg8XQ/tCg68RK5kXm4P4GccW0FPh3qL7/+IGazFYtzdd6yvWqzjzWMi
	IwNcNY2s9YdqYd6Mq3wV6vfSNi03V2D9Ia0kDn03gpBPwJUSNVk1xaJrZVmC7q4hIVd19Vqek72
	ud80BNifOqvik/gvP5ypkEkhPVNvgIehcKdHOLaCJujClQanEkId3jy+xFRRl5Q23eqY+yZQi/C
	15UbzzL/XjuhW3pdOz0tyz6GFisxDgaKXdh1voX6MiiZ9C9MZmEYlHfmT5THbcQRm8uz2QpG6yX
	Kf9r0aMaWjm0Yd2MQKzWJ+ovws7qM49E4gMD5dTSxHOwI7tlrt7VDFGLEVemBOr1LkQ==
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1e4 with SMTP id 5b1f17b1804b1-49044ebc273mr405897415e9.26.1779961823128;
        Thu, 28 May 2026 02:50:23 -0700 (PDT)
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1e4 with SMTP id 5b1f17b1804b1-49044ebc273mr405896895e9.26.1779961822657;
        Thu, 28 May 2026 02:50:22 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee2a12a69sm5701309f8f.16.2026.05.28.02.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 02:50:22 -0700 (PDT)
Message-ID: <73a2e2d5-cc4b-495e-a7b5-36af411c218d@redhat.com>
Date: Thu, 28 May 2026 11:50:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] wangxun: improve service task
 synchronization
To: Jiawen Wu <jiawenwu@trustnetic.com>, 'Simon Horman' <horms@kernel.org>
Cc: netdev@vger.kernel.org, 'Mengyuan Lou' <mengyuanlou@net-swift.com>,
 'Andrew Lunn' <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>,
 'Eric Dumazet' <edumazet@google.com>, 'Jakub Kicinski' <kuba@kernel.org>,
 'Kees Cook' <kees@kernel.org>, 'Larysa Zaremba' <larysa.zaremba@intel.com>,
 'Jacob Keller' <jacob.e.keller@intel.com>
References: <20260525100543.27140-1-jiawenwu@trustnetic.com>
 <20260527143114.GM2256768@horms.kernel.org>
 <065b01dcee49$ab3f2de0$01bd89a0$@trustnetic.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <065b01dcee49$ab3f2de0$01bd89a0$@trustnetic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292639-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,linux.dev:url]
X-Rspamd-Queue-Id: BC9625EFF9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 4:28 AM, Jiawen Wu wrote:
> On Wed, May 27, 2026 10:31 PM, Simon Horman wrote:
>> On Mon, May 25, 2026 at 06:05:40PM +0800, Jiawen Wu wrote:
>>> This series improves synchronization between asynchronous service work,
>>> device teardown, and module event handling in the Wangxun drivers.
>>>
>>> ---
>>> v2:
>>> - Check WX_STATE_DOWN before setting WX_STATE_SERVICE_SCHED.
>>>
>>> v1: https://lore.kernel.org/all/20260519080048.7448-1-jiawenwu@trustnetic.com
>>
>> Hi Jiawen,
>>
>> There are AI-generated reviews of this patch-set available at
>> https://netdev-ai.bots.linux.dev/ and https://sashiko.dev/
>>
>> I would appreciate it if you could look over them and address any
>> issues that are either introduced by this patch-set, or directly
>> impact it.
>>
>> I would not suggest expanding this patchset to address any other
>> pre-existing issues, but rather address them separately as appropriate.
> 
> Hi,
> 
> Looked over AI-generated reviews, there are some issues need to be clarified.
> 
> Sashiko-nipa exposes an existing issue in the wxvf resume flow.  The VF PM
> resume path currently calls wx_init_interrupt_scheme() followed by
> netif_device_attach(), but does not reopen the device when the interface
> was running before suspend. I plan to address this separately by fixing the
> wxvf resume flow.
> 
> Sashiko-gemini exposes some issues but none of them were introduced by
> this patch set. And one issue I've clarified in the previous version.

IMHO makes sense. I see the commit message somehow touches that point,
but for future memory a more verbose/explicit wording would have been
helpful.

Thanks,

Paolo


