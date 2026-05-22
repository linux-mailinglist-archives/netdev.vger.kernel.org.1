Return-Path: <netdev+bounces-290836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDl9D6xLEGq5VwYAu9opvQ
	(envelope-from <netdev+bounces-290836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:27:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA95C5B3EC2
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60F663074C44
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1F537B02E;
	Fri, 22 May 2026 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3sAJHlb1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29837FF54;
	Fri, 22 May 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452108; cv=none; b=WKc6qK1/3jVnm4JdA6+ClDBZEDvDQqAVojeZ+W5ppWI9EjO/lFci5cuR5/KNor/uhv29kZZPHr1jD3V+D1ZDPVepDr7TwLTZ5zPCR7yPx+TWV7WMgwHkaOtr8aVUn5XdRpvn0B18E6koTwnMq5/dSbHoU3MbHBphWurhlj8lu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452108; c=relaxed/simple;
	bh=IHc2gXg8/c2V4nlATDcj7K+fCqfxwvZwhAHeBn8+R2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAnYK1l5v1KcyHJzwFSn0zPXbH0+ncwJG4dvus/xzAlw426r2+vrX9AImzvrJUVIQLam6eBHN+OuisaNxdbkxKtoSYIqt3fjnVjtDmzmkDrmfDS69qjYSz/kQIbs1YH0J6BghfVYBlMA6g2uZAJau9vfZ6wXLVJB1EkZ5chdXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3sAJHlb1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OP5kDDbyBhNllN1CVAUniMuZiS5jxiyCHBQ7Quk3BjE=; b=3sAJHlb1Y53fSEQSPVdAZv/eZp
	Q8qp25xnlsxFpfIamFD5kztSb+v2mEAFDvjR3XMwVVWbyJtolvV9oZu5mPdm9tVtYeMzClk4AKhUn
	ykIWGY3DIiK+ciO6VW26TzXFSoknY2RgYO42+xJe+6vyDFkpwLsyNaZH9nJDx8h+00N4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wQOm8-004AaJ-07; Fri, 22 May 2026 14:14:48 +0200
Date: Fri, 22 May 2026 14:14:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Abid Ali <dev.taqnialabs@gmail.com>
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] net: stmmac: mmc: Remove duplicate mmc_rx crc
Message-ID: <12d899f2-3baf-4ad0-8834-a489cba543bd@lunn.ch>
References: <2d702678-5b2b-451e-b692-228efcbbefc4@lunn.ch>
 <20260522065434.6231-1-dev.taqnialabs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522065434.6231-1-dev.taqnialabs@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-290836-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: AA95C5B3EC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 06:54:34AM +0000, Abid Ali wrote:
> On Thu, May 21, 2026 at 20:44:53 +0200, Andrew Lunn wrote:
> > Thanks for the updated commit message.
> >
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> Much appreciated.
> 
> Should I send a v3 with the Reviewed-by trailer added ?

No need. patchworks will pick it up when the Maintainer applies the
patch. You only need to append it if you need to send a new version of
the patch.

	Andrew

