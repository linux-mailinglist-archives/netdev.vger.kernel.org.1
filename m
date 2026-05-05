Return-Path: <netdev+bounces-284201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAW2E+R3+WnV8wIAu9opvQ
	(envelope-from <netdev+bounces-284201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 06:53:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9014C695C
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 06:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 408BB301A420
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 04:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD43A3E6D;
	Tue,  5 May 2026 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b="i8j0bxXQ"
X-Original-To: netdev@vger.kernel.org
Received: from retry-chloe4.scw-tem.cloud (retry-chloe4.scw-tem.cloud [51.159.124.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025382C030E
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 04:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.124.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956831; cv=none; b=oRUi4/Aas3ryP/xVZErhbSPugEmb1bpIIyinxTkZa/EN96Tcm901B+SByYFkTkTDa2ESZOLqAERtyu9f685nJu+wC+kJBSMOE0gOJnx07ROYhHHqBu4mLUZkXmmHgcpLNisPtiTTSeVV/oC8Z9+7Om6f5wd58rQdNBm8fdXCizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956831; c=relaxed/simple;
	bh=ILXk0ypioXXQWbJScoB2L5GBzoLlSBom5ksLwV4yPQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uJf+nTV6+obISP+oRZbalveHSNBn5V4bQ5/05EWwAeRKYt5Khkk2/VrjSc2yZPIxHWfI8q2JB9Yxe+aHZC8N2Prjna6+i0IAyWdye56OF1BoO94jlx+XklqTa/vJSz6Wa6nv8du7xRnfXPG/QbdwxGfYbCZNDSty0G2pLe0LmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info; spf=pass smtp.mailfrom=leavitt.info; dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b=i8j0bxXQ; arc=none smtp.client-ip=51.159.124.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leavitt.info
From: Corey Leavitt <corey@leavitt.info>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller
 lookup from MDIO probe
Date: Mon, 04 May 2026 22:36:55 -0600
Message-ID: <177795581584.12433.14568712745388778289@leavitt.info>
In-Reply-To: <20260502201016.2215520-1-github@szelinsky.de>
References: <20260424144124.131837c7@kmaincent-XPS-13-7390>
 <20260502201016.2215520-1-github@szelinsky.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: f4 0.1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777955815; l=1407;
 i=corey@leavitt.info; s=default; h=from:subject:message-id;
 bh=ILXk0ypioXXQWbJScoB2L5GBzoLlSBom5ksLwV4yPQ0=;
 b=1aJk2u42VoHWqshhOATuCgfJ4lEVOv6hLmHMSR9OHdI22TUMMYbMrYlA+m0g6qUsK2G2Zw+zd
 9MTklTSvXRiCjTZbjh7/cmhjiCrCuuTmEzIwp8bkXjl+G4yIzt60aG9
X-Developer-Key: i=corey@leavitt.info; a=ed25519;
 pk=Q3mmZT+4CRYT8qp8RWvab30X2v2JnLdhHuK7YIHKzpI=
X-Scw-Domain: leavitt.info
X-Scw-Tem-Message-Id: 23460af5-d1b3-472d-84fe-b434f4bc2804
DKIM-Signature: a=rsa-sha256; bh=ILXk0ypioXXQWbJScoB2L5GBzoLlSBom5ksLwV4yPQ0=;
 c=relaxed/relaxed; d=leavitt.info; h=from:to:cc:subject:date:message-id;
 s=cdc8a02d-c0a1-45e0-85cc-a48257446c17; t=1777955821; v=1;
 b=i8j0bxXQi3eNvzpMM+X6FO3fu2xCFffm8vuo4K2JiRMEdDHNWfZPi4RtvxE4BiNaGG/Xo1yW
 39dHvEfTi4v4cXMeNmkCw/13qUe9Fv6WmzHBGLCeQx+z2L7HMskqGohKfKeBTW/iiCczf1j2aQF
 5o6sSHAy3i05nmMZUts4XTDYGsrT07ZW6vrzWeUeXyu4uTBV53rrw3XNFGPykHQeG5N1X5cXoqN
 /bI0DiIDWeLQN4fWudT3dCZuMefc+aW4Izy6GWjbwQK4KB9MKjbhhAf71J01tuirpeKirEywyR/
 B4WTHzsykREqjAnMOo4ODn5tAo+7dlKkbHcIdvZQ2Xh2Q==
X-Rspamd-Queue-Id: BC9014C695C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[leavitt.info,quarantine];
	R_DKIM_ALLOW(-0.20)[leavitt.info:s=cdc8a02d-c0a1-45e0-85cc-a48257446c17];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284201-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[bootlin.com,pengutronix.de,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@leavitt.info,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[leavitt.info:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,leavitt.info:dkim,leavitt.info:mid]

Hi Carlo,

Thanks for testing, and for the clear writeup of the rmmod path.
Will add your Tested-by to v2.

On the rmmod / module_get question: I think you are right that the
per-consumer try_module_get is structurally redundant once the
notifier exists, since PSE_UNREGISTERED already gives us a
synchronous invalidation point at unregister time. The reason I
did not strip it in v1 was caution: I want to walk every
pse_control_get / pse_control_put consumer and confirm no path
holds a transient reference outside of rtnl-lock (or some
equivalent serialization) such that an in-flight use could race
the unregister notifier.

That audit is on my plate now. I will share findings on this
thread before v2, and let the result drive whether the removal
lands in v2 or as a separate discussion.

Glad to hear the probe loop is gone on your bench and that ethtool
plus PD power are behaving. I expect to have an SFP-capable board
on my own bench later this week, so I will cover the sfp.c path
change before sending v2; a retest from you on the SFP chassis
whenever it is convenient is still very welcome as independent
confirmation.

Kory, Jakub, Russell, others: input welcome on whether dropping
try_module_get in favor of pure notifier-based invalidation is the
direction you would prefer here, or whether the belt-and-suspenders
refcount is worth keeping.

Thanks,
Corey


