Return-Path: <netdev+bounces-104091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B263E90B2EF
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83B61C2163C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F916849B;
	Mon, 17 Jun 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MtTKoTJ+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F31684B6
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632736; cv=none; b=V2fJpi1bqMcXCZRxvN3pGVDC79QY1icPfSzxfUrOxE9pzNDQNF+Vyl4mqAMxijszOMshDmZfXXtjGGHXO2RJLELJ+cu5l+KG2IA4vTkHg0BFipkHonUo8YITLrlePSCnSbr8Ib70kgT5Rj/mH5CtkkSnPhzkCvAaQEY6C6/8mfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632736; c=relaxed/simple;
	bh=W/Aqk/7oXaEh9mhEB9Hn8rNRREtOVyHsZ3CZasc7xfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uazlwKYxTuAN5KEp7Yhq2NVeE32Ko9//3IJxn/iaGnwguCAeg+4LhinmJViLQ03Fp/u878V4oZaojQDN6WjKVK+RD+j/dZtQQbBX+tvs6TB36QjFZa3TdQP7eeFlKxmrnmSwS9T1Qi/FBBRs/DyLGUxuFdt1j67hDP9ffR1jEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MtTKoTJ+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AHvkV7+GLtuXZMnRGYTf+DwpIumYTAJbV1dBEGg5O0o=; b=MtTKoTJ+73HCi7KgrNTPD1OjfM
	+rH/cR9bGR0PtNSOSQBaSrOOOJ2QCSSBUiRMTEAZXXDEy8Y7TkwIEIZS89wfiX0zIko55B9MoGtjX
	48uG/eEJqdiaQ3KbIICMD46cnMqZ8pXnFomO9CByZlGqPyLWIvCr0UesYaYJcPMOVbzg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sJCsi-000H5O-81; Mon, 17 Jun 2024 15:58:48 +0200
Date: Mon, 17 Jun 2024 15:58:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: hfdevel@gmx.net, kuba@kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	linux@armlinux.org.uk, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
Message-ID: <5a38a8c6-a4a2-4e5e-b6a8-b02e86b8cd5a@lunn.ch>
References: <00d00a1c-2a78-4b7d-815d-8977fb4795be@lunn.ch>
 <20240616.214622.1129224628661848031.fujita.tomonori@gmail.com>
 <8c67377e-888e-4c90-85a6-33983b323029@lunn.ch>
 <20240617.144427.323441716293852123.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617.144427.323441716293852123.fujita.tomonori@gmail.com>

> 1) initializing the table in module_init.
> 
> 2) embedding the calculated values (as Hans suggested).
> 
> 3) calculating the values as needed instead of using the table.
> 
> 
> Which one were you thinking? I have no preference here.

2)

	Andrew

