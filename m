Return-Path: <netdev+bounces-215073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1073B2D0B8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93322188E10F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E317B506;
	Wed, 20 Aug 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCPBjuAg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CB288A2;
	Wed, 20 Aug 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649807; cv=none; b=PkBu0DhN6J2b+j3IhO09dQU3D6tUfPGQ0pJ5B3ZTix5byEzmRAHats1S2LGArLOZhKfvEla127THUP8V1czqqI8bv+vV/5PF3Wjp3uhyMVZLD/HUfGM2pAz44XjSfkuGYlgudpwQpH0U1h/iZDQXUQyQRn3ITshlptUF6a18qD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649807; c=relaxed/simple;
	bh=gmn55X6D6PL4NZSWpbJzNZPW5Gc6cW8EIPufeWs4ygs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOaSi2XkwmXRh1AVkcv3OfGLFbewJTKywtcJEcY3dqi75hXOxt+NgVtyfc9hOD57WwEy44/JbWpHvba17wZCvcOEMFE88qnWEQgN7fSNf4wWjUFUjIpOBDV2vqkZ1JFDSsUhmwnWxVGyI255vHa5qzNTMu4vScJdzccIIJJRAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCPBjuAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519B5C4CEF1;
	Wed, 20 Aug 2025 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755649807;
	bh=gmn55X6D6PL4NZSWpbJzNZPW5Gc6cW8EIPufeWs4ygs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VCPBjuAgsUjc2Lmp9/8/7X1vzCvJSJYowNhtzOysoDtK+vRP1zOtyyho+rQIQ5MIG
	 c4qMNZrJZcczo2Bc88cwkx/UY0Yas4iwWgIKuVQBtgCkVzs5/N+sxXx7hkhhQ6Bu5m
	 2zwC9C4CV33Yb5mRK1ztCi4GWBKjlhbcU+CjQTjtbX5cXthoEVPI/gHVi6KL9CyK7b
	 hWfSpGZcCb7LPXjozUMEdg0OSHsTIeXYaibd+IjIvHpDVGh3ms8J0jhzo9X75Dt3nY
	 KQLFbUA0J9h9rAQaOY7w1+OBpbn/USUDiM3S7fMM8KymNGmprB2V86QGMgU4JHPyqU
	 Li2wgkUvtgrBg==
Date: Tue, 19 Aug 2025 17:30:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com
Subject: Re: [PATCH net-next v2 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
Message-ID: <20250819173005.6b560779@kernel.org>
In-Reply-To: <willemdebruijn.kernel.a8507becb441@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
	<20250819063223.5239-3-richardbgobert@gmail.com>
	<willemdebruijn.kernel.a8507becb441@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 10:46:01 -0400 Willem de Bruijn wrote:
> It's a bit unclear what the meaning of inner and outer are in the
> unencapsulated (i.e., normal) case. In my intuition outer only exists
> if encapsulated, but it seems you reason the other way around: inner
> is absent unless encapsulated. 

+1, whether the header in unencapsulted packet is inner or outer
is always a source of unnecessary confusion. I would have also
preferred your suggestion on v1 to use _ENCAP in the name.

