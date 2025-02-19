Return-Path: <netdev+bounces-167849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6555AA3C90E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF203A8230
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7B21B8E7;
	Wed, 19 Feb 2025 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DPOfOgFF"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC5A214A93
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994530; cv=none; b=Yu3fmYC33RnIjVIb4zRNzimmYXk9qrdYGnM4wnidYFpg7TJdp1qge5gXFztR9E3RsvrxYRzLKtnsohXqCtHMHDBUjo6kdQWyQJeRhqs1AV6iftj4JHIPvNzBBy3i3d9XcgvVvSDjsXceQbDMYG0hb5Y02PUsNa7B+ef0LzWkEsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994530; c=relaxed/simple;
	bh=Lj7KdcPd6bLkS8WEPYoRsz5Dl6D3PELzLOWtb5qgaUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlVu9XWbmHG0rBXi7C7Z8EYnPP0fbo/Y473MlsJwp1nHp07sZLdQSCbWLMzVTWlm6pAmZ0LtTiPtouFG0C6/DTu2/XfVxP5xE7sEFVZj5/VC1qnQEqAjx5S4lDjXQfIr866EPRcn22IOXBg82CE8/S5ffSeJgk4fQxF9vMeJZ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DPOfOgFF; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <24e9b1d8-ed6c-4053-8d27-185bcb840f87@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739994516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+huegDAgeAjnHPYOCmkiySPht+ZQ9CEZsRjXjVE7Nk=;
	b=DPOfOgFFQkoQ3s7jW+M9zBELORr+H3SKNLJr7oiaQEehEQ/vyMeTnnEWn3dD4NggkzFBvC
	Z/mWqql7lpRnwg9WsQ9okM5ijAelO3yUTQ1bqJ4MVvuB/9JpbD+1T5Iqe15gS1KG2dmTyq
	PyWYK1QW4MtHxbHTepRjPEyxp5Zh7FU=
Date: Wed, 19 Feb 2025 11:48:28 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v12 01/12] bpf: add networking timestamping
 support to bpf_get/setsockopt()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-2-kerneljasonxing@gmail.com>
 <CAL+tcoBtd1V-dP_ShDNOVKTyfPvcaLy9ZHz2aEDZr5vOpgwdjA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoBtd1V-dP_ShDNOVKTyfPvcaLy9ZHz2aEDZr5vOpgwdjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/18/25 11:03 PM, Jason Xing wrote:
> On Tue, Feb 18, 2025 at 1:02 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>
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
>>     *    @sk_stamp: time stamp of last packet received
>>     *    @sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
>>     *    @sk_tsflags: SO_TIMESTAMPING flags
>> +  *    @sk_bpf_cb_flags: used in bpf_setsockopt()
>>     *    @sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
>>     *                       Sockets that can be used under memory reclaim should
>>     *                       set this to false.
>> @@ -445,6 +446,8 @@ struct sock {
>>          u32                     sk_reserved_mem;
>>          int                     sk_forward_alloc;
>>          u32                     sk_tsflags;
>> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
>> +       u32                     sk_bpf_cb_flags;
>>          __cacheline_group_end(sock_write_rxtx);
>>
>>          __cacheline_group_begin(sock_write_tx);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index fff6cdb8d11a..fa666d51dffe 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -6916,6 +6916,13 @@ enum {
>>          BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
>>   };
>>
>> +/* Definitions for bpf_sk_cb_flags */
> 
> nit: s/bpf_sk_cb_flags/sk_bpf_cb_flags
> 
> I will correct it.
> 
>> +enum {
>> +       SK_BPF_CB_TX_TIMESTAMPING       = 1<<0,
>> +       SK_BPF_CB_MASK                  = (SK_BPF_CB_TX_TIMESTAMPING - 1) |
>> +                                          SK_BPF_CB_TX_TIMESTAMPING
>> +};
> 
> Martin, I would like to know if it's necessary to update the above new
> enum in tools/include/uapi/linux/bpf.h as well?

Yes, the tools/include/uapi/linux/bpf.h should be updated. If you diff them, two 
of them should be exactly the same. This patch should do the same to keep the 
tools bpf.h up-to-date.

For other headers in tools/include/uapi, I guess it depends. e.g. the tcp.h in 
your another RTO patch, the two tcp.h files are very different already and the 
selftest does not need the new macro either.


