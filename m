Return-Path: <netdev+bounces-181625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108D8A85D17
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1318C241F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196CA238C0F;
	Fri, 11 Apr 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Plejhp+K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA50278E61;
	Fri, 11 Apr 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744374738; cv=none; b=mC0uMcYcpkzQBdzTyRy+QPsBkG+TC9FXz4Cx0PPMso6b8BvSBe9ECdWHjTceJqYlB55YLyAC+M36FqbWHVjgLfAa4ttlMI6F1pWfNTy9Z5olxq9X7HulgoUaTSWrxWlU3Bpsg1qOL6CVqeYV3reEyKpmBk5qxNHtCxb7WFAg13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744374738; c=relaxed/simple;
	bh=h8j0KNqrlbIXeOpaRXQwNHp/A7ePkWrs3CKkrme3uE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hq2HTemuzIGRtU0ulrxUY8nJOTJnWOsXMtRWPtvHL3HEw4ejUKdDULP4TEQQh7rDCO5B52JNBseidIJF78ENRYQTAoWeUJsCgp7udqxAHhfBFjstYHFXRxhIdoGfmr1uNZQ9PSCkuLh7PcTc7LddfdAlLLPoKySUmemckStat0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Plejhp+K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=402HI5/cuEiy7munZK1eW//tKKmYALoCkgz7d2IOAGQ=; b=Plejhp+K069D+Y6l3LFxLl5ZM0
	mWfdsQk6rT7Wwe3Iih03Eeqd0SI7Uq2iyEFrQ2GdFnx2rSP6G0aUUX6iQBb7k6YmzCYUnHjQDZmhy
	l7bun6QtcBl12VErFEWxKIIl4VkAzLAFRyQ9XksBTsYO4BfWoJU3+JwgWlJWpbQOkdwk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u3DY4-008nxa-W6; Fri, 11 Apr 2025 14:31:56 +0200
Date: Fri, 11 Apr 2025 14:31:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
Message-ID: <8c9e95e2-27da-4f3d-b277-ca8e98ab61ef@lunn.ch>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-8-ivecera@redhat.com>
 <CAHp75Ve4LO5rB3HLDV5XXMd4SihOQbPZBEZC8i1VY_Nz0E9tig@mail.gmail.com>
 <b7e223bd-d43b-4cdd-9d48-4a1f80a482e8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e223bd-d43b-4cdd-9d48-4a1f80a482e8@redhat.com>

> 2nd regmap for indirect registers (mailboxes) (pages 10-15) with disabled
> locking:
> 
> regmap_config {
> 	...
> 	.disable_lock = true,
> 	...
> };

Do all registers in pages 10-15 need special locking? Or just a
subset?

	Andrew

