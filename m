Return-Path: <netdev+bounces-292465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK2GH5tpF2pAEQgAu9opvQ
	(envelope-from <netdev+bounces-292465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:00:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC885EA854
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C850F3011774
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECA7305694;
	Wed, 27 May 2026 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMynz8ee"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017CF3B4EA3;
	Wed, 27 May 2026 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919255; cv=none; b=IGmMcUbXxP7zaHJIskUcg0h9Wu5VPJEuKnikRYZnZYFoA8CJOi39AuRryS4CEWr+o2RdxraZrMZoFahCsBDh2hMmxOw0w1WK5zNapp1a68ki4oltvgjZcP85x72bp//Yfy6jObO82+lXqwSjqmKBsPQuPBefZROH1oNYQeBct14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919255; c=relaxed/simple;
	bh=K+2PBOTkglAW3miJSMhH9wApdWPjmdrMRgBpbNA4E1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3jVmhCQ1bdYLyFyocfm68D/EJJIwZmEkjZ+D7Rl7FXuIE8ENV6lk08dxT3k9tRrs8FSeExRsEFqdZnGjNjIFT0QT+Dn7oxpnIHoO3eqiTf1SXJqnabjg1gLKxJkGRQMAgE5CFzoiVdLaPOtoPD04yH5ylFpLrcggZvfyLkm2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMynz8ee; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B62A1F000E9;
	Wed, 27 May 2026 22:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779919253;
	bh=x0pxT4HZIhcs1HqpqHxsIDiMExdPoz+EHtFOvLXYu9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GMynz8eeNUxQboU0DGK57X7n0j/Eh1ZhKqhlSmEYcT5h7nyrPvC/o5aNmKRO72cCm
	 1AJeyDhqFqVssTE81BqEcsvOI3gXCn40UIjXhp1Nq7rN1x5m5rl8bJ3+eoBUVNRdr8
	 eEElKDA/hsxq50ecSoWtIr11JirnvufB9aJZPErlilcQdocmnnHl2lvWoXel/ew/Ju
	 G6eOU+DWZp4Bzbd03th51HcvS+lFd2TNBLjKqeDi6pe9a69XnUcOYFA2BueS+7LK5b
	 DeAP2QDZ4l/jI1wXyi4LNgEoQWstlYSTcMyxhpuJbU7mpoKsi3I5ChP/dMKYbCa+op
	 URhuv0fOHIBwg==
Date: Wed, 27 May 2026 15:00:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, Steve Grubb
 <sgrubb@redhat.com>
Subject: Re: [PATCH v3] netlink, audit: prevent false ENOBUFS on timeout
 expiry
Message-ID: <20260527150052.68edb415@kernel.org>
In-Reply-To: <20260527192150.949400-1-rrobaina@redhat.com>
References: <20260527192150.949400-1-rrobaina@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292465-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EDC885EA854
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 16:21:50 -0300 Ricardo Robaina wrote:
> When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks
> on the netlink socket wait queue (nlk->wait). If the wait timeout
> fully expires (timeo == 0), netlink mistakenly interprets the zeroed
> timeout as a non-blocking request on its next retry iteration. It
> then triggers netlink_overrun that drops the event and poisons the
> socket with ENOBUFS. This bypasses the audit subsystem's internal
> retry backlog and falsely returns an error to user-space:
> 
>  auditd[]: Error receiving audit netlink packet (No buffer space available)
> 
> Unlike standard netlink users, the audit subsystem has a hard
> requirement to never silently drop security records. It uses a short
> finite socket timeout (sk_sndtimeo = HZ/10) to escape a stalled
> auditd and safely requeue the message internally. However, once
> netlink_overrun() executes, the ENOBUFS state is set on the
> receiving socket, and the audit subsystem has no mechanism to
> intercept or clear this from the outside.

This provides no improvement over v2, let's keep discussion on the v2
thread.

