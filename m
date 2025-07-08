Return-Path: <netdev+bounces-205018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB0AFCE01
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0AA48632F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA832E0912;
	Tue,  8 Jul 2025 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BE/fnwd1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355452DF3C6;
	Tue,  8 Jul 2025 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985701; cv=none; b=ROy8FIQGPKmhtPxYxm4PAabQYUMGYcbkThIMsTwigAKi+ZkUc8vG4dVfn6sx3HjP/pSXwTtx3+uOY87OUHXnCcq2SUEUyXbBKX7tHhIAcjZuHZlKJOGliBrSWsW+LdXkR20lUz1VZmdtb4kLReE9IJMoB8NyfK0XgC/nmGgcLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985701; c=relaxed/simple;
	bh=BZe8i4Wn0uwiHg4WBD4WjYTDW0sV8WCHivpedO9JF1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7vns+HfmSovS1OZvd9K8W+cETC0V3UNi6+KcLs74+gwq8BD2JX7YdgfqUmyQ9LkMgHKUq0y6PNV0kaJpIPgrIpRAdTXJ8dJ2YgliB86sUa28Immdqyur/48sOeBkO6k+NUHA4DsOiXuiFHN1hzctExi9jDrVkIT1cOZCtk2G6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BE/fnwd1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ju/M13OYd3sN5W8yq1NDJZMrTP3DoIOefKkhdnuNzQU=; b=BE/fnwd1b7wHWqtzCvn+UIny7I
	YHzYZ2ymA+rdoxkBb+0xOFe5FjVAOWuVDHZabKPYjDznhiXDfXQRDHvUTK651rwuJnqKCDvXBZJLZ
	fhxNkitlyYbKzcrOrM4XokQb73ukxhl8Ego4UWkf8VIR07HWxGc0OwSkdACssAiZHg68=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9Vj-000pbY-JT; Tue, 08 Jul 2025 16:41:31 +0200
Date: Tue, 8 Jul 2025 16:41:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/11] net: hns3: use seq_file for files in
 tx_bd_info/ and rx_bd_info/ in debugfs
Message-ID: <18e9168b-71b1-46dd-9aea-6dd4116a87d7@lunn.ch>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
 <20250708130029.1310872-11-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130029.1310872-11-shaojijie@huawei.com>

On Tue, Jul 08, 2025 at 09:00:28PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> This patch use seq_file for the following nodes:
> tx_bd_queue_*/rx_bd_queue_*
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

