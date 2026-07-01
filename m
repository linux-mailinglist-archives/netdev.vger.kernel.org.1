Return-Path: <netdev+bounces-303424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 830tFLtdRGqBtgoAu9opvQ
	(envelope-from <netdev+bounces-303424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:22:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 099966E8E5F
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:22:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jz+PeIS9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303424-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303424-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8506303DAC0
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 00:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6CE1D7E41;
	Wed,  1 Jul 2026 00:22:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A7EEB3;
	Wed,  1 Jul 2026 00:22:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865330; cv=none; b=IMolk5xrdYmfXZUKuKD0orRSVx6swTnECl57grvICB3w9gfa9ZceXU+Ditvhz1HPKq//Y5zBpaZYtmVTFsnRIBdHNMAyREt5VpAJT2t0/Ia6aJPZVvjOsuYvth8YxYekZ8OqN9i0aLTS6NijmXb4m4kQ+1GSy6W/rd0X6hkr1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865330; c=relaxed/simple;
	bh=mMcchdAlNizDIwsEX0g6yqVDmYD8+EbSdd0zY93Oyko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9dtq+Up+jYDTNFB5cBq0O+E0VsxJ7OFjzzvSV6NkshJQWHqny1XGe/W3qRzfcgByfHQQmEzyeDxHeeqZNRxuZmRy9jn13bYyPcbpTt3wqtW2jVE4uPXbBvqf3bK68eE/otRNlwEo4TvvuL1kAMAVibwXrBuXCn9FHVx4rI8S3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz+PeIS9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BC91F000E9;
	Wed,  1 Jul 2026 00:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865328;
	bh=TNFRPzXso8ICJqumC1/giinDXhjIml62iLi01mXW94Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jz+PeIS9qJcT/vKWBLlHAbZMwtiFCKpo0Fjvz54AIZ5P/mdPWgAJKCd3dw69/9n9a
	 rpmRPNPSpyfcp4kHAHHe8MU/ciSvWLz03FyX6AQWpfUs4mhlKaUJgpViADnpYR16LW
	 6WbGIVSJqOPsrrd5aO1dtI5RCg8zMl5jjDt55zlAdS3OWa5PFfe+vRfj6AASfR3RCf
	 mrvrkdhkWLqVY/cQ250YyfywlUlAyp8UXIwppVq097xxNZUbnOQfZD5Z6PoJs5PnwZ
	 g320UgFBeqavlHPutxMaAnIRKDFamWVTEWOUATH5nehzkY0mYNdlwo+QrJyPdwNScS
	 Tx2ytJ4jlXhqA==
Date: Tue, 30 Jun 2026 17:22:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Kory Maincent <kory.maincent@bootlin.com>, Zilin Guan
 <zilin@seu.edu.cn>, Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Marco Crivellari
 <marco.crivellari@suse.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net/liquidio: drop cached VF pci_dev LUT and
 resolve VF for FLR on request
Message-ID: <20260630172207.0002f3e6@kernel.org>
In-Reply-To: <20260629141656.1769227-1-dbgh9129@gmail.com>
References: <20260629141656.1769227-1-dbgh9129@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-303424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dbgh9129@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kory.maincent@bootlin.com,m:zilin@seu.edu.cn,m:u.kleine-koenig@baylibre.com,m:vadim.fedorenko@linux.dev,m:marco.crivellari@suse.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 099966E8E5F

On Mon, 29 Jun 2026 10:16:56 -0400 Yuho Choi wrote:
> Xgene PCI probe by using port->dev->of_node directly.

sashiko points out that this is not part of this patch (or driver?)
-- 
pw-bot: cr

