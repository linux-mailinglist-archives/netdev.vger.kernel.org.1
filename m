Return-Path: <netdev+bounces-280734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGYGLC8N6mn4sgIAu9opvQ
	(envelope-from <netdev+bounces-280734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:14:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B31451D2F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9897E3007ADF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC623EB7F1;
	Thu, 23 Apr 2026 12:08:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298162BE026
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946106; cv=none; b=aP5GxccjgtBLmuzkD1/ZJrd1052Ks+890PON0+098GYNgicPhl1f8h0MdAaJTSHzMsHI1e9poKYST9KIpguZvvmOtMzplBYpELeTZbrWIL0WpD8w6vyHyLPRLoQQAx2rwcD5furt/6Fy7imBgZ6tcGfL69x1yx0qC+cflSVLKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946106; c=relaxed/simple;
	bh=9Amh17detrVqvzU7RxH1v/MIpeUMgRuJt11KfZMbzag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eSD4Z9VIHj8ui79DEC++KReuWkoWhVQsSkm295ibrbTakpka2HNwgggDuN+W+Y7ZckgWvc1kIHglnLf/be0jSLs/C9SUI4INldum8qKC/slUcP57TI77zl5PZgO2Fg16FhGvkbbjuuvQajMmuAOejsc0ZUKYCEr2axVhh+uTdcQ=
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
Subject: Re: [PATCH net 1/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (I)
In-Reply-To: <20260423102324.3172448-2-edumazet@google.com>
References: <20260423102324.3172448-1-edumazet@google.com>
 <20260423102324.3172448-2-edumazet@google.com>
Date: Thu, 23 Apr 2026 14:08:20 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87bjf9yj4b.fsf@toke.dk>
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
	TAGGED_FROM(0.00)[bounces-280734-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49B31451D2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Eric Dumazet <edumazet@google.com> writes:

> cake_dump_stats() runs without qdisc spinlock being held.
>
> In this first patch, I add READ_ONCE()/WRITE_ONCE() annotations
> for the following fields:
>
> - way_hits
> - way_misses
> - way_collisions
> - sparse_flow_count
> - decaying_flow_count
>
> Other annotations are added in following patches, to ease code review.
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>


