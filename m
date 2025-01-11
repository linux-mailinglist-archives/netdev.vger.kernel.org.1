Return-Path: <netdev+bounces-157339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6921CA0A02C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46601188D01F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF6D299;
	Sat, 11 Jan 2025 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czZdkPb8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97942110E;
	Sat, 11 Jan 2025 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736560229; cv=none; b=WQ2Ra3Z2Tuzium3INEjP5lATw2EerePT7fzFWpSQpnkOEumdd+24g3uOYEfRrUhsNhitJWqkqW/zqn4Gx9O40qPI9MiOQUvAMZnwzeEUwBIR+4wRvg76fBH/YZM2R5ojPPbaDKVPlh6SKJSRqd7byNOs7ftVx7XJRpiFn7KQAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736560229; c=relaxed/simple;
	bh=OTrfBxqXziWK4/NALxU6kTUsyDm1gXwHCpsAcFv4OAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWeDw4cdN0d07fa/gb8ogyXCb2ntlYFJZrC5mv7cMgYAwCpN0sMgseblyN5lcI8XnSICnYJ69yygPEldhlve/81stKh7WCIaMS6Ua/s+uBW0sVEFglKpwd9fF4Y6vjVIWMvGx7+/VJ4r90waZcE//7MVvz8dvEVSGS/47j+2cjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czZdkPb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECDBC4CED6;
	Sat, 11 Jan 2025 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736560229;
	bh=OTrfBxqXziWK4/NALxU6kTUsyDm1gXwHCpsAcFv4OAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=czZdkPb8t91DXs6LufK2qwEcTfHBEtzjIkpj8bf+VYac3Fl6gkTRRQ5xRprH20ap8
	 l1fNApcxDq+yumRKmL2+lLzNAHp2XATf83rP5+q1Vv79AI2yxgykgveHSKH7GRYs0C
	 rzZFzS9RLRU8BL+b/yj7Qv54bMymTOLhpBdezdog3y6igFUrrJVzV585Kq/7WTjanG
	 Cr655vj2S//pxh2arQ/dpanrRgRo1Za8unVeZO2AvPk5K0x20B+WR25hkLCE2pPNy0
	 laX4/KKEDs7OHpzI8U2ofCw2pYgMz0hMgLzLFXQf7vXomarj6J0RndCaLaKpxXXgCe
	 mZGPO4L6oVbjw==
Date: Fri, 10 Jan 2025 17:50:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v13 1/1] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20250110175028.528eeada@kernel.org>
In-Reply-To: <20250107172733.131901-2-admiyo@os.amperecomputing.com>
References: <20250107172733.131901-1-admiyo@os.amperecomputing.com>
	<20250107172733.131901-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 12:27:33 -0500 admiyo@os.amperecomputing.com wrote:
> +	//inbox initialization
> +	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
> +			    mctp_pcc_setup);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	rc = devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +	if (rc)
> +		goto cleanup_netdev;

I think this needs to move down, AFAICT mctp_cleanup_netdev calls
unregister and unregistering a netdev which was never successfully
registered is not supported.
-- 
pw-bot: cr

