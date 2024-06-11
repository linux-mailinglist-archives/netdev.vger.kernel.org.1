Return-Path: <netdev+bounces-102493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48590344F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D95E288855
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA71172BBA;
	Tue, 11 Jun 2024 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUeCMwrv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3132172798;
	Tue, 11 Jun 2024 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092223; cv=none; b=Hx8UIO4V/c74qQZe6OCSWZkLh6TOIcDWcTqkhVjFGjni4GQHQxxhDSMpNhpMLq0/N5U/ZmQc0MDbmgDvG85k2V7AhvoOXwbHW4F+ecWStbdMSLILcKQ9x5RBC0weLHImBcEVcRcqA4JbVEzqgxRJ6CKGgrQRbnFt9NZfPfNvkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092223; c=relaxed/simple;
	bh=/tWfB59NEBN9boSZX0IDoiDx1xvzNUOL2J/WjwuRFWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKqkAnnQIlV/IuMzcO464pgeFWTelL7R2KH+HiHwe/nuKhcSW6lxoXRiA5aejOj3tqCE6cmBq5iJiDK0++kT3j5IUT0080m+/VQJArf/yNX0aKmrPJkpdbc2buyrpkxq3QKvuiOOpQjGYt0ibVyv5DTtz8p0cXLXtMj4CvUp29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUeCMwrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9EEC2BD10;
	Tue, 11 Jun 2024 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718092222;
	bh=/tWfB59NEBN9boSZX0IDoiDx1xvzNUOL2J/WjwuRFWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SUeCMwrvxhqLlr0zpe5+fL9/zDEf8PGGNw7RCcB9OJoYjzN5vPWFyRda0mxoRNL29
	 F4zzdGCfeUkfbC5hrqArj1FZjH6sIVWG5mzBSiopy99vzybrrz5nOx7TS7CZC6gFtt
	 IlVPh4zTopZrqTkE06ntXQRp4V1Docol8KJjXPqj7j0YvAxeG2TnrhuDiUDcc14Yk4
	 gEZDCexr94ccaj1vjBcqwDoc4OVzguuV2bwby0QFQVKTVcdwUCJRTZpLXZlvnB3bLZ
	 J+Jx2EjSqDBSKWtcI/cBa0wDMGi8ZOTyz17UdwZBMiPB0dRbvxCzXCxD7h6KyVHBj7
	 /bUS4bUEUPUQg==
Date: Tue, 11 Jun 2024 09:50:16 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0] net: dsa: mv88e6xxx: Add FID map cache
Message-ID: <20240611095016.7804b091@dellmb>
In-Reply-To: <20240610050724.2439780-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20240610050724.2439780-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 17:07:23 +1200
Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz> wrote:

> Add a cached FID bitmap. This mitigates the need to
> walk all VTU entries to find the next free FID.
> 
> Walk VTU once, then store read FID map into bitmap. Use
> and manipulate this bitmap from now on, instead of re-reading
> HW for the FID map.
> 
> The repeatedly VTU walks are costly can result in taking ~40 mins
> if ~4000 vlans are added. Caching the FID map reduces this time
> to <2 mins.
> 
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 25 +++++++++++++++++++------
>  drivers/net/dsa/mv88e6xxx/chip.h |  4 ++++
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index e5bac87941f6..91816e3e35ed 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -1815,14 +1815,17 @@ int mv88e6xxx_fid_map(struct mv88e6xxx_chip *chip, unsigned long *fid_bitmap)
>  
>  static int mv88e6xxx_atu_new(struct mv88e6xxx_chip *chip, u16 *fid)
>  {
> -	DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
>  	int err;
>  
> -	err = mv88e6xxx_fid_map(chip, fid_bitmap);
> -	if (err)
> -		return err;
> +	if (!chip->fid_populated) {
> +		err = mv88e6xxx_fid_map(chip, chip->fid_bitmap);
> +		if (err)
> +			return err;
>  
> -	*fid = find_first_zero_bit(fid_bitmap, MV88E6XXX_N_FID);
> +		chip->fid_populated = true;
> +	}
> +
> +	*fid = find_first_zero_bit(chip->fid_bitmap, MV88E6XXX_N_FID);
>  	if (unlikely(*fid >= mv88e6xxx_num_databases(chip)))
>  		return -ENOSPC;
>  
> @@ -2529,6 +2532,9 @@ static int mv88e6xxx_port_vlan_join(struct mv88e6xxx_chip *chip, int port,
>  			 port, vid);
>  	}
>  
> +	/* Record FID used in SW FID map */
> +	bitmap_set(chip->fid_bitmap, vlan.fid, 1);
> +

wouldn't it make more sense to do this bit setting in
mv88e6xxx_atu_new() and clearingin a new function
mv88e6xxx_atu_delete/drop() ?

