Return-Path: <netdev+bounces-299403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qlQlG2/gL2pbIQUAu9opvQ
	(envelope-from <netdev+bounces-299403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:22:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1945685B1D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:22:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=toke.dk (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299403-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299403-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21968304EBBF
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23BA3E4519;
	Mon, 15 Jun 2026 11:21:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B613E44F6;
	Mon, 15 Jun 2026 11:21:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522489; cv=none; b=anbEELIpi1WxWONvr4eUebuiS+J/T6t+2HK5ZX3vFIyxGqgx6jSX24B+s3p2vl3omoP9m99yKnBPGY5bcEYLSyFHGLD8zQ7LCPUQxB4Eu5P7WE6JU7gJxwqiWxhwW49VRuu+gUkGracwbKONLjjZCBvWcSPshylP67Nm2BHBJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522489; c=relaxed/simple;
	bh=eEo+7lV/KNOEviIFhDhv4I6Js9iYIGQ1LsUHg0MJPpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kx8NKKMaZgpKCPv3Gi7lyoJj+qfi5AXt1Iib+9fcAfOriACZc1bdKo3mZ1tPlpPA9ETaED/GDOi7q+VZqDCXH5EsFnpunS/fJ7nXypk5S84CZPSDghQqknj28t1qZ546JRQorVKVJ+J7KjtTWjCkf3dcNH3XFJCQIcHwu1J0pqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jakub Kicinski <kuba@kernel.org>, Samuel Moelius
 <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, "moderated list:CAKE QDISC"
 <cake@lists.bufferbloat.net>, "open list:TC subsystem"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net/sched: cake: reject overhead values that
 underflow length
In-Reply-To: <20260613142626.1b2183eb@kernel.org>
References: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
 <20260613142626.1b2183eb@kernel.org>
Date: Mon, 15 Jun 2026 13:21:12 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wlw0gic7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.27 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[toke.dk : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299403-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORGED_SENDER(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,45.145.95.4:received];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,toke.dk:mid,toke.dk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1945685B1D

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue,  9 Jun 2026 23:29:36 +0000 Samuel Moelius wrote:
>> +static const struct netlink_range_validation_signed cake_overhead_range = {
>> +	.min = -64,
>> +	.max = 256,
>
> Both Sashiko's complain - these values are neither safe nor sufficient.
>
> How was the -64 chosen? It looks suspiciously close the min ethernet
> frame length. But in that case (a) FCS doesn't count so 60, and 
> (b) even IPv4 TCP packets can be shorter (at qdisc layer) than 64B
> leading to underflow...
>
> I see min rate in cake is 64 but I don't see any other meaning of the
> 64 literal.
>
> Toke, WDYT? Should we use a smaller constant (ETH_HLEN?) or do the
> check on the datapath?

Hmm, we do actually have a check on the datapath already, so just
amending that like the second Sashiko suggestion should add no
additional runtime overhead. In which case there's no reason to add the
policy at all, I suppose.

So basically:

diff --git i/net/sched/sch_cake.c w/net/sched/sch_cake.c
index a3c185505afc..259e4b8d09c5 100644
--- i/net/sched/sch_cake.c
+++ w/net/sched/sch_cake.c
@@ -1389,10 +1389,7 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
        if (qd->min_netlen > len)
                WRITE_ONCE(qd->min_netlen, len);
 
-       len += q->rate_overhead;
-
-       if (len < q->rate_mpu)
-               len = q->rate_mpu;
+       len = max((s32)len + q->rate_overhead, (s32)q->rate_mpu);
 
        if (q->atm_mode == CAKE_ATM_ATM) {
                len += 47;

(Sashiko suggests using max_t, but that seems a bit redundant when
there's already casts in the operands, no?)

-Toke

