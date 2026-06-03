Return-Path: <netdev+bounces-294662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3SG6NV7kH2qfrwAAu9opvQ
	(envelope-from <netdev+bounces-294662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:22:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0618635A79
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:22:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=HQ7B4YEE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294662-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294662-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 346463032468
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF339A815;
	Wed,  3 Jun 2026 07:46:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBD3FE663
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:46:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472771; cv=none; b=hQYLq7MVL/rkotWcKNKXQs6uLaQaLWC0tkskapb1W6FndFe9Z7n0KqPxC9cqdBy7xcRY730aXhwoST9WZf6Z80lcPjtUR3Ysnj8Q8uevtaRsBV7oFrrlMBCAg0zst6SxoDpkrlHM7Vr6AshHpaf17vJNFksSzOaJqN2oHxph+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472771; c=relaxed/simple;
	bh=3wZ4OzhudEyTYsHfL198cfy0y/0uTxKz+BFXSUixBfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEupRm2cG57Kx78NgWHgo6KqYR7cstq/QPkGkK07f8/HKx2/NeUhZ3fGyxsWqQqh/3ePelR032nC+XrqyE9Zt5KtsFDsCp2wNU8asJDfCLNpL9Pf/ZrJAV35v3EZHt4xb0ZixW1deJl8vRbIFwEwMr/t9Gyua4M8Qw0Tbs3m1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HQ7B4YEE; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eeba68948so4668234f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472768; x=1781077568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9o+DqfOZqV/p8SR/3omKDeceWss4ta46ySVy0tkiI8=;
        b=HQ7B4YEE8/WYKenP8c9TBxNxszETZeS61OD7wGA6rTueRzflikiNiiq4hHX06+iLx3
         sCKmjaSoWvZEMJKiCu09+iQrBVyQ0PNRR10OmirtJ5j4viaRCa2RgrGnyDLUubpkst2d
         +MnlpPHKRxS8c8C2/3X6WCa9GYxoqH5p+g9gV2Mhka20Wr8f7vA1pJHlL/uZ1S06C4Dp
         stgdqr3GpF8LkwQBvzh2y10lIoOeCBY4AE6tzb/2qKwd7sILjZyXhHCrByUlGJpPCaGE
         +6ngqwafloB4ezx/nrZyeOS1Y5CTwMHuQjc6zOl/4dcqdqaNkyiTatx9qoNVlspExV/V
         1Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472768; x=1781077568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9o+DqfOZqV/p8SR/3omKDeceWss4ta46ySVy0tkiI8=;
        b=PMyfJXYJtJ1L9nakKEZZEaFZn1/XEy+JYC1+Ay7hEdQXI+RGvQsl88cXcEmHQhjzzC
         ZADMhwVcm1wKYW20zuIHuVPOLyzH9OXtbKoz21/j3c0PjREy1cPZo/mGU1OlVyFYeidZ
         hGP3WggPyAJSml4T6T00FVDPqQvSNPQA20P+R10pF84onH0B8tWZS3jWG58uUJ07pF8C
         HaPEijVfPgTBUubZZLRQNj+CGm7wnu3iQuoa19UJPQXBep0KOsr1HtlpFqsRGq/vbRip
         BZHta5wkfPYmhZ2KwsnmYgWBO13xIhqLpQIF9eCVCmWpBG2/R50aUAm4IonOdecdyrTm
         FdXA==
X-Forwarded-Encrypted: i=1; AFNElJ9zb/BmjUQahT3wAPyyVHyG6AgZhBHkqISO1KAChKA8U3m/RjZJduPEhxJJwOZxijxkh/nVRR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweaMDjIPyN83/rQsgHeNwsuuSDWqlnBoyfqB7+V21y/71MUdvU
	/OJdQDkwN+o04JGSw6cKDur8Tajptwj2O1lu7sQ8/9YZsqgkin3fMjTclf5Bi2ILbP4=
X-Gm-Gg: Acq92OHdgXuvcAPxWiZ5otNW7AnD2FEdMfP13AFQN76K1a1D8l1wNsVd8uZLpINK6MT
	KCSrXjBiG3olYH4AGnyPSe0nziiOTsZHREP/U/iPwvnXttKVz2rJG9IjpCDD8ShPXPKx/25jRm5
	sAJFqhugra1h1GQiia9+X4kOf0WAnpXoxSFlZ0g54UhdOttejEfrcjyADDJQ3y7Y+x8mcIm2p3S
	y/kOBDcMk8Tabs5EcoE5eY6pyFGVw4PrnOWol56hxSkGPeeFXFCwPiggWWP2M/r81evxZyhwavN
	h1Rl+bqJQVjklgQQj/rtpUIu6XKD62y3e4AUuG1o+Rf9UwsnK0CTdQuEBgPTHQSkcQHwcbGW/YU
	v+SD+Kbe8YbXKTIZ/cd1grkI+yKg5+iWVCdwPLgvPC49XC1nFtOUYJ21QRECrjEXeHlWiG8d8d0
	ZacUK6Hj8HK3KUr5NoJBhLuTdg41z1Xi2RUSLCbfzNqsEASSrB9yrBGOfKH/TurxjuUsJjrYYOq
	rQ=
X-Received: by 2002:a5d:6e84:0:b0:460:1695:89c9 with SMTP id ffacd0b85a97d-460218433b5mr1956420f8f.24.1780472768184;
        Wed, 03 Jun 2026 00:46:08 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344148sm5543595f8f.19.2026.06.03.00.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:46:07 -0700 (PDT)
Message-ID: <0002f8ee-0114-4ff3-9b55-2316655bb712@blackwall.org>
Date: Wed, 3 Jun 2026 10:46:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/11] bridge: provide lockless access to
 p->designated_cost
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-7-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-7-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,blackwall.org:mid,blackwall.org:dkim,blackwall.org:from_mime,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0618635A79

On 03/06/2026 09:20, Eric Dumazet wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations around p->designated_cost
> 
> This is needed at least for sysfs show_designated_cost(), BRCTL_GET_PORT_INFO
> and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_ioctl.c    |  2 +-
>   net/bridge/br_netlink.c  |  3 ++-
>   net/bridge/br_stp.c      | 28 ++++++++++++++++------------
>   net/bridge/br_sysfs_if.c |  2 +-
>   4 files changed, 20 insertions(+), 15 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


