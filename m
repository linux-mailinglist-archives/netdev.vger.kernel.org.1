Return-Path: <netdev+bounces-252351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHFDM54pcmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:43:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 857A96772E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE75E3C9CD2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C9C3016E7;
	Thu, 22 Jan 2026 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3wbYFeC4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18FA2FE591;
	Thu, 22 Jan 2026 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087367; cv=none; b=BWZUm0nw9z8g/0oNNGjoP1jdRfpVL9RjYgqs0Mizgx9zQNBLVDje2ssfYZjguETR9E0Y81OaqmgUsE2qaT7l0xhy/VRQgnrnXsqJa+polK41EYFRPbYsvhNMuzx4uJV7qTgT5IfJAvKMQb1QN0JQ2OqL7IWZfXeg8bvGuAtUaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087367; c=relaxed/simple;
	bh=HVLgGWEcLkI/u9DtzcpuXXGfpM487XsFtewEEUDD3uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbHKIpUVOxR7NDA6U48goEefeaASy9rhg9tm0LziH49bihTbwiU/LkTvlcfQPZMCDbq+orlKNdFkxhVQv8XOKrPAe5Md1nl9sLpIB0ceOHf5BcFTfAI+9fBilG76cPJRheg57p+TwTPPVD7d5rtsrirhr2wn2ZMRBTKT9JTLcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3wbYFeC4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KkhVBB+QgzcCgYyqL44Qur19CLLRdKf0hGWKGZRHDXM=; b=3wbYFeC4l3BuZgViSmTjQ/upiU
	dBWtE6sepWEKwD6lbSg8mRK7p26bIka0HVof7t/10AMQrdbIO5y8JFcbLVA319b37CaMPRi7FeKcT
	TX/GWvVdkBXLRZ1Xb+iIo0rrO9sySy3HvUK95WGYquFBA2tSAjxiRZ21T91QCfGPoXmo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viuR0-003yGm-Mo; Thu, 22 Jan 2026 14:09:14 +0100
Date: Thu, 22 Jan 2026 14:09:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com, francesco.dolcini@toradex.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: dwmac-imx: keep preamble
 before sfd on i.MX8MP
Message-ID: <96f2c395-82f0-4399-be3b-6b0e3f07f90e@lunn.ch>
References: <20260120203905.23805-1-eichest@gmail.com>
 <20260120203905.23805-4-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120203905.23805-4-eichest@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252351-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,armlinux.org.uk,st-md-mailman.stormreply.com,bootlin.com,toradex.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 857A96772E
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 09:30:04PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The stmmac implementation used by NXP for the i.MX8MP SoC is subject to
> errata ERR050694. According to this errata, when no preamble byte is
> transferred before the SFD from the PHY to the MAC, the MAC will discard
> the frame.
> 
> Setting the PHY_F_KEEP_PREAMBLE_BEFORE_SFD flag instructs PHYs that
> support it to keep the preamble byte before the SFD. This ensures that
> the MAC successfully receives frames.
> 
> As this is an issue in the MAC implementation, only enable the flag for
> the i.MX8MP SoC where the errata applies but not for other SoCs using a
> working stmmac implementation.
> 
> The exact wording of the errata ERR050694 from NXP:
> The IEEE 802.3 standard states that, in MII/GMII modes, the byte
> preceding the SFD (0xD5), SMD-S (0xE6,0x4C, 0x7F, or 0xB3), or SMD-C
> (0x61, 0x52, 0x9E, or 0x2A) byte can be a non-PREAMBLE byte or there can
> be no preceding preamble byte. The MAC receiver must successfully
> receive a packet without any preamble(0x55) byte preceding the SFD,
> SMD-S, or SMD-C byte.
> However due to the defect, in configurations where frame preemption is
> enabled, when preamble byte does not precede the SFD, SMD-S, or SMD-C
> byte, the received packet is discarded by the MAC receiver. This is
> because, the start-of-packet detection logic of the MAC receiver
> incorrectly checks for a preamble byte.
> 
> NXP refers to IEEE 802.3 where in clause 35.2.3.2.2 Receive case (GMII)
> they show two tables one where the preamble is preceding the SFD and one
> where it is not. The text says:
> The operation of 1000 Mb/s PHYs can result in shrinkage of the preamble
> between transmission at the source GMII and reception at the destination
> GMII. Table 35-3 depicts the case where no preamble bytes are conveyed
> across the GMII. This case may not be possible with a specific PHY, but
> illustrates the minimum preamble with which MAC shall be able to
> operate. Table 35-4 depicts the case where the entire preamble is
> conveyed across the GMII.
> 
> This workaround was tested on a Verdin iMX8MP by enforcing 10 MBit/s:
> ethtool -s end0 speed 10
> Without keeping the preamble, no packet were received. With keeping the
> preamble, everything worked as expected.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

