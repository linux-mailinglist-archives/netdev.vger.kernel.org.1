Return-Path: <netdev+bounces-282317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLJIKMvN8WlrkgEAu9opvQ
	(envelope-from <netdev+bounces-282317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:22:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A6A491CBD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE3B3312840E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45913B9DA1;
	Wed, 29 Apr 2026 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Kh0X2UTY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE333BE644
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454068; cv=none; b=DhQAZVmiIpcou18Bpnn3/S24taTWhbvLThBvHI0BLYYJdUcdZ+oKMDcttxZiVkuDPFgULpFRwnJ2r5KImdCEv1SVFFs8QlTJjzT3ZqQX70rOHcayOb5a3vTflgeqNg+9Yk/VUdFLCVlDLqA+wLWzkh9v6ekSSxQcC43EN1vnGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454068; c=relaxed/simple;
	bh=jgXf7B8o2L5oMafAOmlJziUFrFGb55/V8m6ibh44qX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4npC5+8seKaHW4juzw1M4ILFXTvddvpN4fdc+nE2TNqoHyJ7uDae4FWxmiIzZpUFvILgYyePULHcd9GRBG6vwyy93rOEgpZZmALAdNNIX6CGojkh4TaFQk74B/ZBlGeDa6FyFBBRTOVKL1EbKX3BewZ6nKHlJv4ebhi4COYyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Kh0X2UTY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so3897695e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777454065; x=1778058865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpYH2pYzHGNT7MGXi5hbxaSm8cn5K6kufuob4tK43BE=;
        b=Kh0X2UTYUtu5Z9MkdzdVoMf+VlxIkcpcwYwixlLLfd2w+SShdK+LIpDdr7UQVNA5sL
         PO8WkxVfSAvK/qmGWoIUKUhmWHcm4e0KfBM3FAQDVBzyDgVzasC2Fq/gW1W77amEhckY
         cLfav0jD9KbISos0uKdr/EOA7nyMeBg5s22vznYbmE3Y+8bp7Ino4K6uRn/GI/BvG93S
         Ykfz0I+ubgmgixCFDj1r9VuGicamA5f3JADJEE99L5feKFpj3fsvu3Ws9d2si1ZlSwQW
         Q2dj70wtnxHX28wCrdcO4IuEbqnsKnuU9dC/vB7bFOuWIfIlYv6zUhiGDOmeYgw+MivS
         5aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777454065; x=1778058865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpYH2pYzHGNT7MGXi5hbxaSm8cn5K6kufuob4tK43BE=;
        b=Ed1m9gZetATe+JtNNbDlN+9KpQIj60JQ4m4bILTgqMPBFraqn6WH+N28XWc5IeHNgk
         0uXpz7sBAaKA8zeMN7GSL7fZdllQkcYA467xAcNYbyRFJStuP4WZD8WSiId+PmJGXHy5
         PWw7cBRV2tdqRpIb3aZKRtzKWekhnVhOnuyot9WNBdDfm3KTjGXp3x0FEYCHaJ/CG5+f
         hhxQMy6KMnVpJPc2bjOhuAgLfFT5HdWUyPxuC5G1U4zePJqhw5N9bUO4QNhlJt59+Lg7
         EXO6yrO8SYNOAKi0CswBL2JgAa6XXQvbE3MsYNZeL/mkcPalCOmSme4Ctc8zBuwe+dwF
         HXPw==
X-Gm-Message-State: AOJu0YwnxoKfEXT9Tk7eCiFdY7GY8YhyLeTkCNvYWrWhQ/1hS/AkNbHe
	oZt3pkhCInkDRUkxMJg0HFY22uZB11meAQOZZYTtMvgFzkP+al3qD/JCCk6xQVR+z5o=
X-Gm-Gg: AeBDieute2pIFUW2WUPZFyHOvcFGBJn11oA58nhh/9NkNnGvOrkDNCM3u6xkdNIQUn9
	7Az9b1BWegGg0bWKYpWYwOSnnpiPubLCuxQ6NexD9vEJCY1qP9X/pjY1f84/oLUMPx1sOeAPr33
	BTqKz+goO2GPsMrIOF/N/5eEcPNOl9Ez+Qg1cQov4YHeeSnd2/C/Wdl74GxtX4ei06EPhZMoOuW
	rApyRcqSt/STF62iBmCn9hjHEmChkvFeVb9LEmASqS/zfczKGClJp50SoH8jh3YKlwy3pS0qnep
	/S04ah666yK/Qx0T3+lgboX7I83mu0dIdGMBKdv2B0Sj01ux+F76qEba1MFZ64IHkby38U/ZqTp
	OkvBAnAkjfyvDMkigXW0sfDN9n7GhxrW3WjfyszfplXfyQy7N88pI6xPZuRZD0VbOIIaaB7mnPs
	GtqL0VpXhy0Ju4A4O9Q+Y+86E/yuXxHR6KI3CXwRwAyoJ84NnNUSoEC2/81GQgrDbi/0XbHaico
	Pk=
X-Received: by 2002:a05:600c:8593:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-48a7bf91264mr27144905e9.3.1777454065493;
        Wed, 29 Apr 2026 02:14:25 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c31f293sm13971375e9.28.2026.04.29.02.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:14:24 -0700 (PDT)
Message-ID: <2dc013c8-8ef4-48af-90fd-1ce6ea3b893a@blackwall.org>
Date: Wed, 29 Apr 2026 12:14:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: update the IPv4/IPv6 entry and add Ido
 Schimmel
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>
References: <20260428203924.1229169-1-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260428203924.1229169-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 01A6A491CBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	TAGGED_FROM(0.00)[bounces-282317-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackwall.org:email,blackwall.org:dkim,blackwall.org:mid,nvidia.com:email]

On 28/04/2026 23:39, Jakub Kicinski wrote:
> The IPv4/IPv6 and routing code is not very well separated from
> the TCP/UDP code. Scope it down properly by providing a more
> accurate file list, instead of net/ipv4/ and net/ipv6/
> 
> Now that the entry is more accurately representing layer 3
> and routing merge in the nexthop entry into it.
> 
> Add Ido Schimmel as a co-maintainer, Ido's git history speaks
> for itself.
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   MAINTAINERS | 63 +++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 47 insertions(+), 16 deletions(-)
> 

Wohoo, great!
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


