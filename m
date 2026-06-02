Return-Path: <netdev+bounces-293981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEZLH7ZFHmomiQkAu9opvQ
	(envelope-from <netdev+bounces-293981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:53:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 085EF6276D4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4922304855E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B04366575;
	Tue,  2 Jun 2026 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpTryM1J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8E363C62;
	Tue,  2 Jun 2026 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368652; cv=none; b=KYyD9Rzw/K8f2pCqCGkSycGt3UsiqROBCj5I3s7ll2qsua3y0NV6lZpLy+0YvLoueHEHIXi4QjkGjzuVzCyK8a3OwnH+vranNYgVbSRCt1ME/7dxnzFtVYTYjxw8DGiZl0U8n0CgXrzoJHrtqqSj4idaqxyy9XJj6vnkx+13l60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368652; c=relaxed/simple;
	bh=aySwtQdVbFX82LTfwEJ0G/aCOZ4z315DkUE8rBkBdQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVEJB4n4pclDKbQJRz1GdqD6C9xDcn7wu/DplLrzCzkY+hvd3nlgxbkw1iH0ZAFlLwqFHnLymAl2kUiE+fhJe9qHvXfSwx7B8+nFsnIOtasvBZ9aBnjgp7bmFdxoOaP/NGPDO09OTo5awE0MMfSO6lHSTJzY2QGSY5a8exaCyrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpTryM1J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A33C1F00893;
	Tue,  2 Jun 2026 02:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780368650;
	bh=aySwtQdVbFX82LTfwEJ0G/aCOZ4z315DkUE8rBkBdQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MpTryM1JRtj4DJaZloYViNdKr2YaX11GT3F6pyDR5ueeVT3aT/n+1J0LdVbmRK8/G
	 qiDCx0yQHoGX2zalYu2zGyJjIoLUZmVSed1Vcwfr4PL+n4A2nm1rdkFNtm2pLQBaRl
	 EfSXqOLAbzms5ItihXSQ32dISrS6Zsjd5DF3luaE4AC4Rib92zIlyEgmtl6Ij5CejK
	 T16Bf1ZX6sFMSzquiQOqKxIwLRnAgfaWAvh9rf5Ir0v32O4fvbvwlI5AlJSV/UFMil
	 u84zSZ1LcA7Go7+DsXY7UHQrH7I8bfyo2sh6NTgex/up7EDchQxvSdCvUn6ZEjNvqw
	 I8HY7nkmbm/gw==
Date: Mon, 1 Jun 2026 19:50:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Murashka <yurypm@arista.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: tg3: guard napi_disable and
 pci_disable_device calls
Message-ID: <20260601195049.766544fb@kernel.org>
In-Reply-To: <20260527115535.1686932-1-yurypm@arista.com>
References: <20260527115535.1686932-1-yurypm@arista.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293981-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 085EF6276D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 11:55:35 +0000 Yury Murashka wrote:
> During PCIe hot-plug events, uncorrectable errors can be reported and
> AER recovery for the tg3 device is initiated by the AER kernel driver.
> The tg3_io_error_detected function is the AER error recovery handler.

IDK, I really hate this NAPI specific tracking. Can we add a callback
to struct pci_error_handlers to let the driver know that things went
fully belly up and the driver should pack up its toys? Sounds to me
like the key issue here is that there's a side exit thru the state
machine.

