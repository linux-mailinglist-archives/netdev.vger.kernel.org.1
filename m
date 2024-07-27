Return-Path: <netdev+bounces-113369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F95F93DF15
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 13:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1151C20A7C
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C155893;
	Sat, 27 Jul 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F3/KzAFq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B26F2EE;
	Sat, 27 Jul 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078449; cv=none; b=BUTHWjOhKQoYVQ8KB5UDjK0q8QBK0NV4t4BBdGTdgTNb0PEgfa0kAcjIeG2XRJNOxfUu0qP5Jjp7XufZwnIMCWO/uRO2ZI1Qqc3vGZOa/PeNkraucb9iVuD/S3wt+gFHY2rGalY8LIBKOqBjBS2txYYGhZeAraSd52N03i0OgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078449; c=relaxed/simple;
	bh=rkrv4x/6SEw6h+sSPRyOXVXlzWGwVar6XHfLAnUXJKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqUB8mQJ4kzewbe1/vXIix7YhzSbjlfLgmUNBqfdIdjciWXxChdLMQ4gc+QwE/ElwXvDtjQ3g8KL5uy/C2yuRIPu+SU/nKJCl1jFZGG3LF6LeyUkDaLfHc9JSh1IhO0v6u/YemIzlCCQ6/be4Qmq+FRjkpM4Q/re9sV79VtENRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F3/KzAFq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J83O2a+R4pUUul/fshVpSLu7T4K2ZSID2CCRNrWOt7g=; b=F3/KzAFqBptCN3MwIbELkGSesb
	x09U9AM1bZGGMA78OLoRpoMDbSTTxSCMd99v+3ztJFbAv/b25QQWH6AnhMTQAFxRjCVQFwC0PHgwv
	GSAKEcWrNO9s0xAkXG7tgkpHbl6I5V1xqqAeGnvrHhSuEAjKhQMWu1MP/FLs+5XmsISU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sXfGY-003LLm-Uf; Sat, 27 Jul 2024 13:07:10 +0200
Date: Sat, 27 Jul 2024 13:07:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Frank.Sae" <Frank.Sae@motor-comm.com>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH 1/2] dt-bindings: net: motorcomm: Add chip mode cfg
Message-ID: <830d0003-ac0b-427d-a793-8e42091c4ff2@lunn.ch>
References: <20240727092009.1108640-1-Frank.Sae@motor-comm.com>
 <ac84b12f-ae91-4a2f-a5f7-88febd13911c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac84b12f-ae91-4a2f-a5f7-88febd13911c@kernel.org>

On Sat, Jul 27, 2024 at 11:25:25AM +0200, Krzysztof Kozlowski wrote:
> On 27/07/2024 11:20, Frank.Sae wrote:
> >  The motorcomm phy (yt8821) supports the ability to
> >  config the chip mode of serdes.
> >  The yt8821 serdes could be set to AUTO_BX2500_SGMII or
> >  FORCE_BX2500.
> >  In AUTO_BX2500_SGMII mode, SerDes
> >  speed is determined by UTP, if UTP link up
> >  at 2.5GBASE-T, SerDes will work as
> >  2500BASE-X, if UTP link up at
> >  1000BASE-T/100BASE-Tx/10BASE-T, SerDes will work
> >  as SGMII.
> >  In FORCE_BX2500, SerDes always works
> >  as 2500BASE-X.

When the SERDES is forced to 2500BaseX, does it perform rate
adaptation? e.g. does it insert pause frames to slow down the MAC?

Maybe look at air_en8811h.c.

      Andrew

