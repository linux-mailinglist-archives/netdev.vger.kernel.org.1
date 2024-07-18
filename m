Return-Path: <netdev+bounces-112007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FBD9347E7
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 08:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E22D1F22EF3
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114513D0AD;
	Thu, 18 Jul 2024 06:16:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC3282EE
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283367; cv=none; b=dFeuvaJUQuPUOIcvNFr5aPWjZbbh487oK1KPJ5Yx4vwEErmLRPcC68QGdlfC8xk21qZUT8ib1jIQcnQt/dH9WAe0MiHigNoIX0oXB6WOt3699wCl30ncncQiDIwARkHy2o6uSM579xQGrbm9mJ//YdI+l1JSdg7NUrTIe3BYm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283367; c=relaxed/simple;
	bh=eZXHLFiK9reFWlMMLXm/+to3LMCYDYBwubXY5fnxWUI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=VrJN2W4lnwc3JiDUZ11XmkpjKoEO+SJRRFsst17Vg6HAgkXeEwffMcok10cwBh32+a5W6zTioUAEaBdkKCjFm38v16uBZ+D537V3+WcdsC4DFh2Fo4yyguM9sH75+Eg+p0EaDl9Xgb5hCm+fPlvTMNG5PwTBIGmCV1uZJA+cQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [50.229.122.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 673A97D06B;
	Thu, 18 Jul 2024 06:16:04 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-13-chopps@chopps.org>
 <20240715131619.GE45692@kernel.org>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Simon Horman <horms@kernel.org>
Cc: Christian Hopps <chopps@chopps.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian Hopps
 <chopps@labn.net>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5 12/17] xfrm: iptfs: add
 basic receive packet (tunnel egress) handling
Date: Wed, 17 Jul 2024 23:14:53 -0700
In-reply-to: <20240715131619.GE45692@kernel.org>
Message-ID: <m2zfqfcjj0.fsf@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Simon Horman via Devel <devel@linux-ipsec.org> writes:

> On Sun, Jul 14, 2024 at 04:22:40PM -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add handling of packets received from the tunnel. This implements
>> tunnel egress functionality.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  net/xfrm/xfrm_iptfs.c | 283 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 283 insertions(+)
>>
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>> index 933df59cd39d..0060f8825599 100644
>
> ...
>
>> +/**
>> + * iptfs_input() - handle receipt of iptfs payload
>> + * @x: xfrm state
>> + * @skb: the packet
>> + *
>> + * Process the IPTFS payload in `skb` and consume it afterwards.
>> + */
>> +static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
>> +{
>> +	u8 hbytes[sizeof(struct ipv6hdr)];
>> +	struct ip_iptfs_cc_hdr iptcch;
>> +	struct skb_seq_state skbseq;
>> +	struct list_head sublist; /* rename this it's just a list */
>> +	struct sk_buff *first_skb, *next;
>> +	const unsigned char *old_mac;
>> +	struct xfrm_iptfs_data *xtfs;
>> +	struct ip_iptfs_hdr *ipth;
>> +	struct iphdr *iph;
>> +	struct net *net;
>> +	u32 remaining, iplen, iphlen, data, tail;
>> +	u32 blkoff;
>> +	u64 seq;
>> +
>> +	xtfs = x->mode_data;
>
> Hi Christian,
>
> xtfs is set but otherwise unused in this function.
>
> Flagged by W=1 x86_64 allmodconfig builds with gcc-14 and clang-18.
>
>> +	net = dev_net(skb->dev);
>> +	first_skb = NULL;
>> +
>> +	seq = __esp_seq(skb);
>
> Likewise, seq is set but otherwise unused in this function
>
> ...

These are another artifact of the splitting the commits, they get used in the later commits to this file. In any case I've removed them from this particular commit in the meantime.

Thanks!
Chris.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmaYsyMSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlsfsQAIloKENsMi4kfvgFeU7jGkUQwWGfoFfh
XkABn5GNV9uhHKMYZlXN3h/+0VSNf7/8cb2tAgPGsM3Pv5lAUNHddrJEFRsfsYBD
GXm9yC16Rf/MSdctLQ0WTvSLFNadalRndJcDfTl7C6IslCabaMgFSEFrStJ72m71
10svNJk82u6uv/gSvuRXwAIf6wlLuOXzHoZHjnHDfOsj7AO3tO7nByixI1PMLiLU
X19qOLIcqOSdaMDI75GQsMt+JboBaKkd9AdF+8tq3Dq/IOhWX6vG4BhU0NTPVqJn
ro/XISjg3CcTF1M+IPFwR5uQ75AksU4BkKgaOd1GXRa0wjFwXWGTyqUS6DnSKG0Y
5gbYen8TyI+d3Oi7G5AzGEVr+xEWE9KIquMOlIQphda1xbhQpDkpsovGQ69WvEtc
t1JHQVZ+tNDD0Ucm6L/yOwSzsF34R4+IWtnNnOilgANiz86Awg88AR7XnJCinkFP
w2rUlg+t8N82lNvGz2tkazmDwhF5iv5yyF7E67uTf7EAqqVVAvo9NSPq94FV4oRS
ICcPQU8p65/xErt7P+zILRop2Y6EK7QPrAX16Fuabd93RvX5cPR+pa0I90JZvfpn
eCu0iS7iEk9BDWlGUzOey7kz+VZxxUKXR9HuXq2yOIiENYWUD/hV7A+G5E0gKK0b
9F60XWlI2532
=6YV7
-----END PGP SIGNATURE-----
--=-=-=--

