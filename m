Return-Path: <netdev+bounces-121106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947E095BB4B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7EE2843AC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEFE1CC158;
	Thu, 22 Aug 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G6LO7iiK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6AD28389;
	Thu, 22 Aug 2024 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342701; cv=none; b=S5trTRGTjdavELMRqTWRvQ7hXxh7rclX1JDqvM7DSlwhiDDryaZvrZGtYOFaXdA0LVyacYi0INxQefauz0Qt87KCrrdzJMv1jXBwfd4v4DMvLt0McNRHMndTyLEcKeuCW6CU/8zZNhTtriXQr2cYQSTz1Hz04xPxR0enu6dVGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342701; c=relaxed/simple;
	bh=hTLeE3Z+lzy84nujlkjwPGhS0nL+0VfqYn3wTJTrduU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7j3uL9QAldcbhZutcJs+oTHOWdjXv856ekBFasEWBzoLCJ1XHaBFQ14pBg/kV2vQuRdpf6DJZ4DUik8irCmdOOsqpJGLFQdRYFz7fa6W5dWwrW9RQCIkOTSzO0V8ungT3gNvfb75QPkcmd/s5L1ocsKieZgEVzO1HlBwYufBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G6LO7iiK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ke4zMjhARqRva6A0rdMVgrCDkZdJLT09LkkEDhGdw8o=; b=G6LO7iiKTeguk3t6pfqBYbu+hP
	5g/Hr9wDN6eQr0ZhPRSU+EEwjFt35lzey4geNHH/JLqEwwhmHJJKl1TXsXfpbU1wTZW/iybBx0rU8
	3C7LzPqSdr+JNmJbrCxaMzVhBHX45gsELfkcNMF+VjQbDQnu6zRfanWBeZPEsjBPROVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1shAIp-005Rsp-OE; Thu, 22 Aug 2024 18:04:47 +0200
Date: Thu, 22 Aug 2024 18:04:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net-next 02/11] net: hibmcge: Add read/write registers
 supported through the bar space
Message-ID: <2548f41a-4910-4b60-9433-87714f594e82@lunn.ch>
References: <20240822093334.1687011-1-shaojijie@huawei.com>
 <20240822093334.1687011-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822093334.1687011-3-shaojijie@huawei.com>

>  static int hbg_pci_init(struct pci_dev *pdev)
>  {
> @@ -56,10 +62,15 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ret)
>  		return ret;
>  
> +	ret = hbg_init(priv);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_register_netdev(dev, netdev);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to register netdev\n");
>  
> +	set_bit(HBG_NIC_STATE_INITED, &priv->state);

There is a potential race here. Before devm_register_netdev() even
returns, the linux stack could be sending packets. You need to ensure
nothing actual needs HBG_NIC_STATE_INITED when the interface is
operating, because it might not be set yet.

In general, such state variables are not needed. If registration
failed, probe failed, and the driver will be unloaded. If registration
succeeded and other functions are being used, registration must of
been successful.

	Andrew

