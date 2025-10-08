Return-Path: <netdev+bounces-228168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 684D1BC3B7A
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 09:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F04188C7F4
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137AC2EDD5F;
	Wed,  8 Oct 2025 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtn9dCCB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E12F1FF1
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759909507; cv=none; b=JyAdH51y+Bpayx5D3ZoKwfbnm1+qgAkf510AERXaclvnERwzTwbfwS3Sb+WDlRHkn7475b3+kPaA3UWLMDlrMcyFmyZHohXiBsJfbgKBflupIA4DGESs/ahcd+rsWGKs4arDHCRUutEJzvTcsYewpyZiqJsqqzc4EUocRXCAtTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759909507; c=relaxed/simple;
	bh=3w28I4GAvoc2bUNYZ7KQovVLcXabOlHXH0mC4+ytlCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rT4HfOwygug40Z8bzxxUOSS9E6XOxQzDdZgoe9GJaa+Id21QCj02mTAsKGf+xYB/GsPabY/+tictOA4EEquf7oWb0oA8obNeUoD+6ml+BVFD60ODOYD7WdzM83zqDARVkEF3TD4C79WyLlQju4vycT3CTAKgj/Dbzu3TVLp8JaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtn9dCCB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759909502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LP8rwr9dluWtJzK7YAotUA+YpE6/qWoT5JSDJEemzM=;
	b=gtn9dCCBYlgyx2g8DLwqLZXZEdqQjXA6KXr7jSALLwd9Vo0OqjOOlGqrbd85DqLIDiE5oc
	3R29n4x7hjIQk5Ze3bsoh4wHn0h0fuip0qqMcbjKtlvbJfMHtE5sy5yyos6HGXbcVcl9Fq
	QWWCp5xCgmAii9OFna+zPBSk6su3BvU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-kaSWCHaaMsenTpa1UzLwUw-1; Wed, 08 Oct 2025 03:45:00 -0400
X-MC-Unique: kaSWCHaaMsenTpa1UzLwUw-1
X-Mimecast-MFC-AGG-ID: kaSWCHaaMsenTpa1UzLwUw_1759909499
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so5464679f8f.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 00:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759909499; x=1760514299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LP8rwr9dluWtJzK7YAotUA+YpE6/qWoT5JSDJEemzM=;
        b=ax9y3NKdvBLkoEsYMPxgBdVIZKRTSLhFwEFjaQ9KysZXCLrRISrEKftSr051+1h5MU
         zLxkZGf8zEbu5L/DjfsP8feIuZIP/SngWANtIEetRz9Pwg0Frvcep6grbs7px60zryWj
         nk31ln//D04FrTt67BLOOm00goFqdhIaL0Q7cTaBXRAoCWHvDiV3wNIqEQkPwzfTWuUW
         Sez5e7LpF4MC4osZJpYHt6u66E4QW54DWNGqWzy4D1u47SmLsy87iaTgzBRj79egJ0W1
         L3HOTo8spkafaeL3nAeMQOV6yUyZtJ3B8/FqszQQG3Pjoo/iopKj+NzJxk+EVj0La9uQ
         EpAg==
X-Forwarded-Encrypted: i=1; AJvYcCVCzgcGeTb/6rS/OzXoK/gj8pL9fCUBdkfMmqhmn0T7WD5QO0Ggz+/vdULOiGyPu3l+bFsA1EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hxiBj2uDxcRXhy/ApH5UHKmoO+5ABJodCVifP3mSWyDupPHH
	vk17xC1LAWcqLEAYhX1AdpynQe2Mx6uPso8L4oEDY2JLWjLHO6ObLr1g8Iy34z1Z6XmoCsbHbyV
	ewq+ngNh6UoGRFlP4pVM+UdLKpZjOjusUHjFEYRFxUrPYoYk7UGZ7e7x7sA==
X-Gm-Gg: ASbGncuhPA5RzIPUxk/lOzMIWPdLAGHpORu9dL+sP5QIJQ5ga3R3/NhHPcpKxwLNgDt
	A/zLIvTlnetYnVRLn8YCFgn10zqNx9EhvfObgPjTQ2cBgPmS3lPldmQafh3HqyLX9K6RaFFRxAl
	AhcMKeUGjhZTH8safbhG/9pVQ5Vq6MBRv0b1ClDA2EHMxxHaVbq3HzNJwpDLYIxUOF8y6hrPbNB
	bOvLJY3uV2pTwmqZ9SR1HefQjxcLkZD4W15o22OvV4gYLYy3p8/khaswR3s3H6c3fQQbaDvs5k6
	ur9dQsa8zWqYOk55Fl/yOzweiVywPTeYgpyUOqGAjl5rPfsjOsT3uZbCcD6TZj5sD9KWsCxUCeO
	AfiJAI6zfgKrFrIckgQ==
X-Received: by 2002:a05:6000:250a:b0:3ec:db0a:464c with SMTP id ffacd0b85a97d-4266e8d8f47mr1349408f8f.44.1759909499419;
        Wed, 08 Oct 2025 00:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHncWKF5W11brMyBtrO5GXAQCe4dMYH8shl4uOExE85dz2Htlh5ZBcEByvfg3s+0YC29NC+Pw==
X-Received: by 2002:a05:6000:250a:b0:3ec:db0a:464c with SMTP id ffacd0b85a97d-4266e8d8f47mr1349393f8f.44.1759909499034;
        Wed, 08 Oct 2025 00:44:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab909sm28004857f8f.19.2025.10.08.00.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 00:44:58 -0700 (PDT)
Message-ID: <30754f20-b556-4790-b978-f27df5657583@redhat.com>
Date: Wed, 8 Oct 2025 09:44:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 5/5] net: dev_queue_xmit() llist adoption
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251006193103.2684156-1-edumazet@google.com>
 <20251006193103.2684156-6-edumazet@google.com>
 <fcd97ca7-f293-49ce-bf01-3ba0001a7753@redhat.com>
 <CANn89iKW=ZPpYMBBKN_U=-4zCYB4jZD6N4M6_HLcTJVupiVx3A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iKW=ZPpYMBBKN_U=-4zCYB4jZD6N4M6_HLcTJVupiVx3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/8/25 9:32 AM, Eric Dumazet wrote:
> On Tue, Oct 7, 2025 at 11:37 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> Hi,
>>
>> On 10/6/25 9:31 PM, Eric Dumazet wrote:
>>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>>> index 31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0..94966692ccdf51db085c236319705aecba8c30cf 100644
>>> --- a/include/net/sch_generic.h
>>> +++ b/include/net/sch_generic.h
>>> @@ -115,7 +115,9 @@ struct Qdisc {
>>>       struct Qdisc            *next_sched;
>>>       struct sk_buff_head     skb_bad_txq;
>>>
>>> -     spinlock_t              busylock ____cacheline_aligned_in_smp;
>>> +     atomic_long_t           defer_count ____cacheline_aligned_in_smp;
>>> +     struct llist_head       defer_list;
>>> +
>>
>> Dumb question: I guess the above brings back Qdisc to the original size
>> ? (pre patch 4/5?) If so, perhaps is worth mentioning somewhere in the
>> commit message.
> 
> 
> Hmm, I do not think this changes the size.
> The cache line that was starting at busylock had holes.
> You can see that even adding the long and the pointer, we still have room in it.

Ah, nice! I did not take in account the ____cacheline_aligned_in_smp on
a later field (privdata).

Thanks for the clarifying pahole output!

Paolo


