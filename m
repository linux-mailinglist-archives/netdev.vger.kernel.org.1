Return-Path: <netdev+bounces-181141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF3A83CB9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE5A1898734
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938D204C30;
	Thu, 10 Apr 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx/C44HZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9921D86DC;
	Thu, 10 Apr 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273306; cv=none; b=F9kb6Nh+HDFkPkr1UI31WzM/MusCnG8tQOA8jC5GUmCJkx/hH+IESuuSqo4LIgIH3/t5K/9kRRxrSikZwfL7EfMy7/TFswxjMqYE2uyGRJ5Gb6Oz2Tr9cf7S7v9QwqrTQylbR3EU+IESq4Z1d7Ku2rwxSEcz/g/XZrdz/x8WbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273306; c=relaxed/simple;
	bh=T6cKF1AH6u5sSEkewMIOmHQeFJzUhjmBmmaZtyPLzhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C55650Esb2JwPJ+sMnK8qlssZHKS5rGVx3PlfaLL3gdQvekScVHEPj3ybJRLQdGiO11cgQ/qerr2vEomx1vvj/AWIXCtRRqDsIkKKvmOUZ4mBIphsxsuCzgqF6Wm7kbU4pOR2X6jp1+wfcA3/kusHBk6puFthn9IPGWqSNPIHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx/C44HZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E49C4CEDD;
	Thu, 10 Apr 2025 08:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744273304;
	bh=T6cKF1AH6u5sSEkewMIOmHQeFJzUhjmBmmaZtyPLzhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cx/C44HZl16jH12vNnkP451QQg5FzAk7RvBGhK7Tfe3tdRcND7YkpVLx7eVQXIS03
	 fRsb0Id09N2YUjJxtfvW9ymhqshFCLl/+nkASkq2fBPKj+gNBgAuI+tv35pl4ka26w
	 UDc00QsDlSCwiJeCFKTFC+JrRpph7hQ+KVmgoVHGerHDsUUk1f0pnwrEUI2ls3IChR
	 c6dX6lWqSvyAQZ07QtHllKqzulecA6fl3BdFpRwdaC2wxv9FzxYG5OFmFVFIbVXbV9
	 uBpnLJYoUJVPme7KZqHnZhvqBcvSGHCzrsZLrAZiS6APigrLrMhaepwlfrHxmVTuxJ
	 Ejz3aooy8rCeg==
Date: Thu, 10 Apr 2025 11:21:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wenjun Wu <wenjun1.wu@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Phani R Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH iwl-next 05/14] libeth: add control queue support
Message-ID: <20250410082137.GO199604@unreal>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-6-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408124816.11584-6-larysa.zaremba@intel.com>

On Tue, Apr 08, 2025 at 02:47:51PM +0200, Larysa Zaremba wrote:
> From: Phani R Burra <phani.r.burra@intel.com>
> 
> Libeth will now support control queue setup and configuration APIs.
> These are mainly used for mailbox communication between drivers and
> control plane.
> 
> Make use of the page pool support for managing controlq buffers.

<...>

>  libeth-y			:= rx.o
>  
> +obj-$(CONFIG_LIBETH_CP)		+= libeth_cp.o
> +
> +libeth_cp-y			:= controlq.o

So why did you create separate module for it?
Now you have pci -> libeth -> libeth_cp -> ixd, with the potential races between ixd and libeth, am I right?

Thanks

