Return-Path: <netdev+bounces-285419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QItYGFO5/Gl2TAAAu9opvQ
	(envelope-from <netdev+bounces-285419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:09:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE52F4EBDCD
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50FCB30DCDCB
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8DA2E7623;
	Thu,  7 May 2026 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP5MZYWP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F82288CB;
	Thu,  7 May 2026 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169689; cv=none; b=SDT6QvU5OiFSVfN9ZgDN6djt0APyFhrdZD45zMpcJB+Mr8nVJ3OBSRUFK1hi4vhZOK4YliqnKpy1YDUos/TlJK63nFS4OGTH/XTPcDFEwZm2ustmpxGs+B0ZjAUa3pjCuPcOWtG21LM3aXTgpSrTiQFCi5qhMsi+N3+DeMmaFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169689; c=relaxed/simple;
	bh=Y87c8rgf5Me61NjHZqAJx7x2YdYTO9VlCNejGsYJBuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyQ/QaQbs0OczRzCGWEE3h5wY4mpJj9uHkDpbMbK4s0MgcZcLeDyQ5BlgN9nQKqokd+7LfNnHSr/Vr+NAoMMtHeV1C7nhiInKdHK49Vp1QVjwn0NEFAk+5W0aP2Plr777YyeVc5V9M8rky4vISSw58B6OuBe5ZB8swT8STQ+xss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP5MZYWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0BAC2BCB2;
	Thu,  7 May 2026 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169689;
	bh=Y87c8rgf5Me61NjHZqAJx7x2YdYTO9VlCNejGsYJBuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dP5MZYWPxelGzt/aJZ3RU85/wmKuzBI+xpBxd4tBOsiT/zeWMkznnogWi9KB+mJty
	 LvAOrrtQcJddfbE7QLFieq+dpdjDmnCM5iPjMmAgXG33gHuD6JrYqn8v7p2caiC4aU
	 ZwtWhM6vhbXIq2ehcnAaijwzp2awdxgfp57ypTORcef4aD+hPBWpUXu4DH9+mLq6Lm
	 UyPo94Xh9W52ouAQmUO8VhsbPJzpmyndPxI4TvRyj4xG1E+dqfNMZo/KLMcKIw2YNN
	 CBXgkprrxeS8prvRgo2BHDhFk4OOiL3LQ+d2uVAaPKBOtieuVkxyFuC6D7fcCq/rRV
	 YhD65Pyj47j/A==
Date: Thu, 7 May 2026 09:01:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Alexander Duyck
 <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net v2] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Message-ID: <20260507090127.285a5087@kernel.org>
In-Reply-To: <afyxOaFhFzEKDK//@devvm29614.prn0.facebook.com>
References: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
	<6cec0c03-5bdc-4131-9899-bc5c77fba198@redhat.com>
	<20260507072453.5eec7051@kernel.org>
	<20260507072954.263ae8dd@kernel.org>
	<afyxOaFhFzEKDK//@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EE52F4EBDCD
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
	TAGGED_FROM(0.00)[bounces-285419-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, 7 May 2026 08:35:21 -0700 Bobby Eshleman wrote:
> > > fbd is a devlink priv, not netdev priv, touching it after free_netdev()
> > > is perfectly fine. I wish Gemini tried a *little* harder instead of
> > > guessing :| Sorry for not commenting earlier.  
> > 
> > Ugh, not enough coffee. It's complaining about MDIO reads, I think
> > that's valid.  
> 
> It is, but I think the race pre-exists.
> 
> static int
> fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
> [...]
> 	if (fbd->netdev) {
> 		fbn = netdev_priv(fbd->netdev);
> 		if (fbn->aui < FBNIC_AUI_UNKNOWN)
> 			aui = fbn->aui;
> 	}
> 
> 
> Definitely possible that ->netdev gets freed concurrently with
> fbd->netdev evaluating to true... but fbnic_netdev_free() faces the same
> race.
> 
> I'm open to fixing this all at once, if preferred. Probably need to look
> at some of the other fbnic_net ptr guards too.

I agree with Paolo, seems separate.

FWIW I think the fix may be to move the single aui field that mdio
cares about to fbd instead of fbn ? Feels like the problem is due
to a layering violation, mdio should not be touching fbn fields.

