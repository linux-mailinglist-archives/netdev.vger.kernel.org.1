Return-Path: <netdev+bounces-286814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFedNTkzAmrSowEAu9opvQ
	(envelope-from <netdev+bounces-286814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:51:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F57D515430
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF753003EC8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191EA3502A3;
	Mon, 11 May 2026 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ppvwcDHW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D237998C;
	Mon, 11 May 2026 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528963; cv=none; b=sqPgVRGfdoa+vjP57yxIJpRr+B0+b4hqMdkNjiGFEYODBoKM9P2llyvEHsuU8Ag1/rBDbNrQokoOr2iHZSqdIOZVsPA9nBx1stLQM2qANfj3zKF02Ko4Wy3QfWrLd9pWUDZRtorFZo5JNHU04mWTuA7h+LNuUlwBIqvaV/5O2/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528963; c=relaxed/simple;
	bh=ES/zVHXEpLSl55hYZiXFJYryCdfnJ8t9WgUEAk1T3AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs6Nxw/nUxV/6aycUuOX4ig41V1S4nTQjsAM9M6J7GImFkJbPr8pSL8cZ3f050kAUWxcOSeqpbzVUVw3gX2fWR/Gf90iGSMGreCK6VNZ0YjsHD0jEt/3enMYjq1lKBzWBOHoKCbq92CTkSBb4eElAfHJrlHyqCKuziA1EwsJq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ppvwcDHW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WPanf4BQtaRA4rRWTLFzrBpCX3rZrqSPwixXTkqtKQI=; b=ppvwcDHWVns+HeqdQ4KGgyo/xg
	2812PQ1T+UJxdPJU0jLtvyDqZKPKrjApYdk83nX6HYtjO+ZoNLjnVCV1PHFBHmelTISmzqT4knfou
	KqVqGhOL53RO3KRXnolkX/Y8bEZbcVn4fFpLEdbolXcjF3BovlKmLlAnDl8CCCzCFDSk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMWco-002QoQ-NY; Mon, 11 May 2026 21:49:10 +0200
Date: Mon, 11 May 2026 21:49:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 6/9] net: ethernet: oa_tc6: Hardware
 timestamp support for OA TC6 framework
Message-ID: <46a6321a-408f-4c63-8835-86ee9c4bdcd6@lunn.ch>
References: <CY8PR02MB9249D813205563D5C64ACEFF83382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249D813205563D5C64ACEFF83382@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: 3F57D515430
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286814-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 06:19:31PM +0000, Selvamani Rajagopal wrote:
> Added hardware timestamp support as defined in Open Alliance
> 10BASET1x MACPHY_Serial_Interface specification. ioctl interface
> added for ethtool to report and set the hardware timestamp feature

7.8 Frame Timestamp Capture

The MAC-PHY may optionally support the capturing of timestamps on
Ethernet frames received from and transmitted to the network. Support
for this option is indicated by the Frame Timestamp Capability (FTSC)
bit in the STDCAP register

I don't see anything in this patch looking for FTSC.

> +/**
> + * oa_tc6_hwtstamp_ioctl - ioctl interface for hardware timestamp
> + * @tc6: oa_tc6 struct.
> + * @rq: request from socket interface
> + * @cmd: value to set/get timestamp configuration
> + *
> + * Return: 0 on success otherwise failed.
> + */
> +int oa_tc6_hwtstamp_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, int cmd)
> +{

It would be better to add a generic ioctl handler. It can call
phy_do_ioctl_running(), and can check if time stamping is support in
the hardware, and if so, also support the time stamping IOCTL calls.

    Andrew

