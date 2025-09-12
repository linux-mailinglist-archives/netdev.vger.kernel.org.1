Return-Path: <netdev+bounces-222668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC8DB55545
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D5D3BD26A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B63112CF;
	Fri, 12 Sep 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUO0GWBa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C90258ED9;
	Fri, 12 Sep 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696540; cv=none; b=pF8p00FXVjuVtOPxsYze4iushIuT0Sqsr94oKB2s/l4f97tZ9nJZ5OqCq2bvf8FdGkrowls5NeJdR4aNYysHcQlYk+KjNOrEYYrUDKVe60ZO6btmBtTelA3SQTY48yG3BCj7qLRlEbpiLF3/JF/+5UkMhXqi9RpivICTYTWU6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696540; c=relaxed/simple;
	bh=LC9SJihUmHBE79M9xIfX+ZUt3bLMom1pdv5elzrej94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+LLQsR6SbOSb93qZbRoF9RXxAlYX3Vab+Dd7ZwspJp8BZho/uKlVDYS86WVmEeuvZaaKTI30TFGgKixPcas9JDuVjaY7d9wbtIqaZ2cTDgU+o18O1pfxv/j3rsTqMjEglPp2/g618dFWEGsJ7JgFqlaFXsmxC1Hs4XtmxMAJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUO0GWBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21182C4CEF1;
	Fri, 12 Sep 2025 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757696539;
	bh=LC9SJihUmHBE79M9xIfX+ZUt3bLMom1pdv5elzrej94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUO0GWBa1K96/YnjR37d6ojAMwMr98haM5Z7UA8R404k1XiIEuHBjYOQdGZ/sqvqD
	 v91ko0UcscyTPJiTLHcEt8sAf4ATo9sBBHyynYLWr3G5K1ybALRWv9UmjBUekw8hW3
	 T0Sgki1ExTjoTwtDZ2Mwy/ysnvLYzWvgNZbBbU2WKzTuCD6zT5PMMT6zoZoIv0MZD8
	 WQJzOpMZnjBWW+2fibgLZDldxTw8Aqk8+gc19gH/edIEREQSvVrIxJpioxVUg4S4wD
	 a2JDN73Y/fPg+wvPRg4ePNge1ZgMidAXUbVc3hiHiGTsFl1d9uimVSqcNDxNdYT6Cr
	 3z0iTALB6+Hsw==
Date: Fri, 12 Sep 2025 18:02:14 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, hgani@marvell.com,
	andrew@lunn.ch, srasheed@marvell.com
Subject: Re: [net PATCH] octeon_ep:fix VF MAC address lifecycle handling
Message-ID: <20250912170214.GB224143@horms.kernel.org>
References: <20250911144933.6703-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911144933.6703-1-sedara@marvell.com>

On Thu, Sep 11, 2025 at 07:49:33AM -0700, Sathesh B Edara wrote:
> Currently, VF MAC address info is not updated when the MAC address is
> configured from VF, and it is not cleared when the VF is removed. This
> leads to stale or missing MAC information in the PF, which may cause
> incorrect state tracking or inconsistencies when VFs are hot-plugged
> or reassigned.
> 
> Fix this by:
>  - storing the VF MAC address in the PF when it is set from VF
>  - clearing the stored VF MAC address when the VF is removed
> 
> This ensures that the PF always has correct VF MAC state.
> 
> Fixes: cde29af9e68e ("octeon_ep: add PF-VF mailbox communication")
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> index ebecdd29f3bd..0867fab61b19 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> @@ -196,6 +196,7 @@ static void octep_pfvf_get_mac_addr(struct octep_device *oct,  u32 vf_id,
>  			vf_id);
>  		return;
>  	}
> +	ether_addr_copy(oct->vf_info[vf_id].mac_addr, rsp->s_set_mac.mac_addr);
>  	rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
>  }
>  
> @@ -205,6 +206,8 @@ static void octep_pfvf_dev_remove(struct octep_device *oct,  u32 vf_id,
>  {
>  	int err;
>  
> +	/* Reset VF-specific information maintained by the PF */
> +	memset(&oct->vf_info[vf_id], 0, sizeof(struct octep_pfvf_info));

Hi Sathesh,

Can the following be used here?
(completely untested)

	eth_zero_addr(oct->vf_info[vf_id].mac_addr);

Or does more of oct->vf_info[vf_id] need to be reset?

>  	err = octep_ctrl_net_dev_remove(oct, vf_id);
>  	if (err) {
>  		rsp->s.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> -- 
> 2.36.0
> 
> 

