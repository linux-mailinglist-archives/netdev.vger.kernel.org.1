Return-Path: <netdev+bounces-165387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67066A31D08
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 04:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187831611E7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FEC78F54;
	Wed, 12 Feb 2025 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgbolSdF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF3271838
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739332049; cv=none; b=T4f4g7dtJ0su0rjhvdpDL8VNdtgpozXgN9brjmxJOw1nnOIYQS1+nQC+MOz459LUD+6QVNqCQvuDVI3Yrr46MtrFPgpb1ixzHIb441EQlmVlvT3dvAEhZPVWB1UQc7FL+auqWTrr7D/o6sDZLHmr5PtY8R9r8W7JxKayvgf1TFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739332049; c=relaxed/simple;
	bh=jLaA8Fl+Rv7id0EOOM+OOG/BhZnvIouPFpS4RbSWKwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4erfivsI9GT+DruTWMbu47DYpz18oq2vbCebd/jdlQgj7BxsaAcRHBTaeX+zgXd2ycGVMlYGJv07JWdVLj5Q4eYbq6O41GhsH/cP6lotPbsivjkuWNJTt/T5v4jnVc9ERbsZuYDGiRRDriSpUEs49rihHGaMG1KjmOJ93u1ClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgbolSdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CDAC4CEDF;
	Wed, 12 Feb 2025 03:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739332048;
	bh=jLaA8Fl+Rv7id0EOOM+OOG/BhZnvIouPFpS4RbSWKwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HgbolSdFVo+f1VtJPSaXW0q8knjz1zqmoMuvEvz3uVScqYbbOyt5Rti0euUj6IK3r
	 k0dMHnyVXkrxS+RggGsl6h/tNsXnUt2dr0TX7VPYhcoDDH6A8KygVIrFNjN49f+oKX
	 c6bOcRe6X7sPpTjRGkoGTQxIzkOEXtIMGgxIfBqvXA42HPlFHIhct0IisxiGOdHE1N
	 P5vsH6v0hDV/BJCDyFAjH1Yzg77CMXC5qEY7c+aqNJPwsYfmqYroY1dzLbi559xCZi
	 I3f1uJxBfQVwomwQx3A51W38nsIkNQ644phSOTaRF3q0LE9WyMNL9aj4ajuy5+FXyB
	 XwqNFAaIsnVvQ==
Date: Tue, 11 Feb 2025 19:47:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Karol Kolacinski
 <karol.kolacinski@intel.com>, richardcochran@gmail.com,
 grzegorz.nitka@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next 04/10] ice: Process TSYN IRQ in a separate
 function
Message-ID: <20250211194727.59090a33@kernel.org>
In-Reply-To: <20250210192352.3799673-5-anthony.l.nguyen@intel.com>
References: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
	<20250210192352.3799673-5-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:23:42 -0800 Tony Nguyen wrote:
> Simplify TSYN IRQ processing by moving it to a separate function and
> having appropriate behavior per PHY model, instead of multiple
> conditions not related to HW, but to specific timestamping modes.
> 
> When PTP is not enabled in the kernel, don't process timestamps and
> return IRQ_HANDLED.

You also switched from spin_lock_irqsave() to bare spin_lock().
Looks safe but you should have mentioned why.

