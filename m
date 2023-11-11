Return-Path: <netdev+bounces-47194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 980587E8C2A
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 19:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28700B20A55
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E718E09;
	Sat, 11 Nov 2023 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX9ST7pm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4803D14F9E
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 18:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3757C433C7;
	Sat, 11 Nov 2023 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699728062;
	bh=RX3cBdIDKqcF57RnJqTIKKb8tzO0jX/53K43wpZkfaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JX9ST7pmqRLghGLS7zyNC/HocKeBpovpuRqw2Jz/p4XuyrOJsalbi4mZAUH6uMJIb
	 PnOlPrZFvJjmwcOB/NioYCw3uHkliZo6fxI07BuFd1hGgL36EsGTrnd0tEzjcU4s/V
	 rqRPeAXjS5dz6OASQzkqo6NeXtvogL7YYeL3TzuR9/UMJx898K+9nKemVYLo2piWAA
	 1pp7Mt46U53NRvaIf9Ixp26m58ew93Tw00a6QorCxFgI+XsAG/W+Yq0l5qVbxzTsAW
	 WRda9xI6nX3+Yk3tzHYCDYeFAfWHPEDa4Qs+qP/njhdzwNIrMqJBCJ0+Y8GNuwi1bC
	 OxqSHSguRaqxQ==
Date: Sat, 11 Nov 2023 18:40:52 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Todd Fujinaka <todd.fujinaka@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net] i40e: Fix unexpected MFS warning message
Message-ID: <20231111184052.GA705326@kernel.org>
References: <20231110081209.189481-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110081209.189481-1-ivecera@redhat.com>

On Fri, Nov 10, 2023 at 09:12:09AM +0100, Ivan Vecera wrote:
> Commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set") added
> a warning message that reports unexpected size of port's MFS (max
> frame size) value. This message use for the port number local
> variable 'i' that is wrong.
> In i40e_probe() this 'i' variable is used only to iterate VSIs
> to find FDIR VSI:
> 
> <code>
> ...
> /* if FDIR VSI was set up, start it now */
>         for (i = 0; i < pf->num_alloc_vsi; i++) {
>                 if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
>                         i40e_vsi_open(pf->vsi[i]);
>                         break;
>                 }
>         }
> ...
> </code>
> 
> So the warning message use for the port number indext of FDIR VSI
> if this exists or pf->num_alloc_vsi if not.
> 
> Fix the message by using 'pf->hw.port' for the port number.
> 
> Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks Ivan,

I agree with your analysis that this change corrects the port number
printed. And that the problem is introduced in the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

