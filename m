Return-Path: <netdev+bounces-202401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D910AEDC0D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE03B16C963
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCAB284665;
	Mon, 30 Jun 2025 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQBL7A6z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD1C1B4F1F
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284509; cv=none; b=r20zIjuqC90R1YrX1R9ggtPn/Hh5FeAFbyq2YV/B6AR8bp5mo61jPNxF6QSPlMWEKNBI9czg/C55585EDEFWmntZ3XZUiFJe6JfWWjtohmmw+rc/mWlNtTUPmZZP2Fwaxc+BvCJaWXANsLBM9ufVEPzlp1r1maI99pmnoIYLwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284509; c=relaxed/simple;
	bh=LzTFpWpxZyHI92NgPPBbfs4npMCQOd7bT2TOc4DXqPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU3hO1wqN+ezVhzrox5HBjrQb444JeoB2HqsMPB+ZcS/TWzl0VgEiWd+3A8HuAeo4WjxCIFALt5xXTd9x/1laRajZ4D2iHZHPiR34+QzAEqpaBo4IxrcXKBfiSYMOf6CFi+OXv5mEa9B2GCScJ4vgeEEidL/En47v/0/X0A+e/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQBL7A6z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751284506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3UpL9XpHPaPQprAYLhgHMcy3HDDwfmg1McyZZUeR4U=;
	b=NQBL7A6ztAALUIyEI5rClGASM/hNz9FI67q1XcZxE09tq25abA+3JG+ACHcUVZEI1QZRGY
	W2s1tDoYRrtSwGjfRkn1XTCRxi4BpJUqGaE3WGWfqg5oEugATpIASFF8HvrV0bY410rWGM
	e61KyILEeDn0OL7AUuA5PVUdViNyUKQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-n1BxGc12M7iih4onufrvDQ-1; Mon, 30 Jun 2025 07:55:03 -0400
X-MC-Unique: n1BxGc12M7iih4onufrvDQ-1
X-Mimecast-MFC-AGG-ID: n1BxGc12M7iih4onufrvDQ_1751284502
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a58939191eso640632f8f.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 04:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751284502; x=1751889302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3UpL9XpHPaPQprAYLhgHMcy3HDDwfmg1McyZZUeR4U=;
        b=FEFn66IIl+A3GKxAxTbC7k0zcLD62LNgVo9G3Ibz20pIDoiGYLWP1yZT3YG6NTuuo2
         u2NX+TGjB/fHpTAOc8ieBzgj/eZWhK/rZzRT+ENZRsr1YmlLogXhDmV5TNWsN98YIu3Z
         BGCUt/vFxTUTGavYabYCM9yc4IA6+6S2nRzSDaO8A7246BUOzFUTfxPTQUaK/eQVnNtY
         XRHBQr1xXazHZNZfR1ZSK2y7ikxC1cKf8oOkBcHx9T3DZcTaakhzBzKwgXHNpshIQK2a
         vCWTnfNZjC2Q8ZL59/+KsSRB/z3RfWX+ZWO9XKZLLU/K/3h/e1eO1CvRwSVA0tIepnxm
         7MEA==
X-Forwarded-Encrypted: i=1; AJvYcCW2WSSt5O+ZFF7LqvBcO4Jy1tvK8Yozd3ccd8MTml+W56TPrxSQFQCO9FQo+irMKfoSlxPXmKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBjzbR8jkWe8+oowov72d2B20eKNZZuQsdvYpkBDwWHRLwL9e
	fNsjeIuB6ARiBzdbQ2POei6cenFFwhkT6d1JXYZ/4nwpQvmuF1NjITv7FQMNojuZL+zX6ZmhJcB
	M8WtYKm+PWv9dSG2Mi/Nq+qNEwc6aKIw8r9NiuCIF7OiBnmB/C14j2zKzZg==
X-Gm-Gg: ASbGncsFvipQbAAzprk6FzhuuaRibRj0gvnUjfaxLP//ihAyc9Muy4N/xltroElXKgZ
	yuEkNQYCwyy+4FtRI747QHzHJDW6CHr2ijWfCybZStmoWkzms+QeAeyahww+lpKbWkR3158NNnc
	U4U5zk6CYBAI8yNZblKax3kyw5EJEhWfJgoCMhpbdG6xXhwNK2y78i+3bRfdIKkZ2LEwU/p+x9H
	xgYoDhk7FWeJLy8jRUvFyfXyQUlVkfbWlTeGWIRpb7f7YFP8HGU8x7jONBWAw6if0BC7/AQgwKv
	39ifPBDWCLPhgUt4XQnebAHqF5gAqBIWsCmy4gvGthuCMl+EXbx1yFCt3uTklTCXxRvMeKQ0+vO
	tPw==
X-Received: by 2002:a05:6000:2dc4:b0:3a5:2182:bce2 with SMTP id ffacd0b85a97d-3a8f4c00b15mr11300699f8f.17.1751284501872;
        Mon, 30 Jun 2025 04:55:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5tP4Rk1GFfnasgGCow+Z8e0y7nuejBBHDuHkx9VTSZZb2kZ8DK5QzhCOqGdnsGGXOfGZ69Q==
X-Received: by 2002:a05:6000:2dc4:b0:3a5:2182:bce2 with SMTP id ffacd0b85a97d-3a8f4c00b15mr11300675f8f.17.1751284501442;
        Mon, 30 Jun 2025 04:55:01 -0700 (PDT)
Received: from debian (2a01cb058d23d60071afe2302af9653a.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:71af:e230:2af9:653a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f34csm10028500f8f.85.2025.06.30.04.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 04:55:00 -0700 (PDT)
Date: Mon, 30 Jun 2025 13:54:58 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Aiden Yang <ling@moedove.com>, netdev@vger.kernel.org, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	MoeDove NOC <noc@moedove.com>
Subject: Re: [BUG] net: gre: IPv6 link-local multicast is silently dropped
 (Regression)
Message-ID: <aGJ7EvpKRWVzPm4Y@debian>
References: <CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com>
 <aGFSgDRR8kLc1GxP@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGFSgDRR8kLc1GxP@shredder>

On Sun, Jun 29, 2025 at 05:49:36PM +0300, Ido Schimmel wrote:
> + Guillaume
> 
> Report is here: https://lore.kernel.org/netdev/CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com/
> 
> On Sun, Jun 29, 2025 at 02:40:27PM +0800, Aiden Yang wrote:
> > This report details a regression in the Linux kernel that prevents
> > IPv6 link-local all-nodes multicast packets (ff02::1) from being
> > transmitted over a GRE tunnel. The issue is confirmed to have been
> > introduced between kernel versions 6.1.0-35-cloud-amd64 (working) and
> > 6.1.0-37-cloud-amd64 (failing) on Debian 12 (Bookworm).
> 
> Apparently 6.1.0-35-cloud-amd64 is v6.1.137 and 6.1.0-37-cloud-amd64 is
> v6.1.140. Probably started with:
> 
> a51dc9669ff8 gre: Fix again IPv6 link-local address generation.
> 
> In v6.1.139.
> 
> It skips creating an IPv6 multicast route for some ipgre devices. Can
> you try the following diff?
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index ba2ec7c870cc..d0a202d0d93e 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3537,12 +3537,10 @@ static void addrconf_gre_config(struct net_device *dev)
>  	 * case). Such devices fall back to add_v4_addrs() instead.
>  	 */
>  	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
> -	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
> +	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64))
>  		addrconf_addr_gen(idev, true);
> -		return;
> -	}
> -
> -	add_v4_addrs(idev);
> +	else
> +		add_v4_addrs(idev);
>  
>  	if (dev->flags & IFF_POINTOPOINT)
>  		addrconf_add_mroute(dev);

I believe that should fix the problem indeed. But, to me, the root
cause is that addrconf_gre_config() doesn't call addrconf_add_dev().

Ido, What do you think of something like the following (untested,
hand-written) diff:

 #if IS_ENABLED(CONFIG_NET_IPGRE)
 static void addrconf_gre_config(struct net_device *dev)
 {
 	struct inet6_dev *idev;
 
 	ASSERT_RTNL();
 
-	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev)) {
-		pr_debug("%s: add_dev failed\n", __func__);
-		return;
-	}
+	idev = addrconf_add_dev(dev);
+	if (IS_ERR(idev))
+		return;
 
 	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
 	 * unless we have an IPv4 GRE device not bound to an IP address and
 	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
 	 * case). Such devices fall back to add_v4_addrs() instead.
 	 */
 	if (!(*(__be32 *)dev->dev_addr == 0 &&
 	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
 		addrconf_addr_gen(idev, true);
 		return;
 	}
 
 	add_v4_addrs(idev);
-
-	if (dev->flags & IFF_POINTOPOINT)
-		addrconf_add_mroute(dev);
 }
 #endif

This way, we would create the multicast route and also respect
disable_ipv6. That would bring GRE yet a bit closer to normal IPv6
lladdr generation code.

Note: this diff is based on net-next, but, without all the extra
context lines, a real patch would probably apply to both net and
next-next and could be backported to -stable.

> Guillaume, AFAICT, after commit d3623dd5bd4e ("ipv6: Simplify link-local
> address generation for IPv6 GRE.") in net-next an IPv6 multicast route
> will be created for every ip6gre device, regardless of IFF_POINTOPOINT.
> It should restore the behavior before commit e5dd729460ca ("ip/ip6_gre:
> use the same logic as SIT interfaces when computing v6LL address"). We
> can extend gre_ipv6_lladdr.sh to test this once the fix is in net-next.

Yes, I fully agree.

Long term, I'd really like to remove these special GRE and SIT cases
(SIT certainly has the same problems we're currently fixing on GRE).


