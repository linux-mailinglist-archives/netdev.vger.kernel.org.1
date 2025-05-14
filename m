Return-Path: <netdev+bounces-190382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D17EAB69AD
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBDE189F459
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F175B225401;
	Wed, 14 May 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT3oxS91"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B1202F65
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221613; cv=none; b=SV4JTCYLbJlZqGxd3Kowrvb9wnsYHone1goYECmZndAbysib44ZliVUicqueIEIK6EkosfzpXYHcb0UbGC8MpsRQljalMrn0epS+gmPtg62qN2mjg6Dpc0yTBH29fPKwVa2SkqZmNOP0gLdBUjXFC93sjvq5t58/3Cj+3InQ81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221613; c=relaxed/simple;
	bh=8GBsbE1t649OcCtq68JueSMDB1Fp3AL9oTSyebsoWxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQYbGdY+2lOPgT/if4UTe4EdaAMmBjcbJ1War0xO8bPc3ltTImhUNDI2qwT+jIwFxII+uzwQCD3mk+bGLbN7fJ6PZbdu5/cYp4aa60PTMonVkspT80fJP8uP1rWuwoy/cLCbRAMd8JsDrysFKWnAqyBhedW0MJDcGVWhuxd3/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT3oxS91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E376C4CEE9;
	Wed, 14 May 2025 11:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747221613;
	bh=8GBsbE1t649OcCtq68JueSMDB1Fp3AL9oTSyebsoWxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FT3oxS91zHV8RkjI5KEg9C4CYcp0Raykoe/c7jHzC47H7bt24gsqnkcG21uv8x5Eg
	 +OJnjH4j6KQd9L7ssOhjQSemsZBNuDAT9Ei1eS4aGNR4to/aIje4CnpYoXG42xO/YL
	 0GM0cQTxPb+LBur78Uf4XZX0kG3TWNRHVa708qfdqrDySEbLlYYWsmOfzASefCpY/P
	 FLRPMnPmbVm9WbpVHRzdeBU/URW3NfD9k5xgELAJxH2xZLDCxjdVAhnPBXy/mhymns
	 AjYRnY5lDcO6KrsrBEfG/3unlGhSxUUrS5c0IFQYfBYIxugsM39y3ysKAmhdxStYSm
	 I3YeI35lVFouA==
Date: Wed, 14 May 2025 12:20:09 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, mengyuanlou@net-swift.com
Subject: Re: [PATCH net v2 2/3] net: libwx: Fix FW mailbox reply timeout
Message-ID: <20250514112009.GI3339421@horms.kernel.org>
References: <20250513021009.145708-1-jiawenwu@trustnetic.com>
 <5D5BDE3EA501BDB8+20250513021009.145708-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D5BDE3EA501BDB8+20250513021009.145708-3-jiawenwu@trustnetic.com>

On Tue, May 13, 2025 at 10:10:08AM +0800, Jiawen Wu wrote:
> For the new SW-FW interaction, the timeout waiting for the firmware to
> return is too short. So that some mailbox commands cannot be completed.
> Use the 'timeout' parameter instead of fixed timeout value for flexible
> configuration.
> 
> Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


