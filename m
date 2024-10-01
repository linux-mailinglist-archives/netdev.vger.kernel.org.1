Return-Path: <netdev+bounces-130847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068B898BBE5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9332EB22203
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B736B1A00D1;
	Tue,  1 Oct 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0xkxlOgK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443C1865E0
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785012; cv=none; b=piSOPZa6OkDKl4R0lMrnEsBu25HDVGLfy4sJlTxD87vAwRTR/Fyn13vY7SOZ/c2jxhrZlUs68TTlB7K+JcUs5JxnnlqB0M9l5I41aoYQPX2RUY5aMkO4JE7dpCG7PaQfg6vHK+0TU5uFh3sOUPkLujTNK3GPzCe/cb43x865irw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785012; c=relaxed/simple;
	bh=eorK7lz/QkMV2LRm9b63yUbhAocxTr5/LZT5gcgozfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIzkOH7vTVFBXIXinvgse6PEs3JCmLDi3asLTrhlKDn/dmpCEb1qRQLQFE8oDEhnKt4tpUzcgxCjpeXl1p1RsHIJEI0TFvc5RGbUb4HPE/v4W6859pKZpqZV+rUr5chh+KXnfAeNsrREBoqBu9vzYqW/YvZlBN6S43w30BvtuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0xkxlOgK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IqMfzmoJthbFWjMpbXDGduturBVkFP2Q0Btk120KpXg=; b=0xkxlOgKqC3zyalmBUoNHssvXG
	g8ylOtI6fG/RUsolQwToo+oXBmIC2qDh+K2s0b5QV6roLs6TiSc3RQAwrlD05UVee7wn86rL0ETJ3
	/SbDTpF0RqY1VbI4hRBuZQX/nuPXGfpnIFDeghQcN6I2E4xxluSmMgyGc6bFnFTH4fCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svbny-008j3K-VL; Tue, 01 Oct 2024 14:16:38 +0200
Date: Tue, 1 Oct 2024 14:16:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"agust@denx.de" <agust@denx.de>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Message-ID: <54dd7254-8e8a-476a-9c02-173a28d5a3c6@lunn.ch>
References: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
 <aafbddb5-c9d4-46b4-a5f2-0f56c58fc5df@microchip.com>
 <60008606d5b1f0d772aca19883c237a0c090e7d3.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60008606d5b1f0d772aca19883c237a0c090e7d3.camel@siemens.com>

On Tue, Oct 01, 2024 at 11:57:15AM +0000, Sverdlin, Alexander wrote:
> Hi Parthiban!
> 
> On Tue, 2024-10-01 at 11:30 +0000, Parthiban.Veerasooran@microchip.com wrote:
> > I think the subject line should have "net" tag instead of "net-next" as 
> > it is an update on the existing driver in the netdev source tree.
> > 
> > https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
> 
> I explicitly didn't target it for -stable because seems that nobody
> else is affected by this issue (or have their downstream workarounds).

This is the sort of information which should be placed under the ---
marker. It would then avoid reviewers asking the question...

	Andrew

