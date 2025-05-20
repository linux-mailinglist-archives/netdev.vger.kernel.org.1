Return-Path: <netdev+bounces-191786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632D2ABD381
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F00B1B6753B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82251269B0B;
	Tue, 20 May 2025 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqBQ3zdi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD0268FDE
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733676; cv=none; b=OJeQ8XaRu8UhU5NMAF8eVcgh4dqbhyHMf8+rmyu+S9i7mkNAwGVWlgmYnRmDHRXuNUDMU8QRTTWRzXLBDSA3khDoLbfDovIspJhthJkRq3Oum+rnpZTmCDC+yKLCPn24n2BcgowTRVm/0jktz/F+YQp3lom+DLMqEqsZZ7lAjY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733676; c=relaxed/simple;
	bh=PCd7B2CKJamE+lIGpi1n0g7Z4216i/A7aPBeHZSzo10=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dMMX/32jvS84RfRkKwY4+6LsmWLy2P/ykZzzVzpwxdeRHtFKGpXJc5oKvXZ60aVOIxn9ht4K6jcl2n7l7V55lFx12sfwxIBJVIWmcwhyyK9Ftzu0dYETRK+Z/mWZa7xyS2xNyBGj+y/YOd64TjOAVeG3FxpHvrVVxKe5I+3m3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqBQ3zdi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747733672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NE/+J7lqNQA/ShV5FIY+NGVs5/A/4r4zhgGDuUCRS4=;
	b=CqBQ3zdiaNNuBS59/THA7LgUSYr7VNe0qPGf5aMPz+Ym+k008NhhIWctWGUwGtm2r7HWRa
	J+86sDW7S6kD+APKUUeWSg6LdKiB+yJKheFrOcHU7hrAo2yJaloChygOEnHbE8Pv/S9y5A
	xj1Ci0tzEavi7Bu7Y00jcOxwtLXc/nc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-vO2Jn9IhOraWqQNjWF2-OA-1; Tue, 20 May 2025 05:34:31 -0400
X-MC-Unique: vO2Jn9IhOraWqQNjWF2-OA-1
X-Mimecast-MFC-AGG-ID: vO2Jn9IhOraWqQNjWF2-OA_1747733670
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a376da334dso878548f8f.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 02:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747733670; x=1748338470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NE/+J7lqNQA/ShV5FIY+NGVs5/A/4r4zhgGDuUCRS4=;
        b=Y9f/UzVZNUdRZxGPI3sKYqIQWFjyOf6PbkU5QzMkFnx7YZIcEDrCkQ9j/KVQDtQa4Z
         6MczSwRa2Kk0WpLOUsLbuOXTtKtC4xj1n9JNiOkdcled6fVdvK9tVZtlmY2EiV4vOoW2
         7zpm9aTlC+qOtVqnGOBdBJTnlkHMN/lgjeEiS6s7eaW6j2Z4xuf19yJWyav9VeThB6Pl
         tCb0QYilod/BxUsNRe7hgNCUeL6GBg4rveL7HePunYJeMlb4f3x1I39fmU+Ht46r5m9V
         rZmF6IHY+JoUBGxCSM7Gvd8t2+CRz8Wj5Q058v/S5KGXSouMUfdRei43wiCP24qtco5a
         i3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX2eK3QHsMMLgRfSckwOI5Rbro918Sq57QU6uOFx030ZMNGQONmwnfJqa5JtwVkIBLp0X8lqNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbkS9z63v6qnalLMe5x2CwQBEFPDSPiWdOWvz37N7ASH9r5fA
	HPMZxcOjnioGBQy+AHfK4Ddj4YW7o585obOUlQxPqlbOBV1lflCiF+io8WT7LZv7+JLpat+PEwV
	FsRT5WozsryHkWxRf5Mp2fJH+5RhU8fiM9/Onip2KrJIJLM/OYfR6lWziyG7+LyWpFPuN
X-Gm-Gg: ASbGncsU4+NjWdSpN3tNuwDjyFzZRx3IrZhQnyBb8ezYBXDqjHEB69HG3ilxULL+uLq
	BHjAi7V2CSQJe7onnPRWHrImvq6H4NJWiKCDd2rVuplMsst5mZ3ZJfrLhhXJbsBCYX1BTLvtGPB
	qNNCTlV7GdVGlGUCgxOCNHlmnQPTZWCRud3++A9rWGBHA94+X4rmv+6gSvCFO1AX9RAvken6zZx
	6FdcIhWc75QBYTiuOtbayLTm0woCQZYaB7Y2AgT7QV7TT39eyGSY5h3l2xo50uPR9GAx70ZCQZL
	nAOE7wOEQVSNLo5DegqWbUnCUYFBIROz9+ykr6Yq4zkvbchM0oaM6bnlQiI=
X-Received: by 2002:a05:6000:1ac8:b0:3a3:6cf3:9d63 with SMTP id ffacd0b85a97d-3a36cf39e6bmr7068869f8f.34.1747733669692;
        Tue, 20 May 2025 02:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuVkjVQJ2eOY0GRr+yrteefyL9sA1r4XDiPPnflkR/rXOi3fp9tCEjol8O9cOiuqNwVG19PQ==
X-Received: by 2002:a05:6000:1ac8:b0:3a3:6cf3:9d63 with SMTP id ffacd0b85a97d-3a36cf39e6bmr7068828f8f.34.1747733669229;
        Tue, 20 May 2025 02:34:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a84csm15787427f8f.31.2025.05.20.02.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:34:28 -0700 (PDT)
Message-ID: <14d6af16-c93d-4b38-b748-76c894c0cdf2@redhat.com>
Date: Tue, 20 May 2025 11:34:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 08/15] tcp: sack option handling improvements
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
 <20250514135642.11203-9-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-9-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> 1) Don't early return when sack doesn't fit. AccECN code will be
>    placed after this fragment so no early returns please.
> 
> 2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
>    tcp_current_mss() does not memset its opts struct to zero.
>    AccECN code checks if SACK option is present and may even
>    alter it to make room for AccECN option when many SACK blocks
>    are present. Thus, num_sack_blocks needs to be always valid.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  net/ipv4/tcp_output.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d0f0fee8335e..d7fef3d2698b 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1092,17 +1092,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
>  	if (unlikely(eff_sacks)) {
>  		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
> -		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
> -					 TCPOLEN_SACK_PERBLOCK))
> -			return size;
> -
> -		opts->num_sack_blocks =
> -			min_t(unsigned int, eff_sacks,
> -			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
> -			      TCPOLEN_SACK_PERBLOCK);
> -
> -		size += TCPOLEN_SACK_BASE_ALIGNED +
> -			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
> +		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
> +					TCPOLEN_SACK_PERBLOCK)) {
> +			opts->num_sack_blocks =
> +				min_t(unsigned int, eff_sacks,
> +				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
> +				      TCPOLEN_SACK_PERBLOCK);
> +
> +			size += TCPOLEN_SACK_BASE_ALIGNED +
> +				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
> +		}
> +	} else {
> +		opts->num_sack_blocks = 0;
>  	}

AFAICS here opts->num_sack_blocks is still uninitialized when:

    eff_acks != 0 &&
    remaining < (TCPOLEN_SACK_BASE_ALIGNED + TCPOLEN_SACK_PERBLOCK)

/P


