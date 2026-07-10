Return-Path: <netdev+bounces-306632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ghuBAR8mUWoqAAMAu9opvQ
	(envelope-from <netdev+bounces-306632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:04:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B0B73CE1F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:04:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=yqGM8TC8;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306632-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306632-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F772305894F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC44844210E;
	Fri, 10 Jul 2026 16:49:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DB4418F2;
	Fri, 10 Jul 2026 16:49:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702172; cv=none; b=EDd6VO57MFOS+wFg0IsWdPXRvTtX2ezN+/m1kle0/mnWGapz8WKUQDm/7vbE+nem+vyPfqte3RHW6f2v8F4HzRxz4cysV7vBU7GnUDpwQJIvCyb0V37VbMXHD2q3u2cltSD399EoPeP44pwbLFun7TXVjpAXgMv0TLmE9qk36E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702172; c=relaxed/simple;
	bh=LIWX7JGoFjuB4lkn5HoQseNyWV/4TB8Hwgp7oMlg2a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1IWjHI8jp6ne0hHl4jGurCUuYHQUvVL1mdpSvPo1of6vLFiGdztte2lky0y5FNyc2wcGgZuJDeow81vrwVJgnQ25F/cF6jXfuhXwMYQszPrBV4Ck7yCMQ8iyMWjVPklajv+oRCBPpeCxaqRZnT4n9xNbFLZXvm/Ueuzka3x8BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yqGM8TC8; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ctpw6H5oitgKah3XmofQDzLZrombiT2hiX7qbOqdOHA=; b=yqGM8TC8D5G63SEgrNyIFMo1ni
	YHDUODa82SvLG5OFbeYUUtoHPcmMBgGi901C2tNI6+g6WketgPWn3kh6zM/OHkG3cDbrXl3rwJGlX
	Rco81EFU5kClMmBr05IrxW44tUdOQZKovbC+8sf8SYbOqt6hr9HLueV3hFlX22J5Pthg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiEPe-00Bfjf-3w; Fri, 10 Jul 2026 18:49:18 +0200
Date: Fri, 10 Jul 2026 18:49:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: vadik likholetov <vadikas@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bhadram Varka <vbhadram@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: enable the MAC on link up at 10G on
 10GBASE-R
Message-ID: <fa9ea443-a8b5-433f-a4b4-e5c73afc4b25@lunn.ch>
References: <20260710120908.3731591-1-vadikas@gmail.com>
 <f23adbcc-6f9f-4828-8de9-b85c4450b4b7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23adbcc-6f9f-4828-8de9-b85c4450b4b7@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306632-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:vadikas@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:vbhadram@nvidia.com,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84B0B73CE1F

> I suggest that instead of this fix (that is ommiting the 5G case btw), we rewrite
> the whole ctrl assignment as :
> 
> 	switch (speed) {
> 	case SPEED_100000:
> 		ctrl |= priv->hw->link.xlgmii.speed100000;
> 		break;
> 	case SPEED_50000:
> 		ctrl |= priv->hw->link.xlgmii.speed50000;
> 		break;
> 	case SPEED_40000:
> 		ctrl |= priv->hw->link.xlgmii.speed40000;
> 		break;
> 	case SPEED_25000:
> 		ctrl |= priv->hw->link.xlgmii.speed25000;
> 		break;
> 	case SPEED_10000:
> 		ctrl |= priv->hw->link.xgmii.speed10000;
> 		break;
> 	case SPEED_5000:
> 		ctrl |= priv->hw->link.xgmii.speed5000;
> 		break;
> 	case SPEED_2500:
> 		if (interface == PHY_INTERFACE_MODE_USXGMII)
> 			ctrl |= priv->hw->link.xgmii.speed2500;
> 		else
> 			ctrl |= priv->hw->link.speed2500;
> 		break;
> 	case SPEED_1000:
> 		ctrl |= priv->hw->link.speed1000;
> 	case SPEED_100:
> 		ctrl |= priv->hw->link.speed100;
> 		break;
> 	case SPEED_10:
> 		ctrl |= priv->hw->link.speed10;
> 		break;
> 	default:
> 		return;
> 	}

The bug description makes it sound like it was not obvious to
debug. So maybe put an error message in the default: to aid the next
developer who hits it with SPEED_14000, or whatever comes next.

	  Andrew

