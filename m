Return-Path: <netdev+bounces-145187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 661479CD9D4
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15BDAB248A9
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 07:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D1174EE4;
	Fri, 15 Nov 2024 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="SG0WR2Up"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306C523A;
	Fri, 15 Nov 2024 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655379; cv=none; b=EHguPAKAum+9S+FpgzoQOxQLkVaV492naNSszniQj01OwEMEwPsIWQjOyTlxSu4zhuwoXDkWiJC6lElqn4tO3qCGUqpMvZdtO2rqS7K+v9gbCjnVSJISWzYyAPIr39rQYKKYCnrFsKgx1C86fV0y12XYEpUJPEjYmFasbQnxK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655379; c=relaxed/simple;
	bh=N/BiYXgE9Jhe3HGAW2Ch4Co0N6fmwewtwH683zofX10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmiavrPTO+6pASGQ/BbMPJ53XyrOTBEKlBNcOj9EnU5fTniOE+A525A6nsM8oCo7+Ael0Ytonoxvo2a9LiITxOOJIjyiGHycOnxaM7rXBPzSrg32WuflprDJqjOJD5cY0HcaVI6mL/iPz48LLRaz+u0C5gQkLdsTj55zJATHocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=SG0WR2Up; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1731654886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9pgoHLWj9VbX/NrQJnb29ZRcPNXEydueCcQO0bd/UTE=;
	b=SG0WR2UpAqHzUaQRKm+gP7+Zc8GGYDTVxn3e5ZVXw36iLlm4UsX9RrwAHnkBpr2F1c0ZTC
	31GUNdD/c1Ct33/szlga0McFaQZ9l0O/0s6SEIzccdw0qi0dI73e4aUX3awT8DZlY3WyjG
	15ULoyZV9cz6NXchMMgftYzkSM2Xdls=
From: Sven Eckelmann <sven@narfation.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
 Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: Re: [PATCH-net] batman-adv: Fix "Arguments in wrong order" issue
Date: Fri, 15 Nov 2024 08:14:40 +0100
Message-ID: <2963697.e9J7NaK4W3@ripper>
In-Reply-To: <20241115045637.15481-1-dheeraj.linuxdev@gmail.com>
References: <20241115045637.15481-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3320950.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3320950.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Nov 2024 08:14:40 +0100
Message-ID: <2963697.e9J7NaK4W3@ripper>
In-Reply-To: <20241115045637.15481-1-dheeraj.linuxdev@gmail.com>
References: <20241115045637.15481-1-dheeraj.linuxdev@gmail.com>
MIME-Version: 1.0

On Friday, 15 November 2024 05:56:37 CET Dheeraj Reddy Jonnalagadda wrote:
> This commit fixes an "Arguments in wrong order" issue detected by
> Coverity (CID 1376875).
> 
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/
distributed-arp-table.c
> index 801eff8a40e5..781a5118d441 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -1195,7 +1195,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct 
batadv_priv *bat_priv,
>  			goto out;
>  		}
>  
> -		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, 
ip_src,
> +		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_src, 
ip_dst,
>  						      
dat_entry->mac_addr,
>  						      
hw_src, vid);
>  		if (!skb_new)
> 

Sorry, but this is wrong. We send an answer here ("ARP request 
replied locally") and of course we must then switch src and destination. 
Otherwise we would send the ARP response to the entity which didn't requested 
it.

This was already marked as false positive in Coverity a long time ago.

Kind regards,
	Sven
--nextPart3320950.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZzb04AAKCRBND3cr0xT1
yzM0AQCBQ1es0wPjpvjM/8+1H+eeP4x7a8mHMiUCI0cuKxT8yQEAmrAsexf+nPGA
Z1QV0TNZe100S6Fib9mpVuTh3xXCjAU=
=Orm4
-----END PGP SIGNATURE-----

--nextPart3320950.aeNJFYEL58--




