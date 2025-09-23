Return-Path: <netdev+bounces-225538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781D8B953F7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1182E473E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD92031CA5A;
	Tue, 23 Sep 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXg80mPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F83191A6
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619738; cv=none; b=o3uS3u5YIITASNN7OLB0ZRsHvzMfEXANPEOyWhrWs/o//WXSpArAFDyMeKihMs0GXKOXVcUm9LYMV57aPDdIGMSF3YGZM161Z/6Qn+8ak0WSr/JR7QZ+Grs8yhVTjY8VzqB0nUmSd07mi64iNcwxRkTosqGCsgAEW+q8mne9h6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619738; c=relaxed/simple;
	bh=+clR6Ohj4shvtZ4Od5XAq00h67vP8sWoPMLPPDKC6fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL9W2dN11XU2JEx31fbILhc2rAkA9S/g0AFGWxSgB6OtBtK+F/SknXuhtb4KucYBps1gfhL4qxkRtz7iZZ4epaVv/My/0+hAeW1mUSdMSDmAUgpNNHo9rlzAccTG+JuigwDnVx+Qnuia2aD3Ztqkdv5Fb8WKrBJCV3kXWY5qCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXg80mPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50E7C4CEF5;
	Tue, 23 Sep 2025 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758619738;
	bh=+clR6Ohj4shvtZ4Od5XAq00h67vP8sWoPMLPPDKC6fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXg80mPOuVxAJSLq5ZLV+yFZk9trSHtv49qD+yP//Y6Gza+AZWzV1UU1RE3IFgOl2
	 gyfgVG6eYX83gGrkwBWEapIyykvWbXcpMMIySjxjrogpcFg08KQklfUHi9W5LoGiT4
	 OHxgI3UwlruHdF7SJpYZ8/3OR21gqG/Inn0hZ3Cigc3Om0Fs17CxIljm+7stmIjh9D
	 4sPlZsb83LHCn6sTaFDAKwtJTBlEtk6lZEOdDkRrXDjMxr939Au6uhilKIbn+7kWFb
	 VDtCR19h1NwPYEp297ruTiA7st9S0YOIhOZTTRCKWWjN0lCwBiizVPCgE5nBcKKviv
	 OB/T+Vkn0Eh8g==
Date: Tue, 23 Sep 2025 10:28:53 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	aleksandr.loktionov@intel.com, kohei.enju@gmail.com
Subject: Re: [PATCH iwl-next v4] ixgbe: preserve RSS indirection table across
 admin down/up
Message-ID: <20250923092853.GG836419@horms.kernel.org>
References: <20250920102546.78338-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920102546.78338-1-enjuk@amazon.com>

On Sat, Sep 20, 2025 at 07:25:45PM +0900, Kohei Enju wrote:
> Currently, the RSS indirection table configured by user via ethtool is
> reinitialized to default values during interface resets (e.g., admin
> down/up, MTU change). As for RSS hash key, commit 3dfbfc7ebb95 ("ixgbe:
> Check for RSS key before setting value") made it persistent across
> interface resets.
> 
> Adopt the same approach used in igc and igb drivers which reinitializes
> the RSS indirection table only when the queue count changes. Since the
> number of RETA entries can also change in ixgbe, let's make user
> configuration persistent as long as both queue count and the number of
> RETA entries remain unchanged.
> 
> Tested on Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network
> Connection.
> 
> Test:
> Set custom indirection table and check the value after interface down/up
> 
>   # ethtool --set-rxfh-indir ens5 equal 2
>   # ethtool --show-rxfh-indir ens5 | head -5
> 
>   RX flow hash indirection table for ens5 with 12 RX ring(s):
>       0:      0     1     0     1     0     1     0     1
>       8:      0     1     0     1     0     1     0     1
>      16:      0     1     0     1     0     1     0     1
>   # ip link set dev ens5 down && ip link set dev ens5 up
> 
> Without patch:
>   # ethtool --show-rxfh-indir ens5 | head -5
> 
>   RX flow hash indirection table for ens5 with 12 RX ring(s):
>       0:      0     1     2     3     4     5     6     7
>       8:      8     9    10    11     0     1     2     3
>      16:      4     5     6     7     8     9    10    11
> 
> With patch:
>   # ethtool --show-rxfh-indir ens5 | head -5
> 
>   RX flow hash indirection table for ens5 with 12 RX ring(s):
>       0:      0     1     0     1     0     1     0     1
>       8:      0     1     0     1     0     1     0     1
>      16:      0     1     0     1     0     1     0     1
> 
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
> Changes:
> v3->v4:
>   - ensure rss_i is non-zero to avoid zero-division

Reviewed-by: Simon Horman <horms@kernel.org>


