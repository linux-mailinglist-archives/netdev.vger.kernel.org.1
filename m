Return-Path: <netdev+bounces-222152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08892B534AE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA1F1B63A5F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0ED32C316;
	Thu, 11 Sep 2025 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZqODPk4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DCF54763
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599137; cv=none; b=hwg+O/RTkwzw3f/aIBOo/BNhKx/gE09ToEPn2Mug2QtV9dLkHJGj9U9NZ3ygxyn/EcQbC1H/1t80MsPdFQs5q+MweRiXPMIRiwU2mPFoA+bWDZCb09o0oziOIrszqWsOtlqrZDPMlB6HpZYcedZfD+fu8MY6P3GREimxOp4GTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599137; c=relaxed/simple;
	bh=K0S4G0CV/3Zh07ck0zBhpnofzZVSaTJuo2XWMWJa99E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnE0gIsCarEMPY8rmEiDBKkcQj+wvUyYTWcOEBEpLZg/jdiZHaWZJvrazEdPPEyLYkpHmduoxNmVmgcIlJXG68XDEuVB+PrTLuyChufhYE/oyC+WDqzE9VnMtnx0a9CnA7BB02woTibel1truyUdWtedgsQ9heaZphD3NuZna/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZqODPk4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZ2Ktj1g56z3qPuAnQex8Pway5k7jRhwyzzpgEl5SPk=;
	b=WZqODPk4QjP6wcNsvme42gi+vYWmxNCjfplXAcSPBMJQQ5QMzy0bm3pVaPccjrZ73Z4TH6
	aCjtPux5KQRjWmO/9E4Ln1CelI7gqECTy6f5lqChzI7XaEywFn5qDxCRTKl8a4GlChDS8h
	4QFsf1CQRlAG82DIDO9VBtoRC/hB0Ls=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-X3TIZNcAMBuveApUVX0TlA-1; Thu, 11 Sep 2025 09:58:54 -0400
X-MC-Unique: X3TIZNcAMBuveApUVX0TlA-1
X-Mimecast-MFC-AGG-ID: X3TIZNcAMBuveApUVX0TlA_1757599133
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e014bf8ebfso610565f8f.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599132; x=1758203932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ2Ktj1g56z3qPuAnQex8Pway5k7jRhwyzzpgEl5SPk=;
        b=mLaOXpj4xox5Hf/GNsqtEgMmMp5Jf7rOq2kMRqeon/Q/p7CQwL489xKbYy8yJnkQEV
         dCN2fHjw4h3bgZdz8oJcjyNKvS4IWT8jqTWoiRp8hSiKFnL7jLOHxxXR7gIFAEzsZiGM
         z1xNfKDOq7KHI0KQwyliLQYoXMRb0V2+TJP0yJhDuQitKmw8SG72fsrih1qg4iUV5wbU
         jb/Sr7jOeuGtNZ62DM5Swd29kw9QdTIX1Jbgk177U9gHIbgelbbdxWi4ua/tRxbwKPZa
         PV3HZLazdvgOGmL6aQ/ueZarJSr8MFmh39HPelkgfi3igoP9RXavJvj+4Qb832fOn7Am
         vZDg==
X-Forwarded-Encrypted: i=1; AJvYcCXTD3sYN+gYLpg94G3z+ZBRTbIfWCzcdcVML43megIK/3GGi1FNJnvx8ge68Os7cnsMwsGvqpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhoXRpOniC1WNEWuPAdbVl3OY9mYUzmnv1b7S1OVubapI7KNN1
	xT6ssOlqSDxJ7iR0kSiUNzofgHgOud25bE0gGRIWxjKPqQ2kmQN/yVCnZ84A9wn+aYZscvZDelU
	nyrsTijtFhqEnCjPn+eWqtx675OW44yANobsDARGt0UXCgaXh39zmJBdBJw==
X-Gm-Gg: ASbGnctZJ5F0AhlbyZAD6gLhxUdLmv2ZWo6W+byxDWNiCKPEAC9MnfYonC4wtVVx3bx
	1gW3R0MKNJf2lc7/w0lZ8DQ/C7s9BhNTeou5iG+dDjZkYbzbnVK4N/KaX4ghvMHAlafeYsZdFyE
	6EyobzdfyvZQpFwToX260mefoBei6tJM/We1Z/ZsrsR9J1S6C+42h6e7iRom39oMN2cReln3Fqm
	uZH3cvAqHkT10MEsYAvIk003PAhVJcy5Mv3fhDEeU32UY6LzgcSCiXg18Kz1ngS6F7ODp9ARk9h
	tIAIs6fxIRbB/xjOurhVlK4xviY+UZRX5t2KB3kGHWU=
X-Received: by 2002:a05:6000:184b:b0:3e0:f4be:8710 with SMTP id ffacd0b85a97d-3e75e0f030amr3142021f8f.6.1757599132646;
        Thu, 11 Sep 2025 06:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV+/Xbxtukxn4RCbjAiMGxZiHPVTXoxtRh3womJ/bjYaTElTT5eWCiKQE1H5OHbFBCpEavKw==
X-Received: by 2002:a05:6000:184b:b0:3e0:f4be:8710 with SMTP id ffacd0b85a97d-3e75e0f030amr3141991f8f.6.1757599132207;
        Thu, 11 Sep 2025 06:58:52 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775842sm2686555f8f.7.2025.09.11.06.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:58:51 -0700 (PDT)
Message-ID: <c0e713e8-0586-4d0c-97f6-0e3284b7b733@redhat.com>
Date: Thu, 11 Sep 2025 15:58:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 17/19] psp: provide decapsulation and receive
 helper for drivers
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250911014735.118695-1-daniel.zahka@gmail.com>
 <20250911014735.118695-18-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250911014735.118695-18-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 3:47 AM, Daniel Zahka wrote:
> From: Raed Salem <raeds@nvidia.com>
> 
> Create psp_dev_rcv(), which drivers can call to psp decapsulate and attach
> a psp_skb_ext to an skb.
> 
> psp_dev_rcv() only supports what the PSP architecture specification
> refers to as "transport mode" packets, where the L3 header is either
> IPv6 or IPv4.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


