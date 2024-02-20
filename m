Return-Path: <netdev+bounces-73295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C72985BCA4
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3A61F2341C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4AE69DFD;
	Tue, 20 Feb 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDL51/xP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15505CDED;
	Tue, 20 Feb 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433773; cv=none; b=j3cXAN6v2OCtfGk21bnKE3xXsuC1+418DcASR6W4d2kqyIxnbWboKVdI/w2JpY+yWEBAYKWQhgbOLqCDIF7kCCaAKOIcbHs5MjFaLBcAbn7zkrUUjRJZzRu+gLwO+//TmiI6W0dSw/dm73uBEQfi6EBEFy1QeGmjT6xxOQPjAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433773; c=relaxed/simple;
	bh=Q5BWa8LkWf902AxVTsQ/Vk7boyDKv6MiQY5w+ZXdYKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FI2hloyk6ZxqFhChm2qJA0pRgaghn0ZuVXgG60lyFzs+t6+OkwUi2F5k28oYqwNqKyDZDeJnWhRh93kfgywbqhFr6oXL0t14HdK22I68fcVUuZC4/V7UPyFiiUKiB5XoZhrMQdfKIXJKED81oj45KAS+mPbtNGE0bZmpVMLJgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDL51/xP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FE2C433C7;
	Tue, 20 Feb 2024 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708433773;
	bh=Q5BWa8LkWf902AxVTsQ/Vk7boyDKv6MiQY5w+ZXdYKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDL51/xP6pc6UuWIIrE/ULokhaA0Vsu3/GWwd+ew91wGsc1nIk9kL/zCarULtlWWk
	 n8oXykLkk1lkVXPdj28ctAzMV3NjQq12HaTujBx4w5zB+Nl4HBaCCz65guDc+uGA6n
	 BNp3HCFt8zpK5YVEoZV05JTsAK/3s1Nkn0bsertTXPh0yzb5mx80ghJdLuKmrP/ThN
	 NFsQi7M1r663rsSy7vyAcU9/4hamPARjn0qnQQOa/KUVf7/nFACL8E5oaJ+76oAPQ7
	 zFUqw71sreswoZq5sS/mbllizqCcdsXgJFzjVbFryODclY7YAY7+8vFZ7hYxh3W1en
	 cuQlAhiLsdg1g==
Date: Tue, 20 Feb 2024 12:56:08 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 1/9] net: usb: r8152: Use linkmode helpers
 for EEE
Message-ID: <20240220125608.GG40273@kernel.org>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-1-71f13b7c3e60@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-keee-u32-cleanup-v4-1-71f13b7c3e60@lunn.ch>

On Sun, Feb 18, 2024 at 11:06:58AM -0600, Andrew Lunn wrote:
> Make use of the existing linkmode helpers for converting PHY EEE
> register values into links modes, now that ethtool_keee uses link
> modes, rather than u32 values.
> 
> Rework determining if EEE is active to make is similar as to how
> phylib decides, and make use of a phylib helper to validate if EEE is
> valid in for the current link mode. This then requires that PHYLIB is
> selected.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <horms@kernel.org>


