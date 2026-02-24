Return-Path: <netdev+bounces-260657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF0JD5UUnml+TQQAu9opvQ
	(envelope-from <netdev+bounces-260657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:13:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B4318CA2D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 659963087FF2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D7833C19A;
	Tue, 24 Feb 2026 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qe4nZ/Oa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838733890B;
	Tue, 24 Feb 2026 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967634; cv=none; b=UXhFVJ7fyhqYqr2YnTBftc/50vi09d8JpINpn6E0OtZcAceNzNPcZCAsPrGQVoddGZQl2PaGQw2Oha+MrlVOGsrzt4/Tr1XSaMtISbW8Tv36DFXELvz/xxFCR2jb2d71+qoDyWJVdMoxGocnR4c3iJSzv/S7JoepZsBa3P/nBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967634; c=relaxed/simple;
	bh=qH+wkqcAZoFHBWFGsvILDX5k34YvpyeZQuTW6aHUgcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA8qNKdvm8B8+RyicS0pa+yN+EPOXdsE9eJ96C5yWLdu210+D1mi5g7PLa0ckxEHDR2KDMcpr+gUSi7dNuvo5EZI52JTyGsacwU7oXbSZhu8VhLLjL3TbV2XI9lD2qfrTu65s5RtO6DKWXhilX0Nzwym4ZX4PHCx2GPromXLoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qe4nZ/Oa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U94Ig4/e/063S0R5GOVtrNrHzKnLiYRWwvC295QY90k=; b=Qe4nZ/OaethSZNHIy/OiBoRBoD
	r+H9lUklCXgww/qJDuEKSyz0JqybbflQ0YRx4SHKepkwS7TOeoTVQA5xYVuSJ5nFEidu+exdIfBd9
	8eiHJJulcmush5l2dtNEXsoyEBAbtkQB1h4zR9v76qdIdFVBsliCFWLJYq9rAMP9m28Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vuziw-008eoG-Oy; Tue, 24 Feb 2026 22:13:42 +0100
Date: Tue, 24 Feb 2026 22:13:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
	Rahul Gupta <rahul-rg.gupta@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 5/7] bng_en: add initial support for ethtool
 stats display
Message-ID: <9fe6bbb8-874f-4aac-9051-a5683ea80c46@lunn.ch>
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
 <20260223163641.755200-6-bhargava.marreddy@broadcom.com>
 <14ac2695-7046-4d67-8b00-6deeb27da73f@lunn.ch>
 <CANXQDtYvHg2h-Qz1ErEARnq+1T5_S4KXdJpY9yfBm3ckiN1eUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXQDtYvHg2h-Qz1ErEARnq+1T5_S4KXdJpY9yfBm3ckiN1eUQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260657-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: A4B4318CA2D
X-Rspamd-Action: no action

> Thanks for pointing this out. We'll review the stats and map them to
> the appropriate structured callbacks (.get_rmon_stats, .get_eth_phy_stats,
> .get_eth_mac_stats & .get_eth_ctrl_stats).
> To make sure we get v2 right -- should these stats be moved entirely to
> the structured callbacks, or should they remain in .get_ethtool_stats as well?

.get_ethtool_stats should only be used for anything which does not fit
any other calls.

    Andrew

