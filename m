Return-Path: <netdev+bounces-190985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D836AB9938
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBCB504696
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88931231847;
	Fri, 16 May 2025 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhboFUdo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A8231836;
	Fri, 16 May 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388728; cv=none; b=nPxj79JKppEJHBicTwAe/4Z0/IWF+LOL8fC1rdWYCN4pvpZiZeQLqhOr4ayogktSM8rjgCuezlFmbAEthk4pQzI5KJV/8keLKvyWLR/HLe5crqwPFzuja8UqFw5xzHnDv0RZ3XdeOxcUhsJ+n5u4MnOdAS4FQ6EFvCHCfXWSNNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388728; c=relaxed/simple;
	bh=e7yeGEXq5WaeIQNIW/XccMU2VpxH4/y2FhBYeVBRQOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu2dFgBQOzSsytTGfXpWkj1uwOve+ldS9GP6XyyWK3kOycTAyigJCA/Uf3qBHzHtCtlyBDg6FUjLRXuNviqklZXWe3V240C6QeDluCLi1zrtn+HRwEjYyW8haoK52eIFukSHXDJ5OcMQ0yswhrKgYwaPmAX2NGM2TkLi1wuFAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhboFUdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F82C4CEE4;
	Fri, 16 May 2025 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747388727;
	bh=e7yeGEXq5WaeIQNIW/XccMU2VpxH4/y2FhBYeVBRQOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhboFUdoo1SKe0onXbXMqjUq/0n3vJPyHaXVBFWy/EXuNA6OA4D4i1g9SUe8vuBU6
	 3um4des1zzGAkv3wZBrhBIZ45Xz8OqQoEfBBs0iMEq/YV+bzanYe9sOhStjD23D7yi
	 mFHbiORuReuH3VtgTV6WakEvr7YFBXzQR/l+5VwJ+oeuZXJhyBy808H0AY9YxnBftF
	 eeKadRTRcKa3tRxRo7PAQ6R6olrpYlb1KYy9OREmCu5hHwVdNL3cf4CLfcAqlRI46L
	 ePg3NzhqatwTVveecTU0aeeT9blYsP+ZI+EjUqNAYP2QoD5wdCyULuXJ+pG2v/Pe4C
	 J1LaHCLQYzlFQ==
Date: Fri, 16 May 2025 10:45:23 +0100
From: Simon Horman <horms@kernel.org>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: Re: [PATCH iwl-next v2 5/8] igc: add private flag to reverse TX
 queue priority in TSN mode
Message-ID: <20250516094523.GM1898636@horms.kernel.org>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
 <20250514042945.2685273-6-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514042945.2685273-6-faizal.abdul.rahim@linux.intel.com>

On Wed, May 14, 2025 at 12:29:42AM -0400, Faizal Rahim wrote:
> By default, igc assigns TX hw queue 0 the highest priority and queue 3
> the lowest. This is opposite of most NICs, where TX hw queue 3 has the
> highest priority and queue 0 the lowest.

...

> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


