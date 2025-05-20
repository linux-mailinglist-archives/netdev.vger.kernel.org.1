Return-Path: <netdev+bounces-191984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A779ABE182
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E827B402A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BA727055C;
	Tue, 20 May 2025 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG9LV55E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA70288D6;
	Tue, 20 May 2025 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760780; cv=none; b=HMT4MrUoQSqprDQC/dkOOJxmbrSDAPYXcuhqc88yvH5i1/qHjx+pmd8t4W/jGkNm0DJRy9rsYUEFFdLzurAL2/+RdT6xKCS3oXwa4AuG/sfnI4QiVPkfnisJbPMwO9NWBtJi6wzdYglyhUoAubDzsRYPZdgexxz2/LGfmdHZovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760780; c=relaxed/simple;
	bh=4+x/WzJqcocQ57G/pMHfGlGvRWRP3I3t99jvTgG0zGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU5zjZpOtZPDDlV+53BdBt1z9GpDifWtN5hUpQDetIrN34/F5bDHR0XrO4jDMfkPn6zQuHdf5Xjx/RdyTFM8A4aqmfIzRUcxGXUlP9VdXFpvja3rDj5tw2CMGg3GkTRBoeLHIHvcd2W1cVfcCtAoYfYk1vdXBFOAkpf3ygARp9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tG9LV55E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6680C4CEE9;
	Tue, 20 May 2025 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760780;
	bh=4+x/WzJqcocQ57G/pMHfGlGvRWRP3I3t99jvTgG0zGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tG9LV55E86YtwIbQonnRfogH4Z/1ML9Id5+9pe/+Ad6wMpPuSNAKt8dx/W+YEBgeG
	 bc5Ni3p2MJjJFSJ9CHFplXB8nAuvn60pckBrd2z8LqM5g5ENa4bl0Hn9zHn9FvKtkm
	 TIFnxLbNEf21icElfbyAxYpFY2C4m3Ngiue4VRAlNN87ipEfwTe1lwlq7DvF7a3A6b
	 77BwOp1DcFR60LyCtDTWfrH76CrgKH9JeKH705euQt7bXh6Bsxzx5aawewsYGSG5ly
	 9JaB5F8pocn6KuNq8y+V04xYVg1r2ZL2kuCwUs46yY+Buw6dNCxegwSMvddxekHxWQ
	 ++5Fgo6DuPFdQ==
Date: Tue, 20 May 2025 18:06:15 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net-next] octeontx2-pf: QOS: Perform cache sync on send queue
 teardown
Message-ID: <20250520170615.GO365796@horms.kernel.org>
References: <20250520092248.1102707-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520092248.1102707-1-hkelam@marvell.com>

On Tue, May 20, 2025 at 02:52:48PM +0530, Hariprasad Kelam wrote:
> QOS is designed to create a new send queue whenever  a class
> is created, ensuring proper shaping and scheduling. However,
> when multiple send queues are created and deleted in a loop,
> SMMU errors are observed.
> 
> This patch addresses the issue by performing an data cache sync
> during the teardown of QOS send queues.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

Hi Hariprasad,

This feels like a fix and if so:
* Warrants a Fixes tag
* Should also be targeted at net rather than net-next if it fixes a problem
  present in net

