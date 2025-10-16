Return-Path: <netdev+bounces-230202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 32553BE5475
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1A2F3592EE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA5428E571;
	Thu, 16 Oct 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDMMjER2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512F1A9F83
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644150; cv=none; b=QHZcW9fAhire3pQDYi3sCGw/Qn2/cOnBjiVrhGqmRavWaYUUnu7+tjsaHNOdgqIE2m4nYv23RbffE96rXpEcn97gR+Cvs28waNau3VPoYR1YeO+FdrbcdgBkSWcANy32aI37/zn1jL+ewOQCMAamwQez1hSAwuFaItV5W3qbxaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644150; c=relaxed/simple;
	bh=3rIyLJ6m1xES1cMpV+PoF9iUemm/uAax2YAU6H4WgLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trxZTZvO5Y73Vl2YNfvSVEFo/fKPswNf62JALO5aB4BnndpzC3ZwId7L2jFaI7ipnR+DLN4BP1uYUA1c+Dy8CgO/DTmRpc01/sl5iBfVezxeRLoPkwR9H4ZWc+BUyLf9Ee1MuehtqRlq65cQr87UR7VGUA0/LcJsFE7rGxmEUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDMMjER2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272B0C4CEF1;
	Thu, 16 Oct 2025 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760644149;
	bh=3rIyLJ6m1xES1cMpV+PoF9iUemm/uAax2YAU6H4WgLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nDMMjER2iHcxRYJZ1I1F5pTXd85RpeEX50RXiH6k4Q5+xyRRdFsLrSqsCMKjXUNhN
	 6SOEG87jDhg4WgrntNjjRjPljlQK75moe9nSOZkbxgKCgTguzWxhGH9iJNUwYxS+aH
	 8U5yP7XWSq+JMYYT8QQcgFUK416Sd/PwDRWVIc9jhK9qzkeJQQdCpXHcGxvap1VjKv
	 QLo8cpzFrJM0xFcEnjDsQ3BbiZKZoKQdMRU7QYSc2Q7p9KZQie8173pr+BEDAx2Xvd
	 cXn/2rMQ6uHiljvsb30lDx8eyGiwqV1vby0KdXpa9+8u3apV/DzfyFvDbaTvb0t1m4
	 p6BM3i5ULnqZg==
Date: Thu, 16 Oct 2025 12:49:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org,
 jv@jvosburgh.net, pradeep@us.ibm.com, i.maximets@ovn.org,
 amorenoz@redhat.com, haliu@redhat.com, stephen@networkplumber.org,
 horms@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v13 6/7] bonding: Update for extended
 arp_ip_target format.
Message-ID: <20251016124908.759bbb63@kernel.org>
In-Reply-To: <ef443366-f841-4a84-9409-818fc31b2c0c@redhat.com>
References: <20251013235328.1289410-1-wilder@us.ibm.com>
	<20251013235328.1289410-7-wilder@us.ibm.com>
	<ef443366-f841-4a84-9409-818fc31b2c0c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 13:50:52 +0200 Paolo Abeni wrote:
> > +		if (nla_put(skb, i, size, &data))
> > +			goto nla_put_failure;
> >  	}
> >  
> >  	if (targets_added)  
> 
> I guess you should update bond_get_size() accordingly???
> 
> Also changing the binary layout of an existing NL type does not feel
> safe. @Jakub: is that something we can safely allow?

In general extending attributes is fine, but going from a scalar 
to a struct is questionable. YNL for example will not allow it.

I haven't looked at the series more closely until now.

Why are there multiple vlan tags per target?

Is this configuration really something we should support in the kernel?
IDK how much we should push "OvS-compatibility" into other parts of the
stack. If user knows that they have to apply this funny configuration
on the bond maybe they should just arp from user space?

