Return-Path: <netdev+bounces-174325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C1A5E4B5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8565A3AB806
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F211DE896;
	Wed, 12 Mar 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eJ7NxHTW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66EF1DE2B5
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808723; cv=none; b=aTb0MVD9VeW3oxMqVrG/liu2o60JkPItoWp39QeqZbULov5s1ir9r+1l/4g/XIWBlKUZW/5tt8bnhMWpk8oCqD9bDbPNj2CDtMnc4uQRcVWdwiiQn6jH0+l5kK/iUZMqg+eWD+R1whvgkQJgXEDnWcgOsqYwbaH+AZoUdT+SaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808723; c=relaxed/simple;
	bh=q6MT6TGT5btkiVqU311iy6+K8XShjWuXOW0PwaHbs7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fC8z8EeMJRnk+9b/9hxzB3IikReGl0qV6E8jvKl1VV6uK54D/YbLEJvGWSLoWPCwv/2hreScFo1uTGTIthbscXJvOkbnysyXokTn9kPZzbUSugvKmmtRX7XGXg/Hv/h0GUMrCFRQgVi5bt0sxMgw7GZmUuJoHrvCqOkCDq193rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eJ7NxHTW; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e52bf5eb0fso19605a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741808719; x=1742413519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8FWTMxoDWECVIzdWJDV9TjUeW5cDC5UtYMLxpO4Tkw=;
        b=eJ7NxHTWBvvUJDKFV23CNSIDn9scTTCHJbzguQSlTpb6MUITcf9AVwuth4CZv8ryl8
         S6xqjAhoc+Dg70dFB2I1Ac2irxivc7YIEQAsPVRI1VBH6ycEoFhOJA/TXvyERm/AUCDz
         6rOkE8Z4rSx/PL1r+MMgkXeHVpiv/LbpYFZzfEPzMHpkgCam90dOdmJKsFgmDed4O5um
         dRvRVj1mvXLn0bjCM8poZnB8KYxFbr9w3mpED1WxDx2o3N7vm/wCnnxZXGloQvSKlKMC
         fU9H3dwikALh7TUfjGRhvRo/fqldg6vRR6JCTqfuw5muuiwpa/QRft4Ic820fTafNH56
         Uqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741808719; x=1742413519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8FWTMxoDWECVIzdWJDV9TjUeW5cDC5UtYMLxpO4Tkw=;
        b=ZZOqpjfF6LSXrpzmZ62qkg/8eC8cFthlBqIwLXJ6Jd8RBnRdq30IIFnw1BFNtY2vYl
         BEy3LtmSOGwRwmq7bu16lNQPjh0K5K9MoPS3jXRN6TIBsb5OLASvli1rlJgwgv2jzifw
         LwcFYYOp2vsu+WMPCUB0TXA/brFnqkTzveDVgVy1p3Z1GND7iYKW/Qa6TPxcsx+Lj04j
         sSw51kwLO3q0wRnqCxdsC0ptRTyz7NWrnRS3q0U/heldcNAy7DIEnGAiR9uqRSOBZ+ej
         gZezYv4/66QwM7yjmm3RLBx4dT3T/WOHsJYKrFa973fTyfmCNXWdEX9hFRHpqJgWDZ4K
         nucg==
X-Forwarded-Encrypted: i=1; AJvYcCWfgEfCc2CsL0oRhpp2LZ0bc25j4F7aAFAthCH23YG1AOQKDLiX6MD569wXcmsVLVPZX66HTVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8fDk/5TN7A4s7NSxFbPY1eBopQ7igNPIp+y3vqn7n8vqekQp
	ZhdAYcvq5PB16B81oKuAjBGH2E8wNFUNz61pvZXjsJZlJPZZMNqcHd0cs3c71hZ1hVTiZ5crG1K
	ULhsy+7Jr7T4=
X-Gm-Gg: ASbGncvIff/xFtBsxMHwWIpNh3gTIfiEDydL1tJUVhm7vBA3h+WeB9+mfg0rrXRlA9v
	iG6pi1g7vsolOrtQGbHN56TeTHwLt8I9DP8GiJoLi3EcH5FektngZczGB9w+23MG/gE3MiXpFto
	/UJ7nrXT9LS6f5vf+C34nIyh4BsBL8FzmJTKTpr7t1lwK9yb2xUePIODLZvBkRrWxE7c7nF4EHd
	J+4QynPLNdkvMz06yyMNuxDAQQYXhQevynEp/oZuRCwuf9qJ/ynTSiI7Xsk5lCyoOPFHY93jHuD
	DkbFeh+/S4v64925Hgdv5oPJs+510FQ5bJrMAASgEUQU7wBJTV+gAT6uWjl0zbFpzHQsSGHxTkK
	PQRnormUhbWpPWUzF6bI=
X-Google-Smtp-Source: AGHT+IHTx4EU6vkIX0vHyGboavg9dHnjr7QAKp4JGwEjxaB70ueR+QBNO1yjFeyZYfs03uegESyNfg==
X-Received: by 2002:a05:6402:270d:b0:5e4:b3da:6838 with SMTP id 4fb4d7f45d1cf-5e75f59ddedmr4813639a12.7.1741808718855;
        Wed, 12 Mar 2025 12:45:18 -0700 (PDT)
Received: from [192.168.0.185] (77-59-158-88.dclient.hispeed.ch. [77.59.158.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733fa47sm10026501a12.6.2025.03.12.12.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 12:45:18 -0700 (PDT)
Message-ID: <4ed5bfc9-dcdb-4f43-8be0-9d7315a88583@suse.com>
Date: Wed, 12 Mar 2025 20:45:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] net: enable SO_REUSEPORT for AF_TIPC sockets
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: edumazet@google.com, netdev@vger.kernel.org
References: <318ad96d-99ba-4c53-a08d-7f257dbc3d6a@suse.com>
 <20250312182048.96800-1-kuniyu@amazon.com>
Content-Language: fr
From: Nicolas Morey <nicolas.morey@suse.com>
In-Reply-To: <20250312182048.96800-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-12 19:20, Kuniyuki Iwashima wrote:
> From: Nicolas Morey <nicolas.morey@suse.com>
> Date: Wed, 12 Mar 2025 18:44:10 +0100
>> On 2025-03-12 17:35, Kuniyuki Iwashima wrote:
>>> From: Nicolas Morey <nicolas.morey@suse.com>
>>> Date: Wed, 12 Mar 2025 14:48:01 +0100
>>>> Commit 5b0af621c3f6 ("net: restrict SO_REUSEPORT to inet sockets") disabled
>>>> SO_REUSEPORT for all non inet sockets, including AF_TIPC sockets which broke
>>>> one of our customer applications.
>>>> Re-enable SO_REUSEPORT for AF_TIPC to restore the original behaviour.
>>>
>>> AFAIU, AF_TIPC does not actually implement SO_REUSEPORT logic, no ?
>>> If so, please tell your customer not to set it on AF_TIPC sockets.
>>>
>>> There were similar reports about AF_VSOCK and AF_UNIX, and we told
>>> that the userspace should not set SO_REUSEPORT for such sockets
>>> that do not support the option.
>>>
>>> https://lore.kernel.org/stable/CAGxU2F57EgVGbPifRuCvrUVjx06mrOXNdLcPdqhV9bdM0VqGvg@mail.gmail.com/
>>> https://github.com/amazonlinux/amazon-linux-2023/issues/901
>>>
>>>
>> Isn't the sk_reuseport inherited/used by the underlying UDP socket ?
> 
> tipc_udp_enable() calls udp_sock_create() and udp_sock_create[46]()
> creates a new UDP socket and bind()s without setting SO_REUSEPORT.

Thanks for the feedback. We'll advise to fix the userland code then.

Nicolas

