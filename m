Return-Path: <netdev+bounces-186720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71741AA08B4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84EAD7A72A7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD12BE0FF;
	Tue, 29 Apr 2025 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/CJsyhv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D23293B58
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745923004; cv=none; b=lNEhjnmxSQNIVoaQ1RaKI5dWIuvxWezp24J/g94mCIFdHMRthtp/gV3pBJlj9H7BdJYavKE+TD9Un9JbEBHlWdz0Pxmjb7ixnNu6huo0JdUZQLg/Qhp7hks2QALgl/mEEZBc7ime2A25nVzGsKTW8t/DpCh6SZKxEsG01W/M3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745923004; c=relaxed/simple;
	bh=z4O32WXMbZp6KoDD/rLAOJVdIV2a6ApoC4W1W2ysjr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmLXj3CK2ONNAdl6/Pf6CcGl0sLSdYKT23dHIVcumTuUB1GlklQji9hy+m7UCVnIXWZKVeB//LpLiua0jyTdvO23Vr0sUstvUp7Qzx6Q0vXKZpR6ad2Y65yVqd+LxqGcXoDUFlm3JXCDDbYnDz96LBRNY2RNMZPxpcrkICr5XYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/CJsyhv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745923001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnnK4v0ZhrRY7uhbTKq6B6d9n3dw0rEk4NULWBTSKCY=;
	b=T/CJsyhvaVEaDlqiw+TZ+j1CRFfOqOJpRZF5vvX1Emi5qG2wqBLMPezHh+CQETm2yV2PMT
	JYVf40O08YJBL7mhr34WNg5SuMQh+fP4tBJtdYTkZQP9DZn/5Zx78HNL8tTexvTBylcXwd
	vGZHokXADtfNJvsokAQ5MPD9f+rwl5k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-r9YLIPIhMU2psgit3x6WZA-1; Tue, 29 Apr 2025 06:36:39 -0400
X-MC-Unique: r9YLIPIhMU2psgit3x6WZA-1
X-Mimecast-MFC-AGG-ID: r9YLIPIhMU2psgit3x6WZA_1745922999
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acbbb00099eso540541766b.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 03:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745922998; x=1746527798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnnK4v0ZhrRY7uhbTKq6B6d9n3dw0rEk4NULWBTSKCY=;
        b=c6R6GdklZSYAwERRwhid8uiquKFgrxnbVzg77q0sKb/0o0RzlMY3wAFLZUTBBNAaiA
         6A9+wo49d/INRmCOPowLCOMzcIQ8EABqQvwtbOT4yYG+qegdNOqUgzIXj/HtN1lZ2XvW
         dC1jeHzdGD+4QmetqeEx3c4WoHQzDkfT2/+2stGwH1wH47Vbh3n/oqmzCHJMo9V+BI4O
         pxjVPUAA9a2kOssAm7yUZWG4JVqHVx20CAMoJ29cPs0vpt5o4SSNItsyJuCeH5rHlFIM
         PgOrtJGHRek9McY6nqC8SHaCoNRG30c0pjsGAX8zfkN+T1gTp1VkX1OUqx6oPQ/RZ0o5
         jW2A==
X-Forwarded-Encrypted: i=1; AJvYcCUfeUluTBLplTb2p4Ytwiyemukn+prVSZoN81M/tRPuT8ob+GWxELeK+XrlbWcvp8z5kVwiKyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/A6j+1PWRjSrtDVwHWuah0d7a8Izsydkjq/yslsQtOh4OYJr
	rLdFhGkV4wuqtFJ3sxbK72ZVXszfO9UjsnPugXFsxgMl1bCP5lB/KKpFZRB14GGGyqMm/1YsAux
	FbK19VUxJOl74IP66jSAyIHxOybrg6bwxt3ffJ0Se3zBq2C8FqgM3aA==
X-Gm-Gg: ASbGncvbEj5OSwAyGYzxLxJcLzGvQW0NbuOedW49+vNJuruxovlqVsC4gS/4okMhhkx
	GoJvNSAsqfn3zkDu/uy12vF70z0/w48huIX7GnZp3timcLhRtWFpoVa1OFD4lR5Q5MEC10axFsy
	f/rZRgitMkkdZlZXDDaD8OMJcIV8VYCpt/wbsnsicRuC6+r9BT+nuAxtivHZo6AW3/usC1ZPwqR
	UXVZypkKLkmSv9DacLuRB0t6RtrJ1gO3dW2ckq7sxdFMiNIZEG0cYhZsQe7LeY0pxmD4LltuWkv
	QVrUhe4p9lxchZv4Q9g5UqUJLpUAr284pA3/SDg0Uq4jj8XG2pfYiW12uoo=
X-Received: by 2002:a17:906:6a23:b0:ac6:bca0:eb70 with SMTP id a640c23a62f3a-ace84b55d83mr1257181766b.56.1745922998601;
        Tue, 29 Apr 2025 03:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYLnutURY9GSI8aMToCMoJnbXPAocgDQCYLVDcJVZnEaipHJS5GvmH6c6UiyLPyLaX/DhufA==
X-Received: by 2002:a17:906:6a23:b0:ac6:bca0:eb70 with SMTP id a640c23a62f3a-ace84b55d83mr1257178266b.56.1745922998154;
        Tue, 29 Apr 2025 03:36:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed701eesm770725066b.140.2025.04.29.03.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 03:36:37 -0700 (PDT)
Message-ID: <4124e050-5614-424c-969c-9521ff02bee3@redhat.com>
Date: Tue, 29 Apr 2025 12:36:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 04/15] tcp: accecn: AccECN negotiation
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index e36018203bd0..af38fff24aa4 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -156,6 +156,10 @@ struct tcp_request_sock {
>  #if IS_ENABLED(CONFIG_MPTCP)
>  	bool				drop_req;
>  #endif
> +	u8				accecn_ok  : 1,
> +					syn_ect_snt: 2,
> +					syn_ect_rcv: 2;
> +	u8				accecn_fail_mode:4;

AFAICS this will create a 3 bytes hole. That could be bad if it will
also increase the number of cachelines used by struct tcp_request_sock.
Please include the pahole info and struct size in the commit message.

If there is no size problem I guess you are better off using a 'bool'
for 'accecn_ok'

>  	u32				txhash;
>  	u32				rcv_isn;
>  	u32				snt_isn;
> @@ -376,7 +380,10 @@ struct tcp_sock {
>  	u8	compressed_ack;
>  	u8	dup_ack_counter:2,
>  		tlp_retrans:1,	/* TLP is a retransmission */
> -		unused:5;
> +		syn_ect_snt:2,	/* AccECN ECT memory, only */
> +		syn_ect_rcv:2,	/* ... needed durign 3WHS + first seqno */
> +		wait_third_ack:1; /* Wait 3rd ACK in simultaneous open */

A good bunch of conditionals will be added to the fast path checking
this flag. Is simult open really a thing for AccECN? Can we simple
disable AccECN in such scenarios and simplify the code a bit? In my
limited experience only syzkaller reliably use it.

> +	u8	accecn_fail_mode:4;     /* AccECN failure handling */

This is outside the fastpath area, so possibly the struct size increase
is less critical, but AFAICS this will create a 6bits hole (as the next
u8 has only 6bit used). I think it's better to read the 'unused' field
to mark such hole.

>  	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
>  		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
>  		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */

[...]
> +/* See Table 2 of the AccECN draft */
> +static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
> +			       u8 ip_dsfield)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	u8 ace = tcp_accecn_ace(th);
> +
> +	switch (ace) {
> +	case 0x0:
> +	case 0x7:
>  		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
> +		break;
> +	case 0x1:
> +	case 0x5:

Possibly some human readable defines could help instead of magic numbers
here.

[...]
> @@ -6171,16 +6252,27 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>  	 * RFC 5961 4.2 : Send a challenge ack
>  	 */
>  	if (th->syn) {
> +		if (tcp_ecn_mode_accecn(tp))
> +			send_accecn_reflector = true;
>  		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
>  		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
>  		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
> -		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
> +		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt) {
> +			if (!tcp_ecn_disabled(tp)) {
> +				u8 ect = tp->syn_ect_rcv;
> +
> +				tp->wait_third_ack = true;
> +				__tcp_send_ack(sk, tp->rcv_nxt,
> +					       !send_accecn_reflector ? 0 :
> +					       tcp_accecn_reflector_flags(ect));

The same expression is used above possibly you can create a new helper
for this statement.

...

This patch is quite huge. Any hope to break id down to a more palatable
size? i.e. moving the 3rd ack/self connect handling to a separate patch
(if that thing is really needed).

/P


