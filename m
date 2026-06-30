Return-Path: <netdev+bounces-303335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k0i8CZYQRGqHnwoAu9opvQ
	(envelope-from <netdev+bounces-303335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:53:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2586E752B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:53:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nzjve3ZH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303335-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303335-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18288303DA94
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D503C10AA;
	Tue, 30 Jun 2026 18:52:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1419DF4F;
	Tue, 30 Jun 2026 18:52:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845566; cv=none; b=AHuz2j8Y3nr/nxTngJcydXbWThAYP7um+uLpwX6V8cgNc1X6xo72+OuMmsQgNcYSDRtbvicYl+3G9RCjc0oE2aULl0YnlJDY5dlwQaeCzqD44txJFSem7EzXjry8k8CaTWFbEljOm5+JJYAUle+znpQC/n0YScDRLqFTFGnf5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845566; c=relaxed/simple;
	bh=vXoGTXa7yOfZ+Uz4oCc9QsXVWOkaOXUUNBli4k+0M40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IubVZQzPD60PdQQhB8WUHugAEmoMqABtaC5Px44tAEUc2neZaW+obMU28+gQwwLdk4YddQqVR7xo7ia5UjpcixieXvnYRqx4MSiTvm3ETUDrMuPXOJrB/jNuAQn36mtP2e20P0dBZk3tnbUz/Uh+MuaoIPNqYclmSpLN+iAo/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzjve3ZH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13E41F000E9;
	Tue, 30 Jun 2026 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782845565;
	bh=/R5x4upYXKuPYhHztTLUT8qvKxBK3EbNELQaayF3Enk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nzjve3ZHUyRD/VQjkWpvhA0rcAZLfTckC3CrloarflxPntChqVgmnD4GoaQzk6oUn
	 b78YspNj/IvPScnlYiiA0Tgs40+pkLRcSi1WQVM6zug3BFmWZTWfs026de46HG7md1
	 qptuWIcvOBoU3FX/1cbERAGSqVD9r/e5YMqfYp6ZBARJcZzNKM2spaJCTFdT1rh2If
	 foPCUYUjqz5vgi3PDi9z9SGx908msKzGc0Uc0unF1DHYw5cYJvCXtkur3Ch/EKQLJE
	 dWtd0NE+ySYbBvt441w3du2Uw9Okrpchhaw9JeQDkBO2PaWWXO973qPgGQa4er0K3W
	 RQPE0I8n2YVIQ==
Date: Tue, 30 Jun 2026 11:52:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH net-next 0/9] Switch support
Message-ID: <20260630115243.19cd0b4e@kernel.org>
In-Reply-To: <20260630024715.4124281-1-rkannoth@marvell.com>
References: <20260630024715.4124281-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303335-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A2586E752B

On Tue, 30 Jun 2026 08:17:06 +0530 Ratheesh Kannoth wrote:
> Marvell OcteonTX2 switch hardware is capable of accelerating L2, L3, and
> flow. When representors are enabled through devlink, a logical port is
> created in switch hardware for each representor device.

There's a number of allocations here which are missing a NULL check.

I'm sure sashiko will also have semi-infinite number of complaints,
so please check that yourself.
-- 
pw-bot: cr

