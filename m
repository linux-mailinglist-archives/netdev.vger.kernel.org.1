Return-Path: <netdev+bounces-279563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y8OwBAtR5GkHUAEAu9opvQ
	(envelope-from <netdev+bounces-279563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 05:50:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29742304C
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 05:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0ED63014C19
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 03:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001252FE579;
	Sun, 19 Apr 2026 03:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2cQsXAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792EE3537F2
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776570558; cv=none; b=DpLzW7iK3WxFteIJ7kxJoheHfwPDL5fSs9ln2QwOBn/PJH8hOcBqmk+BSqrRDa/S+RXN4M49PnkigLP2Q+F9bBDmfltSEaCX1yEX80J4QyO4nC1hezWa2d0zEZ87ZvvPjVC/eZe5qbnrxL5ZpbdkDh1yuzenweA7teqQwNqKuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776570558; c=relaxed/simple;
	bh=S12gDRV8UMaFRNrDIoZ7VWm1iDULsSaAoUZ3xWGigxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dic0moc/OEYVVOtziLuz4oEI5yUtPjtc7LaPQgdy8b1TOxhhaLqM0fk9s+6QCCx8xdY1W9J+j2OCp+o023DQX7OZLRvc/CuBMwDpvIivb6Ra+mdJeSu2eHx5ZxE2N9x2SftVQJdQYdYSbwE+uMRHPMFf7V7cmagr8Y3WkvWdGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2cQsXAy; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82f1f6103afso868884b3a.1
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 20:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776570554; x=1777175354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W4t59mV/IsvjAmjNjgwm3dIzEFcuY8Z1WSSbhRgsh4=;
        b=m2cQsXAyMupsTxnumRWJk2keYP0zlrMbWT99iI/KSSD/GL0JvBeIdzn22nxuvh3hD7
         e3aWQfA+XXA5HSKkZFX6/acBKBy1qzunUzo5xCkByUNvcGg5Qf5+AuYDU01TCjP+It/t
         ruTGYEYxDWlycHRlJuKvx+Th5AyoOkqHQ3BimmJtD/TLbmxwINof2PuQSEYAuNkHWVtL
         17W+BXj7pSHhDdYvr2c6599GM6etLSKids+yYsQJwoWdYvlJmCqBi4QTtpC51abMIbwR
         3XBQpxGh5R1y+p9ck/iaTVyjQt0MIbcyPSIE23YpIyoeYLw8cL99RQxWIFQ8jVgGAtDH
         Yk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776570554; x=1777175354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2W4t59mV/IsvjAmjNjgwm3dIzEFcuY8Z1WSSbhRgsh4=;
        b=Po6y32Sg9ph2rdXHy+jiI3dmjnLcH4R3Sa5vDKcuPzuOOmCWPReEpQjjI/MkVkITPj
         VY2ijsDbL9DpmakvQL2TFKg9VX9umSLH7k9ZhVJal4/v9F0FrIIt3ZTR0MSsjqiaK+uq
         WFCqRuxyrwEdpofNl/MJ/qoDtvAfbMhDvMwoxAMdCg4J+GCN+OAIzGdwLLhXsLr+b2Y8
         y32EW+bgTH0HS7mUYXqiLAOkKEDBEDrKJFZO+7LndLw2toZDPSuwLzGu0B7mmIzirW/u
         6fmVaAQ1bMU5I54wytRk02IVZmyNpB9VeEbhgj/0pfBIeMEYHhuqTTSnoDh8BYuDbPOA
         D/HQ==
X-Gm-Message-State: AOJu0Yz2hzNjxprY8cZ62SkS9pDIJn3b7dnxf0kZHhZmx461TWk4pWm8
	WeNqZYPdODz+QXQ5fP0SVTGieIoIm7uOeJEszgbwjUUV3hTSIF+/8+Np
X-Gm-Gg: AeBDievHtccMGoYX1u36R5OSkpB3U6t6Lrr2+md0PqOx4v0Ap/riArcDCWB1QBE2gUr
	Irkt/KHIUYRK6Wd/OlnpDKMnfNFiKDlqGyi8ZPag3GR3R6zVq62x394wBiHTGZztU8ftX7q271r
	rk1XS5Yg6RvFu3KdBzw9oltNNLPXhfTKfprEXugZT3MKV+ykan+NEGhwO1dXo6+NL9fsNgnAmHE
	vFzEsuDdpM5I5PWYV8hstwk6vXfdb2AAljhASUflCaUzhK51woc+MwXq7B4FqdbZofl0Rdi0dbE
	0MS8KlZm3Rb8Aj+NbUxoIJk0i1y1nvRhjDqO3Eiss15UbMjVbZgPp1wcFojraETX8bGbae31B1L
	uX7GEdZNENjXNxCHXOd/PZK4y6eiZ4gqVs7MmFuPSbkA94ykhFEqw7CgKfOXpbVj7fmT5mnLOHK
	G/5WW4gNWLP+Jwdzv0/UqG606ifS5Xdszow2C0Iiwi2E1tlXjzJafIoIv+61E=
X-Received: by 2002:a05:6a00:1956:b0:82a:17b8:1474 with SMTP id d2e1a72fcca58-82f8c82dd9cmr8714155b3a.1.1776570554530;
        Sat, 18 Apr 2026 20:49:14 -0700 (PDT)
Received: from [0.0.0.0] (42-3-10-232.ptr.netvigator.com. [42.3.10.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e984f20sm7014406b3a.8.2026.04.18.20.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 20:49:14 -0700 (PDT)
Message-ID: <6eb15ec6-6994-4b24-9a53-48a653b96860@gmail.com>
Date: Sun, 19 Apr 2026 11:49:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: l3mdev: Ignore non-L3 uppers in
 l3mdev_fib_table_rcu
To: Ido Schimmel <idosch@nvidia.com>, Ao Zhou <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@resnulli.us>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 royenheart@gmail.com
References: <cover.1775062214.git.royenheart@gmail.com>
 <429dd4a81d4ca5624ab9f6d7b53c5fe08552c734.1775443332.git.royenheart@gmail.com>
 <20260406154808.GA714138@shredder>
From: Haoze Xie <royenheart@gmail.com>
In-Reply-To: <20260406154808.GA714138@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,mellanox.com,resnulli.us,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-279563-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royenheart@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F29742304C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/6/2026 11:48 PM, Ido Schimmel wrote:
> On Mon, Apr 06, 2026 at 09:28:16PM +0800, Ao Zhou wrote:
>> From: Haoze Xie <royenheart@gmail.com>
>>
>> l3mdev_fib_table_rcu() assumes that any upper device observed for
>> an IFF_L3MDEV_SLAVE device is an L3 master and dereferences
>> master->l3mdev_ops unconditionally.
>>
>> VRF slave setup sets IFF_L3MDEV_SLAVE before the upper link is fully
>> switched, so readers can transiently observe a non-L3 upper such as a
>> bridge and follow a NULL l3mdev_ops pointer. Require the current upper
>> to still be an L3 master before consulting its FIB table.
>>
>> Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>> Suggested-by: Xin Liu <bird@lzu.edu.cn>
>> Reviewed-by: David Ahern <dsahern@kernel.org>
>> Signed-off-by: Haoze Xie <royenheart@gmail.com>
>> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
>> ---
>> changes in v2:
>> - point Fixes to the VRF slave ordering change identified by David Ahern
>> - add David Ahern's Reviewed-by trailer
>>
>>  net/l3mdev/l3mdev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
>> index 5432a5f2dfc8..b8a3030cb2c4 100644
>> --- a/net/l3mdev/l3mdev.c
>> +++ b/net/l3mdev/l3mdev.c
>> @@ -177,7 +177,7 @@ u32 l3mdev_fib_table_rcu(const struct net_device *dev)
>>  		const struct net_device *master;
>>  
>>  		master = netdev_master_upper_dev_get_rcu(_dev);
>> -		if (master &&
>> +		if (master && netif_is_l3_master(master) &&
>>  		    master->l3mdev_ops->l3mdev_fib_table)
> 
> Don't we have the same problem in l3mdev_l3_rcv() and l3mdev_l3_out()?
> If so, please check if I missed more places and include them in v3.
> 

I checked the same pattern in the other slave-side helpers, and v3 now
extends the fix to both `l3mdev_l3_rcv()` and `l3mdev_l3_out()` in
addition to `l3mdev_fib_table_rcu()`.

All three helpers resolve the current upper with
`netdev_master_upper_dev_get_rcu()` and then use `master->l3mdev_ops`.
So v3 consistently requires the resolved upper to still satisfy
`netif_is_l3_master(master)` before dereferencing `l3mdev_ops`.

> And I think that the part that I was missing earlier is that we don't
> have RCU synchronization in the unslaving path, so an RCU reader can
> either see the original master, NULL or a new master (e.g., bridge
> instead of the original VRF master).
> 
>>  			tb_id = master->l3mdev_ops->l3mdev_fib_table(master);
>>  	}
>> -- 
>> 2.53.0
>>


