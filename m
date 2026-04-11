Return-Path: <netdev+bounces-277723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vGN2ASnO2ml06ggAu9opvQ
	(envelope-from <netdev+bounces-277723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 00:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B83E1D93
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 00:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE7F530154B3
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 22:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB23002A0;
	Sat, 11 Apr 2026 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z9iVBUVW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E224BBFD;
	Sat, 11 Apr 2026 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775947299; cv=none; b=HCODOio7oXTGvTks3Poo1LzpBHkeO+QCvrnvfBzGunrMrdUQRLJcPgWb1HwDa0eWrRof6MoVnn+/1/9MQ+SDGqNovABWKjq3xXjKQ4R1q73ulLQK4H+SrrQd6XpBQLKwP6m7F2Rp/+wkEzZO/i3Xa+O2F6HHb6zTQ6fwHbaVTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775947299; c=relaxed/simple;
	bh=2aR/iIkG+jSR6uKXfzIVlH7jNUNOLqkPIfYHeqqxzj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+2ZbwevxSPDlbHAeuYdKKwfiOksuBeg+ovIn9XkRbRPhr2BJoTQQeidXMBupxaTKJ5gbEdkRxp6D6y400MWK3mxEzsXIbrEVpDFC3afYAhRjEJgTBos7zVQolhVg0W8dLFT3o/WwyIW4r27vIsu085o8aZS/QwksGj5PjKmDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z9iVBUVW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tkHT1KxafF+nsFZnG2OLuj8Znyepk7iMYuIaA5TDu4c=; b=Z9iVBUVWfVfQ8tT22hAmGbuJZm
	qnF9y3xBizCbSeKUEavZyfuekuqqQQvgxQIBv6hhgGDWRHCQnlmPTHmor1tlLtS3ls2bpRBYQj+q0
	xnW+DZ+SAjKtC8zZXhKvaaV4i8ThNqehYj3CgYfUOpFkjvrtmascKQN/GfgtRpTkc8vI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wBh0y-00Fkmo-Rn; Sun, 12 Apr 2026 00:41:20 +0200
Date: Sun, 12 Apr 2026 00:41:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 1/2] net: dsa: mxl862xx: add ethtool statistics
 support
Message-ID: <e97dcdd8-17e1-4e0a-a695-92dca4abd895@lunn.ch>
References: <cover.1775865049.git.daniel@makrotopia.org>
 <127b374aba1fb8eb4ad9215e0c0826dd4545fc58.1775865049.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127b374aba1fb8eb4ad9215e0c0826dd4545fc58.1775865049.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277723-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 5B2B83E1D93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +static int mxl862xx_read_rmon(struct dsa_switch *ds, int port,
> +			      struct mxl862xx_rmon_port_cnt *cnt)
> +{
> +	memset(cnt, 0, sizeof(*cnt));
> +	cnt->port_type = cpu_to_le32(MXL862XX_CTP_PORT);
> +	cnt->port_id = cpu_to_le16(port);
> +
> +	return MXL862XX_API_READ(ds->priv, MXL862XX_RMON_PORT_GET, *cnt);
> +}
> +
> +static void mxl862xx_get_ethtool_stats(struct dsa_switch *ds, int port,
> +				       u64 *data)
> +{
> +	const struct mxl862xx_mib_desc *mib;
> +	struct mxl862xx_rmon_port_cnt cnt;
> +	int ret, i;
> +	void *field;
> +
> +	ret = mxl862xx_read_rmon(ds, port, &cnt);
> +	if (ret) {
> +		dev_err(ds->dev, "failed to read RMON stats on port %d\n", port);
> +		return;
> +	}

RMON statistics should be returned via the .get_rmon_stats in
dsa_switch_ops. Please only return statistics here which don't fit any
of the other statistics functions in dsa_switch_ops.

    Andrew

---
pw-bot: cr

