Return-Path: <netdev+bounces-304269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jShSFzDNRmpfdwsAu9opvQ
	(envelope-from <netdev+bounces-304269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 22:42:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B486FCC87
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 22:42:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=bR216o8Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304269-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304269-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6335930097E5
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 20:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7628367297;
	Thu,  2 Jul 2026 20:42:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8E2E54B6;
	Thu,  2 Jul 2026 20:42:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783024941; cv=none; b=ooaLKB1l0YBjmVT0wkrhFyXsKv+NrjHIo2Vfl9FDSKWPMlIFaSj+J0j/U7j8CzggIvWtgCRfOw8hU6tDkXz/ulBHSGOEKgkIdvQMm4zO031tmxAxGmtvTDPeOWwT/ntls0PAUsrrw2KEg4NZqZVMu6sjFOw2xg29WaJylGCnK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783024941; c=relaxed/simple;
	bh=0K7O3V1Ye6c8TkK4J5fKCXasvKhmf6Q3+0dtbjAOAlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kcs/lpZo9EzJt8g8i2UtrHCMUffeV9U7MNYh4liOvgMbh9ntFW3XvG9je/JQtK0kp4Zdt4niD/GE0EisjihsHtK4u1+IOHg/jOc7uW3vRtKv6t4ZXGkdKVKaf6kaS98iYr2Po7YCwHglOFdtD7lkWO8XVoiv57KRwnIvWTcru6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bR216o8Q; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nEh/4Jq/1g2wOt5TMRZMIQ6WyzWLCqNZKJvNkdPsiRE=; b=bR216o8QbXJ3gzhf773vs6to3f
	/4MorbeElKkQWRWJYDACbzAe+fWhqFhy66+NXFMbt/Wp2TO328PBp1iqpyjfbPCu6Si5/RxCgH1Cm
	nKbTq/OspEqfLD+RCsKIJxBTcnG2m2g4iUgV1svPoz4uUaClikt/W4DIr1qrNeyV60JQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfOEZ-00AR6L-LF; Thu, 02 Jul 2026 22:42:07 +0200
Date: Thu, 2 Jul 2026 22:42:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, madalin.bucur@nxp.com,
	netdev@vger.kernel.org, sean.anderson@linux.dev
Subject: Re: [PATCH v2 1/2] net: fman: move IRQ registration after init to
 prevent NULL deref and UAF
Message-ID: <19877366-38df-4598-9892-3b295a5238f1@lunn.ch>
References: <e1f8aec9-751b-4a51-ab09-ca3c37522e30@redhat.com>
 <20260702092815.1206704-1-zhaojinming@uniontech.com>
 <20260702092815.1206704-2-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702092815.1206704-2-zhaojinming@uniontech.com>
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
	TAGGED_FROM(0.00)[bounces-304269-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:sean.anderson@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2B486FCC87

On Thu, Jul 02, 2026 at 05:28:15PM +0800, ZhaoJinming wrote:
> read_dts_node() registers shared interrupt handlers via
> devm_request_irq() with fman as dev_id. Two bugs exist in the
> current code:

Please start a new thread with a new version of the patch. The CI
system just thinks this is part of the discussion, not something it
must test.

Please also read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

and set the Subject: line correctly, etc.

     Andrew

