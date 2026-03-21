Return-Path: <netdev+bounces-270224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK7ZFzq5vmksYgMAu9opvQ
	(envelope-from <netdev+bounces-270224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:28:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CBD2E615F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C2A1304EA84
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C3D38BF76;
	Sat, 21 Mar 2026 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rDr5L8K2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8A38F25F;
	Sat, 21 Mar 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774106666; cv=none; b=BBvOAP9SCOEDioLcwVUGqeZfq5wvq27avpIE+tlFuvCsCWkF0sgknqQuAjb/g7Ezqo3CxcMQaZrtq4K/Aq9Pp5WHgypFjdBe7fhNQwgOKzXCmOie/x4BadTLO5NR39Dgt1ocaPouQVxf8MVnvGywZCXti1o09BKBMIwOmnZHr/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774106666; c=relaxed/simple;
	bh=u0wcA0tPR8q/+IKF3H8Puc2o7lli+o7vG3hVYnqd9sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVD2gk4PA8qj1XgZkwDQ2LaXrutsu5fh8eaSwf+5MXqq7Hua0sh5f+Nhqc4FQ5aqtOG74oFpH6LJf28+Q69Pc96xrFbuzbJ1xwNT5St6yEHDxzAkRylcuxM2sm9JRCaAHfSzTbSvNibLunlpjTJeyjMuL9vwREuPe1XcQJMILDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rDr5L8K2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1xQXnxuKnh/cYEUl1dyTeGXPR8XNOB8KEAwiWHUWmTA=; b=rDr5L8K2KLnAm6jSe+Qd2VdA1v
	LcYT6iEfQoEn/DKdYkz0OintU+ZKi/qKmRXpFfjNaBr8K+S67q5YXJJg4C4m9Ua6S/Mpq37JNx/Cf
	DVS3oK0edE1WMocSFhfVEf0PujNeLhlwgXhziAmTv0CdtNIo0F5XMSsrZEwwlaXmbyCQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3yBK-00CiyE-Jk; Sat, 21 Mar 2026 16:24:06 +0100
Date: Sat, 21 Mar 2026 16:24:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 1/2] net: dsa: mxl862xx: add CRC for MDIO
 communication
Message-ID: <c5f29b9b-9447-488e-b8cc-e2f7e7cbf1a8@lunn.ch>
References: <cover.1774070039.git.daniel@makrotopia.org>
 <af6911188ee6becb9100d4bf13d0820e5bf9eaca.1774070039.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af6911188ee6becb9100d4bf13d0820e5bf9eaca.1774070039.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270224-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 17CBD2E615F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +/* Firmware CRC error codes (outside normal Zephyr errno range). */
> +#define MXL862XX_FW_CRC6_ERR		(-1024)
> +#define MXL862XX_FW_CRC16_ERR		(-1023)
> +
> +/* 3GPP CRC-6 lookup table (polynomial 0x6F).
> + * Matches the firmware's default CRC-6 implementation.
> + */
> +static const u8 mxl862xx_crc6_table[256] = {
> +	0x00, 0x2f, 0x31, 0x1e, 0x0d, 0x22, 0x3c, 0x13,
> +	0x1a, 0x35, 0x2b, 0x04, 0x17, 0x38, 0x26, 0x09,

I had a quick look around and count not find this table anywhere
else. Mellanox has a different CRC-6 polynomial. Until somebody else
needs this, i think it is O.K. here. But sometime in the future it
might be moved into lib/crc.

> +	ret = mxl862xx_crc6_verify(ctrl_enc, len_enc, &fw_result);
> +	if (ret < 0) {
> +		dev_err(&priv->mdiodev->dev,
> +			"CRC-6 error on response to CMD %04x\n", cmd);
> +		return -EIO;
> +	}

This is the question, what to do when you see a checksum failure? The
basic assumption is MDIO is reliable. PHYs don't do any sort of
checksums, nor any other switches using MDIO. Why would you want
checksums?

To detect the hardware is broken? If so, is returning EIO sufficient?
Would it not be better to admin down all the interfaces?

To allow the MDIO clock to run at a higher frequency, at the limit of
the bus, so you get occasionally failures? If so, should you not
retry? But are the commands idempotent? Can you safely retry?

	Andrew

