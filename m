Return-Path: <netdev+bounces-119237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B00954EBB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932131F22B49
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6465F1BD00B;
	Fri, 16 Aug 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqP2VJv6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074D817
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825482; cv=none; b=rx5JhwzXl32FWm1W0bPmodFTTbeNE6YqLAsTDXeS7ivN8CghXj30Eej5GJ0dvQAMIdJ/MxtDtS5TW2nWqe0sbk0TVIL74dPQRteUsSxlzfpS8qr3iywfyqgtyQs1R2RA+J7FOo4Uq05SbnzEmCufMbQG+oiu8P2xvpFmIx87rek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825482; c=relaxed/simple;
	bh=BbZre3nFAB7A1cLbo9rX8GYPusT0NMEfFUyubQ3QoP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln+BK4CF8f/2cAl+f60aGkD3h/0721RCzj/eeWFjBPqBZ0TVmfPXbmFsIQ3xfaTcgjKM7crCHpDsHe4kvLXKsg//qy4v+NlFqhUwKrt9jyk7OWrlgZRlc7zVIugVm6YDV9TkXEfDq/wSoF0eYIQhSIV5YIYLtP26fQoj6SXJ6xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqP2VJv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8E8C32782;
	Fri, 16 Aug 2024 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825481;
	bh=BbZre3nFAB7A1cLbo9rX8GYPusT0NMEfFUyubQ3QoP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqP2VJv67iEFazGiWZ/pIe4PJac90BmbRyW+gsaE2YAbcXIIx1VC3b8LBbB9N4TCw
	 zhcS9ugAjAZlshUKWi/t3IfAZfCmW7X2O21RLYQ7U2zoGC1pUgbX9Y9virIhYnNz3y
	 aVlfJ5NT7DO+Su5ThF0wRY7H1OZay8IImrQ1X7zZSneY5/2eVXB30P+sa7SL2Gktj4
	 9VE2YGP4TisKN1X7BLubBOKZPeAZo+PX2Ys00wGGr+EiN8110nlH8n2MRuuaWbANUe
	 wbpSQ9OdNtVSwjy7msjq+7g6TN6d/msvdmBCAEujx+ZTD+JD3f0RdD97GNJR+dKj3q
	 gMgtVpfJruoQg==
Date: Fri, 16 Aug 2024 17:24:38 +0100
From: Simon Horman <horms@kernel.org>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ibm: Simpify code with
 for_each_child_of_node()
Message-ID: <20240816162438.GV632411@kernel.org>
References: <20240816015837.109627-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816015837.109627-1-zhangzekun11@huawei.com>

On Fri, Aug 16, 2024 at 09:58:37AM +0800, Zhang Zekun wrote:
> for_each_child_of_node can help to iterate through the device_node,
> and we don't need to use while loop. No functional change with this
> conversion.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

I don't think there is a need to respin for this,
but the patch should be explicitly targeted at net-next

Subject: [PATCH net-next] ...

Otherwise, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

