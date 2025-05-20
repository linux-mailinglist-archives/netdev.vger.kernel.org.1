Return-Path: <netdev+bounces-191788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F1CABD3E8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE3217CA48
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D867268C62;
	Tue, 20 May 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O81hku0v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879F25FA2E
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734601; cv=none; b=lL6LEk4egH7CgvKU0Zv8PZJCSxrDNO4ezBk8HMUiSt+bxy4sAGW91i/89AWquv4fnUORzHYJob3qrpPa2VrdEMySB0900KwRXTWVwWNLhJYwVZlszUQiIutEYGPAQbk6NnIcB48/Sbp0+ZlJldGlPTo3AF9TEmsAEcxc9JU+p0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734601; c=relaxed/simple;
	bh=zmMeJiDDZWaauBVCwiIbfO5yDwZo3DooABBxbFXHDdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W+9lQKFXKRtFQ1RassYbYArnT/dXtYnvyCt/D4MGJvWkMQ7T5alrTFCvsUr0eAMalnqbN4ESDAWUfzUkuAq1oiRUb96Yjtg0r8a4OpWodYFcn/rvDS6V8/MQZd8/N+gPFLZpn/cQ2pGG673Uhc4jQa5M31UBJNf1JZstMZW6W6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O81hku0v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747734597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKVK+uAlT4VzaC9oAx0YIHTOnxhoJDuCN0nhLSXNB60=;
	b=O81hku0vozDSd0vx5MrGGGu4I9sBNeLDddnul+OCTTTQZemvHGvQI9LD+6XRCBoNz/MjwN
	AUNtL+bUx6DxqKbBmR5kVmYOOWGg4HsKd+S12s091OKOLFYGYVXJO2oyBXp73j+j07SnEt
	RfkHfPQSGcRH3NX9fk9K2+eKz3FUp+c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-KPruGjr9PMyq2aX1ZUg3-Q-1; Tue, 20 May 2025 05:49:56 -0400
X-MC-Unique: KPruGjr9PMyq2aX1ZUg3-Q-1
X-Mimecast-MFC-AGG-ID: KPruGjr9PMyq2aX1ZUg3-Q_1747734595
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a3660a9096so1227164f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 02:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747734595; x=1748339395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKVK+uAlT4VzaC9oAx0YIHTOnxhoJDuCN0nhLSXNB60=;
        b=YXAIef5hcLPvYSbDPv6AKd1c7chSdlygyL1YgGRQKdRiJbAug+XWI/k8/QlB+ooXFV
         2C9Bcm5KPEgyk0cL8M4oGEB2KVMtVCQ1b8kKOcJ6S3KYTNwSuGvnxabr07Sd/rUKydQr
         Q9Cmsiw6E8zd/uTEfxzJn2+PFe1wLbKVC8mF6x6dr+Fk3IFQk2dKb+G2H8D42Axa3RAT
         brFVdhJrLGyXykuBPFf3aMkJc4AW3uZqhDxPm08/lDXu5E/gJp0ZNJC8D4x/bnGs2YtU
         0mwVbkTQo8FXvLrqtWw2/d7dJqhCmPObMFBDRVIhZHL6kU7dgDILDuxNycr7BsV/kjow
         tCLg==
X-Forwarded-Encrypted: i=1; AJvYcCWbwOHo/kgMnsZ3KP2R/1OdgsPXVQSgGyWsrqVyups1u4Me2sVp/wcN3JA8lajhScLarECtsxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymfVFPlfN1AqiCw7woJ9BE7daLg0WVs+SvjxICOgCG9QTL8ZSQ
	+r/nkvakStZh21S4T6Cu17DjkNw05a7R5MNT5y/q1f3lcB8uv0IrcquFhCArSE/UmKsPwDHfXWt
	T5O3SZ/93+gSACO/jVLrDdKNWLMNuPB1XnD6rrCsSEi/28riCB9qS7vxhjQ==
X-Gm-Gg: ASbGncsWDLwCp+je9v5CrW25V9AethNIZQG1qRe7GiKxiUYX2wQtvdNqO3cAsA3Wcse
	/Z2feV4Uvha6nNBzu9PAYIyYnUylDhsXPHgw2IEjDyNQm23A6Ds1YA3uzII5kpWTPFpGCUPGQ36
	ST1BFRtKrsxNq8hH9rnCVFRjF7xy84boThJOLJWd7TJm4Jve/1gOx6sjAgf4OlZsUs1S8IIOSIX
	C2OxgSwOzxfII236X90UoYw/zqzfC0AFoe3W5kz3DzoPnsSkHqiVR6s6eXdvkMsGC6V/YaU/9GC
	08Z7VWu2IOHvdfjvRVS58n6oIZnfp+a45h5ZEIuM2PZEVnVqBlJx8HJ2RJc=
X-Received: by 2002:a5d:6a49:0:b0:3a3:5cca:a56a with SMTP id ffacd0b85a97d-3a35ccaa7ccmr9873007f8f.32.1747734594725;
        Tue, 20 May 2025 02:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERZPLs4JlsuZmumP5YHPtj9qIckLqLuPz2NZ0FOXcdTy6ANbEKQ9dbQymmsaS/IsilI+AwLw==
X-Received: by 2002:a5d:6a49:0:b0:3a3:5cca:a56a with SMTP id ffacd0b85a97d-3a35ccaa7ccmr9872974f8f.32.1747734594291;
        Tue, 20 May 2025 02:49:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88a13sm15601908f8f.74.2025.05.20.02.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:49:53 -0700 (PDT)
Message-ID: <6ce5f200-aacc-4b01-b3b6-b2dbe543248d@redhat.com>
Date: Tue, 20 May 2025 11:49:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 10/15] tcp: accecn: AccECN option send control
To: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-11-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-11-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -6450,8 +6480,12 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>  	 * RFC 5961 4.2 : Send a challenge ack
>  	 */
>  	if (th->syn) {
> -		if (tcp_ecn_mode_accecn(tp))
> +		if (tcp_ecn_mode_accecn(tp)) {
> +			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
> +
>  			accecn_reflector = true;
> +			tp->accecn_opt_demand = opt_demand;

There is similar code to update accecn_opt_demand above, possibly worth
an helper.

> @@ -1237,12 +1253,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	}
>  
>  	if (tcp_ecn_mode_accecn(tp) &&
> -	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
> +	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
> +	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
> +	     tp->accecn_opt_demand ||
> +	     tcp_accecn_option_beacon_check(sk))) {
>  		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
>  		int remaining = MAX_TCP_OPTION_SPACE - size;
>  
>  		opts->ecn_bytes = tp->received_ecn_bytes;
> -		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
> +		size += tcp_options_fit_accecn(opts,
> +					       tp->accecn_minlen,
>  					       remaining,
>  					       saving);

Please avoid unneeded white-space only changes.

/P



