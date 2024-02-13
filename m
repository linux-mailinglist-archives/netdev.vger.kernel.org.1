Return-Path: <netdev+bounces-71154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B04785279B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 03:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5E81F22BAC
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9348BEB;
	Tue, 13 Feb 2024 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AswRXoIf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A248F45
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 02:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707793049; cv=none; b=bCBbCLAVSDBrYIPqCGmmDj8+yD1Eq9WVCAq2P0Zj1l1zGWyb30JtnBL/hGUDb7AXyt5pmnuT6t/thNHG2w2nSlhNRGnhTsQ3okQEFjn9a6X6W6QBTyYn+OJjS1fbR/X6RW5xNq5yoyerygczuyiyyPxb0HCIUgY6odDOuRNDl3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707793049; c=relaxed/simple;
	bh=P2wz8A19vsUXIFJKQTXrWeJ9ZKS5/2dM/tdeXDjZreg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAjzV5ad2LuZ9BjzLyC+PjbBiaJ2XgoGWvOLmuz3EaRqhtQ6WplnkKTHg80XTGSKEGrOrL5pBJSuUqklj7urSei3CmavCiA7i5VT+zdiXRn+6jagWjTA564yMJushkLxB+hx+HLHsjsCnbbY0+IPHhzx+goje9sCtfwlRdmp5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AswRXoIf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=QmRTM+F4Gohc30EjRUTixCf2KZhi2DRSyz/9I2DZiTc=; b=As
	wRXoIfQtrE3lmQ3r07xlfDkV80+sJuPSiFZyK8JRPfGAthbN4aBoFGdoS+KikV8md7stYQweONuBn
	KNhx21XWbxhQ8HI7VRCup+WIhDGBT1gpYUtCYAKRyTpSaJ7HqyobqzhbolyZU34Lflqfm4v8dBhtT
	1lOvuL2VWSRXC8A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZizH-007cuj-Mj; Tue, 13 Feb 2024 03:57:35 +0100
Date: Tue, 13 Feb 2024 03:57:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH net-next v4 2/2] net: fec: Refactor: Replace FEC_ENET_FCE
 with FEC_RCR_FLOWCTL
Message-ID: <e0b9b3d2-44e8-4a7f-a233-64aa4845f566@lunn.ch>
References: <20240212153717.10023-1-csokas.bence@prolan.hu>
 <20240212153717.10023-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212153717.10023-2-csokas.bence@prolan.hu>

On Mon, Feb 12, 2024 at 04:37:19PM +0100, Csókás Bence wrote:
> FEC_ENET_FCE is the Flow Control Enable bit (bit 5) of the RCR.
> This is now defined as FEC_RCR_FLOWCTL.
> 
> Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

