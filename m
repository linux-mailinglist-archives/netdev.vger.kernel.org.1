Return-Path: <netdev+bounces-218365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA28B3C34A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2DD5A18A5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FA0226CF7;
	Fri, 29 Aug 2025 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uIWoXMqy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05C2566;
	Fri, 29 Aug 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496952; cv=none; b=mmr3og+nkT61H7gt1oUBxAhzVYoFxS827BT4ojYEzV0aLJF/uPfmS/vTuBBN7z8i8KLssgvkx4Gdy8y7zFBUegmeYspbqcnyfKLX5fioj0YyxmLTj4ri6NXxm7xDS/U/Nz0TSETrh78faCtrhTdvz1G1GJC6m+jLO2yEC64cfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496952; c=relaxed/simple;
	bh=LLVcrIi/cyWo0LjJCEYkZmzJpxi7u/TFm+fW6emCsds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgpi13wT21EcuKAQOIKzgNYXvCmunHGkYhNL80XU+uuob5Knq96hE0v1EtCZ9m5LgDrjH77x2d84dAUnvx6CfqadwDIXxns65wQ8viqRV1gtSWaL35Tt8adLQ0ICnmn9sSd4yWBjU99on2TAaUvVbgyMY0TUeLLRJFdoGRTlTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uIWoXMqy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ro188kEhUKQPnNng/X944mHUrpfeDnYN6haIPs2ALlU=; b=uIWoXMqyXks7k78f4aKMtdvSfw
	GTKLj6b+kWAY8I5Jv1Wl280VovqT8EMA+ErXadFbpF1j2BG4khowgYRu4/i+5xklVMtzkNEE+I1Rz
	Raqs37mmA21IdmMRxWlW3FlC2i+RwsH96oUgzz0/X1SwIHjETTUdYKT0g/KcNWtP9Vsc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1us552-006WFX-Ve; Fri, 29 Aug 2025 21:48:12 +0200
Date: Fri, 29 Aug 2025 21:48:12 +0200
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
Subject: Re: [PATCH net-next v9 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <8a76222e-8da7-4499-981f-64660e377e1c@lunn.ch>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-5-dong100@mucse.com>
 <d61dd41c-5700-483f-847a-a92000b8a925@lunn.ch>
 <DB12A33105BC0233+20250829021254.GA904254@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB12A33105BC0233+20250829021254.GA904254@nic-Precision-5820-Tower>

> Maybe I should rename it like this?
> 
> /**
>  * mucse_mbx_sync_fw_by_get_capability - Try to sync driver and fw
>  * @hw: pointer to the HW structure
>  *
>  * mucse_mbx_sync_fw_by_get_capability tries to sync driver and fw
>  * by get capabitiy mbx cmd. Many retrys will do if it is failed.
>  *
>  * Return: 0 on success, negative errno on failure
>  **/
> int mucse_mbx_sync_fw_by_get_capability(struct mucse_hw *hw)
> {
> 	struct hw_abilities ability = {};
> 	int try_cnt = 3;
> 	int err;
> 	/* It is called once in probe, if failed nothing
> 	 * (register network) todo. Try more times to get driver
> 	 * and firmware in sync.
> 	 */
> 	do {
> 		err = mucse_fw_get_capability(hw, &ability);
> 		if (err)
> 			continue;
> 		break;
> 	} while (try_cnt--);
> 
> 	if (!err)
> 		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> 	return err;
> }

Why so much resistance to a NOP or firmware version, something which
is not that important? Why do you want to combine getting sync and
getting the capabilities?

> fw reduce working frequency to save power if no driver is probed to this
> chip. And fw change frequency to normal after recieve insmod mbx cmd.

So why is this called ifinsmod? Why not power save? If you had called
this power save, i would not of questioned what this does, it is
pretty obvious, and other drivers probably have something
similar. Some drivers probably have something like open/close, which
do similar things. Again, i would not of asked. By not following what
other drivers are doing, you just cause problems for everybody.

So please give this a new name. Not just the function, but also the
name of the firmware op and everything else to do with this. The
firmware does not care what the driver calls it, all it sees is a
binary message format, no names.

Please also go through your driver and look at all the other names. Do
they match what other drivers use. If not, you might want to rename
them, in order to get your code merged with a lot less back and forth
with reviewers.

	Andrew

