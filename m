Return-Path: <netdev+bounces-268758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KB/FmbUuWleOQIAu9opvQ
	(envelope-from <netdev+bounces-268758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:23:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E479E2B314B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE4BB305BF4A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75039E6FE;
	Tue, 17 Mar 2026 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E84ZIKNS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04439B975
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773786212; cv=none; b=orQ+F1qDqDAZjAUrjNxmAT1+75bruE7JPfSD7VZDuiAT3jYSRYwjo90cQ9qt+dHI3OyCNSkh/qcxBCEMok4HnAZymcLOxRlyc3XkyY3rBx1qmgr+UQcrrqx9MRMAgofL++xEiOatCZVCXkkUx2zRDSVed4EjUPaYPIwQgbkH01o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773786212; c=relaxed/simple;
	bh=KZ4gwcyzXvnVIFRAiZ+1RRHJs20Jhg3plMvyTXKzXjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t14H2ngXaMdM5CjyV0T2M6S3IwOQZ9YWU3SCHXYSheTuziu7qTEALTeR11af1ZQypF54cd523C2OLof/NRqpuqMngm93+Bp9Ff8FzFoF7DiwXrgMnhHmy4dNAPTCm5WcvIw9rxqo533YAKU+7gYcKJP5rFVzuW1SLt4iVGaWTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E84ZIKNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52656C4CEF7;
	Tue, 17 Mar 2026 22:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773786211;
	bh=KZ4gwcyzXvnVIFRAiZ+1RRHJs20Jhg3plMvyTXKzXjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E84ZIKNSdi+faybvgCxg7l4OH73TdPGNOYcT0OuM/P8c0vhn8AccJT9YbBrp+WMrL
	 vFpUZyDq9hpm/uHk6QJWneM6IVkfgFnuh+RyypqKrINnvMbxobY1ZHWOK81Of/QWf4
	 9KNbMP+ffq4tgisO8WTlVJ56OjrZpc2puVZgCku1mhS7zdGk5rV7s5NVLUGCP8pvcj
	 18bo8TgvORtscNS0tuh0O5iIAoYfRttahlh73xPbW0AKi9wAWmwUnzvAgezZFsoBHI
	 gzNq6qoJuoxNu1vNUkSt2qo7x6WX2XuxSk9wjzXwqodxcqNz+ZIqWxHH5o1gvVlrMs
	 db73erZiAu6IA==
Date: Tue, 17 Mar 2026 15:23:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Nicolai Buchwitz" <nb@tipi-net.de>, <nicolas.ferre@microchip.com>,
 <claudiu.beznea@tuxon.dev>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the
 interface is running
Message-ID: <20260317152330.32998fdd@kernel.org>
In-Reply-To: <DH57URLYG3TU.B4HGNJATLFMU@bootlin.com>
References: <20260316092720.39198-1-nb@tipi-net.de>
	<DH57URLYG3TU.B4HGNJATLFMU@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268758-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: E479E2B314B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 18:00:02 +0100 Th=C3=A9o Lebrun wrote:
> Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

I told you recently that open / close is not allowed.
So why are you putting a rb tag on a patch which does exactly that?

https://lore.kernel.org/all/20260306190948.44d23f8f@kernel.org/
--=20
pw-bot: reject

