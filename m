Return-Path: <netdev+bounces-213878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97166B27341
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BB144E2562
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E02877C1;
	Thu, 14 Aug 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gvpBMHto"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010CB7260B;
	Thu, 14 Aug 2025 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755215784; cv=none; b=Ztfis1Hri5DrT/XmkxXucrtYBs1KCvRLdd9PnW3J8nXVukZRdKneNx4NZEOgRN1utWcLkWfVKtk+VkWiqscEmyOqi4l7Pgu658ikLnU93PEv+TSrNSH+7P21yTdXBzrDPsxMbx2PCXi79mMRupU7h6/a5xgoj3g38WwoNXIuX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755215784; c=relaxed/simple;
	bh=x0bFVZ1uYETRh4/U3dVs/8jgbtkqyYD9kNirgPjbrts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwKG/UsCVrPoDYTNj5wvo66kQYrPcKmUh6t4uJtS9dvvJl4nuQ41Nl6yvdLq80qx/9tgEpviTEpJ27m2hoCKlLq8eNzrjl2QRo7Ri2P6ES1T31KQAxsc+t4ElMJ8Q/oOpe2TFSZSng5wZpjvHHw2LcfeOJa6psB8VX42Hj9xUck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gvpBMHto; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iO7gvkcR9jtYhgYI3L/x/G8cryb+BsMsMughOI020Ks=; b=gvpBMHto5iIFoh5Dbv3pv4pdrS
	I5hckahbjVnzHxY3wG0ZJUmqULWPkkUTh/nlLCOBqlM5hEd1/vHcSRFRlfF1zawLxHMdMuQxA+aB/
	c+H2XZ6nIieweUmUmLIHH23G0cNhMNagUymCV68GL7J8ZAvSYCpMLKMdmoFCNgPbXA3Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umhnK-004lJP-Il; Fri, 15 Aug 2025 01:55:42 +0200
Date: Fri, 15 Aug 2025 01:55:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <a0cd145c-c02e-40da-b180-a8ca041f2ca3@lunn.ch>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812093937.882045-4-dong100@mucse.com>

> +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	/* limit read size */
> +	min(size, mbx->size);
> +	return mbx->ops->read(hw, msg, size);

As well as the obvious bug pointed out by others, isn't this condition
actually indicating a bug somewhere else? If size is bigger than
mbx->size, the caller is broken. You probably want a dev_err() here,
and return -EINVAL, so you get a hint something else is broken
somewhere.

	Andrew

