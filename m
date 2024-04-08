Return-Path: <netdev+bounces-85792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE38089C358
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE89DB2D36C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D1F7F7F6;
	Mon,  8 Apr 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swSSJ9So"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352C78285
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583143; cv=none; b=C/h/91Zpjqqjm28pFd5y2QccoeC7zyQd+CXtSuxRZ0uGwUfPqzPW8bu0+Fz5mKl3qxLbCyJDrAT1mVEd6WCE3W0/nfqrMHiNR5Mj+OJ29+1HCf9exBQBNrHdVL57UhIFulwtA3M8kj0RVTCRiQ6ltnsOHqFCmIniJrNhlEs0omU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583143; c=relaxed/simple;
	bh=ZZ1j49kXRZioyRheEpLmhWE7M5mUvy3M3llmDuAPn30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7Iy4HoAdIpo/+zFxQ/PkIfdv27Fv5cKCmHppcNigEQFZvc7jxx0knwO9qt38R1R7yq+hQYEIUska6R9deVzcJCJgUkxYZxe18bb00IpK20tu242yaECQyYgj2Wxl6bjo0bOQavny2BYBJElNcswTTtP/wYtRxrmBC990HCgkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swSSJ9So; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB82C43390;
	Mon,  8 Apr 2024 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712583143;
	bh=ZZ1j49kXRZioyRheEpLmhWE7M5mUvy3M3llmDuAPn30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swSSJ9SooD5M6Rix+XRmlpY++WFoyuTVfLVp7SRZzpP20Js2SpqLIP/Ya2bFaM3fV
	 OK38CVwArYXsyCRocQMdQ2Xu5guDsmtYfgCjIz0psaC21v4wmaOh9NwsTr17MrNA8h
	 jeoR8GZ4R2DTFecJLG5otcT6GTJsuNCFn9b/Ms55/WwSymzQlk7mhLoaXRpk7nlpb+
	 pYeI0azsAjhhmnPG7uCiR90/FMDu20/q8V8f7ASMUkeiEmrV+GelJ08i5yrvwY3LnD
	 EbRXud2hOmQniaQIjjFBkcWyv1eRert6hWdxIl0nB2E3ePcls4ezlFED9kuOkWE4c/
	 M2SYWn5/VFlMg==
Date: Mon, 8 Apr 2024 14:32:17 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	mschmidt@redhat.com, anthony.l.nguyen@intel.com,
	pawel.chmielewski@intel.com, aleksandr.loktionov@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Liang-Min Wang <liang-min.wang@intel.com>
Subject: Re: [PATCH iwl-next v5] ice: Add automatic VF reset on Tx MDD events
Message-ID: <20240408133217.GI26556@kernel.org>
References: <20240404140451.504359-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404140451.504359-1-marcin.szycik@linux.intel.com>

On Thu, Apr 04, 2024 at 04:04:51PM +0200, Marcin Szycik wrote:
> In cases when VF sends malformed packets that are classified as malicious,
> it can cause Tx queue to freeze as a result of Malicious Driver Detection
> event. Such malformed packets can appear as a result of a faulty userspace
> app running on VF. This frozen queue can be stuck for several minutes being
> unusable.
> 
> User might prefer to immediately bring the VF back to operational state
> after such event, which can be done by automatically resetting the VF which
> caused MDD. This is already implemented for Rx events (mdd-auto-reset-vf
> flag private flag needs to be set).
> 
> Extend the VF auto reset to also cover Tx MDD events. When any MDD event
> occurs on VF (Tx or Rx) and the mdd-auto-reset-vf private flag is set,
> perform a graceful VF reset to quickly bring it back to operational state.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Liang-Min Wang <liang-min.wang@intel.com>
> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


