Return-Path: <netdev+bounces-285076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJicAlPL+2lsEwAAu9opvQ
	(envelope-from <netdev+bounces-285076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:14:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1774E1784
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF91330090A5
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 23:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C6831716F;
	Wed,  6 May 2026 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjkP6/4e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE66314A95
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778109263; cv=none; b=TE9ngIGB7Bp6XOlL6CgMUKdJwpXWp1qsYY46UqEdXfKR15UvNWhrNLvKmJHkyETZL2Q017gBgUkT+ZEo46VVfVKEtiBelR3kTlAKLKNbvikUQfxuEgCPi7lECPeTJmsDvyiphV48un0nV/B24u20MdHKmBasos0Gc9UMj3mmS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778109263; c=relaxed/simple;
	bh=UjfnE7/O3qZFWScF1cgpg1Gv7HfPB1Y2MekRvxqZkh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKNUPIHgpopsSgyFUL9vddkmGqTQkHiDKUnpZqLFCnLegQ74u4FLzbijcIjirp9q2HbkWMPwv4snT+axxOTcjMsVRNXA+JbYM2YiQCTJ+itnGPVvJJmBCzTHkFRdcArNoNJfnaMD/XLJi+2QNsfHlrOsZcqNgfzJ12EpsPQK+oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjkP6/4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC0C2BCB0;
	Wed,  6 May 2026 23:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778109262;
	bh=UjfnE7/O3qZFWScF1cgpg1Gv7HfPB1Y2MekRvxqZkh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VjkP6/4epoQ/cKMZAR19PddFjdr5Qm1O+9vM0Bx9MMaGfnxYkzxZz9eOj/zhzwVgQ
	 syrGs+VDc8H/Jo6W7MrqXO6vIwJHD0/jHMVOPmIWagYOprhYU0OQwM/d/XwOXehQSy
	 JAdpznZxFGX3KSO9ei+SzmOk2omMUjYeuRJdsjQ5KgDpWyRHrkxBsYWnw3I56r/Vyj
	 vsOTXlO166IbSS7Cf9TlQUhk/uNxc2r63pnIUFJXXml7idI7KM1kbrhEMV/GzLb3wf
	 jL+79F2D/3wOZl9X9yfd/JS3mRBQx7vYG3iC8niitTJ9nGpXPqOS4SoE/I2dnSAFTd
	 U00PVqhBGR4rg==
Date: Wed, 6 May 2026 16:14:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "chleroy@kernel.org"
 <chleroy@kernel.org>, "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>,
 "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: return NETDEV_TX_OK if skb
 was freed
Message-ID: <20260506161421.4e15d466@kernel.org>
In-Reply-To: <AM0PR06MB1039608A8965FE12520901515F73F2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504174406.2229693-1-holger.brunck@hitachienergy.com>
	<20260505182220.29e5f34e@kernel.org>
	<AM0PR06MB1039608A8965FE12520901515F73F2@AM0PR06MB10396.eurprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9C1774E1784
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285076-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Wed, 6 May 2026 09:35:00 +0000 Holger Brunck wrote:
> > On Mon,  4 May 2026 19:44:06 +0200 Holger Brunck wrote:  
> > > If the skb was freed in the ucc_hdlc_tx function and the packet marked
> > > as dropped we need to return NETDEV_TX_OK. Otherwise the above layer
> > > will try to requeue an already freed skb.  
> > 
> > Is this really true? I thought negative returns mean drop.  
> 
> the API suggest to only use NETDEV_TX_OK or NETDEV_TX_BUSY as return value.
> I checked several drivers and they are usually returning NETDEV_TX_OK if an
> error occurred and the driver consumed the packet. But you are right
> dev_xmit_complete will also return true if the return code is smaller than zero
> and the packet is not requeued. Should I update the commit message or should
> the patch be dropped?

Drop the patch. 

