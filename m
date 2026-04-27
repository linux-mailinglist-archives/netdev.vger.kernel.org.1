Return-Path: <netdev+bounces-281532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGRPHIXs72mjKgEAu9opvQ
	(envelope-from <netdev+bounces-281532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:08:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BD47BB65
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B7E300C901
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F743ACA7C;
	Mon, 27 Apr 2026 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYS5xEOS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091638A717
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777331329; cv=none; b=U6X3uxJU6tPnuBerm21NA6K6gfAHSP171Hlr5YVP88Av3WB0OB8JUHa4GCLT79QiwXMtL/GOck0UXnkm7S1pDtCExZL8rxye8u+N8mWQ6TVqa98mjwNqy9mjTtc4ExsRtVRflfhAg3qw7XNBatXqGbuWtJXN39yXlerS/eIqMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777331329; c=relaxed/simple;
	bh=EVk/KEdeMlfbcW2aUVxYwK+aQpzkD/QO/L7LRLozs+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiTamap1GkU1RZkVJjwUVEPqkrSYVTChxfqdwuhVkpvv5vcaTVxpkr7gTOQiV5QStGb1U83hgXMwwANWrvGLkXqOOcMyaP3WHBsREwz6jjVOVbnioZVLo7IuNlGjEuCMoNEbHyoqTNu098sIUbzwwN4K3/3dKXDC1lGaLGWK/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYS5xEOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB85C19425;
	Mon, 27 Apr 2026 23:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777331329;
	bh=EVk/KEdeMlfbcW2aUVxYwK+aQpzkD/QO/L7LRLozs+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MYS5xEOSxknxqJZAndSbM718c4ESg65SRwOn/zB7mNBDGT0gZJ8VMT2gX0mTDHird
	 ThC5Z0FjDrK56r6iGf2kU+SHif57ZhpYg9b34k30SVAcNIFxtyhLq9cav2o0x8kKJg
	 T/qagzTuHDs2zR5UM9y6i8aLdBz3iDJWz9JqFwvMbpfl2RP+5Q7HKONAvblSIaMFzU
	 1OUJA3o+jwDO6g2ugC+TdHUeNf8hkPZ+fQV4MEFPkeM513g0bCVtOznFq2zOZhQsLk
	 GQ3zyoH+LEH3nj8SSRi4a8wQO+TVzQWRn01KKBlqA2oFYsS+StF/OgMZrm/qC/sX8w
	 LTsoO/jDTQvSw==
Date: Mon, 27 Apr 2026 16:08:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/4] net/sched: tc_dump_qdisc_root() refactor
Message-ID: <20260427160847.5dbf1915@kernel.org>
In-Reply-To: <20260427132555.1791636-3-edumazet@google.com>
References: <20260427132555.1791636-1-edumazet@google.com>
	<20260427132555.1791636-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C51BD47BB65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281532-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 13:25:53 +0000 Eric Dumazet wrote:
> -	if (q_idx < s_q_idx) {
> -		q_idx++;
> -	} else {
> -		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
> -		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
> -				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
> -				  RTM_NEWQDISC, NULL) <= 0)
> -			goto done;
> -		q_idx++;
> +	if (!(q_idx < s_q_idx) &&
> +	    !tc_qdisc_dump_ignore(q, dump_invisible)) {
> +		ret = tc_fill_qdisc(skb, q, q->parent,
> +				    NETLINK_CB(cb->skb).portid,
> +				    cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				    RTM_NEWQDISC, NULL);
> +		if (ret < 0)
> +			goto out;
>  	}
> +	q_idx++;

Probably subjective but I'm not sure the

	if (!(q_idx < s_q_idx) &&

is more readable than the previous version?

Especially for:

>  	hash_for_each(qdisc_dev(root)->qdisc_hash, b, q, hash) {
> -		if (q_idx < s_q_idx) {
> -			q_idx++;
> -			continue;
> +		if (!(q_idx < s_q_idx) &&
> +		    !tc_qdisc_dump_ignore(q, dump_invisible)) {
> +			ret = tc_fill_qdisc(skb, q, q->parent,
> +					    NETLINK_CB(cb->skb).portid,
> +					    cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +					    RTM_NEWQDISC, NULL);
> +			if (ret < 0)
> +				goto out;
>  		}

I feel like checking the ID + continue in netlink dump loop is fairly
idiomatic.

