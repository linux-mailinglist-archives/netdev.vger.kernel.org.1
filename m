Return-Path: <netdev+bounces-285393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LCjMDGx/GnlSgAAu9opvQ
	(envelope-from <netdev+bounces-285393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:35:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685ED4EB252
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1C9C300AB15
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859B137C91A;
	Thu,  7 May 2026 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcWBKvcp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B21A316E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168110; cv=none; b=PAtFMMSYxlSKonwWq1TJ+FcKa4V1IcQKWkU1WAheiY/FUZms/ruiv8UdksH82GeekV+BzzRbgeLXiyIawE9cqQ3QTVIWGeXRIl6Nt8gyaJVgcgtsygXucaDoxHtniuYN13IIvDo2MLTtTpEzKtlTcD34p2Ve5pbP6VjufoV13GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168110; c=relaxed/simple;
	bh=rzn+mXwuxuGBqeL9f0zlEdgdDoITVl3qMXqi0a/HbI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3XVqw+TFXh0IRka2qL5U9TszkKg1sjXiRXO8ONftI7DLi7ywxvRJa32azlTJjo0NTxQELpnaMEvow0M650icEtZ1jRjD6YZ8hzc+Z1NMymA5AyIMeeaCyhoy8aEc7cCh+02OdTEREsjMoESuw4RuzPxCd/ZGwp+k24uRDm/+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcWBKvcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A07C2BCB2;
	Thu,  7 May 2026 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778168110;
	bh=rzn+mXwuxuGBqeL9f0zlEdgdDoITVl3qMXqi0a/HbI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WcWBKvcpSgYbkBNyr6JNT1JrlsNQNjuDcOrxP9Q04JR7iG1SGc53yJH9QuWx5bU6x
	 V3bLy879FPuVi32guDbf+7BM6eD2rG0QsVrSlIBxJHWhd6nwvx/fOu6yjzWxUC7lsf
	 ppTsFMDsQK6dNf9+DRUSOd4udu7qMWEQZ7ICQIc9NUqxdGbHEgFSC35l5T9xjZTsNS
	 l4W6WgDn9gxuCsAeA9SdmMeOdmR8pfwnBXaWyeo3hLoxjnlKlKKRQE58NzxMwvsLRV
	 OBQl58iKhbpDNK1WmaUAz0L0ER1vrXEEI+o6c88vRJ1twtcyZiK8t6jU3Do5lOnVhB
	 ZNuiPLuNt/Row==
Date: Thu, 7 May 2026 08:35:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "chleroy@kernel.org"
 <chleroy@kernel.org>, "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>,
 "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH v2 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Message-ID: <20260507083508.681108f1@kernel.org>
In-Reply-To: <AM0PR06MB1039657EB2FADD7BDAD4159D5F73C2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260506111529.2919079-1-holger.brunck@hitachienergy.com>
	<20260506161629.5488a643@kernel.org>
	<AM0PR06MB1039657EB2FADD7BDAD4159D5F73C2@AM0PR06MB10396.eurprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 685ED4EB252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285393-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 7 May 2026 15:07:35 +0000 Holger Brunck wrote:
> > On Wed,  6 May 2026 13:15:29 +0200 Holger Brunck wrote:  
> > > When the device is removed all allocated resources should be freed.
> > > In uhdlc_memclean the netdev transmit queue was already stopped. But
> > > at this point we may have pending skb in the transmit queue which must
> > > be freed. Therefore iterate over the tx_skbuff pointers and free all
> > > pending skb. The issue was discovered by sashiko.  
> > 
> > And you tested this how?
> > 
> > Given the questionable v1 I'm highly hesitant to accept patches from you if you
> > can't test them.  
> 
> I tested the patch on a ls1043a board running HDLC in busmode on kernel 6.12

Please add this to the commit message, as previously requested.

