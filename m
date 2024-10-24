Return-Path: <netdev+bounces-138632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CAE9AE690
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8F9B28A28
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E13E1E105A;
	Thu, 24 Oct 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUE7L+mp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7B1DD0CA
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776483; cv=none; b=L2qdsf8skXcuodxtZSvOlLSrvN2SMuhPmX0khL15pQ8ualkFTIqJ1n0FtquSPQpIqvT1ldMO3/5aWaN78PdKg9i4NR4gk9WiBAXQ/C6cgbTTN5C3/1puHTYkvaf5yfT6nQnqNduKes2v6C4ckajldF1bopebgcfHSX7GEwmi/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776483; c=relaxed/simple;
	bh=Pkfsb6G7XD6+q2is2hMkiN3zTsZuYb2EXhEZcy3Igz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvLHFQhv4jrEOCGfWnmbBB34Ss9H+cChnf7rjZGGTBzmTWd3wDblxMf+E5+DfasTAQBGr1lLd7VV8C5ZEyzXgBCneEkIQGTEgfN51OY6RJpNf5CtKNHQTjDzO6Y6MXQwwmmPLaG1PRt3Nz5OqfCl6IkDXbIWccFbtnLIZ+uNqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUE7L+mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B168C4CEE3;
	Thu, 24 Oct 2024 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729776482;
	bh=Pkfsb6G7XD6+q2is2hMkiN3zTsZuYb2EXhEZcy3Igz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUE7L+mprYIJqY/XTekJVuIwBR++r0sSuFIvUtO4tdXKaxeNCx4Dbr4v/Y6XgHEha
	 Swk1ghFJBZfy1wmUk2WzAessXAykVNjuoqaEN/+QH1gbUotMHX/h3wBXij0OziteVo
	 lZhRfc26N9a9Yu6M3tY+6mvL1T7g0KKlIlnRnkq50l2oZXkMHkPA50N2Rjo9Z6VxRC
	 gY8hEHBDt+eF5pqXsDpDX4mDR/IdGokFD929hTjoNi1eR3vmvg+U1dJIAYUxsOLvFL
	 6ondEW8ZZy1RlNxUC/HNIf8vC8qtHlg+f9ze0Y449ilSOIj1ZNoEMzzr/IHLMnyXCL
	 YXXrMmkOcftNA==
Date: Thu, 24 Oct 2024 14:27:58 +0100
From: Simon Horman <horms@kernel.org>
To: Yuan Can <yuancan@huawei.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, alexander.h.duyck@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] igb: Fix potential invalid memory access in
 igb_init_module()
Message-ID: <20241024132758.GN1202098@kernel.org>
References: <20241023121048.26905-1-yuancan@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023121048.26905-1-yuancan@huawei.com>

On Wed, Oct 23, 2024 at 08:10:48PM +0800, Yuan Can wrote:
> The pci_register_driver() can fail and when this happened, the dca_notifier
> needs to be unregistered, otherwise the dca_notifier can be called when
> igb fails to install, resulting to invalid memory access.
> 
> Fixes: bbd98fe48a43 ("igb: Fix DCA errors and do not use context index for 82576")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
> Changes since v1:
> - Change fix tag to bbd98fe48a43.
> - Change target branch to net.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


