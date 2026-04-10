Return-Path: <netdev+bounces-277210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCXWH4hl2GlDcwgAu9opvQ
	(envelope-from <netdev+bounces-277210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:50:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A77C3D1931
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 369AD3031820
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A412EB859;
	Fri, 10 Apr 2026 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa+XUCHO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602442D9797;
	Fri, 10 Apr 2026 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789399; cv=none; b=m0l/3+/B1qWJo6Y+DT21IIIyLK44hvookajsPRkHLdqy0tcaOyzYrM8Au2DWvYxNWYIWgws9QJ5IZrvxZPxpZ+rCfYpX/bEO/+3ufwXN2YysTo85wtnKIrAjxpdxEJ9TRTMAQ75/Dq6v7SIcHtaPzSViqP3DMwyg09wgaLhNY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789399; c=relaxed/simple;
	bh=PFxwESjEwiInOIjqqERto05W36d4TqT8t9KgDW8sOSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUg4kan9bZBoMxh8SpaV2Nzl519gk3dLL+b3WfsBy7Wkr+PAU2KbJmB6YmHYRS8cYM1EU0UachrvKPAMaKA7l5z52blku0puYpKNyJGoqEufZUo6hHBvXdGJ/dRUIYs7E+wnSP3hRNIX4R86wQX4uRBBM3KK6Jvfo0o1GOHh9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa+XUCHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F85BC4CEF7;
	Fri, 10 Apr 2026 02:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789398;
	bh=PFxwESjEwiInOIjqqERto05W36d4TqT8t9KgDW8sOSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aa+XUCHOgWmSMF5tXwjQPXAitH7QV/XANqoMsyzyd4uyQ/cNkP1YBmRHiQR55zrz+
	 sfByURHJZk5TXIJ8z5LzT2zCW5E0ue+rBd2nyOIK+fSvCOg1Zx9BBmTCdOjSLN/WvF
	 iNdIGk0h/XXe37TMGj4RBSRp241MFK0NV+pEJbsLG+eCJjeWc/Tap9gkR3DboOvUnA
	 JGbNjrAX44i2bUCmpgmTsXFoy6WiIkUlkHAb0y4CXNayPwJ9dhbLIIP83jc2lPEfXY
	 y54G5vyw1ue6B6Kqau/vStn2lu5vkL2j1vrm37Sg9DTL8pH7MWUJeO5AqRfxMJes6w
	 XUEPPSHPoVenQ==
Date: Thu, 9 Apr 2026 19:49:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] net: rose: defer rose_neigh cleanup to workqueue
 to fix UAF
Message-ID: <20260409194957.5465e98b@kernel.org>
In-Reply-To: <20260406170125.175258-1-mashiro.chen@mailbox.org>
References: <20260405125830.89251-1-mashiro.chen@mailbox.org>
	<20260406170125.175258-1-mashiro.chen@mailbox.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277210-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,abd2b69348e2d9b107a1];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A77C3D1931
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 01:01:25 +0800 Mashiro Chen wrote:
> rose_neigh_put() frees the rose_neigh object when the reference count
> reaches zero, but does not stop the t0timer and ftimer beforehand.
> If a timer has been scheduled and fires after the object is freed,
> the callback will access already-freed memory, leading to a
> use-after-free.

What if ROSE is built as a module and gets unloaded?

Please don't post the next version until next week, we're drowning in
these AI generated patches.
-- 
pw-bot: cr

