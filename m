Return-Path: <netdev+bounces-152132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF4B9F2D0F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4120B1882FC5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27EA200B8A;
	Mon, 16 Dec 2024 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oGIgcC2A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900D2AF03
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341641; cv=none; b=EQb0fHDKWzYk5I0rV3UpBvVD4FjwwGQXM1z4GAVk7mLqsX248O+HmsNUjsxfGwOk2lcz/m7QvCcsgtc7iK8aWTVcqAyW/Thg70erujeIy6YV+FfXpbWzv7f12RsGLy7csdi9BU4+y9l0FYtvAE/7vcvGkenEAt4CTc1sVP+Am9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341641; c=relaxed/simple;
	bh=xS9hPm/14LVu+UgX6xBs4KgQFE7LLBLHKlOGhseoChc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNUEVIMk49UCk4jajgTq4jk8QVrCi0s3FCI2iFfxFbSqqouJi7Sw2sAgK0FZW9OmaYP4BJhxXVp0/ZhVMmwA4Y07RtT60n4gYNhG7vTLGrb++eulw9UncdCif1NPkAoNHuMoHJes5F24fhzomrb+vIHwwzGlaxaEzxrX1vALIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oGIgcC2A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YfrD2qcCtBRO2Ho2yurgEkP0JD/5CRWitflNlTmQAJs=; b=oGIgcC2AmsfufmedAPGpEtiW/w
	Il8ozHCrGQOiwLh1etMXCGbg1ZbSocyAC2ccJJQQnqRy3AspNZ3jKmSN0icaoGjNMmG40xzBrJfJy
	1OsEE/IcLQrCHV3uTXuQ9m+cI9wj44XtxUoBfbrhKDdAWxxD2cSl2ojlo7eCiSGKiZJY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tN7U6-000Zgl-2R; Mon, 16 Dec 2024 10:33:50 +0100
Date: Mon, 16 Dec 2024 10:33:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3] net: mdiobus: fix an OF node reference leak
Message-ID: <c7b55b3d-c7a9-4d42-a6e4-64148816a80d@lunn.ch>
References: <20241216014055.324461-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216014055.324461-1-joe@pf.is.s.u-tokyo.ac.jp>

On Mon, Dec 16, 2024 at 10:40:55AM +0900, Joe Hattori wrote:
> fwnode_find_mii_timestamper() calls of_parse_phandle_with_fixed_args()
> but does not decrement the refcount of the obtained OF node. Add an
> of_node_put() call before returning from the function.
> 
> This bug was detected by an experimental static analysis tool that I am
> developing.

Just out of curiosity, have you improved this tool so it now reports
the missing put you handled in version 3? I expect there is more code
with the same error which a static analyser should be able to find
when examining the abstract syntax tree.

> +++ b/drivers/net/mdio/fwnode_mdio.c
> @@ -41,6 +41,7 @@ static struct mii_timestamper *
>  fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>  {
>  	struct of_phandle_args arg;
> +	struct mii_timestamper *mii_ts;
>  	int err;

The netdev subsystem wants variables declared longest first, shortest
last, also known as reverse Christmas tree. As you work in different
parts of the tree, you will find each subsystem has its own set of
rules you will need to learn.
  
>  	if (is_acpi_node(fwnode))
> @@ -53,10 +54,14 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>  	else if (err)
>  		return ERR_PTR(err);
>  
> -	if (arg.args_count != 1)
> +	if (arg.args_count != 1) {
> +		of_node_put(arg.np);
>  		return ERR_PTR(-EINVAL);
> +	}
>  
> -	return register_mii_timestamper(arg.np, arg.args[0]);
> +	mii_ts = register_mii_timestamper(arg.np, arg.args[0]);
> +	of_node_put(arg.np);
> +	return mii_ts;
>  }

Although this is correct, a more normal practice is to put all the
cleanup at the end of the function and use a goto:

	if (arg.args_count != 1) {
		mii_ts = ERR_PTR(-EINVAL);
		goto put_node;
	}

	mii_ts = register_mii_timestamper(arg.np, arg.args[0]);

put_node:
        of_node_put(arg.np);
	return mii_ts;
}

This tends to be more scalable, especially when more cleanup is
required.

	Andrew

