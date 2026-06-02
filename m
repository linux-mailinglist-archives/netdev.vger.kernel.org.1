Return-Path: <netdev+bounces-294193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H9uBCE3MHmoNVQAAu9opvQ
	(envelope-from <netdev+bounces-294193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:27:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4989A62E07E
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:27:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=cJYN2Nsk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294193-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294193-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCAEC30364BB
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13CF3D9026;
	Tue,  2 Jun 2026 12:20:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1F3CB2DA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:20:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402846; cv=none; b=RqNn1PrdUEW3ZV1ZI4L3juqUADTGK0OiwVzTI208pl+6tYFapSDh/CSEGgKFVg5ygzPUrilzrhTzzLTkKaHJzOR3M3k/SIqLWg+JzGftxlhUrb1+womeIaMi9jFGZmB+zCor8BUaM4k1qGvfq6Vte9NvmN3fLs/eHGWqNecuf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402846; c=relaxed/simple;
	bh=ZjocbGkE3mphpdlq3/A8YNJfazwEXErVdBsEsCf37jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL+n57qE1E+joVaCJ29XfRM4lzXoO42giegpnEe3zuaiwun7xhHMtxRFeJk/cYQAtVZkxDfXo1ZToQ8veH0VL22+lVXQ/jU6GbfGsVGSOvDYc/UJ8NuyjZ3JVRq0oPSo5SQm0NAz0Yvn09nJIpbaBtMOcdmoEYkeS9T+jdXGMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cJYN2Nsk; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FJ+nYsc3+IXWTof0guvaRGWcGvUqnL6cVadRyGFm3/g=; b=cJYN2NskSInDBakX5YhOY7Ltwc
	jCay5h+jM07YiDxnFanOuJmldLi1FmrItvxsGb7Usl+o/pGF0oU1SXyOBJxhOXdmF525RUEjfJeCF
	aq/bi9sWxVW+bAgsFsHe50MG5vjYBDAvlX1896S/U6LjDOoXWR7qsQDFaRrYV7zGEfpM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUO6m-005gST-7A; Tue, 02 Jun 2026 14:20:36 +0200
Date: Tue, 2 Jun 2026 14:20:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, mensi@mensi.ch
Subject: Re: [PATCH net-next 5/8] net: mdio: realtek-rtl9300: adapt spaces
 for defines
Message-ID: <233257c8-9908-4e70-bc04-6f5506f97ac5@lunn.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-6-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602052640.93083-6-markus.stockhausen@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294193-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4989A62E07E

On Tue, Jun 02, 2026 at 07:26:37AM +0200, Markus Stockhausen wrote:
> Register and fields will get longer prefixes in the future.
> Keep define blocks clean and readable and add another tab.
> Additionally clean up some multi-space separators with tabs.

As pointed out in another reply, there are logically two different
changes going on here.

Doing checkpatch cleanup is fine, when part of a larger patch
series. So if checkpatch is complaining about spaces vs tabs, feel
free to clean them up. But please say in the commit message that is
what you are doing.

Changing the indentation level i would do when you add the prefix
which needs the new indentation level.

      Andrew

