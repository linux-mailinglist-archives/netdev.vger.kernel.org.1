Return-Path: <netdev+bounces-254549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNx9Oh3hemnN/AEAu9opvQ
	(envelope-from <netdev+bounces-254549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:25:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C45ABABD
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092F23016C86
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD612D6400;
	Thu, 29 Jan 2026 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU0vvC6C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C228B4E2
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660699; cv=none; b=Y7WqoBjB/ywr2oAgqZ49tNpBXk4EaQxklPbIXEoIvcCWEOiSMi1caUXweOv5bbiCtAAiHysnAPCvHu+gdlSQfg0Zoa+0yPdwedLcxStqrqgoV5kGE3V/FQvydgD4/o+xW+JF7APef8pqIe/SWkC2Ywkn1fw389H21S5GuckECXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660699; c=relaxed/simple;
	bh=F/zJBy3s9wx1FP2zGmyPMHXEHj6g4oRv7fOw2E6nKZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nupgkGvyW3pYQPCLLqR7QCPAcvjvtWyzNPXrGZYTtj3RCIz9jkXKFcwN79w9Rx0yThd1DqF+ZqgRR/nctwhwtf3uuJaUK3d7AgnwAqvSgmHq124dKGZoaI+jTLHwn902eb0HUKVN9MB49YQdYsmS68+MT5DVYywUCkAbVQYdDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU0vvC6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB708C116D0;
	Thu, 29 Jan 2026 04:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769660699;
	bh=F/zJBy3s9wx1FP2zGmyPMHXEHj6g4oRv7fOw2E6nKZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hU0vvC6Cws8DOibqWOSx/ZlrZ9xtfluuTmwD5O6v6sepcub2v76u51F/0oeKagEXT
	 8tC3YPwOSBijN1+JUT6iHR1hOB6KE0u0KTN/9sMqAxjKdKcTk96vB2gDEeVc5hEmJ1
	 lyPxlp3S8t4MHHn8c7TbY2IdcJBMCZ+C8vM+CVsIwM/jp8YkwQ0R8EZtUkceQnzVuE
	 LXz8likdlsPHUr1iiWN5+hB9lJnGcUAI8QGQfqeBhDevVl/d0TNh1qPnVjA4P7zsN0
	 lvVni/v5+GuwyUVNirQAKFxM6QKmXeOiYrYZQpP4uzKxFlNeQeFtPy3K5lXWaafauO
	 G7eAnUU1NyS4w==
From: Jakub Kicinski <kuba@kernel.org>
To: marcdevel@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dborkman@kernel.org,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	pabeni@redhat.com
Subject: Re: [net,v2,3/4] neigh: discard invalid lladdr (b/mcast poison)
Date: Wed, 28 Jan 2026 20:24:57 -0800
Message-ID: <20260129042457.360431-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <973e792e8002319e6d61be82b79b1678027c30ee.1769464405.git.marcdevel@gmail.com>
References: <973e792e8002319e6d61be82b79b1678027c30ee.1769464405.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,linux.dev,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254549-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66C45ABABD
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
neigh: discard invalid lladdr (b/mcast poison)

This commit adds validation to reject NDP Neighbor Solicitation and
Neighbor Advertisement messages that contain broadcast, multicast, or
null MAC addresses in the link-layer address options.

> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index f6a5d8c73af9..34202a816a4f 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c

[ ... ]

> @@ -1033,6 +1041,14 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
> 			net_dbg_ratelimited("NA: invalid link-layer address length\n");
> 			return reason;
> 		}
> +
> +		/*
> +		 * Broadcast/Multicast and zero MAC addresses should
> +		 * never be announced and accepted as llsrc address (prevent
                                                  ^^^^^

In ndisc_recv_na(), should this comment say "lltgt" (target link-layer
address) instead of "llsrc"?

Looking at the code above this block, the lladdr variable is assigned from
ndopts.nd_opts_tgt_lladdr (Target Link-Layer Address option per RFC 4861),
not nd_opts_src_lladdr (Source Link-Layer Address option). The comment
appears to have been copy-pasted from the NS handler without updating the
terminology.

> +		 * NDP B/MCAST MAC poisoning attack).
> +		 */
> +		if (dev->type == ARPHRD_ETHER && !is_valid_ether_addr(lladdr))
> +			return reason;
> 	}
-- 
pw-bot: cr

