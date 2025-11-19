Return-Path: <netdev+bounces-240112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C7C70AAA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE022348381
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C23D327C08;
	Wed, 19 Nov 2025 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgpJCLrj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726A3074BC;
	Wed, 19 Nov 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577347; cv=none; b=hBN58PFmWhzpDUWODLl+nKEXblFKDLkBuikmUHDTWBb5uOuCgKEeCIObsi+gDa+gafTs8sE2pctexDSU8OJs9t7U0oo0A2de53+t4hRNlrBKGh82UbD/6nO1FN3nJSDiCwD+wPmgOu6jNSIklX2Rsgi/Aw24CxvuLuxpsfcY7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577347; c=relaxed/simple;
	bh=9wKGQkAN4eTHkqUQxVV6qaoHW5rjdvZ6IVdsYwt3fCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=en5780Djr2wt4A+SzWJ/B9SKTMN2noVVolmliwho13bfsf6iOSOI84EtAzfUzXFSnAD2hXBH9ZklDXxs86S5jmlUZKIQvJc+ygEk7vlzJeNSCuBqTf6mYiynEckw+eHQnv4RDwhet0yZc6nPU9uadb1EzRdwVGwCh5chpcvwX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgpJCLrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197DDC4CEF5;
	Wed, 19 Nov 2025 18:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763577346;
	bh=9wKGQkAN4eTHkqUQxVV6qaoHW5rjdvZ6IVdsYwt3fCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RgpJCLrjn4N8u/Zxq35Fzci8fPcO+a2dBRsirEtQUGSKTfddFtu1TvBc1M6MmTjtN
	 F3bMeefe3wrKYCXK7Brt7fPZMESV0snx4cLVutSXuX6/BY1K4ydDl/y33M3QyiSquX
	 sUguGXj3cBTMw47MM2dK6sF6Ioqmfd35JBi8NANxpAwpRqF0cCU6ZodE6EdUlVUPSM
	 7FokbINa1SuKcLgOqAPdgZcpCnISg8t7FVCfBVV28+J3zt/HH2zAfwNUCrUiW8/nLf
	 fOKVUTHyTPwTvWTanoFAY9NEBFq7Tds3DtUpt4LJ0b3gcv5anUGAyAaelpnKa2nXu+
	 7IUmDdcFCPLuA==
Date: Wed, 19 Nov 2025 10:35:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Serge Semin
 <fancer.lancer@gmail.com>, Herve Codina <herve.codina@bootlin.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <20251119103545.53c13aac@kernel.org>
In-Reply-To: <aR4A1MaCn9fStNdm@smile.fi.intel.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
	<20251118190530.580267-15-vladimir.oltean@nxp.com>
	<20251118164130.4e107c93@kernel.org>
	<20251118164130.4e107c93@kernel.org>
	<20251119095942.bu64kg6whi4gtnwe@skbuf>
	<aR2cf91qdcKMy5PB@smile.fi.intel.com>
	<20251119112522.dcfrh6x6msnw4cmi@skbuf>
	<20251119081112.3bcaf923@kernel.org>
	<aR3trBo3xqZ0sDyr@smile.fi.intel.com>
	<aR39JBrqn5PC911s@shell.armlinux.org.uk>
	<aR4A1MaCn9fStNdm@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 19:39:32 +0200 Andy Shevchenko wrote:
> On Wed, Nov 19, 2025 at 05:23:48PM +0000, Russell King (Oracle) wrote:
> > On Wed, Nov 19, 2025 at 06:17:48PM +0200, Andy Shevchenko wrote:  
> > > On Wed, Nov 19, 2025 at 08:11:12AM -0800, Jakub Kicinski wrote:  
> > I can say that stuff such as unused const variables gets found by
> > nipa, via -Wunused-const-variable, which as I understand it is a
> > W=1 thing.
> > 
> > I suspect CONFIG_WERROR=y isn't used (I don't know) as that would
> > stop the build on warnings, whereas what is done instead is that
> > the output of the build is analysed, and the number of warnings
> > counted and reported in patchwork. Note that the "build" stuff
> > reports number of errors/warnings before and after the patch.
> > 
> > Hope this answers your question.  
> 
> Pretty much, thanks!

We do:

prep_config() {
  make LLVM=1 O=$output_dir allmodconfig
  ./scripts/config --file $output_dir/.config -d werror
  ./scripts/config --file $output_dir/.config -d drm_werror
  ./scripts/config --file $output_dir/.config -d kvm_werror
}

I have strong feelings about people who think Werror is an acceptable
practice in 2025, but let me not violate the CoC here..

