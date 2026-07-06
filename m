Return-Path: <netdev+bounces-305114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TPbZCo/lS2pOcQEAu9opvQ
	(envelope-from <netdev+bounces-305114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:27:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A35713DAD
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:27:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=oMAXZIfX;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305114-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305114-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C86843306FE2
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B8B384232;
	Mon,  6 Jul 2026 15:14:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BC383C8D;
	Mon,  6 Jul 2026 15:14:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350866; cv=none; b=s1TahoALDjx2B0pptmN6Hr3H6OqKMOq7vE+osqc8j3rVNd3BW3TXijNuxjnVemsmmr1Wo95HjACN+XWb6NKhfkiIFBnBi6wNexfs2WLbCmL0dQ1CoExhvlOXQdWkUzrik5H3cAzAjkNjk4XNcV8wVpC1WMfTAGuqTpf5nhzvUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350866; c=relaxed/simple;
	bh=mrlxGSjj9QqNo+lP5Xdb3XGmfRsPsv7mmKFtUSLE6yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty4dJoiKa1Np0Wt/DM2nreqaheN1Wd47MmRis6PkoQBlk3JBSQMTIyec5/ZVeDirEdjKfmWqkr5WFF0WMm+LcGhQiMPSLjhqlXO4FceD0n6rJrm/sdwFKlY9pHSGgkJqJ7tj4f6cltrxtXsuExTaQmvyextxfmM/jM7KbCE1xnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oMAXZIfX; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wNZE3VgZ4LBQ32jJECYzyYgXQTt23JxegdPIx4PiGAI=; b=oMAXZIfXtOyR6kd/mqs8q2lLz4
	Z4xwwtRpWKp59t2Fh3tVaxij2cLpoZPu8rLjgnQTkkOAp/g7SbcUs6ME5CEoLoAfUbHIgypoGIWHO
	bZ70hYWPPTvegolzdSUJ1YvjSEFTPvX2MNKLmnXn8Gjurzxqhfmrr5nJdE6+TSoAGuVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgl1X-00B0jy-Vg; Mon, 06 Jul 2026 17:14:19 +0200
Date: Mon, 6 Jul 2026 17:14:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: solos-pci: validate DMA receive size
Message-ID: <8ef7d67f-c47c-4342-a411-4ac126abd757@lunn.ch>
References: <20260705084504.54281-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705084504.54281-1-pengpeng@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305114-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.sourceforge.net,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:3chas3@gmail.com,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73A35713DAD

On Sun, Jul 05, 2026 at 04:45:04PM +0800, Pengpeng Hou wrote:
> The DMA receive path reads header->size from the RX buffer and uses it
> to extend the skb with skb_put(skb, size + sizeof(*header)). RX DMA skbs
> are allocated with RX_DMA_SIZE bytes, but the DMA path did not check
> that the device-provided size fits in that buffer. The MMIO path already
> has a similar size check against card->buffer_size.
> 
> Reject an oversized DMA receive item before skb_put() and drop the
> invalid skb, then continue through the normal DMA RX refill path so the
> port is not left without a replacement receive buffer.

Subject: line

    Andrew

---
pw-bot: cr

