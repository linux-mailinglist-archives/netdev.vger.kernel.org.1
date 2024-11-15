Return-Path: <netdev+bounces-145298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2AE9CEFE2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9460AB2650F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E451CEEAA;
	Fri, 15 Nov 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogdhdrq4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217E1CEACD
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682631; cv=none; b=sQ02Yzb2iCa78n7wVU1tjb6kPdAnC6OA7BLeXsKGt8T1x48X4LaCIZaHtiCWXKU3Hs01dL1jN+/a5k3BfYUhxpQEBYRcfcknU8NB9+HHtOXoDJ2zThtCB9OZKHWEUBn0TXmAAE80zfguD9VE3nFsLXL4v2O5UvDUrxPrHq54/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682631; c=relaxed/simple;
	bh=tEJGs8fq681vGN+O2Sk9cL1PzpKgb6ms4buFCWo5l54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDKfy3AJpV1d7gO6vzBo6x0fuq1wZ09wwgri2khWwpPzftIhqLQLE5pBXJd0ioU4tchAtuLByiOsPaD9E+u7Q/7STO8IzVU8LmR08PwaofkHpAalkeX3BPqtu/CrhqXcfz7lPV68iM9RJAh7xjJGO86421+NHlDoUQFyRASR4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogdhdrq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C096C4CECF;
	Fri, 15 Nov 2024 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731682631;
	bh=tEJGs8fq681vGN+O2Sk9cL1PzpKgb6ms4buFCWo5l54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ogdhdrq4eeE0rwptSZMR2nc4z2zzR2rxtSprTjqQzfXkkcBiy2yYb+hyHB0DicjuF
	 goPnHXSUS7hKeoEhWN76S+FDDEA3BstKVmKVIuPb38EbuedLAwRxfLajXOGRHMWSGF
	 qt9X7khCsA0PS9l6ERMxdaxPGjlMG9NR2FxgaEoswlbkhJKPXo8fm4nEY9DVQI/jjG
	 FleHJxOR9V0Kd4odYaX5ok1qEaviV4N9EF/UwlZUbnPRyM1PdAC8Qkbc3AB3kgVGAJ
	 T+kANcCPG7W7v69AFhTvpFCxz8DPt1bgqIdf/yDFrtuXfzz6s1xt7+KnyN4/QdKylx
	 PRWOuNaxGvnAg==
Date: Fri, 15 Nov 2024 14:57:07 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com, kernel-team@meta.com
Subject: Re: [PATCH net] eth: fbnic: don't disable the PCI device twice
Message-ID: <20241115145707.GU1062410@kernel.org>
References: <20241115014809.754860-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115014809.754860-1-kuba@kernel.org>

On Thu, Nov 14, 2024 at 05:48:09PM -0800, Jakub Kicinski wrote:
> We use pcim_enable_device(), there is no need to call pci_disable_device().
> 
> Fixes: 546dd90be979 ("eth: fbnic: Add scaffolding for Meta's NIC driver")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


