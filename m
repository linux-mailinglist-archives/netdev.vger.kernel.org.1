Return-Path: <netdev+bounces-293282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKzwCpkTGmrj1AgAu9opvQ
	(envelope-from <netdev+bounces-293282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 00:30:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97790609501
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 00:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD6463017BCA
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A53630BF;
	Fri, 29 May 2026 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="31ISob5G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21843431F5;
	Fri, 29 May 2026 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093845; cv=none; b=HnhA72o08AR+9ppWvycCxoDwM6MybbfofaZAemBqg4QNwhCKrdtVM221uq3QzabwO5YjftiSyZRoZCFHCFNVM2v3Uw63GMienMb/fGa0VLBPhYvCic498plargwvKspQS5G/RWUXhjBZOYKBf/DBwO5/OVyCULqHWHVhnjjlQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093845; c=relaxed/simple;
	bh=8XyZnD0uaP4ofNcwnJJJnYevGg7kNKCVrtmp1Zz/OqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub/m0EZDrwfyKjQ/VkLViRuTXDYZzimnzGLGhRE/MPYX+IqnmCBruLQzt6gyzVLI5OIpPMGf7D4+HKlsNWQ39nplzxgGsOEVzLqoMPhz921rKQkS8Of8pCfjAtiYq9TE/zddIWJ4huclR/lc2qJTyUF172LmINcQJfAnBOGsFN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=31ISob5G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MHWJrSnQ0j1iQkgyVgRMpaNcFjIVKllyXaFmkHK5JRU=; b=31ISob5GKeZo9XnNkcOfYHKnPA
	AZhvT7VBzmzWxkA+uknWRi1wCi0uf8B8BUeXuY6/LirF8SHBz0uoJGziHK60LFoaP/FJevwGkBX9B
	qwlqI9zUbDYnMMZqVnxz1fcZURpH+ZUOnEGpXJiCi6r/Q2Q02cCCPshPgzpBXuo5nOQY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wT5is-005B8d-Rj; Sat, 30 May 2026 00:30:34 +0200
Date: Sat, 30 May 2026 00:30:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 06/14] net: ethernet: oa_tc6: Support for
 hardware timestamp
Message-ID: <15c67f3e-f2f5-41a1-b1d1-00cb622360de@lunn.ch>
References: <CY8PR02MB92493D70B9443A982AB0305C83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92493D70B9443A982AB0305C83162@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293282-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 97790609501
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +static struct oa_tc6_ts_info_tx *oa_tc6_tsinfo_tx(struct sk_buff *skb)
> +{
> +	return (struct oa_tc6_ts_info_tx *)((skb)->cb);

The () around skb should not be needed.

> +static struct oa_tc6_ts_info_rx *oa_tc6_tsinfo_rx(struct sk_buff *skb)
> +{
> +	return (struct oa_tc6_ts_info_rx *)((skb)->cb);
> +}

And here.

I've not looked deep into this code yet. What is the lifetime of the
data stored in cb?

> +
> +static void oa_tc6_defer_for_hwtstamp(struct oa_tc6 *tc6,
> +				      struct sk_buff *skb)
> +{
> +	if (!tc6->hw_tstamp_enabled)
> +		return;
> +	if (!skb || (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) == 0)
> +		return;

Can skb be NULL?

	Andrew

