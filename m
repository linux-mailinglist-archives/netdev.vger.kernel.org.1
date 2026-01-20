Return-Path: <netdev+bounces-251626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ia4G4QAcGmUUgAAu9opvQ
	(envelope-from <netdev+bounces-251626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:24:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D64CE9D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0C92B20F73
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893563E9F65;
	Tue, 20 Jan 2026 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0WLm9SWQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F23BC4D5;
	Tue, 20 Jan 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947087; cv=none; b=tHWCnoHkA0KByZwIZ3YErm3EoK6QP6eQ5Pi3oqvWyP8xln4GCqK+SLahpk7xvUknw+RTttMmz9U2kvm7O0xhnoFrZkiUsFKBMh6nnKG59x4Mflr28Ocb4TRb4BfJO8pgJ24M2xcsiVCf6dBqehVtg6v6EuN46brlDjrdXkwT6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947087; c=relaxed/simple;
	bh=Olq9PDUgotvmRb3FBULz7tIkeAz8VsmFDj4VyiCOunA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYkpF4rZs4HTgDViefkpChQ2tBo1DqnII79FgOCc+LQrRmojySuCUzpDmtFJ/+LgMBEDOD4xvYPBpGHSwDdlLN71vzzkb4TtUWEgKtUO2S+BAwPVZnRglIhJLn5ifLt8MXNgitwDJvB/wPs86DNJXW8hZ0GOZUH+xH/k/P+p6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0WLm9SWQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cz8APhsseY0Zk6G5E1jpmPu9bX8/ov5VZe6gD1zzSmc=; b=0W
	Lm9SWQQov5SYd420XUzSP8tyaiF9Y4ujlBQzmY/Th4asNTZ50ub3BJd9Dlsrxalzcy+e9smXDK7uN
	NqKWIJLS3Yz9jukT5jfXlgISuHH38T+Dy7aAeX+CrQxUfBfk/HmRYj7G1QITxRhI94jWTECv3vxjD
	lw4a8v0h3Xo2qJY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viJw7-003jIq-CF; Tue, 20 Jan 2026 23:10:55 +0100
Date: Tue, 20 Jan 2026 23:10:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v8 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Message-ID: <2e3f213b-d507-4290-91af-fba7492155d2@lunn.ch>
References: <20260119073342.3132502-1-a0987203069@gmail.com>
 <20260119073342.3132502-3-a0987203069@gmail.com>
 <04df4909-4fdb-4046-917f-2f2e47832c62@lunn.ch>
 <a5cb949f-34c1-470c-bd04-0b35c249455f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5cb949f-34c1-470c-bd04-0b35c249455f@gmail.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251626-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CB0D64CE9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 09:34:39AM +0800, Joey Lu wrote:
> Dear Andrew,

Please don't top post.

> 
> Thanks for the clarification.
> 
> In our design, the Ethernet PHYs are located on the base boards, not on the
> MA35D1 SOM.
> 
> The SOM base board routes two RGMII interfaces from the SOM to two external
> PHYs on the carrier board.
> 
> On the MA35D1 IoT board, there is no separate SOM and carrier board - it is
> a single integrated board.
> 
> I will update the DTS accordingly so that no PHY nodes appear in .dtsi.
> 
> Thanks!
> 
> Best regards,
> 
> Joey
> 
> Andrew Lunn 於 1/19/2026 11:22 PM 寫道:
> > On Mon, Jan 19, 2026 at 03:33:40PM +0800, Joey Lu wrote:
> > > Add GMAC nodes for our MA35D1 development boards:
> > > two RGMII interfaces for SOM board, and one RGMII
> > > and one RMII interface for IoT board.
> > > 
> > > Signed-off-by: Joey Lu <a0987203069@gmail.com>
> > > ---
> > >   .../boot/dts/nuvoton/ma35d1-iot-512m.dts      | 12 +++++
> > >   .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 10 ++++
> > >   arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 54 +++++++++++++++++++

Does ma35d1.dtsi represent the SOM?

If so, what is ma35d1-som-256m.dts ? It looks like some odd sort of
carrier board with a few serial ports and some memory? But systems
like this put the memory on the SOM, not the carrier.

As i said, i'm confused with your naming here.

   Andrew

