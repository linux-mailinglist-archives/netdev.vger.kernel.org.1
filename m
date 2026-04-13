Return-Path: <netdev+bounces-278198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3XHjNClZ3WnYcwkAu9opvQ
	(envelope-from <netdev+bounces-278198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:59:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C43F3533
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8539C302BDFD
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80313859D9;
	Mon, 13 Apr 2026 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9isYdre"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450D347BA5;
	Mon, 13 Apr 2026 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113610; cv=none; b=AAC44yCE6atKe4f04CtmKWdCj4c8OLyBtoDpiym6RnnzKgffBBfCqFNpSMVhydjT5x0h/uCS1UG9pxYU7LiqPmlOtCPulBvfndKCo4b5nW1WNF6Jl+qNUvKqhSsLnD/HsA92HakV3YSxCW2UnkwOf8LyFNyIPu5BkEekywd36YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113610; c=relaxed/simple;
	bh=P/rJiMEHhO7Gh9LW3ve5RLu5Z8y7cE2unh6UzHui4n4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWy+CehczFn6dQmDYmwZuhZP/jBzGv9rnDGDiH4dk7LvNBkW+URMARN3vX0rMClxs8rgxd9loG+s7ox4GMgb2hjh+hY3bK2CTXNe6zlPqV0tICtw18xRTr3DZBYun3YTiA3C69wwqlAz5ysXlIgA1qMaTd0R+v4X3Nglkoa+h1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9isYdre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AF7C2BCAF;
	Mon, 13 Apr 2026 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776113610;
	bh=P/rJiMEHhO7Gh9LW3ve5RLu5Z8y7cE2unh6UzHui4n4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R9isYdrezLd8PaOvN1L+PpRrpNBzaImrF7/quEK2shoF3b5jJgO7KuvJTOOwBDWV5
	 cWuo/j2xxeq822CJkJNI1BJAyGJmeE6ZOIVxmF+7rFeFufN80GMl5r0LhH6LcJodtN
	 UW24ueaOTCUMv+7RVop65/iQwvmoeu9B0M9Z4NHOTAO/m7OUmOwL+BY/Gg7uP/n4w0
	 rHqG44KWHfSGOmPmT5fmGWBFWn17XpiwMyzLlm99WUYVMdRTa5WAlZQVf6YKkNhZCU
	 MytsfEwvdHkhU9SoJhQg92Tux1VUPKq/s6EB+FuKA836rGvX2EXCsHYXZuKvZhAdMW
	 w32ZZ8p/FEjOg==
Date: Mon, 13 Apr 2026 13:53:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: f6bvp <bernard.f6bvp@gmail.com>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 2/3] rose: clear neighbour pointer after
 rose_neigh_put() in state machines
Message-ID: <20260413135319.20336802@kernel.org>
In-Reply-To: <20260413174238.112418-2-bernard.f6bvp@gmail.com>
References: <5a88b747-bb06-4ebd-99de-80ceb574cf22@free.fr>
	<20260413174238.112418-1-bernard.f6bvp@gmail.com>
	<20260413174238.112418-2-bernard.f6bvp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278198-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 578C43F3533
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 19:42:37 +0200 f6bvp wrote:
> Signed-off-by: f6bvp <bernard.f6bvp@gmail.com>

Human name is required when authoring patches.
Please do not post patches in reply to existing threads. See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr

