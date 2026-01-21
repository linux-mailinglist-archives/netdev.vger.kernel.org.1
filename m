Return-Path: <netdev+bounces-251886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPdxHPLdcGnCaQAAu9opvQ
	(envelope-from <netdev+bounces-251886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:08:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0076F5829E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 074196CB86F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F18547D923;
	Wed, 21 Jan 2026 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GEjxzqob"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A241322D;
	Wed, 21 Jan 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002231; cv=none; b=sXGJa0q1ZLGOzOJrt6IWRQy9TBm6xVC6zXn/I+EYAWOuyZyYbOSJB5UmM8SKB+e6f9F6DjWHBWGpo/KmS37E064lCKMnUHxU2O3V5KhvVliHgGxNcOfvxluDicgQppLcUk9ug+zXWyq4BXOupaUJDTD2PxDDy94tY3mFrSI9giY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002231; c=relaxed/simple;
	bh=tnpatR80AdYbdh4qpMuKqyLO03x9xSRyZzw/5Mp78wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfbT4QpHCykC2HSImyqhfrRnZpwJt4DxWqvRHj4p0wkbPbho/1CG6LqZY9/2yXovs13QscffxpKaquLNOCPeNM+WXNn79v2tYgTiFX4WQxQnd6ufEriVlswv3w3zHevR/AvCZVwqebiBMm/e4t52U694BW13/ZzAs9ZddbHk6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GEjxzqob; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9stp7G8+jx+wDU2rs7p5oT5keVe5sNUsqmxQNNXqt2w=; b=GEjxzqobru254gC3J7+TDzCEDi
	i2iijfCHprMNPB6IdW95h8Zz5cfA/ixdbgtBwxuHqSrs15CkzwezfSQbSoraSwhTuXvPAtEQ/hXSp
	g6ZDcACxw2o8ajaSeANwxKCLgnzBThePbDbZhDBB/cgYK1vP9DDfA/imJKzjmf2Y7+Hw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viYHs-003p2V-MT; Wed, 21 Jan 2026 14:30:20 +0100
Date: Wed, 21 Jan 2026 14:30:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: ethernet: litex: use device pointer
 to simplify code.
Message-ID: <17e6bdc4-a38a-4486-a92b-bf9a1f9a4f8a@lunn.ch>
References: <20260119040446.741970-1-inochiama@gmail.com>
 <20260119040446.741970-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119040446.741970-3-inochiama@gmail.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251886-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,antmicro.com,gmail.com,jms.id.au,vger.kernel.org,gentoo.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 0076F5829E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
> -						      struct pcpu_sw_netstats);
> +	netdev->tstats = devm_netdev_alloc_pcpu_stats(dev, struct pcpu_sw_netstats);

Is that longer than 80 characters? netdev keeps with the lower limit.

Otherwise

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

