Return-Path: <netdev+bounces-138188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ACA9AC881
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912CC1C22E4D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88E21AA797;
	Wed, 23 Oct 2024 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0NlSRP/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0071AA795
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681508; cv=none; b=EtFHxC4w7mdIoJ119I+jmuCattKnz8q8PvwRgM/wub1Z9ObMMj1sV5QdLrGQpjvo364pdhc6piAmviB+ro5Qdos96u8hG7XW84xS3fROZVidhKNXqepEeqy1a2nTbE0PTc9+PWJA8GvhQyflkFjJqTfxrK9UQjYBfh1Spu+j7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681508; c=relaxed/simple;
	bh=FKa0AF6d011xZG8QkoSi3NfLB++wBZ3dxyZrKs++iYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlZNT4vUnu/MrVdr0zlDCeTQxnQw5b3UApQGQIIIFyhC/FRzrpaiWOi6g7paWyGhHGtqdRtglZ8zRFtxxs1oZAPGveCl5x8sM1Utwe3itfEGcWhPAwQBEfiV0DN0/cjrqL/0u4V6T0ia7veJl2dgXVi+b2ld4pO9xnc9O/7TsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0NlSRP/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729681505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRoXCL+lJl+eEBbydja9iJndeH+Hx6b3dZuvZ5kid7Y=;
	b=L0NlSRP/ldkZcWRBKRP9pVR1zcKGkGRxbjsfjjTlus0tXKRPvxND5Q8bVIxlVFljmFf6d8
	ItbAE4JP5+c5/G7T29VwrjcQOawjlSe7OB1UNtFdzUYvEc2O/n2xaVtQ5fLwRElIK7CIsZ
	ptNCo9ZrnI0B8EBOAf+AtF0DX1GBAPk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-lDzSg2zkMHepkHJPuyELDA-1; Wed, 23 Oct 2024 07:05:04 -0400
X-MC-Unique: lDzSg2zkMHepkHJPuyELDA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315af466d9so46536365e9.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 04:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729681500; x=1730286300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRoXCL+lJl+eEBbydja9iJndeH+Hx6b3dZuvZ5kid7Y=;
        b=VLYKVFkLYZeaaeEi8HBbuNmorR4hF5lZjS0p4WUbu7oklLsjTTRQHDYyo6kgsUm/ZC
         C1dUjKAgROxH0mZ5J60T9JhM0aldHBtnhFH3ZQWeNu1zU68GqHt9Wz11ijJOWZ+GycCq
         XLhTBX0SLCgkM/BZtxSlUU3x1IOCtOl6eaqxVFAj/dexPRycSwdNgouFvxLSh1DQj8Fn
         aN7TzeQhJhGN4VSweVnswqWmv0ENYCAP/2CUVTp4bI33yCj0bR+trKESEAOw+ksklia3
         +Zk8AoR+JY2EkXlpfq3xtYyINbTRA1XvPwYS43tByLNio83e6OM0zJjTraeplxnoXJSa
         IW0w==
X-Gm-Message-State: AOJu0Ywf/8luWulgr7tHpQWbb1xGG7S1R0ee1vKOKVxz//tW94z0miye
	64GsNXKMseqDL5/iIaoM91oqGSxhmwGdAymkxilCtfyad/KCBjuus4vPuTCGeoLMwXDwyiIMjYH
	2FyCCy4j0QPhCtT3MGvtqUQY7IElBbKn95wbFdz0O+Hz9FF1Kfk3YOhWv5ZEFvRE9
X-Received: by 2002:a05:600c:3d0f:b0:42e:8d0d:bca5 with SMTP id 5b1f17b1804b1-431841ee366mr17195225e9.2.1729681500484;
        Wed, 23 Oct 2024 04:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY58cmWvEmPe/4FpKoI+3ygOiZWLFnMN0K5Zric1w/pJEuRWQvnQFgD2iSswM4EI9vuy0Nsw==
X-Received: by 2002:a05:600c:3d0f:b0:42e:8d0d:bca5 with SMTP id 5b1f17b1804b1-431841ee366mr17195005e9.2.1729681500051;
        Wed, 23 Oct 2024 04:05:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c50947sm13188845e9.45.2024.10.23.04.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 04:04:59 -0700 (PDT)
Message-ID: <cba18775-af46-4ae5-ad29-28687401781b@redhat.com>
Date: Wed, 23 Oct 2024 13:04:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 5/9] phonet: Don't hold RTNL for
 getaddr_dumpit().
To: =?UTF-8?Q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org
References: <2341285.ElGaqSPkdT@basile.remlab.net>
 <20241018171629.92709-1-kuniyu@amazon.com>
 <12565887.O9o76ZdvQC@basile.remlab.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <12565887.O9o76ZdvQC@basile.remlab.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/19/24 09:48, Rémi Denis-Courmont wrote:
> Le perjantaina 18. lokakuuta 2024, 20.16.29 EEST Kuniyuki Iwashima a écrit :
>> From: "Rémi Denis-Courmont" <remi@remlab.net>
>> Date: Thu, 17 Oct 2024 21:49:18 +0300
>>
>>>> diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
>>>> index 5996141e258f..14928fa04675 100644
>>>> --- a/net/phonet/pn_netlink.c
>>>> +++ b/net/phonet/pn_netlink.c
>>>> @@ -127,14 +127,17 @@ static int fill_addr(struct sk_buff *skb, u32
>>>> ifindex, u8 addr,
>>>>
>>>>  static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback
>>>>  *cb)
>>>>
>>>> {
>>>> +	int addr_idx = 0, addr_start_idx = cb->args[1];
>>>> +	int dev_idx = 0, dev_start_idx = cb->args[0];
>>>>
>>>>  	struct phonet_device_list *pndevs;
>>>>  	struct phonet_device *pnd;
>>>>
>>>> -	int dev_idx = 0, dev_start_idx = cb->args[0];
>>>> -	int addr_idx = 0, addr_start_idx = cb->args[1];
>>>> +	int err = 0;
>>>>
>>>>  	pndevs = phonet_device_list(sock_net(skb->sk));
>>>>
>>>> +
>>>>
>>>>  	rcu_read_lock();
>>>>  	list_for_each_entry_rcu(pnd, &pndevs->list, list) {
>>>>
>>>> +		DECLARE_BITMAP(addrs, 64);
>>>>
>>>>  		u8 addr;
>>>>  		
>>>>  		if (dev_idx > dev_start_idx)
>>>>
>>>> @@ -143,23 +146,26 @@ static int getaddr_dumpit(struct sk_buff *skb,
>>>> struct
>>>> netlink_callback *cb) continue;
>>>>
>>>>  		addr_idx = 0;
>>>>
>>>> -		for_each_set_bit(addr, pnd->addrs, 64) {
>>>> +		memcpy(addrs, pnd->addrs, sizeof(pnd->addrs));
>>>
>>> Is that really safe? Are we sure that the bit-field writers are atomic
>>> w.r.t. memcpy() on all platforms? If READ_ONCE is needed for an integer,
>>> using memcpy() seems sketchy, TBH.
>>
>> I think bit-field read/write need not be atomic here because even
>> if a data-race happens, for_each_set_bit() iterates each bit, which
>> is the real data, regardless of whether data-race happened or not.
> 
> Err, it looks to me that a corrupt bit would lead to the index getting corrupt 
> and addresses getting skipped or repeated. AFAICT, the RTNL lock is still 
> needed here.

To wrap-up Kuniyuki's reply: addresses can't be repeated in dump. They
can be 'skipped' meaning the dump can race with writer reading an 'old'
address bitmask, still not containing the 'new' address. Exactly as
could happen with racing dump/writer both protected by the lock.

The bottom line is that this code looks safe to me.

Thanks,

Paolo


