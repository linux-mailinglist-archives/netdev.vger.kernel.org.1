Return-Path: <netdev+bounces-231423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B710ABF92DD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 323FC4E43D6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35893292938;
	Tue, 21 Oct 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKxnu4tB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E2915CD74;
	Tue, 21 Oct 2025 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088068; cv=none; b=WdEFZglJ5i2rZzRaJLTVwYYb3lPmm8zbt1CPzMLMkyVmFvqGZm8Alxk4/Tu3owMGBJpwtjdp6MESe8Prndnn0RuoFr/2qicIuaN+0kbn5XMglznAOP6R4uTJ2z4VWST0KuFpBOVjpmHg8Ak8vxCHKJLsxoRcmmQsI5ruif8rn5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088068; c=relaxed/simple;
	bh=pyMV3cdwE0Pa3g75ct4gXzBftCoQzFcqhaO3cwgS6tU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYyn53uYhJPm6wc2gDQGZKJw+u3GQTYpMIvWgt+Ff768HARFFwC5XMECWzlVxkkVtObMVhwTIbH4XJUMbZqWGeltoqO2gUefcNdt1MS/Dk+qfzuwT5b36HpzzdS54WXHBlA7P8eHC7i+BJ1v+iMzqvzzN71vgOFo1BcmaQAmO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKxnu4tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE225C4CEFF;
	Tue, 21 Oct 2025 23:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761088067;
	bh=pyMV3cdwE0Pa3g75ct4gXzBftCoQzFcqhaO3cwgS6tU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qKxnu4tBvDWczzaNbMvL6MgO7srWwr2R2NWK6PQ29OXfBHnL0Q75w1gb+iIh06ldb
	 q9jnd7SL+AJc1RyM+V7OJogymmCcOo77oGK0CirceecroybbTZPjOJ9uy6W8pgiE1a
	 zb75gBm8GMSnkXB0VvCeueLXtBgKGIf6mKuT+XyUAIT6DUV0uh4CML1VPM20QqJrm0
	 ObBr7vdEhamOW5+93LG5opwSlhKO/b4FmQaVi0A+xhgq+enOS7/HMAgomNCYzpGU/X
	 Ho59UWkBFqmGnAj5AwUxMpkNCOiqrOJQufLjNDMVMIqH0cO9+kYMn+iNvKTVTee/IJ
	 CHupcw3yTd+0A==
Date: Tue, 21 Oct 2025 16:07:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, <netdev@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mohammad Heib
 <mheib@redhat.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v2 02/14] i40e: support generic devlink param
 "max_mac_per_vf"
Message-ID: <20251021160745.7ff31970@kernel.org>
In-Reply-To: <d39fc2bd-56bf-4c5b-99a2-398433238220@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
	<20251016-jk-iwl-next-2025-10-15-v2-2-ff3a390d9fc6@intel.com>
	<20251020182515.457ad11c@kernel.org>
	<d39fc2bd-56bf-4c5b-99a2-398433238220@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 13:39:27 -0700 Jacob Keller wrote:
> On 10/20/2025 6:25 PM, Jakub Kicinski wrote:
> > On Thu, 16 Oct 2025 23:08:31 -0700 Jacob Keller wrote:  
> >> - The configured value is a theoretical maximum. Hardware limits may
> >>   still prevent additional MAC addresses from being added, even if the
> >>   parameter allows it.  
> > 
> > Is "administrative policy" better than "theoretical max" ?
> 
> That could be a bit more accurate.
> 
> > Also -- should we be scanning the existing state to check if some VM
> > hasn't violated the new setting and error or at least return a extack
> > to the user to warn that the policy is not currently adhered to?  
> 
> My understanding here is that this enforces the VF to never go *above*
> this value, but its possible some other hardware restriction (i.e. out
> of filters) could prevent a VF from adding more filters even if the
> value is set higher.
> 
> Basically, this sets the maximum allowed number of filters, but doesn't
> guarantee that many filters are actually available, at least on X710
> where filters are a shared resource and we do not have a good mechanism
> to coordinate across PFs to confirm how many have been made available or
> reserved already. (Until firmware rejects adding a filter because
> resources are capped)
> 
> Thus, I don't think we need to scan to check anything here. VFs should
> be unable to exceed this limit, and thats checked on filter add.

Sorry, just to be clear -- this comment is independent on the comment
about "policy" vs "theoretical".

What if:
 - max is set to 4
 - VF 1 adds 4 filters
 - (some time later) user asks to decrease max to 2

The devlink param is CMODE_RUNTIME so I'm assuming it can be tweaked 
at any point in time.

We probably don't want to prevent lowering the max as admin has no way
to flush the filters. Either we don't let the knob be turned when SRIOV
is enabled or we should warn if some VF has more filters than the new
max?

