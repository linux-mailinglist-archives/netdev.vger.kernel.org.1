Return-Path: <netdev+bounces-191686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E6ABCBF0
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E19F3B6BB4
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 00:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F52253F07;
	Tue, 20 May 2025 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="INrmpwCZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40596374D1;
	Tue, 20 May 2025 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747700159; cv=none; b=jwuYCE3f9gRQGL6nfPWjNzYE/FiJjPPcZHkrxTfcPOPN8fmJJTc5qFk7egWcv5cEC1jYYAhU7IengNsgBH09QOHUsFWHc+m11XAKXvDc1LaJCIOA+PqB4RYxnwbxKOltYxOFkNH9vVHVzS0GZjr9aa7JgS9vDRKc9qF7sRIg/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747700159; c=relaxed/simple;
	bh=TU1PuU20ULP0nxdQLvR4OMMp/ktsrxHvmhb+Ek+jIT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm5R2cwwpw+S5xu0Lxnnxg/wmHFhKTdlk04k7hKJjpKaAgLJYnCRqpXBQRqLiFP0r3uzilYsrXpxGYYC9LGCMwYgwh5NoOnH2uLAy0yhm7scO4xr/BamcFXI1nLe/REuulzMPtY61eYTeJJSSyVOpBfJaz+e21MK+vAzuW/h6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=INrmpwCZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7MeXPOcFmUddS1SAwooWtuqxeKXe3n1iDcpVdycH0O0=; b=INrmpwCZhz1VbKAkkOBF7qF6SG
	7c7735Eoz0KbjiO9TR8P6WUZBywZ893FV3XP+efpALN/Pcn5HyDFmUSsFKNq1/wXMx9mK0SqTdkvb
	mruwi448TfW+h/FHiz5+0kQUtLMZQ5qsM0mipnN3VlZ8gvCSNaG+sDaaAcCbdN8RbXB0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uHAe1-00D4ER-DB; Tue, 20 May 2025 02:15:45 +0200
Date: Tue, 20 May 2025 02:15:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: dsa: b53: fix configuring RGMII delay on
 bcm63xx
Message-ID: <e0d25a68-057b-4839-a8cd-affe458bfea3@lunn.ch>
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
 <20250519174550.1486064-3-jonas.gorski@gmail.com>
 <ed75677c-c3fb-41d1-a2cd-dd84d224ffe3@lunn.ch>
 <CAOiHx=nwbs7030GKZHLc6Pc6LA6Hqq0NYfNSt=3zOgnj5zpAYQ@mail.gmail.com>
 <2e5e16a1-e59e-470d-a1d9-618a1b9efdd4@lunn.ch>
 <CAOiHx=mQ8z1CO1V-8b=7pjK-Hm9_4-tcvucKXpM1i+eOOB4axg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=mQ8z1CO1V-8b=7pjK-Hm9_4-tcvucKXpM1i+eOOB4axg@mail.gmail.com>

> Without this change no mode/port works, since there is always either a
> 0 ns delay or a 4 ns delay in the rx/tx paths (I assume, I have no
> equipment to measure).
> 
> With this change all modes/ports work.

Which is wrong. 

> With "rgmii-id" the mac doesn't
> configure any delays (and the phy does instead), with "rgmii" it's
> vice versa, so there is always the expected 2 ns delay. Same for rxid
> and txid.

If you read the description of what these four modes mean, you should
understand why only one should work. And given the most likely PCB
design, the only mode that should work is rgmii-id. You would have to
change the PCB design, to make the other modes work.

> The Switch is always integrated into the host SoC, so there is no
> (r)gmii cpu port to configure. There's basically directly attached DMA
> to/from the buffers of the cpu port. Not sure if there are even
> buffers, or if it is a direct to DMA delivery.

That makes it a lot simpler. It always plays the MAC side. So i
recommend you just hard code it no delay, and let the PHY add the
delays as needed.

	Andrew

