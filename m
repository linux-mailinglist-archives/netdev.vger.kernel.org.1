Return-Path: <netdev+bounces-293115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNq5INSOGWpTxggAu9opvQ
	(envelope-from <netdev+bounces-293115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:04:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF24602A08
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4CEA3013B86
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE7A3195FC;
	Fri, 29 May 2026 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tlLWJsVY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBE31197C;
	Fri, 29 May 2026 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059855; cv=none; b=D1GXac6CXPc2CaA6oEm4HH7zwuREXBGH9CAF5rppDezFd5T0KYk0yhIDKstKvKx8Cq42oL91q3eobdJ6lyrkwz3r1plI0zxLGyax2Yrp3Mjtp3RAxvMybAjgmJBp0oBgWOhNjIRZyiJO1X0m21MSVhoErvKcAOZN2PmzJzxorL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059855; c=relaxed/simple;
	bh=OVQ0tA8+eFU5RLkX369uWTW1RTrTI3CHGxuTvryVfuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTw76OcRK2GOpMOZ7vTkJetWyf8TLb3RliFLWn/J+OaZdkRUj+DRkzINKrTuN8jkuRoPcUR2RjAh6dpGPR8uE6mXDpqMLJDbBiQB+/zV8l7GzZxNKcQRwf9HnYnnEySl3sJDwvQcjqmVnqeQL/00403CytH9cMYksQOrfXgbopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tlLWJsVY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BUsVTXtWac4HLSNT5dWtOS8zRSibeIPlKQyEy6fXA8g=; b=tlLWJsVY8p0/R9sesXCKHs094J
	PosCTQnW6A1Z05qQit3q+/aGqEuX1zhMcb+gezKm0VEXGYC23KIc90iqxTMMFcsVCWJWPdNBvjzYl
	lba/KNhFT6+GdSzG1ehzr+OyNAp9W9ub7MiLNATP9fRVBSj285n6FbYOmsfbv++53v90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSwsY-0055SF-7z; Fri, 29 May 2026 15:03:58 +0200
Date: Fri, 29 May 2026 15:03:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: ciprian.regus@analog.com,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/10] net: ethernet: adi: Add a driver for
 the ADIN1140 MACPHY
Message-ID: <a272f9ae-1958-456f-b177-7c966694c047@lunn.ch>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-10-37e5c8d4e0a0@analog.com>
 <ahlY8WSRO_HPmGtK@nsa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahlY8WSRO_HPmGtK@nsa>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293115-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[analog.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 1DF24602A08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Nuno

> > +static void adin1140_stats_work(struct work_struct *work)
> > +{
> > +	struct delayed_work *dwork = to_delayed_work(work);
> > +	u64 stat_buff[ADIN1140_STATS_CNT] = {};
> > +	struct adin1140_priv *priv;
> > +	u32 reg_val;
> > +	int ret;
> > +	u32 i;
> > +
> > +	priv = container_of(dwork, struct adin1140_priv, stats_work);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(adin1140_stat_regs); i++) {
> > +		ret = oa_tc6_read_register(priv->tc6, adin1140_stat_regs[i],
> > +					   &reg_val);
> > +		if (ret)
> > +			break;
> > +
> > +		stat_buff[i] = reg_val;
> > +	}
> > +
> > +	spin_lock(&priv->stat_lock);
> 
> Maybe consider using scoped_guard() and similar for other places?
> Marginal win though so up to you.

Please trim the text when replying so just the needed context is
provided. It is easy to miss comments when you need to repeatedly page
down, page down, page down to find something.

> > +	ret = register_netdev(netdev);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "Failed to register netdev (%d)", ret);
> 
> If we go to devm, this could be return dev_err_probe().

dev_err_probe() is not really about devm, but handling EPROBE_DEFFER,
and not issues an error message when it is not wanted. I don't think
register_netdev() can return EPROBE_DEFFER, so it probably does not
apply here.

    Andrew

