Return-Path: <netdev+bounces-190172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93EAB568D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E7A4A2003
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED67E2BCF6D;
	Tue, 13 May 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J27i8swJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199772BCF5A
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144524; cv=none; b=Xg11ma9xuW+8ge/tDT8rMdLBopIwKnA8Jdh3qdQBfW4Ae9w3csMQ0PfAtJsvEb7zOIlxLywSNzV2Ow9MOne6bqrs621cM+05eG6fZoMkshRtOsLSMovcF0wzFn3+4PNRocdIXzT2/YzPwb/USeWf8yW/M7qs9buqWs9VrNuVEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144524; c=relaxed/simple;
	bh=k8MO0qQYf2yjnXq8zGlgq6trmVTpsGIo34uVN9tvwMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZ9vc8FtVsU/+Q0XGQrHKl49+vsMOgcA6cdOYjDlzrUiqxIDwBtGTLQVP1HNpisWpjySc3pWT/m3EbtYHf5Xds1gC6VCN9diuL3ZGwdmOCW3vHUHt+Inwa8dxRwNXRv4DUt8OJnjkty080njP6wCu4lIVi6vu2Xxy/ZpwXYXbOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J27i8swJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747144522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mDXk/1z60Kt8lR+wZMc16OkBv5Hh1LoZwzwZnjv5+0=;
	b=J27i8swJ8QBbww//idTa1K/UB7SCT3GuYWXw1c4opSVvCUZwpsuZYdHCy7wmGC2budh0Cd
	QZ8D94ShcHORgi73xHroujS7mMLr9hNDvkPs8FvIYPnVA+26VtTVyWYkzJoqKbyuumF8Gh
	gLlByZF02YqG+ZHAbt3//wmA7R9+WoQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-lYI1RALPMo-qZ8k_Jgb3yA-1; Tue, 13 May 2025 09:55:19 -0400
X-MC-Unique: lYI1RALPMo-qZ8k_Jgb3yA-1
X-Mimecast-MFC-AGG-ID: lYI1RALPMo-qZ8k_Jgb3yA_1747144517
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a1f9ddf04bso2427579f8f.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 06:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144517; x=1747749317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mDXk/1z60Kt8lR+wZMc16OkBv5Hh1LoZwzwZnjv5+0=;
        b=wJjGR9fqxnmbnMxceha/eGAZD9L4jfwNSf7KDIdWpGKQt4rhZEQprqgZAdD601o5eV
         vgFaMJ9P8qQhWHAXASGT+9+k1tkF+I231PkNTk1in+0ENQJN8Z7T33AowPVbq9AsBL34
         bwOa0i44qkAEB3xKfGgDMrsAnunSTisshyhefW4XNpcoNdzLnMwqpQOVVPam0Q7H1wXW
         Z3HWzsIR1yRIorfc3dIjniGwd3tluYnQlIlF8qxAZuXDHa7bwR284gurntzPacCg84Fa
         w1PrPsenrB9RkT4avMGBnHq69krkYF1VTtx6NyxcAvGUAZMX3PKkA6jI3HZ2z5hWiSyS
         XjQA==
X-Forwarded-Encrypted: i=1; AJvYcCXTj1/uitN5gBCSSH7y72pvMsqSTSBV74xzOmd4Ybu1ireHiZ29J0qwHqgaon3WOnjJm+7yr8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrA145ofOtug9FADuGL0qC3nx410eVItcN/HLw6Es6FSsa323r
	dNHriqyzZvfErrvcwZKHH2Bh915Ozk29JxJMLFdxNWq0vT7T4DiT5Aq8/Apj3bHlbFi42d+zQSU
	vhfk/0Jjkx7IgQ7To13Z/onXSqOO7S+pm/kLmNdoIq3lj/n8tcik4EQ==
X-Gm-Gg: ASbGnct4s1yu1G11vaoXQwyDFpsnAFro+sU8CHFj1+5RPXN9GLAYw8A9y6dyDJsWzIc
	vKDrjD3BgbD3Db3ZmJmP2+JEPm+TUepb6U+NoR6W8Dviwh1Qp+A0mHFCHeRub8aJ7SV2+t1wO+I
	7Uziyhm3zR6/hv36WmbQIyVkmyYFxCj2oV7Zs0HMPoIildldZBuHsiBCftjJ9kIj2vmg1n05Tlb
	k72jF5JeI9Y1UL0ZiAflwPNY6u7cYITMXpQZjBv71K0GlzZXmSkH6aROw0HrLWLIhubtZ2lJ3gt
	7i7zbgIPLOdvysvY3VM=
X-Received: by 2002:a5d:598e:0:b0:39c:2688:612b with SMTP id ffacd0b85a97d-3a1f64277femr15324303f8f.7.1747144517287;
        Tue, 13 May 2025 06:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/3P787hez5DUCbzjfJPJODBbn5DQDvgAda7uo/wL13u5mlBuNcHOROPQYLGn7Nvk65To4cg==
X-Received: by 2002:a5d:598e:0:b0:39c:2688:612b with SMTP id ffacd0b85a97d-3a1f64277femr15324275f8f.7.1747144516860;
        Tue, 13 May 2025 06:55:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde0esm16586527f8f.18.2025.05.13.06.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 06:55:16 -0700 (PDT)
Message-ID: <39e06f51-621a-4d17-a4dd-17287e260e18@redhat.com>
Date: Tue, 13 May 2025 15:55:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 04/15] tcp: AccECN core
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
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
 <20250509211820.36880-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509211820.36880-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 11:18 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -5098,7 +5100,8 @@ static void __init tcp_struct_check(void)
>  	/* 32bit arches with 8byte alignment on u64 fields might need padding
>  	 * before tcp_clock_cache.
>  	 */
> -	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 96 + 4);

This looks inconsistent with the pahole output in the commit message
(the groups looks 95 bytes wide, comprising the holes)

[...]
> @@ -382,11 +393,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
>  {
>  	struct tcp_sock *tp = tcp_sk(sk);
>  
> -	if (tcp_ecn_mode_rfc3168(tp)) {
> +	if (!tcp_ecn_mode_any(tp))
> +		return;
> +
> +	INET_ECN_xmit(sk);
> +	if (tcp_ecn_mode_accecn(tp)) {
> +		tcp_accecn_set_ace(th, tp);
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
> +	} else {
>  		/* Not-retransmitted data segment: set ECT and inject CWR. */
>  		if (skb->len != tcp_header_len &&
>  		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
> -			INET_ECN_xmit(sk);

The above chunk apparently changes the current behaviour for
!tcp_ecn_mode_accecn(), unconditionally setting ECN, while before ECN
was set only for non retrans segments.

/P


