Return-Path: <netdev+bounces-176964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE76A6D022
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B34D1885CB7
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A913C689;
	Sun, 23 Mar 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWSeRnGg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D435893
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742748830; cv=none; b=rVSSQkmkDr+bbZofkHD+GMoztRQz4/KaGFQvw7uXGW12JI4QFkRgSPMIKYib/X7yKx9Sbq3MKcTgBYu94e0Pxz5S+T1wVYARkj0C42MlS5/55BUwVEQLsmaiNmLGY4hA4LNFhk/IoCgRkq/xjXIbmpACc8W3pAl1djagKigXIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742748830; c=relaxed/simple;
	bh=FQHrLpe1heNBZ7ovfW2w/wuecLHQdWzjb611CA1ILak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxJ8xjnvLM4zwDV5hZoPkbbvt5Sbu77lfbQjqdRw4Jd5zGPVtWhYBYcj8fjwWqdthmzVlBsPthLx1YNCrLMhY1DgtJ87V7SQwAMvvx/uqDboI//4ZfrPc4O4vUAgZtMu7BOYipDWD3HLiMe2B0RRMX4SZoJseamPvfclu1QPm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWSeRnGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07824C4CEE2;
	Sun, 23 Mar 2025 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742748830;
	bh=FQHrLpe1heNBZ7ovfW2w/wuecLHQdWzjb611CA1ILak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWSeRnGgDZoa+FD2Jftwn6ddLmXFu3Jerwphx/0OhnscY6XARxNxvxXcqlQXzQ7xF
	 FcYrNXbtk0ImF24O+5p22ihIzNQHxzG0bVcX3Gi+ezG8fkczRsjJz1C/5y9xIWbMQx
	 GnAgOxxBYmkIlnjBZerNKmjNggo+i1b49LrPiq/R1NJGAvqFNaqiJaBtVtmyNv20z5
	 7S1jr7lFyiejzAm/UZS/dp1KTeIXZbck9camtxLVqCtY4hhosfkPPo4bX5jeQP/4Bq
	 NjJ/hm0drOA/cMzkC1qYlzmYo0DjLRz4BZHvmAVFXYpwkhjJNbEm0p351XmSwa93NV
	 YkakNHneLlVrw==
Date: Sun, 23 Mar 2025 16:53:45 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] ipv6: fix _DEVADD() and _DEVUPD() macros
Message-ID: <20250323165345.GS892515@horms.kernel.org>
References: <20250319212516.2385451-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319212516.2385451-1-edumazet@google.com>

On Wed, Mar 19, 2025 at 09:25:16PM +0000, Eric Dumazet wrote:
> ip6_rcv_core() is using:
> 
> 	__IP6_ADD_STATS(net, idev,
> 			IPSTATS_MIB_NOECTPKTS +
> 				(ipv6_get_dsfield(hdr) & INET_ECN_MASK),
> 			max_t(unsigned short, 1, skb_shinfo(skb)->gso_segs));
> 
> This is currently evaluating both expressions twice.
> 
> Fix _DEVADD() and _DEVUPD() macros to evaluate their arguments once.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


