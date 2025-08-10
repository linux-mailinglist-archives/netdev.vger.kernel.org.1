Return-Path: <netdev+bounces-212381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604BB1FBF1
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 21:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BBD1898946
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E31F4C8C;
	Sun, 10 Aug 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POrsAlTK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3952629D;
	Sun, 10 Aug 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754854704; cv=none; b=k2us5FAUFYBX3FqP18vEh076eDjI1RSg32OqVrvMu3hXNoS2O5qkQF65NnczrUnf5Pg3Gx3pjmzc02Ew3cQIj9MhRyEmFlB9BaYE8SE7Kayaj30A8fQ2OrQdUmcEWigFSU2+9I3ZRZ2pe5JUsFPpM31XfV3cLXH5rxIAj9JHJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754854704; c=relaxed/simple;
	bh=MNNIpZoV5jnuXripp31kwcrQ5tsECyRkMwSoShoSfi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2IsbdGNnW7nJBKWxmMt4SzY+xhh5PKnlsStSpE9eUD81lXfLeVg3Q3p65ERfMC2/yU8s++8Zadb8uTRPis+fzmNzpxlhGMbokOR6RoL15NRlNTnvaTypO5MhAVu1qfbMPoAozbXouR5hxGUGqPcarfPck1ybjcMoZ0S3zqKArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POrsAlTK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so1780723f8f.2;
        Sun, 10 Aug 2025 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754854701; x=1755459501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aczauj7vwM4V3ZaEGB71qJbFIAHWwCrwYPqryAam7OA=;
        b=POrsAlTKjtNbZjKp5iiFbnvtpvD/sYD06e7XaqL+hAgvcsNCCwX2XSqkfe3GwEhEtE
         YBvVem21ch0x90ulpsoCSdld7TwNbx5Uquk6AiPQmbx/6JX7K2shngHmDEQCnHpLE8uN
         /F8SpoKorPOcN9PHCxjf4w7kXDcsRSJOuvEhiqOS9T25emfXQrI0bT7Tt6Ms1fX02Guk
         dQ2C69p+EY08ock92MfS14Dr2Ig29+UovHN2jORDECMaWoZGeKB8H1S/Fu1G4aOTT0u4
         j5kdsven57xKxrZAesCgsUpTaJYxD45HLf1NTlTMxqJE78HAPIWrsLUiKOzwkNqbu9Eo
         41eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754854701; x=1755459501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aczauj7vwM4V3ZaEGB71qJbFIAHWwCrwYPqryAam7OA=;
        b=G2hFjDYHzLCALhovxQiy/L6zxcV2QAJE3HbqcAis08cb7b+NHlRpAGE/BX5pORtEER
         OHqyGzpWhoJDKQdEddz7/KoQN4L/Fsl50TP+NmsmO2uTRIEMtPFKZnN6CyNJRMA1JH/J
         gru47KWQzoh1gnly0zuNKye2HnI5tuvAWnOlzl/UigM/Nha/o38lsIch+IyLbUMiR9mJ
         w4FBpEXoRh5eV0LqJQow/pt44KmZAjLDwzkxKIlJqqfBQskSA48z7A/YW/3+MFTwPCyC
         Emh1mGXgmvANc7MFtyI1J6tZ1AWW60b1aloo203PN5GJcyw/mn7B7yxpv169DXB5eDOy
         Krfw==
X-Forwarded-Encrypted: i=1; AJvYcCVYnLRcnsganlDEs6OSCa2+/Uf6U9CBzr4Oll6vGtXw0lM46P1za9TghfF8LJswYqqpOGuLF7Ku25lSZfc=@vger.kernel.org, AJvYcCWzPq241bNd98lMG3hS6G5snBTyT4FWQFKB58sic5l4uh8m4GnkRralZUuWb+yvJJVCfTmmtqqh@vger.kernel.org
X-Gm-Message-State: AOJu0YwDY38C+hlOBHOP58ml1pbEkEoSxlOtqliExgRRWzZkNCkvCX+v
	uvWz80CK9stSAUBE4uDY2GJW8cg24K2qglCyHFKilX39SlSD1GHuxdh5
X-Gm-Gg: ASbGncs2lIkYyYM20EjYw4ZickOyd367Dk51Mq2+Vw4g2jRuuvHr/CD3AQiNTWW4ccJ
	+j1J1J9NTvB7qXOJGB3RnLlJz6My/hNlh4b4kF0aMoSO8pvPWVwy3lHEWRwEwMynbCW0j98zvRI
	SQf5+JyOqIrw093G4ua5JQW8d4VQoC6/yeMFzQwC0t22uRkTbUdgkHrRK528M4tPR8YZikBbPws
	SroNA5nHhpX/PKH5LQIEChXuP2qSQGA6eSsRkyGx4Fv4B09mheqTlSh3n2m3ArQzUq0cxEgx6cb
	JNdXEmWNv4obWwOwth6L3Ym7FIp/hxdJV/tSdQXGv1HhzCjquIeFrH41+dHZErpPMCo/cg2t6fH
	cBK9zrcmBEBW6YOzbmqTjGPOJDr8YZj4=
X-Google-Smtp-Source: AGHT+IEnYcH99DAYRXc0x0UK3oERqXnoWXIIKhvaZF6qQWBO6/lfEYEjNJYFzoYYr/fb+tERMIrBNQ==
X-Received: by 2002:a05:600c:1912:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-459f4eb1a07mr89058935e9.12.1754854700772;
        Sun, 10 Aug 2025 12:38:20 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.128.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58553f8sm238595195e9.14.2025.08.10.12.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 12:38:20 -0700 (PDT)
Message-ID: <ef987e32-f7ce-4b5a-82c4-8d89d5034afd@gmail.com>
Date: Sun, 10 Aug 2025 20:39:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
To: Byungchul Park <byungchul@sk.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 almasrymina@google.com, hawk@kernel.org, toke@redhat.com
References: <20250729104158.14975-1-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250729104158.14975-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 11:41, Byungchul Park wrote:
> Changes from RFC:
> 	1. Optimize the implementation of netmem_to_nmdesc to use less
> 	   instructions (feedbacked by Pavel)
> 
> ---8<---
>  From 6a0dbaecbf9a2425afe73565914eaa762c5d15c8 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Tue, 29 Jul 2025 19:34:12 +0900
> Subject: [RFC net-next v2] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
> 
> Now that we have struct netmem_desc, it'd better access the pp fields
> via struct netmem_desc rather than struct net_iov.
> 
> Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
> 
> While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> used instead.

I'll ultimately need this in another tree as indicated in the
original diff, so I'll take it into a branch and send it out
with other patches.

-- 
Pavel Begunkov


