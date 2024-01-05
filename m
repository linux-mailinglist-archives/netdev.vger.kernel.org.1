Return-Path: <netdev+bounces-62110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9837825C0A
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 22:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A647D1C23370
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 21:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3DA219E1;
	Fri,  5 Jan 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvPNzW6T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DC35EF7
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 21:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB625C433C7;
	Fri,  5 Jan 2024 21:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704489219;
	bh=l5Ymg66TVOpAN1XPpEJlRktNwCvTjgI4pO0t7LY8zZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WvPNzW6Txqyb5nciGlGjQreOLOKXUW78CXZ4hFfh1ZLLkyM+2YTj/c7Wym/Nqu+PU
	 fKToOBz8kestyJs0d54HjxuOUijefLQWKoHVMBYqlIt5xwJyPChYDSyQBMF4loSIja
	 0/hCR9PxpEM7M+/oO+iwQdyIqFiteM1ag6xH9tSc8QhfeWijC/QPuqletrdJKPRD5Z
	 eKezNlTCHWmVnIu5RBScAKWjcaZYxV03KtxxBsF5/1jTrSelTq3GN5Cac/gUgaZLA/
	 RPMVFGEQcRvNjpwjFO7UvVn+cQWFFEjKBQnp9NbjsHkRD1ONnq4FG6yuyByIosFHyv
	 8s8CLBkMko0Tg==
Date: Fri, 5 Jan 2024 21:13:34 +0000
From: Simon Horman <horms@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, pmenzel@molgen.mpg.de,
	emil.s.tantilov@intel.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH iwl-net v2] idpf: avoid compiler padding in
 virtchnl2_ptype struct
Message-ID: <20240105211334.GA114301@kernel.org>
References: <20240105013232.44996-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105013232.44996-1-pavan.kumar.linga@intel.com>

On Thu, Jan 04, 2024 at 05:32:32PM -0800, Pavan Kumar Linga wrote:
> In the arm random config file, kconfig option 'CONFIG_AEABI' is
> disabled which results in adding the compiler flag '-mabi=apcs-gnu'.
> This causes the compiler to add padding in virtchnl2_ptype
> structure to align it to 8 bytes, resulting in the following
> size check failure:
> 
> include/linux/build_bug.h:78:41: error: static assertion failed: "(6) == sizeof(struct virtchnl2_ptype)"
>       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>          |                                         ^~~~~~~~~~~~~~
> include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>       77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>          |                                  ^~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/idpf/virtchnl2.h:26:9: note: in expansion of macro 'static_assert'
>       26 |         static_assert((n) == sizeof(struct X))
>          |         ^~~~~~~~~~~~~
> drivers/net/ethernet/intel/idpf/virtchnl2.h:982:1: note: in expansion of macro 'VIRTCHNL2_CHECK_STRUCT_LEN'
>      982 | VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Avoid the compiler padding by using "__packed" structure
> attribute for the virtchnl2_ptype struct.
> 
> Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312220250.ufEm8doQ-lkp@intel.com
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


