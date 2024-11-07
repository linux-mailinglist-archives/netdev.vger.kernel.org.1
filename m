Return-Path: <netdev+bounces-143015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706079C0E5D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A021F234A6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5582178E5;
	Thu,  7 Nov 2024 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fmndRhbs"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781721744B
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006367; cv=none; b=j4p86JysdtltIPdBm6vPY7pkw1onm+N4MBLB5Tu+IuerNKZoMps68TOulJY1MoPiolE42cdaZzzkndLDs5/3Uhcvv8NPkOCZ0wghme8D5vBLABlcTy3ot3Q6nb0SeXAOY8WKICl2N+ogDOch+aey9VoaEUflz+2Xs0K93e3qTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006367; c=relaxed/simple;
	bh=426b7JryXM4stovdUBOyibOVt0RjfEdOJzStcbi1hkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLnNCxoqpWQEspxVSAgXmgQwvkynLS0yu5JJ15p4OH9I/Qt7GBsejjRBffKhFbYgRgdlPdBayB/C+lqxW9HmGVrweWhRI5GytFdgIZClKkDEhpmswlBhRpy8QgaMDC26/4rMPmHYJUwWCPXJrJwT9167S+aSURTvhW8ofCCsomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fmndRhbs; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7934db76-db35-4cc7-a4d4-842f108fd0d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731006362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rgBUS2CZnGMEGdt/TTd02cvYvgz+FrSnullT1PYHuI=;
	b=fmndRhbsUauVlQ5xvj6r8V2Kz0+h3gT/VdxNfXuqxZTBlUKnGopf1m6EaS+VE/cSR/FDa0
	TF8DSDXSlpFd/p7oWugY4GCIPlcgoel7azd/8S/sZ/WpyV0rroCCEKCcLf9roB2BpvcTa9
	l0PeKllJyE/bCp5uVjr4RMfKsXYWO84=
Date: Thu, 7 Nov 2024 11:05:52 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, willemb@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
 <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev>
 <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
 <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev>
 <CAL+tcoBf+kQ3_kc9x62KnHx9O+6c==_DN+6EheL82UKQ3xQN1A@mail.gmail.com>
 <f27ab4ce-02df-464e-90ed-852652fb7e3e@linux.dev>
 <CAL+tcoDEMJGYNw01QnEUZwtG5BMj3AyLwtp1m1_hJfY2bG=-dQ@mail.gmail.com>
 <97d8f9b3-9ae3-4146-a933-70dbe393132e@linux.dev>
 <CAL+tcoBzces5_awOzZsyqpTWjk0moxkjj7kHjCtPcsU3kNJ4tg@mail.gmail.com>
 <49ad2b87-29af-429e-8acb-2bba13e2b2aa@linux.dev>
 <CAL+tcoAmajwBTkfrWez8sEsyHJUga5qbiOdpybjPPe44dyfYxw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoAmajwBTkfrWez8sEsyHJUga5qbiOdpybjPPe44dyfYxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/6/24 7:31 PM, Jason Xing wrote:
>> /* ack: request ACK timestamp (tcp only)
>>    * req_tskey: bpf prog can request to use a particular tskey.
>>    *            req_tskey should always be 0 for tcp.
>>    * return: -ve for error. u32 for the tskey that the bpf prog should use.
>>    *        may be different from the req_tskey (e.g. the user space has
>>    *         already set one).
>>    */
>> __bpf_kfunc s64 bpf_skops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
>>                                             bool ack, u32 req_tskey);
>>

>>
>> For udp, I don't know whether it will be easier to set the tskey in the 'cork'
>> or 'sockcm_cookie' or 'skb'. I guess it depends where the bpf prog is called. If
>> skb, it seems the bpf prog may be called repetitively for doing the same thing
>> in the while loop in __ip[6]_append_data. If it is better to set the 'cork' or
>> 'sockcm_cookie', the cork/sockcm_cookie pointer can be added to 'struct
>> bpf_sock_ops_kern'. The sizeof(struct bpf_sock_ops_kern) is at 64bytes. Adding
>> one pointer is not ideal.... probably it can be union with syn_skb but will need
>> some code audit (so please check).

>>
>>
>>> 3) extend SCM_TS_OPT_ID for the udp/bpf case.
>>
>> I don't understand. What does it mean to extend SCM_TS_OPT_ID?
> 
> Oh, I thought you expect to pass the key from the bpf program through
> using the interface of SCM_TS_OPT_ID feature which isn't supported by
> bpf. Let me think more about it first.

I still don't understand the SCM_TS_OPT_ID part but no I don't mean that.

The bpf prog uses the kfunc to directly set the tskey (and tx_flags) in 
skb/cork/sockcm_cookie. The name here for the tskey and tx_flags may be 
different based on if it is skb/cork/sockcm_cookie..

