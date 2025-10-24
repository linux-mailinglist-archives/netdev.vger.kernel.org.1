Return-Path: <netdev+bounces-232408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF4C0580E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FA78346D5A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA3305076;
	Fri, 24 Oct 2025 10:08:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-07.21cn.com [182.42.151.156])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCFA1624C5
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.151.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300488; cv=none; b=ciTeCSiJjEufVDPKFqiRx3w3Nm7FmtroGQYH4lGbzXFiIgZvbaQayRrFmzpo6ORaR5pLSWnQYtUXy8osm2OJftj1yAVBFeRVEPuqmvOpBp0hC6v3xKJNRlBt5k/IGh8LTDJbxbhSfvVEQzCvWU4nrbj9xbXbS+FNz5vqZXrCMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300488; c=relaxed/simple;
	bh=4u2lyIhLe1fFd5+mtmWik5edtnvV7ERltByjZpiMpAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liKH4/c+H0KaaSrbwY0lgKGDF2w3Too8BoMF4eZUvIJiDWzom2XqrJ/JJzb3xBef0SUqCHY7J7zwtkAk6oL0jBfNxY3po8HxwcL/7qkjYI8fAMuagC7hpdFpWivfzc/PKIlv8GZb6CgsSUI7AGL7w90V3zM9pHtMivmnZDpRK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.151.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.138.117:0.49956858
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.68 (unknown [192.168.138.117])
	by chinatelecom.cn (HERMES) with SMTP id 42F079B262;
	Fri, 24 Oct 2025 17:56:06 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([27.148.194.68])
	by gateway-ssl-dep-79cdd9d55b-s7clz with ESMTP id 88b43cef9ec94d2ebf469e6a4f4760f5 for edumazet@google.com;
	Fri, 24 Oct 2025 17:56:08 CST
X-Transaction-ID: 88b43cef9ec94d2ebf469e6a4f4760f5
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 27.148.194.68
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Message-ID: <9cdfcd5a-3100-4ada-844c-beec0ac77de2@chinatelecom.cn>
Date: Fri, 24 Oct 2025 17:56:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATH net 1/2] net: ip: add drop reasons when handling ip
 fragments
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
References: <1761286996-39440-1-git-send-email-liyonglong@chinatelecom.cn>
 <1761286996-39440-2-git-send-email-liyonglong@chinatelecom.cn>
 <CANn89i+TsY67y-pCkOkJHsh11Leg77Ek7n2-j6X6ed-U20eR=g@mail.gmail.com>
Content-Language: en-US
From: YonglongLi <liyonglong@chinatelecom.cn>
In-Reply-To: <CANn89i+TsY67y-pCkOkJHsh11Leg77Ek7n2-j6X6ed-U20eR=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/24/2025 14:43,  Eric Dumazet wrote:
> On Thu, Oct 23, 2025 at 11:23 PM Yonglong Li <liyonglong@chinatelecom.cn> wrote:
> 
>>                 return -EMSGSIZE;
>>         }
>>
>> @@ -871,7 +871,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>>                         return 0;
>>                 }
>>
>> -               kfree_skb_list(iter.frag);
>> +               kfree_skb_list_reason(iter.frag, SKB_DROP_REASON_FRAG_FAILED);
>>
>>                 IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
>>                 return err;
>> @@ -923,7 +923,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>>         return err;
>>
>>  fail:
>> -       kfree_skb(skb);
>> +       kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_FAILED);
> 
> There are many different reasons for the possible failures ?
> skb_checksum_help() error,
> ip_frag_next() error
> output() error.
> 
> I think that having the distinction could really help, especially the
> output() one..

Hi Eric,

Thank you for for the suggestion. I will send a v2 with these case.

-- 
Li YongLong


