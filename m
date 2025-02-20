Return-Path: <netdev+bounces-168167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A38BA3DD8A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8D73B3425
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D841D54FE;
	Thu, 20 Feb 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A87R7E0Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD811CEAC3;
	Thu, 20 Feb 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063528; cv=none; b=CyE/gVIO4GLsL1xWRk0ws1HG0f3TP/qQjtnlW6fgso8Gzaz4rU3uq4nNCHcc73BJkO8CXRX9HE09HXJxBp05GbZlj7h8sO3fImFv+BT4tISVa7LKJhqui6dvarCAF4ZJVOLfkxk93fGYtZ0tw3c7Kpkq0teU3Wr2T6lbqpAgZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063528; c=relaxed/simple;
	bh=c7HIeEgMPymcUcuYz3GOcnJXu3nu0vfO8rhi1Vc1mE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hArQ3jphoymH2cZbbqZCNQWbXo4scFCiTy9f0lTOn3VCDgsC8Y+que/l5YLdd1TJVt+53jwe6VYeCl5mYVf4hTs6AoW0uNjd0HDv8qSejLOpT+kvZ6rOv3ZvIT+i7EBHNAfz2+9gVRI2r6PK43fL6Q5sfGrolNX9xycnmXGP1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A87R7E0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56260C4CEDD;
	Thu, 20 Feb 2025 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063527;
	bh=c7HIeEgMPymcUcuYz3GOcnJXu3nu0vfO8rhi1Vc1mE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A87R7E0Z+4G+OLBFHiyrxfV82fZS5t7k0Clurbj/+Hyuq+cRJG4bRXyDepsuIyMcu
	 Fqo7BcDv2unOGoiPkXWhM+TT8fsMY+Izzn5/9IQu7O/9aAkwdDvEiK7VrUT/tZZuVA
	 rPxsVv7dnyB7VP0lwNH1/fOq5IvKXZOKW3rrhHlarFKUKHLH9EtEyEeTimweCtcLJa
	 sX7tGDkVz7kTOX6qK7ZRm1R3SyLU43wIH+GJl/ZyD3pKVUN+RG9rS1DDc2SMBbL9kW
	 zlxqIqB99mikUTCoHSCY7ABbCjrAacaoyP4D2lvQvVCADyKGzY3Ci60Dj5htUIwz29
	 YhCMw0elMce1w==
Date: Thu, 20 Feb 2025 14:58:43 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: Re: [PATCH iwl-next v4 5/6] ice: support egress drop rules on PF
Message-ID: <20250220145843.GC1615191@kernel.org>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
 <20250214085215.2846063-6-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214085215.2846063-6-larysa.zaremba@intel.com>

On Fri, Feb 14, 2025 at 09:50:39AM +0100, Larysa Zaremba wrote:
> tc clsact qdisc allows us to add offloaded egress rules with commands such
> as the following one:
> 
> tc filter add dev <ifname> egress protocol lldp flower skip_sw action drop
> 
> Support the egress rule drop action when added to PF, with a few caveats:
> * in switchdev mode, all PF traffic has to go uplink with an exception for
>   LLDP that can be delegated to a single VSI at a time
> * in legacy mode, we cannot delegate LLDP functionality to another VSI, so
>   such packets from PF should not be blocked.
> 
> Also, simplify the rule direction logic, it was previously derived from
> actions, but actually can be inherited from the tc block (and flipped in
> case of port representors).
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


