Return-Path: <netdev+bounces-269727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B1FIl2PvGlU0gIAu9opvQ
	(envelope-from <netdev+bounces-269727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:05:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE12D4582
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F296E3017328
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B7D4C97;
	Fri, 20 Mar 2026 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICagL03F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A064
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773965143; cv=none; b=q+NCFLzSB9ee6D1hzydyeN09OOMnVzAFLmZmboJi3ZHja2qMIO2WpoVZemJCh6A4qWtr8xlLA4FZDg+6p1amyNOPExmrMIl7nDzrsTHTfL1s1C7v8KHBxB6DWfA4P0uxn/7LmbBjuGUtaF7hG6hN2h/KqW4/YkiKsEG8ag81uMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773965143; c=relaxed/simple;
	bh=u9a+HUSNrVAAkzh+T44LxcUv39YeiUyKUwSvhq39FXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYWFc7b3OjQ6bk+R752149+qqUfpkSKVG6ChIwnC5i9NIYhVKoR1zUA/hEnT93cIKtEWRYWiHgy50TWN6v/fNTGTjo5DeXX1a7u+aiC5IzlPy32jOHxVgCUTMxbTLuAZjYlX/nANXdy22gz2y6fhDjGephGEMehbcb8wXU9QgwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICagL03F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A9BC19424;
	Fri, 20 Mar 2026 00:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773965142;
	bh=u9a+HUSNrVAAkzh+T44LxcUv39YeiUyKUwSvhq39FXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ICagL03FQUAl2azxm9C0rk69ndgtpCaoiPUdyEhBm0CSS7lv83j4TTf2wsPSOX0Ws
	 ezTkVB1blxCx6PTCqGc5wNGcmF/1Wdt8jdmnFCuORwISTCzr4skXwEnyoF/ReiI4L4
	 v0pXPnUPCLXkqDPAWBC0gTj7lidsXOjUhY60yGkxiKooXh16BsKY3dHOJullNDJd3e
	 LXtazxi8Dh2DzqOYKFyMTr1UmaDDrhxXobLkv3SCGbQPcX5HhWzN9TTa8tk/k1heJe
	 mbyZzTCkaLD6PopoBlnwF+JN5Wb53I+i0Q5nZTIKcktpgG3slP0O1Gam6tSyufnmRA
	 RII1unK3HFZ+g==
Date: Thu, 19 Mar 2026 17:05:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net] rtnetlink: fix leak of SRCU struct in
 rtnl_link_register
Message-ID: <20260319170541.27c75eac@kernel.org>
In-Reply-To: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
References: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269727-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3AE12D4582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 17:15:15 +0100 Sabrina Dubroca wrote:
>  	list_add_tail_rcu(&ops->list, &link_ops);
>  unlock:
> +	if (err)
> +		cleanup_srcu_struct(&ops->srcu);
> +
>  	mutex_unlock(&link_ops_mutex);

Does the cleanup have to be under the lock?

