Return-Path: <netdev+bounces-213880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305A9B27352
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11581CC5A03
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16DE1114;
	Fri, 15 Aug 2025 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xHY5s2Ul"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31885A41;
	Fri, 15 Aug 2025 00:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216334; cv=none; b=ZrBn/XVTtiTE3sVYpCq3LqT0nKQvvpGIO2sasDc15fItrpHg4KrrxkM+L0BLTmNvfeDJZToJRn78YNRg4DAE4mFPzzU0vhfOltPqYTIOO38/MJoiYolnG9ObJcwZEWem5UrJ8+XSoi/y0VIzWtmriDSNsl0JlJUn0xHuwbAoxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216334; c=relaxed/simple;
	bh=AI6EC+WjrnaVKgQRAnxGKZerbb+jbd1sEX7r6pONNvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKP5wih+kH4pvsscOSR1n5WIj3Yba8aA1Hocv5ke01VtzEa1ZwYFY0lq29FdKaQ52BJy4RsIYRdbVYCy+4+3TnFPH5bWA69sGRSdZ4dMQsXJ9GfuGtK7ZXcD5UrBUv4I/9FgWNAEQzjqb/oTDntSg5BgvHB4UigZiVk9T4RNcsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xHY5s2Ul; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uyIoDG3Q5lXrt2iNgEV1rF7cmOwtm6+FCTj1aZTo/Q0=; b=xHY5s2UlG3VEMLoeSIOa0VWA95
	EzhSxYzMcOw63bZ7Qtnq5NHF8IwBtdtUvLMZjs3ly+cEsBll/mxhdFkWQ0oK80kbuip6K56N/fjHg
	xwyX0dfmfGBMCTv/Zw1bx8unhIIYLcX0OIDeM2t0bmLB99C0W4U4bvjlIANpqoZ00cAY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umhwH-004lMt-JT; Fri, 15 Aug 2025 02:04:57 +0200
Date: Fri, 15 Aug 2025 02:04:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <9af5710c-e465-4e21-8705-4698e544c649@lunn.ch>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-5-dong100@mucse.com>
 <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
 <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>

> If it is more cleaner bellow?
> 
> static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
>                                   struct mbx_fw_cmd_req *req,
>                                   struct mbx_fw_cmd_reply *reply)
> {
>         int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
>         int retry_cnt = 3;
>         int err;
> 
>         err = mutex_lock_interruptible(&hw->mbx.lock);
>         if (err)
>                 return err;
>         err = hw->mbx.ops->write_posted(hw, (u32 *)req,
>                                         L_WD(len));
>         if (err)
>                 goto quit;
>         do {
>                 err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
>                                                L_WD(sizeof(*reply)));
>                 if (err)
>                         goto quit;
>         } while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> 
>         mutex_unlock(&hw->mbx.lock);
>         if (retry_cnt < 0)
>                 return -ETIMEDOUT;
>         if (reply->error_code)
>                 return -EIO;
>         return 0;
> quit:
>         mutex_unlock(&hw->mbx.lock);
>         return err;
> }

You might want a read a few other drivers in mailine. Look at the
naming. I doubt you will find many using "quit" for a label. "out" or
"unlock" is more popular.

When it comes to locks, it is better to have one lock statement and
one unlock statement. It then becomes easy to see all paths lead to
the unlock.

	Andrew

