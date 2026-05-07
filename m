Return-Path: <netdev+bounces-285094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KD0M57m+2kaHwAAu9opvQ
	(envelope-from <netdev+bounces-285094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:10:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 437C34E1D18
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 070ED301B15B
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C997204F8B;
	Thu,  7 May 2026 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFb/L5DZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0B1E1C11
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116249; cv=none; b=qCBhvDVXT1pGWM5s8oEbWLdnK4QcsClUnRFyvrtUhufe75YiDufgGURaH6kiC5iN3R09gjSV7GJBfCHgBdjV4tn0T851vZY9DTWKSEDy+oc5EBsY4ENaUKufbm2kpx1fdoZHH68JqqMrTgfzm2W580qLJvbD9pcK9egc/kmAk3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116249; c=relaxed/simple;
	bh=qW0e4pJitM8lt/mPXTrcPekS8gy0H5EdYkRLpdPHjmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOkV2RCyLV15nvtU+2Nr8to6eP0lwwracpHakELRT8c8ZliCcaAekeU9hrc4sUt+LeASIOrgwKd+l0irKMGMCR0de1+OLeWUJ06ySmYXqfYcDSg/S3QDu59GmAUoW5hVmPfYPD12fv/TVxb2lJk2/b9fIZSuRbtwZCwymeTQ07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFb/L5DZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAC4C2BCB0;
	Thu,  7 May 2026 01:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778116249;
	bh=qW0e4pJitM8lt/mPXTrcPekS8gy0H5EdYkRLpdPHjmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pFb/L5DZXYFqzhB3mDXV27GZ2VWp5xeLI1EYXkH7Klh2otoGN5+jDqbFJGXxSMZDA
	 /rN+zEj1IWNUdm4WUEtgyzd/Y8ItvZZz/qtnMWrlUqSU0MdwsKCfXW3glM9yCH4JM/
	 fKVOzFt48Gt9/pX7s/MjHN4DFq3JDNjFYjvE1PYRAKYhHWOfnx/sQsUG6womSZMmaP
	 yNH1yv5vB00VxvSb3z85uF4buE/i95Fc6dyuCXX3vCKKWjUw5dM3FowOwh419by+OJ
	 95KKIltQzKNEpSouCD5J4qXtwR+4ZfQgD8xrIh6uffapppYDeX+UyoaAtEFYNK+j9p
	 f5dSKZQI/fmNw==
From: Jakub Kicinski <kuba@kernel.org>
To: jhs@mojatatu.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	victor@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	horms@kernel.org,
	vinicius.gomes@intel.com,
	graypanda.inzag@gmail.com,
	security@kernel.org
Subject: Re: [PATCH net 1/2] net/sched: sch_cbs: Call qdisc_reset for child qdisc
Date: Wed,  6 May 2026 18:10:46 -0700
Message-ID: <20260507011046.2172988-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505132102.128903-1-jhs@mojatatu.com>
References: <20260505132102.128903-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 437C34E1D18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285094-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,mojatatu.com,davemloft.net,google.com,redhat.com,resnulli.us,intel.com,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/sched: sch_cbs: Call qdisc_reset for child qdisc
    
This commit introduces a reset callback for the CBS qdisc. The new
cbs_reset() function propagates the reset to the child qdisc to prevent
qlen and backlog accounting issues during resets.
    
> diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
> index 8c9a0400c8622..1efd72581614e 100644
> --- a/net/sched/sch_cbs.c
> +++ b/net/sched/sch_cbs.c
> @@ -243,6 +243,16 @@ static struct sk_buff *cbs_dequeue(struct Qdisc *sch)
>  	return q->dequeue(sch);
>  }
>  
> +static void cbs_reset(struct Qdisc *sch)
> +{
> +	struct cbs_sched_data *q = qdisc_priv(sch);
> +
> +	qdisc_reset(q->qdisc);

Can this cause a null pointer dereference during qdisc teardown?

If a CBS qdisc is created and cbs_init() fails (for example, if opt is null),
it returns -EINVAL leaving q->qdisc and q->watchdog uninitialized.

The cleanup path in qdisc_create_dflt() will call qdisc_put(), which
triggers __qdisc_destroy(). __qdisc_destroy() unconditionally calls
qdisc_reset() before calling ops->destroy().

Because q->qdisc is null here, calling qdisc_reset(q->qdisc) would
dereference a null pointer.

> +	qdisc_watchdog_cancel(&q->watchdog);

Similarly, could this trigger a crash by calling hrtimer_cancel() on an
uninitialized timer?

Does cbs_reset() need an early return if q->qdisc is null, similar to the
safety guard already present in cbs_destroy(), to prevent these issues?

> +	q->credits = 0;
> +	q->last = 0;
> +}
> +
-- 
pw-bot: cr

