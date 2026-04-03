Return-Path: <netdev+bounces-274782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHiHEjIJz2kNsgYAu9opvQ
	(envelope-from <netdev+bounces-274782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:26:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948E38F6F3
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D233026C24
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7184A21CFEF;
	Fri,  3 Apr 2026 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XMSm2tcy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E855849C;
	Fri,  3 Apr 2026 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775175983; cv=none; b=SovZ2ThTi4S0neW4y7JErfDUD+KPCXSsl4eh+YOk2C5bkbIM6rWrzte7Ne/lB8NDsy1DVU+yW32SI2vGYUgrSAoleI2s+7wThsWSUMyhhig/FqvqF0vqJfvFZwQS3xS9irT+ycF5sSXLCmTd6ZxGKYPxrN6d3Oy96u0xDrK4Woc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775175983; c=relaxed/simple;
	bh=nIDYs2vgAJJTESx/ohCk8mYgy63QYXG6uJT52qGVS+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BviK46vB3Re+tD+GaCD83LVaN7tkEVKriAfK2+evX1pTVcV7s9xfY1AoIacgxUTvQRYEgy/ReeONmAuc/e0DtnU7BS2SP/q5Dttf8cCEjOSmTGtbqrFVAeiHoEdSt/5HufbTcEctVS3v0LE+zLR2GNzpYm2lRRWcKMdXFuEx/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XMSm2tcy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jbj8praS6QSoMl3yq8q4zrnI908gnmXP6pRA+BXrLfY=; b=XMSm2tcyAXFKlfJ1KAnvLY8+ac
	SR7GJJrBbHx3TAbouNg62qJaC8UlidZgRdn8HDidui+jr2VNlTqvsBQo66lRMrNjJejst7/m0+z6P
	NOZcSSgw/mef4HRh4AcP0WEZqooDYSBmxB2RcHl0uliFASb5OK7zpI0akQ97HHqO+P+c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8SMY-00EaeW-SU; Fri, 03 Apr 2026 02:26:14 +0200
Date: Fri, 3 Apr 2026 02:26:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: dsa: yt921x: Refactor long register
 helpers
Message-ID: <112370b9-0e2c-4d5c-a614-4eca5593b2d8@lunn.ch>
References: <20260402223437.109097-1-mmyangfl@gmail.com>
 <20260402223437.109097-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402223437.109097-3-mmyangfl@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274782-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 9948E38F6F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -static int yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, u64 val)

> +yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
> +{

The old reg64_write actually took a u64 value, so the name fit. The
new one takes 2x a u32. So i'm not sure calling is reg64 actually
fits. Maybe yt921x_reg32x2_write()?

> +static int yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid)
>  {
> -	u64 mask64;
> +	u32 masks[2];
>  
> -	mask64 = YT921X_VLAN_CTRL_PORTS(port) |
> -		 YT921X_VLAN_CTRL_UNTAG_PORTn(port);
> +	masks[0] = YT921X_VLAN_CTRLa_PORTn(port);
> +	masks[1] = YT921X_VLAN_CTRLb_UNTAG_PORTn(port);
>  
> -	return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), mask64);
> +	return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), masks);

Or you could make yt921x_reg64_write() continue to take a u64, and
avoid all these changes?

How does the datasheet describe these registers? Are they 64bit
registers, or 2x 32bit registers?

	   Andrew

