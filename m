Return-Path: <netdev+bounces-107441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594B91AFE4
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20A91F241B5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603F919ADB3;
	Thu, 27 Jun 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGZgHYGc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47B33C9;
	Thu, 27 Jun 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518143; cv=none; b=Ky82NXjRI6kokhVLKFSba4CHav0BWgDbbho8kKyHnY4ZnkYXs6N2jACogI0mpwUa0+tuZxis/FmQOzRxzlPxalxTbVErS3r/uz12t59pLDymhs/BvryiXqlnb8IqBx24M3x2cphZf9gqaVxEIniIEjrHRnopS/BrtXvKyHvCL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518143; c=relaxed/simple;
	bh=W6cqxra8+FO/up23yLnW1643ICKIZwNjxUraKipwBPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqsOa0BFadmuZH/MuDQ5LufdLUbiI9PwYsKZIg4F4zBJD0wkthjCGGXf9U5qULhVb+iWVMeWedOAdv9kZZspN8RSx1Qbs/Un0JfkstFW9wL4UHNo0VyHCq6/gWM8AquUSVpHHUqYBvcfiSLZCLTqRGk0JH65yuLtkl2xcMmYkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGZgHYGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38169C2BBFC;
	Thu, 27 Jun 2024 19:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719518142;
	bh=W6cqxra8+FO/up23yLnW1643ICKIZwNjxUraKipwBPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PGZgHYGciad64FjNtnvO48bagrr4ryGUZQ4xfqR2mLiX/sJxXF1M1w+zBVikB98vl
	 JWjQqqcBMQPL8yUHdoxQcyzkPtILF+yOnqYxUcjI+jCqi7DV6Kl3UhLxKrO+k4FCy5
	 u7yy56vRnAhXo/GV8JF8k3gNL7xZNGcea1ddJjie/GwSl5CToBqqtr+iylTChrIHDD
	 pUX6ORyfEDZP2LaRcEHR1PLBSZ1i61Kja3cO9XFZQW5oFMcDBuc9hYieQLuCdInsQW
	 EdINUkvMD95xRj2Ef86nKL4spKQFN7uHXFywfk/KMNz8ULyaTqYbG7ERyEfFx3WnN5
	 PThfjwkd4vxWw==
Date: Thu, 27 Jun 2024 12:55:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] netdevice: convert private flags > BIT(31)
 to bitfields
Message-ID: <20240627125541.3de68e1f@kernel.org>
In-Reply-To: <e0b66a74-b32b-4e77-a7f7-8fd9c28cb88b@intel.com>
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
	<20240625114432.1398320-2-aleksander.lobakin@intel.com>
	<20240626075117.6a250653@kernel.org>
	<e0b66a74-b32b-4e77-a7f7-8fd9c28cb88b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 11:50:40 +0200 Alexander Lobakin wrote:
> > I don't think we should group them indiscriminately. Better to add the
> > asserts flag by flag. Neither of the flags you're breaking out in this
> > patch are used on the fast path.
> > 
> > Or is the problem that CACHELINE_ASSERT_GROUP_MEMBER doesn't work on
> > bitfields?  
> 
> It generates sizeof(bitfield) which the compilers don't like and don't
> want to compile ._.

Mm. Okay, I have no better ideas then.

Do consider moving the cold flags next to wol_enabled, tho?

