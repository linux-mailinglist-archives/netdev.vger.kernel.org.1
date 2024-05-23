Return-Path: <netdev+bounces-97892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BA8CDB12
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 21:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412E0B22DD7
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0031E84A3F;
	Thu, 23 May 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3ZdVm4J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7684A36
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493611; cv=none; b=iiaCbHq/izKCIO7PVtTlqT6FXKJOFQMe5jYFzb6tlzTGlRw+40UpyKKn9zBd/qzjqeBqZMkFmXD1xbGwDjBlf/Cl4x+ymckb7qq9N0yOwCxnAxhFr3dZn9HIpgCtoXThtVopgGtT5Vyu+wMP1V0k0dzRnN7GfdJvOvQy6O2dNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493611; c=relaxed/simple;
	bh=LTFuzqo/cdgV6wXIved8UzB8UVSoC25saxxFqeXXg+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcfLy7JYF8NtglW3Oa6MZvqZXrZFezF696nHL7dkM67huYKtZOOKjdfjNLsd0LQRGDLW9a8Jr681zAM/ENDS0X74coNK21dNmud0xk6Cd8lTryj8XXhfPcJV9uorDfEvGuv2+Rpw0Za5Y4gWFxqJxyy0FBOoi1pAgFA87EMmxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3ZdVm4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364D2C2BD10;
	Thu, 23 May 2024 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716493611;
	bh=LTFuzqo/cdgV6wXIved8UzB8UVSoC25saxxFqeXXg+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3ZdVm4JyE4tnKat0sRRJSV4yzgANMr8bQLDZxzQ3LDxJh9eJYIL/lO2apaLKv7rM
	 3MjuO/kWFEO81/E6W1xX/FsFyb1ZIwmppzvD9bbGVAtmFmQ31DNgpJtyhICnQ7k38z
	 TFi14jXYfofJrPs2tkpqDJ3yZVp8wiiX7/1PP1l9scnf99jzlcLLBbtg3i36o8eQtY
	 lMIx2x/k/HZ6lYYXgG4yoqOj/aBv7OipxXSFvJ183SKAsiVwzwmadHzCEh5PsAb38T
	 lL5p+ct2GNvdqlfEts7lNd/OsxY7qopggZ29QIMfKbu+EgT2M/5XvjlTQSvcazKILn
	 +sTvqBPPpsUNQ==
Date: Thu, 23 May 2024 20:46:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net 2/2] ice: fix accounting if a VLAN already exists
Message-ID: <20240523194646.GQ883722@kernel.org>
References: <20240523-net-2024-05-23-intel-net-fixes-v1-0-17a923e0bb5f@intel.com>
 <20240523-net-2024-05-23-intel-net-fixes-v1-2-17a923e0bb5f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523-net-2024-05-23-intel-net-fixes-v1-2-17a923e0bb5f@intel.com>

On Thu, May 23, 2024 at 10:45:30AM -0700, Jacob Keller wrote:
> The ice_vsi_add_vlan() function is used to add a VLAN filter for the target
> VSI. This function prepares a filter in the switch table for the given VSI.
> If it succeeds, the vsi->num_vlan counter is incremented.
> 
> It is not considered an error to add a VLAN which already exists in the
> switch table, so the function explicitly checks and ignores -EEXIST. The
> vsi->num_vlan counter is still incremented.
> 
> This seems incorrect, as it means we can double-count in the case where the
> same VLAN is added twice by the caller. The actual table will have one less
> filter than the count.
> 
> The ice_vsi_del_vlan() function similarly checks and handles the -ENOENT
> condition for when deleting a filter that doesn't exist. This flow only
> decrements the vsi->num_vlan if it actually deleted a filter.
> 
> The vsi->num_vlan counter is used only in a few places, primarily related
> to tracking the number of non-zero VLANs. If the vsi->num_vlans gets out of
> sync, then ice_vsi_num_non_zero_vlans() will incorrectly report more VLANs
> than are present, and ice_vsi_has_non_zero_vlans() could return true
> potentially in cases where there are only VLAN 0 filters left.
> 
> Fix this by only incrementing the vsi->num_vlan in the case where we
> actually added an entry, and not in the case where the entry already
> existed.
> 
> Fixes: a1ffafb0b4a4 ("ice: Support configuring the device to Double VLAN Mode")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


