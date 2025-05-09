Return-Path: <netdev+bounces-189339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE2BAB1B8E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 19:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8E01C466EF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E4A239E91;
	Fri,  9 May 2025 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7G5iLCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96A22CBF6;
	Fri,  9 May 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811819; cv=none; b=Dez0emfn467879TcMhrWVUnYZy5vbCIoF110TZkzBbq19V/N+ChJb5Y1IJagV7AFt9KvPNr/IbZ/Sy42WZk8EPBlblIkADG+qS/vxs62lfLyhDwp8r41VcarjbebMIenbjeuTgC9V7EpURBR2DvQpwS2lYm6qg6C+22FywVubuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811819; c=relaxed/simple;
	bh=mW7Q4WOzI5YU1FYLOgmozqSQi3IAzhyUp6jsc2gvljI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSKfsrOPwMvd90r+WXKIYepS4apUtvi/XRx/qpc/1zE+GLgeoyhugSxa4jNqGqFn2GWW6mJ5IaDRGirpXsj4K6mIpudg3RVCXKnelf5+JQ0NY1pHy/QJObLkF/8ta2PI7IKt7B9l89qSuJX6Wn6txg1Zcl8IDidyRDx5f0xdgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7G5iLCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7BEC4CEE4;
	Fri,  9 May 2025 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746811818;
	bh=mW7Q4WOzI5YU1FYLOgmozqSQi3IAzhyUp6jsc2gvljI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7G5iLCmXAjHqnDymoGSMYCHKt0FGONZ2280C13jjahlcYvubNWIgN9NnDcCqdQnu
	 AEO58bEaRAqF14/wxZDzBySNJp3+LSN0Y74nNO7YDkmqh7EqPV2ge7s3dXT0BUhSaq
	 VGZLa6RVkWQv2g+dTRak/4qnig5LDJfO1RV6ibSJdYly7zm6+P0W4xbCfk5vZC+GzO
	 2m7mL+xResoyVFbcavHB6yjSJYO+FMm+HYOCMjo6ikq2vwh868xV2zec2bzWmTz+D3
	 0nYEDHor6jzucViInfWQJ32KQ6OdKkkEzpLZt2R+zg3SKxemCNK26WyuLt8ELwxxad
	 7iqtTUsTqya+w==
Date: Fri, 9 May 2025 18:30:14 +0100
From: Simon Horman <horms@kernel.org>
To: Ozgur Kara <ozgur@goosey.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ethernet: Fixe issue in nvmem_get_mac_address()
 where invalid mac addresses
Message-ID: <20250509173014.GQ3339421@horms.kernel.org>
References: <01100196adabd19e-0056f10b-0ffb-4076-8a6b-779f87c327b6-000000@eu-north-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01100196adabd19e-0056f10b-0ffb-4076-8a6b-779f87c327b6-000000@eu-north-1.amazonses.com>

On Thu, May 08, 2025 at 02:14:00AM +0000, Ozgur Kara wrote:
> From: Ozgur Karatas <ozgur@goosey.org>
> 
> it's necessary to log error returned from
> fwnode_property_read_u8_array because there is no detailed information
> when addr returns an invalid mac address.

Maybe "useful" would be better wording than "necessary".
Logging doesn't seem to be a hard requirement to me.

Moreover, I'm not sure that logging is appropriate.
E.g. fwnode_get_mac_addr() is called by fwnode_get_mac_address(),
which is in turn called by acpi_get_mac_address(), which logs if call
fails.

> kfree(mac) should actually be marked as kfree((void *)mac) because mac
> pointer is of type const void * and type conversion is required so
> data returned from nvmem_cell_read() is of same type.

It seems to me that nvmem_cell_read returns void *.
So a good approach would be to change type of mac to void *.
In any case I don't think casting away const is the right approach;
what is the point of const if it is selectively ignored?

Also, I think this should be a separate patch to the logging change:
one patch per issue. If there is more than one patch then I would
suggest collecting them together in a patch-set with a cover letter.

> 
> This patch fixes the issue in nvmem_get_mac_address() where invalid
> mac addresses could be read due to improper error handling.

I don't see any changes to the program flow for error handling in this patch.
It doesn't seem like a fix to me.

> 
> Signed-off-by: Ozgur Karatas <ozgur@goosey.org>

-- 
pw-bot: changes-requested

