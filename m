Return-Path: <netdev+bounces-301033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A+MXGj0QOWrimAcAu9opvQ
	(envelope-from <netdev+bounces-301033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:36:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D13E16AEC05
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:36:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=m+MULcED;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301033-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301033-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBD7F3020126
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C769370D7D;
	Mon, 22 Jun 2026 10:36:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5699233953;
	Mon, 22 Jun 2026 10:36:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124575; cv=none; b=AS/NCL78ng3UFqQuc+hBv3yQ3ID9F7lRLiGhw+nvqCC000UrQGnvPHAQOatbC144OkpiZ8ylJ7TuNfZG4biDwPGcImPnqhbsc8DWc1JGoy1OdyKVqkYsu1ftb5AgQU7Vtt9pS9CMqv24m/JLkh2PRj6GN4nSTdLHJh7Sz4PNM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124575; c=relaxed/simple;
	bh=p+P6k40v6POcdPcPItQjOXliIhbq4DSDEPWa/3S580I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWWQ9YCEtjikGvcb+LezVCmC+jg5WRJqYVWNbkj4mluY4V0o4y1WO0fYudVD7n6Ct9EaUeJiZwcUQyVjJ6gvp3JgA9Uu5FWl8TEkvhNs2Z5e05YisyjXvcabxew5162s+ef+EqUHPXvBoPNDCUQtI1pRXksfBWCGBfhRLxa6iSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m+MULcED; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=id/hH3roivukEKrMQFRL72o3+KlR8rCe5EpGyffEesA=; b=m+MULcEDHYVEi811nM/inW0Avy
	MxJfQ+D2TqmEm7YKdv9whLy430MAT8+59aFzeKH1ZvS2iZWMZIsMIN+GqSfIE96sOJb6wmOMy7whO
	yl3zH4VUpOwk9YhXzNBHYvouSmwj+a0tdXM9sQqXMjFHi/fT425K8fURM0NGe7bFBaiM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbc0a-008oQg-WB; Mon, 22 Jun 2026 12:36:05 +0200
Date: Mon, 22 Jun 2026 12:36:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com, netdev@vger.kernel.org, pabeni@redhat.com,
	sean.anderson@linux.dev
Subject: Re: [PATCH v2 2/2] net: fman: use devm_kzalloc() for fman and rely
 on devres
Message-ID: <4692dda4-657a-4c00-9e65-cff4b79d19be@lunn.ch>
References: <20260619121328.922138-3-horms@kernel.org>
 <20260622090505.2418478-1-zhaojinming@uniontech.com>
 <20260622090505.2418478-2-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622090505.2418478-2-zhaojinming@uniontech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301033-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sean.anderson@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D13E16AEC05

On Mon, Jun 22, 2026 at 05:05:05PM +0800, ZhaoJinming wrote:
> The driver now allocates the top-level struct fman with devm_kzalloc()
> so that its lifetime is bound to the device and resources are released
> automatically by the driver core on probe failure or device removal.
> 
> Remove the explicit kfree(fman) from the error paths in fman_config()
> and read_dts_node() to avoid double-free/use-after-free and to follow
> the devm_ allocation convention.
> 
> After of_find_matching_node() consumes fm_node's reference via
> of_node_put(from), the post-muram error paths no longer need to clean
> up fm_node, so replace goto fman_free with direct return ERR_PTR(err).
> 
> This change complements the existing use of devm_* resources (irq,
> ioremap, etc.) and simplifies the error handling paths.
> 
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>

Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please read it all, but see section 1.7.4.

    Andrew

---
pw-bot: cr

