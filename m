Return-Path: <netdev+bounces-297922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DCoOGDQ+KmqDlAMAu9opvQ
	(envelope-from <netdev+bounces-297922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:48:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A928666E4A4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:48:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=cJDxf477;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297922-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297922-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F00308110B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B134104E;
	Thu, 11 Jun 2026 04:48:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066713314C2
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:48:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153296; cv=none; b=phxqEZwilwEmTg6ta1uwJlXcCU8HP2e5HO+V+F+w/77E3AN4EG9G1HErujr0jIIMRA9thWOQhBJJGGvpVkwdf1zn0XgHqbLDCLJDEtJumZX/kDS+d4gXq0xWTeD+Vd55dvZj2Tf4YNrVUcTsBrrTBno5hp8Z3OxTkNJgLkbM8ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153296; c=relaxed/simple;
	bh=qUylB5X6qsyVkzOwt6egzi75ak246ePx3uIWJkmZS+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbp6hCq/8j1B/NdED8EGNCM23qhZXk4qwXPvhzpCRy7RGAtDHe8mVhSGAcT7DyDIkyux4GhswYUBy7A+GIKxp/paA65v1PkUeQ7nr9mp+T1v44GEiibBuUaTnYlH3gixnbomNR+xB8HoSzsu8dWcCKWVQBaT9NY2qZipSNawEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cJDxf477; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4602e2a0372so5492204f8f.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781153293; x=1781758093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzz94QLSRU/UB8vEmVxjrC692qHzU+ePKBvtbcH4MYs=;
        b=cJDxf47781wyfSdRBRVSeNhiBY/uf8dGKINNu7qLJgZUA18lKoiPArfJzRz9JXDnfG
         2UB++KYhAzHLn+M2LbFsBM49o3IapYbVKeuKqtbOU64nma0tDSa8QfrJcxEdBm9oIKt7
         EHaOwKyv9jbmWyxuP5K3eZamgkXJAnYllxBC7vZa+Pi9cDTmd9Txl1nZYlwEhM+ueOBn
         jCYqGQkQnLzE+zOWP9/jS4HPYwD1g9w7RnXcwupt8JET6mi+n0vf7/Q9UfjQg23bV839
         4phLdrcYG2LqJAGRxg2hME8+u2s6ajVjMDYoPUhQuPwz4hk3Rz81gTCr3/3paMt0/j4e
         D/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781153293; x=1781758093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzz94QLSRU/UB8vEmVxjrC692qHzU+ePKBvtbcH4MYs=;
        b=lC3lF/Mq4hGEUUFV5/4XA8qZYIp3vw6t2cDq56QRoOvUlawiBw/lOqw831MwJFItc0
         zPBtbCakwjXNO6k+S7IscoJGxqkZKkOdzY/pIRwBUKXqC+G85H1ktW5Py6CWapvkzNwJ
         Y9q1pSwjHwhhGKs3IIa4D1HEL5PDn+fWLU9XmTdHAZ7ZGzUFLuuufEqgOAOBI5uWItP2
         BhjMcqZKzqS4YnyLisgQHvw+4nLlxYaw1RQwLUMT0xQTAOjKpZmRPUakKzNYwwH776Gz
         FLT514N0ECDKKqB9KFSHvi0mWaB/QrfSeQRgfuidIvKoeicpFvw9a4ozx46tGgpf5L71
         8DXw==
X-Forwarded-Encrypted: i=1; AFNElJ+caT+RP/zeapV+fislpnAAZJKRqc613rRqQ2JiAAUinHE3gqC1tFEMIJ2Ihl0Fd7ZtUjO8bw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYBvrophO1MQ8ZjhE+d5Xef31RlFFuqbb9mOzVsnIsR8m0EoH
	LEAlGc9/iEENY6RMxV3QGNefa9fuw/EmOVa+xD3jZ+938q2EqBUnTk+ZNiEHyxiG0tM=
X-Gm-Gg: Acq92OF3FkdqTLbgpf1dbwJzrogsUffbMloVmBEMlAZbqq2HejdkZ4L6OypEA/I8jXw
	Eiqp5eeRWTZUm+ho8d+oEyo2S34p7yQN+LVfZomGhZkNK73wPMsYN2RG0N7oc0KeuvZvuJOMZ6Q
	hBWpRTLv4CDSkqBT/hPDiqkzZl8vStu3ZNMHc5FjhZAPzj1txNOBq2+nlmDrj5Vaz6hwYBVfsJi
	6Hl/Y7v9n0wH6giigsWXnhfqXSz6NccJ4VOFx10lQNSVqG8TL8cdeZAg4NGxYZfWK1oZg58pSjG
	grF0/e2OsA1ZFkhen7ojiF/cxmjFseaR73A8yuY2tfrQHQNx5kco7fsa6LXzPF/vbAKJK88jFRC
	xJa+L2iLUQQjjJKV4f8NAGD/WjoNsmMGBMnr77UqxdHFxICakwQQTcVi0oiRKwVA9P85Qg6ECgw
	x9tnA8XZQ61WMaoInFYHtye/9OLJycgvVmNDcTLI2iyiSm9HhwzH/ECaVwwBYTZbne
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id ffacd0b85a97d-460677b28camr890344f8f.40.1781153293408;
        Wed, 10 Jun 2026 21:48:13 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm82124123f8f.23.2026.06.10.21.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 21:48:12 -0700 (PDT)
Message-ID: <d9a92cd4-130d-4f56-b45f-83b953946523@blackwall.org>
Date: Thu, 11 Jun 2026 07:48:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 5/5] net: bridge: use atomic ops to
 read/change p->flags (III)
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260610161836.1275531-1-edumazet@google.com>
 <20260610161836.1275531-6-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260610161836.1275531-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297922-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,blackwall.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A928666E4A4

On 10/06/2026 19:18, Eric Dumazet wrote:
> Use test_bit(), clear_bit(), set_bit() in:
> 
>     net/bridge/br_multicast.c
>     net/bridge/br_netlink.c
>     net/bridge/br_stp.c
>     net/bridge/br_stp_bpdu.c
>     net/bridge/br_switchdev.c
>     net/bridge/br_vlan_options.c
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_multicast.c    | 5 +++--
>   net/bridge/br_netlink.c      | 2 +-
>   net/bridge/br_stp.c          | 4 ++--
>   net/bridge/br_stp_bpdu.c     | 2 +-
>   net/bridge/br_switchdev.c    | 8 ++++----
>   net/bridge/br_vlan_options.c | 2 +-
>   6 files changed, 12 insertions(+), 11 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


