Return-Path: <netdev+bounces-304611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i/06EyDnR2puhQAAu9opvQ
	(envelope-from <netdev+bounces-304611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:45:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3CF70462A
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:45:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=rstkdL9C;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304611-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304611-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 634453099857
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247E3081A2;
	Fri,  3 Jul 2026 16:39:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10C286D4D;
	Fri,  3 Jul 2026 16:39:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096743; cv=none; b=E8GMVl5jUH70jmJKho8iJiFcD8y6d1fajzVzU1w+sGIPT3IpSs9AhGrouFbAbSgfw3dsozcFC5giKiTPPho1s6wynpQu/dhj2Ok+BkbGmBmIvNq/1omwM0jcuRULFhauwUlpYsKUT1MrkM+Uho6SCjKbJxAt3CPFv3rtdYPJp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096743; c=relaxed/simple;
	bh=5DVVBtTOW0yr5qDqr84mGeBE9GlwwdKdtKIQ4DEOBLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA9En/sNgBjeVMVN9+v8jBqOfC16xFJ1ekOxTvTaYbBmYGDfDSCf0RfzAbWVh+ogqQpgZY8+ugqv0BUntwAhUbl2W3oNIvQ37rwE8W5Fp2BA1LWozXAsjFH89Fb8+ZesUCHAPvuJZUMYG37PrDQd+V8sS95Zuw9dAPHwNPBIAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rstkdL9C; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cOUbwEcbUl3Tbzt6eGApLmbeUlwF/FWkHZ2MGvOerL4=; b=rstkdL9COsd4gO3sCjGnPktLkf
	pVSuBjoTLGb0FQt8q7bZyAUqQI4OkYaDtfiThk543MM9Zv3MB1g5iPE9N36ZYmNyuHfryOUujYY35
	tLQwxT65h8QmyS9R8I22xXTWrO+3RTZ4Fni9NvH2H65H94Mi5yq9zbZUbWmm6pmfIbYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfgul-00AZoE-6r; Fri, 03 Jul 2026 18:38:55 +0200
Date: Fri, 3 Jul 2026 18:38:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: emac: mal: replace devm_request_irq with
 request_irq to fix probe error race
Message-ID: <fa4fa65e-1635-4313-a5e0-56a5208272e2@lunn.ch>
References: <20260702235045.1326384-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702235045.1326384-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304611-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B3CF70462A

On Thu, Jul 02, 2026 at 04:50:45PM -0700, Rosen Penev wrote:
> devm_request_irq() is a managed resource: the IRQ is not freed until
> devres_release_all() runs after the probe function returns.  In the
> probe error path, free_netdev(mal->dummy_dev) and dcr_unmap() execute
> while the IRQ is still live.  If the shared IRQ fires during cleanup,
> the handler accesses unmapped DCR registers (crash) or the already-
> freed dummy_dev (use-after-free).
> 
> Switch to plain request_irq() with per-IRQ error labels that tear down
> only the IRQs that were successfully registered, and add the matching
> free_irq() calls in mal_remove().
> 
> Fixes: 14f59154ff0b ("net: ibm: emac: mal: use devm for request_irq")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

You seemed to of sent the same patch within 24 hours. Please don't do
that.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Send a self NACK to the broken version, wait 24 hours, and send v2.

    Andrew

---
pw-bot: cr

