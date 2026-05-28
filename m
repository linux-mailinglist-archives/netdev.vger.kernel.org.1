Return-Path: <netdev+bounces-292854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gByUC2CzGGr9mAgAu9opvQ
	(envelope-from <netdev+bounces-292854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:28:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C58535FA623
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D36D3016D09
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BD9346781;
	Thu, 28 May 2026 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hLnmZu6S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F734B697;
	Thu, 28 May 2026 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003676; cv=none; b=W10ukockDSs8scy2i5UmRVxgYPJH0xJzydiwBYjU4ljn4r+3zf3+nktz1zwz9IkLWI6agXnPeCJO50dskY99GHxGVrMGQ6qt/4KDkuBHXbKt37Qux0l5fHq35kA9KNRKDZg/VReLy5MvXiPJyTV1NPvpemI7q+Ez/aBWP/rzgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003676; c=relaxed/simple;
	bh=EgK7UFGhkhHo5Y731leXYxcPIXYYldwgOalPLakyZuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COfPUZ82cR2RQb87Crki3NxHkz3Lp1emnseeJlsfJFU3lFgSvZBUNwmRtK90Mc7T5q15U1dJaKSM9ib4ZAS0IlxnMpszBw4ZicmvPD9LDBHqx4p3HRw+FATOkJ/wdpjqDPLzYTSl07oDiUB7EJE+E6210a8AilSaMKhrW8YKjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hLnmZu6S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0Us6JpRTk6mfnZ8x0RrWhEDsIYcKaLSaIeJxYFEH0kU=; b=hLnmZu6S4Cs2UN+H7DA1OrhwtF
	Ip2pSl5zI0yG64CPlvR6JkeP8Xb2w6A1k+hDjV9k63lznOiq269xmC6es11CyWBiW4khkReBmNIUW
	IUP41JgJwzj0dJ8hVWdm6TYOWajOyTZCXHRBDna3f5TQiFDtC7jqWJAberTFYeGZI3Ls=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSiGa-004xuJ-Pz; Thu, 28 May 2026 23:27:48 +0200
Date: Thu, 28 May 2026 23:27:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, marek.behun@nic.cz,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Subject: Re: [PATCH net-next v3 2/3] mv88e6xxx: Refactor 6352's serdes
 functions
Message-ID: <da75a54a-2978-4001-980b-702455f35b9d@lunn.ch>
References: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
 <20260528210310.1365858-3-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528210310.1365858-3-fidan.aliyeva.ext@ericsson.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz,vger.kernel.org,ericsson.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-292854-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C58535FA623
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 11:03:09PM +0200, Fidan Aliyeva wrote:
> Changes:
> 1. Replace serdes check by mv88e6352_g2_scratch_port_has_serdes in
> mv88e6352_pcs_init function by mv88e6xxx_serdes_get_lane function making it
> more generic.
> 2. Replace serdes checks in mv88e6352_serdes_get_* functions with
> mv88e6xxx_serdes_get_lane making them more generic.
> 3. Add lane argument to mv88e6352_serdes_read so it can be reused later for
> 6321.
> 
> Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
> Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
> Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

