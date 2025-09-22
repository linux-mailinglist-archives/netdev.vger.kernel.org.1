Return-Path: <netdev+bounces-225311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D34B92169
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E144E188D73F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396AE30DECF;
	Mon, 22 Sep 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="cjH+7J3s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FC30E0C6
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556551; cv=none; b=ozlKxOr+sQT518F6ctbos+fJ7D3MNmTpztKEX08eDOQhuUgSnQp4q0XtSH+cEixa09rhC/Ilk4B4gs7vwZsagtY/SfnoW1gXv88W3P8RC+N09Rqnwy/8Bzs3wnQYW6B56jFVOIIyeSHoAUk9cWaWpQ4UIURGQcE1neyG/BSQFVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556551; c=relaxed/simple;
	bh=pq/O0L3iQRvpt2S4brWTo8EHJ/WdeRstTtx1HjRCEWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLDJ0udj0g9EUn5zkpDmAWQnpQT7ihrCmgsvH+nzxcTvy8phIOnrHSAqef9WeGpSLGzQ27UtvjN51UkuPQJiS4d33RMfdPFzJSkeUfBTSledjh2pRlNSU9T2ZXHKj3/STBDK9aX+Bw9V154jKzQmw631D0OJCxRNz8L/C8dtCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cjH+7J3s; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1821191e87.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1758556547; x=1759161347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JH5AoWKD3BnRdokPxPgfiznRnTMj6/N6Wxj8BEiEKQA=;
        b=cjH+7J3scrKdYHS2qnYAPJ7xVXT6TxmOmvXT7CH8LK/rHZRuk4T5nBYidcomCwWwBT
         FVVbnHjl2/DOkDTJukGB93cEUWM3bfjqmk+IUkff4WqwIZhioOLX17XbPXaxpGCKnM80
         Q4sWqqg0L1GCAoASdtVc3Cy3lUYye9NZWJdZ22AITrJrdl8WSg2zs0vwemKHkpL1Fkfq
         bLeEqaOOJ/H22mfVpaz4B63QrLZ45jRDvj/G+/WjFzXi32Q7XDpzboA2Rh0sxs+bgcEx
         +uZFH3OQqECi02QYKcQUDfS9SesbKB4gn1QCSsisbT0rlGtodljHIWTqhfcw+VOUN4De
         WX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556547; x=1759161347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JH5AoWKD3BnRdokPxPgfiznRnTMj6/N6Wxj8BEiEKQA=;
        b=qmaYEq/vMVawj8lZpjfnpUamKbr9aNWaIYVtlXG4MuCGPvFZtcZ68qKNoMMdEMtx1m
         xcrjRpZckp2jH6gvt7bYnG/BFUct33u++YXg0FtsXg4Q06I5ORqtU4onyDg7MeEoR0eR
         pQar/cWuZ52xu1d+ASgf/wcw7ZT9W6Bs9KDatGtJemGUwgH0H/umE6fnph7jusPerPik
         PiQwNmVeD4WFRzH47XjfQ0NaE2iYSMHAvjTPY/RcYo5gk2YhbrAxFI34BI7wFdT6/tPn
         SwMy4bcAsxSb5emvQebsuKkpQGmErCrMPpVaTbkoblL8pFjTzy7+VFIipm44JhJ0Gedt
         GPaA==
X-Forwarded-Encrypted: i=1; AJvYcCVg4KkGRjUcS2bgall0WEv8SUm40bjWfBrUwjG1Ca5K/fHaBc6OuVcsdE1pjq/37bFnX3RZqyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTb1HLKIvP1mUIw5jFsq1DSG3dV30VThEQ1Icw4KP3vtZYBd35
	j502JGOs1CnlABSvclZEZ/6Nedc/ZMm+EPa273cWUDUi5/TYOjYH2JH5PdcY7hLl7IM=
X-Gm-Gg: ASbGnctG50NsfbrHw9QSds9xA8OAB8L/vLfA0P2wcNmKDloimS5KO81cGRRH285gYdx
	hE/q45bsEQkPkvPwQMoqGuP36jZqUBNhkR/NtRP/+iZB4E8mO/hcmwWmRt8e7hw4FAa01bE0spN
	sy2lVEqMobsCN/eW1kIBFpBT4+E2tg5MMelx+jGLCXy25p0XFwIB5iCAawMgGuL/jqmTFWup6KR
	fQDOFWGUawDvh7UPpC58BQr6XAkPjrOKc1CwqWezWCRXZ60AVP5KWkOVVDHo/eqL/IwIjA9tV1S
	CoYtvIg3KKCd2dY4PugrKmA8jCLgZaeufMZjuDXx0ZHs5miegun7aiLCUEw7tq0+atP2UoTjN8J
	tFyBqGwgL2R3xfFBZf7frS50xJ0oB4PASjtOpIfbvUVuw63tlkBPI42vdx0owZbuLWwOLyAgZ0o
	w0SQ==
X-Google-Smtp-Source: AGHT+IERmXOhfELt8HvWUl7P0WDmFnVRCBbD/AzuUK5nRxpLxCKfqpY4wj6t5yMfkpqaSjn/kjNSOQ==
X-Received: by 2002:a05:6512:ea1:b0:577:fd15:396 with SMTP id 2adb3069b0e04-5789586999bmr5689677e87.15.1758556547546;
        Mon, 22 Sep 2025 08:55:47 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57f504e8bbdsm500761e87.133.2025.09.22.08.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:55:46 -0700 (PDT)
Message-ID: <fa3b661b-8bdc-4d2f-a058-8e379ee411c6@blackwall.org>
Date: Mon, 22 Sep 2025 18:55:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: bridge_fdb_local_vlan_0: Test FDB
 vs. NET_ADDR_SET behavior
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, bridge@lists.linux-foundation.org,
 mlxsw@nvidia.com
References: <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
 <137cc25396f5a4f407267af895a14bc45552ba5f.1758550408.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <137cc25396f5a4f407267af895a14bc45552ba5f.1758550408.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 17:14, Petr Machata wrote:
> The previous patch fixed an issue whereby no FDB entry would be created for
> the bridge itself on VLAN 0 under some circumstances. This could break
> forwarding. Add a test for the fix.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>   .../net/forwarding/bridge_fdb_local_vlan_0.sh | 28 ++++++++++++++++---
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


