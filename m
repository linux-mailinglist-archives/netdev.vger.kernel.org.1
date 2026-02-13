Return-Path: <netdev+bounces-258587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLpoOuv0jmnDGAEAu9opvQ
	(envelope-from <netdev+bounces-258587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:54:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B557134BAD
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEEC330E877C
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28B34F499;
	Fri, 13 Feb 2026 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="B34Qbrw1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A1034F24A
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976426; cv=none; b=Qjr/ON/tlc3bgyci4EnBlFzJH/NTR7Aq6wz+4apQ827s/w0nu51FJ0ohBeTNkDKYe+gfk9jXCRAPwkWqhd03qr02YIV4u4e/Q/bMf0wcV/oJaGrj0iiCoSlueBynmWs5vvZ/upJBgyT4J9zhePOWA9dnieuotUGGAvMLxMGNLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976426; c=relaxed/simple;
	bh=RIesuow8Owo7wqI2pGBDeCOlPkxXvbQ5i0krwN3HP50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bErRzh3qKjbaRoqzcZbqXDKtyrzcTncOBlRcAolc8RL2hxp9cvGvI1/ufzJV71n59pytFIqSjnqPTt9oXZW7E7tAKCKrC4dwPyjceczKqeQ9O8Y79cr9gVEItxWvNzITWZTcp4I0vLNufxEBy8UFBnCP5DV1AVTxXZ2e/CpNVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=B34Qbrw1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so5840585e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 01:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770976423; x=1771581223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ACw1Fe1MYqj4TvYFJTTYpC2xFtLa1JWsA1+lYaVXDL4=;
        b=B34Qbrw1/ysi3UbFOWurL/g14doCwX/pDZBeKVfatBIxmFqikSWLx3NO7GCUoi9rjw
         k/XKqKqxtWWZv1moSAJIb1gS5fFhp7iOCDMP4LcW2vKuNqPrNhYn2LYA6fTFj3DSvEyF
         9YBlqQPsWXQw9fynX8fKbyOLaVkQLQirnjzhaBozQlKyGofAE73r3laWg2BkM6AWkgpC
         2cIWU/sWxuOp0p3chwVE1VaJjE5yP26zGwf7fsNDYlxNNG4/8FTwNNJJCnZWP0w6+9nd
         62xzkEuHRmvtEHI9spOKUK74ceV/OvpSM8tLATjt2e3PRL746uV2ACXFvOBhFavkl8Mk
         ry5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770976423; x=1771581223;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACw1Fe1MYqj4TvYFJTTYpC2xFtLa1JWsA1+lYaVXDL4=;
        b=nL1OTcNkqm7O7F/NKpncv0LcUgt3UNqkN2+IXxYRykQe6tCFahh+w8IExrZYmSAscr
         zRxF154R1mFcid3YfpBU1PGueqpXMCNg7UboYqqsKK42V0Lfdus3GJXezbHhFm86ztyQ
         J+XQOAfplchC6nNym/uJLCmVPV3nKpG3ZUFRa+BmgCQwwp/BY4vBvddZDu6vZBOSY6t8
         Isg6f2eT83CtMbuMraeg//6PnoT6x/fAnY4OmRoKio2eBcwosNAjW7cbDnEcYDEnxhRp
         PcuC++iFm7+733JXm/VKpB9ap/pBLuqfbfjtHYITz6G3Vme+/Py1l3lsQZF8tiUF21z6
         2QnA==
X-Gm-Message-State: AOJu0YzqvZNrSGw6JCewb5wMktMlEcZzxHI3oiTMwZSXgWdJKcBj0Ips
	igo1P9YxxVCCFVy8zBoWm+RY1Dk8bw7hPIdKEHtkGW0KNihpXZ2UvWKvuBSCmzr19FjlZ6aZ35Q
	Xf0s+fr0TABhsPUOCgGxwXUkhohWphf/C02d+x2JrG0kKaat8Ck+EDuh1SCvzuvVG
X-Gm-Gg: AZuq6aJIecu1few/ldLEQVX3Z3KiW5uWvc30kQ+95doDFU+wloEc3Bwt2yE/IC7b1dG
	yXw2X+GkddTH5uNSOGKw8OGJC7zhuxlhO03NIj3Uf15nDzeUvOiF0mD3sN+1XgGrcNnaip/6fLN
	QAfzo4hwFkK6xn/MSyoPBiy3E0Blm0FZWNSqEiFkzifMFL6edn2rRn5APLpHj3rDxqg5WH3wU1X
	nKhPg+S/RKdCfMT5KiLjXNXe91kBKx/EEWX2KcmSTpuHBpK3mg0voR8vYaSzJsc4i1j5YAhnRTN
	YJINtpR9VMN0DZ8Yr9FkPDrTYZQ0vyiXuU1VJlp+kHz4R6rSb1y7/4mqt+AJ1XDS8smPqZNPmxs
	+3DqD7rCp2arm5v66AEweAq2VWuXVs+TjvJtTEkifK2hJ3Wu0i9uhNFiHKkUc/T3gHL5qbctcjh
	mhMpTw/NIrM2RUJs1XubX7nu7LN3E/SZ+2y/uIEMy83m2YwTPFzHKJITo6
X-Received: by 2002:a05:600c:3e14:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-483710904ecmr30260795e9.29.1770976423232;
        Fri, 13 Feb 2026 01:53:43 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:686c:823d:23c:28d? ([2001:67c:2fbc:1:686c:823d:23c:28d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371998777sm47752205e9.1.2026.02.13.01.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 01:53:42 -0800 (PST)
Message-ID: <085435ca-8803-424f-bc25-027530ab996d@openvpn.net>
Date: Fri, 13 Feb 2026 10:53:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ovpn: tcp - don't deref NULL sk_socket member after
 tcp_close()
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>
References: <20260212213130.11497-1-antonio@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260212213130.11497-1-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258587-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 6B557134BAD
X-Rspamd-Action: no action

On 12/02/2026 22:31, Antonio Quartulli wrote:
> When deleting a peer in case of keepalive expiration, the peer is
> removed from the OpenVPN hashtable and is temporary inserted in a
> "release list" for further processing.
> 
> This happens in:
> ovpn_peer_keepalive_work()
>    unlock_ovpn(release_list)
> 
> This processing includes detaching from the socket being used to
> talk to this peer, by restoring its original proto and socket
> ops/callbacks.
> 
> In case of TCP it may happen that, while the peer is sitting in
> the release list, userspace decides to close the socket.
> This will result in a concurrent execution of:
> 
> tcp_close(sk)
>    __tcp_close(sk)
>      sock_orphan(sk)
>        sk_set_socket(sk, NULL)
> 
> The last function call will set sk->sk_socket to NULL.
> 
> When the releasing routine is resumed, ovpn_tcp_socket_detach()
> will attempt to dereference sk->sk_socket to restore its original
> ops member. This operation will crash due to sk->sk_socket being NULL.
> 
> Fix this race condition by testing-and-accessing
> sk->sk_socket atomically under sk->sk_callback_lock.
> 
> Link: https://lore.kernel.org/netdev/176996279620.3109699.15382994681575380467@eldamar.lan/
> Link: https://github.com/OpenVPN/ovpn-net-next/issues/29
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")

-- 
Antonio Quartulli
OpenVPN Inc.


