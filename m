Return-Path: <netdev+bounces-84882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE682898855
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9799B28BA89
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA084D29;
	Thu,  4 Apr 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUDEOBsp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418A839F8
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235330; cv=none; b=Y5FtKhVdHq67oqrQEZy5PJbVGS+VceoNtOBSEvQPC2jxLlkv+aOTsUpx8x1dMZTLChjyqSwP2RZJUbyp+qDTx8U7qPkNNm6C7WYFxkm4WEmvq5Re/7n1bBG1evP7yKKUsQtp7pKGx5nSMxqKpoRuid86Jc8E5Y/liTWqEgJaI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235330; c=relaxed/simple;
	bh=piYo9QgAQMJLzSMJ3LRhK+TE3bBd7tdG5/UH/HfIJc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmXie+zFeS2WYoh2eKXUYsQJQ+A/x1sZ9zorIsC8eUBbQWoKeN5aQ1eA3oym4dqVKv5BFAlesE9a/x0SK5N2OLeR2ZfOXvRxEuyR/cYgoQDcdL1oeEPM51ZjN4AP4ZH/AJIRVhZx3QySQO7JllAbyOWjhyGrCsW1rA5bZ9oo3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUDEOBsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81528C433F1;
	Thu,  4 Apr 2024 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712235329;
	bh=piYo9QgAQMJLzSMJ3LRhK+TE3bBd7tdG5/UH/HfIJc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUDEOBspoRxl/DL7MB77NtCe+CapCd0Y8/dwk83ZnBkwXRHtpBTFfC/92Un7GZPEY
	 ekVMARg5hIsRmYeHMeVdJTmOBRPxFFdlqlQhucDAMGC3PeOzPg+xa/Nj/essVyvZii
	 UerZRHaEBQ0CiToYRVBb5pKM1VTBE8Q8iR1SC55GpAPxRkwuwZjkm508K0L58H6r0l
	 e3el3gIXOrs8tPyF+mjsiKFlExp83Lan56AB4FPDWFjhV99SGayMjMdZSF1MB8Ch5s
	 s3oo+tgel35LpVM2MrkAZ6ks6Z+XqEvpWQdYYQ7FMahk1XevXE0vgfvDCvWe+f3g2F
	 1/KROFhLVjJmg==
Date: Thu, 4 Apr 2024 13:55:25 +0100
From: Simon Horman <horms@kernel.org>
To: Lukasz Plachno <lukasz.plachno@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	brett.creeley@amd.com, pmenzel@molgen.mpg.de,
	aleksander.lobakin@intel.com,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next v8 2/2] ice: Implement 'flow-type ether' rules
Message-ID: <20240404125525.GQ26556@kernel.org>
References: <20240403102402.20144-1-lukasz.plachno@intel.com>
 <20240403102402.20144-3-lukasz.plachno@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403102402.20144-3-lukasz.plachno@intel.com>

On Wed, Apr 03, 2024 at 12:24:02PM +0200, Lukasz Plachno wrote:
> From: Jakub Buchocki <jakubx.buchocki@intel.com>
> 
> Add support for 'flow-type ether' Flow Director rules via ethtool.
> 
> Create packet segment info for filter configuration based on ethtool
> command parameters. Reuse infrastructure already created for
> ipv4 and ipv6 flows to convert packet segment into
> extraction sequence, which is later used to program the filter
> inside Flow Director block of the Rx pipeline.
> 
> Rules not containing masks are processed by the Flow Director,
> and support the following set of input parameters in all combinations:
> src, dst, proto, vlan-etype, vlan, action.
> 
> It is possible to specify address mask in ethtool parameters but only
> 00:00:00:00:00 and FF:FF:FF:FF:FF are valid.
> The same applies to proto, vlan-etype and vlan masks:
> only 0x0000 and 0xffff masks are valid.
> 
> Testing:
>   (DUT) iperf3 -s
>   (DUT) ethtool -U ens785f0np0 flow-type ether dst <ens785f0np0 mac> \
>         action 10
>   (DUT) watch 'ethtool -S ens785f0np0 | grep rx_queue'
>   (LP)  iperf3 -c ${DUT_IP}
> 
>   Counters increase only for:
>     'rx_queue_10_packets'
>     'rx_queue_10_bytes'
> 
> Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
> Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


