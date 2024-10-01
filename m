Return-Path: <netdev+bounces-130816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5064998BA1B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B6D1F226E4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53321BD02F;
	Tue,  1 Oct 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo90k86+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE81A0AE4;
	Tue,  1 Oct 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779845; cv=none; b=iQVjHssR223KaPJuU/VrRwkT1bfaz8z8KlOaESbpbvxqB1/xn2FQx2lf7h+I7w8dCdGVX68rIK30i3xAfzPR+1L8Rzc0ngLBEWfh1t4IHoWfRAYFHUNkokks+A/dVIibloWDZqRwiSUIj4BAxWAgEn/XdsnGtkOCO/YyS/0FjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779845; c=relaxed/simple;
	bh=7cExMTorNUc1Uux7+jnxV9kavMLQzVbcPKBnRWiPrBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpgahnXvVYFBri+6ekJNPPpGod9LajM6nw0mx0y9TbrbO/+JUIR6KzBR/na9Zc6Ji5IOFAxsqhfD7jPimrlUoH4tlcg7rV4Gr20xhvpcm6nrlW0D2tPnovEIgFwOjvGU/uEU3hY21EvalHAOr+ccR6k+tEasGhQ7ekUd87SjURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo90k86+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CF5C4CEC6;
	Tue,  1 Oct 2024 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727779844;
	bh=7cExMTorNUc1Uux7+jnxV9kavMLQzVbcPKBnRWiPrBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wo90k86+jsYQ1lZc1+qSLOG5yLZzed4XviptbpfkZvL2/8xI/2h7rTQRZE3SaKTk4
	 o925c46IkVP/8c7on1RNbohQgvcQDm+eFJB6R7BklNFtSs+Bt/scqR325qyGbfnnel
	 3QkNy0mY3oVTMkPhCu4PiXDqgIhRMBQUXEoYmP+JvbwEF/ThGXRHMkGltsuf1ojH+P
	 XHhsZwvv7FexGHfm/r23uxh/Jk4T3yVMTgPPZ1ctIc9Xv+t4xyflSECv8kCBsGm3lU
	 /sQX/M+WgLEY1ladLfCpNplYGWB3QNbROESlGnip4MQIt/JyFApXsppF/Jbbc8ud5+
	 Ji1f63xfeMMPw==
Date: Tue, 1 Oct 2024 11:50:41 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v3 2/2] e1000: Link NAPI instances to queues and IRQs
Message-ID: <20241001105041.GM1310185@kernel.org>
References: <20240930171232.1668-1-jdamato@fastly.com>
 <20240930171232.1668-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930171232.1668-3-jdamato@fastly.com>

On Mon, Sep 30, 2024 at 05:12:32PM +0000, Joe Damato wrote:
> Add support for netdev-genl, allowing users to query IRQ, NAPI, and queue
> information.
> 
> After this patch is applied, note the IRQ assigned to my NIC:
> 
> $ cat /proc/interrupts | grep enp0s8 | cut -f1 --delimiter=':'
>  18
> 
> Note the output from the cli:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump napi-get --json='{"ifindex": 2}'
> [{'id': 513, 'ifindex': 2, 'irq': 18}]
> 
> This device supports only 1 rx and 1 tx queue, so querying that:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 513, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 513, 'type': 'tx'}]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Simon Horman <horms@kernel.org>


