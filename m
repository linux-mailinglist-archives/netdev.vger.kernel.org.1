Return-Path: <netdev+bounces-38131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FEE7B9875
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1192528193E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2452C262B8;
	Wed,  4 Oct 2023 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCUKYNVp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084EC22F1C
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 22:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C80C433C7;
	Wed,  4 Oct 2023 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696460216;
	bh=Me4/VkMC7j1r8DeOEaXdnLeyeaoIZ4d8reP9/IH5dBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VCUKYNVpZIYtC8T+xyF7fWCToT+m4tnSsEsGhXphS0DDe2XkayCPNuulUWR6Fe9kV
	 XqDEymCUrNaB3wjZznSKB7z6WqtpCzpQoQcPMzBbl1LJcDZiSXdHSUiwLqHvDo6EiF
	 YCrOx/hJjsd6/+JEPXbi9vDO00ZUuzUJo4QLp6HufhU60GeazTyCp2VVqt8ujD0/pX
	 YWZg0vKfb+O580ryuHHFxPDbHU/KdMISjdtYHbeNoH1QuBpdd7NkY+7mUD7v1gfQkr
	 WkcUxiY0iGXEIBVP8lbTckEa0oQCwrn4h62H1/Z7/XAgJBnSSb49WNNhXOLbEpkIrr
	 vfVrdIKr+YnUA==
Date: Wed, 4 Oct 2023 15:56:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <edward.cree@amd.com>, <linux-net-drivers@amd.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, Edward
 Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
 <habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
 <jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
 <linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
 <leon@kernel.org>
Subject: Re: [PATCH v4 net-next 2/7] net: ethtool: attach an XArray of
 custom RSS contexts to a netdevice
Message-ID: <20231004155655.470845fb@kernel.org>
In-Reply-To: <781cf46c-bbcc-5223-76b8-176c7bf5836d@intel.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
	<4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
	<781cf46c-bbcc-5223-76b8-176c7bf5836d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 11:17:53 -0700 Jacob Keller wrote:
> > +struct ethtool_rxfh_context {
> > +	u32 indir_size;
> > +	u32 key_size;
> > +	u8 hfunc;
> > +	u16 priv_size;
> > +	u8 indir_no_change:1;
> > +	u8 key_no_change:1;
> > +	/* private: driver private data, indirection table, and hash key are
> > +	 * stored sequentially in @data area.  Use below helpers to access.
> > +	 */
> > +	u8 data[] __aligned(sizeof(void *));
> > +};  
> 
> Is it not feasible to use container_of to get to private data for the
> drivers? I guess this change in particular doesn't actually include any
> users yet...

That could work in general but here specifically there are also 
2 variable-size arrays hiding in data[].

