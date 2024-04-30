Return-Path: <netdev+bounces-92279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E33D8B66E6
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C379DB22683
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 00:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0D063D;
	Tue, 30 Apr 2024 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ1Uid8j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5A4C96
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437075; cv=none; b=DJdqJedN/rXyFCYLmIRyBBe2fUqPxz1QGyLKtLrSZaF3VinpNHO3mqJJ1+tbTh3kjqJ7C6sqpXrDTdTRe9+j4jmVtlZ/Y4JX8TV+NyJXIPV3vsiN4M4qfgorWU27Z9o5/OvQkGU43LJ+Liz9rLvu4gKxNfJ0lsZ00cFGh+LJb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437075; c=relaxed/simple;
	bh=r9/8X8qk0hYHI27n5oqEY6xWu4CebjPyy9djXLR3PBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZN07iMJRmp9AN8s1xkuUzOcat1bosq+bfZ7lm5Py6uy1jYKm0MllSGNcJJqc6plqm+yyUSX4lG7a45ZhfRbOu44bQBGNfi3yS1cOI9150xgRewZ3TP6DdqPigj+lWeBanEf/HI80KE88ELz02hH1O1qrNPBqE3oqecZc7iBhlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ1Uid8j; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572229f196cso5209174a12.2
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 17:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714437072; x=1715041872; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KyYWouGv3DqqlPUwTb+HH9fxstBjY8jH3IJ7DDdzyrk=;
        b=IZ1Uid8jbnqUvzG16qsfgU6dEi/4ENtB7v6ezZBhjs+1QXp9fu8YLEp24y6W88scUG
         Qz2DnHfpSQ3FYNQXX33eB5+vE7H3KcBEw2klF8eJCSSxIXNNo8cEr6Cxmpg4ykiWDA06
         CVSJWfVBGtTUQwYUbykUMASR9pPcgB6ZtWfqzMevgJojvlcN8HbfZer+fDwsrPkOenT2
         B93CtevXel6KnbWj7eRsGijSe6AC/NL2QZAYmb69TC4/U7I2OKZcSS4tZOWsDYIpppWQ
         7gd+53cMJDLEfrsPXyfS7qC+32Q4fMF3PKF8cRNf5DXYGkgDPg0pNB1dIKnUb2wknSgo
         COLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714437072; x=1715041872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyYWouGv3DqqlPUwTb+HH9fxstBjY8jH3IJ7DDdzyrk=;
        b=qbbm4+77Yi8pJhvhmrKXmlyKVPfBXU/AszExq4QMWOWB0hCu+0QqXcU7hHPlW/Yo59
         gqJn0Ewy9ID2mRcwtMfxE2J+/e2ds4hsG+ij1RAmCI7T4nxv3V94cVqED4841VjCTtUp
         vt3lyVkM03eaVmMBnfOuCTSwAyAXdfmE1/dSYKtAgjMBvEgrpnleSmWl6+P7d+ezZP6Q
         JiJwAU3XG50iNlu2JVH5DcGfrfno6g720Hl8FC/h4e0e8XAThSpH9l/SgMnnW65qhAow
         //RRWn/W05OzC4vyp0K3qq3lm7cxHLg6Rt+5Gz1yIX7qkTMEqVEnVX9c6klTgUX+caIO
         DFRg==
X-Gm-Message-State: AOJu0Yw3Z7Pcq0vdUOo08cY+f5pL+WliMTx+BlLs74PqKNPR9GsaTEpu
	FxDuj7n+ma4cKKj8aH1UWaUEfuZpzTFnajR8R7a5luMKdoUiSjBGVjBFCPed
X-Google-Smtp-Source: AGHT+IGbCtPt00kcBJ4NbzOmHXYbzF4eEbcXOt2/cQRrx8pFUtZPDOcShwHGg1SCPh0bcuQLe437mg==
X-Received: by 2002:a17:906:af19:b0:a58:d757:6cfe with SMTP id lx25-20020a170906af1900b00a58d7576cfemr6810299ejb.6.1714437071378;
        Mon, 29 Apr 2024 17:31:11 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d70a:9c00::b2c])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709064f0400b00a58a4e08893sm6090695eju.104.2024.04.29.17.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 17:31:10 -0700 (PDT)
Date: Tue, 30 Apr 2024 03:31:08 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: update the unicast MAC address
 when changing conduit
Message-ID: <20240430003108.4dyjlavsledkbvot@skbuf>
References: <20240429163627.16031-1-kabel@kernel.org>
 <20240429163627.16031-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429163627.16031-3-kabel@kernel.org>

Hi Marek,

On Mon, Apr 29, 2024 at 06:36:27PM +0200, Marek Behún wrote:
> DSA exhibits different behavior regarding the primary unicast MAC
> address stored in port standalone FDB and the conduit device UC
> database while the interface is down vs up.
> 
> If we put a switch port down while changing the conduit with
>   ip link set sw0p0 down
>   ip link set sw0p0 type dsa conduit conduit1
>   ip link set sw0p0 up
> we delete the address in dsa_user_close() and install the (possibly
> different) address dsa_user_open().
> 
> But when changing the conduit on the fly, the old address is not
> deleted and the new one is not installed.
> 
> Since we explicitly want to support live-changing the conduit, uninstall
> the old address before the dsa_port_change_conduit() call and install
> the (possibly different) new one afterwards.
> 
> Because the dsa_user_change_conduit() call tries to smoothly restore the
> old conduit if anything fails while setting new one (except the MTU
> change), this leaves us with the question about what to do if the
> installation of the new address fails. Since we have already deleted the
> old address, we can expect that restoring the old address would also fail,
> and thus we can't revert the conduit change correctly. I have therefore
> decided to treat it as a fatal error printed into the kernel log.
> 
> Fixes: 95f510d0b792 ("net: dsa: allow the DSA master to be seen and changed through rtnetlink")
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---

It's good to see you returning to the "multiple CPU ports" topic.

This is a good catch, though it's quite an interesting thing why I
haven't noticed this during my own testing. Especially when the platform
I tested has dsa_switch_supports_uc_filtering() == true, so it _has_ to
install the host addresses correctly, because DSA then disables host
flooding and not even ping would work.

I _suspect_ it might be because I only tested the live migration when
the port is under a bridge, and in that case, the user port MAC address
also exists in the bridge FDB database as a BR_FDB_LOCAL entry, which
_is_ replayed towards the new conduit. And when I did test standalone
ports mode, it must have been only with a "cold" change of conduits.

Anyway, logically the change makes perfect sense, though I would like to
try and test it tomorrow (I need to rebuild the setup unfortunately).

Just wondering, why didn't you do the dev->dev_addr migration as part of
dsa_port_change_conduit() where the rest of the object migration is,
near or even as part of dsa_user_sync_ha()?

>  net/dsa/user.c | 45 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index b1d8d1827f91..70d7be1b6a79 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -2767,9 +2767,37 @@ int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
>  	if (err)
>  		goto out_revert_old_conduit_unlink;
>  
> +	/* If live-changing, we also need to uninstall the user device address
> +	 * from the port FDB and the conduit interface. This has to be done
> +	 * before the conduit is changed.
> +	 */
> +	if (dev->flags & IFF_UP)
> +		dsa_user_host_uc_uninstall(dev);
> +
>  	err = dsa_port_change_conduit(dp, conduit, extack);
>  	if (err)
> -		goto out_revert_conduit_link;
> +		goto out_revert_host_address;
> +
> +	/* If the port doesn't have its own MAC address and relies on the DSA
> +	 * conduit's one, inherit it again from the new DSA conduit.
> +	 */
> +	if (is_zero_ether_addr(dp->mac))
> +		eth_hw_addr_inherit(dev, conduit);
> +
> +	/* If live-changing, we need to install the user device address to the
> +	 * port FDB and the conduit interface. Since the device address needs to
> +	 * be installed towards the new conduit in the port FDB, this needs to
> +	 * be done after the conduit is changed.
> +	 */
> +	if (dev->flags & IFF_UP) {
> +		err = dsa_user_host_uc_install(dev, dev->dev_addr);
> +		if (err) {
> +			netdev_err(dev,
> +				   "fatal error installing new host address: %pe\n",
> +				   ERR_PTR(err));
> +			return err;

Even though there are still things that the user can try to do if this
fails (like putting the conduit in promiscuous mode, and limp on in a
degraded state), I do agree with error checking, to not give the user
process the false impression that all is well.

However, this is treated way too fatally here (so as to "return err" without
even attempting to do a rewind), when in reality it could be recoverable.
When moving the logic to dsa_port_change_conduit() please integrate with
the existing rewind flow.

Keep in mind that the RX filtering database of the switch or the conduit
may be limited in size, and may really run out. For that reason, your
dsa_user_host_uc_install() call should be placed _before_ the
dsa_user_sync_ha() logic that syncs the uc/mc secondary address lists.
Those are unchecked-for errors (partly because it's very hard to do: you
need to synchronize a deferred work context with a process context), and
they could easily fill up the filtering tables of the conduit. So let's
prioritize the (single) standalone MAC address of the user port.

