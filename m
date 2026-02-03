Return-Path: <netdev+bounces-256307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DJqCkj/gWmYNgMAu9opvQ
	(envelope-from <netdev+bounces-256307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:59:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BF6DA4A1
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABC2E30886FE
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B403A1A37;
	Tue,  3 Feb 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ktj+Ou+G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580603A1A21
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126980; cv=none; b=oRI+uCwmJxpc2o32YEfyTKWpsDZB/0sKJMcYx4Qe8Go04xnKegnso80mVtq6lEgANysLXz6Nf46rHuuKehusaeW41eJcc0fHzND+yKSK4Rmlg+nuu+Z85qab9U/ly6OUUs0UG90XyWs6fv51R6p8GwC6IaypQeYfXbKdQj6TV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126980; c=relaxed/simple;
	bh=Zn/20ajFXurlM+wAgJ/1iIKp14ol0n+sjyOlUQvMO1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv9ov/vVGfRO2NhwE40FRwV0XmkHJcL76/7RMm1kVN0l4oUzF9wz8ciEG6JZ+HxpTXqWzLv54Thfay5HhEXMxAKErT9lN4wp4aDAtDn6OOtvSb8HMWr6CMj52uudnhQcsliCgZkffZ9x2a3BFdARPSa4mvLw3a7UDzEVLGSdU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ktj+Ou+G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pTryl0FuPFRFzRApW9cwBAuU6sg3HyILzQ1MYdu+I2o=; b=ktj+Ou+G3Pi6RAjxGSZVPBO6M7
	uFs83TvD4qyfXr2TPm+LVXy9TJFUPNEQy2ZjU//a8fBsAvx6StA0rFDTin2TcTLUH7++TWLH9zoSE
	MZbziwV9jdY2m3fjmQsdvdtGWRf+A3btW/AjzoWaFWB4xm4p+ROVpb8Jf9QBTXWGWpiY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vnGt6-005x8S-3J; Tue, 03 Feb 2026 14:56:16 +0100
Date: Tue, 3 Feb 2026 14:56:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v1 2/7] net: ngbe: improve the reset flow
Message-ID: <4ddc6f7d-ee6f-48a9-857f-a10448815675@lunn.ch>
References: <20260203075759.5852-1-jiawenwu@trustnetic.com>
 <20260203075759.5852-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203075759.5852-3-jiawenwu@trustnetic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256307-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88BF6DA4A1
X-Rspamd-Action: no action

>  static void ngbe_reset(struct wx *wx)
>  {
> +	int err;
> +
> +	err = ngbe_reset_hw(wx);
> +	if (err != 0)

The != 0 is a bit odd. It looks like rest of the driver uses if (err)

> +		wx_err(wx, "Hardware Error: %d\n", err);

I also wounder if this should be fatal? Should ngbe_reset() be made an
int function so the error code can be returned?

	Andrew

