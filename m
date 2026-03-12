Return-Path: <netdev+bounces-267021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPyaLqCdsmndOAAAu9opvQ
	(envelope-from <netdev+bounces-267021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:04:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A5027090F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F793019197
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810F437D101;
	Thu, 12 Mar 2026 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQPZrlpj"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA4388E6D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313395; cv=none; b=p7/s5DfoP/B4woBcuLITi7fYOwji+jw8naiijA6Qg1wLY4EcqOZ0JHjAo8JvKAzwc+Zte0RiT6IfumeA6I4ehyip6G3Sn+ubvG0QULZoa//rn4gK+osfQeo/TtLZGVh5i8iOxAKB0T9Jy1KaUQ+nUcDwp1dfSg+GMIHdKokUdfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313395; c=relaxed/simple;
	bh=UUcVOa1ml4IT+so9c26zVBxSFJGrrX8ZlFFVzqIzMhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XP8Edsz4dYFdMefDG4TVhDs0OVijooNPw9XOuuqdZJX/h3Qq8Obkj4rWJAB5FNv6v039NEaOo0CC12FLk/k6uvdGGz9aoCiI7JxV//0IDUvRWoMPxgftEJa41TETbFOJPzjj2IqLH9mEb2XbBlOYiykBMsR+FZarh9SNY8C3OPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQPZrlpj; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c72ba406-fc16-4ce0-b75f-3105b64caef6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773313381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPLcfrBtEHAjQV2Y8IMtDKf+S0m+yy6x4yuZ7BKmpaY=;
	b=MQPZrlpjRE7zwrBemW4uWnbZiEPqn9io2xefqJYQGvMgGYmiDOrmK1+Xbv/A0BYUWeBeJg
	2oUnloLGfTplCIO/4S8qdKkoKXQypa6nmFfabbWmt9jwZtATSD17Qzzj7eiKY3m72aajVF
	CbZzhwX+inukupwFR9KLISoKfqPJEhk=
Date: Thu, 12 Mar 2026 19:02:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
To: Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Eric Dumazet <edumazet@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin>
 <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
 <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
 <abARG4sHFdUNqcRV@penguin> <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267021-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,google.com,goodmis.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linux.dev:dkim,linux.dev:mid,blackwall.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 22A5027090F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/12/26 6:36 PM, Paolo Abeni wrote:
> On 3/10/26 1:39 PM, Nikolay Aleksandrov wrote:
>> On Tue, Mar 10, 2026 at 01:07:15PM +0100, Eric Dumazet wrote:
>>> On Tue, Mar 10, 2026 at 1:00 PM Eric Dumazet <edumazet@google.com> wrote:
>>>> On Tue, Mar 10, 2026 at 12:49 PM Nikolay Aleksandrov
>>>> <razor@blackwall.org> wrote:
>>>>> On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
>>>>>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>>>>>
>>>>>> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
>>>>>> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
>>>>>> when the bond mode is round-robin. If the bond device was never brought
>>>>>> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
>>>>>>
>>>>>> The XDP redirect path can reach this code even when the bond is not up:
>>>>>> bpf_master_redirect_enabled_key is a global static key, so when any bond
>>>>>> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
>>>>>> interception is enabled for all bond slaves system-wide. This allows the
>>>>>> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
>>>>>> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
>>>>>> reached on a bond that was never opened.
>>>>>>
>>>>>> Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
>>>>>> before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
>>>>>> never opened), fall back to get_random_u32() for slave selection. The
>>>>>> allocation in bond_open() is kept, with WRITE_ONCE() added to safely
>>>>>> publish the pointer to the XDP read side. A plain read suffices for the
>>>>>> !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
>>>>>> under RTNL lock and is the only writer of rr_tx_counter.
>>>>>>
>>>>>> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
>>>>>> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
>>>>>> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
>>>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>>>>>> ---
>>>>>>   drivers/net/bonding/bond_main.c | 9 +++++++--
>>>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>
>>>>> This is Jay's patch + the unlikely change, looks good to me.
>>>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>>>> Orthogonal to this patch  :
>>>>
>>>>   get_random_u32() typical cost is around 10 to 20 ns, I really wonder
>>>> if this makes sense
>>>> for the packets_per_slave == 0 or 1 case to haves this kind of
>>>> randomness in the first place.
>>>>
>>>> Perhaps we could use a
>>>>
>>>> static DEFINE_PER_CPU(u32, rr_tx_counter)
>>>>
>>>> And :
>>>>   slave_id = this_cpu_inc_return(rr_tx_counter);
>>> I also have mixed feelings about this patch.
>>>
>>> We probably should detect that the device is not ready before hitting
>>> something deeper in the stack.
>>>
>>> Sure, a NULL deref is avoided, bu what happens next ?
>>>
>>> We send a packet while the device is not UP, I am pretty sure this
>>> violates at least some RCU rules in device dismantling.
>> IIRC when the redirect continues, the packet should get dropped if the device is
>> not up (checks at a few places), but that's outside of bond's jurisdiction and
>> after the slave id is needed in xdp master redirect's path unfortunately.
>> I'm not sure it can reach much further, it just has the master dev's slave id
>> generation in its path.
>>
>> In any case we shouldn't crash in the slave id generation in the bonding,
>> that ndo's only job is to return a slave id.
> I'm sorry for the back and forth, but I share Eric's concern. I think
> the approach suggested by Daniel:
>
> https://lore.kernel.org/netdev/4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net/
>
> or the initial patch form:
>
> https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#m7c67bb12f85bc88d583788fb6e41113c46208ae7
>
> would be better. To respond to old concerns raised there: the check is
> IMHO bond-specific, as control moves from the lower interface to the
> upper bonding device, and the code is under an RCU critical section, the
> device can't go away before the xmit is completed.
>
> /P


Looking at this issue holistically:


1. The XDP layer fix addresses the root cause of the current issue

2. Adding a defensive null check in bond_rr_gen_slave_id() protects
    against buggy callers - whether from XDP or future code paths. This
    aligns with the defense-in-depth principle that Nikolay and Sebastian
    highlighted.

Could we include both in v1? This way, the bond layer is robust regardless

of who calls it, preventing similar crashes from other potential code paths.


Thanks


