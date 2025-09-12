Return-Path: <netdev+bounces-222472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C3B5466C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695EF1897AA4
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974D32765EA;
	Fri, 12 Sep 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH2i35iK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733F626E16C
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667843; cv=none; b=NDMNN+eXRu+l29VNH1wDCTJHQ7YYm/BVQnN9JXpbSmd5i6a+P2Ynmnp1dCjlsk2GtcYK9aixqF2QK+U247kBOTp6kysnr3JS1JH7zUlvtCx4o5nKhQurG+y9LSTOH6rrF/9VNMn6CBLijnTEmykBldakFY4rLZoPs3g4XPIfUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667843; c=relaxed/simple;
	bh=6P97i865U08jWJQoiTmLd/zDtEt1kPmipD6fJxtrMLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfhidgI7G8IDkkpG+fjBvyjhxhjUzaKcdbTWCO3VjNLWRUSlUAA2K4XlrbaerRtG/iINcw9vIRNrpumRXdTfBXhc7ZMibxOzMlGZBBLN/03TYMSVlMugI9kInl7ZRvQ7Pz6F/2n62ifuu+apamgyvYaBToT2PWezLyuiTiV1FsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH2i35iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDABCC4CEFE;
	Fri, 12 Sep 2025 09:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757667843;
	bh=6P97i865U08jWJQoiTmLd/zDtEt1kPmipD6fJxtrMLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fH2i35iK+XMUhPaRiq+syIGF0Q1YriCNDDGl6t4jbGBMTCcC4TYK23Oq0H3YX2tow
	 X1+tSVSsNWpYbnBPsPEOoKUU59IzjUrbTfoynhW3QYlSCQP+2kUSeLRf5h44HZbvJ8
	 3V9KuCldVCU4XUHJF3C0KPI4ZQmkHz3gLgVezpVMFChVHf9XfIlb+8Ad0czyKvpvOY
	 OcrdiWOy6xdnqfemQ9dHfqHOlen9ArNJtw1/k1G2Y9MaRe6c0/Dggvl5SYcm9PCDtc
	 3Tb+Q70bjPy0pWwuGBFbpWCPKUlorTbIIi6jQiYyyrLtZXgqw+cibvCHFYP9JKTvHj
	 Ri25W3NEX0rzg==
Date: Fri, 12 Sep 2025 10:03:59 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, mschmidt@redhat.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [PATCH iwl-next v4 5/5] iavf: add RSS support for GTP protocol
 via ethtool
Message-ID: <20250912090359.GY30363@horms.kernel.org>
References: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
 <20250829101809.1022945-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829101809.1022945-6-aleksandr.loktionov@intel.com>

On Fri, Aug 29, 2025 at 10:18:08AM +0000, Aleksandr Loktionov wrote:
> Extend the iavf driver to support Receive Side Scaling (RSS)
> configuration for GTP (GPRS Tunneling Protocol) flows using ethtool.
> 
> The implementation introduces new RSS flow segment headers and hash field
> definitions for various GTP encapsulations, including:
> 
>   - GTPC
>   - GTPU (IP, Extension Header, Uplink, Downlink)
>   - TEID-based hashing
> 
> The ethtool interface is updated to parse and apply these new flow types
> and hash fields, enabling fine-grained traffic distribution for GTP-based
> mobile workloads.
> 
> This enhancement improves performance and scalability for virtualized
> network functions (VNFs) and user plane functions (UPFs) in 5G and LTE
> deployments.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



