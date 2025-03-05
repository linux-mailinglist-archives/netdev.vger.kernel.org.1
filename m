Return-Path: <netdev+bounces-171874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D04A4F2F9
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEBB3AAAB9
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C03B2A0;
	Wed,  5 Mar 2025 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRbKWIlx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D11E50B
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135900; cv=none; b=iiwnrHF9SKOHMUWlda8e8/NNwQQsWEF2McfhrGLu/KVRCGGp4xQVy7V9TNQv8GsZzeqMfcmL9kEMBTH3BVME7j23SRLz2q9ZZgJU2iJ5Wk3UPvqswjVRlR+s+aJZkcN1tXiUoI75PoPoNFUMN0K32h4wumW+LWqOC1alf9sJibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135900; c=relaxed/simple;
	bh=9hLWRXWxHLgq0kbJTo3u5KPKZDzNf27aFaVOmSfCS6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lO0NqIMpCOcnrvQTYmPcYE0h6Ri170AOfbHRc9j37L9ZcRmWnNFY4vd76QU2WJeH7IFsYxeiqNsCIX154FYOThUZK51XqJYbNb+bsG7RO53Di91/7dzaRtmmkWKXFkA1HAFrqpfkmJdafIezdN0VunliEFyvXDTGpAeBIKf5cfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRbKWIlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92365C4CEE5;
	Wed,  5 Mar 2025 00:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741135900;
	bh=9hLWRXWxHLgq0kbJTo3u5KPKZDzNf27aFaVOmSfCS6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jRbKWIlxOVIP/x+HnMXnjXLp0DolUMW5VM94GaT2iXz5PUo+XY6JptSz2veWfuNXE
	 0gN6RZ4Y4Iu7k0txI1nOgDfPaxxfunK7nXTu/LWGhrG8EBrra9dx2wDRSLSOjJDDwg
	 P1iovwaEK8Y8qkfpDS9GFBrUFZlPEDvvS845mA6Ec9UcxZ4S1YOus3ujbD5UmCW5mU
	 fiYnXDNE0bZWk1KTWTc/bv4+U31GScQU50fPVaCM2IbD6nnqf06t30lQltznKKW+Kz
	 GGqeeytuDmjuXpSPAzmYzX6dTpZ3D4andDNQo7cKz4yax7JdaySFo0X3DIZfrpTbp9
	 lCcBAIwHTCiQA==
Date: Tue, 4 Mar 2025 16:51:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next v2 9/9] eth: bnxt: count xdp xmit packets
Message-ID: <20250304165138.4c0c0edb@kernel.org>
In-Reply-To: <CACKFLim64PEa=y2dchoq0QR_+sm7Bigr6H0CXB4UFQg8s0gnQQ@mail.gmail.com>
References: <20250228012534.3460918-1-kuba@kernel.org>
	<20250228012534.3460918-10-kuba@kernel.org>
	<CACKFLim64PEa=y2dchoq0QR_+sm7Bigr6H0CXB4UFQg8s0gnQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 14:48:05 -0800 Michael Chan wrote:
> > @@ -1134,6 +1137,8 @@ struct bnxt_tx_sw_stats {
> >         /* non-ethtool stats follow */
> >         u64                     tx_packets;
> >         u64                     tx_bytes;
> > +       u64                     xdp_packets; /* under rx syncp */
> > +       u64                     xdp_bytes;  /* under rx syncp */  
> 
> Why do we need different TX counters for XDP?  A TX ring is either for
> XDP or for regular TX.  It cannot be for both so why do we need
> separate counters?

No strong reason, felt cleaner given xdp is under a different lock.

