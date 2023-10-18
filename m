Return-Path: <netdev+bounces-42331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6D7CE4C8
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D16A281B08
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614B13FB0D;
	Wed, 18 Oct 2023 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVvNKp1G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9562F531
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 17:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F17C433C8;
	Wed, 18 Oct 2023 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697650816;
	bh=a4MNBzIoQraa+P47UnuWNFSqE8gtKcdSsgT0BnTe1Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YVvNKp1Gdiy4zquRwSNqkoqP9Y8U1CeEAVV8xmeElCyZ8nCupZmWYM7ZTz1xZB9dY
	 8AHPqT+TI3kITYLP7q8ccjFQhl5JV9Bc9bjmAkXAEHYzrFH3pve6CqtbDbab8Bnnl6
	 yeua8COeRAd6q1xaRDSLEgFDq1OkCzqHdXUlq6CcxFeAVmCICPR5MnkBm18/eiBt41
	 8QYwyXm+zebSU3kSVNasCwuS+26jLzVO1PBQflcoYVqsHuyli5k4x7yd6eHqQ3+FrA
	 jLTRGDCWrhp4z06IZP4FBWDo7gCM7ZJixinvMqNLCMPyUeDoFTldAABiA8VYmt/mUv
	 au/6sQvEm84NQ==
Date: Wed, 18 Oct 2023 10:40:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: takeru hayasaka <hayatake396@gmail.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20231018104015.42b2465b@kernel.org>
In-Reply-To: <ZS-TfMKAxHLEiXBl@nataraja>
References: <20231012060115.107183-1-hayatake396@gmail.com>
	<20231016152343.1fc7c7be@kernel.org>
	<CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
	<CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
	<20231017164915.23757eed@kernel.org>
	<CADFiAc+OnpyNTXntZBkDAf+UfueRotqqWKg+BrApWcL=x_8vjQ@mail.gmail.com>
	<ZS-TfMKAxHLEiXBl@nataraja>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 10:12:44 +0200 Harald Welte wrote:
> > If we were to propose again, setting aside considerations specific to
> > Intel, I believe, considering the users of ethtool, the smallest units
> > should be gtpu4|6 and gtpc4|6.  
> 
> agreed.  Though I'm not entirely sure one would usually want to treat v4
> different from v6.  I'd assume they would usually both follow the same
> RSS scheme?

FWIW I had the same thought. But if we do add flow matching 
support for GTP one day we'll have to define a struct like
struct ethtool_tcpip4_spec, which means size of the address
matters?

