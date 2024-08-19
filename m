Return-Path: <netdev+bounces-119772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF65956E9F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34B2B20979
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB0347C7;
	Mon, 19 Aug 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC6cTnM1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB229D0C
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080943; cv=none; b=AZWxtR5FUMtYOOSnXpEpzyWEbsHV6S6rQoSLH7DtuzoynS1TdmsFU7NpaX6smJgpsDet1bwji2gUJTgozUsgI5Jz89Fr54pBfTrvTMjOI/6GFxmfjLNlU7IHB9MUhsyHYnuhDOATWGT98jKm/eROyookJUCCsPidEyLLTj5Hhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080943; c=relaxed/simple;
	bh=a9qxI5n4LrlkWyR01mesv4VWM2o/xIBZk+h35g7/yxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrzs93xzV/O1JcmAJ0b5asZLcu+/PljCvByAUlll/PhF9+Hv1gWCk/PMIroKVlc4lIH4TaW/akoIrvyxKp4t2y4TpCEW8LjCr7E9UG+1ux8HhogdLfGMco/hOIXKO4APB7dVJQkSYFvrVQX4zafl7RMfmtpGBJaB1TWo7B4wTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC6cTnM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8E6C32782;
	Mon, 19 Aug 2024 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724080943;
	bh=a9qxI5n4LrlkWyR01mesv4VWM2o/xIBZk+h35g7/yxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kC6cTnM19j9Od4xB2HxjZCbBINjN3UsndIH8vcvXMcyODV33YPPDPoYbUfVlnR6+b
	 3cS6eaD0Zp3dkdrlUkqCRyZujZ3E960sgXCu30SFJwKsHtlMb/FXqgwM7ljXGZ70d2
	 KQUl46Hm9HFwsOzH7fpPu5RDCMNYdO/Tv31EBYWugR7jPkANV0Ffol1f2Tj+nIg4Zb
	 1TV38B8/Gew372YJ5DdPkSs+VOHsrR2xnL3StEq94buA77CvwfgJ232JZh8ClrvYyK
	 NkJh/jrNtf69AovHmj3zJFXKRnAkc20k8+BIMLyY4VEpuZm7zDUu41Kf3lmj0pNGMp
	 i1E7x2IvB0AEw==
Date: Mon, 19 Aug 2024 08:22:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
 <michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
Subject: Re: [PATCH net-next 0/9][pull request] idpf: XDP chapter II:
 convert Tx completion to libeth
Message-ID: <20240819082221.40614484@kernel.org>
In-Reply-To: <33cd92d1-5d54-42d9-9e01-7c633543bfff@intel.com>
References: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
	<20240815191859.13a2dfa8@kernel.org>
	<33cd92d1-5d54-42d9-9e01-7c633543bfff@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 13:58:40 +0200 Alexander Lobakin wrote:
> BTW can I send the netdev_feature_t to priv_flags conversion since
> there's only one kdoc to fix and the rest was reviewed or should I wait
> as well?

You can post, the rate limits apply to vendor drivers only.

