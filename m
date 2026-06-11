Return-Path: <netdev+bounces-298267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v9OaNUr6KmqN0QMAu9opvQ
	(envelope-from <netdev+bounces-298267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:11:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C9674574
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:11:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b=PEqluxwn;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="E RVxEAe";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298267-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298267-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7299632FB118
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F88397352;
	Thu, 11 Jun 2026 17:58:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DC38333B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:58:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200686; cv=none; b=RbfFn0+1RQ8lTRWysLIKYtTlURVgXHYlGb1qj5+gY0WrRK4YTQNQ5LYZRThsKXpUKx7StVi38Re36qi3DuocFjG9uva9Hsga8C0eOtq6dBwKWKZ25glJpjEZNGc2oHWXyGk0yEub3dULJ7WDJajHDUI91rmeHllN+CBK76yY+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200686; c=relaxed/simple;
	bh=Kh6ENXEvSpBtA+7GRc3J7wZRb6ZBVzAyNJcJz4GWyKE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MQXczDQyUQ4nMwpkzaePPCvqbr/tTUeX3utoz0AaW1aMks+A3Mr2hYocKb0Ybb08ujS/oNBLSYfMZdN78AI0PEsh9zWkRMSlSoWKjpXoB+PLA7E2oEUhJ8lHL2HJkGCaAPOP8r+LNeqJC7YeI1N56lURBRuY+Y13DSpu3JQcYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=PEqluxwn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ERVxEAew; arc=none smtp.client-ip=103.168.172.159
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 949D01400111;
	Thu, 11 Jun 2026 13:58:03 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-10.internal (MEProxy); Thu, 11 Jun 2026 13:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781200683;
	 x=1781287083; bh=PSI6vrXa62DLOtjxNMaKyTJ6p/iETJFSHoAb3s7WiEY=; b=
	PEqluxwn7x/wskvuTelASVFBOYSa7YjeG87NrB2cTkQ0NcmWS6yu7xXImKsgsLYG
	KMxlXtbrxlp9lOQD8ytzwqTRLsHNF472TQJ2BBNAYPWRqylJfw/OthD8C/HM5A5i
	K+V3w04qNGY+PA8OQG57eO1kIgmYS1Sm4q9yZ4fikLiosxQZhCL+RMG+ubqRuKx7
	2HfKv8oQG/9HqNKpi+4P8TTp2rcZEce+uAXNY/4SbL8p9GJSf/LXMSQUUZlIW1vr
	06PXP/4JK1ltQX793qft8MqrQrll/sXWd5Wpu0ySoyqJ9Q8oK62JG7qj1P6A9WA0
	blBwp47SaLU04VWnJ/NSZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781200683; x=
	1781287083; bh=PSI6vrXa62DLOtjxNMaKyTJ6p/iETJFSHoAb3s7WiEY=; b=E
	RVxEAewiOSo4MnzQi+dRtchiv0S4rrALPY1f3COWWc+vKsvRyI5/Te49PcbbWcSd
	AgrWrZL+uIX2NXzolYgHSAz1PkmvuVO+NCl4duEBsmC8rsmv3cM+4D0ae5ZGgZkN
	I3QlFAlcWBkDGgzZIwenN2Xz+SlN4bnewrQFtkrfSzXzaFrEUQoVcRIuIsQYTAOw
	NwpBQnFqP97TitdjLCnJ7M6I+WF8qHa2YYPFe+n4TW/udjr0BhX37hPXp7HH0gee
	c/waaA9W3FMmb4HbqfrruH9gdiS2V4NMztfdCgq969Z0gqKjj0WMkh61WdrEHEHF
	B6ux6Ao+ONZH622xcwHfQ==
X-ME-Sender: <xms:Kvcqak02ji_i7mj1nv1pn1EJFuZFZtxAAG_DRk_Pkf7VqDcKEnHDGA>
    <xme:Kvcqap4g4bSUTmI3nlZSFtvxeHJWDfGoLpCyx315ldO-tOFcQ3mAQqeRWkRgKUL8e
    egUPwhano0_x3S1K_7fDoZjcyH_48yxYeZ8MSOHy7nSbZS3RSGbRTEN>
X-ME-Proxy-Cause: dmFkZTERexda/n6nHvB5FwS/rRjWmUh0JBhh5WMoTpWyzfjUF4Kv35tZDANyGhOLm/OIXW
    TMoLnvVvrYntvMptIH+x0ZxLR9KbmBkTyC+m2L6yeCX5ObwMHtPZ/z0eM5U+1yDt5zg+z1
    qg01CBJz3Q/Nc1TluU9sPSSsxBsvDH+Zd8YqL926yR6badkDn/mpDF5qGAHtT2TF//WgOd
    IsvldxHpwzltHmoWkLll2pDTg3DcI9iJHhksCisn579Vm8ujKXOXPbFZQh1AIpn0j+99Cu
    KFkkIzwj8Fw8Px5zUoEkOuQ2ay+BysVBGrIYdgN7YA2PgSy2HWCzj3+PPNsORv0QUMNZWi
    SYcE2zLvnciGqqCjZBa/gLpja1Ye9vxZAGMyQW6CdfwYkQZAm622Z7PXJADGMjg6/UbS18
    5Kzm3aKSgaaxqlp+WBWBW2LG98UoyRCi9uEKbby4uWA2m5e6uEy2VnJ2Z8Cdi05MNwH0kl
    MFpBukyKvjsyeiXTImPimMgrtDRZ8LJZp6Y280KEg2ISYkgrZCPn5AzHeRoBVJvAvB7bgj
    qz064TQhHt2IG5wpy2e5DuMR/jOpegEz59lttzgIxeUGZfbnTd59e139A1pkUxI5gMyww1
    rQ6tVKlPMEWZrk9iIWRauxEc2dKPgbDpi+CCvAMW20DiwkoFPaadszKY9F5A
X-ME-Proxy: <xmx:KvcqalSzs1_ziHQyBO1pd7zluxjB4LHU0ijYR9hzG386OMyRuz2Bjg>
    <xmx:Kvcqap8QECyGcTAGSq56h4gFD-cdLogSRyVVojiwlOR8Kk2WstELRA>
    <xmx:KvcqauprkqJrQtvBCQwDxZrqhu1G0UrtzOzz8u6TeGTc91jNkYrKVw>
    <xmx:KvcqanU0sQuaRdLFtnj5pQPiR6UdjLZovp75ODUpTmG76tms3aQAfA>
    <xmx:K_cqamdPVXeheZhTvrahhzmJVxby3gWCiq3ibtVTXRM_YqV-qX-0bIYW>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A320A18E006C; Thu, 11 Jun 2026 13:58:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Jun 2026 19:57:41 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Paolo Abeni" <pabeni@redhat.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Xin Long" <lucien.xin@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Willem de Bruijn" <willemb@google.com>, "David Ahern" <dsahern@kernel.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>
Cc: "Shuah Khan" <shuah@kernel.org>,
 "Stanislav Fomichev" <stfomichev@gmail.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "Simon Horman" <horms@kernel.org>,
 "Florian Westphal" <fw@strlen.de>, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>
Message-Id: <60756eb2-8f4c-48cf-adb2-79228de6266e@app.fastmail.com>
In-Reply-To: <859702b5-0528-416f-9325-c13757d8463f@redhat.com>
References: <20260602093931.516281-1-alice.kernel@fastmail.im>
 <20260602093931.516281-6-alice.kernel@fastmail.im>
 <ea5ed9f7-daf5-4996-8c0d-84c2bb946be5@redhat.com>
 <6bdf5092-d877-4c09-b3a2-07a92b57fd54@app.fastmail.com>
 <859702b5-0528-416f-9325-c13757d8463f@redhat.com>
Subject: Re: [PATCH net-next v6 05/11] udp: Support gro_ipv4_max_size > 65536
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FREEMAIL_TO(0.00)[redhat.com,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	TAGGED_FROM(0.00)[bounces-298267-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 342C9674574

On Wed, Jun 10, 2026, at 11:31, Paolo Abeni wrote:
> On 6/9/26 7:41 PM, Alice Mikityanska wrote:
>> On Tue, Jun 9, 2026, at 10:32, Paolo Abeni wrote:
>>> Hi,
>>>
>>> On 6/2/26 11:39 AM, Alice Mikityanska wrote:
>>>> @@ -2605,6 +2605,9 @@ int udp_rcv(struct sk_buff *skb)
>>>>  	if (ulen > skb->len)
>>>>  		goto short_packet;
>>>> =20
>>>> +	if (!ulen)
>>>> +		ulen =3D skb->len;
>>>
>>> Sashiko noted the above is a bit fragile, as malformed udp skb will
>>> unconditionally use the skb len.
>>=20
>> Malformed packets are addressed in patch 7 =E2=80=94 it closes the ga=
p, so that
>> uh->len =3D 0 can't come from the wire.
>>=20
>>> What about introducing/using an additional helper alike:
>>>
>>> int udp_get_len(const struct sk_buff *skb, const struct udphdr *uh)
>>> {
>>> 	if (uh->len)
>>> 		return htons(uh->len);
>>> 	if (skb_is_gso(skb))
>>> 		return skb->len;
>>> 	return 0;
>>> }
>>>
>>> and use it here and in the next patch?
>>=20
>> Since UDP-Lite was removed along with the special case in udp_rcv, the
>> helper for udp_get_len makes sense now, yes. The only two places where
>> it's going to be used, though, are udp_rcv and udpv6_rcv. AFAIR, only
>> these two need to read and decode len=3D0.
>
> I think also udp_validate_len() in nf_conntrack_proto_udp.c could/shou=
ld
> use the same helper.=20

Possible; but I'll have to pass dataoff to the helper, because the SKB
in udp_validate_len doesn't have skb->data pointing at the UDP header.
I'll do that.

>> I'm not sure about the skb_is_gso check, though. Given that malformed
>> packets are addressed in patch 7, do we need this check? udpv6_rcv
>> already does the following without checking for GSO:
>>=20
>> 	/* Check for jumbo payload */
>> 	if (ulen =3D=3D 0)
>> 		ulen =3D skb->len;
>
> AFAICS, checking in udp_gro_receive() is not enough to protect the who=
le=20
> RX path: some NICs still do use NAPI, some other explicitly skips NAPI=20
> when aggregation is not possible. Also malformed 0 len packets are not
> dropped at the GRO engine level, and with eventually reach udp{,v6}_rc=
v().

That's a valid point; devices that use netif_receive_skb will skip the
checks in udp_gro_receive. Moreover, these checks don't block the
packet, they just flush GRO.

> I think the GSO check is the more robust among the easily
> available ones, and should not impact performances - it touches 2
> additional cachelines compared to the current code, but both should be
> already hot in all the relevant callers.
>
>> I don't think Linux supports jumbo UDP with HBH coming from the wire
>> natively, does it? If it doesn't, and the above is only for BIG TCP, =
it
>> should be safe to check skb_is_gso in udpv6_rcv too, but again, is it
>> actually necessary after patch 7?
>
> WRT the need for such check, see the previous point.=20
>
> I forgot about jumbograms. The current ipv6 udp RX path currently=20
> handle them,

Indeed; I tested with a TUN device (with NAPI), and receiving a
jumbogram via socket worked (sending, I believe, is blocked by the check
in the beginning of udp_sendmsg).

BTW, are there any selftests for IPv6 jumbograms?

> I think we must preserve such handling. Possibly something=20
> alike the following?
>
> ---
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 15e032194ecc..d4d1d85dd7cb 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1085,8 +1085,9 @@ INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_=
buff *skb)
>  	if (ulen > skb->len)
>  		goto short_packet;
>=20
> -	/* Check for jumbo payload */
> -	if (ulen =3D=3D 0)
> +	/* Check for Big TCP over UDP tunnel and jumbo payload. */
> +	ulen =3D udp_get_len(skb, uh);
> +	if (ulen =3D=3D 0 && inet6_is_jumbogram(skb))
>  		ulen =3D skb->len;

Looks good, thanks for the suggestion! udp_get_len will cover BIG TCP,
and the new check will cover jumbograms, restricting ulen=3D0 to these t=
wo
cases only.

Thanks for the review, I'll resubmit with these changes.

>=20
>  	if (ulen < sizeof(*uh))
> ---
>
> The above will make the check in the RX path more restrictive, but it =
will
> be also aligned with the existing one in recvmsg().
>
> /P

