Return-Path: <netdev+bounces-84663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CEA897CF4
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B43428D4AA
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 00:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23CA819;
	Thu,  4 Apr 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAjSWw8k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907628FA
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189907; cv=none; b=Dic6ycGKyHggvUW2Eqe0nPOimzHzukeJZ2gloumn5wtXivVbtb1gmWnNhZofnK55ACoZnGlQaDMyLCYelwSX2cSoRsiWYU6kbNgCDCRUUgwewwXSmmTiTuabNzhEy26nUvYiTTSY5iwNa/MW3d65mYae4GHWZA40xz9/tuYwDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189907; c=relaxed/simple;
	bh=oFgDkqDFbBuI5mDUBruGWOiy5gGd2s0+giOp4E1Jyns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KN9fP1M7Fs39Vk/xa4u6T7FYy1Mh9JEJVhp6buYN4YFaW/vr6CmLxBp6cTfhkx4/umgB+MhN7mJNf/sG9Qe1efOmGGSfyD4xB93NyV8/in9T3TLy57QyUkaPhwZn9W5JIcb4UiDJpg6Jt2lnrfcVmSijfAENb1ZMuleSzhYjrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAjSWw8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D97C433F1;
	Thu,  4 Apr 2024 00:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712189907;
	bh=oFgDkqDFbBuI5mDUBruGWOiy5gGd2s0+giOp4E1Jyns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TAjSWw8k6GmTkmAsyvPKWdQQnLmKDQwQ6/GdVjEfA4fUOBlEMsu1bYBpR8TGEzmS5
	 egDBIRgsS48gXmeM5Dfa6KrHuxb5ULq5KpQpsff9CqvLL6jWsPXnCM+8QibOwhcNld
	 9G+CVa9fo38kl2oKz0JwzHuBu9r1nL2j1Z11gisc4NVDfuFciarNPCIfC1lYAIjotF
	 wSgWQDfe4GyZF7eUvGShkbdl2DNZ88dPtRsoZMfzIxAxyJ+epayQY3s185jeq+8Uoi
	 Tpt/JyN0DD8ZasNMIZVLSki6p2hAym+0kll6p3s6ShUgtLYW2njT3FHLECweSsnIFb
	 nBssSYPTnPORA==
Date: Wed, 3 Apr 2024 17:18:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <anthony.l.nguyen@intel.com>, <edumazet@google.com>, <pabeni@redhat.com>,
 <idosch@nvidia.com>, <przemyslaw.kitszel@intel.com>,
 <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH net-next 2/3] ethtool: Introduce max power support
Message-ID: <20240403171825.31d6867a@kernel.org>
In-Reply-To: <348ead57-cdb8-4db7-a3d7-e8053a5f00c1@intel.com>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
	<20240329092321.16843-3-wojciech.drewek@intel.com>
	<20240329152954.26a7ce75@kernel.org>
	<f7c6264e-9a16-4232-aba2-fde91eb51fb7@intel.com>
	<20240402073421.2528ce4f@kernel.org>
	<348ead57-cdb8-4db7-a3d7-e8053a5f00c1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 12:19:57 +0200 Wojciech Drewek wrote:
> You're saying that if min_pwr_allowed or max_pwr_allowed taken from get op
> are 0 than we should not allow to set max_pwr_reset and max_pwr_set?

Yes, return -EOPNOTSUPP and point extack at whatever max_pwr attr user
sent. If driver doesn't return any bounds from get() it must not support
the configuration.

> And similarly if policy was 0 than we should not allow to set it?

You mean the limit? I'm not as sure about this one. We can either
treat 0 as "unset" or as unsupported. Not sure what makes more sense
for this case.

