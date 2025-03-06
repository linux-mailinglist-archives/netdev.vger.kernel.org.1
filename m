Return-Path: <netdev+bounces-172488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A6EA54F6E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA24E169B3B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53222183CB0;
	Thu,  6 Mar 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ckyXPoQY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532E158851;
	Thu,  6 Mar 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275946; cv=none; b=q5SrXFOMynAU6QpTl3b6vfBbNOp/yulkFC/+IC2R5sByQSL86DTXWSkELC90cmGpNR5BCiveyN0xTSs5UQ3JQGs0hSfabERz9JCbOkfjIeg9TSa9XjfDCbwU/aFWnJ9oEHWj7NaKO7Wx8BQIfOGAkzADKuaar6EEJsXSWxobT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275946; c=relaxed/simple;
	bh=yc12q/9VarqqACL+4SSHR1iRG15Iia1AK1NmxQMuyMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMWvrGFA1ICvR+n7gLZUa4UBzvUTjOVtcATduDXyjVFXw1mBIMz7xos6hK2M0nD8pBoNlUhODiR7c5WvJyWG68LZvMwAqk0fbJNSj7tm8mnOaeXAcLpgmQhkDBgQfEdV16C1qMEbVGTkM5Xh6uVqEQvOjpgTUzPbTJfHaQV+ir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ckyXPoQY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DaZf4IUwIv+KPIOCFk7sNexM9Sy5HaExOZEMTIADKLs=; b=ckyXPoQY9UE0Sjp+gFeFoAZmA0
	VORoHsfWL5x2ltTzZIVm1sb0maXNpTUmMX2uzMptOm+xYwaEr7axcmgakLZnT+GLRkQTIuzAAYc2M
	x3zdMj6lDQ8ReNAKgxoBqPAjKI/NggVp2fbjDHAVlMmzZcBmLnf+vDjZBYWHptZpwIac=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqDPi-002qG1-AR; Thu, 06 Mar 2025 16:45:34 +0100
Date: Thu, 6 Mar 2025 16:45:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Joseph Huang <joseph.huang.2024@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/1] net: dsa: mv88e6xxx: Verify after ATU Load ops
Message-ID: <2376767d-e504-437b-b1b9-d1a41b02598e@lunn.ch>
References: <20250304235352.3259613-1-Joseph.Huang@garmin.com>
 <20250305202828.3545731-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305202828.3545731-1-Joseph.Huang@garmin.com>

On Wed, Mar 05, 2025 at 03:28:27PM -0500, Joseph Huang wrote:
> ATU Load operations could fail silently if there's not enough space
> on the device to hold the new entry. When this happens, the symptom
> depends on the unknown flood settings. If unknown multicast flood is
> disabled, the multicast packets are dropped when the ATU table is
> full. If unknown multicast flood is enabled, the multicast packets
> will be flooded to all ports. Either way, IGMP snooping is broken
> when the ATU Load operation fails silently.
> 
> Do a Read-After-Write verification after each fdb/mdb add operation
> to make sure that the operation was really successful, and return
> -ENOSPC otherwise.
> 
> Fixes: defb05b9b9b4 ("net: dsa: mv88e6xxx: Add support for fdb_add, fdb_del, and fdb_getnext")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
> V1: https://lore.kernel.org/lkml/20250304235352.3259613-1-Joseph.Huang@garmin.com/
> V2: Add helper function to check the existence of an entry and only
>     call it in mv88e6xxx_port_fdb/mdb_add().

You need to start a new thread for each version of the
patch. Otherwise the tooling does not always recognise it.

> @@ -2847,6 +2870,13 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
>  	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
>  					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
>  	mv88e6xxx_reg_unlock(chip);
> +	if (err)
> +		return err;
> +
> +	mv88e6xxx_reg_lock(chip);
> +	if (!mv88e6xxx_port_db_find(chip, addr, vid))
> +		err = -ENOSPC;
> +	mv88e6xxx_reg_unlock(chip);

unlocking and lock the registers seems to introduce a race
condition. Could another thread delete the just added entry before you
test to see if it was correctly added?

Please hold the lock across the entire operation.

    Andrew

---
pw-bot: cr

