Return-Path: <netdev+bounces-286819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCtiIrU6AmrmpAEAu9opvQ
	(envelope-from <netdev+bounces-286819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:23:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8424515C45
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 888303013248
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047083793A6;
	Mon, 11 May 2026 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NNdRg8IA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE342E3B15;
	Mon, 11 May 2026 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530726; cv=none; b=R3zzLiV74NEr3xrEtrFXl3cp2QER601dZ/0cZaXczU5OUNn/pNA3KwYlxghGIPP8p1wmhsIJCPo/Gvft36ubHfUvd5RmrfuLL0VuWASaF81q5tR9WYDjowS278q2MIaSgq1X7jOzmSdkpR9Iyd/rNNXYpsw9EP9I0Xzc0kd/bgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530726; c=relaxed/simple;
	bh=0VjGp+tXbz9uFrh/GLx9A0gDKs6zfM8IUPWa4rbivE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhdJWw6ajz8XkCxtj1RYvA+Mr66H2tF9zyqMhrNy2sbiFDZytjnoGzOL4NTQkxL6JaA8CTJGav8fPoe0P7zK+M3Ez1LevVhQmzqnbRUTrUdryid8RGmLmi4UnJqTGCRqAx76EyC7TDvxPOvMHE9/a33wJ90Sb/3bjIb0fzzCcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NNdRg8IA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mtQa3BI1a6Wl1vb+E1fQiei8z4Ufqvm312kxxeSce2M=; b=NNdRg8IAe+w77wDtdltpkGJUCl
	G/yp/TSl2Ey1sQDaf5qCEi9XoYst15iVA74KyRN7Mjo4/S2h01vhFEH2VvjDB1ZrzCyRhLTVGvyX4
	cEfBzFouz+X2fr8Sq6vIDsGjv/N77ZY2m9GuHQ+hrTVhA0AunDqfDUrLhPs+WOkGFuok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMX5G-002R0L-Lc; Mon, 11 May 2026 22:18:34 +0200
Date: Mon, 11 May 2026 22:18:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <657612fb-747f-4506-8a7f-e9536d7c4c2b@lunn.ch>
References: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: E8424515C45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286819-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> +static u32 phy_addr_list[S2500_NUM_REGS] = {
> +	(0x4 << 16) | 0x8000,

> +	(0xC << 16) | 0x10,

Is 4 OA_TC6_PHY_C45_VS_PLCA_MMS4?

0xC is your vendor 1?

These should probably be moved somewhere public:

#define OA_TC6_PHY_C45_PCS_MMS2                 2       /* MMD 3 */
#define OA_TC6_PHY_C45_PMA_PMD_MMS3             3       /* MMD 1 */
#define OA_TC6_PHY_C45_VS_PLCA_MMS4             4       /* MMD 31 */
#define OA_TC6_PHY_C45_AUTO_NEG_MMS5            5       /* MMD 7 */
#define OA_TC6_PHY_C45_POWER_UNIT_MMS6          6       /* MMD 13 */

and think about how you can represent 12 using a #define.

    Andrew

