Return-Path: <netdev+bounces-283683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Dl9SKtW692malgIAu9opvQ
	(envelope-from <netdev+bounces-283683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 23:15:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A847F4B76F5
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 23:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B2733001394
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 21:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFEE3A63F7;
	Sun,  3 May 2026 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Le9aXHFp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E19376BF2
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777842894; cv=none; b=MRevrpqj+OIVe1t5Fub5/ZxOv74Xf4pLjXwlWIIspmEEOS8tDEHE42f0g3y6tZcbj3Vm+NB28W0SD44VxmR0Z2MaISM5eNjaTIJeHMV1dOl1qSaQ71FK5pag64O1cGyyDwkiv9774Eq8xThmNKxGgZmRSFrqsDtVMHzZ9FLBTwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777842894; c=relaxed/simple;
	bh=V+K2mVsBaeYnMGR6qilukYJVFlEoxh0x5n7Ud19iDCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaVyCq88u9sbBcPbgEoX7SK4YUDRsj0GKmBPZ3aFd4VS6Hebay6LUDU8oEk6m/MBVj+6RbvorMo12Lrc6NEg0S15M4/5Qv34Ao4AyubVO/mCgMBncToiFlQKOF63ATEQAWFl/b/wjiLYiD3g9G4pMTul10oC0RTsaQe7oCglKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Le9aXHFp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so26978085e9.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777842891; x=1778447691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I3GbalmqOVoLmaBsRAowsaRFDSvBgG2HvM4r+wv7hQY=;
        b=Le9aXHFpNjuWBa6mN/eJfWVuzLOtt50u8foGu02uykhSgb62wIp1bINqT4IsC5nXqA
         wO/EWntEosazGCKZC+yKVOJAqvg69juSQntRAQ7odK6IeKHf7Dh4gY7vVEnCYCzvYOMW
         F3x8VNyEHJyVqHORgnfWz4/RerAXViTYYzs0TFb+hMuImtnS7HSmJlCZEpyISa6u/W98
         LxkAVzncuDmHMvJf00aZHRvP5tNzPCPgxq0AefCVrpFJnZ2kMjCuw2hYIteevkb/JD75
         HWvmoW2A1vPWL7771ag4dzRfRWNyCarFh7MBC1pYObN+oeiHK8RopNl4MEJnWBsjocCA
         3j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777842891; x=1778447691;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3GbalmqOVoLmaBsRAowsaRFDSvBgG2HvM4r+wv7hQY=;
        b=rgiah/UitDD78ZOyBN9ib5HVTgPRIfVd4TGz9ntf9Ta8sxCdWNhGeY8YYDEUFr3mSF
         eqEbroLKHt178tROvyeuwGC3JXfvqefD0AswCQxFpOZ1uvVavjxbCuP9XzIn6HkXgtMJ
         zMnvGGUgU8a53Gj6wbS41VlfXMKhU6zvoesDHVeUPXH8dbC0FLLmg2HNvK2M/0w0TMmv
         DT3pUg/dfBrvhcW9gDEkRiX6McT1+HgFdD0qs6nYA7lFBJo5ZSgTDC1fvInpm2Sh8uHf
         2oiHSiTEJ1IU8oR8oM/h1TiOKEufCfOcpxcN9GWFEChtNxgG1omK1vp+8XQtqCgLgPin
         2iZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9+MwTMCSfI3IjMA5sCWXqt/V7feE0n3Y3+SNEQrFFprRW2rHSlx2ajUduazar7VvSalvPeLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBdMy6lVzU/pnBlm3hW/QR1wnW5zbpexaMwzUGz3bx4DAtchV
	Em4b5Uj6KS3Sk/5YRGrELlUaWVeyOlklbVVCSkgVdCY6p2CSlJcfhN6HRz8Dzemy+eypV4Vmxa4
	/oevPxLhpOEO+xHm+1g6a9PeIhkaSfmG7pL3xGczQagdhZyXsM9c=
X-Gm-Gg: AeBDietndC7Z5jJK8mcS3eguaYfzKlnIIa3QA+SySKkK6weup15+atic9BXNM/Q/6RB
	tYvkP5AISlEiiqboQsPoxXTnjJaEXWBF5OXXXra3tsC4/TAPAYfITSkir23nQUb5SYMhg5zQnXq
	dqOo+dsl0rpiNFKx+m1YkBpBkO+yuXO0QplxhulKMENbeXG8e3XmSpCEkv2NAy3AYylTC1gmSB4
	pMibOZwUj/lRRSgEfJNWKNkgLKPbZKMMnW+FK6fhO1KXdIf/SVcU7/uKDCX9tqGBtlPh/6NsjLw
	NSOIFyjK9B7WM+WTXpdPchkJe+sf9pjDjzG1lisoeoFDzmShkmxiFEwbnFaFg8vEGkvBGKXiplo
	FKEV/yVGvaX6tEcD2DcwL4CduKVDopHst73/lzUnx5LTT8MViP9F+INIihHyEOSBA59nXRBbTnW
	ewH+F6mlUg7392dOZ5HPOhgajvpGvnu4QsZHCB7y4K1hnQueGvSmkfmNw2qZivD6hl8Ls=
X-Received: by 2002:a05:600c:4652:b0:488:bfc3:efc with SMTP id 5b1f17b1804b1-48bcc9f3309mr55373745e9.0.1777842891163;
        Sun, 03 May 2026 14:14:51 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4b8:ca93:ad37:ba9? ([2001:67c:2fbc:1:4b8:ca93:ad37:ba9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6ffb7sm225462925e9.5.2026.05.03.14.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 14:14:50 -0700 (PDT)
Message-ID: <b359d13d-8414-4aeb-958c-496b4b898b93@openvpn.net>
Date: Sun, 3 May 2026 23:14:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ovpn: tcp - defer TX from softirq to workqueue
To: Dao Zhong Ma <cz1346219@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Ralf Lici <ralf@mandelbit.com>
References: <20260501145425.757147-1-cz1346219@gmail.com>
 <20260501145425.757147-2-cz1346219@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260501145425.757147-2-cz1346219@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A847F4B76F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi,

On 01/05/2026 16:54, Dao Zhong Ma wrote:
> ovpn_tcp_send_skb() holds sk->sk_lock.slock while performing the full TCP
> send in softirq context. This can hold the spinlock for a long time
> (large skb), blocking lock_sock() users. This can starve the RCU GP

Are you sure that the stall is triggered by just processing 1 large skb?

> kthread and trigger RCU stalls warnings and hung tasks.

Can you trigger the stall/warning easily?
Any steps to reproduce?



> 
> Defer the TCP send operation to process context:
> - In interrupt context, only enqueue the skb under the spinlock
>    schedule tcp_tx_work.
> - In process context, dequeue and flush the send queue under lock_sock()
> 
> This reduces the softirq critical section to a short duration, allowing
> lock_sock() users to make progress and preventing RCU stalls.
> 
> Signed-off-by: Dao Zhong Ma <cz1346219@gmail.com>

As Jakub pointed out, this is breaking the selftests, therefore you 
should first double check what's going wrong.

On top of that, could you please run some performance tests? I think 
this is going to hit quite a penalty.

Especially if you have multiple peers and you defer all their traffic to 
the same workqueue.

Regards,



-- 
Antonio Quartulli
OpenVPN Inc.


