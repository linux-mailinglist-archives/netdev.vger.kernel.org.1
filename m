Return-Path: <netdev+bounces-199703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8983CAE184C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B945A7440
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABC1284662;
	Fri, 20 Jun 2025 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6r0VJoz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165ED283FDA
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413018; cv=none; b=tbaNY3VPudNcZFJwF27f8irDJCPDdY8qzX9MnyNTOk+eqKTiK6lGDswy3yv3iy8F9A575zRL8DbUWftYZZCB7qtlkDk2N0qADXxyZxfcY3vrLDU+6t2/c/x6MNoW9N2RsC9Aw6y3+qTWf4ng7a/X58mWbSBhiW+PeE6WV0sE05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413018; c=relaxed/simple;
	bh=3gseqlGUY8/NVFfrCKcSoucr2xXagpRMRwCOKivEyT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh+jKsVBempiycqL5jf/XkMPUaWknlyTYClVdEK9ndNQYN+6FnYDibdvYTcOtnSdyfc4fhVAX7/TIetmsdLKeKxd/sg+naa1iD3y5IyHqiKl5HaHdzZGB9M5lkTNSC0nQUb9ypje4ZkqUqErM3yPcqIwUoB91NiOoR9O7NKyaoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6r0VJoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E21BC4CEE3;
	Fri, 20 Jun 2025 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750413018;
	bh=3gseqlGUY8/NVFfrCKcSoucr2xXagpRMRwCOKivEyT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6r0VJoziKRjOCdlIBHTn6I0wVG8czxjwBr0KG60edKf2166+h/ct5Q55yWj8MWM2
	 B2qxShKr/KiOMJvnSkdmtGui1RBGN0Hi6TjDhccndBpI+TpvHrsMaE0PsjvcykheXY
	 EbWwW7EZ6hYjd5QQzUlQjbgYlb9+aMBmQRVtcx17AK7AnXsPJmoszx6uy/IYyz5Krk
	 UvCziB1OuG04mgrMi1oDgeGkOzC0EkRXonETlYjQt6mKt7/30JBdm2VmT+NJXMnRxi
	 90llcpBnV1l4qACfZZdUuM9JIERU6QI9FKxOQ4+s6RCntEU5q5iR8A0RZo34eAX+k7
	 ZT3OXbddTvD9w==
Date: Fri, 20 Jun 2025 10:50:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, shenjian15@huawei.com,
	salil.mehta@huawei.com, shaojijie@huawei.com, cai.huoqing@linux.dev,
	saeedm@nvidia.com, tariqt@nvidia.com, louis.peens@corigine.com,
	mbloch@nvidia.com, manishc@marvell.com, ecree.xilinx@gmail.com,
	joe@dama.to
Subject: Re: [PATCH net-next 10/10] net: ethtool: don't mux RXFH via rxnfc
 callbacks
Message-ID: <20250620095012.GD194429@horms.kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
 <20250618203823.1336156-11-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618203823.1336156-11-kuba@kernel.org>

On Wed, Jun 18, 2025 at 01:38:23PM -0700, Jakub Kicinski wrote:
> All drivers have been converted. Stop using the rxnfc fallbacks
> for Rx Flow Hashing configuration.
> 
> Joe pointed out in earlier review that in ethtool_set_rxfh()
> we need both .get_rxnfc and .get_rxfh_fields, because we need
> both the ring count and flow hashing (because we call
> ethtool_check_flow_types()). IOW the existing check added
> for transitioning drivers was buggy.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


