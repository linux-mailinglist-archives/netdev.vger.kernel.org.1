Return-Path: <netdev+bounces-40058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E777C5957
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1F41C20AB4
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9791BDC5;
	Wed, 11 Oct 2023 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2uDkKIO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275E1B29B
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DB0C433C7;
	Wed, 11 Oct 2023 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697042476;
	bh=hejh49+2QJYUTv/+mj/o5LoRRT/U0icOUjD72vSPqFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D2uDkKIO6qFka1E/H1MPofJv0xZKXnhqqQeemZgDdoL97jDFj3u+R1OKQtU5wcXp/
	 YLov0IhajJJu2nhyT0egq/WSQ45qaIAYKTW6uRuRN3k5cWyg1RCvM/3s8+PDZYk6Er
	 S3RTx7vwBRMdgK0g5bTjHd674CMJeGkK2sS+hA67XQNnlkwlUIHi5vemHPQzJ8Eq9P
	 6XijW+Z5bioIdbaTRnzbgRpOcs+VCxxFqhI+cdbaAE2MxoruSal/FHp/tOlWNLEDSP
	 tW49wzRAMztLeirvCgB4tXverg+HJU6+ujzBjs2fmKWgtTJlvn9iC1a/dIweOYojD0
	 FlVFjA5fFpphA==
Date: Wed, 11 Oct 2023 09:41:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: takeru hayasaka <hayatake396@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ethtool: ice: Support for RSS settings to GTP
 from ethtool
Message-ID: <20231011094114.4d8f24c7@kernel.org>
In-Reply-To: <CADFiAcL-kAzpJJ+KAkvw2tH8H0-21kyOusPSPybcmkf3CM7w9g@mail.gmail.com>
References: <20231008075221.61863-1-hayatake396@gmail.com>
	<20231010123235.4a6498da@kernel.org>
	<CADFiAcKF08osdvd4EiXSR1YJ22TXrMu3b7ujkMTwAsEE8jzgOw@mail.gmail.com>
	<20231010191019.12fb7071@kernel.org>
	<CADFiAcL-kAzpJJ+KAkvw2tH8H0-21kyOusPSPybcmkf3CM7w9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 14:25:55 +0900 takeru hayasaka wrote:
> > Regarding the patch - you are only adding flow types, not a new field
> > (which are defined as RXH_*). If we want to hash on an extra field,
> > I think we need to specify that field as well?  
> 
> I've been really struggling with this...
> When I read the Intel ICE documentation, it suggests that in RSS, TEID
> can be an additional input.
> However, I couldn't think of a reason not to include TEID when
> enabling RSS for GTP cases.
> 
> https://www.intel.com/content/www/us/en/content-details/617015/intel-ethernet-controller-e810-dynamic-device-personalization-ddp-technology-guide.html
> (cf. Table 8. Patterns and Input Sets for iavf RSS)
> 
> However, for Flow Director, it's clear that you'd want to include the
> TEID field. But since I found that someone from Intel has already
> configured it to use TEID with Flow Director, I thought maybe we don't
> need to add the TEID parameter for now.
> 
> https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210126065206.137422-1-haiyue.wang@intel.com/
> 
> If we want to include something other than TEID (e.g., QFI) in Flow
> Director, I think it would be better to prepare a new field.

I think we should expose TEID as a field. It's easier to understand 
the API if fields are all listed, and not implied by the flow hash.

