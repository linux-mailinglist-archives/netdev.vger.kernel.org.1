Return-Path: <netdev+bounces-141297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2639BA676
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF011F213DE
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCACB176251;
	Sun,  3 Nov 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uowakQZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5816EC0E;
	Sun,  3 Nov 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730649251; cv=none; b=E7XLcQWOmCGGFqkXaDLlx42bVP7L6CjJOrEFOXoOOoFaHRJzbhwySLC++jJ9YqsxqSD/SKk2VTNpSwYl+n2Xqbg8/EflA/cV5k0DXBasWk2eEp0WWbhj/3nQ9/E0NsYjD7/GjLb3pjOdcRHR9KpMVy2EAVdneDzQERyByUnFJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730649251; c=relaxed/simple;
	bh=6sv0lXKBraM8bsqSE/nFJD8+HhevcGipFf9cWOaUdqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ca0xTzvnOzF/x+FaluLOIQgb9skYHYHpGq3WdHNRqINakdgS1oVB06MbGpbQqh5vS8iBhySCQEJfZDisl7fFr9ABfdBIR4Os/bbfr+UAxUAgSxBx5m86jtzBTNHrb72kTlqXxyykiKnVGCJS/WWcostmCbxBPUhV5bcd10+Egmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uowakQZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992F2C4CECD;
	Sun,  3 Nov 2024 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730649251;
	bh=6sv0lXKBraM8bsqSE/nFJD8+HhevcGipFf9cWOaUdqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uowakQZCdEqIfu957nYgHU207R/xlNLbUI09F1zw5JJfhQ/3seYpZlwkxaArTbc0v
	 i4GGtrdTZXrlKXuaguq7Edh96jPNf1xyHJbxxcrLjUx7W46RqjLcwyQBywQh+lfBit
	 yEOkn+s01suVXWQ3byl4F2G5mxEb1nDAsbOA9ZDSQvZctM7StOQwPh5njr7vcClBNV
	 1xhgDy80svDKlyw9hz66UJZB/XIFtJ5A+hbC8+E/c60LxpUYlJuLUYVp32XYzAh8/w
	 oERRbgzQDIHySFemb69i/NhLKNlKdEchxIcwQx+y7UYyBsYajhPnmQAWHOsGHSez/N
	 o1ctFPLUlIDhQ==
Date: Sun, 3 Nov 2024 07:54:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: davem@davemloft.net, michael.chan@broadcom.com, edumazet@google.com,
 andrew+netdev@lunn.ch, vikas.gupta@broadcom.com,
 andrew.gospodarek@broadcom.com, pabeni@redhat.com,
 pavan.chebbi@broadcom.com, martin.lau@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] bnxt_en: ethtool: Fix ip[6] ntuple rule
 verification
Message-ID: <20241103075409.0d31e277@kernel.org>
In-Reply-To: <219859e674ef7a9d8af9ab4f64a9095580f04bcc.1730436983.git.dxu@dxuuu.xyz>
References: <219859e674ef7a9d8af9ab4f64a9095580f04bcc.1730436983.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 22:58:30 -0600 Daniel Xu wrote:
> The reason was that all the l4proto validation was being run despite the
> l4proto mask being set to 0x0.  Fix by only running l4proto validation
> when mask is set.

Limitation is odd, but it's not a regression nor does it violate 
the uAPI so I think net-next would be appropriate, no Fixes tag
(you can say "commit xyz ("..") added.." as the reference).

