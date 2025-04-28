Return-Path: <netdev+bounces-186477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E5A9F563
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF1D4619FA
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23D6269CFA;
	Mon, 28 Apr 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W97oK6cg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607418E02A;
	Mon, 28 Apr 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856950; cv=none; b=VlTQPLEm9jf2KOoCdvJqkiMYX5WZwwezQ1OhlXA7mOyyepmEv38wVpjcd6fpuAmPqH3holDpibOBLnGzFm/zcdv3B9pAqBvaUNr0xFj3S3eghjh9e27eLslbY7tQT8WiEWk7PcdJT3PaIPtueDfuse2FrEz3PsEwXwxyGOgsjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856950; c=relaxed/simple;
	bh=iqNP0hU3IjnWmgdEg95YCQHUyyxU09ifoxYOSrBliRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd6/H4dCpNnZU4M9YRnI250s7I1baO3K1jNe1dfF1jDznVkTfDT+PPdrEWTfiBULLg5FbBpvqM8prCUlALkaQUL3nd+DBC22ZJHC8F8wloG+hfshUPK5ZT+QVZd6KQsTRqHN0MaIWMKZpn6tvejJA0oW71PvjOHw3inatat0vVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W97oK6cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80881C4CEE4;
	Mon, 28 Apr 2025 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745856950;
	bh=iqNP0hU3IjnWmgdEg95YCQHUyyxU09ifoxYOSrBliRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W97oK6cgtJNEwz7oFlcr70nFNj4Po9ZAS/hCsNrAudkGxxsu8wN7r5SRbb0MqaZCY
	 k662rjsyf+P9yksDWy1s/nsOrs2LP/rHhxXa8nbjBPvqvYgo8TQELXMQ4arsKiSWpY
	 IbcrSbi0efDBZ9wUiMc/ft/XQxflEkhvv/KB8nP8Ty7qrTJ2LxBT2JEF5HVwNiiG0T
	 2rN7zHKP1GPzgYiqPDtVSYjL+/sEgcB15zMPScEaMtaJA22jVo1YRT5TizQjOILy+l
	 NnQxEBJhNNsMF2EqOXYHgufBJyLyBYxI6c7UYkaciAwQi1NXYOwdslL3nvLkYlqXtd
	 XudoKVyVepEWw==
Date: Mon, 28 Apr 2025 17:15:42 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: Re: [PATCH iwl-next v2 01/14] virtchnl: create 'include/linux/intel'
 and move necessary header files
Message-ID: <20250428161542.GD3339421@horms.kernel.org>
References: <20250424113241.10061-1-larysa.zaremba@intel.com>
 <20250424113241.10061-2-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424113241.10061-2-larysa.zaremba@intel.com>

On Thu, Apr 24, 2025 at 01:32:24PM +0200, Larysa Zaremba wrote:
> From: Victor Raj <victor.raj@intel.com>
> 
> Move intel specific header files into new folder
> include/linux/intel.
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  MAINTAINERS                                                 | 6 +++---
>  drivers/infiniband/hw/irdma/i40iw_if.c                      | 2 +-
>  drivers/infiniband/hw/irdma/main.h                          | 2 +-
>  drivers/infiniband/hw/irdma/osdep.h                         | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e.h                      | 4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_client.c               | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_common.c               | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h            | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c                 | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h          | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf.h                      | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_common.c               | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c                 | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_prototype.h            | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c                 | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_types.h                | 4 +---
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c             | 2 +-
>  drivers/net/ethernet/intel/ice/ice.h                        | 2 +-
>  drivers/net/ethernet/intel/ice/ice_common.h                 | 2 +-
>  drivers/net/ethernet/intel/ice/ice_idc_int.h                | 2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c               | 2 +-
>  drivers/net/ethernet/intel/ice/ice_vf_lib.h                 | 2 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl.h               | 2 +-
>  drivers/net/ethernet/intel/idpf/idpf.h                      | 2 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h                 | 2 +-
>  drivers/net/ethernet/intel/libie/rx.c                       | 2 +-
>  include/linux/{net => }/intel/i40e_client.h                 | 0
>  include/linux/{net => }/intel/iidc.h                        | 0
>  include/linux/{net => }/intel/libie/rx.h                    | 0
>  include/linux/{avf => intel}/virtchnl.h                     | 0
>  .../ethernet/intel/idpf => include/linux/intel}/virtchnl2.h | 0
>  .../intel/idpf => include/linux/intel}/virtchnl2_lan_desc.h | 0
>  32 files changed, 29 insertions(+), 31 deletions(-)
>  rename include/linux/{net => }/intel/i40e_client.h (100%)
>  rename include/linux/{net => }/intel/iidc.h (100%)
>  rename include/linux/{net => }/intel/libie/rx.h (100%)
>  rename include/linux/{avf => intel}/virtchnl.h (100%)
>  rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2.h (100%)
>  rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2_lan_desc.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 657a67f9031e..2e2a57dfea8f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11884,8 +11884,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
>  F:	Documentation/networking/device_drivers/ethernet/intel/
>  F:	drivers/net/ethernet/intel/
>  F:	drivers/net/ethernet/intel/*/
> -F:	include/linux/avf/virtchnl.h
> -F:	include/linux/net/intel/iidc.h
> +F:	include/linux/intel/iidc.h
> +F:	include/linux/intel/virtchnl.h

I'm not sure that I understand the motivation for moving files out of
include/linux/net, but I guess the answer is that my suggestion, which
would be to move files into include/linux/net, is somehow less good.

But if file are moving out of include/linux/net then I think it would
make sense to make a corresponding update to NETWORKING DRIVERS.

Also, include/linux/intel, does feel a bit too general. These files
seem to relate to NICs (of some sort of flavour or another). But Intel
does a lot more than make NICs.

>  
>  INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
>  M:	Mustafa Ismail <mustafa.ismail@intel.com>
> @@ -13534,7 +13534,7 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  T:	git https://github.com/alobakin/linux.git
>  F:	drivers/net/ethernet/intel/libie/
> -F:	include/linux/net/intel/libie/
> +F:	include/linux/intel/libie/
>  K:	libie
>  
>  LIBNVDIMM BTT: BLOCK TRANSLATION TABLE

...

