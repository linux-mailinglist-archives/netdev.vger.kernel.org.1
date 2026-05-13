Return-Path: <netdev+bounces-287514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI6CDcxNBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:09:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA43353127F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F26143043D4D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E838D018;
	Wed, 13 May 2026 10:08:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251E38F951
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666936; cv=none; b=P+QcPul/QcXKAZENyJKlb8gllJraCuxPY1VWEt3q5BIsleOqQ45yj+wS8YSWwulV4kxsLMqTJ+FQXrfGc+9yS/BSgaQc8ryhBnfYSS+N9DmnqQhFre6CATLGyhPbkiL/JAq7FzO1S5IEiVp5O2/N4oXfZxGHjqLydrWS6M27kNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666936; c=relaxed/simple;
	bh=eWJ8n/QLajUYFkBpkYxWY7XF8XCyaH6+HWQ9C505Nqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=to9suXMEnyB1/T3bAVsNInFqlsS6RXjV0rKoFlm8C/jd89Oj0E4E69jWjo2EEEj+c31k80URV5Om0CVbzaJTZw1TMw/mDDsV3CiDDZOVJxAwERkHCfxSg+gK07gGtHHFAK8uh3cXFQsYMiZd9T0xfjqr2jq8pJ5MyUhbOrkB3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Ido
 Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next 0/3] net/sched: changes around
 qdisc_qstats_qlen_backlog()
In-Reply-To: <20260513080853.1383975-1-edumazet@google.com>
References: <20260513080853.1383975-1-edumazet@google.com>
Date: Wed, 13 May 2026 12:08:46 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875x4ry635.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BA43353127F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.71 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,nvidia.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Eric Dumazet <edumazet@google.com> writes:

> First patch makes clear qdisc_qstats_qlen_backlog() runs locklessly.
>
> Second patch changes ioam6 to not acquire qdisc spinlock anymore.
>
> Third pach adds missing READ_ONCE()/WRITE_ONCE() annotations in hfsc.
>
> htb still needs fixes, I will take care of them separately.
>
> Eric Dumazet (3):
>   net/sched: qdisc_qstats_qlen_backlog() runs locklessly
>   net: ioam6: no longer acquire qdisc spinlock while calling
>     qdisc_qstats_qlen_backlog()
>   net/sched: sch_hfsc: annotate data-races in hfsc_dump_class_stats()
>
>  include/net/sch_generic.h |  6 +++---
>  net/ipv6/ioam6.c          |  4 +---
>  net/sched/sch_hfsc.c      | 22 +++++++++++-----------
>  3 files changed, 15 insertions(+), 17 deletions(-)

For the series:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

