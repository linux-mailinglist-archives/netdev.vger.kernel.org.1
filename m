Return-Path: <netdev+bounces-32396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4116D7973D3
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D16281729
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FF212B61;
	Thu,  7 Sep 2023 15:32:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAD29B4
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26EFC433C9;
	Thu,  7 Sep 2023 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694100728;
	bh=4/JKnKNExLGNGv2sCb9eyK1f+7iv+45LcWMfCPifJOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzYu7q8H4km5gUF2N5v5Qpvt7O6xn42LrO9Ej8XfTRaq8JkQJKQ75LZkXZVh58LG7
	 RzIz3zz3ZbNBhqr9HTBXuW9FbN5XmRSl8hVVbNuCf+f8mJQEXPU0eFp4iMl4ew3uhU
	 9yeUW3oXtWsHEbt296hRUkZz6LRPPqfKoH0qzUXuq9eLbWsgFop44ZtBtTRNaCfKdy
	 eQbqd3AOP+9s4tvT/w9Thd1wg8lg6mieUoeBh837n2k8GPM3efEr4tcHd90JL6nD5a
	 M1HmY+xEUMOPRBVkJ9dG5/DbzQugBVdocLuA58kTpUOab7JR7G2NclEhm0hB+xbEXG
	 rOR99XJ7ZB1vg==
Date: Thu, 7 Sep 2023 17:31:56 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	mschmidt@redhat.com, ivecera@redhat.com, ahmed.zaki@intel.com
Subject: Re: [PATCH net v2 2/2] iavf: schedule a request immediately after
 add/delete vlan
Message-ID: <20230907153156.GJ434333@kernel.org>
References: <20230907150251.224931-1-poros@redhat.com>
 <20230907150251.224931-2-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907150251.224931-2-poros@redhat.com>

On Thu, Sep 07, 2023 at 05:02:51PM +0200, Petr Oros wrote:
> When the iavf driver wants to reconfigure the VLAN filters
> (iavf_add_vlan, iavf_del_vlan), it sets a flag in
> aq_required:
>   adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
> or:
>   adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
> 
> This is later processed by the watchdog_task, but it runs periodically
> every 2 seconds, so it can be a long time before it processes the request.
> 
> In the worst case, the interface is unable to receive traffic for more
> than 2 seconds for no objective reason.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


