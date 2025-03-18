Return-Path: <netdev+bounces-175892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E5CA67E18
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8E93BB2E5
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294C20D4E3;
	Tue, 18 Mar 2025 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfLhz6vh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22BD1DC9B4
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330399; cv=none; b=WVixsR9itHia5CHKtDj9vXXtTVvtr/DZRNDVKfduPOYp7iTormtO1oAuGm1p/aLtPd0y4TNxpqAl0ll6DdI6Q0Bo2FfsOQFxhY/DSaXdMiznkff10768/kRqYNo/qmZD7bMGwT7uKUv9f0jrmlyt3OL7/fkfdTFXMDT4zMW7rS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330399; c=relaxed/simple;
	bh=13lfmfMFp5yiGDJACu56ik+F1xYLiOhKaByL7SF/OQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxkFvHB0lIIWuejDJybF8pIXVGUNpo8ELfHsj7fS0p6kDbJOcKBQIAZwlIKWgT8shjpAFBuFOK5y+AcDvIkM1uSKdhX9S81nGVAONY2UxBd2wdO4sB1wYWKBEFP1AitVjBZqT9wf90ZusJQzSbcoaZP7KLg19CN9DoUQf9PgxOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfLhz6vh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742330396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKZ//bPsindkM5BfO9nnLTaw6lkWlRTOBwgW8pQaUQA=;
	b=bfLhz6vhFr/ps3bx2y/Sn6z9UpWDnnP0N+zyJh6HLfE0GoiVcIGOCG7tAJ3uIwPiacMzO8
	wfTBoLYFWGI+5d6oSOs1JJ1kv2GY9FokfOcMYplDlYgxDP7ea6oFMJ6anTeq7020F2zsSz
	xDkhULu604ySXFdN/YYafIy7wgd/RNU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-fzVdVPdUOxWz4guy1vQduQ-1; Tue, 18 Mar 2025 16:39:55 -0400
X-MC-Unique: fzVdVPdUOxWz4guy1vQduQ-1
X-Mimecast-MFC-AGG-ID: fzVdVPdUOxWz4guy1vQduQ_1742330394
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39135d31ca4so21383f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 13:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742330394; x=1742935194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKZ//bPsindkM5BfO9nnLTaw6lkWlRTOBwgW8pQaUQA=;
        b=kPn+hUonyTPrUGca35gQwIP+rnEbMaUr15TkPM1w91paDIzSR9ft8MtFp7TzXe/pFa
         mVE0qqVmSWfeisbIIA5Pzae+42tsCokiU33BCFVupknx+zwk2eGOe+E1ajLV2FZCBly4
         XucQfs61JWq++LlFsLGUlwFO12OMzoFlLptdK9rmHcYgjCuWSTdE3i9n391GVFEMPjHM
         fSkO2/MqgeIBUQdGAzx1yoWFEW4hbshWVz4L7VSPh2RiPvULLXQinf0G6zpXqsFwvOi4
         ado2ZSgFolBcWlD36SN4dMlx5W3JkJP4z0kdvkVKh/gs38E5piGWea593/4nCZc9ohGs
         f4sA==
X-Gm-Message-State: AOJu0YzTdr5d9tanvupIc+IC4maEOfmRomb9jyoeaMFrTCMPTOvdwDZB
	CqtkWTee5t5YMWf2sf4NMb0c6DXSY8R2wCh+krRuSjDRbx1BbY5AcvWgpwBFqRYXRc+iYlPPEpU
	LiTWy1ViIui3+nFTLqcukOTeUHo4EZanPM329WSZJ91CCjmWdMUWLkA==
X-Gm-Gg: ASbGncuURCoTSUmlMn//GfYi4NDCcfJquZefCLc2GkfWc3l4WtflGDh/wXi9ZIy7OMn
	8pHityzD8/RMAnC/860IuhzFUK/V5po5TFDqRYheFOSEq8ohGWJmr8e1/RasH8keF1N4NDdMyKi
	oD2ASO/rqoIlxm9uEEnZohxFcqSKd4btmS7+StJePZt1/JT+bUtAPcf+yPucZHKxZGr/9mqvl39
	NwwbikYBWP6vIH2mcODUZBJaPY0/M1gtQ2TXMrJeoMJyCEn6hlXrjd3+lDPpwa1cMe2gWsXXQ/m
	1SPUKa/GZeYGfC8c11W1EcyhyZq9uu1neIlKUlfQI4UTZg==
X-Received: by 2002:a05:6000:2ce:b0:391:bc8:564a with SMTP id ffacd0b85a97d-3996bb7747dmr4840828f8f.22.1742330394077;
        Tue, 18 Mar 2025 13:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNwBiPYzXs8wg1huBa5AqI/CqvdSOSsxhcBRuXVWNrU6o62BWKNEQL8+exAvpeA1SVbsCsKA==
X-Received: by 2002:a05:6000:2ce:b0:391:bc8:564a with SMTP id ffacd0b85a97d-3996bb7747dmr4840807f8f.22.1742330393667;
        Tue, 18 Mar 2025 13:39:53 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3cd70c26sm24470555e9.2.2025.03.18.13.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 13:39:53 -0700 (PDT)
Message-ID: <6bf46527-e4d9-41d0-9213-94af1394add9@redhat.com>
Date: Tue, 18 Mar 2025 21:39:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: introduce per netns packet chains
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
References: <2a1893e924bd34f4f5b6124b568d1cdfc15573d5.1742320185.git.pabeni@redhat.com>
 <CANn89iLst-RHUmidAqHxxQAPrH8bJYT+WiFxPU0THJyWWH0ngQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLst-RHUmidAqHxxQAPrH8bJYT+WiFxPU0THJyWWH0ngQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

on 3/18/25 7:55 PM, Eric Dumazet wrote:
> On Tue, Mar 18, 2025 at 7:03 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> @@ -2529,7 +2546,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
>>                 pt_prev = ptype;
>>         }
>>
>> -       if (ptype_list == &net_hotdata.ptype_all) {
>> +       if (ptype_list == &dev_net_rcu(dev)->ptype_all) {
> 
> Using the following should be faster, generated code will be shorter.

Right. I can do that in the next revision.

>> @@ -5830,6 +5848,14 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>>                 deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
>>                                        &ptype_base[ntohs(type) &
>>                                                    PTYPE_HASH_MASK]);
>> +
>> +               /* The only per net ptype user - packet socket - matches
>> +                * the target netns vs dev_net(skb->dev); we need to
>> +                * process only such netns even when orig_dev lays in a
>> +                * different one.
>> +                */
>> +               deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
>> +                                      &dev_net_rcu(skb->dev)->ptype_specific);
> 
> I am banging my head here.  I probably need some sleep :)

Let me rephrase. I think `skb->dev` and `orig_dev` potentially can be
located in different netns; prior to this patch all the netns
ptype_specific ptype for a given type were placed in the same ptype_base
slot, and traversed by the first deliver_ptype_list_skb() call.

Now we don't need to traverse the lists on both netns, as the ptype rcv
function (packet_rcv) will ignore packets with dev_net(skb->dev) !=
ptype->pf_packet_net.

Does the above help?

Thanks,

Paolo


