Return-Path: <netdev+bounces-102019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E6901196
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CE51F21D73
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C676178362;
	Sat,  8 Jun 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxNkPtcr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398082BAE9
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851579; cv=none; b=aFkZCL3lnPom2O5MObnptZNdP3qqVAR/JGwSYNKwr+nZjEKH5Qw9C83nSRqsPU7VMm1GGlZGs3wc/Hg3eKha/yTJe/aE8pCbk0IWLxThnJytLDzkZdPta61lPxSgZDALUHvnC1CE5xsuPLGQiaZ1GuQsVTdi0saBdsfFj1xVwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851579; c=relaxed/simple;
	bh=66RBUCctymOeYenWzkI6pbfx5NZQIGtxYRb2XI9dboo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaadEt+M8XToSBAlatNa+9886PDna4WT0jAs/BnRGZMX06LhHSdcw50Y95G6YsAzzfJbzH+6rnTqmBuR5YGD0JSp4LZKZw03IrdPq3L8gtDeCC43HUVe1piT+9KmUiQEQDo1QbmPIX2PblCM3jCh5Y2SLfXf+IL+ym2HYO+IzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxNkPtcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88917C2BD11;
	Sat,  8 Jun 2024 12:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851578;
	bh=66RBUCctymOeYenWzkI6pbfx5NZQIGtxYRb2XI9dboo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxNkPtcrsBuKhFjDQbS+XQ/sBAWmsAqHV19so/ntCFq0NFmthYsCjilr9LOPDfveJ
	 SP9myWOOeIGLw/YD9HUdr4JOx6XCfevZCPeGVv4yiatN1HUW7m+5erEaGvNZEh7djC
	 zaAhpPMTL5Ad0k181LtP8ktLzCHFbECOQFonYZsDkJo02Qw1wQuIA9dxITwydqG2i9
	 D6DatlCJ62wFRnoos30ulfL5JWkU2aLRml+nZEEmWlFWYFolGjFXFbhgst2Jssc/3u
	 fs78HMIVmUJOA8r9pB/tBFU/EXoXYlplm3CttRkR1u/QxLQMMPzsSTniRLTPew6mJ2
	 9UHftVHDoY9yQ==
Date: Sat, 8 Jun 2024 13:59:35 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 09/12] iavf: refactor
 iavf_clean_rx_irq to support legacy and flex descriptors
Message-ID: <20240608125935.GB27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-10-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-10-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:57AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Using VIRTCHNL_VF_OFFLOAD_FLEX_DESC, the iAVF driver is capable of
> negotiating to enable the advanced flexible descriptor layout. Add the
> flexible NIC layout (RXDID=2) as a member of the Rx descriptor union.
> 
> Also add bit position definitions for the status and error indications
> that are needed.
> 
> The iavf_clean_rx_irq function needs to extract a few fields from the Rx
> descriptor, including the size, rx_ptype, and vlan_tag.
> Move the extraction to a separate function that decodes the fields into
> a structure. This will reduce the burden for handling multiple
> descriptor types by keeping the relevant extraction logic in one place.
> 
> To support handling an additional descriptor format with minimal code
> duplication, refactor Rx checksum handling so that the general logic
> is separated from the bit calculations. Introduce an iavf_rx_desc_decoded
> structure which holds the relevant bits decoded from the Rx descriptor.
> This will enable implementing flexible descriptor handling without
> duplicating the general logic twice.
> 
> Introduce an iavf_extract_flex_rx_fields, iavf_flex_rx_hash, and
> iavf_flex_rx_csum functions which operate on the flexible NIC descriptor
> format instead of the legacy 32 byte format. Based on the negotiated
> RXDID, select the correct function for processing the Rx descriptors.
> 
> With this change, the Rx hot path should be functional when using either
> the default legacy 32byte format or when we switch to the flexible NIC
> layout.
> 
> Modify the Rx hot path to add support for the flexible descriptor
> format and add request enabling Rx timestamps for all queues.
> 
> As in ice, make sure we bump the checksum level if the hardware detected
> a packet type which could have an outer checksum. This is important
> because hardware only verifies the inner checksum.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


