Return-Path: <netdev+bounces-279562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id N6JvCBJQ5GnOTwEAu9opvQ
	(envelope-from <netdev+bounces-279562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 05:46:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2B2423040
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 05:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9689430210FF
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 03:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F9372ED0;
	Sun, 19 Apr 2026 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZM9S5Po"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE3372B41
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776570381; cv=none; b=AZdov9rfjTqDgBbG0FKFodv2qD642frB4vfKL9gwqzJ/Haca3c54eScyGK4IhSnM9DBk9ZMC6zZMus9RIMusrSzuKLBrmDR8YBNvvFFp7mMR/UGqLssGK5BUWSIZMCs6kawSMRdm6EPTg3inHZADda2QmYX8AYkkHc0rH/G2QF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776570381; c=relaxed/simple;
	bh=AWL1fvfjcSfDXTDcsIcbh6SF1T09ZTxxPQ3G2vXow8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQDDt3OdjRQ7+WXttnVFblJ4Cl7mDYgD7itIHsrGIeAkoAhviP3y9HfnHpQk9gEvxnEyBmyqR9aeB3rxHdqx515YNGWdjka4VR+SJoN8fW6ywW3Lm/W0v/7MK3LPzgphqQEQY8Z6giJG6I6/lCoEybw7+j8OF0bhlmWEbbHYya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZM9S5Po; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so1251138a91.1
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776570374; x=1777175174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGR/VQpFdx50JUYfm8+y0GVH27nS6VLuCc7LT9tghPA=;
        b=pZM9S5Poub+oZX+f0ia5+ow4PddGoRADw1JvYQqvVYrvXZFvK90F1eCN1LfkQt4DXl
         yurLtJ4GIfw7qwQMiEgR30gFdLMXZj2xxu6iZDUhehUyzd9nNl5YL0zUjaCXFcZLo5vv
         OBD7eqehs1rxL/d+1sZR9r7Avt5wVO8KgKjTm4BuuslXxBriseb0I2HqQq1qN9BRU+lC
         NAnPk+MfPB7IVBLKpGwSwLJRfR5e3jjxFTwq+/dj9YnUhBmxtQEiNLMS77J/WaCiwI5v
         36nB9TlfDUmc1dyT1M9ymMsXoEfiKp1gaRfx/o1Q6z/lNts1xaEupH7dR5VNj1tNKnr2
         PYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776570374; x=1777175174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGR/VQpFdx50JUYfm8+y0GVH27nS6VLuCc7LT9tghPA=;
        b=mts1Qv9isJWCk2X4FkYZubYAOC+wY2LEcKI6woTOUOIN3gmi1QDmxKIcYsZVmMBh1U
         wmleWArfgDpHsavfe11GNzsYyKLCaB46t5bwNGxOC7/809Th3omB1NAp5/7s5uEyQmJX
         bmeTubWHIK7dqRGKHn5gSOZPjiF6KfTlcWXezk7fMfZ5XAvqfj4MxMaCCAMm8XOPaU6M
         ygYZOioEiD8cdVYB/uKERIVOLEIO86j22MgjQTg/SFvcdmNg/v6egn7gcISR2G+OKCHq
         JBhJTFYJ1dKjyGFRCldHo22W/F8EjUiur1S0FFLOsmb6rqJOQSOvqPFHLAm4BxmhZoXJ
         p2YQ==
X-Gm-Message-State: AOJu0Yxhh8y8tPSdgbGJBbR+nn8+JEXJLWc8Z8NKCz2x6zEv72r9XiGW
	UT8/JeDeZ4nYHK5r67WJy1nONpjbUuUTXGHX8+VMtgzTPxR0jSaRtRzR
X-Gm-Gg: AeBDieuGXMf7hzFf9Pw8nVZMlcrKmZuPFMtIbi/cY+Xr04175tFyr9XnIGaXuEFQ5tt
	eoPV1vbMD4GsCE5pyou3RAbHDEw7euSfzdG6UrSdlHHT4PksE9KCIKPlUk94lfME/4/Dheil+z7
	gd7CtOgWIA99FXu8XArsyyS8XR3RWhrrshEyWYFv5LOlHI+GpsBauJunVQ9Jb5xx3gQUp28N9gi
	6zMn0+2q5z2v1ChY6z8beAbBWyghbLsec1D7X211aLdSPwb2EmX3ru4wbMBlKAalJpWO2DI4fw1
	a37tQuLuBkFb/Fdb/I9DTrgJAIfSaGT7zvzdxUNr5JwiwJon18RsMrqGJMchGsXmfk6Sg0TT3h+
	JVDQ+17k3SM2Lej5yrKFbfVQ9KSnZvoDbYdG0Wm1P+pxiw+Laih8m3aXs7D6JHXELTbhnSZl2sq
	i0K3NfY+FXIQ9567eXdm85KM3iQJHFwIA=
X-Received: by 2002:a17:90b:5845:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-36140473f70mr8894181a91.14.1776570374395;
        Sat, 18 Apr 2026 20:46:14 -0700 (PDT)
Received: from [0.0.0.0] ([64.118.129.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f370sm4914463a12.7.2026.04.18.20.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 20:46:14 -0700 (PDT)
Message-ID: <4313b696-1f01-4017-ab9f-54514ce70a82@gmail.com>
Date: Sun, 19 Apr 2026 11:45:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: l3mdev: Ignore non-L3 uppers in
 l3mdev_fib_table_rcu
To: Ido Schimmel <idosch@nvidia.com>, Ao Zhou <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>
References: <cover.1775062214.git.royenheart@gmail.com>
 <b3b88cddc7e79d4b43756b26ae5db965678f3ba9.1775062214.git.royenheart@gmail.com>
 <20260406103350.GA654671@shredder>
From: Haoze Xie <royenheart@gmail.com>
In-Reply-To: <20260406103350.GA654671@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royenheart@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4E2B2423040
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/6/2026 6:33 PM, Ido Schimmel wrote:
> On Sat, Apr 04, 2026 at 07:52:03PM +0800, Ao Zhou wrote:
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
> 
> Do you have a reproducer? I don't see how that can happen.
> 
> do_set_master() ensures that the device doesn't have a master when
> ndo_add_slave() is called. Meaning, if netif_is_l3_slave() is true and
> netdev_master_upper_dev_get_rcu() resolved a master device, it's
> guaranteed to be a VRF.
> 

I agree that this is correct in the synchronous `do_set_master()`
control flow.

My concern is narrower: an RCU reader can still resolve a stale upper
after the unlink, so `netif_is_l3_slave(dev)` alone is not enough to
prove that the resolved upper is still an L3 master at the point where
`master->l3mdev_ops` is dereferenced.

>>
>> Fixes: fee6d4c777a1 ("net: Add netif_is_l3_slave")
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>> Suggested-by: Xin Liu <bird@lzu.edu.cn>
>> Signed-off-by: Haoze Xie <royenheart@gmail.com>
>> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
>> ---
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
>>  			tb_id = master->l3mdev_ops->l3mdev_fib_table(master);
>>  	}
>> --
>> 2.53.0
>>


