Return-Path: <netdev+bounces-282391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMQLKVUI8mnhmwEAu9opvQ
	(envelope-from <netdev+bounces-282391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:32:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E852494DEF
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2844C305BF30
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D6A3F7AB7;
	Wed, 29 Apr 2026 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DeHXCnCr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89039099B;
	Wed, 29 Apr 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469102; cv=none; b=pCC4Pq6Xs+9MoqP1+jKl0HcEK8W2QFXcBAaDa8kHikEf+EhZ/7rvUINK0GU+oECaR+KYmMAJmALRRnD5hyrDFeqWc2oCUSg8PuIrkNS/OB2DRRItGKocY29f9Y74p0gUXZ3jGf4gij3a0KRl3xFdZqUNGovKrbhNgUdhwqNENHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469102; c=relaxed/simple;
	bh=oKMamG83QOLrWSxnhitkkjPtleCNuHOyDK7t0dLY+8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tscyY+uEPYPaoLl2P4DDFQMowBcflld8bnJ5eNW1K3aalJiiYari2weZF9bxM5sUO9KOonad1JHAcdp011yXfyKSIO7HTP6wNCRoYwFgP3jf3SwuMm8/U2UHllklBbtb3qBdPqwimNhwObCsknOPWaRE/++o2E5fuqFxjbq5gBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DeHXCnCr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QSOgMQl0K1POqlJK6mzVSLOEWmD2vZiKst0hjhUeTdI=; b=DeHXCnCrlOcl7xy8sGWJgNWbVV
	C+NF4TfBFHbekMVdBDUQ7SOE215XeHu/QrzKhApgtgj/3uByR1MpX7b8Q8MABZQ7sXwqIEJ6TYW5m
	dU3Qdchehn/q9gyYCkhEZhQX8woEn+AiWF6e3SZ/E6mNYR2afi4KSVQP72GFXf3TqCaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wI4uK-000XKa-At; Wed, 29 Apr 2026 15:24:52 +0200
Date: Wed, 29 Apr 2026 15:24:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: gianfar: use alloc_ethdev_mqs
Message-ID: <72c3a071-ae9e-416a-8800-6b136c2758ab@lunn.ch>
References: <20260428223058.113013-1-rosenp@gmail.com>
 <0f704ce2-e936-4bc1-8ab2-144de9e74af8@lunn.ch>
 <CAKxU2N8yb9-M9zELSxdEjLz02GKFZ2mOmgHhc7NbW+oJsvtGXg@mail.gmail.com>
 <d807e204-0052-4a33-b711-e372c7695023@lunn.ch>
 <CAKxU2N_uQaGvsT5zri53Bcr9veCFWzV=_VnddJRdOXBYgoqWQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N_uQaGvsT5zri53Bcr9veCFWzV=_VnddJRdOXBYgoqWQw@mail.gmail.com>
X-Rspamd-Queue-Id: 3E852494DEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282391-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]

> I see what you mean. Will respin this.

This is why the netdev FAQ says:

  Netdev discourages patches which perform simple clean-ups, which are
  not in the context of other work.

  ...

  This is because it is felt that the churn that such changes produce
  comes at a greater cost than the value of such clean-ups.

Does changing alloc_netdev_mq() to alloc_netdev_mqs() bring enough
gain to offset the work needed to find the new bugs added at the same
time?

I know i would prefer looking at patches adding new drivers, new
infrastructure, new features, than broken cleanups for very old
drivers with very few users.

	Andrew

