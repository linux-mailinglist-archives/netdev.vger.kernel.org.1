Return-Path: <netdev+bounces-219391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBE9B41185
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F307AEEF1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377751991D2;
	Wed,  3 Sep 2025 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FwJn0dOy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953714EC73;
	Wed,  3 Sep 2025 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860940; cv=none; b=iEAmt7p+0p0i8OKl9IqG1MqpQWCIe09RQmf3f5FPbwgA8/RtIf49P/d7hDOBN1PYuSNqEK06kULeyDc9QZkEAOuqjv5fqIZ49E0rEczCPRih/zpOUTmDlc+sI2Eu3ysIZTBtK+wO2ctWjZP45silSGYnNy9aZfSx+JIlMwGjozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860940; c=relaxed/simple;
	bh=CglZ6hAs0lyhGPLSCvb8VAjSDqZIp0mI++SFUORODDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWeln0LoMqS6rSx9ynrJENKSgDtU/pAX3UTe6GHfUDJMme0j5whv8SoCDUjz4+5UU2J0bqhIZLkSuqdZvHZjpXy92lFomVgZ0IXW805sm5QXs1vI6YjVcuS5OTIWGqVx71u1bSIJ7QIHqMLXsDQBecisIq8SVLsj4a74jKDmyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FwJn0dOy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MT9bLzeACo6TSh3Rx/aV9OKa1IS+aeCJ1/SX9kCee/U=; b=FwJn0dOy05N7I5ceB1y60GRE+c
	ZUJ9E4Qjs83dV8yZOfUgeiGRbaiJESba91KSMkgovEhEEPPiiJVajZIdhWtyIdB+cs20RFhn4GpYO
	PPYO7OekYGtuXz6I1WMvwaZ5ImmFQNnRJql8k3X2sB002whxFATmEK7ZZj/YCb88ITrE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utbm0-006xId-BF; Wed, 03 Sep 2025 02:54:52 +0200
Date: Wed, 3 Sep 2025 02:54:52 +0200
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
Message-ID: <f7a9598c-fe92-4fb2-a195-ab2e6a1c085f@lunn.ch>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-5-dong100@mucse.com>
 <d61dd41c-5700-483f-847a-a92000b8a925@lunn.ch>
 <DB12A33105BC0233+20250829021254.GA904254@nic-Precision-5820-Tower>
 <8a76222e-8da7-4499-981f-64660e377e1c@lunn.ch>
 <1D189F224F826D6C+20250901072734.GA43225@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1D189F224F826D6C+20250901072734.GA43225@nic-Precision-5820-Tower>

> static int mucse_mbx_get_info(struct mucse_hw *hw)
> {
>         struct mbx_fw_cmd_reply reply = {};
>         struct mbx_fw_cmd_req req = {};
>         struct hw_info info = {};
>         int err;
> 
>         build_get_fw_info_req(&req);
>         err = mucse_fw_send_cmd_wait(hw, &req, &reply);
>         if (!err) {
>                 memcpy(&info, &reply.hw_info, sizeof(struct hw_info));
>                 hw->pfvfnum = le16_to_cpu(info.pfnum) & GENMASK_U16(7, 0);
>         }
> 
>         return err;
> }
> 
> /**
>  * mucse_mbx_sync_fw - Try to sync with fw
>  * @hw: pointer to the HW structure
>  *
>  * mucse_mbx_sync_fw tries get sync to fw hw.
>  * It is only called in probe
>  *
>  * Return: 0 on success, negative errno on failure
>  **/
> int mucse_mbx_sync_fw(struct mucse_hw *hw)
> {
>         int try_cnt = 3;
>         int err;
> 
>         do {
>                 err = mucse_mbx_get_info(hw);
>                 if (err == -ETIMEDOUT)
>                         continue;
>                 break;
>         } while (try_cnt--);
> 
>         return err;
> }

This looks O.K.

     Andrew

