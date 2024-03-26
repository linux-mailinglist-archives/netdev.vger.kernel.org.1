Return-Path: <netdev+bounces-81996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D171588C082
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6458D302080
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA356452;
	Tue, 26 Mar 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcJukP7+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604954BEB
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452027; cv=none; b=k+nf0USngr4NtPdRxbBMkee8Flc6C2Lxj4QQPA+c/kI7eKD97zLiz7UKgm60uO5Y+7RLMXohRLhtycn+2ZI97Isqwjp7sigwsg7nSvWCC87RavQ7MYZtcjcVai78TsVHOTKmwSxaGCx3BhfDbxXNlY9KXBkwfE8vxmQJp8OcaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452027; c=relaxed/simple;
	bh=rKe++Rz2WAQ6DvWQZx1Q6tqtL8Tl7Iu18OHMBTq2orQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6pYBXPkbr5GTvCHye37gXHDy8WxmqJWPeaAyvg5NIhlARjBbHlVrHDAzJHqSZTP+WfVBM6Tp3pzWLPTxhLkiekxXzMUTGJpwD38jnfEfu9C95oJ1xRjWthFeYXNxNvqIBBIECTLqxx2J7J1Xgvr5e0D+W89pzb4n1nMOsAcRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcJukP7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB87C433F1;
	Tue, 26 Mar 2024 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452026;
	bh=rKe++Rz2WAQ6DvWQZx1Q6tqtL8Tl7Iu18OHMBTq2orQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcJukP7+lgDuv2FBqGUKVAvYgPp00hcQ/opXeHXH4F1Xi8qMGRIeqqVEPITIa/rWd
	 FGArHLyErjkGHshFFBg35uI2OQtbduTQWtM0j0hN4qoMYR/1CNWHMpkhw3D8U7yXY7
	 5eMGYzUipgQHshq4ubWP9XVmJ0A+J1dy+bR0sXnAPbHknZg9QvbytBSLm5ukJYW4SO
	 azOHB0VtwoDJKxthemP91Esiz7uzUMB797+/5o7pn9sjXlYXiz7hjKiweqJTR06rkQ
	 SXs3HPlzROJZCKKyDCJCTmLUU+LPVQosHnBzNmHkChkJ+DhBDrmg0o35SWhLnrmiRz
	 FCWbR08UXsLtQ==
Date: Tue, 26 Mar 2024 11:20:23 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [iwl-next v1 3/3] ice: hold devlink lock for whole init/cleanup
Message-ID: <20240326112023.GL403975@kernel.org>
References: <20240325213433.829161-1-michal.swiatkowski@linux.intel.com>
 <20240325213433.829161-4-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325213433.829161-4-michal.swiatkowski@linux.intel.com>

On Mon, Mar 25, 2024 at 10:34:33PM +0100, Michal Swiatkowski wrote:
> Simplify devlink lock code in driver by taking it for whole init/cleanup
> path. Instead of calling devlink functions that taking lock call the
> lockless versions.
> 
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


