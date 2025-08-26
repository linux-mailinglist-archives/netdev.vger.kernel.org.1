Return-Path: <netdev+bounces-217006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D4AB37071
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE3F7AEC10
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618A3352060;
	Tue, 26 Aug 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLtREdGX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7792D2390
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226001; cv=none; b=gSwR4Q4FNLumyF9+tltfSRoYW2g7uMjZD5PsRh3h8JFPWbMiBVoZReYGiahHyXB6HkXbG1KOgonsB3XiCLZ7WMKv8bw2z9ou0WuJaRRPbO/C5HKm8w7GRtkOn24DKMsnD91sJkIjiNJ1RHLxY5p49OaA3FrHvNLGvPI8/U74lrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226001; c=relaxed/simple;
	bh=dCH9BJfNTHmofJpgfaBZCatTRuktCGZASw5OEhzVx0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFwkzU251zVrglUcyGJwvW8mFC+38pluNvq+fkgC/mX9bAfJ01dS4IRobGNXKOuqkCYdQ9jGtp0gLoqXYCpqvA/ikwg7r9OVAGvtfvZ4QNKwj5q+ZcshD/WrHjr5GedNmX98cFm5EgN+FB+HBNWjQDkAs82DbWCyaz4ZpRfgxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLtREdGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6A0C4CEF1;
	Tue, 26 Aug 2025 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756226000;
	bh=dCH9BJfNTHmofJpgfaBZCatTRuktCGZASw5OEhzVx0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLtREdGXKfQyf5MLxXbhJ8ZTQVzhZyRcM1k+iO/2FfIqX+yIzdZdO1789kRrvmZmx
	 LKt7Fn2EiHAZaHqyc+v9Iw09dzUbuZXKCHVhGon0RSWWdcvTulNxK+oUjeGZlr3QnG
	 ixuh8AVZTIOVdaTJquEMpxPYzvy3ZZgCxu0P1wJBPq3aGVilD0MnouFOhMI9Gi6rEg
	 8gnKUeiJkm0v0YHxQ1dHjiOJV31JEn6qK+HswducYkhK1nza8fwq4ywt9NZqrhvpPE
	 WGmWNKFMbQc/+HyIzzxTYKUFIJBeXl6syZN8zxiXIiWyowR6UkJ5LeehvWZqCcjzIC
	 ixPr3bajF2ysQ==
Date: Tue, 26 Aug 2025 17:33:16 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>, jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net 5/8] i40e: fix validation of VF state in get
 resources
Message-ID: <20250826163316.GD5892@horms.kernel.org>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-6-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104552.61027-6-przemyslaw.kitszel@intel.com>

On Wed, Aug 13, 2025 at 12:45:15PM +0200, Przemek Kitszel wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> VF state I40E_VF_STATE_ACTIVE is not the only state in which
> VF is actually active so it should not be used to determine
> if a VF is allowed to obtain resources.
> 
> Use I40E_VF_STATE_RESOURCES_LOADED that is set only in
> i40e_vc_get_vf_resources_msg() and cleared during reset.
> 
> Fixes: 61125b8be85d ("i40e: Fix failed opcode appearing if handling messages from VF")

I suspect this could be

Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")

But I guess that either way is fine.

> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


