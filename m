Return-Path: <netdev+bounces-260283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLEYCP3vnGkaMQQAu9opvQ
	(envelope-from <netdev+bounces-260283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:25:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD6A180373
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24DDD303F44A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7621CC5A;
	Tue, 24 Feb 2026 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2tQOFWaH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167E3EBF08;
	Tue, 24 Feb 2026 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892730; cv=none; b=If06dJD45ZEsVCJL691nl+63po3ZOqt5QKT+st8mqgd9pe28pQZWwXz123tsTWAgsOpkEa8FxCCCWW+w5E0nD2lhho/1++/HfbvqE7PMML4TLDHoWs2kIfaoi7WVNE9UXiKeyDnlEkcTS78KohxNQMlNjLHPoHtVu95Ml+3Ff7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892730; c=relaxed/simple;
	bh=7Hn1LL/P0+aqiVoYtGkNW5sN75m37hbO8D97TAL8QZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1NZ02OkTitceYcf/1bfNEcw16Vo1YDIM/CEtNiX7z9wOj+vdnq/bnw4D4dAGyL8389UZf1YK17SGc2e4Mbu3XZYAcs1RlsNpYkINoysyVsH+LsjBcy0vFC+bwcO6FA8WA9XksevbyKyxL1gjAx/IuWWI8tqd+8gwF6fExn7Pnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2tQOFWaH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9wNbfljbdrFJ4n2mZFkerLZ8iaTZAp5bP82EU+2TLyg=; b=2tQOFWaHgdJXv3mVmyFe//Zsgf
	OrGcmZyuuWjtmVmZFttTohmxtToez41TqAz7m0rpqWhIxDTW6kzPlTBvqOnEmO3JcaQZ8FzHj742Z
	jje/868dk3eAHYAWpw9r6naV2UJCRvi6D3N8PDWkZ8WSdmMnpxjKs+5P6vRwAGa4n0+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vugEk-008Wyl-A0; Tue, 24 Feb 2026 01:25:14 +0100
Date: Tue, 24 Feb 2026 01:25:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] staging: most: dim2: replace IS_ERR_OR_NULL with
 IS_ERR for devm_clk_get
Message-ID: <796e602c-12c3-4288-8ed2-b41bfd64b2d1@lunn.ch>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
 <20260223220504.2102-3-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223220504.2102-3-iprintercanon@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260283-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FD6A180373
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:05:01PM +0000, Artem Lytkin wrote:
> devm_clk_get() never returns NULL, so IS_ERR_OR_NULL() checks are
> unnecessary. Replace them with IS_ERR() for both the "mlb" and
> "pll8_mlb" clock lookups in fsl_mx6_enable().

Looks like you have some other patches mixed in here.


    Andrew

---
pw-bot: cr

