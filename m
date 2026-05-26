Return-Path: <netdev+bounces-291682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIATIIOSFWovWgcAu9opvQ
	(envelope-from <netdev+bounces-291682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:30:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD9B5D5907
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4C22300515E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5BF3D8101;
	Tue, 26 May 2026 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B1QJKTpS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72041E4BE;
	Tue, 26 May 2026 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798653; cv=none; b=SOjcnGmKduELSdqgR3Vda4wJNsKoxgKRxPGavpu16JajytnjjN225AXjnYNBvRGc0TUZ2+49sl5hxKWYGlo/8HTvL3AjQHVzIfv1uIVuhZ42gFQtz+DLfc6Wr3ChbBP42KVkDLkQygN+QEUEvRsXGKKfHiz0urLjxVAgOu0OZxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798653; c=relaxed/simple;
	bh=6CRuk+pAg84iQqzOdg6Q7kbbhrlLdUum4AujBZcxfZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR6IkLmYsYBzRpuegxumaO7IqtamTWB1GwaGfhWSCA0cfKZGEDuO3pyiFVhQBU7gQd8LauURSAwOSLHqWqLGqk0UF9OflAv5UVM30LTlH+6r4NKY1dSU7FYPqE34oy8Cy697Dglpd5S8X2Vou7Hbgj72/uiR9X0gUXv/ccCj6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B1QJKTpS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AJ1NuSMr9aNbhlX00wnxVp1CKAtXHvBuNJIm1yN0oGE=; b=B1QJKTpSiyUbXqs3Oq6f2wzQ4f
	BSaPAVKgB5T7RCtmB+RbV7IImchc9CfV8nBdir98URF/pJwxeRlarqWP8ZdvQhZ8F7gxyyDC0sgp0
	RocNwEQhrpirl1aukBpemxIA57iL85IY0pezlkQ4RYlDmIKNSm5bWR72BQge81VLos7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRqvj-004a9Y-3H; Tue, 26 May 2026 14:30:43 +0200
Date: Tue, 26 May 2026 14:30:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: cedric.jehasse@luminex.be
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Message-ID: <c2e2ec6a-edc4-4eb2-8dce-a79858e6a1e1@lunn.ch>
References: <20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be>
 <20260526-net-next-mv88e6xxx-cbs-v2-1-13eb49c29b83@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-net-next-mv88e6xxx-cbs-v2-1-13eb49c29b83@luminex.be>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291682-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7AD9B5D5907
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:41:14PM +0200, Cedric Jehasse via B4 Relay wrote:
> From: Cedric Jehasse <cedric.jehasse@luminex.be>
> 
> >From the datasheets i've looked at these switches have 4 or 8 transmit
> queues per port.
> There's a PRI field in the dsa tag used to indicate which egress queue
> the frame is to be sent to.
> This isn't done for vlan tagged frames because this would overwrite the
> PCP value in the vlan tag (The PRI field in the dsa
> tag is used as the PCP value in the vlan tag).

Maybe a bit more context would be good here. This patch is about
frames the host is sending to the switch. Looking at just the commit
message this was not obvious. It was only when i looked at the tagger
change did i understand that.

Does DSA_CMD_FORWARD vs DSA_CMD_FROM_CPU make a difference here? Does
DSA_CMD_FROM_CPU skip some classification stages in the switch, where
as DSA_CMD_FORWARD might pass through more stages in the switch and
have the queue over written by the hardware?

	Andrew

