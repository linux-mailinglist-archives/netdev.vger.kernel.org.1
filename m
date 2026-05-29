Return-Path: <netdev+bounces-292917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHdGNy3oGGruoggAu9opvQ
	(envelope-from <netdev+bounces-292917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:13:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBC35FBE50
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A742F303ACFE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79B734D910;
	Fri, 29 May 2026 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mUhSMwXr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EF319067C
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017085; cv=none; b=C/KVDXYSuPfarYBS0YP6ZPPgAj582/KcGqigIYeIFY3ItsnJS5XSVMBAVh4jXlkXm1Mh/saKchWabRxDLH8k4PY4+3cIA/AxybCz+AzgpXtApdcqPTyxl4qsHeU9Hcu7+T+WKiGQfKBj1ChZ5Mq9ZjhcxOxkKE3N2XdJtM7iO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017085; c=relaxed/simple;
	bh=IXFFaTUOr5SmQ8Ycsy9ason09ZXFMZg9YIBLODfqgm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGHlrKujDLUmLRsZXH3WU1lrzJkKy7uthDvV01W1T/muCF4QA881nS7dAiLpgsYeBWgghK4BNJj7dYD8VgED6HJbV9EUljxKGTcZGH8HVhjNbtmm2mYJ127hfkZLKxvXyVBQdm+bO/7DaGcWcp9dNXlqGvg/nYw7BIEYjYXbPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mUhSMwXr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y7aAYuuOXsoIWmHusGu86t4YWqk38FGU7P4VrVz3G8E=; b=mUhSMwXrRHgYZKx06PuD7i8Qo0
	X+i/cA53n69LmZ9ba7UOINuGse5Oymo51Y70xHzp5y01ee5Q7IFOkI0b4kJQGhY0QAhHd2O1ApRxl
	vxYMe/ercggYQcTqzLnwPYekE+xacmXsxxxOXXyo3K5Q7SF5je9wGgPYULpRwcYEuu3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSlkm-004zLp-MQ; Fri, 29 May 2026 03:11:12 +0200
Date: Fri, 29 May 2026 03:11:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH net-next v2 1/4] net: mdio: realtek-rtl9300: provide
 generic command runner
Message-ID: <97c23300-8a47-49c2-abf0-3af2e257403a@lunn.ch>
References: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
 <20260527163449.1294961-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527163449.1294961-2-markus.stockhausen@gmx.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292917-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 5BBC35FBE50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 06:34:46PM +0200, Markus Stockhausen wrote:
> The current bus read/write commands for C22/C45 are RTL930x specific.
> Avoid to duplicate those 200 lines of code for the RTL838x, RTL839x and
> RTL931x targets. Instead provide a generic command runner that is SoC
> independent. The implementation works as follows:
> 
> The runner will take a prepared list of the four MDIO registers. It will
> feed the data into the registers. This generic write to all registers
> (or to say "a little bit too much") is no issue. The hardware looks at
> the to be executed command and will only take the pieces of data that
> are really required. No side effects have been observed on any of the
> four SoCs during the time this mechanism exists in downstream OpenWrt.
> 
> The last fed register is the C22/command register. This will be enriched
> with the proper command flags from the caller. The hardware issues the
> command and the runner will wait for its finalization.
> 
> Besides from feeding all registers the runner emulates the behaviour of
> the old code as best as possible
> 
> - check defensively for a running command in advance
> - Before this commit the driver had different MMIO timeout values.
>   1000s for command preparation, 100us after writes and 1000us after
>   reads. The new version uses a consistent 1000us timeout for all
>   of these.
> - return -ENXIO in case of hardware failure (fail bit)
> 
> As a first consumer of this runner convert the write_c45() function.
> This is realized in a multi stage approach
> 
> - a generic otto_emdio_write_c45() will be called by the bus
> - this will forward the request to the device specific writer. In this
>   case otto_emdio_9300_write_c45().
> - There the command data is filled in and the additional helper
>   otto_emdio_write_cmd() will be called
> - That adds the write flag and issues the generic command runner.
> 
> With all the above mentioned in place, there is not much left to do in
> otto_emdio_9300_write_c45(). It just fills the register fields and
> calls the write helper with the right command bits.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

