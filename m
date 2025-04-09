Return-Path: <netdev+bounces-180693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C7CA82235
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EE21880759
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8A225C6F1;
	Wed,  9 Apr 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="SO0oIJ9O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD52550BC
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194822; cv=none; b=CWFqMFyumhIgMjZMOga3SCrJMfSRqf7V3HHEa6cYOWGk9POwKLC0zvLCJUlxJR/QtZGNyGUm3fa/MbghSxvCcpk6iCvr+EcWxV22CSX4uO200tFP1Mk4w8jGdybwnqMy1XHdOVTo8s4pav5F75oPKQCwOY/dQ2kxCrLDoCV447g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194822; c=relaxed/simple;
	bh=eJiiSL2hEBM31QpdZjTGxkNCHrjWvXRhsnysYFnGW1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNYMO9jK/kBONvpHZw2gIwG7lG1TSnsmR2H1BIHmISW0MsTjdEsoOC9wE3zsb1Yd3b3ACNqAtxo+QGujHT2CMarCsT39OQBZQQOnY36ymw2qkc+ArahstBXaftG/1SbKm+w7lQL6fFu/EM+HBaOWN8A7BRFrXHgr7eLb9aS8dgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=SO0oIJ9O; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so69485305e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744194819; x=1744799619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNYfYAHMIpD9FdvT1GsMuzUjrwnA51rOxuoeTYQFk9o=;
        b=SO0oIJ9OuALE/dMT1Sd2HdGV4lAtohQB4OXAWLT2WS5tRJFdinqkBkw+8ihbV/ZINr
         RtKW7IcYFRFP0rToDQhq+Jc8EQSnd2cAK4uUOF5618cuMg4RcYTEcuL1WPbijMpy3Kvc
         60dcwW2hK8NMCgLYXxvzcT2KpEV4960QaUWvNXzbRgRb6kJLcpO59JD5ccUrzqsGq42n
         aEzfMKVQ6s4rDfvhMSUMXlnopKgxX0gn06S27oV74lZevMJ+wCPOLN1mP45DYoK12osW
         Ini7/r5v4SuKDDMtAAvppmSiNshV4mDnuIPPE562FCJoq8TQ5dRjY7bFhAx2XKJkQdfp
         WhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194819; x=1744799619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNYfYAHMIpD9FdvT1GsMuzUjrwnA51rOxuoeTYQFk9o=;
        b=CZljZeV563Q/rRa1zQoIEgvWW6exvH/9cyoFRByVZA6SyrCp7YBnDiTRgWTzmGXUc0
         yYnWXJ8ACiddP+XbpjHbulsClGXg4QWVvrh/RKdPEw+KT1QuVoNlXWVbmAZjDjjWCKRO
         sDh0k0fCk+1NefZ9Uxg5bUrVl4c3KiiJIUkSWOShp2TiLrolQvbdeZjcPVosFDWavzj2
         o5oxn065JEsgvws6ioTkiNQieQp2gLggYcHq8F5T4zI6kdO/4zLMOa7IKmsPbR12jdCD
         6UavnRYKQNIi8t63akJb0CmdysTVHUdbCbx/yyYqBWUudMD//De9/rR9gbxY9wPcssZ/
         C7SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT/c9c1idVFVwY9nBlwgOEcpXRp2yhpD3P9tyM8PKvkGLVvKAZqiC0/gMirKtQ5BA9ybzDxGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1FaU8jhpydElyHVaulA9XZ8YSI3wokWf6fWdLzhHG+6MY/ela
	tM17nfN3bSjUEnzkTMCfysLHyNqFUc6nq6fJMfDGXWNc6APIJ9eQYsQ3w7txKqc=
X-Gm-Gg: ASbGncsnhi2NstUNf0ijEOZn/J4eHsCptWcOaF0h3armhfagI1UBYv8D8duFSd8Gl5I
	AzB71+NzgDDf34ddnwNQemPxXzMkqXVBywCVomRkgRRa7OOUZqc5LLRlvcLwgwBiSyb9MCbfWWZ
	xKJquv869feOxC2d/x788VLNUHs1C+j9+SX2acvZf6uSCmSpfjnqv+ww27T87oXUfQPkoQERh/j
	8FBPbpkvv/a+i7Sfhr3t37XSR6cqB3DzbbNEY+iVDIQMvZZWWOYkbvck+fy0bd1t6xVxFBWwc2j
	KGEl81ohHCN1fEpdbXDICFLBIZXFAzZFM9TF8t9YTKCM0v0bNwVaTCTnD+pipb78uYVo4JCY
X-Google-Smtp-Source: AGHT+IGOViq/FFxXMmab/4pISxbhFgAUX7J2o72U3BiWbwrZb7f0t75b8fXgPQvEBnKDhmE/5Yxtmg==
X-Received: by 2002:a05:6000:2508:b0:39c:223f:2770 with SMTP id ffacd0b85a97d-39d87aa7b97mr2230265f8f.15.1744194818617;
        Wed, 09 Apr 2025 03:33:38 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893773absm1263777f8f.31.2025.04.09.03.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 03:33:38 -0700 (PDT)
Message-ID: <4ee836f0-9d28-4e40-bcca-1b4eadd040f3@blackwall.org>
Date: Wed, 9 Apr 2025 13:33:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: test_bridge_neigh_suppress: Test
 unicast ARP/NS with suppression
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 mlxsw@nvidia.com, Amit Cohen <amcohen@nvidia.com>
References: <cover.1744123493.git.petrm@nvidia.com>
 <dc240b9649b31278295189f412223f320432c5f2.1744123493.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <dc240b9649b31278295189f412223f320432c5f2.1744123493.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 18:40, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Add test cases to check that unicast ARP/NS packets are replied once, even
> if ARP/ND suppression is enabled.
> 
> Without the previous patch:
> $ ./test_bridge_neigh_suppress.sh
> ...
> Unicast ARP, per-port ARP suppression - VLAN 10
> -----------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast ARP, suppression on, h1 filter                        [FAIL]
> TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]
> 
> Unicast ARP, per-port ARP suppression - VLAN 20
> -----------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast ARP, suppression on, h1 filter                        [FAIL]
> TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]
> ...
> Unicast NS, per-port NS suppression - VLAN 10
> ---------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast NS, suppression on, h1 filter                         [FAIL]
> TEST: Unicast NS, suppression on, h2 filter                         [ OK ]
> 
> Unicast NS, per-port NS suppression - VLAN 20
> ---------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast NS, suppression on, h1 filter                         [FAIL]
> TEST: Unicast NS, suppression on, h2 filter                         [ OK ]
> ...
> Tests passed: 156
> Tests failed:   4
> 
> With the previous patch:
> $ ./test_bridge_neigh_suppress.sh
> ...
> Unicast ARP, per-port ARP suppression - VLAN 10
> -----------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast ARP, suppression on, h1 filter                        [ OK ]
> TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]
> 
> Unicast ARP, per-port ARP suppression - VLAN 20
> -----------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast ARP, suppression on, h1 filter                        [ OK ]
> TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]
> ...
> Unicast NS, per-port NS suppression - VLAN 10
> ---------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast NS, suppression on, h1 filter                         [ OK ]
> TEST: Unicast NS, suppression on, h2 filter                         [ OK ]
> 
> Unicast NS, per-port NS suppression - VLAN 20
> ---------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast NS, suppression on, h1 filter                         [ OK ]
> TEST: Unicast NS, suppression on, h2 filter                         [ OK ]
> ...
> Tests passed: 160
> Tests failed:   0
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../net/test_bridge_neigh_suppress.sh         | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


