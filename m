Return-Path: <netdev+bounces-184632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CD2A968FB
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED5C3A97B5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D016A27C85F;
	Tue, 22 Apr 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gv3VkBdw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF31F2C52
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324459; cv=none; b=p5Dk3jx6yewnMH2t8HfF7MBg+y25ykhZE/jH8D+UIjKxLLhq5zPRi5MHhUp6J4k7K9Kienrv+zQRnKRt0xmQhnPRdUmAr3sHCGu3JqIxrGS97hzbHL09aE8qxY9Nn5KSVU7seu96y/QA/jFpoKSvwsW54LsXRP4BgCcc0d945jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324459; c=relaxed/simple;
	bh=+KyTPZcZpjUlSXuR6Od3i08Rwm0tJd9CK0l/bnn8NmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpGl5v8lTbqaLBD48vSMXw2JQQGtwKBumcWSR/jgyWuk3FRErUb6z7g58VjbnWyHCGkrWvQGfUk+fBXh546mnuU0hkAcXSnHe6z6At21DP2OQArxLIwyP6vzd3y/TY+83JHFD99hFlc3V4SpRZQTpyOtVGMDXlnWw/4vZqdfcUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gv3VkBdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B25AC4CEE9;
	Tue, 22 Apr 2025 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745324459;
	bh=+KyTPZcZpjUlSXuR6Od3i08Rwm0tJd9CK0l/bnn8NmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gv3VkBdw7aXshQ4XgExftOsReBTV7mhTllK8tkzMq1Vhs1cPm6z3f9Pwik48nniTU
	 wlRogZnmr5bVtm3XVdBqNvJzKlLs2Lda+M5BYzx7DZ7zonx1k7ShuO+xZkYO/rOl3d
	 8zPrfFrStsT9Jbf/7Uhk+m2Ovx/cFrCljHD9jW0bXdjp4tAC8cPM1v//O3Zlc/PQwZ
	 BZ2VKkZIqOh6zqutSOYux73tdvwGZfpcZIvqIjXagnPt7k8cCztFcYVsmpLND+nz/G
	 oo6UjuEEjfm/J73vd6pLOGNgzV9r2MOZYpezz9ffEKHaB44oWjzZPdImpmDt2uX1/D
	 NGCsQH1P2tSYg==
Date: Tue, 22 Apr 2025 13:20:56 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 2/3] net: ibmveth: Reset the adapter when
 unexpected states are detected
Message-ID: <20250422122056.GC2843373@horms.kernel.org>
References: <20250416205751.66365-1-davemarq@linux.ibm.com>
 <20250416205751.66365-3-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416205751.66365-3-davemarq@linux.ibm.com>

On Wed, Apr 16, 2025 at 03:57:50PM -0500, Dave Marquardt wrote:
> Reset the adapter through new function ibmveth_reset, called in
> WARN_ON situations. Removed conflicting and unneeded forward
> declaration.
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


