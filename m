Return-Path: <netdev+bounces-182771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF87AA89E06
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44136189E98A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE9C1FFC4F;
	Tue, 15 Apr 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N+nSP0LF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D21B0F11;
	Tue, 15 Apr 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720090; cv=none; b=jtHxUyG+YhpVloV0bTTXfySPfwr4ewpq2+6+YjMRI8aFJkIVveJic+LLzUnkfWDF9X+HKTbRNIizKy6Zg4uOQ6Kq5jCLDIMnYn2Mu8Rn3zowt+pSz9QFfZbhktRct1ufTV+ZtAhDsb9N/Ws/uLT/TtoABx6BixxRxVnfwGYUWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720090; c=relaxed/simple;
	bh=B42YVR9YxQ/uex4o94ytf3FzVViu54twI9yKly29LIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZUc9zfkQCZqQgLoGgAxn7DDd2gpBDAXopyj1PbStiqoswpgn4oXWk691hmEPlQXro7kbOJ+WENLLK2uXirsyUccLk2Gnp3BTRQt29kwV/GYUm6EXsFSRVh6v8Mam3Rv+pCvq5nxhzHwcJBrIgdzoZoeZh3nsbWuO8oqDrXZySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N+nSP0LF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jc0Cqlc/4O2y6b7YPqyHcGJj5zn8IQ6ifRZ5GyrmqcY=; b=N+nSP0LFNe1o8wmFAAm+MqQiKB
	3UQbB7QDZwHm+dhJjQMVXF+GNWXi9WVEXZqF7oMyVJGH5Yx/ysMBl7iYZy/0yGuz76GWsWjR7jtT9
	yITFXX/CXJ8G0o1pBAy3pN+bbafucyzdQunt+fND7+GMC6UMMQlvjDOSrQifmjrd3IfI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4fOS-009R29-Ez; Tue, 15 Apr 2025 14:28:00 +0200
Date: Tue, 15 Apr 2025 14:28:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Feiyang Chen <chris.chenfeiyang@gmail.com>,
	loongarch@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biao Dong <dongbiao@loongson.cn>,
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: Re: [PATCH net-next 3/3] net: stmmac: dwmac-loongson: Add new GMAC's
 PCI device ID support
Message-ID: <15ef5303-330e-4734-851a-32a8390437d2@lunn.ch>
References: <20250415071128.3774235-1-chenhuacai@loongson.cn>
 <20250415071128.3774235-4-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415071128.3774235-4-chenhuacai@loongson.cn>

On Tue, Apr 15, 2025 at 03:11:28PM +0800, Huacai Chen wrote:
61;8000;1c> Add a new GMAC's PCI device ID (0x7a23) support which is used in
> Loongson-2K3000/Loongson-3B6000M. The new GMAC device use external PHY,
> so it reuses loongson_gmac_data() as the old GMAC device (0x7a03), and
> the new GMAC device still doesn't support flow control now.
> 
> Tested-by: Biao Dong <dongbiao@loongson.cn>
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

