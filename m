Return-Path: <netdev+bounces-109162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4639272D0
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06D9B210F4
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86451A3BDD;
	Thu,  4 Jul 2024 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeodwkRA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46DE194C9B
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084810; cv=none; b=dZIQhDDaCMSAHiHbErTah3vzTbL9+n0im5qIza3bNXI5EmIB7lNa/jNzzX740TT0bruPRG1KhPHcthqhSKm2CyDmR0WjMFyBMgtvpwStlJ1ETJcM9ZoSMJKs9Gj241/kNfxoX0UKzIwWZX+rftzngsQHg8XkJcfGeev5wgOjGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084810; c=relaxed/simple;
	bh=Kk8dVpDTmuErX+uIyrLj24Hr42BeyaSmy9+FsD7SSLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIPPqRx2dCWtZ2/3k6/nsqwi3uJcB/u3KTFDqZsbxDN2PgTDX5UOv7hpMiQ0tg+6URD4iynnV+eXXtvDw/N+6Fewsde56ZJ2OGLFqfCiYMpu7vB5S90LLAf6Uedr3utcmYjNDjkSSFBdKi252vgxD9JoHNAgMOZwhYqObtBArl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeodwkRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85859C3277B;
	Thu,  4 Jul 2024 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720084810;
	bh=Kk8dVpDTmuErX+uIyrLj24Hr42BeyaSmy9+FsD7SSLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeodwkRA8UTcnBMdzKI6g9K0WMXxOdFyRxVqptgmH3sbaUllteU4uYPSNQPGNGY0j
	 9qZF8rPBCOUEH3NQYBsSMXD9LIjhOu0QtBu8xxFebDUrdg4JPgsGXAHgPKUvdveXC/
	 ofFw8SF9L1SVvv/e45F2bs2zS5Qhhu1IkGGrSZKCno9y2REBbepzaAKL8RpFEy5reV
	 QnZKtOaOfJX1cx8leeGxzIpeIRwcR25or+XR1k5X6CSfsx0TseSFbVUooWNNOoSRSN
	 h2T6Js1U5nw+33VfB53jOivNocXzEHpleFGUGglbNUcQ9cC0SOsELmG1PXi7UR6ZC9
	 dohI/R1qYyYrg==
Date: Thu, 4 Jul 2024 10:20:06 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net] bnxt_en: Fix the resource check condition for RSS
 contexts
Message-ID: <20240704092006.GZ598357@kernel.org>
References: <20240703180112.78590-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703180112.78590-1-michael.chan@broadcom.com>

On Wed, Jul 03, 2024 at 11:01:12AM -0700, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> While creating a new RSS context, bnxt_rfs_capable() currently
> makes a strict check to see if the required VNICs are already
> available.  If the current VNICs are not what is required,
> either too many or not enough, it will call the firmware to
> reserve the exact number required.
> 
> There is a bug in the firmware when the driver tries to
> relinquish some reserved VNICs and RSS contexts.  It will
> cause the default VNIC to lose its RSS configuration and
> cause receive packets to be placed incorrectly.
> 
> Workaround this problem by skipping the resource reduction.
> The driver will not reduce the VNIC and RSS context reservations
> when a context is deleted.  The resources will be available for
> use when new contexts are created later.
> 
> Potentially, this workaround can cause us to run out of VNIC
> and RSS contexts if there are a lot of VF functions creating
> and deleting RSS contexts.  In the future, we will conditionally
> disable this workaround when the firmware fix is available.
> 
> Fixes: 438ba39b25fe ("bnxt_en: Improve RSS context reservation infrastructure")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20240625010210.2002310-1-kuba@kernel.org/
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



