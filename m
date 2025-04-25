Return-Path: <netdev+bounces-186049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88EA9CE73
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 18:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F14A3AB2CE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E69E1B423E;
	Fri, 25 Apr 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4Rp+tDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749441AA1FE;
	Fri, 25 Apr 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599517; cv=none; b=HlaJtZugXJP/MAmZTSiG+UNrOQvn3106IxITBVxEGtBq1y2ZyWRTdKYyN3K4NLdpZYshAC/ZXVf7Irenpw3NtR5FjTdA0s98b3qI+lJn9oHzGfIQ0vc54GVU4+jDUqPQ1Xjkh4BPR01dmZZxtz4uGRreK0MgkX7xf0RAvo3dJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599517; c=relaxed/simple;
	bh=Wow6JQPfakyrFETVMOiqJ/ZVDU/bPHWIfEcPRk1RCTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLP0KMJwg+tcmN1s+9RxUlydPf17nNp5wUm3mjW9ktoSQ+fqV8BpG8mxXBHHnvybqeG8kFR1AT4Fw5m+gnflyr0/z0vQ0VN5asIlWrAjZq/sB3VUIoFkvwbFn4IxZPAki1qGEZ4TSs7FjxX1jqny+fjFVuMQ/O7XrvEnjgvdyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4Rp+tDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37E6C4CEE4;
	Fri, 25 Apr 2025 16:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745599514;
	bh=Wow6JQPfakyrFETVMOiqJ/ZVDU/bPHWIfEcPRk1RCTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4Rp+tDLxBpVeOUQg9/LnPyijQ+57i3HXJfngMCferBEuKAmb2TebW7oYqpB2AmGz
	 gcyxEijR4YBZhU6+2qiV8GawHaRZuVWqqlHHxmfu4PPwH7EQ70L7Ntwv/en0vgWDdq
	 qafvcAf14Kt8Mz70/rZeLjOhjbsv1UGeU4Nb/kS6abjrcx+LM0ao2hyyck/DdS4HwY
	 A1DTL8D6zwr1PxN2AtTIS7pFNP9rfwzfVgUjc5CZJB6FwlbNKhmGgVXBkc1vEXgRQs
	 iCzKGSClsUct73ydEWohviqpQvzjhMcjd9TiUnsvVrJSZnGWmV7jwIxomS9eh4ivE7
	 yFGEAOsj8I1nA==
Date: Fri, 25 Apr 2025 17:45:10 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: disregard NVM checksum on tgp when valid
 checksum mask is not set
Message-ID: <20250425164510.GP3042781@horms.kernel.org>
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
 <20250424162444.GH3042781@horms.kernel.org>
 <dc357533-f7e3-49fc-9a27-4554eb46fd43@jacekk.info>
 <20250424171856.GK3042781@horms.kernel.org>
 <2a80cde6-27d4-46f2-8ad0-b7feefd4764c@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a80cde6-27d4-46f2-8ad0-b7feefd4764c@jacekk.info>

On Thu, Apr 24, 2025 at 07:37:26PM +0200, Jacek Kowalski wrote:
> > Although I do wonder if commit 4051f68318ca9 is backported,
> > will this patch (once accepted) end up being backported far enough?
> 
> Stable 5.10 (and newer) already has 4051f68318ca9 and ffd24fa2fcc7:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/ethernet/intel/e1000e/ich8lan.c?h=linux-5.10.y#n4139
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/ethernet/intel/e1000e/ich8lan.c?h=linux-5.10.y&id=8f1e3ad9456935f538c4ba06d2c04f2581ec385f
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/ethernet/intel/e1000e/ich8lan.c?h=linux-5.10.y&id=eb5e444fe37d467e54d2945c1293f311ce782f67
> 
> In my opinion my patch should be backported as well.

Yes, I agree.

