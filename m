Return-Path: <netdev+bounces-160902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8635A1C098
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 04:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0746188CE27
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 03:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A0204698;
	Sat, 25 Jan 2025 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FU8LpUgJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756AD14A62B
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737774779; cv=none; b=m0uxHyW5gvIMS9n+nw4XSLb8KC+YgMnjiNcQqGClix2IOWCA2kn82gTGSx7hyxvO60wUnMxpTZvDm7RRv0CfX05fSEEMgH7ZXo8bmLzurd7HBIVlXhNzEXKCxYVN2bRtU7nLenAf1dN58tX1We//J/e+cLs0H96z98KGl1rkubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737774779; c=relaxed/simple;
	bh=el4vgfpubsQQBBzi2DY5pPuT2LqEnHa2JRSCWp7m1B0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O0gf5UkqMJ/7ffIlg5C7hfJXrO5ky7hFZZ/uacskSohccAW7ceVfjEyvWM+m3PPzslNySV+eCiCDq0gsccneqEGOhb7wVTzM9KkJ3pNO+tL+SbVllO+JuESZ+koKUm3x6w+c9kMkrfbUivYQIgqplCEDDmA8vkAu/ZWAaCW2jQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FU8LpUgJ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d523822-4282-442a-b816-e674ba0814ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737774775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pktsqRhc3T1gmntmdMN3VhPXrceEVPXy5W4EiXeDWsk=;
	b=FU8LpUgJYcXdeKM2ihEYIp/ggYbZRHriz17BSH90o4XcmT8I+Ws9UgqR2XY95KsF/JFSNj
	fCSHlNKAdj1voyR08OB8sWfBk2Lk/djmqmL0eVf+B/b+lcTufgie/ARaeugbbw0ZyNOQFN
	1zU/QURApn31DWynQasFwfpuCshwkBo=
Date: Fri, 24 Jan 2025 19:12:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 04/13] bpf: stop UDP sock accessing TCP
 fields in sock_op BPF CALLs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-5-kerneljasonxing@gmail.com>
 <1c2f4735-bddb-4ce7-bd0a-5dbb31cb0c45@linux.dev>
 <CAL+tcoAXgeSNb3PNdqLxd1amryQ7FNT=8OQampZFL9LzdPmBrA@mail.gmail.com>
 <331cec22-3931-4723-aa5a-03d8a9dc6040@linux.dev>
Content-Language: en-US
In-Reply-To: <331cec22-3931-4723-aa5a-03d8a9dc6040@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/24/25 6:25 PM, Martin KaFai Lau wrote:
>>
>> Sorry, I don't think it can work for all the cases because:
>> 1) please see BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_LEN_CB,
>> if req exists, there is no allow_tcp_access initialization. Then
>> calling some function like bpf_sock_ops_setsockopt will be rejected
>> because allow_tcp_access is zero.
>> 2) tcp_call_bpf() only set allow_tcp_access only when the socket is
>> fullsock. As far as I know, all the callers have the full stock for
>> now, but in the future it might not.
> 
> Note that the existing helper bpf_sock_ops_cb_flags_set and 
> bpf_sock_ops_{set,get}sockopt itself have done the sk_fullsock() test and then 
> return -EINVAL. bpf_sock->sk is fullsock or not does not matter to these helpers.
> 
> You are right on the BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_LEN_CB 
> but the only helper left that testing allow_tcp_access is not enough is 
> bpf_sock_ops_load_hdr_opt(). Potentially, it can test "if (!bpf_sock- 
>  >allow_tcp_access && !bpf_sock->syn_skb) { return -EOPNOTSUPP; }".
> 
> Agree to stay with the current "bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB" 
> as in this patch. It is cleaner.

Also ignore my earlier comment on merging patch 3 and 4. Better keep patch 4 on 
its own since it is not reusing the allow_tcp_access test. Instead, stay with 
the "bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB" test.

