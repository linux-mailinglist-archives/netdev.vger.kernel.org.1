Return-Path: <netdev+bounces-38614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C5A7BBABA
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FC1C20948
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D5A250EA;
	Fri,  6 Oct 2023 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw4cglRd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94322EF8
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1391C433C8;
	Fri,  6 Oct 2023 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696603700;
	bh=tpz2lJHsFpXAdojf/r2F+CjbjlhID/zdHJhAMnUPoCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pw4cglRdfnNQIC+v8UHZFG9a8HZIFKlwmn8crhYx3+RrtDuK/Umh0/7FsERtCn7R4
	 yEaIj7ty0itLM2i1EjAWcqxRaQDxBDvKKBCk4aSis+ZYZGyJ7rirPb8+wvJcfTe2X6
	 ORJvvnuzdLyrsQnhNN/1hn19HGLs6ceD84WuebNp0U08JxkqLJeJANE51iAQfxUKxc
	 NjMyXpnXhWpL/Fpew1ALhW7OrQpKPE8ZTT9MBfOmzjIanNM2T7svMBG08yXegkygnx
	 iTMvKnL+r2rU66lKgBvyFyBLiVz1aqQZDgZx0RD/aBKRNa5ytE46xX8PqmZ2Iu0aNn
	 WkJqroi9ENOfw==
Date: Fri, 6 Oct 2023 16:48:15 +0200
From: Simon Horman <horms@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: rdunlap@infradead.org, wenjia@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	netdev@vger.kernel.org, raspl@linux.ibm.com, sfr@canb.auug.org.au,
	alibuda@linux.alibaba.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com, tonylu@linux.alibaba.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH net] net/smc: Fix dependency of SMC on ISM
Message-ID: <ZSAeL1aLpkXVweg6@kernel.org>
References: <d9a2d47d-c8bd-cf17-83e0-d9b82561a594@linux.ibm.com>
 <20231006125847.1517840-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006125847.1517840-1-gbayer@linux.ibm.com>

On Fri, Oct 06, 2023 at 02:58:47PM +0200, Gerd Bayer wrote:
> When the SMC protocol is built into the kernel proper while ISM is
> configured to be built as module, linking the kernel fails due to
> unresolved dependencies out of net/smc/smc_ism.o to
> ism_get_smcd_ops, ism_register_client, and ism_unregister_client
> as reported via the linux-next test automation (see link).
> This however is a bug introduced a while ago.
> 
> Correct the dependency list in ISM's and SMC's Kconfig to reflect the
> dependencies that are actually inverted. With this you cannot build a
> kernel with CONFIG_SMC=y and CONFIG_ISM=m. Either ISM needs to be 'y',
> too - or a 'n'. That way, SMC can still be configured on non-s390
> architectures that do not have (nor need) an ISM driver.
> 
> Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-next/d53b5b50-d894-4df8-8969-fd39e63440ae@infradead.org/
> Co-developed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

