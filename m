Return-Path: <netdev+bounces-289444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBmnKppYDGodfwUAu9opvQ
	(envelope-from <netdev+bounces-289444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:33:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1255957EC0D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7486305BF82
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E44633123F;
	Tue, 19 May 2026 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXu8/vwB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E344BC030
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193620; cv=none; b=I1h4YHG/5nZRIRJxOeuojBIDrU0wX/uGA/t+WGezU8yrngQjKGdAyS+Y6kgLO7VWXvvUFaZWdZkhO8xzZzZgjpvGlUanp3wa1XGj9jTVyMNexdfdVgL9zUTfxnyf2At2q/Nz+YiVjieSzPRkBdsajo1sPDf2fUz4EeZxpeW3QWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193620; c=relaxed/simple;
	bh=RujqihfWGD6HxMViId0HXIl3yV7Wgy4/zFCiTKpJ9D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7201+vo3Xy8nkAYcd4sBgq8+yHpm0dAN5NzlsKk5Attz/xfmCB3F8wPw5ZaPi4FF38lukGgg/mhV45vU85e7RtUcqEfgHSN+th5MHI+XKoXx9VeuJzGvbPBthmWjKigaWDcokV5Uy//4GfRQPSVtV7KXgyynwrp2WpbaqoD5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXu8/vwB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48910865133so2016575e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779193617; x=1779798417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1fL6Lb1MuErNbfNqNLESAR0o0rQvy2NEDm3WS5YbMY=;
        b=VXu8/vwBZ+2cILUI1HwBLSvyw2Qq9NcLAWjvMUZFoWpSXqV3or0OGaUvrG22yX3eiP
         uIFR8ABs7qePCtiiZO6y4YhWHyc+OfZ/OcFo6Ed3570CRPhjkuUyukUmk4lElLdUQUcF
         xghFbD8ltT9t3BZ7UDOVm/Iz6W6Gyd1CsFywz32c5pZz7jfHH408PhS4gIgeid41J4bi
         Ef3OjAEnDRdkGUzm6VGiaFXKvQ62WuZvvCDiCJ5/fvZ0r+vt3lMHNUK38Vk7Op03YvYT
         uv76iPUtxJ3XYW+Q0kPOK0DmIEB4nCyBMi8Tdexc+O7Fg5n6oa00guGq/FYDsXQmwN9r
         aGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779193617; x=1779798417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1fL6Lb1MuErNbfNqNLESAR0o0rQvy2NEDm3WS5YbMY=;
        b=bj6jnI0KhdOK6vfanxKkPIHt2wmrhLyxIGTPrcveLyRONANkkEKI6ItFj+0yDvqkqo
         bT9pRuKPoDFmTmPviMmvwZGLZGZaULR9th+4lnoVUgTogPyuuuMIVV0ZOgEik3flYWES
         5BDDzffQE18TrO5/0pU5vmD8fjnjXaSXAOsNmHO8lExCttW7kkkJwEIKSxlC4U0EuhtK
         oQTSDmuvEhT3jv2CONaargW/iiXpYfnrsZxWintQQhW+lrAHaDs8ooO+HEmtmXuEGBxe
         raKga5Okpb9QMYOCVunCSVvypxif6RBep5gJrlxO6Ck8SybUWY+vJlaKFiUUoKU780bm
         7OYw==
X-Forwarded-Encrypted: i=1; AFNElJ9SAKLLHlptVwz9iS5hXaeX0LjvIT5RcbCqdJGWveyq2SELk4u0TzyJzcs8Kz9M+jQC8gXLtvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6u424fXC6hDc9TqEJr9Pow9tMvO30r9ddXaSx7bFFnDdSE0J
	EUYhk4/bfkQHexkxbrQTv9fA2xoFFAnxsZ4DhpyhogtbEUkcor909Wc4
X-Gm-Gg: Acq92OGYjZvT8PX/TCnvTdJfnp3+4XVsBaMYQYUtmQjoaVe3iUr3SkidCzHAvMJ7acb
	TuKTgYgNvl1CpMiIRwAM3xdgJlApH1eTcQmQ7h2xUVToar1I0WDIJal5cEbFdVkAVPWR9Bklcxv
	+nLpyPKcbBSn40M7Ix3SW7d38aEp+xZXZrrzjIrK63LTZGESj/VjNeSd2ygk4cgNTZbWRPyNx1h
	P08SuL2QUmku4NDJc7eO30KhSOuycB1bDuzwVPjPXLmUtDpLI3/I5yxLpyDt4YwavN8I5CzYkqy
	BSbZUtmcQA9XTqQwDNiHzOdiZDD0kBIiZnI9c4FXxLAsd3YIEGSxGZHWOTvoaPgQeHWjj9zJn/Q
	63tPOI+HJfRmpNDjJozeR5/TCOZhPQhUTLmfK96V91mRBAYH9QQ21dyStTQNGhRu5B89vFRuLVJ
	i/8+JFI2r8FCEf6KNtawz1qEbccSkTI5lGu0jJ5FWoRa1+buKmS99Sker0DrA6kpuhh3d3MC5Zk
	muUrKOGkOrINP0ccBKk
X-Received: by 2002:a05:600c:a48:b0:48f:c8d4:487a with SMTP id 5b1f17b1804b1-48fe63138d7mr131610435e9.8.1779193616689;
        Tue, 19 May 2026 05:26:56 -0700 (PDT)
Received: from ?IPV6:2a02:aa16:1105:8100:aca5:18d3:d87:7987? ([2a02:aa16:1105:8100:aca5:18d3:d87:7987])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab7c5sm344268795e9.12.2026.05.19.05.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 05:26:56 -0700 (PDT)
Message-ID: <8f25efa5-bd29-49d5-a260-e0ed0ab9ea75@gmail.com>
Date: Tue, 19 May 2026 14:26:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dev_addr_lists: don't WARN on GFP_ATOMIC
 kmalloc failure in netif_rx_mode_run
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Qingfang Deng <qingfang.deng@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260519095557.3749407-1-yzjaurora@gmail.com>
 <878q9fod8m.fsf@cloudflare.com>
 <d864aff0-d9e9-42c9-87e8-0074dc35e857@gmail.com>
 <ewjfjqocrhwmdoa6mgz3mibtuepp7c3mr5c6zixz26lzfa3g5r@4qfqvbesfv5n>
Content-Language: en-US
From: Zijing yin <yzjaurora@gmail.com>
In-Reply-To: <ewjfjqocrhwmdoa6mgz3mibtuepp7c3mr5c6zixz26lzfa3g5r@4qfqvbesfv5n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289444-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,pastebin.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1255957EC0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks! I will attach it accordingly. 

On 19.05.2026 14:22, Jiayuan Chen wrote:
> On Tue, May 19, 2026 at 02:11:53PM +0800, Zijing yin wrote:
>> Thank you so much for the feedback! I will address these comments in the 
>> next version. This is not found by syzbot by the way.
> 
> There has the a syzbot report now:
> https://syzkaller.appspot.com/bug?extid=f2421634072a4b47071e
> 
>>
>> Hope you have a great day!
>>
>> On 19.05.2026 13:22, Jakub Sitnicki wrote:
>>> On Tue, May 19, 2026 at 02:55 AM -07, Zijing Yin wrote:
>>>> netif_rx_mode_run() fires netdev_WARN() when netif_addr_lists_snapshot()
>>>> returns non-zero. The only path to a non-zero return is -ENOMEM from
>>>> __hw_addr_create() failing its kmalloc(GFP_ATOMIC) -- syzkaller hits it
>>>> via failslab, and it can also be reached under real memory pressure.
>>>>
>>>> This is the only allocator-failure site in this file that WARNs.
>>>> __hw_addr_create() itself, and every other caller of it in this file
>>>> (__hw_addr_add_ex(), dev_uc_add_excl(), dev_uc_add(), dev_mc_add(), ...)
>>>> just propagate the -ENOMEM silently. GFP_ATOMIC is a may-fail allocator;
>>>> callers are required to handle NULL, so a returned -ENOMEM here is an
>>>> expected runtime condition, not an invariant violation.
>>>>
>>>> The miss is self-healing: any subsequent change to dev->uc / dev->mc
>>>> (every dev_{uc,mc}_{add,del}, IFF_PROMISC flip, etc.) calls
>>>> __dev_set_rx_mode() -> netif_rx_mode_queue(), which re-queues the device
>>>> and retries the sync. The only cost of a failed attempt is one stale
>>>> rx-mode window until the next update; nothing in the kernel relies on
>>>> this attempt succeeding.
>>>>
>>>> Demote to net_err_ratelimited() so the condition stays observable in
>>>> dmesg without tripping panic_on_warn.
>>>>
>>>> Reproducer (syzkaller .prog format with setup notes): 
>>>> https://pastebin.com/t7AQKx9v
>>>>
>>>> Fixes: 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work")
>>>> Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
>>>> ---
>>>>  net/core/dev_addr_lists.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
>>>> index d73fcb0c6..c6fdcac74 100644
>>>> --- a/net/core/dev_addr_lists.c
>>>> +++ b/net/core/dev_addr_lists.c
>>>> @@ -1275,7 +1275,8 @@ static void netif_rx_mode_run(struct net_device *dev)
>>>>  		err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
>>>>  						&uc_ref, &mc_ref);
>>>>  		if (err) {
>>>> -			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
>>>> +			net_err_ratelimited("%s: failed to sync uc/mc addresses\n",
>>>> +					    netdev_name(dev));
>>>>  			netif_addr_unlock_bh(dev);
>>>>  			return;
>>>>  		}
>>>
>>> 1) I'd go with net_warn_ratelimited() instead. The promoted message
>>> level in syslog might cause operational pain, and as you say the
>>> condition is self-healing. Seems unwarranted.
>>>
>>> 2) Since it has a Fixes tag, should probably be sumitted for 'net' tree.
>>>
>>> 3) Was this reported by syzbot? If so, there should also be Reported-by
>>> and Closes tags.
>>


