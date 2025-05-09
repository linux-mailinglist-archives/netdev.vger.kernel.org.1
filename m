Return-Path: <netdev+bounces-189402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C7FAB2034
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531B59E4855
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7781026462A;
	Fri,  9 May 2025 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0chTNvM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F11263F44
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833284; cv=none; b=l0D+2y9kiMHQSzDMFAjOAhpcidJFaTCsoCuqqa6PVEWbXP7rCmLu4k2MdKtNwQCEeVEBAdF4OUlA+mELduWugxMxlxi3dicodnDvITg1IeD/hCQTyFVghCqJ5U5VWlibCgj2mlPr/KW3gCLmxoGaaLb6igJ5twimSrm0sQiEhrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833284; c=relaxed/simple;
	bh=ng6yPoq+OKE5ywHHR1OspsTvJmNlNuRTj4biaFJmOZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/irfPQ6RhmEvhueFGDuJ+CZiR1q96o2m+Hpl2HdPxSsc+wDVNhM8SiH3UgkTrca7Fq6VqY14sEJYCguT5t/bxy4DLiww+b/xIGLy39LJosYgxCYiayiBjF/xkZSYIVWAHjPsdF61KMSkSL8OxP6iUljKch+FsoOoSRXMLF+ERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0chTNvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7140BC4CEE4;
	Fri,  9 May 2025 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746833283;
	bh=ng6yPoq+OKE5ywHHR1OspsTvJmNlNuRTj4biaFJmOZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H0chTNvMG1RXoTDyY4GItmGBseNoO/S9S9n1Jz24Ha49G3d8iuFoS28NHpJdwIjQk
	 27TQVqr3zLx3VwanEpu9KmEUtpnkgGC2FZgvYQiYU2It2QghMWjg2NDEN8J67ZwYyL
	 5E8kmeakbkeOuj43w2fDwJcx3mdfWLjhnZbahV2oQkFWeuFbaF5tUcBpCXxUGJx6cA
	 4JO6H+LKAtZpzSE7wXQgbZpJ+gLxWfoJ6wS0i3ASvXZD3T4U7HsVQc3fAA07ZcFDYj
	 EbMFoYOO6Ab1og7C1leTQY4UdYrFn0KfA8+Culc97DccbDKcfvQTGtdm4hsc6zRvKt
	 dPK14qu53r7zw==
Date: Fri, 9 May 2025 16:28:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [PATCH net-next v2] ethtool: Block setting of symmetric RSS
 when non-symmetric rx-flow-hash is requested
Message-ID: <20250509162802.54bcfb5a@kernel.org>
In-Reply-To: <a0a458de-44b4-4f08-b6d4-4775212c1cf0@gmail.com>
References: <20250508103034.885536-1-gal@nvidia.com>
	<a0a458de-44b4-4f08-b6d4-4775212c1cf0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 15:41:39 +0100 Edward Cree wrote:
> On 08/05/2025 11:30, Gal Pressman wrote:
> > The conversion of uapi #defines to enum is not ideal, but as Jakub
> > mentioned [1], we have precedent for that.
> > 
> > [1] https://lore.kernel.org/netdev/20250324073509.6571ade3@kernel.org/  
> 
> Isn't the traditional solution to this kind of issue to do
> #define FOO FOO
> after each enumeration constant definition?
> Any reason that can't be done here?

I think the question is reverted. Any reason to do it here when we have
no proof that code using ifdef CONSTANT exists..
As previously mentioned there's precedent for define -> enum conversions
for BTF, and nobody complained. OTOH having each line followed by a
define is not super clean.

