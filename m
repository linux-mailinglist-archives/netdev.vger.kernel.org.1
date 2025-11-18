Return-Path: <netdev+bounces-239525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D7C693EF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 13:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D58304E86CB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF9B350A1A;
	Tue, 18 Nov 2025 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igs6xJON";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/YRxWQ2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07161314D03
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467354; cv=none; b=BZ7zTOD4j+tC65Pa31hN11ZdbAFMBqms13kiy5RdLDcBhGNiY0uRFIdheSU1CF344IS1Tfg0yrROM5ADrTYU2ro3SGsqZedarkzMQMYejuI3nx+cwPLO+DiBTvO0cKy4eLSCf5ZlBJIwti3T0437vKepnQF2ilM9QhvxsWo4gYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467354; c=relaxed/simple;
	bh=WESiHmXnNlbdDWvUDg2JYyETEusd8ierS+wGRLf1eUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VbhCvqrXK7EVs8ELks96/jNphy9RmRwqv76DrSpqO+Fgw31MKXLC6Qh6d/6EwaVuNux9+P9v/GApRY8i9+dhs+3d/3p080rpGyI2mfVQqiuPcBHXxjYd/0QmULRUJ/hg06NtANXZ6cQEkC5i2kLyW8jwgVn1tPs568r3+ga1H14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igs6xJON; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/YRxWQ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763467352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1i1D0Pw7oFyRhkqVPQdxod01xxz5lck/BaJyW2U7Kc=;
	b=igs6xJONP94vrrzE2eO+iFG4CKZMn9tNnQ5beqNkfwIkAXpc0oo7iN2tYkx5H+XzQuxDBu
	46IGRA7qvFODKd0eP0mHG8Nc1OQ7SmWWcnNhrRhPFjUL7r/In0tTDHPRTabeIQmeU7h0to
	i+365Hz1cgwA7zBTqSxWpublkfkded0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-VJESm1TzPXywGNVVjbCDuw-1; Tue, 18 Nov 2025 07:02:25 -0500
X-MC-Unique: VJESm1TzPXywGNVVjbCDuw-1
X-Mimecast-MFC-AGG-ID: VJESm1TzPXywGNVVjbCDuw_1763467345
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779b432aecso14439415e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763467345; x=1764072145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1i1D0Pw7oFyRhkqVPQdxod01xxz5lck/BaJyW2U7Kc=;
        b=R/YRxWQ2SMSzQUbsQAvTbRaItCqUi2N1q3QQJzyNCF5rUZXGyzVRA6MX/P3lpSxEPt
         tOIX/7Edg6Qdl9f/O6J+QC8ctoU1LhrjCU0nKI8KO4RuQRrrbZhA7GIO2U7uvz8Tetwq
         NhnjZMvAQ/j1ym3qbBfD4BL6hkaXYJ+vBTrzIA3m86DRZII0T++h9zYPrvqg6cjkhp9I
         eYWPKNNJnapFg/Qm6im4fDZxhZK/YvGPNTR++p/oqclvZEhEej+vuWZ5daLJi+eBXUTc
         t5AYwxZKuVQBZNNGPKRPOFOvDB1A6suX9fPHNyhJLrFGbWhzNUtpzFtKTd/w8epbRPAx
         yTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763467345; x=1764072145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1i1D0Pw7oFyRhkqVPQdxod01xxz5lck/BaJyW2U7Kc=;
        b=Co5EbjS1WvYNeiGPkANC6mAQH8AU7+A8NQw1whtLCQ/Fcc+PscqW8oXpNCOVFzgDUh
         u+6YlFniq6MkKn2AKK0zY2ChBo/qHI8umuxZopUzGV9PxjcHlR1anY+O7ZiYUByXQ25E
         sQBjeZ9VqwmLmlMraSPmdXZaNt0sWjIX/KOcLIYbGcwOsL9CXjqwl6jOSl5rCJSp7ECK
         Nd1kLzDnWR+XZavUm6tXHWdxag/pF4xUZiI0GmzVXAAvOKMP+WMQW2W/fHIxdQkB/XPl
         x3QgMJs5FqOwk0m7P+1RN2aUSQHZjf6099sWQkOFv/QBpbE3S082ygeWI33HUHi1aNaR
         gUDg==
X-Forwarded-Encrypted: i=1; AJvYcCW1uNyqAvIJeNHoYEjrEaziBV+xCUKNz87mb6fUYbd2X8bCvl/VCLNA4r812z+MsFu7P/DBos8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8TofkQFN2bDi+ieHScwkRXZtsHfAGkwqexOS6dXXSk9sGMQr
	Qh4sWp43g0VFyyonVbCvOTKxLYqyUD7iPS6XVuqxNVYYmxu+ipRnDyuOUyfxPhgEAe5eUQcT43O
	EZf3bvHicYLeyPa9e0Uw1xf9345XVwWhDgP4LY1CTW8OKxphn/Qu7xBRAKQ==
X-Gm-Gg: ASbGnctgmTXX+JeSj6Hoghyl/GDTlmP8UB71vS/YYG7C98m5p3v1e1ia7q7q+/hqxw0
	bdNki6HgS61du7wppVQQn1DzSp7USXsJKm5Rf1GF51K+V+Ey9P2OdJKPSBFzZ6OjHi6NfVwv8B8
	+aeiGkNFZlAeiBQ7s4lSttAyk4K9fsMFqq/8s1FG6jzpcOwa6rQh2+kX0SryoQF5Vx4jEyjCFic
	n9+P4ltoTuYuI8iGTzwbeOW8ntt9u0Uqtg/3Ya2z8GlbddyP/AH6lPyUglUDojlJOnfUMyC1fT6
	4+fDQAe4cF384hk25z+d9byydz2KaoTCa92Fqdjlf55n67PAVrq1E5t8yyQMGfvq99XcGphwOF8
	miU8RcmMLsJkS
X-Received: by 2002:a05:600c:6289:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-4778fe62100mr150045845e9.9.1763467344568;
        Tue, 18 Nov 2025 04:02:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIbPbD3fHl61Z9bqUbxf1dmLAfvuvlg8WHRxbMNqZy32h7ZBzMmci6k7t6kXMAsw9zXDp8Qw==
X-Received: by 2002:a05:600c:6289:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-4778fe62100mr150045425e9.9.1763467343987;
        Tue, 18 Nov 2025 04:02:23 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779fc42f25sm156990785e9.6.2025.11.18.04.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:02:23 -0800 (PST)
Message-ID: <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
Date: Tue, 18 Nov 2025 13:02:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Note: typo in the subj

On 11/14/25 8:13 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> No functional changes.

Some real commit message is needed.

> 
> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> ---
> v6:
> - Update comments.
> ---
>  include/linux/skbuff.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index ff90281ddf90..e09455cee8e3 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -671,7 +671,13 @@ enum {
>  	/* This indicates the skb is from an untrusted source. */
>  	SKB_GSO_DODGY = 1 << 1,
>  
> -	/* This indicates the tcp segment has CWR set. */
> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
> +	 * subsequent segment in the same skb has CWR cleared. This is not
> +	 * used on Rx except for virtio_net. However, because the connection
> +	 * to which the segment belongs is not tracked to use RFC3168 or
> +	 * Accurate ECN, and using RFC3168 ECN offload may corrupt AccECN
> +	 * signal of AccECN segments. Therefore, this cannot be used on Rx.

Stating both that is used by virtio_net and can not be used in the RX
path is a bit confusing. Random Contributor may be tempted from removing
ECN support from virtio_net

Please state explicitly:
- why it makes sense to use this in virtio_net
- this must not be used in the RX path _outside_ the virtio net driver

something alike:

/* For Tx, this indicates the first TCP segment has CWR set, and any
 * subsequent segment in the same skb has CWR cleared. However, because
 * the connection to which the segment belongs is not tracked to use
 * RFC3168 or Accurate ECN, and using RFC3168 ECN offload may corrupt
 * AccECN signal of AccECN segments. Therefore, this cannot be used on
 * Rx outside the virtio_net driver. Such exception exist due to
 * <reason>
 */

/P


