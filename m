Return-Path: <netdev+bounces-217972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831BCB3AABD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A0477AD967
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22EA18C02E;
	Thu, 28 Aug 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnyknhac"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5D2566;
	Thu, 28 Aug 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408727; cv=none; b=hmU/BgVvG98mDFN7LjHN77INXFkN0rCqk5cF8jo9Oatyp3ton/yoSn/iJB4rE4JIJLXPE6bdQfWq/nFgUUR4gJzEYEpbadax+Yu9oRMtai4DhZks9ndJNVf9lSicoG2oxmJ9/EpJa2X7vhL8/aiUWrfijrtR1xflJj7lL1uwdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408727; c=relaxed/simple;
	bh=LH6AezsFH2q8tyoFIG5AafkQxCdiqL+l8zIp+QJhOzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7laaTJCHsxR2CmkyN/oUFGM7tCy34OVUS1I+lN9gHdtrsL8CtLnIqdDcMoD59EiBS7mpribcg+vJZwKl053fb80JGqKscJ8JGQqL1FwI8iGudV4TEymslF1pCYYgMiwNrVm3oQ6iY0KiX3Ajn2JbEVAM16jbuYlw9AxamlwNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnyknhac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ADEC4CEEB;
	Thu, 28 Aug 2025 19:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756408727;
	bh=LH6AezsFH2q8tyoFIG5AafkQxCdiqL+l8zIp+QJhOzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rnyknhacP6qCuqPNt7MzsAqUyqUOhd65DLpkW8Hg0l1cWsNq91ANU7FCRFEJhxx5T
	 dEkAYrIR6f4H4VKE+8d832o0ORHofu15vxzDPaZOQN8iQs8hqZZZZ0X0Unz25nc8TU
	 GP5ORre0ZHC2VExTc1BX2RsFzAEIClWsM3x6ZQxgmxne3+ipFmsDr1+zY2qAzbF/YJ
	 8+/6GH/qsLqbU1bd2Dv95bFPSSqOpfH7uIPrMXNEzsERcW31g/YOTxccWXnDEI/7mT
	 yS86rv50XdeGbo9AH8CLZsbQsTkcFzXWx71zohNiv5YjSFE9s1hIOEJmGM//h+y1rH
	 sta4Xws5OlFNA==
Date: Thu, 28 Aug 2025 20:18:43 +0100
From: Simon Horman <horms@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Karsten Keil <isdn@linux-pingi.de>, Laura Abbott <labbott@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mISDN: Fix memory leak in dsp_hwec_enable()
Message-ID: <20250828191843.GH31759@horms.kernel.org>
References: <20250828081457.36061-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828081457.36061-1-linmq006@gmail.com>

On Thu, Aug 28, 2025 at 04:14:57PM +0800, Miaoqian Lin wrote:
> dsp_hwec_enable() allocates dup pointer by kstrdup(arg),
> but then it updates dup variable by strsep(&dup, ",").
> As a result when it calls kfree(dup), the dup variable may be
> a modified pointer that no longer points to the original allocated
> memory, causing a memory leak.
> 
> The issue is the same pattern as fixed in commit c6a502c22999
> ("mISDN: Fix memory leak in dsp_pipeline_build()").

Thanks for noting this, it was quite helpful to me.

> 
> Fixes: 9a4381618262 ("mISDN: Remove VLAs")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


