Return-Path: <netdev+bounces-294690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Yv4HWrsH2rWsQAAu9opvQ
	(envelope-from <netdev+bounces-294690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:57:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0393635E8D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:57:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=WKo0LZKi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294690-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294690-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6E2F30E4E2A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85385421A1C;
	Wed,  3 Jun 2026 08:54:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B74423A6B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:54:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476884; cv=none; b=PYvXZaUl9XTiTVEX6RnWuYV8EkJXoD03XQJrm0CKBAFD3nBAFCGOt9kxod0OxSAgrV48SlyXYRAGBna+i1bfTIzx0p8l6yAGmvHqCyPl2b95CDyNfhNEG5FEm7yQsSE2UKQpUQQBtt8qUFoG90To6+TigF7Wagm9UYoHnSlJ15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476884; c=relaxed/simple;
	bh=rRGg//Y4nDsQNy1FHaP+pR67XmCWoxS8P2u7l41taE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsFWMeURRKMyhiYHZDQksPtgXxjzEqbEKAXYTNOaDjOtANyoB0iZH7tmjqC/MeetDT4mLGO9whlm9GaAHMwgce1DI4PCt3aFTTJVveWAS7keUyn40cHiNjIVQNKhUSY6D/ycHi3r/6fgK+UGTCrA2x6S7AOiVvlcOR4dThQnlyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WKo0LZKi; arc=none smtp.client-ip=91.218.175.177
Message-ID: <df784239-b995-47d0-8cc2-c6c8e01182de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780476879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nEt0ZnblfZVUOOxbnF3behQcy+9xXOn6KT8LbzXD30=;
	b=WKo0LZKiRqDuTCbIM/wzF1bXcZAqnnILnOg4XhNBDPglVs8TNIDTZk9ixjDq8EzZUbbwJh
	KRKc0s8/iIEo1vJ6x5Hl0FUsbdwYbyFEL7DSUK85zoLte+Zkf9ux5kT56UhLcipu2LKuEc
	5lg2LZL0mJjih+10smRnPzLuvWF+myg=
Date: Wed, 3 Jun 2026 16:54:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] flow_dissector: fix uninit-value in __skb_flow_dissect()
 for ETH_ADDRS
To: Eric Dumazet <edumazet@google.com>, "Zhou, Yun" <yun.zhou@windriver.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260603030810.3593625-1-yun.zhou@windriver.com>
 <CANn89iL2OnKcFOV7hHON=70670bC9vsUXBFm3nADU89qgepVfA@mail.gmail.com>
 <2fe4890d-842b-4595-b0db-6859579ca6ef@windriver.com>
 <CANn89iJhZTztRYSoNsUhN0y2UUucm5g5=jHAWKqN1wLOpeJoMA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iJhZTztRYSoNsUhN0y2UUucm5g5=jHAWKqN1wLOpeJoMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:yun.zhou@windriver.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0393635E8D


On 6/3/26 4:33 PM, Eric Dumazet wrote:
> On Wed, Jun 3, 2026 at 1:16 AM Zhou, Yun <yun.zhou@windriver.com> wrote:
>>
>>
>> On 6/3/26 13:44, Eric Dumazet wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Tue, Jun 2, 2026 at 8:08 PM Yun Zhou <yun.zhou@windriver.com> wrote:
>>> Please add a Closes: tag
>> I will add a Closes link in v2.
>> Closes: https://syzkaller.appspot.com/bug?extid=fa2f5b1fb06147be5e16
>>> I found some not relevant syzbot report :
>>>
>>> https://lore.kernel.org/netdev/6a196faf.c16d89a8.217f2c.0002.GAE@google.com/
>> This should be the same issue. And it can be reproduced by
>> https://syzkaller.appspot.com/text?tag=ReproC&x=12924152580000
> Please investigate which device allowed to send an Ethernet packet
> smaller than the ethernet header.
>
> We do not want to add tests all over the places, we should fix the origin.
>
> Look for dev->min_header_len
>
> Thanks.


It's TUN.

I think we should reject loading "tc filter ... flower eth_dst 
aa:bb:cc:dd:ee:ff ... " if dev->hard_header_len < 
sizeof(flow_dissector_key_eth_addrs)


