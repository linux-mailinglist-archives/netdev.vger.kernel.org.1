Return-Path: <netdev+bounces-83025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C889071A
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB0F1F26DCF
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CEC42A9C;
	Thu, 28 Mar 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI842sPQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3BF18C22;
	Thu, 28 Mar 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646630; cv=none; b=V7Mss8ss6pFX/pJw0Qf1LEWHPg40JXtarAEPgrLZwAasQu7h4gdJszwbgSZbUHLuLb9kmVZ0PS1rVersXa0eobznJxRpBFbr2/fEnJjV1EoMt1vtiSRlI5Sp1mpiGVSNZ5+pMR9rSWbXnJbBPiSXuzMM9bgfiCoL6PD7rKncQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646630; c=relaxed/simple;
	bh=P2CKB0L231HThL4Jt5a3TeDwHGhyU9+DFrwHKENAF5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/HHQ2BW0B1sA0fI2Lz6CG3N7dI8/7G+zSSZEyuDI8v2Q7ezUS5RK695G/LJSuZrrfdzIkQXlcO8NGFqFj3pIhqplCovWWwDy8jn3UZAf+GSllgKu8C2XxRXXwofTbDFyXAhgAv+PNgqo9MZ+rP5VKZTH3OCE3HLQE9pULfgxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI842sPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A588BC433F1;
	Thu, 28 Mar 2024 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711646630;
	bh=P2CKB0L231HThL4Jt5a3TeDwHGhyU9+DFrwHKENAF5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fI842sPQ+LoWq1tsKBLskQ8CaHp5btU0ZDrBXzMxmxK9mMDCOpxfiC27RSJf9lFxH
	 5inhl+CGsY7Q+VllkoOlWUcFY6j4gChUA6eJBpfkUl97u1EaJMU1EiclDMHjTGzjbT
	 9eaZQea83f8IjtWlO9EbusD+FeigG9FaMGKZx/J4pF8zuExHI9BEvrDVcKp80bYllH
	 QUtBPu6EA6s9GNZRRnFFHMR7hRBGbRIOF1WtsnSkv1EFqMKaMxv8nrl7mvTicOmDdb
	 dMG/xGwG5Le/Z9QmOcWzqeThVTEMIShwW6WEygIvARayKSe/MqMCM+mfOzzOZNrOKP
	 3jvMkNmyC674w==
Date: Thu, 28 Mar 2024 17:23:45 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mschmidt@redhat.com,
	aleksandr.loktionov@intel.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH iwl-next v2 3/7] i40e: Refactor argument of
 i40e_detect_recover_hung()
Message-ID: <20240328172345.GC651713@kernel.org>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327075733.8967-4-ivecera@redhat.com>

On Wed, Mar 27, 2024 at 08:57:29AM +0100, Ivan Vecera wrote:
> Commit 07d44190a389 ("i40e/i40evf: Detect and recover hung queue
> scenario") changes i40e_detect_recover_hung() argument type from
> i40e_pf* to i40e_vsi* to be shareable by both i40e and i40evf.
> Because the i40evf does not exist anymore and the function is
> exclusively used by i40e we can revert this change.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


