Return-Path: <netdev+bounces-156196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74674A0573E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD327A130B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF21B3938;
	Wed,  8 Jan 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQVUXubq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274719D8B7
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329480; cv=none; b=TgCYS3HSM4Vv2XaCHPK1XDdVLZpa+jfFTnEtLXoBltucf49OHsTqlbghUaPj6ZHM8SaQJ1eH0hbtjcxEf50QDFJNTn4gGKDJM7460un6GStwJltNDglL6f6i7m44WmkDlV1ztBh7mbpt3AsF3ArDnMPtFpdg961bG2hoJArlWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329480; c=relaxed/simple;
	bh=WgOqo56rYew6iEUDuzafyPugMgfU6khxfZtwwCMLXJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYuOAk3MczhWdhJy3LF/8yYlP42Xlpk30CB1NfhOe4t5I1ZPlGuxmapmo3cx5HFR+bx8xy04IZWSu6rVa8e+cvEC+IxV98VFosgwbPK8fVpx5nAMmc+vx2B9xUt3SR/p9tzOuv8zoUKGn3OoWVIAC80Fs4860P463TlpgqrZ9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQVUXubq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89847C4CEE0;
	Wed,  8 Jan 2025 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736329479;
	bh=WgOqo56rYew6iEUDuzafyPugMgfU6khxfZtwwCMLXJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQVUXubqKmqnRukOLIkr4kPA01eHXHE6TWVPt4/RNOOpXSfKyQGYdiBAcPvc41b5T
	 4RAbqAPW5XKjUrizu8kuEFhmiOKo/eRsBLqTyr/zVVdipSddfHPfyox1RyTCYqBrIb
	 0tbXTkb/pkxrxy++5h4bo2w0sDFq8NG4iGZVGQf+tNEzP43F8wQz/g1Ldl3xxmwxHT
	 OUb7slihbDsIretynfv7wVto3ICrbCYC7ORNYRQwT2YdR/CzbDbqDdU6gmP07ir68r
	 Un+PYxd++03EMOK47sLVMiAQQ9YPR7e26Z7oD3sKr8rHtcAm+I4AUQnkHWtpUL5ULo
	 eOPox89CasoOg==
Date: Wed, 8 Jan 2025 09:44:36 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: hsr: remove synchronize_rcu() from
 hsr_add_port()
Message-ID: <20250108094436.GF2772@kernel.org>
References: <20250107144701.503884-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107144701.503884-1-edumazet@google.com>

On Tue, Jan 07, 2025 at 02:47:01PM +0000, Eric Dumazet wrote:
> A synchronize_rcu() was added by mistake in commit
> c5a759117210 ("net/hsr: Use list_head (and rcu) instead
> of array for slave devices.")
> 
> RCU does not mandate to observe a grace period after
> list_add_tail_rcu().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


