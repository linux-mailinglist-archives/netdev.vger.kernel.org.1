Return-Path: <netdev+bounces-203427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE58AF5E53
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10AF445066
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EDE2F3651;
	Wed,  2 Jul 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="YfxY0NsL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E602EAD1A
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473070; cv=none; b=fBYc1epuNc8oXgrHteLdKX0n9AA/NmN5Pvjtwz0oAyxZlRgHi0hZ9P/e2L9DAfsSg4wkHjcnzkefK472IHo0iyzoEVD3UJNU/XPgXbjsYvx4q95nt20Eqgh8+Ep459y85ZkeFaKH0Zn5+uqeRbYfaJk5MxI24A/dMm5FJHe3q8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473070; c=relaxed/simple;
	bh=65WluV3BvvXKhljAjH+/Or49/aYcpF02/db+XF1Iy/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0vzRiqitMdChx6S5HKyF6b6KDJTx6wTopdSr0GdyRZfK2MMdkoq+lRqDi95DeMWXxBd6AhkgGWDydy8LqAdXPoJvJwzjjZ+SIS66NXSnZ3kxjif5r/38DQXfpDLCNUmOPQBPlAny9cqCvfdeqSu6VyN94c65argyFjDUSMuuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=YfxY0NsL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45306976410so2869615e9.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751473067; x=1752077867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+DRtnG3/5fhrw2/e04xUvMWhA80ygiUHCaMrGaRsIHA=;
        b=YfxY0NsLV1mAMRBl/86xKM2VPXaewCQG/0XeJd8Q6XoSxm3wEvSBMcIowynsmPLJur
         pp7gCyASoI8ZpkY01JRdTtBL3QYBYZqgEqMyJ854lpkDeR46kS4skemu2a1/I5l7Vjq3
         65psKvUq0U11YambA0Wk0toSVlaV6xkMC+veYCqlw5X8DDGZa2HQl9Ula8oc9eKfqMHu
         qGL+ogzL7mGTTeTQqJ8AL/Ln5qc2TlfR0YJC/zcQVhiGSe+fwPGQcMi7B1Hk54uKgHqo
         a3A1MDd67X9vY0ALqKLsd63tKPU0CG+a7IqWyNXUGT1wYDYKf+4bFA6y0bPAXHhGZbZh
         dynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751473067; x=1752077867;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DRtnG3/5fhrw2/e04xUvMWhA80ygiUHCaMrGaRsIHA=;
        b=PkDUhSQ1/+WTfcV7xhAQMe2tof0t8eFf1dhZxf/st31kAklQD+EJz2g2WtpnW1DMaQ
         31p+RDCL+bzvW6C8z5ef+ypEEzJ6H0VEIfDQQ52mez/gr0R60NW1hec7jT1YfS8Qllbs
         3bRBZRt6LQ8oWZvYiQTAsbw87qyFQ7lqbKFmGJRdZrdeGi/ZA8lPH25bWXwu4veAvbyD
         8jWgkhAzSYfULTmcLnZqA1cwKeevj0+9zLmaS2C0ClTsozzu7IbsDF+asKnMgeSqIZdg
         RV9ACpAZgf1+fNakAO4mRGtwZEtId0SacTeeOsirjiusHRIUwBR8mjqxtuQd9yVMJSbY
         3rbg==
X-Forwarded-Encrypted: i=1; AJvYcCX9HQhbgqlJzyEoeA0GiDgTXeWW9GReKeF9CpitrI2j5YZOFxmjNctOLHjvedRC2Hb8reCshow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxE0DZnyLxFnkddA99xPP6kIurNiAi2/KLVCaZInu4q0tgdQZ
	UopKASAiN9AOQ5c4ZAAihTfaXQ32Jq85NMTe5XD+CAyaHTM/6U8vfMPXZNmC/UOvb/M=
X-Gm-Gg: ASbGncujfPPSbIMqLG9q7ZuyG5HXfM8M3G6vT7NalGnLmFj+nWRwqlJR7tu5OX7eKOL
	TMZntUZwUwL3xfZKxWcczCjNGGV8u3XNW620V29//pV2Cxf2Uyx6YIamdrsSjy0cX2ZWKMZQi4R
	5PuM9U7nue8EGv+7TiFdoh/YkooirOXd3gEgxnL0Ss+BY+2amvYWWKrHlM4D3ekcKXt/m5LUirf
	TQuCkxYN19fU7irhzhP3rDq21pRECv4g5B+h0itFcpiljerhhZz2J3JvH5ARhgKVzcb9czAwE03
	Hq6SAYIvOfzSs+/Zno9A3MAWYd8+5dh6M9gE4zlNCc0hahmTMAjAHvVVkZiAHf/Xom8WNRUnN2s
	uFxLaaZdquIFAYwZvITD4/PN7rj7WU9a3uOTd0Co=
X-Google-Smtp-Source: AGHT+IGmgT1DZZNaOfq26TUVuwOD6QhF7YzlfyrujVZ7SN1RUi3cre88qvNTmXSTqyDFUkfv1BFcUg==
X-Received: by 2002:a05:600c:4751:b0:453:c08:a1fa with SMTP id 5b1f17b1804b1-454a3674ea1mr14677105e9.0.1751473066499;
        Wed, 02 Jul 2025 09:17:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:5568:c43d:79bc:c2ec? ([2a01:e0a:b41:c160:5568:c43d:79bc:c2ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997e24bsm2310945e9.16.2025.07.02.09.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 09:17:45 -0700 (PDT)
Message-ID: <6a42127f-77bd-4a25-af61-8bb8adb666c1@6wind.com>
Date: Wed, 2 Jul 2025 18:17:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gabriel Goller <g.goller@proxmox.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702074619.139031-1-g.goller@proxmox.com>
 <20250702073458.3294b431@kernel.org>
 <7c47cfb6-c1f1-42a1-8137-37f8f03fa970@6wind.com>
 <20250702091055.3d70a5ee@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250702091055.3d70a5ee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 02/07/2025 à 18:10, Jakub Kicinski a écrit :
> On Wed, 2 Jul 2025 17:14:42 +0200 Nicolas Dichtel wrote:
>>> Should we invert the polarity? It appears that the condition below only
>>> let's this setting _disable_ forwarding. IMO calling it "force" suggests
>>> to the user that it will force it to be enabled.  
>> Not sure to follow you. When force_forwarding is set to 1 the forwarding is
>> always enabled.
>>
>> sysctl | all.forwarding | iface.force_forwarding | packet processing from iface
>>        |      0         |           0            |        no forward
>>        |      0         |           1            |         forward
>>        |      1         |           0            |         forward
>>        |      1         |           1            |         forward
> 
> Ugh, I can't read comparisons to zero.
> Let's switch to more sane logic:
> 
> 	if (idev && !READ_ONCE(idev->cnf.force_forwarding) &&
> 	    !READ_ONCE(net->ipv6.devconf_all->forwarding))
+1

