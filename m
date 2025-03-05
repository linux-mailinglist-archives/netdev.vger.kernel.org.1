Return-Path: <netdev+bounces-172096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D0BA50341
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5272164C2F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315F24E4B4;
	Wed,  5 Mar 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hkfcbV6e"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C98635D;
	Wed,  5 Mar 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187675; cv=none; b=c4pxQgUbF0QA7VDJFRuJmQzwrWia26Z+vtR8l2CFuKpMQqv9JJ9Zxo6z3co1N4qwWQ7Fwc8mwZFZEW78Gm5tpPaokhc3/NqH2LltYS2+tLZ7mNcW02P95rQY4mt7LENHaZ990hzgCmFH4iadItjkMOW7yO/BM1y8S3LaTf0iPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187675; c=relaxed/simple;
	bh=oUCJHhTLkIkZYGtUC5LeznhRIkU1WBXDpdv7zgGdYkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnnzYTJV7iyqKWz+d6FcxhIq4WKi7T0PvSfcNmhyrZi3I0QhDYK70TQlRJuDZo66aa50QKkAqEKnCU/rPzCQWReMBesn6lh+pgsRTs73xTWoPT6n+K5jz0BROkDVtb9Eaq/hnWK18YG1lg5DkMv0klgWsaciVWj5T7cbtzKJSGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hkfcbV6e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tdeNOf9UKgSka2fVLsKE2/PskNhMSwr2fUM0473Ddao=; b=hkfcbV6eMLZ4tDrXgg1MvCQFUM
	aRdyQaT18pOCXfCzvZGlMWpE6SSrJxRKlYMH3PFJvGGOtUGPvnrddmy2WuJlDGc0mC4H+fSSw9ERr
	KvfhT1+sI27asFVYASQBKiJF9VXAI/WwK2fngp8pU4FAzYzTA5+xfb2PwL8GbhV3S4fg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpqRu-002Vtc-LE; Wed, 05 Mar 2025 16:14:18 +0100
Date: Wed, 5 Mar 2025 16:14:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Joseph Huang <joseph.huang.2024@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Verify after ATU Load ops
Message-ID: <2ea7cde2-2aa1-4ef4-a3ea-9991c1928d68@lunn.ch>
References: <20250304235352.3259613-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304235352.3259613-1-Joseph.Huang@garmin.com>

On Tue, Mar 04, 2025 at 06:53:51PM -0500, Joseph Huang wrote:
> ATU Load operations could fail silently if there's not enough space
> on the device to hold the new entry.
> 
> Do a Read-After-Write verification after each fdb/mdb add operation
> to make sure that the operation was really successful, and return
> -ENOSPC otherwise.

Please could you add a description of what the user sees when the ATU
is full. What makes this a bug which needs fixing? I would of thought
at least for unicast addresses, the switch has no entry for the
destination, so sends the packet to the CPU. The CPU will then
software bridge it out the correct port. Reporting ENOSPC will not
change that.

> @@ -2845,7 +2866,8 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
>  
>  	mv88e6xxx_reg_lock(chip);
>  	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
> -					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
> +					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC,
> +					   true);
>  	mv88e6xxx_reg_unlock(chip);
>  
>  	return err;

> @@ -6613,7 +6635,8 @@ static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
>  
>  	mv88e6xxx_reg_lock(chip);
>  	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
> -					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
> +					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC,
> +					   true);
>  	mv88e6xxx_reg_unlock(chip);

This change seems bigger than what it needs to be. Rather than modify
mv88e6xxx_port_db_load_purge(), why not perform the lookup just in
these two functions via a helper?

    Andrew

---
pw-bot: cr

