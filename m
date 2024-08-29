Return-Path: <netdev+bounces-123339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037F964910
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58181B22E66
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58FF1B011B;
	Thu, 29 Aug 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsUHafk7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5801C6A1;
	Thu, 29 Aug 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943095; cv=none; b=BX/2wDCP0UXz96M+MtfbCDLQ+fDZv6hhzE7io+bF/d2Cd988XQSY7IpKAZkDxIkbrQLjvnijI1Zr5kMZEcaW6wVB+R8tbJI+5AdkxliJG/1WvsUgdyRhgPYCRzS/XNWZZ+TLR7nF4feOj8SnfKu43lpfnMGRufC0KurxaqnNmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943095; c=relaxed/simple;
	bh=rRykT8OQgaenDvIxYt53LaIAo4Gxdd96QkB/dv1nl8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtEij8RK36vdfzEJ8IL5IDwyzr12hHyOAaOeUVNKx7B1cTQVGeUtZZI5AlORUikJyf70v1B4U/e4tw6tButHqAn4M2vLFJUuSYd5jQep9sMIimjh2z0BHOqtCZHL0oKV2NzRgDqc2JPMrJCWbCDsT4pYOZu4aenbJTDWMWrMEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsUHafk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F07AC4CEC3;
	Thu, 29 Aug 2024 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724943095;
	bh=rRykT8OQgaenDvIxYt53LaIAo4Gxdd96QkB/dv1nl8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gsUHafk7rTdqjlc8g6CdOPmEDiYTlTQ0Qlubs84BvCBCuz27rYlGqJcSe8YGk7KZ4
	 tdeCZ7dOSpCnk1l9Xp8D8Np15q8bmy0Df6EO4JnAQKPDb1OBfJ41YrgRWgbR6k16HG
	 onTQgXql4iOL0Pg0/1crJJBkTmgeOydT5w8AHjLI1jBg7CPVA/6Lv1nTHPlVVLPjsY
	 peGwWVVDNdsF6Vi52NTt2f1Kce04ArUFb4ke7mVjsLWSqlTZeEYWsjVD7K16+FY/NZ
	 z/OWQBHL1hKHPoqnhrkf+UcsQxtmCWS06Wpy7ZNdv01Pwsl6C8Bsb1vG4GXgiDRHtn
	 ktQpwiYYBK0UQ==
Date: Thu, 29 Aug 2024 07:51:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 06/11] net: hibmcge: Implement
 .ndo_start_xmit function
Message-ID: <20240829075133.34c28f1f@kernel.org>
In-Reply-To: <df861206-0a7a-4744-98f6-6335303d29ef@huawei.com>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
	<20240827131455.2919051-7-shaojijie@huawei.com>
	<20240828184120.07102a2f@kernel.org>
	<df861206-0a7a-4744-98f6-6335303d29ef@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 10:32:33 +0800 Jijie Shao wrote:
> I won't be able to do a loopback test if the network port goes down unexpectedly.

One clarification in addition to what Andrew explained - we're talking
about allocating in ndo_open, not carrier itself being up / down.

