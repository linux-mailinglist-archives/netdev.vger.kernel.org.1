Return-Path: <netdev+bounces-292277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KepAlfnFmruvgcAu9opvQ
	(envelope-from <netdev+bounces-292277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:45:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C655E45F3
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9189D300425E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7C3F6C29;
	Wed, 27 May 2026 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Huj9E6DD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83286305057
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885908; cv=none; b=Kt3o+O8W8LkoPqM2THai8GKXNbCwzjOEFGGoq+4VIxGHWTe6slSpd0tt2A44jqZI6PMOqBJ85Idb3CgYECD/UuVe1gADLr2P3LLnQH5u2Rn44BjlCI9/jg4wF8rj26RqwBP8r+L3YFZEWzqmnBNQ8YiHbOIvWcN6FLMtlr417Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885908; c=relaxed/simple;
	bh=UuoF/SSVIBBjD8o2nai2wCiKGzi8UqyqfMz357rb0gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+osXrPtJh9FdVBrwrFifVODTtOAWaum+9nkVO5BxeenTK3SeTe5LPSstWIM5ZdKOcItgTXCk8HUifr0ELwddec59onEXWTjAsIqAmQdVzVNMeS3WxmP2yig+O+ob8ZUgSj5YXRzLk9ShGQRpvjLzbBZZ1fbgjkVgX0vZFxC7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Huj9E6DD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4905529b933so32800925e9.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1779885905; x=1780490705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2mjncS8MA7krLkQK+9Yd/R6ecwTZGpLVQUg7Xk5PHww=;
        b=Huj9E6DDwFtkpuxuWzG4My/KhTwX3w6Ms3sybht9/i+bw94R8AK8yr8bb/uWRlcs0c
         2fMe1AsOBhyRs3SFjiJpGp1UWilP/TU510dNnB4NBThJXa6osubMrL9CV83o5Y989zCX
         0MtYGGIemdJzIBEbgQhEbjSFBphu2A4g4V25J32QMpnxCw3qTcStpR15dCLRnb7RWASl
         jUN5u7q7ZUIblh5EowteJ3f4C5ZyzhkyLFke8GmRwbhvHUXQFmGqGosXlkv+VgRMkeC3
         MzGW18ve2Z6UKH0F3IrM+X7WCDdOQK8wWNUOyHffi2XEyqH5wT+TXSYvPNxH/nsI1cHQ
         P10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885905; x=1780490705;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mjncS8MA7krLkQK+9Yd/R6ecwTZGpLVQUg7Xk5PHww=;
        b=ipX9BSX1WECA77kDD38UjlNXzpQVNauryd2i5hd0Mi6fpc9B2ZXDHHTu4OcStnVaII
         y+3ywWP9jx+CJcWEfxHYtsNCvwafXvaMBxCG6Ml2XD6LRiwp7llpLvL1+o0Mv2rfGo12
         O08B7o8DluaQ0G7atJTmKTzPU15kor5njMFXRNEhSHpk0+pbioXI0m8sSPV6f7gTrAFC
         iNGLEblBxFetIsrlZFgvgzFywNdk9LabS7H8oMu8D/s4j2Bp8jVPB2GKQJ70hzqUUAem
         8tt1pyCXQ0YKzYlwaA443OTFejbcE1QM/OW+7ffVtcprTKvHqFj573dyonoBdO7rsY15
         rq6g==
X-Forwarded-Encrypted: i=1; AFNElJ8eAhw1pBupkpP6/zgBXf3z14MnELfSVF05zqFvmdQI7USKk6+uc69MAiJxLlIx3MmuZO1nkD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/dVVUYnn3qhFX1GagMlcUWzZ8zLS6hlcZZQo/srw+LwSIxLaV
	P6QG7YSTq8vk3JV+xOXca4AFCmB3WlWp9hOXUqJni12rp8PeCDDyeLIaB9IOcIM+trmUe1iSKQ+
	Cijsn/MpobVr20iwJrwlremT0X36a54wquEvNGVmabIOOthEnqdg=
X-Gm-Gg: Acq92OExBJhKZlwZh/sk8+1Oj6eZ5hBJ1PpwzkMXp8Kh0pqYX1W11GIR6TEzcPhioiT
	ym3anletf3PDIv5fvSysqG+XdISUk61/i6YNSC4bTJMR2xpGD3sa3qEOzcGNQoZPjjOWMdwcwyf
	CejNFC5M3p4YohCNQ2owNJh25IywKEM1aD4/wo3bzgqZJBlgnxa/khjVUruqPsAs02ABAzKW8dp
	MMkCRWH4v30Om7yLZVPcS91azMNDfb0aTYdEfPIBFks6hcpVhuQiJKq6c0j92GxlhXzHMsBdOlb
	9C6OtD0E7pCnSRbknTcOpY9gTbeCCcxBDe/qpSD7uhgkppibXdEO3BJbVvAPoZmQfQFqmz2TtCj
	UNF+sc1wtBA1aQQXMKTfTaODdCNgfB/c2Rd9p9lqYM5ponEm/GnhF9WAi2PFKunPAzZ9+NAhdBZ
	tUUvVLKgpa2HmTO9la72BQ/CZRZ4pR0mUimmfeYeoqAi94D84yUEYFKUGblixXmlS4msUeWQ==
X-Received: by 2002:a05:600c:8b08:b0:490:601f:d785 with SMTP id 5b1f17b1804b1-490601fd90amr255334435e9.2.1779885904799;
        Wed, 27 May 2026 05:45:04 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:694:3a59:aa58:3b16? ([2001:67c:2fbc:1:694:3a59:aa58:3b16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2a7esm5839146f8f.20.2026.05.27.05.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 05:45:04 -0700 (PDT)
Message-ID: <10ea92d8-f4f6-462a-a76d-729cfa1715e1@openvpn.net>
Date: Wed, 27 May 2026 14:45:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ovpn: avoid putting unrelated P2P peer on socket release
To: Simon Horman <horms@kernel.org>, Qing Ming <a0yami@mailbox.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260523081543.94507-1-a0yami@mailbox.org>
 <20260527085510.GF2256768@horms.kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AYGGhrcHM6Ly9rZXlzLm9wZW5wZ3Aub3JnFiEEyr2hKCAXwmchmIXHSPDM
 to9Z0UwFAmj3PEoFCShLq0sACgkQSPDMto9Z0Uw7/BAAtMIP/wzpiYn+Di0TWwNAEqDUcGnv
 JQ0CrFu8WzdtNo1TvEh5oqSLyO0xWaiGeDcC5bQOAAumN+0Aa8NPqhCH5O0eKslzP69cz247
 4Yfx/lpNejqDaeu0Gh3kybbT84M+yFJWwbjeT9zPwfSDyoyDfBHbSb46FGoTqXR+YBp9t/CV
 MuXryL/vn+RmH/R8+s1T/wF2cXpQr3uXuV3e0ccKw33CugxQJsS4pqbaCmYKilLmwNBSHNrD
 77BnGkml15Hd6XFFvbmxIAJVnH9ZceLln1DpjVvg5pg4BRPeWiZwf5/7UwOw+tksSIoNllUH
 4z/VgsIcRw/5QyjVpUQLPY5kdr57ywieSh0agJ160fP8s/okUqqn6UQV5fE8/HBIloIbf7yW
 LDE5mYqmcxDzTUqdstKZzIi91QRVLgXgoi7WOeLF2WjITCWd1YcrmX/SEPnOWkK0oNr5ykb0
 4XuLLzK9l9MzFkwTOwOWiQNFcxXZ9CdW2sC7G+uxhQ+x8AQW+WoLkKJF2vbREMjLqctPU1A4
 557A9xZBI2xg0xWVaaOWr4eyd4vpfKY3VFlxLT7zMy/IKtsm6N01ekXwui1Zb9oWtsP3OaRx
 gZ5bmW8qwhk5XnNgbSfjehOO7EphsyCBgKkQZtjFyQqQZaDdQ+GTo1t6xnfBB6/TwS7pNpf2
 ZvLulFbOOARoRsrsEgorBgEEAZdVAQUBAQdAyD3gsxqcxX256G9lLJ+NFhi7BQpchUat6mSA
 Pb+1yCQDAQgHwsF8BBgBCAAmFiEEyr2hKCAXwmchmIXHSPDMto9Z0UwFAmhGyuwCGwwFCQHh
 M4AACgkQSPDMto9Z0UwymQ//Z1tIZaaJM7CH8npDlnbzrI938cE0Ry5acrw2EWd0aGGUaW+L
 +lu6N1kTOVZiU6rnkjib+9FXwW1LhAUiLYYn2OlVpVT1kBSniR00L3oE62UpFgZbD3hr5S/i
 o4+ZB8fffAfD6llKxbRWNED9UrfiVh02EgYYS2Jmy+V4BT8+KJGyxNFv0LFSJjwb8zQZ5vVZ
 5FPYsSQ5JQdAzYNmA99cbLlNpyHbzbHr2bXr4t8b/ri04Swn+Kzpo+811W/rkq/mI1v+yM/6
 o7+0586l1MQ9m0LMj6vLXrBDN0ioGa1/97GhP8LtLE4Hlh+S8jPSDn+8BkSB4+4IpijQKtrA
 qVTaiP4v3Y6faqJArPch5FHKgu+rn7bMqoipKjVzKGUXroGoUHwjzeaOnnnwYMvkDIwHiAW6
 XgzE5ZREn2ffEsSnVPzA4QkjP+QX/5RZoH1983gb7eOXbP/KQhiH6SO1UBAmgPKSKQGRAYYt
 cJX1bHWYQHTtefBGoKrbkzksL5ZvTdNRcC44/Z5u4yhNmAsq4K6wDQu0JbADv69J56jPaCM+
 gg9NWuSR3XNVOui/0JRVx4qd3SnsnwsuF5xy+fD0ocYBLuksVmHa4FsJq9113Or2fM+10t1m
 yBIZwIDEBLu9zxGUYLenla/gHde+UnSs+mycN0sya9ahOBTG/57k7w/aQLc=
Organization: OpenVPN Inc.
In-Reply-To: <20260527085510.GF2256768@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-292277-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: B7C655E45F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 27/05/2026 10:55, Simon Horman wrote:
> On Sat, May 23, 2026 at 04:15:43PM +0800, Qing Ming wrote:
>> ovpn_peer_release_p2p() is called when an OVPN UDP socket is being
>> destroyed. It checks the currently published P2P peer and releases it only
>> if that peer still uses the socket being destroyed.
>>
>> A peer replacement can publish a new peer before the old UDP socket is
>> destroyed. When the old socket destruction path runs afterwards,
>> ovpn_peer_release_p2p() observes the new peer through ovpn->peer. Since the
>> new peer uses a different socket, the function takes the socket mismatch
>> branch.
>>
>> That branch still calls ovpn_peer_put(peer). At this point, however, peer
>> is the currently published replacement peer, not the peer associated with
>> the socket being destroyed. Dropping its reference can free it while
>> ovpn->peer still points to it, leading to later use-after-free accesses
>> from the peer and socket cleanup paths.
>>
>> KASAN reports this as a slab-use-after-free on the kmalloc-1k ovpn_peer
>> object. In the reproducer, the object is allocated from ovpn_peer_new() via
>> ovpn_nl_peer_new_doit(), and freed through ovpn_peer_release_rcu() from RCU
>> callback processing. Observed access sites include ovpn_peer_remove(),
>> ovpn_socket_release(), ovpn_nl_peer_del_notify(), and unlock_ovpn().
>>
>> Fix this by returning from the socket mismatch branch without putting the
>> peer.
>>
>> Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
>> Signed-off-by: Qing Ming <a0yami@mailbox.org>
> 
> It is probably not necessary to resubmit because of this,
> but for future reference bug fixes for code present in the net tree
> should be targeted at that tree like this:
> 
> 	Subject: [PATCH net] ...
> 
> You can see more about the Networking development workflow here:
> https://docs.kernel.org/process/maintainer-netdev.html
> 

Thanks for spotting this!
I'll queue this patch in my tree and send it to net soon.

> 
> FTR, there is an AI-generated review of this patchset available on
> sashiko.dev. I do not believe it should effect the progress of this patch.
> But, rather, be considered in the context of possible follow-up.
> 

We are already actively working on all pre-existing issues.

Posted fixes can be seen on the openvpn-devel mailing list.

We are triaging patches there first (Sashiko is picking them up too) to 
avoid clogging netdev.

> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Cheers!

-- 
Antonio Quartulli
OpenVPN Inc.


