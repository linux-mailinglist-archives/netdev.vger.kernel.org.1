Return-Path: <netdev+bounces-104612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14D390D9C2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65832B2152E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621FE46521;
	Tue, 18 Jun 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/0b/CGe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1C1C69D;
	Tue, 18 Jun 2024 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727776; cv=none; b=T6A0T/PlBspF2CoaEK/2AiGlzpx2XMDOdLDeIxfPttLECCO0KZCAahUegYI/5r4loI6ZOklbLNAtUGuYCUbTXbL7rRwT7D2LF0xlcCUS01vMPl2p9XYyt8LJOHwTg0wKBuufgLOS5kg9Amzgi04391X+++kB38ITJ54U3zHRIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727776; c=relaxed/simple;
	bh=7EkWMiTFJTp4Y6SiUk03tFcENf1E0aDZFTVbA0kik4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwlmooUcHeFjSigG58wol8qUiqQYvGud7lNuKFqz6eABTsWEv/OsccT8Gr3iYXffGLKnPUCj5KMarYpJ7h1cSNmnQylcNtA12jca0iEqw4hiGLaVzPbQFxpjEILbI7zLPRpA/eDh5bNfNaKoSRVx2Aa4RB/AL0USahBxrURUHh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/0b/CGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CD3C3277B;
	Tue, 18 Jun 2024 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727775;
	bh=7EkWMiTFJTp4Y6SiUk03tFcENf1E0aDZFTVbA0kik4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/0b/CGeXrmx3Uu/shqeRp0mCHUx4jeqU17NMN2RukV7LXkwdtRIS4VYTjizU6aCv
	 /5GHy6Q/0O1Rrq++7D2YYwI0G4yHTIyf9+pHauALKP+H80XikDQWHs0uvCPNXSjeXE
	 Ma/tzmavOPStc7y75dmYxmimuFy+/WmUBqM5x5Tu8s+sHuUH2Rnta7vlNtq/kDYgAW
	 0E7zxSOPgR4Szz9yfQ6h0piCeqK+QHy4b9JB7qywCgnG5yIWzbID00Eue5jT2UYYxx
	 CVaAdh6DyWO0XX+GBfynfpZQFooCrVe5qc7jODjobAbnNYaPUOCRoAkxUnSGp7/JTx
	 3TSAUivdD5bPw==
Date: Tue, 18 Jun 2024 17:22:49 +0100
From: Simon Horman <horms@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v4 1/5] net: ti: icssg-prueth: Enable PTP
 timestamping support for SR1.0 devices
Message-ID: <20240618162249.GP8447@kernel.org>
References: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
 <20240617-iep-v4-1-fa20ff4141a3@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-iep-v4-1-fa20ff4141a3@siemens.com>

On Mon, Jun 17, 2024 at 04:21:40PM +0100, Diogo Ivo wrote:
> Enable PTP support for AM65x SR1.0 devices by registering with the IEP
> infrastructure in order to expose a PTP clock to userspace.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Simon Horman <horms@kernel.org>


