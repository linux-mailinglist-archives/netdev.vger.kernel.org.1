Return-Path: <netdev+bounces-68067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BA845BAE
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4852942BC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7838E62141;
	Thu,  1 Feb 2024 15:36:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0D5F494
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801804; cv=none; b=bO7w+UDdk7V3QqEjd1ENgyEQf2SNzG8t3zxMGxKcBQtyT19IVgJuG1Mj9nTwIav5YL99LPLAEC5mIa3ZcDS0HhxfCW1CkwuuhPSbqXPmL26ZnrUpNpAJVHLEE2LvUk7L6Q3Oqg54yEK4JUr1A5tYI2SKD2uzpZn+sTRLOjNfGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801804; c=relaxed/simple;
	bh=E2Ur7TnblgfF+O/priD3//nvSlv/KH2Klfy3FtlFVAo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=hGAYgK8n1kinrIggn7kU+h67Fe1LSa67omXSXoZOeMlF5ZKHzAPq6dtRfKSOtG/BzfsJeam5wUZFg0MXlVfbnZQS3dJIH9zWwu31PwyeDWj0BFz+XhfQSIVJnxSvZ3EeuYPflgP4dIHI/SczcuI05l2uu3H0KghZrrPx0UFi0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 847FF7D05A;
	Thu,  1 Feb 2024 15:36:41 +0000 (UTC)
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-7-chopps@chopps.org> <ZWirsc6i-8n4qSAo@hog>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 6/8] iptfs: xfrm: Add mode_cbs module
 functionality
Date: Thu, 01 Feb 2024 10:34:49 -0500
In-reply-to: <ZWirsc6i-8n4qSAo@hog>
Message-ID: <m28r446vsn.fsf@ja.int.chopps.org>
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


Sabrina Dubroca <sd@queasysnail.net> writes:

> 2023-11-12, 22:52:17 -0500, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add a set of callbacks xfrm_mode_cbs to xfrm_state. These callbacks
>> enable the addition of new xfrm modes, such as IP-TFS to be defined
>> in modules.
>
> Not a big fan of bringing back modes in modules :(
> Florian's work made the code a lot more readable.
>
>> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
>> index 662c83beb345..4390c111410d 100644
>> --- a/net/xfrm/xfrm_output.c
>> +++ b/net/xfrm/xfrm_output.c
>> @@ -280,7 +280,9 @@ static int xfrm4_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
>>  	skb_set_inner_network_header(skb, skb_network_offset(skb));
>>  	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
>>
>> -	skb_set_network_header(skb, -x->props.header_len);
>> +	/* backup to add space for the outer encap */
>> +	skb_set_network_header(skb,
>> +			       -x->props.header_len + x->props.enc_hdr_len);
>
> Since this only gets called for XFRM_MODE_TUNNEL, and only iptfs sets
> enc_hdr_len, do we need this change? (and same for xfrm6_tunnel_encap_add)

You're right, removed. This particular code actually predated the callbacks.

>>  	skb->mac_header = skb->network_header +
>>  			  offsetof(struct iphdr, protocol);
>>  	skb->transport_header = skb->network_header + sizeof(*top_iph);
>> @@ -325,7 +327,8 @@ static int xfrm6_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
>>  	skb_set_inner_network_header(skb, skb_network_offset(skb));
>>  	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
>>
>> -	skb_set_network_header(skb, -x->props.header_len);
>> +	skb_set_network_header(skb,
>> +			       -x->props.header_len + x->props.enc_hdr_len);
>>  	skb->mac_header = skb->network_header +
>>  			  offsetof(struct ipv6hdr, nexthdr);
>>  	skb->transport_header = skb->network_header + sizeof(*top_iph);
>> @@ -472,6 +475,8 @@ static int xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb)
>>  		WARN_ON_ONCE(1);
>>  		break;
>>  	default:
>> +		if (x->mode_cbs->prepare_output)
>
> Can x->mode_cbs be NULL here? Every other use of mode_cbs does
>     if (x->mode_cbs && x->mode_cbs->FOO)
>
> (I think not at the moment since only IPTFS (and IN_TRIGGER) can reach
> this, but this inconsistency with the rest of the series struck me)

Still worth putting the guard in, fixed.

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmW7uogSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAln/0P/RSJMgZzsAa9crpj/uzKOQYAnes9+SQy
qJHMvhlJh3C9b2UNpeFygwZ11E5EEJEiYg3RoNXPSbCJPomRIy28QbwA2H+M5ap1
UelnrCnI5F+nLcjyZrpyIMhOgzWo7fBF9GZ9mTgcFhUHVNaGC+lk+YcquFqX04P4
pmaTZCgThO8RjBN3cKU8hb1c6uhZCp4ZvNRK0hUblDfL4cxGENeqNgIq8ju0it7Y
0bbCBuE2E7K9KoCoEmVxyCDvdTeDc2eUn2VuSlnP8zGUUWmYYXq/88d0zbw9/4+x
ccYM6mDd7jI88+W6ElDkaHfptjChyxEryyfkrU1ggKQ7vUAgZjxMnkpuG1Vva9ik
D80OA0PEzv9+quMmtCm5pLmbcS1Xk+Uee14prvibaUrL1kmrlWJ+vXIA4AepohgQ
rQPxbm+2VR1Ekjpdq3irlaT1E1V3cb8w7Si/S0N7C4C1LlXTomIrqmqNbB0timqn
fqXKmevNTFuWFepL/rtwyJYZX+FnczzfRzkF8XtnfMAX+89XwmtdC2oZsgUuhCYw
4U7xBXfywwEVdm7aDSswRYv6XM4n0Ganf7DYP2DQO5eKBMMJ1dwc45vJV8+ElXyQ
Wu7zsJaq1QljSpHTG1B0vfIU1p8dxCnq2LMfwytR+euKNUzp1Afdj8OmmT6fSnID
FchZsSnYBwlP
=YktJ
-----END PGP SIGNATURE-----
--=-=-=--

