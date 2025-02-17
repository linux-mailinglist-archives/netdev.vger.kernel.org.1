Return-Path: <netdev+bounces-166802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEA8A375A5
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0E43ABF3C
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100C6199948;
	Sun, 16 Feb 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5hNT7bO9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8741487C8;
	Sun, 16 Feb 2025 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722725; cv=none; b=itp+WKKliM9D3aCdp+uehCeDK9TdIxmy0Nc2bqhvXSv4ECcDRYos1517N6KrMGWSYXuHuez64BxuMqfZiTTldUhBM5m0NalSGEx9uFRn3KfnsTXYeF1cQZ3PZlAvzcjbk1pYAcxwvsR/CG+6TdJ6A5tYP5ceRm/m8aecFZFNBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722725; c=relaxed/simple;
	bh=xa+ykwNu0h1H72N65u+BSWp/fkCg4qdUbTOkeo2YZtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRCzcgg+e7EEfpEP7PKLglLlv3yY1QShZYuvaJIaYDwi/DUCCv8VshpeQiL11xiW+NzQpgxoABS5MRmGDPwwo4z//SYsf+05EZmLVLjXuWg2VTm8hITyRRyks+yvU4oFXuO3DFxpG9kbJSIPHJ/ojafwsJuvMYlLzsz8/FCOtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5hNT7bO9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NJj3Gp8N/yNawLLhYlUSkThk4LKO/bJ6KDyDCc+/r/Q=; b=5hNT7bO9m7UXqdOirP1F2jhcAo
	xpw3Z0nEC5elZtIPgosvWBn7wpU1CHvg6X3CMQB4Ah7Ast5KsNx660BSykLh7kg8ynGWmRHni2sDC
	Pax+R0g7M8a9W5/Q1+BwwDcEFjpI8F2J4RD42GTGF9WsOFSyRbjuJzzOAKN8b5KIzFgI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhLj-00EhMv-DF; Sun, 16 Feb 2025 17:18:31 +0100
Date: Sun, 16 Feb 2025 17:18:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v5 2/3] net: phy: Add helper for getting tx
 amplitude gain
Message-ID: <aab02a4d-3709-45b1-8331-ee1751c7b225@lunn.ch>
References: <20250214-dp83822-tx-swing-v5-0-02ca72620599@liebherr.com>
 <20250214-dp83822-tx-swing-v5-2-02ca72620599@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-dp83822-tx-swing-v5-2-02ca72620599@liebherr.com>

On Fri, Feb 14, 2025 at 03:14:10PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Add helper which returns the tx amplitude gain defined in device tree.
> Modifying it can be necessary to compensate losses on the PCB and
> connector, so the voltages measured on the RJ45 pins are conforming.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

