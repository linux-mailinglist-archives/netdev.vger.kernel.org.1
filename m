Return-Path: <netdev+bounces-165389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CC8A31D29
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 04:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2E13A5143
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8327A1DDA3C;
	Wed, 12 Feb 2025 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym5pABci"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3A1581F8
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739332625; cv=none; b=TY5oDV6tpR5qqEHAgAwipVWS6zj+n4b6CgGPKTJx41aGhM9JrIJxHmH4Qd8rzTaPhq3w3lwd9s3mEGXNEgNkKVqc2IzQlOLRIRwsbtLoLW+nplNSTC/yxMd8+px06wFGQ4gXY0pD/b5dL1nhHUyPkODv4OqggBzTmkSopz+x1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739332625; c=relaxed/simple;
	bh=GZbhw4/G3BVLHWJ6RomVic2mT9LWCZHPM5EVrM/3TnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcO8RLx4BZDI6opDoOocfgDaEN0tg5l87MI0fsS16wwRu37TigLaTKszm49zPiiZa/pULpKylBLNPKEi1rU9YhGIAGtItyu3EW2hbmI0GBLA9sy7JkxwcrpUHNXGsVEa1SNsZTcts+FIgPHv1t2vfIm5vPMIrvEBQ2mrtlZ2q08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym5pABci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E67C4CEDF;
	Wed, 12 Feb 2025 03:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739332624;
	bh=GZbhw4/G3BVLHWJ6RomVic2mT9LWCZHPM5EVrM/3TnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ym5pABciHA+MT0w/SLSY4phzp+MpdQ72Mpaig/V3kqGqlK6bJTWzZlN6xeVCdmrnd
	 t5sChHWjgovasUPUo7VTYmLlatvMKYCV+SXGRqng9duIn6RnrUuwxv+ymFzmD179eA
	 h1w0IN4ryXPvkYsQVrjIVdLfw+frKrzyTNIael1gyD1J+9V1c2q1/YM2beM+xQjIah
	 5z0C7tOyZpWy3lcTUxTOs7VJHt/eP/aEimkeyhh1fG8dVUECoSkglQL6NT+Vl0KHGD
	 ND4ut+C+1itW6sAq1KsaaiKs7PkFzOYoFqsYTcOR8OYX6tVVHgpZ0LxIZ+gsCu2reX
	 78PYoCxU7VmJA==
Date: Tue, 11 Feb 2025 19:57:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, Saeed Mahameed
 <saeed@kernel.org>
Subject: Re: [PATCH net-next 02/11] net: hold netdev instance lock during
 ndo_setup_tc
Message-ID: <20250211195703.57b5a6d1@kernel.org>
In-Reply-To: <Z6waIoWA8EBllLVk@mini-arch>
References: <20250210192043.439074-1-sdf@fomichev.me>
	<20250210192043.439074-3-sdf@fomichev.me>
	<20250211182016.305f1c77@kernel.org>
	<Z6waIoWA8EBllLVk@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 19:48:50 -0800 Stanislav Fomichev wrote:
> > The netfilter / flow table offloads don't seem to test tc_can_offload(),
> > should we make that part of the check optional in dev_setup_tc() ?
> > Add a bool argument to ignore  tc_can_offload() ?  
> 
> Let me dig into it... I was assuming that tc_can_offload() is basically
> a runtime way to signal to the core that even though the device has
> ndo_setup_tc defined, the feature can't be used.
> 
> I don't understand why some places care only about ndo_setup_tc
> while other test for both ndo_setup_tc/tc_can_offload. Do you by
> chance have any context on this? Does tc_can_offload cover only
> a subset of (TC_SETUP_BLOCK) the offload types?
> 
> The easiest way is probably just to keep calls to tc_can_offload outside,
> as is, but I was thinking that doing both ndo_setup_tc and tc_can_offload
> is a bit more safe.

Off the top of my head the feature flag was added when John pioneered
the opportunistic offload of TC classifiers. It seems to have also
propagated to switch-like Qdisc offloads. The answer is probably some
mix of historic precedent (non-switch qdisc offload like mqprio exited
way before), features which are unambiguously HW-facing, and plain
omissions.

Let's do whatever is easiest here, the series touches half of the
stack, we can't possibly clean up all encountered.. mysteries.

