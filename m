Return-Path: <netdev+bounces-219930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE642B43BB8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFF1A00279
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932832F0C6E;
	Thu,  4 Sep 2025 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VfuYftdR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86B572604;
	Thu,  4 Sep 2025 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989354; cv=none; b=I2JKEhCmNrRXuxlQV/GjOkV7/NHsviYfUrEa8Nqg7VU0Yer8yeTxBEamqLrKCJv5kiRBzNckNIwJQjjGjs0zttX017Ervw4pqAs0SwR1h3BOdr6f7uJODWiUEwRRza50+v7NwtG7UI8Hs44TFKCOw1if+Hk2ThbU9S0MAIkXx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989354; c=relaxed/simple;
	bh=PDnxGRWeEjp96hBsqgEYqVc5VvH/OHtMXABg4S2tAPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4bT49ZzCzVyjG/RwTqLmcgNVWHHyJjvdqgpCRrKCTVaxDP2zuZFThTggevrTk6NBw7SWhOkkgi4mIF+hFqQZBl2bXwzIgl+J+l05U3zeRNK0ATpOKexiA8sQ1Lh0x9A558m7zNsoB2RmqkYSWyNUGe7EqzDWx4Mn1qovAl39Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VfuYftdR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vTMs0h45CDEOQS0xg4zE2o4BKftiiNc3aEpwZSrqS58=; b=VfuYftdRjRctpIk7NA+mQTfInT
	3dRA62fep07AU7Epi2UpU/IfNfCmO6ILckb8HGEwEFCSoA4QmBiIvsY420tlxnhgeG5nugmtjr+4j
	tsxsD7pXoxzKtCcyc5kj2/6ZYBggcJysmDDWh6eZLOW2BfwL0uGYS3SC+AeYTzgVHFD8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uu9BC-007D5j-8J; Thu, 04 Sep 2025 14:35:06 +0200
Date: Thu, 4 Sep 2025 14:35:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v10 5/5] net: rnpgbe: Add register_netdev
Message-ID: <d30ee369-3711-41d2-95ad-85fa3e1cb65c@lunn.ch>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-6-dong100@mucse.com>
 <b9a066d0-17b5-4da5-9c5d-8fe848e00896@lunn.ch>
 <6B193997D4E4412A+20250904030621.GD1015062@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B193997D4E4412A+20250904030621.GD1015062@nic-Precision-5820-Tower>

On Thu, Sep 04, 2025 at 11:06:21AM +0800, Yibo Dong wrote:
> On Thu, Sep 04, 2025 at 12:53:27AM +0200, Andrew Lunn wrote:
> > >   * rnpgbe_add_adapter - Add netdev for this pci_dev
> > >   * @pdev: PCI device information structure
> > > @@ -78,6 +129,38 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
> > >  
> > >  	hw->hw_addr = hw_addr;
> > >  	info->init(hw);
> > > +	mucse_init_mbx_params_pf(hw);
> > > +	err = hw->ops->echo_fw_status(hw, true, mucse_fw_powerup);
> > > +	if (err) {
> > > +		dev_warn(&pdev->dev, "Send powerup to hw failed %d\n", err);
> > > +		dev_warn(&pdev->dev, "Maybe low performance\n");
> > > +	}
> > > +
> > > +	err = mucse_mbx_sync_fw(hw);
> > > +	if (err) {
> > > +		dev_err(&pdev->dev, "Sync fw failed! %d\n", err);
> > > +		goto err_free_net;
> > > +	}
> > 
> > The order here seems odd. Don't you want to synchronise the mbox
> > before you power up? If your are out of sync, the power up could fail,
> > and you keep in lower power mode? 
> > 
> 
> As I explained before, powerup sends mbx and wait fw read out, but
> without response data from fw. mucse_mbx_sync_fw sends mbx and wait for
> the corect response from fw, after mucse_mbx_sync_fw, driver->fw
> request and fw->driver response will be both ok.

Because this is logically the wrong order, this deserves a comment.

You choice of function names for the lower level functions also does
not help. It is not so easy to look at the function used to know if it
is a request/response to the firmware, or just a request without a
response.

	Andrew

