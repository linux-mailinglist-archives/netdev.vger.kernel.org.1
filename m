Return-Path: <netdev+bounces-225561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E3FB956DE
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4AA7A1237
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75230320A08;
	Tue, 23 Sep 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpumrUwR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D70319601
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623320; cv=none; b=oD3lhVjJRVNvRuOr1Aa9Cfvf2X6dISJcmMpHhYfNmNMKM5AoZkABzfDeip44h5JakAqEy7NGKc/DKrsJUibQ6mpto93fgHaVfnREB4cO6yMlv6UMvqxmKl2VWO2ITD0xn5D0AiLswTXJd7CG8NqrJ4NrjWVQkLk6hftLcAEn4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623320; c=relaxed/simple;
	bh=qNsWtsZJmHIUb0a54dq/Zk97f1zSUhZRzo0hHxDMUiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=exBfnpYDS6LlfGVl1z2nfobupoGv4OlOkbikUyNd3nb3F9GEMkiOlG634iXWYKcDeGixfbvaUEBZq6ybJObqdl5DnKcBb/ny22pxNyrizi6OSX+uvrWnv2c6i27gqth6EnJV9BFAF7ny+Zq+TCBCs47GN2Hp6hk46B+IXXpgobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpumrUwR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758623317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seufh+9IrU9b2MywM8OU6QN1JILtHD4ZNUvycpU3ucM=;
	b=IpumrUwRT9AL6+WHKEhyAu2B7PRWuD6rGcZamC5W0ldj2ipU3hFXKdEsBVYkQf6/tw4Hun
	pD+pt3rOkAVvYHEINHLQAjzkGN6r2O1ycqiUHcHesYAJSshscGwj3iGgIfhWPVDA/1ofXO
	JceGc74qdJSsWzEvzfXbg8hDacAqoco=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-Ar0AaO_7MXC6odI7Elw8BQ-1; Tue, 23 Sep 2025 06:28:36 -0400
X-MC-Unique: Ar0AaO_7MXC6odI7Elw8BQ-1
X-Mimecast-MFC-AGG-ID: Ar0AaO_7MXC6odI7Elw8BQ_1758623315
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso44846715e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 03:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623315; x=1759228115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Seufh+9IrU9b2MywM8OU6QN1JILtHD4ZNUvycpU3ucM=;
        b=iXn+mYpkl5ddguYWJMKO7Nef25bnr7VT+87Hrooxz52ZxLANxZRm1ZaIAqyuiKsAd+
         BMIjbDYkCkCwnp26JXPn82+cU/UYdnnI8pSjQId7CNva+sIBwjIHJVJ+t5Frc9UaHvbO
         GtL3ZAYPE4qAr/leQGoo+NiMolfrxBAyRkqUZh/8xWkMOYCkO5o76hvPSAZi/ZnxTz2O
         Iwd7r9HQYeMVo9DTFE2XCYYplUz3VcsbKHL38OtYDJhfevEYUnbALQiECB4kUQ2alGL9
         zYJQiTrBttTpnXfW3m2cB0201JK7XXrs8Cb5xBiCYWb5UUqcM+Nxyoq97NGkOdcfCKwp
         UcKA==
X-Forwarded-Encrypted: i=1; AJvYcCWPGNltm0x/Il5VjKFxFeqLV+KJscKViqb6ZDgIy+h8nta+f9U5IxLMo75MabtgVPXnjDGLpyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9SJBgHaUYhEaOY3M2FyIRdO865faELV2TS10bZcWd82LvoRkV
	8tP8JTvEf4NVyzp+CYlRhS84o1eE2NBsriCbhpS1spxyKI5zyzWGSgpBezEHMe7jQBnulZym+jd
	rmf7D5Xwlu2P9yj3b+G6wCZuqm++WKky8MFBH6r03a+WBSIDn/N0oGr8+Kg==
X-Gm-Gg: ASbGncvw+8uNMgvzxnxRdhaCorNFhq410Sa4LxPashBRWLnwD54FZK+2L9C0iqPUAT5
	CIAXGmtm8HT2gFxQspVB76dzdtAQ4SBmbNThiDLtMniQGOkvp1tPrmZBtKq83VrrbKe5rrZIjLO
	4IV+5sT2v8+OoSEfhZASXpYmTazeosE05Fh041buTENzQeEIRkLMMo1zd6smiPfm89YqzoVVkla
	ODz9SSlZiKh+5lhSbHzY7RkZToe/YBoBoqOvkPUTc8zyrpG0hIWd6qk4S2gsdySg5TIYu3e4B46
	uDYk3iQPb7nLseKDvjStyWjMSWircmjmtL+/8/x5MRCqc4bRQqilT3GKO9OD10UsIKpy9dtHd/p
	HfIxEDyy7zYbr
X-Received: by 2002:a05:600c:b8d:b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-46e1d97d863mr18327135e9.7.1758623314789;
        Tue, 23 Sep 2025 03:28:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE3y5Q9pntwixp7o35wbEMBOVoDHu4y0TA3ICCB6qjtMzYYpwTI3p/PfMW2g4Dp4vpzjkTQg==
X-Received: by 2002:a05:600c:b8d:b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-46e1d97d863mr18326795e9.7.1758623314348;
        Tue, 23 Sep 2025 03:28:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0d8a2bfsm247445715e9.2.2025.09.23.03.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:28:33 -0700 (PDT)
Message-ID: <be76fdc6-79f3-4cea-bcdd-e88138efcb3e@redhat.com>
Date: Tue, 23 Sep 2025 12:28:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 11/14] tcp: accecn: fallback outgoing half
 link to non-AccECN
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index 2256d2efa5ec..8317c3f279c9 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -169,7 +169,10 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
>  	switch (ace) {
>  	case 0x0:
>  		/* Invalid value */
> -		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
> +		if (!TCP_SKB_CB(skb)->sacked) {
> +			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
> +						     TCP_ACCECN_OPT_FAIL_RECV);
> +		}

Minor nit: brackets are not needed above.

/P


