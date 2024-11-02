Return-Path: <netdev+bounces-141226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3281A9BA15C
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 17:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A0728208A
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5687E19CC25;
	Sat,  2 Nov 2024 16:07:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51CB14B97E
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730563623; cv=none; b=UAtMzkihJYfRk0tSWjgJP3UBWpN9H1pMDliKymhtnOO8pamznV9UCd8XKstSROoiNl6zIMsX4wAGsBdOiZfCbJ/8fkP8egpxunGkAUruT89V4QJZ93ry1/gI9WOR//zVIXgX64Ts0zOzesrk/5FgBMXa8XPNql1FD885NhEbXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730563623; c=relaxed/simple;
	bh=oJzNWoPnfP64TD1o7Wjla2LUz02+MTHUEB3eKRMEelU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=aZY/vESwFRMdVKfsW8bn4xoLNyHdw9davA2Eom8OrLnY/jemiHD8Rh1pbqdVc7IiEtTk6/pby04fUiMETUpQFbIslT+QIf58aKuTYYUQ6DWVtVU0fPef8/MWwtpI6sHauGdTyeZd2pLRPgxcl/PssF6r49RUP3kRXM7qqhIcbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [185.122.134.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id B67A27D08A;
	Sat,  2 Nov 2024 16:06:59 +0000 (UTC)
References: <20241007135928.1218955-1-chopps@chopps.org>
 <20241007135928.1218955-13-chopps@chopps.org>
 <ZxYsWnWKPYyaoX79@gauss3.secunet.de>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, Sabrina Dubroca
 <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, Antony Antony
 <antony@phenome.org>, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v12 12/16] xfrm: iptfs: handle received
 fragmented inner packets
Date: Sat, 02 Nov 2024 16:01:42 +0000
In-reply-to: <ZxYsWnWKPYyaoX79@gauss3.secunet.de>
Message-ID: <m2r07tipr1.fsf@chopps.org>
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


Steffen Klassert <steffen.klassert@secunet.com> writes:

> On Mon, Oct 07, 2024 at 09:59:24AM -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> +
>> +/**
>> + * __iptfs_iphlen() - return the v4/v6 header length using packet data.
>> + * @data: pointer at octet with version nibble
>> + *
>> + * The version data is expected to be valid (i.e., either 4 or 6).
>> + *
>> + * Return: the IP header size based on the IP version.
>> + */
>> +static u32 __iptfs_iphlen(u8 *data)
>> +{
>> +	struct iphdr *iph = (struct iphdr *)data;
>> +
>> +	if (iph->version == 0x4)
>> +		return sizeof(*iph);
>> +	WARN_ON_ONCE(iph->version != 0x6);
>> +	return sizeof(struct ipv6hdr);
>
> Better to return an error if this is not IPv6

The version is checked prior to calling to only be v4 or v6. Removed the WARN call and made the comment above saying this more explicit.

>> +}
>> +
>> +/**
>> + * __iptfs_iplen() - return the v4/v6 length using packet data.
>> + * @data: pointer to ip (v4/v6) packet header
>> + *
>> + * Grab the IPv4 or IPv6 length value in the start of the inner packet header
>> + * pointed to by `data`. Assumes data len is enough for the length field only.
>> + *
>> + * The version data is expected to be valid (i.e., either 4 or 6).
>> + *
>> + * Return: the length value.
>> + */
>> +static u32 __iptfs_iplen(u8 *data)
>> +{
>> +	struct iphdr *iph = (struct iphdr *)data;
>> +
>> +	if (iph->version == 0x4)
>> +		return ntohs(iph->tot_len);
>> +	WARN_ON_ONCE(iph->version != 0x6);
>> +	return ntohs(((struct ipv6hdr *)iph)->payload_len) +
>> +	       sizeof(struct ipv6hdr);
>
> Same here.

Same.

>> +
>> +		/* We have enough data to get the ip length value now,
>> +		 * allocate an in progress skb
>> +		 */
>> +		ipremain = __iptfs_iplen(xtfs->ra_runt);
>> +		if (ipremain < sizeof(xtfs->ra_runt)) {
>> +			/* length has to be at least runtsize large */
>> +			XFRM_INC_STATS(xs_net(xtfs->x),
>> +				       LINUX_MIB_XFRMINIPTFSERROR);
>> +			goto abandon;
>> +		}
>> +
>> +		/* For the runt case we don't attempt sharing currently. NOTE:
>> +		 * Currently, this IPTFS implementation will not create runts.
>> +		 */
>> +
>> +		newskb = iptfs_alloc_skb(skb, ipremain, false);
>
> As mentioned above, __iptfs_iplen needs error handling. Otherwise
> you might alocate a random amount of data here.
>
>> +		if (!newskb) {
>> +			XFRM_INC_STATS(xs_net(xtfs->x), LINUX_MIB_XFRMINERROR);
>> +			goto abandon;
>> +		}
>> +		xtfs->ra_newskb = newskb;
>> +
>> +		/* Copy the runt data into the buffer, but leave data
>> +		 * pointers the same as normal non-runt case. The extra `rrem`
>> +		 * recopied bytes are basically cacheline free. Allows using
>> +		 * same logic below to complete.
>> +		 */
>> +		memcpy(skb_put(newskb, runtlen), xtfs->ra_runt,
>> +		       sizeof(xtfs->ra_runt));
>> +	}
>> +
>> +	/* Continue reassembling the packet */
>> +	ipremain = __iptfs_iplen(newskb->data);
>> +	iphlen = __iptfs_iphlen(newskb->data);
>> +
>> +	/* Sanity check, we created the newskb knowing the IP length so the IP
>> +	 * length can't now be shorter.
>> +	 */
>> +	WARN_ON_ONCE(newskb->len > ipremain);
>> +
>> +	ipremain -= newskb->len;
>> +	if (blkoff < ipremain) {
>> +		/* Corrupt data, we don't have enough to complete the packet */
>> +		XFRM_INC_STATS(xs_net(xtfs->x), LINUX_MIB_XFRMINIPTFSERROR);
>> +		goto abandon;
>> +	}
>> +
>> +	/* We want the IP header in linear space */
>> +	if (newskb->len < iphlen) {
>> +		iphremain = iphlen - newskb->len;
>> +		if (blkoff < iphremain) {
>> +			XFRM_INC_STATS(xs_net(xtfs->x),
>> +				       LINUX_MIB_XFRMINIPTFSERROR);
>> +			goto abandon;
>> +		}
>> +		fraglen = min(blkoff, remaining);
>> +		copylen = min(fraglen, iphremain);
>> +		WARN_ON_ONCE(skb_tailroom(newskb) < copylen);
>
> This is also something that needs error handling. This WARN_ON_ONCE
> does not make much sense, as the next line will crash the machine
> anyway if this condition is true.
>
> This is also a general thing, there are a lot of WARN_ON_ONCE
> and you just continue after the warning. Whenever such a warn
> condition can happen, it needs audit why it can happen. Usually
> it can be either fixed or catched with an error. Warnings
> should be used very rarely.
>
> In this case you can either make sure to allocate the correct amount
> of data or extend the tailroom with pskb_expand_head().
>
> No need to crash the machine here :)
>
> Please audit your WARN_ON_ONCE calls, I guess most are either not
> needed or the condition can be handled otherwise somehow.

As we discussed offline, these uses were not where value can actually be wrong, they were all originally BUG_ON() and meant to document the code assumptions/assertions and to catch future coding/review bugs.

This is not a style that is used by/welcome in linux kernel code so I will remove it's use.

>
>> +		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
>> +				      copylen)) {
>> +			XFRM_INC_STATS(xs_net(xtfs->x),
>> +				       LINUX_MIB_XFRMINBUFFERERROR);
>> +			goto abandon;
>> +		}
>
>> @@ -1286,7 +1729,11 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
>>  	int ret = 0;
>>  	u64 q;
>>
>> -	if (x->dir == XFRM_SA_DIR_OUT) {
>> +	if (x->dir == XFRM_SA_DIR_IN) {
>> +		q = xtfs->drop_time_ns;
>> +		(void)do_div(q, NSECS_IN_USEC);
>
> This cast is not needed.

Removed.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmcmTiISHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlzNUP/i6MCMml6XAmjHm/841ETKWdqZEFFAmf
rHlMkBBdAKMjJLY6+lcgI6hTkS+tf/m6UrblWe8wVs5WzsYZWCVwgCeu6gjM/qrE
sGJWJe1qTei6zs0K2kMP1wz8LfRGdsa8MzX3mD18tTJconMiJlDC5aEO/QS3i6Ej
y4a+/HvXkABOqVOfVo8NOl+01eTCiHgICiUXa/5wf7YoiY2aldNFQXeYv1nI+eUY
zC2lYfbLIAL00Z6jw4A8QtstLEKVXIYFhIiXOKQiDUaYlNu3iWqObTVFTCYrePZe
lYlvYXp1lWGq90wnNOS+bi3A/+BdE9C7y5saEpg9BPxO6Sl3Sq8lqAbMLBUWQujZ
YgfLX1IIXDOvMO4pacWlVuqMSUrY6o/KjXsPKhOU8Np0BkJaFKJ/dgYIYWs8M+Ct
ZiZlZwfih+6xfUSkVHsVB/3CLO7L6ohVay4v9m7iHezx7qV4/x1n9veRuEyxraRs
6ID0XTXbt0niqmb6HvBo1JLgpqfYC4g5Nnb77+u8brDrpvBcD6nawyUA3BfkW9H0
ZfRLWo/vMSQaFtEQ1LGfgna/1jlGIDNMeSiiOUMaad1+cEdsiSqxsAw6J/IELxiQ
STgJcqnEQJYpTJwi2i1salqKcQg2CmyzHLoOT710GmWpdA6aDrTepINJ76KUYsLu
vZf/alxiUge2
=uRSK
-----END PGP SIGNATURE-----
--=-=-=--

