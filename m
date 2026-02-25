Return-Path: <netdev+bounces-260964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDHfKcf+nmlAYgQAu9opvQ
	(envelope-from <netdev+bounces-260964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:53:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B3198642
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190CB303FA9D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFB63D2FF7;
	Wed, 25 Feb 2026 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5XwRpasB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBAA3B531F;
	Wed, 25 Feb 2026 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027587; cv=none; b=mp4ul7EKFc0TfF5koDQxbgDXaojvKageOTetPn6KZKhEcKE0sLAIeemuUX3pdKsnIylzllXwNP/fQS0LJip7XsgpwNLefZxqTAVzloJZwI6FteY/2mHXY9qZYZI5wnOSMeiHneIB5IK6pxqp/pZIOIVsv8yf7XhGeIxpQ8HFtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027587; c=relaxed/simple;
	bh=EePpNLxqxLe1Xitsf7KtdEbcUkE17+A5mIaZP3VE5L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJz8EX1zHKvLF2p3ucDMeHPBaYCbJJN/9N5d/Ey8ifSxoh/q5/365znGeZcQyuRDenp2noIeQx22YdvLgnspOoQRehPcyLmi18lzNybj+Wy1Er0XFbyaX8SKqTzH1ux+ks/L0lLlPfUHZVoFqQu3CbQWKU/8OrxRNHO1jYMpGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5XwRpasB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9+QIZxMPWkCD8lT7ZXdcb3F5dkJik3lX7EUr4It56N0=; b=5XwRpasBU2G6LPWg6d9UC8RQuv
	FDdJ4b+IklPno3gMeR3Ng+6vIEcGh21szFPQ89liM4c03q3QPqu/PlurYOCZFgkBrkvEB/x8zM6KV
	l/YGYENHdhSebOC3N/yr1+4ZE8FT3ik6Nhb+ls9gZy11CZLPgdJ9dt9zOYn+1Oos0tWQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvFJy-008khZ-II; Wed, 25 Feb 2026 14:52:58 +0100
Date: Wed, 25 Feb 2026 14:52:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: yt921x: Refactor long register
 helpers
Message-ID: <cb52e6e5-c047-4190-9e06-4f80a8bef051@lunn.ch>
References: <20260225090853.2021140-1-mmyangfl@gmail.com>
 <20260225090853.2021140-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225090853.2021140-2-mmyangfl@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260964-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: E50B3198642
X-Rspamd-Action: no action

> -/* Some registers, like VLANn_CTRL, should always be written in 64-bit, even if
> - * you are to write only the lower / upper 32 bits.
> +/* Some registers, like VLANn_CTRL, should always be written in chunks, even if
> + * you only want to write parts of 32 bits.
>   *
> - * There is no such restriction for reading, but we still provide 64-bit read
> - * wrappers so that we always handle u64 values.
> + * There is no such restriction for reading, but we still provide multi-chunk
> + * read wrappers so that we can handle them consistently.
>   */
>  
> -static int yt921x_reg64_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
> +static int
> +yt921x_longreg_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
> +		    unsigned int span)

Just looking at this, it is not obvious what units span is. Many bulk
read operations takes bytes, even if the underlying code works in
words. I would probably rename span to something like num_u32.

I would also keep yt921x_reg64_read, yt921x_reg64_write,
yt921x_reg64_update_bits() and just makes them wrappers which call
yt921x_longreg_read(). 

> -static int
> -yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid)
> +static int yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid)
>  {
> -	u64 mask64;
> +	u32 masks[YT921X_VLAN_CTRL_S];
>  
> -	mask64 = YT921X_VLAN_CTRL_PORTS(port) |
> -		 YT921X_VLAN_CTRL_UNTAG_PORTn(port);
> +	masks[0] = YT921X_VLAN_CTRLa_PORTn(port);
> +	masks[1] = YT921X_VLAN_CTRLb_UNTAG_PORTn(port);
>  
> -	return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), mask64);
> +	return yt921x_longreg_clear_bits(priv, YT921X_VLANn_CTRL(vid), masks,
> +					 YT921X_VLAN_CTRL_S);

By keeping the names, you don't need changes like this. And
yt921x_reg64_clear_bits() is much more obvious than
yt921x_longreg_clear_bits(). And the patch will be much smaller.

	Andrew

