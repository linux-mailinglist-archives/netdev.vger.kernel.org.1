Return-Path: <netdev+bounces-287114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CW8FSQZA2p10QEAu9opvQ
	(envelope-from <netdev+bounces-287114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:12:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C056051FD81
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB1453015A5E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B53655CA;
	Tue, 12 May 2026 12:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000B23655C2
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587864; cv=none; b=jrX+LJ8giu5xL0EOL6Ucb7m0CzToRDdJ3rY5OLJw0QGRDjtbC8YtkrsPBRtqKrpvEt3e+xhDCyhPk/f6AbmuO+ekS66w3hwPD2Qif2JnnqndTiRSCRyoz9duN6+JyuQgk/9M4BjjoP9Bqb7TC3RlwLLjkLUF2Ewi0K3pCpRFE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587864; c=relaxed/simple;
	bh=VmPZKy3SeR06tX78WhRK4mTTooT8QOFyD0AleVuwmEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tSGvb6TKSw8stVYRpipV7/8roaW1GmzSQH1Ig1v7Dzjze7BUNdCi8CZ+Y+nHxIH1oe/QZx6TS2OFpco9+uy7REw/PiebgWK+uhp8U0fqsM8KpjS/YZpkh+JgciaAypEdWoh6D/jR21MGxgl1QurQs/gssIazuBFxNZjt4meDeVM=
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
Subject: Re: [PATCH net-next 2/2] net/sched: fq_codel: local packets no
 longer count against memory limit
In-Reply-To: <20260512094859.3673997-3-edumazet@google.com>
References: <20260512094859.3673997-1-edumazet@google.com>
 <20260512094859.3673997-3-edumazet@google.com>
Date: Tue, 12 May 2026 14:11:00 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o6ikygiz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C056051FD81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-287114-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.232];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toke.dk:mid]
X-Rspamd-Action: no action

Eric Dumazet <edumazet@google.com> writes:

> Commit 95b58430abe7 ("fq_codel: add memory limitation per queue")
> claimed that the 32Mb default was "reasonable even for heavy duty usages."
>
> In practice, this is not the case.

Well, the assumption lasted a decade, so that's pretty good? :)

> Packets that are associated with local sockets sk_wmem_alloc
> do not really need additional memory control.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_fq_codel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index 1b1de693d4c64a1f5f4e9e788371829dea91740e..71107dc52be799a14f370f2ad74d2eadd93992c1 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -212,7 +212,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		q->new_flow_count++;
>  		WRITE_ONCE(flow->deficit, q->quantum);
>  	}
> -	get_codel_cb(skb)->mem_usage = skb->truesize;
> +	get_codel_cb(skb)->mem_usage = is_skb_wmem(skb) ? 0 : skb->truesize;
>  	q->memory_usage += get_codel_cb(skb)->mem_usage;

Only one concern here: q->memory_usage is exposed to userspace in the
stats, so this will look like the packets queued are zero-length to
anyone watching, which may end up confusing folks? Also, there will be
no way to see how many bytes are actually in the qdisc.

Should we keep a separate counter so we can still accurately report the
memory usage to userspace?

-Toke

