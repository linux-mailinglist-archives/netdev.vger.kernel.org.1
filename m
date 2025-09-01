Return-Path: <netdev+bounces-218909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B9DB3F022
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DDC2074CD
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C472749D7;
	Mon,  1 Sep 2025 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0URVk/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0F1E868;
	Mon,  1 Sep 2025 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760234; cv=none; b=puEFIjzrqp08pFl6reMO0HcqPA73YzP9IPDeIAlqO2MQ3MeMKSgrr/2kpzPtEBJZes27CgE3rqF349edXME3OBF0X8c1wpn2BiEFUMddosduIhlhxIdum+DjuT+LjILWMxKr8VKl35WhTp/AiII0HHO+4DITwBW/0vC0If3LP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760234; c=relaxed/simple;
	bh=vEf+v35veVMPK8oik7sxeMjUD3BsqjaP57XbnUyh6vI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oi5GGXVZocHJtx+jo10JGOHI7jm5w1IwS1HD+byStrSz+63Svc08is7Mfb0OERQaszEeQekj+o/Xdw7ZFW3oMJvWIHFYmg2sDHz2gcPxZA8AbJYRojy3q0DDqsgpUTYdtYVlCkQoIrc/hpbEYC3pGB1lUJRtAQPnXmuJTIR92oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0URVk/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403A1C4CEF0;
	Mon,  1 Sep 2025 20:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760233;
	bh=vEf+v35veVMPK8oik7sxeMjUD3BsqjaP57XbnUyh6vI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u0URVk/iEH9BcJRB8GQ6HwFcRggKjzsYaSuhex+m+0KayzHOfldbKmMNLEe/jDpRZ
	 N0aQQVaks3CPm3e8B8gSIXsEcYkY6KRCO2u+Kefn1ONSs5Hbyu7ZseH7KPtBDDYAi4
	 T2SDucLYl3QjL/5LggpNRkRuMK6XZyiTttPSYiGowJET3IBc/onAEfym8m9RpnyCxR
	 IKAxcOD4f5amSnlNU9OPiyYx19etP2MkCmT5e/L4Vu65EcVkUXD5wYL2+vR7ggX0Rd
	 Bx9wb0Icg/SQBfOxP+Yso68JFwNke4xcgzTDdcW0Ldrr3n6HKMvyguCLx/HrM36Tuy
	 MKhJw0fkze5nw==
Date: Mon, 1 Sep 2025 13:57:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Steve Glendinning
 <steve.glendinning@shawell.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1] smsc911x: add second read of EEPROM mac when
 possible corruption seen
Message-ID: <20250901135712.272f72a9@kernel.org>
In-Reply-To: <20250828214452.11683-1-colin.foster@in-advantage.com>
References: <20250828214452.11683-1-colin.foster@in-advantage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 16:44:52 -0500 Colin Foster wrote:
> When the EEPROM MAC is read by way of ADDRH, it can return all 0s the
> first time. Subsequent reads succeed.
> 
> Re-read the ADDRH when this behaviour is observed, in an attempt to
> correctly apply the EEPROM MAC address.

Please name the device, and FW version if applicable, on which you
observe the issue.

> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> ---
>  drivers/net/ethernet/smsc/smsc911x.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
> index a2e511912e6a9..63ed221edc00a 100644
> --- a/drivers/net/ethernet/smsc/smsc911x.c
> +++ b/drivers/net/ethernet/smsc/smsc911x.c
> @@ -2162,8 +2162,20 @@ static const struct net_device_ops smsc911x_netdev_ops = {
>  static void smsc911x_read_mac_address(struct net_device *dev)
>  {
>  	struct smsc911x_data *pdata = netdev_priv(dev);
> -	u32 mac_high16 = smsc911x_mac_read(pdata, ADDRH);
> -	u32 mac_low32 = smsc911x_mac_read(pdata, ADDRL);
> +	u32 mac_high16, mac_low32;
> +
> +	mac_high16 = smsc911x_mac_read(pdata, ADDRH);
> +	mac_low32 = smsc911x_mac_read(pdata, ADDRL);
> +
> +	/*

nit: netdev multi-line comment style doesn't place /* on a separate
line:
	

> +	 * The first mac_read always returns 0. Re-read it to get the
> +	 * full MAC

Always? Strange, why did nobody notice until now?

> +	 */
> +	if (mac_high16 == 0) {
> +		SMSC_TRACE(pdata, probe, "Re-read MAC ADDRH\n");
> +		mac_high16 = smsc911x_mac_read(pdata, ADDRH);
> +	}

> 	u8 addr[ETH_ALEN];

Please don't add code in the middle of variable declarations
-- 
pw-bot: cr

