Return-Path: <netdev+bounces-130815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75AA98BA0F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F2E1C229B9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76381A01A1;
	Tue,  1 Oct 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZbf3QW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3519D09D;
	Tue,  1 Oct 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779820; cv=none; b=tGSQd1YXzFLI9xyS8QjTr7uBLM73lFyDei6Izzn6ppAX+7URNE4Uqmrp4eXrtxKR02lC0Gkn1A4beCl9mZLF5lD20cKG8Z+ulUCP8VMgiMq9qAuKG8kByFqZw8CikrVP5oamkhkjmLg15yCOJUT6mXPA9FUEczTi51h1dK0m2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779820; c=relaxed/simple;
	bh=n82QbT4D+Hou7BZb3ZZDWSX7M2VQuk0TBBZcS/uSaL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0QJ8mY7Jd3EpAJyiU/gOJHHCixpcLBs3cki5/I+rzzImfDDkGjl+BpVYVrrAKUeSmtwfnbLRPAAJEJiTGH42faelNbIYXFTZM0qJCpBIyc8QtOsYHC+2fQuY6tbfZsD+acDOZtooZBYsw9HRxGP3Ytl4bA+1JdQn9l8jnJH4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZbf3QW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286BDC4CEC6;
	Tue,  1 Oct 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727779820;
	bh=n82QbT4D+Hou7BZb3ZZDWSX7M2VQuk0TBBZcS/uSaL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZbf3QW25Y/i8G3VJXAJXcvM63CV6HkIF0awNCqYPrhbapeTA0fdROsjQOoCR/R6a
	 k8EkRcs7wx9dV7uLbIA4UGtZX1+MlZbg26eCB7BsoQ83+Bu/TAuiNhkvqw+Z0O6jug
	 YvYcacKVeaQ9qPKaeLyC1gFAvwyFKiB+RugYc2jD9XFDkVGQpdEftbst+k/ZoO+GEu
	 pQrDaWea7bJeOgPYYRPwM6UGVneD2EF7VCkIBIZQnjvoxLIDmijNJ3pvP/HUPh3zOv
	 7sWItD8FpsAc4X4nxIZAwharmRROOB4jd3bYGh3MyINYZJH1ZqzC3zPWjtDioaYRJU
	 6I0hcJOcPo7SQ==
Date: Tue, 1 Oct 2024 11:50:16 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v3 1/2] e1000e: Link NAPI instances to queues and IRQs
Message-ID: <20241001105016.GL1310185@kernel.org>
References: <20240930171232.1668-1-jdamato@fastly.com>
 <20240930171232.1668-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930171232.1668-2-jdamato@fastly.com>

On Mon, Sep 30, 2024 at 05:12:31PM +0000, Joe Damato wrote:
> Add support for netdev-genl, allowing users to query IRQ, NAPI, and queue
> information.
> 
> After this patch is applied, note the IRQs assigned to my NIC:
> 
> $ cat /proc/interrupts | grep ens | cut -f1 --delimiter=':'
>  50
>  51
>  52
> 
> While e1000e allocates 3 IRQs (RX, TX, and other), it looks like e1000e
> only has a single NAPI, so I've associated the NAPI with the RX IRQ (50
> on my system, seen above).
> 
> Note the output from the cli:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                        --dump napi-get --json='{"ifindex": 2}'
> [{'id': 145, 'ifindex': 2, 'irq': 50}]
> 
> This device supports only 1 rx and 1 tx queue. so querying that:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                        --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Simon Horman <horms@kernel.org>


