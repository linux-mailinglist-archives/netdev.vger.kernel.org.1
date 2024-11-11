Return-Path: <netdev+bounces-143803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1BE9C4430
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8FFB26B23
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DB71A76D5;
	Mon, 11 Nov 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kApQqBjb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD621BC9EC;
	Mon, 11 Nov 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347333; cv=none; b=DgrtunnCkxHOedOGiyYRp9p+j9pZsCGfCsTcdT5IlbttWp2cFZjqMhTI7nhSzzxZ+2q1CSAgZN7ftvItEoiR4pFUQYrONQXDEs7BWMIr5MJ98UhGcDmlbU0akRwTKIO3//N3AjvLbI0G86n9ElvWUoRv3LlqfesHmbgEfatgRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347333; c=relaxed/simple;
	bh=/8HoIU4UAnAKhMvR/WUlr+X2oei2/XjEowz8UAFduJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDNBw5hk5Fazdj5LhkJHy5IOVKAK2cNDGk8AtHD8++VakY8Tl9lJWpsO0y4tlCvgAGL866JrJV/GAV7EWCg4MVifwZARevmTPPezF8hQicbaEUMeLvxKp4+mSCC4y0TnUaNBGWeCZpQfGl4VdVtP/Iq+FOB7lP+dzR432GTgfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kApQqBjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8352C4CED4;
	Mon, 11 Nov 2024 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347332;
	bh=/8HoIU4UAnAKhMvR/WUlr+X2oei2/XjEowz8UAFduJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kApQqBjbziZW1nioWWoTY8oBcIoybMyiUfREPWnGKUA/DrtwnUNOQbmrOIT1r39mW
	 2B720sUpy49FUzBmeqMNtoV2/k1KLfL9p1SVCTPL5JGMNnlcPT74zqIhiBXJk9vr74
	 NiL2Cme5WGokgSSXUbDOXZZ9fUR52YpzouPThrA05ufrVxfSCwiCKM5+0jjHwxupHY
	 3wSY4F7TrHTu02+nTBpSX5I7k5IZAFRgzffTUoXiWCvaimrvLD4dCWeCPqr3RaUZjB
	 qcWzT+uE85mDlK1IxuL3k4qskKZ+fQgTGj4oS1AAud2kaywDnGFmEnlnLmrRVXBo8E
	 f8EwD8nC52u5w==
Date: Mon, 11 Nov 2024 17:48:48 +0000
From: Simon Horman <horms@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/7] enic: Adjust used MSI-X
 wq/rq/cq/interrupt resources in a more robust way
Message-ID: <20241111174848.GI4507@kernel.org>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
 <20241108-remove_vic_resource_limits-v3-5-3ba8123bcffc@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-remove_vic_resource_limits-v3-5-3ba8123bcffc@cisco.com>

On Fri, Nov 08, 2024 at 09:47:51PM +0000, Nelson Escobar wrote:
> Instead of failing to use MSI-X if resources aren't configured exactly
> right, use the resources we do have.  Since we could start using large
> numbers of rq resources, we do limit the rq count to what
> netif_get_num_default_rss_queues() recommends.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>

Reviewed-by: Simon Horman <horms@kernel.org>


