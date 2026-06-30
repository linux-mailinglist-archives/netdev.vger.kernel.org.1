Return-Path: <netdev+bounces-303380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i0REM9A9RGq7rAoAu9opvQ
	(envelope-from <netdev+bounces-303380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:06:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D046E8469
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:06:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=sXJ0p2Tt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303380-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303380-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 663733006B59
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55F31AA92;
	Tue, 30 Jun 2026 22:05:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1080248F66;
	Tue, 30 Jun 2026 22:05:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857157; cv=none; b=M+MPUWvLZu5TtshusF7iiuoYnVdkNPHBU+n74X5oEOfDRfacuebjwhio2PBQfQ2Wsw0B9G+tgb/VD25b3oFokBmUi7vR2xRbz7T/iuVBXnT4IbRpdQ+440VNEpFzTrACVN3KGSJayuGDqfWLwZVXv2yZPBJPiyRK1H9Nw1OTeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857157; c=relaxed/simple;
	bh=iZY/SN5neogzI0BGV6RQH7zuMkhmWhthxtKeNKWqXNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ6qVfRuO59eiIXlAVgGy0qfb4/yMbuREnRjI9IhIcL0jLpZe0mSOeA0EAqLRe//io6WcNzsFbTxngYty2xu2ys0Vrs9rHroMF5QPxVM2+Ddc+RO+AgCLQb2MhiAN00+QxgnTJNzZYJI7nCajXoSoNEV4/4WS0SgEivF8ztf9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sXJ0p2Tt; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5AWjf6/VDgEl6krgDa0UEq44NylSD0Tc3uCkVdGyjws=; b=sXJ0p2TtdOshibb9LBgWjhaiMb
	+aXbSKgB8iWtGdXH1iSlqTCUHXssbYR1UPo+8sqZrzig1L0B8o6YTW7+BqRVLnjw7Qi0hkUrCVRKR
	xH5FqQADVH+J4Ys+5NzfMweu/vqR2gWsbi2L61OFRr/izQi9W5mPmiA5DeZgs4HLkf24=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wegaQ-00A3BT-Ly; Wed, 01 Jul 2026 00:05:46 +0200
Date: Wed, 1 Jul 2026 00:05:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com, nic_swsd@realtek.com
Subject: Re: [PATCH net-next v7 3/4] net: phy: realtek: add support for
 RTL8261C_CG
Message-ID: <2e36dae2-36da-4390-b4a9-6736871715d5@lunn.ch>
References: <20260629064718.1349-1-javen_xu@realsil.com.cn>
 <20260629064718.1349-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629064718.1349-4-javen_xu@realsil.com.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303380-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:nic_swsd@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de,vger.kernel.org,makrotopia.org,nxp.com,realtek.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,lunn.ch:from_mime,realsil.com.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58D046E8469

On Mon, Jun 29, 2026 at 02:47:17PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
> 0x001cc898.
> This patch introduces a distinct family of handlers (probe, get_features,
> config_aneg, read_status, config_intr, handle_interrupt).
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

