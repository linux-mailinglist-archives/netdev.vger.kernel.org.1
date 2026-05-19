Return-Path: <netdev+bounces-289226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OqZBHGwC2q2LAUAu9opvQ
	(envelope-from <netdev+bounces-289226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:36:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283F57593F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C283037986
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3F257855;
	Tue, 19 May 2026 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiAB3Jxy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2687C248886;
	Tue, 19 May 2026 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150909; cv=none; b=DGWu7z20CtNvvutsk+9Xq0arJOLTNZtXNC6ub8a740dukLcB90Rb1LMPr5L8Jx+7MaVqpPVx4Du8Udq6Sy/6Rzj6k6bxcY/Vc1n4cEwIG8gOgdPesRP4P+68v+vguhQdyY79+J/5fOPvJX48WUrn3H9IIb1tbiQmls5IebRJ+mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150909; c=relaxed/simple;
	bh=bcUAzun7DuQa2FpfbLLFAcM6nRlL97zheKTEUXqRsAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SevAc+pPRw1dsZzbTSvh3kogdZIivhU8tzU2Dy2OCPmqvy0zWtIc0RR3aavj1QTIEgT686YxQZA/nBHnYfD3sE+SwFdgHnt2SM9+SA/yubqY2cJAO/fcrswcvFgDKBoDRP6ahLSc8gVNrRiE1BYttGAljIUq0wZ8eEusFxCoudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiAB3Jxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49251C2BCB7;
	Tue, 19 May 2026 00:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779150908;
	bh=bcUAzun7DuQa2FpfbLLFAcM6nRlL97zheKTEUXqRsAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LiAB3Jxyo1+A0tOUzJeHpOdwErFpWhiv97/kgCDbjQ23i9lVOb5Bxofn/WMMnWeSJ
	 0dINgQnRghqhsLgkXrCAX2IPwR8QFpXCfAENLKP4jepPjnvWvnRWJiJ5DJcNRJb5zk
	 X8yQKYoC+e3eAv2KAQqTcsi5DFJ6AtEuMn6hbzzBFHdfA3RvqEx6ER3uOUEdLH37Rz
	 ANTPH20Qj62bQjUc6ydc4NZzUsuPMibY1mL3ne7/CSZMe1BsiIrjE2iQMEPPh048KA
	 KgJIT4muXwN0Y7PxUdnXxHDTlmUvse23DV0VZeBDL+GosmPERCl86q1MhzqTsF/QoT
	 IdjFUmp2FOAOA==
Date: Mon, 18 May 2026 17:35:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, Steve Grubb
 <sgrubb@redhat.com>
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout
 expiry
Message-ID: <20260518173507.2f2529c9@kernel.org>
In-Reply-To: <20260513172443.1128496-1-rrobaina@redhat.com>
References: <20260513172443.1128496-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289226-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8283F57593F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 13 May 2026 14:24:43 -0300 Ricardo Robaina wrote:
> When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
> the netlink socket.

Holding socket lock during slow IO sounds very wrong. One could say -
that's abuse of the socket lock?

> If the wait timeout fully expires (timeo == 0),
> netlink mistakenly interprets the zeroed timeout as a non-blocking
> request. It then triggers netlink_overrun that drops the event,
> completely bypassing the audit subsystem's internal retry queue, and
> falsely returns ENOBUFS to user-space, resulting in the following error:
> 
>  auditd[]: Error receiving audit netlink packet (No buffer space available)
> 
> Fix this by detecting when a blocking sender's timeout has expired
> (timeo == 0 && !nonblock) in netlink_unicast(). In this case, instead
> of retrying with timeo=0 (which would incorrectly trigger netlink_overrun
> on the next iteration), safely free the skb and return -EAGAIN, allowing
> the audit subsystem to gracefully enqueue the pending event into its
> internal backlog.

The socket _is_ the queue, normally.

Please explore fixing this in audit?
-- 
pw-bot: cr

