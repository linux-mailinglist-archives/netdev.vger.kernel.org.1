Return-Path: <netdev+bounces-284604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPEiHJ2B+mm/PQMAu9opvQ
	(envelope-from <netdev+bounces-284604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:47:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA34D4CB4
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70046300CC31
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 23:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A8D3264F1;
	Tue,  5 May 2026 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSZqag/N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66A31A045
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778024857; cv=none; b=pQBOS/uOz9JL85dUAB3JUQTwzGoz3FEHi3SScaTQZRUfth3nZMZym53XwnAoijnfLDYmZ1J86O3KYSJiqjz8KgvZ35EewLqEdb5I9iY6JRsH5FJ14hoovkvwlPzSShblR1VyU5jRVPDBs1FCrWraESaBsbfcK2QLUEN3UqOK/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778024857; c=relaxed/simple;
	bh=3r0ZNyX7X5IFV2nmj70h8MMAibad4YbMGo46z2KFL3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQqrjmtHXaURJsFgG0MWkLWQP1ZthW5XRmNfYSbz6MWLRKmrv8ontn/Szen0gFlfYKypVIhvJCsIwD6r4mb+4ThAdshxYurzUI/rgleysIlJNNmJCHjPvLO3bCO6JJCGeTog818Jae0WSxdIKF9NQPMzo3X5u50SYALDfkuQJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSZqag/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4839C2BCB4;
	Tue,  5 May 2026 23:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778024857;
	bh=3r0ZNyX7X5IFV2nmj70h8MMAibad4YbMGo46z2KFL3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mSZqag/N7r8AJmkmWKSMWc2XDHcFWL0l2IRahDmpTvkdMKpw0q5vX/uyu1YxkwexJ
	 OJEYOiGJiXJx/edjOD5FZ0SnOBHB5aBpjgoiy+OGXUW2gOYQAclwhnUE/wheB9K7kU
	 J+V0ow0Mf25DcPNpw5YCZgeF4/zaFAJ2eWlpOxdqKgBpnSPCRIVih0Li0BIYc3nIzv
	 Wxxm3XLwajFtHA2Iti3ZedeI3UGVgY9ZmDOHBKpMuYxsthWO5Je2ARt4n6OyPkb+lg
	 8xHsqfmznJ9lUUK8MiY2Tp1COk/s+/rIXhmTZ+nWHY7yY2v9bulRxbchQfXwSEOPp7
	 Ie/iBEug+i0kw==
Date: Tue, 5 May 2026 16:47:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "qiang.zhao@nxp.com"
 <qiang.zhao@nxp.com>, "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Message-ID: <20260505164736.26d203a8@kernel.org>
In-Reply-To: <AM0PR06MB103966EF99B706158C49CB3EAF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
	<3e1a653b-81bc-4008-8f84-77c823aeef49@kernel.org>
	<AM0PR06MB103966EF99B706158C49CB3EAF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C2EA34D4CB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284604-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 5 May 2026 08:33:34 +0000 Holger Brunck wrote:
> > I don't think you can just kfree() an skb like this.
> > 
> > I think you have to call dev_kfree_skb_any() instead.
> 
> yes you are right or at least dev_kfree_skb() as the error handling code in
> ucc_hdlc_tx does.

Please make it clear in the commit message how you discovered
the issue and how you tested your patches.

