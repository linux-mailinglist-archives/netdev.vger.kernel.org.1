Return-Path: <netdev+bounces-305265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TWc9KXJmTGoDkAEAu9opvQ
	(envelope-from <netdev+bounces-305265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 04:37:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 114DB716E03
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 04:37:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="B3gT6S1/";
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305265-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305265-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F39AD301D4D6
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 02:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474743750CF;
	Tue,  7 Jul 2026 02:37:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5DB3750BE
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 02:37:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391856; cv=none; b=JRedRimE8V5vBCrZEK/HAknVK7bp5ps/Gve0y6JY3KNBCTZKCXznFa8ND3RUxXUr/u1v9VPf5s8qZWc+ZpOU65udjQ92XbB+2txE47TE21mLL10PLSAxklEneYY/mOo0riOKUraGmuBGwqIM3I2ENeUGqcw/v2adA6JwERwZ0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391856; c=relaxed/simple;
	bh=uFaDu1M29QjV1NMBRbwwJuAMpePKLdMa7L+bG/15AWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9wHIehqekDoDW63gy9GRRb8yRqTR5zuI1ql/SZpGH3HUEwxPp5gWwzVBAM4heOjGntvsHazhekCzGaVk85RiP6bViEdXZbeG6TFVpf2086jfHRG3YLfjLXe/1rJGtJw4CZv2XpSiOnJC0sYB18sFn6TLw5JdzBU2H1NUN/lD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B3gT6S1/; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=3GHkig73pIhx4aXv7cxivnimg+Vg+quBYDk/2xWgxPk=;
	b=B3gT6S1/SyTZueyfLo1WYPgpLRIrK7Olup1BTG232V3/m1Feu9vh5tnbE5ky93
	6/fbzNJ5zl4Y10sGc6Y1/rvKEdm8YAwMxBkBuv5nQ/Mc9u/2Dqt6EHYNbN5Ogg8V
	C0Q2ZsWj1rnbyz5BHFIz0Uj1x5GiBYwJLYTWiV7FfDsE4=
Received: from [172.21.20.151] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ixszZkxqVBL2Fw--.29608S2;
	Tue, 07 Jul 2026 10:36:37 +0800 (CST)
Message-ID: <dbcfecb3-7b5e-4d53-b4ac-486fded1e192@163.com>
Date: Tue, 7 Jul 2026 10:36:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: skbuff: use net_zcopy_get() instead of
 refcount_inc()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com, kuniyu@google.com
Cc: mhal@rbox.co, bjorn@kernel.org, jiayuan.chen@linux.dev,
 netdev@vger.kernel.org, minhnguyen.080505@gmail.com
References: <20260706100229.13812-1-luyun_611@163.com>
 <willemdebruijn.kernel.250ccf6e7c9be@gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <willemdebruijn.kernel.250ccf6e7c9be@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3ixszZkxqVBL2Fw--.29608S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF18JF4fGr4UGFy8uryUWrg_yoW8Gw1Dpr
	1YkFy0kFs8Gr43AFn2qr4rXr15tws8tFZxGFWS9a43Zr909r9aqFWDGF4Skay7Ar4xKryI
	qr17uayrGF9xXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR573PUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BVUI2pMZjVlGAAA3G
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:mhal@rbox.co,m:bjorn@kernel.org,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:minhnguyen.080505@gmail.com,m:willemdebruijnkernel@gmail.com,m:minhnguyen080505@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-305265-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[luyun_611@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luyun_611@163.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[rbox.co,kernel.org,linux.dev,vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 114DB716E03


在 2026/7/6 21:55, Willem de Bruijn 写道:
> Yun Lu wrote:
>> From: Yun Lu <luyun@kylinos.cn>
>>
>> The net_zcopy_get() increments the uarg->refcnt, which is called both
>> in pskb_carve_inside_header() and pskb_carve_inside_nonlinear().
>> Also use net_zcopy_get() in pskb_expand_head for code consistency.
>>
>> No functional change intended.
>>
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>> ---
>>   net/core/skbuff.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 18dabb4e9cfa..bcf3b2c65fb9 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -2326,7 +2326,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>>   		if (skb_orphan_frags(skb, gfp_mask))
>>   			goto nofrags;
>>   		if (skb_zcopy(skb))
>> -			refcount_inc(&skb_uarg(skb)->refcnt);
>> +			net_zcopy_get(skb_zcopy(skb));
> This adds some unnecessary instructions in skb_zcopy.
>
> It's not terrible and I see the consistency argument. But would make
> more sense to update the recently added pskb_carve_.. variants instead.

Thanks for your review.

The skb_zcopy() does indeed make repeated checks. So following your 
suggestion,

I have modified the code as follows:

-                       net_zcopy_get(skb_zcopy(skb));
+                       net_zcopy_get(skb_uarg(skb));

Does it seem more reasonable?

And I plan to modify all three functions in patch version 2.



