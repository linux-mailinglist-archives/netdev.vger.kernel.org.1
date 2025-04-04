Return-Path: <netdev+bounces-179328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3ACA7C014
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991C0172C1E
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B51F2C5F;
	Fri,  4 Apr 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONYkqMUD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FEBDF49;
	Fri,  4 Apr 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778687; cv=none; b=SbBGGx3EZRMXOwbQFRc5j2PANd0e10X18fLqzhe9XyFx2ZGmCriLC9SF/3vjp05LcX9yWCStmMOGP8hYMEyJ8897rxDf/XTVRNbRQ3hlkwqYYXlStOlbuH78smJf1wFVS8ZaEjgmZ601mfurwN9tGnVLebtIpqMXnhvWXQKjFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778687; c=relaxed/simple;
	bh=LPsLxYddlVBXJ54faW88NFXswk0z7R7equVpFWPbk3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ah97QgjtZIE+qQ4lfOv6rqIes+xU9uJHiocxiZERsljCGT7alrM30TxPKDpn7wg9z86xZzplGIrTiuyBg3kqBI2Mn+kJI/iPXx8IirFfUVJbofyWqkcAg6bBXp9ApfmuooodzQvhVNMBPjtzs9lXgTK6sN2j0ZRlWyCs6jkzVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONYkqMUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC47C4CEDD;
	Fri,  4 Apr 2025 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743778685;
	bh=LPsLxYddlVBXJ54faW88NFXswk0z7R7equVpFWPbk3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ONYkqMUD5CSrr0YYiKGIMwHNUNnHmtuc431Y6HKpwE9CULNssRPG8vv8x1YgYUjEn
	 C0U2uNGhpckQrvyrqzxZW6SjzbG2WXV2AJ4OsoXeqe+7UPjbnLQsGbab0kszgabYAL
	 1Hwe2Ny26g9DoKRQX6kD8vsI38hkdG94QGTK13wDtRbb0FcviUN+Wz8HeuRMVRUh4t
	 +ISBWfcWtb+rAnUIRM7uCtRl7tWBlrb/Fk9xiKcS+eUrcBbpRCxZdIsG1pl+S3+f+6
	 kpl1oQnCrKaNTKqnq0X8Wl/UXLMcGsdC7RiTAkgFXiJ11xlPz7WrFoGJlLucAt0EYc
	 9FuaUylrBukgw==
Date: Fri, 4 Apr 2025 07:58:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 6/7] net: hibmcge: fix not restore rx pause mac
 addr after reset issue
Message-ID: <20250404075804.42ccf6f0@kernel.org>
In-Reply-To: <20250403135311.545633-7-shaojijie@huawei.com>
References: <20250403135311.545633-1-shaojijie@huawei.com>
	<20250403135311.545633-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Apr 2025 21:53:10 +0800 Jijie Shao wrote:
> In normal cases, the driver must ensure that the value
> of rx pause mac addr is the same as the MAC address of
> the network port. This ensures that the driver can
> receive pause frames whose destination address is
> the MAC address of the network port.

I thought "in normal cases" pause frames use 01:80:C2:00:00:01
as the destination address!?

Are you sure this patch is not a misunderstanding, and the issue
is already fixed by patch 2?

> Currently, the rx pause addr does not restored after reset.
> 
> The index of the MAC address of the host is always 0.
> Therefore, this patch sets rx pause addr to
> the MAC address with index 0.
-- 
pw-bot: cr

