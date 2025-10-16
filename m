Return-Path: <netdev+bounces-230145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE5BE46E8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BB6456006D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65069350D6D;
	Thu, 16 Oct 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6erMQRw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE87350D68;
	Thu, 16 Oct 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630431; cv=none; b=HjRZJlmGEH9XCrie5duZpiI/cam1kx7mN8jRmtidjKU+l048erJiJarllel9gH0DjT7j8HMxxRvRKNC4Q3XACOPIT8DTAS4d7jbH/C8S+o+MDs5NTQaNhg0Q+flg9sN57aLCsssEyccLAEsDrJEn5cggpb/AdvFjrQ3PdplGTiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630431; c=relaxed/simple;
	bh=nORpSP6NrI6Qmuqm66M/ilyzrD8flM0QSTQ4gbzBGi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/LaO7j6Hjv/vkKKqbenRLIGANWaFo/D88Xi10NXyEDjijgN1MOydgLfLVyr1ITWKztdc89og2r6NtLW32TfW69h0To/r1kkgDRgIJJfvukEAA6Et9/hBOlfUEqVB0u2V5xjW7Two6e/RV+URVNPfTfR1Nz/SWVACc8anxP2RQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6erMQRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF95C4CEF1;
	Thu, 16 Oct 2025 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630431;
	bh=nORpSP6NrI6Qmuqm66M/ilyzrD8flM0QSTQ4gbzBGi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6erMQRwckQ6A4zou04gI0aaPdOBZOubgDi7fAVY6xKulEcsY1GWnGPpOOaMHwnXX
	 GkX9JWq2f1Htn1vUgbbi18LINXvee8aLd41Y8Sk6x9VzCvIRXEwHS7nHlNatdxhSMD
	 8PhOhXvxuUlUOm4z1Md06yNnNcrfyqxbuOxzctZ7W9zwuBnaYKl8+8NCiw5nWDBoUJ
	 9R89LQBk9cOsZHe1nCBEFiELV/oBteEcH8bbV5N+UgQHpTd6bpXclhtkVS11Hubxa4
	 2OGv3/98XaU8adyPEQBuCToDHaxJSQO0OZnCNh9NnywXTahukgnoFuPiZ8Ad1qLsoV
	 FH3/olxFBwC/Q==
Date: Thu, 16 Oct 2025 17:00:26 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/13] net: airoha: ppe: Do not use magic
 numbers in airoha_ppe_foe_get_entry_locked()
Message-ID: <aPEWmlok8qlV8UCY@horms.kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
 <20251016-an7583-eth-support-v2-12-ea6e7e9acbdb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-an7583-eth-support-v2-12-ea6e7e9acbdb@kernel.org>

On Thu, Oct 16, 2025 at 12:28:26PM +0200, Lorenzo Bianconi wrote:
> Explicit the size of entries pointed by hwe pointer in
> airoha_ppe_foe_get_entry_locked routine
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


