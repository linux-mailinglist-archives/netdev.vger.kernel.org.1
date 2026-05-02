Return-Path: <netdev+bounces-283487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yWsrMyRu9mn5UwIAu9opvQ
	(envelope-from <netdev+bounces-283487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 23:35:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A72B4B3871
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 23:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DE6E300251D
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 21:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D13822B5;
	Sat,  2 May 2026 21:35:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02138836F
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777757726; cv=none; b=DftZR6ha8ZlULhU4yyiquOTlkZgtvd4BRT3KKVNENqGooAqSSrxYAQSimNfT1si4+EcS79yXYdJJhGBOOQspbbyd7pfLvMTAwhHMGSfsbHnGBf5hL3kmHiLAf2sXJe1l5H8Sla+dNz7vWUZSyWukI+03m312ZQAtZ6BH1vbbs78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777757726; c=relaxed/simple;
	bh=PS7eP0ksFCALNNAUSVpPhaFc3/lIjopaBzYEKAyM7Ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YCp2EGF5HutUDiEPpGNk0FPxfSwNyxJjixPlhwhWQxcn8O54me7f7uXAvE5AKw14DeOm72gmp62lnVLE0V/XBKRVd47aHDLG0dQU3ZyVikuQChuNZvWKhjxDrhyCDegzYXD2P+erM3M+2INmh4e9S4/9l00KhRkYsVc4dO8qVbU=
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
Subject: Re: [PATCH net 2/2] net/sched: sch_cake: annotate data-races in
 cake_dump_class_stats (II)
In-Reply-To: <20260430061610.3503483-3-edumazet@google.com>
References: <20260430061610.3503483-1-edumazet@google.com>
 <20260430061610.3503483-3-edumazet@google.com>
Date: Sat, 02 May 2026 23:35:22 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ecjth4v9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2A72B4B3871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.60 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-283487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,toke.dk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Eric Dumazet <edumazet@google.com> writes:

> cake_dump_class_stats() runs without qdisc spinlock being held.
>
> In this second patch, I add READ_ONCE()/WRITE_ONCE() annotations for:
>
> - flow->deficit
> - flow->cvars.dropping
> - flow->cvars.count
> - flow->cvars.p_drop
> - flow->cvars.blue_timer
> - flow->cvars.drop_next
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

