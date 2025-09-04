Return-Path: <netdev+bounces-219767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F90B42E70
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740CA7C1C70
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37537E105;
	Thu,  4 Sep 2025 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKiEbgM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80B14A9B
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947075; cv=none; b=V40tIGIrXFRKvNExuRYJgq29qf4WPRlN3Dt9UzvQG22NHw7acU8OTQ/i27RUqIf8rEItejtT1VposvhE2iiwA2sXdGV3/ek2H8OUKqXNblqINtZAlHYYFLORNqRp4VFdRZJUB+ACQakuom13paMNvukBACRgzLXwP86z/JzPo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947075; c=relaxed/simple;
	bh=z1xGXwrZTJ2PweA+MV763yDyHqlYz5EUgajJtYqIbF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ks4YxyTGPMrGFGyuY5SBAN85JfDPXMiS+tQEoMgQSn9nk5bD+lD7mG2XDT7Y8w7iBfaB/jI/1yGinV2645t/++h9IUUCAJIIqcm/W+Gr1Jh73ULvl7qCIrMNDzdprTWHB7xHJljcVDSA/pzD9vN/Dr/yfa7aVWasM2rBHkGMnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKiEbgM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A35C4CEE7;
	Thu,  4 Sep 2025 00:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756947075;
	bh=z1xGXwrZTJ2PweA+MV763yDyHqlYz5EUgajJtYqIbF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PKiEbgM3VAQjc8rOcPVMdcEq151G6oK91i03m/JWVQd5qHGQfZ+D9eXwdwW8YMx6h
	 oDzNZR0XoWaCMU/k/SDEle1uzuEt1m0kqzNhqIoV7hV8mYClD4I2iYhpGhBux7ngj4
	 N8m7O1JQijMcSXmAqC3mUCdU7hahGPUDIiP9cDMCun8WNt6AmncGOI0EUqdwiAYbcc
	 cfbXXx1fTqdf/thfmG+cQp+908YhINWwYH9IvAs81iN0eyHs+tn8+XT7TQAAo0PsxT
	 cbaJYrHPx0r44szVNGYJ96Nx+l78VsrhhlQc2EwbR6XE9Jg4sNDUgfheXUtURCV/i+
	 ibpXqM4Py28Pw==
Date: Wed, 3 Sep 2025 17:51:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
 pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
 haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: Re: [PATCH net-next v9 4/7] bonding: Processing extended
 arp_ip_target from user space.
Message-ID: <20250903175109.5aef1d47@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20250902204340.2315079-5-wilder@us.ibm.com>
References: <20250902204340.2315079-1-wilder@us.ibm.com>
	<20250902204340.2315079-5-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Sep 2025 13:43:00 -0700 David Wilder wrote:
> +/**
> + * bond_validate_tags - validate an array of bond_vlan_tag.
> + * @tags: the array to validate
> + * @len: the length in bytes of @tags
> + *
> + * Validate that @tags points to a valid array of struct bond_vlan_tag.
> + * Returns the length of the validated bytes in the array or -1 if no
> + * valid list is found.
> + */

kdoc is picky about the return value formatting, it wants a colon, so:

 * Returns:

or

 * Return:
-- 
pw-bot: cr

