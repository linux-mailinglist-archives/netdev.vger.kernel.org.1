Return-Path: <netdev+bounces-280736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIUDJoQN6mn4sgIAu9opvQ
	(envelope-from <netdev+bounces-280736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:16:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB340451D82
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B02C53077698
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47D13EBF16;
	Thu, 23 Apr 2026 12:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5CC2FD7BC
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946241; cv=none; b=gs889hjZFlNISXteLVjoN92E3fNHSy5loaxQq2C2huWv6fEj8Wck28hrq/DuhlGUHa8pbmj9jBxqzUqMcMtyL1pUAT1e1/eAiuzsTiFfJXckXF2ZXEgf8XfiBDqCL2BHw5TydGyolSms2sHp0U1Xl2upO6Mau4hCwfogYLNw61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946241; c=relaxed/simple;
	bh=20LCn011KeloyfGzR0WiIIJsqkeH7IkA13ix9/kv4sc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TBDxDHViLyEk2PR9ygWqMaqDg/nZXkx8FTuY81X7ITSZR95ZublWZGYDmKG0CS/7a/YLMLlkkbs4R5fDIzSoYUOFnXMq1VxG5rmiUX7MVNTjp+n4Zf0yeJCsjNS2bAKJwQ/ZNx8/GNyoWIxjsBiBdG/zAPt7nDqZ8/YMxveD/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 2/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (II)
In-Reply-To: <20260423102324.3172448-3-edumazet@google.com>
References: <20260423102324.3172448-1-edumazet@google.com>
 <20260423102324.3172448-3-edumazet@google.com>
Date: Thu, 23 Apr 2026 14:10:38 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877bpxyj0h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [2.60 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-280736-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:server fail];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB340451D82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Eric Dumazet <edumazet@google.com> writes:

> cake_dump_stats() runs without qdisc spinlock being held.
>
> In this second patch, I add READ_ONCE()/WRITE_ONCE() annotations
> for the following fields:
>
> - bulk_flow_count
> - unresponsive_flow_count
> - max_skblen
> - flow_quantum
>
> Other annotations are added in following patches, to ease code review.
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

