Return-Path: <netdev+bounces-176108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD09FA68D0C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1877C18988E5
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4B25522E;
	Wed, 19 Mar 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE0nUbDm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB449207DE2;
	Wed, 19 Mar 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387968; cv=none; b=f/SEitQ+Xv5udFMUxhD56+yiWVtPFQhBSy7lSGSctHhlx6XbJijnzOZvjeQ4LoJxm7aH9Md3HlObemU1zDNPilSvBGBsWqwXOnzS2/PX2EuWtQGUKuuYZ2vp4dLx7NN08wIFq4dhwC+z0xUt5rjLjaGj3ex6Lcfqy+wjVrUe8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387968; c=relaxed/simple;
	bh=+d6fawMch0I0q+4BQrYh7pBFqbseuDAWGqC2kSBQAdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4A5H9S9bNroLHN1GDVJbVJOlREp9+Cvk74WpUvEtN5pf+tetbY9DDNO0rjK9J/djjh6A5d+X8JBWQUl3d2t4gCJptv8chS1M+HveqrG6uL8REZJ1hmLVCTluOw3ZZqlLUEMfS4y2vJfzg3S3lIX7jmGvrbiO+s/aEr0Bb7J0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE0nUbDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82028C4CEE9;
	Wed, 19 Mar 2025 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742387968;
	bh=+d6fawMch0I0q+4BQrYh7pBFqbseuDAWGqC2kSBQAdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NE0nUbDmBLZYYLcH/13NBkf1wuPc7SAURDVHx//Xbham/L0YjcI0+9IfKjs2JcTel
	 EDJsCu5fdmTBqZB4H7PQgVRMeBjC/VrOXKAxH3IxHrEtLOQZG7je6oaS2xxFMjSpir
	 37AtTTOx/aUumccx6RoEWNOWaTmJjJu1dI01hypXPB5c++wjqtOmLeD88QYn7WF/LP
	 eR4O9ye4GQOxSz350i9HXokoS5Yjw6Bw1T7T/hpPz1fqdGhh5H//NvH3SE/5zaPwsI
	 mSmdatwQTQSgiaE114pwDNsaa5M8FPGBJum3oEinJc7aRwx88dyLh9T1PdP8G7r3/k
	 IYxjxPV5ZuHOA==
Date: Wed, 19 Mar 2025 12:39:24 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: atm: fix use after free in lec_send()
Message-ID: <20250319123924.GD280585@kernel.org>
References: <c751531d-4af4-42fe-affe-6104b34b791d@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c751531d-4af4-42fe-affe-6104b34b791d@stanley.mountain>

On Fri, Mar 14, 2025 at 01:10:57PM +0300, Dan Carpenter wrote:
> The ->send() operation frees skb so save the length before calling
> ->send() to avoid a use after free.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


