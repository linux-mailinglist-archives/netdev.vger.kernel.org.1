Return-Path: <netdev+bounces-37700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3ED7B6AD7
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B041A28163A
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA60029423;
	Tue,  3 Oct 2023 13:47:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A842770F
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A980DC433C7;
	Tue,  3 Oct 2023 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696340827;
	bh=/PqT9j9WUjZ4jMGoDwz8ZdnLpQ5yWa37gzGGi155Hr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0omkTjgj358YbIGBAeaANArP0enwO0cPAm7Qh5j79aiYhwZUUanxoTtE//QafR3C
	 UzALxk1kFtKe5kI1d+WCjNM0Rwimbgvso9Amc9lcEcUrFaVy08Js2UDR9WNJQSuTNt
	 KgJ8ydVwa8JwVq3HNoKWgX+N31D2hVRdyQM0I1pcEQPR25h0qv4/F9ehzSxLoIQJXY
	 mxpvJ1gitJ8mHfbHxed+vT6mM3C+qhk3CnxrEzDM8R/Kq7OnmQDfhmrV2AxMeJNG/L
	 70NMlg/XgMGRxcx/ZFdNGkwo5bbWhsMiBUmWtSgJismy6XbJtG4YPFo3szhNR4FsRh
	 voH5LF/aC9YiQ==
Date: Tue, 3 Oct 2023 15:47:02 +0200
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	arkadiusz.kubalewski@intel.com, michal.michalik@intel.com,
	richardcochran@gmail.com, vadim.fedorenko@linux.dev,
	jiri@resnulli.us, kernel test robot <lkp@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next] ice: fix linking when CONFIG_PTP_1588_CLOCK=n
Message-ID: <ZRwbVoUgcXBhuRqW@kernel.org>
References: <20231002185132.1575271-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002185132.1575271-1-anthony.l.nguyen@intel.com>

On Mon, Oct 02, 2023 at 11:51:32AM -0700, Tony Nguyen wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The recent support for DPLL introduced by commit 8a3a565ff210 ("ice: add
> admin commands to access cgu configuration") and commit d7999f5ea64b ("ice:
> implement dpll interface to control cgu") broke linking the ice driver if
> CONFIG_PTP_1588_CLOCK=n:
> 
> ld: vmlinux.o: in function `ice_init_feature_support':
> (.text+0x8702b8): undefined reference to `ice_is_phy_rclk_present'
> ld: (.text+0x8702cd): undefined reference to `ice_is_cgu_present'
> ld: (.text+0x8702d9): undefined reference to `ice_is_clock_mux_present_e810t'
> ld: vmlinux.o: in function `ice_dpll_init_info_direct_pins':
> ice_dpll.c:(.text+0x894167): undefined reference to `ice_cgu_get_pin_freq_supp'
> ld: ice_dpll.c:(.text+0x894197): undefined reference to `ice_cgu_get_pin_name'
> ld: ice_dpll.c:(.text+0x8941a8): undefined reference to `ice_cgu_get_pin_type'
> ld: vmlinux.o: in function `ice_dpll_update_state':
> ice_dpll.c:(.text+0x894494): undefined reference to `ice_get_cgu_state'
> ld: vmlinux.o: in function `ice_dpll_init':
> (.text+0x8953d5): undefined reference to `ice_get_cgu_rclk_pin_info'
> 
> The first commit broke things by calling functions in
> ice_init_feature_support that are compiled as part of ice_ptp_hw.o,
> including:
> 
> * ice_is_phy_rclk_present
> * ice_is_clock_mux_present_e810t
> * ice_is_cgU_present
> 
> The second commit continued the break by calling several CGU functions
> defined in ice_ptp_hw.c in the DPLL code.
> Because the ice_dpll.c file is compiled unconditionally, it will not
> link when CONFIG_PTP_1588_CLOCK=n.
> 
> It might be possible to break this dependency and expose those functions
> without CONFIG_PTP_1588_CLOCK, but that is not clear to me.
> 
> For the DPLL case, simply compile ice_dpll.o only when we have
> CONFIG_PTP_1588_CLOCK. Add stub no-op implementation of ice_dpll_init() and
> ice_dpll_uninit() when CONFIG_PTP_1588_CLOCK=n into ice_dpll.h
> 
> The other functions are part of checking the netlist to see if hardware
> features are enabled. These checks don't really belong in ice_ptp_hw.c, and
> make more sense as part of the ice_common.c file. We already have
> ice_is_gps_in_netlist() in ice_common.c which is doing a similar check.
> 
> Move the functions into ice_common.c and rename them to have the similar
> postfix of "in_netlist()" to be more expressive of what they are actually
> checking.
> 
> This also makes the ice_find_netlist_node only called from within
> ice_common.c, so its safe to mark it static and stop declaring it in the
> ice_common.h header as well.
> 
> Fixes: 8a3a565ff210 ("ice: add admin commands to access cgu configuration")
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309191214.TaYEct4H-lkp@intel.com
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested


