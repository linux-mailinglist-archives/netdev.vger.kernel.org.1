Return-Path: <netdev+bounces-208198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB93B0A8EC
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7453B31FB
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED992E611F;
	Fri, 18 Jul 2025 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLiKUJRh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD22DEA8D
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857461; cv=none; b=Y/be4UnsdBAC83/B6zr2CXlj9rQPrZ6hVlBEgs21+MPRP6ELazW6HLFVEArENvHvIm1HgrzX2mjubnGtIYwirRNdZSXkloNw3kVLhMcQWHIi6enBc4QUO5YnwHjdb/BNDHync6MPYNamaSgLzhVOr8lowQU3koCsKwgjulN3SnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857461; c=relaxed/simple;
	bh=Xi0Bb00GS9+L00PpJZElzWqMdLzlC3U0U2Ju6UqTZWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXvamaQAriLiFcSucOdfLgUhoQDwzQIU3R1jK0SHBSi9+YvF/G7tFg9TOaSnKNzOI8vZUTKzMJR9naTXvwA1ENdHiVw3hdfM0RcXBKr43xL2WPLHKZNy/iW0xjBm1LBSp2ZoSE73NdY1ecopDJiM1lJNLyfyziHo/etrz9SPPIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLiKUJRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B37C4CEEB;
	Fri, 18 Jul 2025 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752857460;
	bh=Xi0Bb00GS9+L00PpJZElzWqMdLzlC3U0U2Ju6UqTZWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLiKUJRh1lFYlPyzgItFA3LdHqHirDH54tlwToLNDDpaUa7tu8UoBBKqgMI7LgwdF
	 8QYCfKFIPqeus2RvoMsLMa5cswGRFuu+YXpqdqBcmpweRzjBUAA0MIZrFLhXVXQP82
	 u6HO7QcE1LtNuvS7LgY0JyiR0ivKiWY4L7b+RNU9+3EtfyVEE42QLjTplniQ9zwyqr
	 PoexVNIurc7Jns4Xu6TlW+GhnQSj7KorVZzZ2F9aidhBoi0RWzMIwx3SVs2O4AuwBb
	 sxdQaBPiG6U6ZGYudmJQjg/TfEmZliG75VML5HsrWc1sBzchoiAmTvx27lzjbAnQt4
	 l1S4fYgSMFFCw==
Date: Fri, 18 Jul 2025 17:50:57 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	vgrinber@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net 1/2] ice: fix double-call to ice_deinit_hw()
 during probe failure
Message-ID: <20250718165057.GJ2459@horms.kernel.org>
References: <20250717-jk-ddp-safe-mode-issue-v1-0-e113b2baed79@intel.com>
 <20250717-jk-ddp-safe-mode-issue-v1-1-e113b2baed79@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-jk-ddp-safe-mode-issue-v1-1-e113b2baed79@intel.com>

On Thu, Jul 17, 2025 at 09:57:08AM -0700, Jacob Keller wrote:
> The following (and similar) KFENCE bugs have recently been found occurring
> during certain error flows of the ice_probe() function:
> 
> kernel: ==================================================================
> kernel: BUG: KFENCE: use-after-free read in ice_cleanup_fltr_mgmt_struct+0x1d
> kernel: Use-after-free read at 0x00000000e72fe5ed (in kfence-#223):
> kernel:  ice_cleanup_fltr_mgmt_struct+0x1d/0x200 [ice]
> kernel:  ice_deinit_hw+0x1e/0x60 [ice]
> kernel:  ice_probe+0x245/0x2e0 [ice]
> kernel:
> kernel: kfence-#223: <..snip..>
> kernel: allocated by task 7553 on cpu 0 at 2243.527621s (198.108303s ago):
> kernel:  devm_kmalloc+0x57/0x120
> kernel:  ice_init_hw+0x491/0x8e0 [ice]
> kernel:  ice_probe+0x203/0x2e0 [ice]
> kernel:
> kernel: freed by task 7553 on cpu 0 at 2441.509158s (0.175707s ago):
> kernel:  ice_deinit_hw+0x1e/0x60 [ice]
> kernel:  ice_init+0x1ad/0x570 [ice]
> kernel:  ice_probe+0x22b/0x2e0 [ice]
> kernel:
> kernel: ==================================================================
> 
> These occur as the result of a double-call to ice_deinit_hw(). This double
> call happens if ice_init() fails at any point after calling
> ice_init_dev().
> 
> Upon errors, ice_init() calls ice_deinit_dev(), which is supposed to be the
> inverse of ice_init_dev(). However, currently ice_init_dev() does not call
> ice_init_hw(). Instead, ice_init_hw() is called by ice_probe(). Thus,
> ice_probe() itself calls ice_deinit_hw() as part of its error cleanup
> logic.
> 
> This results in two calls to ice_deinit_hw() which results in straight
> forward use-after-free violations due to double calling kfree and other
> cleanup functions.
> 
> To avoid this double call, move the call to ice_init_hw() into
> ice_init_dev(), and remove the now logically unnecessary cleanup from
> ice_probe(). This is simpler than the alternative of moving ice_deinit_hw()
> *out* of ice_deinit_dev().
> 
> Moving the calls to ice_deinit_hw() requires validating all cleanup paths,
> and changing significantly more code. Moving the calls of ice_init_hw()
> requires only validating that the new placement is still prior to all HW
> structure accesses.
> 
> For ice_probe(), this now delays ice_init_hw() from before
> ice_adapter_get() to just after it. This is safe, as ice_adapter_get() does
> not rely on the HW structure.
> 
> For ice_devlink_reinit_up(), the ice_init_hw() is now called after
> ice_set_min_max_msix(). This is also safe as that function does not access
> the HW structure either.
> 
> This flow makes more logical sense, as ice_init_dev() is mirrored by
> ice_deinit_dev(), so it reasonably should be the caller of ice_init_hw().
> It also reduces one extra call to ice_init_hw() since both ice_probe() and
> ice_devlink_reinit_up() call ice_init_dev().
> 
> This resolves the double-free and avoids memory corruption and other
> invalid memory accesses in the event of a failed probe.
> 
> Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the detailed explanation.

Reviewed-by: Simon Horman <horms@kernel.org>


