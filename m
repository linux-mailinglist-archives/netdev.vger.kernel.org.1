Return-Path: <netdev+bounces-306659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EQkwNPBBUWqCBQMAu9opvQ
	(envelope-from <netdev+bounces-306659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:03:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE8673D80C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:03:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=2yqzNXkg;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306659-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306659-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0077300BB85
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B370B34BA42;
	Fri, 10 Jul 2026 19:03:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E323C39A;
	Fri, 10 Jul 2026 19:03:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710190; cv=none; b=Xk+AvhZBDVhIRLnTi7dr5Xaj/Z1QW/iqZbwxdjZnIqlNJEwKOCf7mfOKVlUAyiq5NU6RC4nD+7xM4D1qGObt60uQ+hLO7lNuk1f3jQwE6veYrNanRdBgBScUS9tir7A9FirBiiBoigrf3fgqjGsd3+3SCzB906kdH7oAEQ2qTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710190; c=relaxed/simple;
	bh=0ZCWtiwbCYObNWqc1ISQHKxg4n/1ZqXRuQTiOOP/6G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsAFZ3x5Ro4pG5ly9l+RL3LmMRFvYrOVnanlNjqGpgvvsRROTQ3RSyABSCMsnNd5gRbsYW73iQu81DzCB087kUx/LcnXFzN/lwhUXn2gO4XN3OgpOrI/F4Meclr3w75YD6qZuA+iNYCD448F9r/yUQ/CxzifFX1CoUgzeOGRnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2yqzNXkg; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zmdAJBwKwQivqKeOB+8/J86pkL4UaeLbI9NcIRhX7l8=; b=2yqzNXkg0O//1fox9mp/J3ZVjw
	1CCxYUgwOMDnKK8Emz6izbi+dG5EfDg9HOwA8hlTDL0TUr2YK0ux624OguCqsdOM+TN1H54l4aMhm
	vNS+PCU31IKtgjFYRRY67VtIUaw1Idu7bM8G+NvvlXped6LL/nYNpgq+nQtYjjyf1V1Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiGUt-00BgSb-8c; Fri, 10 Jul 2026 21:02:51 +0200
Date: Fri, 10 Jul 2026 21:02:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Luke Howard <lukeh@padl.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: dsa: mv88e6xxx: flush the ATU when the
 hash algorithm changes
Message-ID: <65e12726-2af4-42a0-9c49-fbf0d9909aaf@lunn.ch>
References: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
 <20260710-mv88e6x41-fixes-v2-2-e23654c65aa0@padl.com>
 <da33e486-2f01-4077-af30-1dc53a6aa2bc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da33e486-2f01-4077-af30-1dc53a6aa2bc@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306659-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jonas.gorski@gmail.com,m:lukeh@padl.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:richardcochran@gmail.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jonasgorski@gmail.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[padl.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FE8673D80C

> If changing the algorithm at runtime isn't handled fully and the hw
> AFAIU gets out of sync (i.e. static entries get lost from hw, but
> retained in the linux bridge), maybe it would make sense to reject
> changing it while e.g. a bridge exist?

Does a bridge actually make a difference?

 * @DSA_CMD_FORWARD: This tag is used on all bulk traffic passing
 *     through the switch tree, including the flows that are directed
 *     towards the CPU. Its device/port tuple encodes the original
 *     source port on which the packet ingressed. It can also be used
 *     on transmit by the CPU to defer the forwarding decision to the
 *     hardware, based on the current config of PVT/VTU/ATU
 *     etc. Source address learning takes places if enabled on the
 *     receiving DSA/CPU port.

It seems to me, a port not in a bridge will still use the ATU. And you
can add multicast entries to the ATU without being in a bridge.

If you want to make it conditional, it probably needs to be all user
ports are admin down.

      Andrew


