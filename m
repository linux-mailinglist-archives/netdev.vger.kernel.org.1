Return-Path: <netdev+bounces-189425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34DAB2098
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 02:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750C51B66910
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299C42192F5;
	Sat, 10 May 2025 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3g/f73Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05322A94F
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 00:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746837759; cv=none; b=JtPMbbo4nFiUHCeMQqeg7Tpqx74qifHmnYb3w4XciUZieMTT5xhO1+SabHEs2rY4AmOHcy9R4wo3MHwOpo89MtI7GrD3a6DbFZWKCZoetSAIcI2pCES/qo4PbfxFbCsl7F9B3j5JF6FkDeM/lmj8HTMMTVrfHa8zxQoye9y1h9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746837759; c=relaxed/simple;
	bh=HY4fqV6nPlvADvdFHsNZI1APniYRWKH0YzgH4MfPh88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTIUhgB2qzAS0JKidbxHyUrQOylqOJOjGqEHKvOsLd/eQYLD3alPwjMBRbJYalqdVTZDLWqGOpX4HSMhS7Ndu+btfkh5vGjGhqVTXOrUyayCVewwRcHxSC9BCwpuMCnsh/j0xGImTjxm7GFJtOZoVm+unGBbmlVrcGo0M4a3FrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3g/f73Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279BBC4CEE4;
	Sat, 10 May 2025 00:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746837758;
	bh=HY4fqV6nPlvADvdFHsNZI1APniYRWKH0YzgH4MfPh88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c3g/f73YhDPpLxhpwG0wamGT+qPbbp2YAK22SK+v7v60yJeBk1IbMCo//qhRTMaeP
	 e+9X5GECwZwj88Uk34UoaR4K2qFZssGcLUVNkquHi2xVTh6G7emzrKpRJHKd/eAIqe
	 H53UpWGtSHkYLfbWBvsLBAmFEd3ca0lxC3IRs8od3F576NgZ5sFOjjhtZB8fmRThRQ
	 XlOZRfN34iL/1REsHPwVDbGh718y4nBA5s2l3tjPMJmtdaWOo/7uCDwIQadgiWDgI9
	 3zycDqKhy2FcizDcDe5X3Z1ezOqsRZLHWYT64H7UfYJBhJhsMGLts8cxvVCwuRXMnX
	 y7xkjrKNGPkyw==
Date: Fri, 9 May 2025 17:42:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David J Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
 pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
 haliu@redhat.com
Subject: Re: [PATCH net-next v1 2/2] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <20250509174237.6e297577@kernel.org>
In-Reply-To: <20250508183014.2554525-3-wilder@us.ibm.com>
References: <20250508183014.2554525-1-wilder@us.ibm.com>
	<20250508183014.2554525-3-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 May 2025 11:29:29 -0700 David J Wilder wrote:
> This change extends the "arp_ip_target" parameter format to allow for a
> list of vlan tags to be included for each arp target. This new list of
> tags is optional and may be omitted to preserve the current format and
> process of gathering tags.  When provided the list of tags circumvents
> the process of gathering tags by using the supplied list. An empty list
> can be provided to simply skip the process of gathering tags.

drivers/net/bonding/bond_main.c:6126:55: warning: Using plain integer as NULL pointer
drivers/net/bonding/bond_main.c:6159: warning: No description found for return value of 'arp_ip_target_opt_parse'
-- 
pw-bot: cr

