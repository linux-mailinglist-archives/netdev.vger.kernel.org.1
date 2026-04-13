Return-Path: <netdev+bounces-278104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE6/I3AA3Wk3YwkAu9opvQ
	(envelope-from <netdev+bounces-278104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:40:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D70B3ED64A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E200C3009381
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0705D3D7D89;
	Mon, 13 Apr 2026 14:40:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758C383C69
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091237; cv=none; b=sCKLMwdPcRdyO/ycMS+WORPIUHUDaZ4M6yNEdvtdCJMOOT9eBzzAVn2gegWQHmeg5yexWtcAWbe3ejb/f2BN4YDmYiiwufCJn1wRMSI8Bbvo8866d/nJZaAokzAJPf5SM00n/0j/YkIXor3otRzkpY5m4oYS2TibPhucdAQwQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091237; c=relaxed/simple;
	bh=ErP/oX1jbT2LjxfaWFU2kJlf23o4t2KHnSim5IV55ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JdSFvUxL9THg2GbpxDgFWMmBkTAT+198J6WuEGu/JGrZAAmwp6jtOEalmoLCEfHN0pk60TFyEoqf58fO5yxRlyKu3yW6xa2YuoAQHL47jQ34aNObUnK0zPeWHZuMlFSAJRUZMbZmprkmPAm8uvwb8LtTU4Ebh0DzQntOpHM1WH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Dudu Lu <phx0fer@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, Dudu Lu <phx0fer@gmail.com>
Subject: Re: [PATCH v2] net/sched: sch_cake: fix NAT destination port not
 being updated in cake_update_flowkeys
In-Reply-To: <20260413110041.44704-1-phx0fer@gmail.com>
References: <20260413110041.44704-1-phx0fer@gmail.com>
Date: Mon, 13 Apr 2026 16:40:31 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87eckidiu8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [1.07 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278104-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,toke.dk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D70B3ED64A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dudu Lu <phx0fer@gmail.com> writes:

> cake_update_flowkeys() is supposed to update the flow dissector keys
> with the NAT-translated addresses and ports from conntrack, so that
> CAKE's per-flow fairness correctly identifies post-NAT flows as
> belonging to the same connection.
>
> For the source port, this works correctly:
>     keys->ports.src =3D port;
>
> But for the destination port, the assignment is reversed:
>     port =3D keys->ports.dst;
>
> This means the NAT destination port is never updated in the flow keys.
> As a result, when multiple connections are NATed to the same destination,
> CAKE treats them as separate flows because the original (pre-NAT)
> destination ports differ. This breaks CAKE's NAT-aware flow isolation
> when using the "nat" mode.
>
> The bug was introduced in commit b0c19ed6088a ("sch_cake: Take advantage
> of skb->hash where appropriate") which refactored the original direct
> assignment into a compare-and-conditionally-update pattern, but wrote
> the destination port update backwards.
>
> Fix by reversing the assignment direction to match the source port
> pattern.
>
> Fixes: b0c19ed6088a ("sch_cake: Take advantage of skb->hash where appropr=
iate")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>

Thank you for the fix!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

