Return-Path: <netdev+bounces-274172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB2eGzRFzWkkbAYAu9opvQ
	(envelope-from <netdev+bounces-274172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:17:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBC037DCDD
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F1DF30ADCBB
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D45472764;
	Wed,  1 Apr 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="Y7vIHXh/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595D39A046
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060053; cv=none; b=hkEjC90IH42Bi9f5e4d9rc3GL7ipWx2M0T36imn4kksE6uexlTzLd+OaTZGSgZ75PWgROSuQ0GdNfKB5DHLQdvOqazlkKjLqRkDZbrnDCgvZFHTORXjT8VSDrK2BwHeNAk+u1beU7FOrM26ffZUSw4s+IXnsz/fCiZmXZkzQTFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060053; c=relaxed/simple;
	bh=5vsaEaZXu0b60Fw2daY4xBXRpr8mZ34kaMt1aHDy5Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfvybbWgquEFgl4GiRqiu6ES8dITloGTfB6XpM22SrcUzGmUNDq7b+AGXnbL13zWJQbMsCAkxagk1XGhEfnPG/lecU4AQjnIfbv8KEMX4fVP3jJrPwifAbJyOEObcFK+m4hV+jrICUDm9BiHTVqF4ypkc0ncHdUDem7jvxfkO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=Y7vIHXh/; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56d924c7183so523519e0c.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1775060049; x=1775664849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+Q1jXLiEJexeZZTXwdCnetPvxe3gmMyFGRYsaWGRvY=;
        b=Y7vIHXh/iyIIc/cnelQ7eBASDDUFHCz3hiO89qemg9+J6BDBYdK6bMrXheNmsb/Y/E
         JSzR2DgPwwTwkbR2S4IxCqZLuEozX3VRIHyGTkkS36NvwMCJSljKFyZu4r72zQipQUDK
         ZfLm/nH8NQKU8zbY0hCBjmCKZA0mOxHjngLI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060049; x=1775664849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+Q1jXLiEJexeZZTXwdCnetPvxe3gmMyFGRYsaWGRvY=;
        b=XUipmtyotl1uML4a9/PNh8kRLnL7Tr9YmaHDGAp7NhBfZ1Kk5I/3aMUxoWvcmKLBE0
         emP4B2zOvCkE4wAqAVUmvCf/zyXxDrGMIKhzL9giNos2YeA+QPlX/I/SvZzf0j/XL8fU
         uRV0L+cbp0SSpf5N/ZVnRMaDcYLfjAbr1EEiIrTS6qdlqxHJJ4EJwa9z2sA4YkinR/wL
         LYnLTv/Nk4fc7fY9saaiTmXuL8Cv9ytxf6WeNmj2f7Nzca2HrFVKZP7BBtBO9RMB7wYU
         Oaut8sWks2Qd6uDjkWrlfUhWlwf4VU73mBCW45A9ikrUjm0+JfeI6q5HCouyn/qapraY
         cN5A==
X-Forwarded-Encrypted: i=1; AJvYcCUKqeQDDw8bSzDtmDQQwSVXwpoM3Dy19iwBX+3T1R8V0tQz/3lYmr6FBB4tMwLERgCpwuw6YjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzcp1fxshinuq3LgfbgciHbxj0dEx6DucSHMJWNC+d/IcdlXTn
	Tjy0aOaolKfUe9tJ7J7EhQfRauSPzmtzeq1qaLWCVddQKrK3JzKMn3TrjhvfRqEYjrw=
X-Gm-Gg: ATEYQzxpgLzZyrGWv0qUUG21eDEBNrDRhZfBthvRHuDWgMqFkt+/UHq0u4aJx440VA/
	QXOW/NbaWEjcHiIwCCKNsPA3t6LjG61txY+EXfxO5ZY5WXRAJuFlZRpPWv7XfAYa3bz6C+7ghrj
	UwPM/vWvmtODxgbnhz/n3RurWeDEcx06jbp7hxZgtDPgGEPX6TabN3ktoZbntfn9hX5UW3WMjtW
	4Owk3Tx3KHETDJ80P524bi3hOV1wM3/mzlV6Qe3qQCApS+J0SssUm5efuoHqaGV2KoWhvpGK/XP
	XWZLZ2P28laknY0kzO6CN2JN0qSfBqdJdioZ+6rI95Knf0gzhYpE4Grcb9I9+GcY8lV6w962sLM
	Tz6IQ+AvyMDpk2BAJTHKeXWUQu0WjBhr6ohkujZuy5A1jY/gbPO+gBstnOPjQKnEnFiJ0SG2fCt
	+ZfDaUSJdjYcFXhuT1AKxmDf1TSfFPeLG6wBoj
X-Received: by 2002:a05:6122:553:b0:56b:8ba0:fd58 with SMTP id 71dfb90a1353d-56d8b04d750mr1470500e0c.6.1775060049263;
        Wed, 01 Apr 2026 09:14:09 -0700 (PDT)
Received: from [192.168.1.2] ([179.105.152.82])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a46f4dsm17612731e0c.15.2026.04.01.09.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:14:09 -0700 (PDT)
Message-ID: <aa7aeb86-2430-4c67-9d5d-bb27ad037865@allelesecurity.com>
Date: Wed, 1 Apr 2026 13:14:00 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 15/15] rxrpc: fix reference count leak in
 rxrpc_server_keyring()
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Luxiao Xu <rakukuip@gmail.com>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Ren Wei <enjou1224z@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>,
 Simon Horman <horms@kernel.org>, stable@kernel.org,
 anderson@allelesecurity.com
References: <20260401105614.1696001-1-dhowells@redhat.com>
 <20260401105614.1696001-16-dhowells@redhat.com>
Content-Language: en-US
From: Anderson Nascimento <anderson@allelesecurity.com>
In-Reply-To: <20260401105614.1696001-16-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[auristor.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org,gmail.com,lzu.edu.cn,allelesecurity.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274172-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davemloft.net:email,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 0FBC037DCDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 7:56 AM, David Howells wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
>
> This patch fixes a reference count leak in rxrpc_server_keyring()
> by checking if rx->securities is already set.
>
> Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> cc: stable@kernel.org
> ---
>   net/rxrpc/server_key.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/rxrpc/server_key.c b/net/rxrpc/server_key.c
> index 36b05fd842a7..d4777851079f 100644
> --- a/net/rxrpc/server_key.c
> +++ b/net/rxrpc/server_key.c
> @@ -125,6 +125,9 @@ int rxrpc_server_keyring(struct rxrpc_sock *rx, sockptr_t optval, int optlen)
>   
>   	_enter("");
>   
> +	if (rx->securities)
> +		return -EEXIST;
> +
>   	if (optlen <= 0 || optlen > PAGE_SIZE - 1)
>   		return -EINVAL;
>   
>
Isn't this the same issue addressed by my patch "[PATCH net v4 08/15] 
rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()"? Just 
asking to make sure this is intended.

--
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com


