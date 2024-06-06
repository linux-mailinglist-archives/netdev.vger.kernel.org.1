Return-Path: <netdev+bounces-101517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F9E8FF299
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB68BB22C49
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA11953A4;
	Thu,  6 Jun 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK7/fdav"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0941B969;
	Thu,  6 Jun 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691222; cv=none; b=LwZThL0o63R+DKb05fih/pxYrTXaRsZPRz0LWBOtnZlZDpshZGiZ/I+0TZcEaILBfL4dUleXt94OJUnXvMCM9CnV5zWT0awUKA8vOnY0P0hW1Owho38w4rgNm5cQK7bxgk4naWCjEVbq8pzzbCXsfQjFMM1ZYYH/BaYKviG4dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691222; c=relaxed/simple;
	bh=CZd+hSP2oTqWrt2DXzt9wijlVem+0PY7P0CiMx8jw6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOKWUPNfHgItFqA/yFXfbAiOlU/HkYlz7VQ0BEgdxnwao1YMZQIae3o+LRkADH/wc71e9fNnRXlL2HE8TIDVAHBNxA6gzIQ+MUfIsokOowmEVWVNc8qCgg83cqI4iSgFSkUjZF2XyTCtm81J/g81Oo1z4GRpPfUIQ9E5lWgX6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK7/fdav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D28CC2BD10;
	Thu,  6 Jun 2024 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717691222;
	bh=CZd+hSP2oTqWrt2DXzt9wijlVem+0PY7P0CiMx8jw6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sK7/fdavea2Fv2h4EQ9Uly7AxR4NwJYBncYllJqe6rx+PZtO8KsPTWgeXGA8pIuu3
	 0wLzbdGMhgGMAKhDNjvp4DA034r/soZZmpayXD/9W0BHp7djmILabFRd6YpmfMA9ce
	 9rshdgwGjJOi9CxeP3uNag1OaWbmRlwJau/vQFQUmNFiAA9TyrV7i4xPVgVegfbcHg
	 5itFBzlRWBtwHK0ktXAw5fCZAZCbqWXic+rwtvPI3RFZUJNkGQSCmhUdgVkhRKQ9Nm
	 4UI01c1Yyb4ZelbxkED7EQzu6LBqH7LMzrrR9d4xuAZenKq33vsdhpzz7UC2hvHxkE
	 o0z0lE/o+sfPQ==
Date: Thu, 6 Jun 2024 17:26:56 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: hns3: fix kernel crash problem in
 concurrent scenario
Message-ID: <20240606162656.GM791188@kernel.org>
References: <20240605072058.2027992-1-shaojijie@huawei.com>
 <20240605072058.2027992-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605072058.2027992-2-shaojijie@huawei.com>

On Wed, Jun 05, 2024 at 03:20:57PM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> When link status change, the nic driver need to notify the roce
> driver to handle this event, but at this time, the roce driver
> may uninit, then cause kernel crash.
> 
> To fix the problem, when link status change, need to check
> whether the roce registered, and when uninit, need to wait link
> update finish.
> 
> Fixes: 45e92b7e4e27 ("net: hns3: add calling roce callback function when link status change")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


