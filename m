Return-Path: <netdev+bounces-109009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D509267FB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E750288A1A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43B9185094;
	Wed,  3 Jul 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/xgocVD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04A61849EC
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030836; cv=none; b=ebffx8LVcHqeUGe+aCxDDtXiuKySiZYbAePadYCLxgn1H413fGa8Pl+HGMLI8F1qJQ+0Vz8BQ6le1R5euaqmHMvC5CYlSx7PWGosmejfTu6NAMP6XV1OuRikDTI0G0oygUuMnWMtPP3iYvRQT/54+JGxbJBa2O2AtBg3pjqV1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030836; c=relaxed/simple;
	bh=3SaaX/yGkke6j5+pzv/5pvphG17t4bjiF8PTudDUSMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFiEYLcH0JqoP1MeFnmVpVs7w4lILmqrFhvOhRDTJaT/eT5Tx+FI1uRIgYhzjMzt0ebBIMW9ODGae2vLZD3J0keTTDy7FM+RreyYnwqypCJ1cNb6fhJyRVEMjGQbrKKGBlU9gLBdkv50C6SZxJDRsidMfMrZPK7Cf5WjahP9ZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/xgocVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B20C2BD10;
	Wed,  3 Jul 2024 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720030836;
	bh=3SaaX/yGkke6j5+pzv/5pvphG17t4bjiF8PTudDUSMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/xgocVDw9BxcR0MbGGAD2isD5kYRHekbI6gffXdWDK1KiWqtXISUKERwUrStkTlz
	 2nZcITzCY1E4SGQHpWA+CmihoGkkZGut+w8qS4/Gr/oRzk/MniAUFQyfvzyW68Jij9
	 6Rwt/QVRSEVY1m8od4tNcqfrWooH10PdJK77WJrbvSj6bwGuLvHKFijsnuk54JLcfi
	 WCNEDXa4lyMqd1KJs7UCs3R1/10fnpQ8QMFSROlqNmJcAcN2r8oXDLRU2kRZXrFuTu
	 Xx0S4ndA/iOKgUhRP5BG9lYD24lwy7p/8t/B6Ez2YvFYlDwst3HudRr/zo4FAkJdL8
	 vEtS7yLVRRL4w==
Date: Wed, 3 Jul 2024 19:20:32 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH v2 iwl-next 4/7] ice: Cache perout/extts requests and
 check flags
Message-ID: <20240703182032.GM598357@kernel.org>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-13-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702134448.132374-13-karol.kolacinski@intel.com>

On Tue, Jul 02, 2024 at 03:41:33PM +0200, Karol Kolacinski wrote:
> Cache original PTP GPIO requests instead of saving each parameter in
> internal structures for periodic output or external timestamp request.
> 
> Factor out all periodic output register writes from ice_ptp_cfg_clkout
> to a separate function to improve readability.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


