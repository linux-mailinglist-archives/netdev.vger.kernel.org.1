Return-Path: <netdev+bounces-224614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB1B86F27
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F02216F91A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330722367D9;
	Thu, 18 Sep 2025 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GhP0lHS0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14BD528
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228401; cv=none; b=N6uxCIDx40KJueczA+fWBpGs3DXgzCkEU62hGl40S4UeDwskCvc0YCfqeTGQi/m4LqkoINwD4Or6zIH0pLilv0WYbpihLtm2HOMR+DqR9WaUuv/QgTlwS2WfJaU/9q/K53S9xDZ45owBrxYwPVPlCdCTNFwkiTkaG/9y9GH207s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228401; c=relaxed/simple;
	bh=DELVBX02WLsyB4lVNKxfitpruiwhJEPmtGd4dRnXDGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwQBQaPlb8Pzo6g+TLXDThA+R6LX4DbFdNDKREKzqK9cR/AYk9AQvnUvtT8AexxX9PzNcgDJYj6wwXYEWQ/2TBcyBzICdIsn/b73VgLPUYQ3Z8A8qzdA9yRrGKwB8jfxY11TcDAckhc1SvTxkOpO25EjJkx5dJgJfcyo+fxQABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GhP0lHS0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5vVotgOLf0KYXpvQTXN96FnJJ2WD+3YI8jibS+wn724=; b=GhP0lHS0ph3Zrpcz7Xm7QN35xz
	YuakG/DOMlaprdauXZoo80mutbcRc98p7A42KvVcFOjhUrOX9NW00Z225LVG/FJFKaysMbJWeHepL
	GRewiW0nLiAAZd1Ztwb4YxBEyh7Jx1gsf6E9s6jNpk7Vn9WU0E6Skd2YsZCD1rGY5MYw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzLWW-008sJD-FD; Thu, 18 Sep 2025 22:46:36 +0200
Date: Thu, 18 Sep 2025 22:46:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 04/20] net: dsa: mv88e6xxx: split out
 set_ptp_cpu_port() code
Message-ID: <37af36f3-0df2-4433-bd45-4d4c316e7a8d@lunn.ch>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIbA-00000006mzQ-1B8y@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uzIbA-00000006mzQ-1B8y@rmk-PC.armlinux.org.uk>

On Thu, Sep 18, 2025 at 06:39:12PM +0100, Russell King (Oracle) wrote:
> Split out the code which sets up the upstream CPU port for PTP. This
> will be required when converted to the generic Marvell PTP library.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/mv88e6xxx/ptp.c | 42 ++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
> index f7603573d3a9..b60e4f02c256 100644
> --- a/drivers/net/dsa/mv88e6xxx/ptp.c
> +++ b/drivers/net/dsa/mv88e6xxx/ptp.c
> @@ -444,6 +444,27 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
>  		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
>  };
>  
> +static int mv88e6xxx_set_ptp_cpu_port(struct mv88e6xxx_chip *chip)
> +{
> +	struct dsa_port *dp;
> +	int upstream = 0;
> +	int err;
> +
> +	if (!chip->info->ops->ptp_ops->set_ptp_cpu_port)
> +		return 0;
> +
> +	dsa_switch_for_each_user_port(dp, chip->ds) {
> +		upstream = dsa_upstream_port(chip->ds, dp->index);
> +		break;
> +	}

I think you can use dsa_switch_upstream_port(chip->ds);

It will look less odd than this loop construct.

> -	if (ptp_ops->set_ptp_cpu_port) {
> -		struct dsa_port *dp;
> -		int upstream = 0;
> -		int err;
> -
> -		dsa_switch_for_each_user_port(dp, chip->ds) {
> -			upstream = dsa_upstream_port(chip->ds, dp->index);
> -			break;
> -		}

Although i see you copied it from here. So keep it if you want.

	Andrew


