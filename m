Return-Path: <netdev+bounces-206713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E4B04272
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2F1188B088
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483FB25B695;
	Mon, 14 Jul 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHlm/59X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8025A2B2
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505237; cv=none; b=iZwixSGmJyYouoBvIgA+krMa3jGo9xZlOsqZswVasa4g0oNQyNP8jA5p59cq6DcPdXzrKtIITl8DIEUhU4F0vw/aoNpfAfw+H//RzA1rFYgrR0OIz9JIaIuwg4BBlCUPs7UjhzTgmJx7/I5iqa+tNT1HkrmBpH2U93f7nnEzeYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505237; c=relaxed/simple;
	bh=IHKSZdBg3WcFhFDOVCLrgHqXdaBXMkfRz+CGmXp1u3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VT9utcRnPWkJVyhdwrBrQEzg5Weu0hgHIquHi/QGiPFs13SmMdVRJ2JN21eIu5/m+tT0y0bNHkTu9wXFSjnwDlerUo5/gv2sYYQx2NZzwtaaH/+Bxi4j+CpjJTvccqWRRof50KzP0Kr6pgPvVeBWfVAUMyIgA1RpQ4yDvMfFG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHlm/59X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFwyX6lIQ0fjoLyREcaVc/pevM031iihhbAQ/uu7vB8=;
	b=cHlm/59XL6xIPLOGB9cvD+Ggupaog3r1L3iWBVLpiLXsOy4fl5VARqwHbd23tUOAs1qJeo
	8CLDht86gwKF/bQDCs8diJbsL9YbqhKVrDkWzKUL/KGxXZUFDh9gdFHiAcbYDdyE1VNPHW
	PvAapgmlfLLsG7uC9b52QioxhKUTyXM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-YVEg5eUuPseeHe2isjPP7Q-1; Mon, 14 Jul 2025 11:00:30 -0400
X-MC-Unique: YVEg5eUuPseeHe2isjPP7Q-1
X-Mimecast-MFC-AGG-ID: YVEg5eUuPseeHe2isjPP7Q_1752505229
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so22082065e9.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 08:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505229; x=1753110029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFwyX6lIQ0fjoLyREcaVc/pevM031iihhbAQ/uu7vB8=;
        b=wDsOcPzpIYccfYvVIKdsemQHIEd6mta3imWwya0c8dz6OQIVNjtaFwct1aXIPkPf60
         ss9Rr0RywGP1uzRTfRZDmLnGM4zGyIZp+waeWeehjiELuk5kL+leMIVQj5TK/BYWUAxm
         /JbiuJXUNcJ7YtjFtF9knRxDpXI/2JsGohZS/Qx/fZ0ssfaK6xzvDTpX+2PQapt91gKy
         vTONk+taIkaRgYsrHjOtqgwVfQSvR/+QdoumWIckNK2mdkeeZq+F8Q2XJsptdCLCeBf4
         oRyMHVt32iQr256TfoMHoLv+aOQJd8L7shuCb2FiDJMyFdAeZH00zNWUz7VdRT0Zl8eX
         vfmg==
X-Forwarded-Encrypted: i=1; AJvYcCXu7Kq7bDIF/BCaZMiXeiJVvqUCZajfYF7wnfYOsM8L4pjARhKnv9cF1aebb+pP4y9m9fzpdJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCgt9mno+cyznVk7+CKLA25kNBMtXclTqTK9DV9vo3IAjcKBC
	NQ6ELF4lpf7s0lKTo7cIyYMxVks7LysfJETHN9EsX39jLxszUCvAo9VTFZ9kcdG16iwEKa8pl2X
	lkggEz4D7+MFNUbgRX+vuxiuGY3V1QNXh9ZpPd0fv7EJfAQikxOi6PksMYg==
X-Gm-Gg: ASbGncudYeGJIxtmGQ4B5VbMH9xlawUec6KJ6btmVdjvMh05Zz6NCiwYDsebbw2FUNq
	JI+dZ1E36R4ZJ8jRDlKV/JdlhLSQMf1qAlBCPs1x7JFmBV9qC3Y9SatxvlWbsd3P93iPoemXfTB
	Pd4j4mNVDqjTYgkCURwAMjNsu2V4izVbKQcyiB9Ig5Ls7dgN1kAcUmH3BcQ0Qkq2f6IGNAkCGUf
	idmKM5DhG9WUbq0v4ewmNKuZWw2AuFAft4knaRnemQrNExGVzeD917kFrzsif6tJ2ct9mzLOBDl
	8UT9dLAkI8dHI5wu61xeK+kcpmcWiEfII7aNm4/loJo=
X-Received: by 2002:a05:600c:37cf:b0:456:fd4:5322 with SMTP id 5b1f17b1804b1-4560fd45573mr66168795e9.11.1752505229187;
        Mon, 14 Jul 2025 08:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/DiiAZoBKMtGEbuxHY6nd18x8tIp6jAQkUUQbuvelaXC253z18SXm8PELPhx5Rs/OhWM7Ng==
X-Received: by 2002:a05:600c:37cf:b0:456:fd4:5322 with SMTP id 5b1f17b1804b1-4560fd45573mr66168005e9.11.1752505228616;
        Mon, 14 Jul 2025 08:00:28 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560ddf5e0esm69819555e9.18.2025.07.14.08.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:00:28 -0700 (PDT)
Message-ID: <0e71834c-881e-4a13-a2c0-3443e2ab7605@redhat.com>
Date: Mon, 14 Jul 2025 17:00:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 13/15] tcp: accecn: AccECN option failure
 handling
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
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-14-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-14-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -443,9 +456,34 @@ static inline void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
>  	}
>  }
>  
> +static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
> +					u8 opt_offset)
> +{
> +	u8 *ptr = skb_transport_header(skb) + opt_offset;
> +	unsigned int optlen = ptr[1] - 2;
> +
> +	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);

You should probably error out from this function when WARN_ON_ONCE() is
true. I've no idea about the possibly meaningful error value to be returned.

/P


