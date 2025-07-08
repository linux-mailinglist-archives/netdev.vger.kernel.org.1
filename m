Return-Path: <netdev+bounces-205015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D8EAFCDEE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360AF7B35BC
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E92DFF3E;
	Tue,  8 Jul 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3F0Jy+OG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893E2DE6F1;
	Tue,  8 Jul 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985612; cv=none; b=pWuyUWZB/Q9JhvVsUS1Gtog58Ol2jal4VoaC35golWICO8ZaGYL3g70DbHjUyfI+E4mdQeOVqc+R7xMP7Ap/fQaIcw/bIeXO0FTBtxUJGJnKqB/hVMquqUrUnVmgiQn3XvRU0aJ4MhF+0CeVRdt8MuwrDScS8gYbl4vgT9IambM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985612; c=relaxed/simple;
	bh=DzLkRuRGnIPC0vr+z5cisyB4/ddM7FcrspuLmC3VLcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDfDJ9BsjdAXX2SrTZ8D0ambnN9uX/vJuIq7VQtCS5LZcb3OifuzDIh568xlNnHRddsfqygjFLlofNvBnFnmWHyTgdBqnkNPjLhcXEU8GK9Xg8yeNqlJxLjeoR4LbsOBlcnt0gHxLhkNv4QGNyn6aIlZXbW5WJKjBtmKGdhX+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3F0Jy+OG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ugBcuZ5foeQpsflut58LWJ8esb5lgXiSVvtouGW/36Q=; b=3F0Jy+OGErqId+IBKXIHRbEF4h
	b2L31wB44ozQE4DzuQV1UklkQ3+nC/I7dR9KDpbbi2Z0rtG4rOgt6Dbeukbow9VO/YWyjjkfEVLPA
	gOcWJexH5v6HvTJ6bQPfqrsoHpQHhVM0AH3kvlUfkMfTb9pXHCRicrPLrDMsCHfSnevU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9UH-000pZS-Jl; Tue, 08 Jul 2025 16:40:01 +0200
Date: Tue, 8 Jul 2025 16:40:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/11] net: hns3: use seq_file for files in reg/
 in debugfs
Message-ID: <dfc4c29f-4a28-4768-b2d9-fc2be9921a18@lunn.ch>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
 <20250708130029.1310872-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130029.1310872-8-shaojijie@huawei.com>

On Tue, Jul 08, 2025 at 09:00:25PM +0800, Jijie Shao wrote:
> This patch use seq_file for the following nodes:
> bios_common/ssu/igu_egu/rpu/ncsi/rtc/ppp/rcb/tqp/mac/dcb
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

