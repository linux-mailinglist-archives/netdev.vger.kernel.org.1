Return-Path: <netdev+bounces-167536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11719A3AB64
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDC9189224C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E021CEAC3;
	Tue, 18 Feb 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FXrTptG5"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5401C75E2
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915732; cv=none; b=UILVQxBZMNqWAskYf9VGxWcj3zlbzqU3Mg1x0M3QRK/nHu58sHz6ueQdEN/nTy7x3yOT/D+YvZzeCjH8DenHjfUH+fME6VtGZ/dquwziHrjUkd/OVKJ/L8XMWm8ul4Lr9qCDAy5F/J31yFyoAl/yuIuni9wL4rdq6jVTOjydQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915732; c=relaxed/simple;
	bh=gjrdDypVIdA4haXxU16AKYcenMcRuxwQ6R+WNcHp+vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxBCF5527k/TMraqEZvSU7F8sUIdr+VC/0R3sn9hCUqx4a5vaSdakEKKhDyK6mGyDiLB+Zr0HWIrTHBTsMmdRVd+8WRl+audOSeVHCIvR3P9aTWNYL9zhb7vedQsrF/hOeyh3ojgWR9i8cRyQNOZRT36b0PYhuYcWsdYdaynkKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FXrTptG5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03553725-648d-467f-9076-0d5c22b3cfb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739915726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFvzlj17vF3RfnrA5cUt+/Bc+hy+HetI/JCrxlNw5g4=;
	b=FXrTptG5kh+rP6vZRg8gcxEpQwM3F41EFaNtvO/rq7gy2uxn7FSERZCnfzWGVDWcoIZ9e2
	j8EoiTt1EJrzjFGm8klGqnrocYVaRyY+EQZgfL/vlSSSVOj8W8WhELuzyDAqYxfXw4RZK+
	2ikS3h4YY9IFl33sW3sdTWDo+QIvY7w=
Date: Tue, 18 Feb 2025 13:55:19 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v12 01/12] bpf: add networking timestamping
 support to bpf_get/setsockopt()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-2-kerneljasonxing@gmail.com>
 <67b497b974fc3_10d6a32948b@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <67b497b974fc3_10d6a32948b@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/18/25 6:22 AM, Willem de Bruijn wrote:
> Jason Xing wrote:
>> The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are
>> added to bpf_get/setsockopt. The later patches will implement the
>> BPF networking timestamping. The BPF program will use
>> bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPING) to
>> enable the BPF networking timestamping on a socket.
>>
>> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>> ---
>>   include/net/sock.h             |  3 +++
>>   include/uapi/linux/bpf.h       |  8 ++++++++
>>   net/core/filter.c              | 23 +++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |  1 +
>>   4 files changed, 35 insertions(+)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 8036b3b79cd8..7916982343c6 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -303,6 +303,7 @@ struct sk_filter;
>>     *	@sk_stamp: time stamp of last packet received
>>     *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
>>     *	@sk_tsflags: SO_TIMESTAMPING flags
>> +  *	@sk_bpf_cb_flags: used in bpf_setsockopt()
>>     *	@sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
>>     *			   Sockets that can be used under memory reclaim should
>>     *			   set this to false.
>> @@ -445,6 +446,8 @@ struct sock {
>>   	u32			sk_reserved_mem;
>>   	int			sk_forward_alloc;
>>   	u32			sk_tsflags;
>> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
>> +	u32			sk_bpf_cb_flags;
>>   	__cacheline_group_end(sock_write_rxtx);
> 
> So far only one bit is defined. Does this have to be a 32-bit field in
> every socket?

iirc, I think there were multiple callback (cb) flags/bits in the earlier 
revisions, but it had been simplified to one bit in the later revisions.

It's an internal implementation detail. We can reuse some free bits from another 
variable for now. Probably get a bit from sk_tsflags? SOCKCM_FLAG_TS_OPT_ID uses 
BIT(31). Maybe a new SK_TS_FLAG_BPF_TX that uses BIT(30)? I don't have a strong 
preference on the name.

When the BPF program calls bpf_setsockopt(SK_BPF_CB_FLAGS, 
SK_BPF_CB_TX_TIMESTAMPING), the kernel will set/test the BIT(30) of sk_tsflags.

We can wait until there are more socket-level cb flags in the future (e.g., more 
SK_BPF_CB_XXX will be needed) before adding a dedicated int field in the sock.

