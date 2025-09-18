Return-Path: <netdev+bounces-224436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51820B84C20
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066585454C2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0D306B1B;
	Thu, 18 Sep 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiHyLrul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729F3081CA
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201315; cv=none; b=P02QbUWDRWrktYTSwOYLNZ7Ba7FUF0IZlSKKsZl2/zGG9KD+vZBgh7yue/WGC3oFVHtElr32sWeCd/bKUal62gyVeVToi6PC9QeMYez8L+Z3RGpQX8Q8AIlx63ajXjW3svZMy+/AiOVjEhdHlR2e7Pnvfz7oykJXYT3WLg7bjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201315; c=relaxed/simple;
	bh=hXvBVmZ/fztmwKpBoz+jL6GsfqQgIV7nyZzXIbVT4II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ct/5UpJGSh3a0z93Lhlm+RhKOlz5naFU7784zE2viyiMjy0J88ZXYCHNRp7kZdIab03RsMGUX/6n9LdYQlot2MLsQxE4cMZ70pzqddUJ3E/ng36iLS1r1VDuSLdgVJxodQXumYuv5i/oi1ZFmUYFPjl/eH9YzY9TDwpGNZJ4Hag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiHyLrul; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-795be3a3644so2611696d6.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201313; x=1758806113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXvBVmZ/fztmwKpBoz+jL6GsfqQgIV7nyZzXIbVT4II=;
        b=FiHyLrulTwsxpINVKRZDhj0xz2kPQEnBFwoyHZrWwZc6/K3lYWp9SvxeHsaV2SXGOD
         UTBc0llnzuZSeQZRgMfRoIb0UOEoxgk5nHF1i5a4orK4Koy1uNNkWGyC4iMfm8bluIUD
         0vrY2DxBFgva4ZAfOjn3FLZmC62SrxKasd8UndiaisUKFI2YC5hUwxCoZIpUY81bX3Tt
         bwP0bhdvWTmiFipaTMM2W0K0IH5joDTOgNf4SRGCHDQlcwlupZJtFo5ZKzkCybDTnpqy
         Hbmm0DhzLgWMEz40BkGeFrJUVcFCJJidhn+9sru2dzyKU5sIkhas1C2jyYqkdpDmqW4P
         0QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201313; x=1758806113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXvBVmZ/fztmwKpBoz+jL6GsfqQgIV7nyZzXIbVT4II=;
        b=pCQr8YGZHNUsaaT0ngPBF5AS2v7WJX3Zrv5w7Js9/yojKIhNCdMpaX6B1QzJV/RHSW
         hV5J+yS9DUPtEFcJaRPO5CpcFdJ7er899QzKEYIqjFRxm2BwcWFHce4aCwKscyaJ2S6+
         7kZzaou/B9/6r5OuW1kEaWVC+rvVrR+zow122/+kG7JW0d5WZkd30AUxnEnJWXbjMfAA
         2PNDfLlWvBdCTAhiOlcqkQXmht0vvcEUVYvkcLKTYe81W5PWCOLrKqGyMNbPIkxWLSgn
         n1G2XdOCYbuxjeGGqC/FJtHCIxqu4jhZt/gVnSKq6N/+UkFE+xHo6t1M/Jw4T1S0kxV1
         eUTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMtDpyZEand+Ax9iIXVqhFy0Cs+qAfXTxTHk0v2k4Etil6tubAXp/hSLBWB1Atl5GCr1uggW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzXT8TMOjRrGE0BqS5eUdCfpTPdc8ebhWh1BBQ7EwUIsKZ5TF
	Ua1OyXOxX4BaQmCMKz0si3Ig8EAuqwbCcxhsiAJeBN6rgI+WP3nEquyn
X-Gm-Gg: ASbGnctdFXEJHnBfftwfLhb0TNij4M2ntu4kbu7+PGZ4v0d9320TyDS/NMy9jGlu6lB
	cINreckMv/HZxt2zI4BhiKRJwQUXvtnvfe22RC7JBO0hAcZVlVQHyb3uHVTy9isu9utOX6DzS1V
	hgg8SrFsGNiVb1iKVFgoF1gbVSg8CjRRVh4LMLAG/3ZKF8k4JTguPnbA2QakJTXnQ1n3MYz5GxH
	F2reG4zfLbfEd6BvHzgkIJIH3GTpyor1uBa+JcDWcMDsaTlVNygnoIfRlR1BsaLqioWkOKsyfF5
	EWG/rTa4iX6cQfe13boZqPOscQbxMmCECwekB0BesT6cg4bFqRKstk8A+241nI0P+594ZMgkwrI
	0Y2iAluSltaE1sFAvWzr+D8E8evlEx6H3Hk2hcT722jU/ha1yieyJ19AlT3dtkRKSvGOTVamcnC
	RAYHhdIlsK9LI3MtxhnXnWUg==
X-Google-Smtp-Source: AGHT+IGX36rYkJKu1Y2spSV+ktEvHacdGTQcg4ybzYZzTOY+HTZxRSY8uiO/O6BE8165/9rWDIa6Ug==
X-Received: by 2002:ad4:5c84:0:b0:780:9cd1:df6a with SMTP id 6a1803df08f44-78ecf117222mr61021476d6.51.1758201312335;
        Thu, 18 Sep 2025 06:15:12 -0700 (PDT)
Received: from ?IPV6:2600:4040:93b8:5f00:52dd:c164:4581:b7eb? ([2600:4040:93b8:5f00:52dd:c164:4581:b7eb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793446aed5fsm13021406d6.9.2025.09.18.06.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:15:11 -0700 (PDT)
Message-ID: <0695458c-7bd7-455f-a101-3c0636a4cbf9@gmail.com>
Date: Thu, 18 Sep 2025 09:15:10 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] psp: do not use sk_dst_get() in
 psp_dev_get_for_sock()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>
References: <20250918115238.237475-1-edumazet@google.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20250918115238.237475-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/25 7:52 AM, Eric Dumazet wrote:
> Use __sk_dst_get() and dst_dev_rcu(), because dst->dev could
> be changed under us.
>
> Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
>

Tested-by: Daniel Zahka <daniel.zahka@gmail.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

