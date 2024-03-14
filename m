Return-Path: <netdev+bounces-79963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8587C3A6
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 20:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCAB1C20EAF
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1168576026;
	Thu, 14 Mar 2024 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SHTRgcz6"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A127580B
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444133; cv=none; b=PM+Tc7VnBRd6cmZ7+jJAmvDXiGrSweOqWh7RVFm2n3QLStrb7IppMQg9ArKAcMTLIuhLvmmSSS4gCuXQ9li19Nl2bM/73P3JUMR68+aRrpI4MqbBRTYE5BnVZwM/lCkD67bqw94Ty/CjsbXtc5hGuRgKJzPSQRRtZcLeoG9VFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444133; c=relaxed/simple;
	bh=PE2W/o/UvsErg2b4BmQSjXcvDafvNWS0TOx8wjbfou8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTRApGqeL7RDfpJo+J5hegMo/ZEbPa4VVcZgjkOLjKiNp34duDucAZWsCELu4dq2RKso6/CVjaahWnkFcSeCiWjp9BH3ymHL+RMVfD+BQaOPkN/2ZjPqsONwXRyJKZ+GHizdzAT/3kxm2JduJeN600Ew71Ge5+dJFo2HQmLxpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SHTRgcz6; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5692ddb3-9558-4440-a7bf-47fcc47401ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710444129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wk6LUIISIZc8BBteqHZvf6DKngdRbzsCGc5VN6J1OYo=;
	b=SHTRgcz6utQlrtEABb4ur0hnuXJiD/bp6XlDbQ07vYilrLmBuj2/dQ8cpWz4e6Gq6krw+q
	y4YCzuZdmY8K0Qea+0k7ENAjXbeKuILtMhoZzv9alpgfCLMknNC2vuPZh1VgJqHylO0FpG
	QvpGco4nPjJ/VC+MJu8fQehU02yBufg=
Date: Thu, 14 Mar 2024 12:21:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: kernel@quicinc.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
 <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
 <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
 <65f21d65820fc_3d934129463@willemb.c.googlers.com.notmuch>
 <bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev>
 <65f2c81fc7988_3ee61729465@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <65f2c81fc7988_3ee61729465@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/14/24 2:49 AM, Willem de Bruijn wrote:
>> The two bits could potentially only encode the delivery time that is allowed to
>> be forwarded without reset. 0 could mean refering back to sk_clockid and don't
>> forward. The final consumer of the forwarded skb->tstamp is the qdisc which
>> currently only has mono and tai.
> 
> So the followinng meaning of bit pair
> { skb->mono_delivery_time, skb->user_delivery_time } ?
>   
> - { 0, 0 } legacy skb->tstamp: realtime on rx
> - { 1, 0 } skb->tstamp is mono: existing behavior of mono_delivery_time bit
> - { 0, 1 } skb->tstamp is tai: analogous to mono case
> - { 1, 1 } skb->tstamp defined by skb->sk->sk_clockid

I was thinking only forward mono and tai until it is clearer how other clocks 
will be useful for forwarding between e/ingress. By resetting all skb->tstamp 
other than mono and tai, { 0, 0 } at ingress will mean realtime on rx and { 0, 0 
} at egress will mean go look skb->sk->sk_clockid.

I do like your scheme such that it is much clearer what is in skb->tstamp 
without depending on other bits like tc_at_ingress or not.

"{ 0, 1 } skb->tstamp is tai: analogous to mono case" can probably be dropped 
for now until bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_TAI) is needed.
Otherwise, it is mostly a duplicate of "{ 1, 1 } skb->tstamp defined by 
skb->sk->sk_clockid".

The bpf_convert_tstamp_{read,write} and the helper bpf_skb_set_tstamp need to be 
changed to handle the new "user_delivery_time" bit anyway, e.g. 
bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_MONO) needs to clear the 
"user_delivery_time" bit.

I think the "struct inet_frag_queue" also needs a new "user_delivery_time" 
field. "mono_delivery_time" is already in there.

It may as well be cleaner to combine mono_delivery_time and user_delivery_time 
into a 2 bits field like:

struct sk_buff {
	__u8 tstamp_type:2;
};

enum {
	SKB_TSTAMP_TYPE_RX_REAL = 0, /* A RX (receive) time in real */
	SKB_TSTAMP_TYPE_TX_MONO = 1, /* A TX (delivery) time in mono */

	/* A TX (delivery) time and its clock is in skb->sk->sk_clockid.
	 *
	 * BPF_SKB_TSTAMP_DELIVERY_USER should be added
	 * such that reading __sk_buff->tstamp_type will match the
	 * SKB_TSTAMP_TYPE_TX_USER.
	 *
	 * The bpf program can learn the clockid by
	 * reading skb->sk->sk_clockid.
	 *
	 * bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_USER)
	 * should be disallowed for now until the use case
	 * is more clear. Potentially, we could allow it
	 * in the future as long as
	 * the sock_flag(sk, SOCK_TXTIME) is true at that moment.
	 */
	SKB_TSTAMP_TYPE_TX_USER = 2,

	/* UNUSED_FOR_FUTURE = 3, */
};

It will have more code churns in the first patch to rename 
s/mono_delivery_time/tstamp_type/.

wdyt?


