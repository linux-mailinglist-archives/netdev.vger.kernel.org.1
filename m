Return-Path: <netdev+bounces-99810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D348D68F4
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE6F1F244B6
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FC17D352;
	Fri, 31 May 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh3Ckn1a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEBC17D343
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179953; cv=none; b=RQxwYc9e6JrP0UqijWVK3Vc7C2PqzfnAIspELrOB7u5bBbOtiXyoZi3/SJlXg0ofUnb3bKPfcBke6v/Z3Unqp0mzhjZk5TRZBZTkPUopwD6BXtLBfM1tM9gp9OzUz6pDFRplKKdFGhpGsYw92Hc51YbMQ4N7yBdcsb1Cjt5oB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179953; c=relaxed/simple;
	bh=gw2JcXterCcKSVJS6tZdEZSTY3FbDxSWvpTUL/n5XmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pILfP8yY6KfldDMJGR4x5hkx+WLz1vbU0hMYBgmFuE8WGLODByD7RowsbBX8JBTfG5+SnWOXtEIryw73JLTLtJMClEx0uxhiOwv86aJBqPZciwleJK6bmg8CzuCYmzptZMDSi1JahhQQM3pYcMK0T2mHpVqeobghh6BGUyOKjU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh3Ckn1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93422C116B1;
	Fri, 31 May 2024 18:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179952;
	bh=gw2JcXterCcKSVJS6tZdEZSTY3FbDxSWvpTUL/n5XmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kh3Ckn1aB1aX9w7X2x4+IFjKMsWvVkJIjAOPwPvQLsrAINfNJ2RDiiZOQa2GVPBa+
	 atwIJlJKziUalAvb9X/q6yjwxcbqr1pPuhczZzo2SeFpuNoxgIjxIMQqxssTX7ssce
	 3kp+c3OsM7EybjQ1dJb4W7N3h5IexVxJnKkxeuvPGIli82XZaEEsx5Na74KSHc/Jcc
	 kRxvn5UUFYnr1egRwaPMdQ7I8+SuinQcPJtEKGYGfwmVnC5WNRVsrL4i1XS1fhS8TJ
	 qivt5hlQj+n66U/OSS5vGgxp8BKQndbB127ngchWi55UMywBWvKHstEddx7HPOIaoM
	 9eLVUUSyuyA2w==
Date: Fri, 31 May 2024 19:25:49 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-net] i40e: Fix XDP program unloading while removing
 the driver
Message-ID: <20240531182549.GR491852@kernel.org>
References: <20240516164108.1482192-1-michal.kubiak@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516164108.1482192-1-michal.kubiak@intel.com>

On Thu, May 16, 2024 at 06:41:08PM +0200, Michal Kubiak wrote:
> The commit 6533e558c650 ("i40e: Fix reset path while removing
> the driver") introduced a new PF state "__I40E_IN_REMOVE" to block
> modifying the XDP program while the driver is being removed.
> Unfortunately, such a change is useful only if the ".ndo_bpf()"
> callback was called out of the rmmod context because unloading the
> existing XDP program is also a part of driver removing procedure.
> In other words, from the rmmod context the driver is expected to
> unload the XDP program without reporting any errors. Otherwise,
> the kernel warning with callstack is printed out to dmesg.
> 
> Example failing scenario:
>  1. Load the i40e driver.
>  2. Load the XDP program.
>  3. Unload the i40e driver (using "rmmod" command).
> 
> Fix this by improving checks in ".ndo_bpf()" to determine if that
> callback was called from the removing context and if the kernel
> wants to unload the XDP program. Allow for unloading the XDP program
> in such a case.
> 
> Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


