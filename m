Return-Path: <netdev+bounces-215399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C88B2E6BF
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C763A5E5DEF
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D272D5A16;
	Wed, 20 Aug 2025 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OnQxEtux"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B62D4800;
	Wed, 20 Aug 2025 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722259; cv=none; b=O4rVhrh/c7wRdp3/3bJrqoiFqimWiypv4o3Ez7bTlk8gw0GE577mbeqDm6+Dil8Q0mcMrEjGzPqKmZuOW+okjq6wCTaFCswjGIhmhfK9bAsk5jGPpHZ1ZcLWPbPKmzuXML5fIwPqmoDMnno2qsO+zda1ss+f0YkALVZzoJV7HwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722259; c=relaxed/simple;
	bh=mzJrSGgLWaaK9dIVUygVgzh+uvRPafsPgrNRmpO+JUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7NUQ3IMEKIO6sQ6VAGDdesrqNchpFy1V0FDqyekCdlwOCOVMMuiuzeNtR0bcYU3t1KuQVreUT5PP26bzGUVKeTeOi0NgGZqtw0BLr/j7ZyrRzSEdYzBXCvnc3h0tUWPUyz/r3/rcE1nu9AYrIJO5EOF8WXdHGbgKqRobz5gZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OnQxEtux; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ywPbgTrNyryAZ/oJTEXQdASAJGgBTy0pxld5doHbKsE=; b=OnQxEtuxhGpxePdfeUf55gomsQ
	AYc3KJuNOlJCbM3Uma9chgrSiFvPB88bS64yOS5ZuoPKT6YNv08D/DANK3JB8KebIspkV5IkTI1px
	0+nhIVJ0ugbCSuPXuX/l+9zJNIRJuOj/BNjZHdfSYOIK8tByNEYvqUuPHUqwgvyGYk5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uopYL-005Mgb-Dx; Wed, 20 Aug 2025 22:37:01 +0200
Date: Wed, 20 Aug 2025 22:37:01 +0200
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
Subject: Re: [PATCH v5 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818112856.1446278-5-dong100@mucse.com>

> +static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
> +				 struct mbx_fw_cmd_req *req,
> +				 struct mbx_req_cookie *cookie)
> +{
> +	int len = le16_to_cpu(req->datalen);
> +	int err;
> +
> +	cookie->errcode = 0;
> +	cookie->done = 0;
> +	init_waitqueue_head(&cookie->wait);
> +	err = mutex_lock_interruptible(&hw->mbx.lock);
> +	if (err)
> +		return err;
> +	err = mucse_write_mbx(hw, (u32 *)req, len);
> +	if (err)
> +		goto out;
> +	err = wait_event_timeout(cookie->wait,
> +				 cookie->done == 1,
> +				 cookie->timeout_jiffies);
> +
> +	if (!err)
> +		err = -ETIMEDOUT;
> +	else
> +		err = 0;
> +	if (!err && cookie->errcode)
> +		err = cookie->errcode;
> +out:
> +	mutex_unlock(&hw->mbx.lock);
> +	return err;

What is your design with respect to mutex_lock_interruptible() and
then calling wait_event_timeout() which will ignore signals?

Is your intention that you can always ^C the driver, and it will clean
up whatever it was doing and return -EINTR? Such unwinding can be
tricky and needs careful review. Before i do that, i just want to make
sure this is your intention, and you yourself have carefully reviewed
the code.

   Andrew


