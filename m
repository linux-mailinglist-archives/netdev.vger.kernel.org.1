Return-Path: <netdev+bounces-161786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1065A23F7E
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4359E168EF8
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B714B092;
	Fri, 31 Jan 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYPv8BBI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8C20318
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738336527; cv=none; b=bwd12tsoCPxIaRxYmvfWqvr6f7nbuS4RtjrnkV9uLSmcPXHkXXt7sS1/ZCcDKGsbLEkY+pJlUTPQWL4gMrmVZ00tAhipts6FOSu6Q6vqO4ZCclgMFArhjOW2uC/Mow+iI7g5pzM1ody1Y1MT9fZ4gEY45eEf7tE2HfTcAgh2Ut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738336527; c=relaxed/simple;
	bh=3VVkjJDKB0JX6i7wVotCXHhAkh/YA5ViSbV7lBGvic4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnlWTDW+VDBcAIQZJMMVA0ZyEMd0MXckuUiNbdzY2Cpk+pYIckHB61wbKVAeCYGMFiGuno1VFsaqNrT8CPGiAEbaYCO4WfZpNe/WjJJ8ojNJaMCOgYdoPIbMXZaWeC5MXoo3RZRagolzKb4SM5ZE5yQVOj4jfKH0+jQTIENmAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYPv8BBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A954C4CED1;
	Fri, 31 Jan 2025 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738336526;
	bh=3VVkjJDKB0JX6i7wVotCXHhAkh/YA5ViSbV7lBGvic4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jYPv8BBIphfS7XFB5tNzRhc2Hnng2AoZGZVTUnxOkeQEhWguUllW6p0GD7BSgDWm0
	 ytaP3rKiccOnCSMWpsfZCI92o458gnM2CMUxqP7mnkxbvJzMef2mX0QQkxtUc6/G2/
	 6nvPmjD/796KIUkzO93YE8G3INRv4zAGixzfH6F3bYExE3MC0/guLLCRLGrQVMAmxF
	 6CkcU8/RzZITMC7atE5MF8Po4z3DKypWk9TqA9k6FbP7H6fyT744imfHI7gPbzw5fB
	 aUs2RTwzcORaocFMJYGhfnZx5qKXFOZG0AcwsBsYjyGkmGAX2/R7jDEyIkN/JHlslh
	 7jiyVewEmwbnw==
Date: Fri, 31 Jan 2025 15:15:22 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	dan.carpenter@linaro.org, yuehaibing@huawei.com,
	maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next v4] ixgbe: Fix possible skb NULL pointer
 dereference
Message-ID: <20250131151522.GB34138@kernel.org>
References: <20250131121450.11645-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131121450.11645-1-piotr.kwapulinski@intel.com>

On Fri, Jan 31, 2025 at 01:14:50PM +0100, Piotr Kwapulinski wrote:
> The commit c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in
> ixgbe_run_xdp()") stopped utilizing the ERR-like macros for xdp status
> encoding. Propagate this logic to the ixgbe_put_rx_buffer().
> 
> The commit also relaxed the skb NULL pointer check - caught by Smatch.
> Restore this check.
> 
> Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

