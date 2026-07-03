Return-Path: <netdev+bounces-304600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id chnpImDjR2pmhAAAu9opvQ
	(envelope-from <netdev+bounces-304600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:29:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 128D77043CF
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:29:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b=Gg22PdWl;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="d bIxK/e";
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304600-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304600-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 451E7300A248
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6630649C;
	Fri,  3 Jul 2026 16:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96972E8E09
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:29:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096153; cv=none; b=XCnablsNLoe5CR4FVlPQuElGekWzWgKNsHuu9a0vGeibyIW6BSifo5Zx/AmSWrHOUZmcGPQhUgohkLMRdwNSE80hWltkx0LD1sUYTO1NDJhu9pSam6N5OV7iMAkw6TfQqH7bA1VL7XkDzjExHwM//WdGgQcF1uQNMAf/0QLANb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096153; c=relaxed/simple;
	bh=BM0Fyb4iwVkV/UL+/pPwzkYSnmOIHtDI1dyGnL1OxRY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OzMZdOStVQc7roSReUSpeWveXx6m7Xc2W8cnpFJ8QALEn0pdfD293Zg/QtqqBYFWzPdwPVyzb+Cu2wFr2u8Y1X5mJrSz4WWxF/cvu6r3LpJhH2gG3C4ihJRO3hwMsPftq81g4nEO6gpGhmoA6uUMBq3Be8IMRd8bmBZX4j0Cbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Gg22PdWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dbIxK/es; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EB9A1400053;
	Fri,  3 Jul 2026 12:29:09 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-10.internal (MEProxy); Fri, 03 Jul 2026 12:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783096149;
	 x=1783182549; bh=fFgmsHLTGseL0q2Mb5vhqMhpE8KbjT0zUixvjgnrdoU=; b=
	Gg22PdWldYEFOfzBz8x7XHHeKw3ryIZVANDQ8igvHz8nX7yheoE4/U4WcmXHURTA
	P9UDB2BRVHf87xDsHZN1KFwXPU2o7Gd+Snxc9pBjrZwOwLktKIVjuSG1B0d3/rAk
	THWBChlloXyrL8RjitDMSEGOL0U3NeQp7zwkgMLiSbUzyrT6zc4tJrfOq1gUYFSM
	bnBwyUQUfX+NYvsBwyaIVtFe3AjFWEqBR6tpS6TPWX5FEQHlogBMo3YwMR8upyd4
	lKkAGG4IjQXE17FvolwmokM0h5qxb3PAIcpbwjtVeSgSZmxbjjQ1aACg2frSBri+
	oiB6cdr7MsvyWcsSoKlzOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783096149; x=
	1783182549; bh=fFgmsHLTGseL0q2Mb5vhqMhpE8KbjT0zUixvjgnrdoU=; b=d
	bIxK/esM2eBisqdSuOxKow5T1pv6H29c222iEHId/fkEYfWqH3JaZcYq3rAmWyyb
	bWm5ZRFiPQONIV5jTX8GfAemg9QrSXdrmcwFIYY+KLh+V0YoaAyrrqycZkWPtbGV
	aiNa9DoY+hi5NA012BlcT76tP2uYQ3P5JKO6pCsmCM3wVWa4X4LMNFA0NU/Wi/8y
	yFx37xvOd5cAjgpYyx7Di9deLI0HeAV5COxSC7EUjklTOImiWWfRqMCiVl1wxNBB
	rzK7Lxt3DVjnon4KkAl2pgMyGYAf4y/iYxn6DL9Z9nxqlwwVsRIv021kuZpyvwv5
	X45sZ/zceNLeMgqqOQ85Q==
X-ME-Sender: <xms:VONHaiMjzmg4cXCNpJnWKM-3aT23P2SdK5E1JX_EbjWS75HmxLADcA>
    <xme:VONHarw7KW0gBp9puIxwnSAFyv61BV8LpIG4yTgMla-pF5Li5R_9oJ3k61DtyGELC
    EN6zu8KlsK7-EAreJcZyZJRYoFLN2yTv6jPYwfbvIwgsAjsWyfqdnk>
X-ME-Proxy-Cause: dmFkZTGL1C9iNxJ+CFWZ2VAFolle2s+MfeDpX/o3VB+FyWvU+uBzowsCGwONgmE0TWzStM
    NLwPrX4wvBcgq/NruRcIGgTbHgyfVXfnDbCo5yYeGRothnyEl+WaNUjMvWzAFKUHM2QzBn
    /1SsrQNO5HxCFjK0iy40BjPaQML+nq/F2Y6gU/dELXT4h41VJZrQxRvudNMTrm0IMeLF/d
    1KgPkZfcT2yClwiYf8y8Ur7QD8V1m1f8ew+OwH7sdnRSbUMOIm1UjtxRhKB6zlViRVbbO3
    L7GaiZkDtUGugmB4LFmAN+RXBRy5ECsxlWqtePyycs4/a3fePvAiorMDQFGmQZDYdIi/IO
    xZJdeCCOETn+f9xz54HUgm2JzuPz2m3TpH8YEIcpDYqM7AwuicPFlVhAcU/L2kcLjazKHu
    OK69viLO8w9+Noa/DyDNQTYen86YO2cZBDOkh4LBN5OrHI9AXuLHDnkCNpRc3D3NkH71nF
    IdrvwAzCvU21cPwlGCHg6zoQLo3ZEZuiyAIXNQtrLKweG0Ocqsft3T6t4RrGIo3yON/yP7
    VkIn+Cuy2eCMaS5dtx44vNsLvZnzA3oeIrov9B/VN7U7fGRPIMHPX2T99WJ7jf5qqRMm+4
    78rtnkIh1QCTbndo71w8TPosXTMpCAKjULPjdoNDwW06PjbVYkXCGyuWQNvw
X-ME-Proxy: <xmx:VONHarQjyG5H0rUhjfvzB6REHNufH9ydyy_u1-qpl01a1ECDNDRwWQ>
    <xmx:VONHamI3oc6QoFPm2WGfU8kSZa6AdWR9Mmu8_GYgSTCiv2IaxOStqQ>
    <xmx:VONHapXevayXn4VaXmXrEI6lJJp6G-k3lqIQsZeXNZrb8oennj-Tgg>
    <xmx:VONHaqghZsbOPTK6PRuI1UUUcHTcep2AMkibT63mowsA2OVV_ibG_Q>
    <xmx:VeNHarC8Jxg57kkNth0nduzJsjeC5Zd9zjf9TsQABejMCv_LMyZoWXiU>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA5F118E006C; Fri,  3 Jul 2026 12:29:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 03 Jul 2026 19:28:27 +0300
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
Message-Id: <922c6a47-9729-4c4f-b635-3efdc03bba8a@app.fastmail.com>
In-Reply-To: <617cfbfe-0b42-4ce8-a283-5c99da26bb10@redhat.com>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
 <20260611192955.604661-9-alice.kernel@fastmail.im>
 <617cfbfe-0b42-4ce8-a283-5c99da26bb10@redhat.com>
Subject: Re: [PATCH net-next v7 08/11] udp: Set length in UDP header to 0 for big GSO
 packets
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FREEMAIL_TO(0.00)[redhat.com,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	TAGGED_FROM(0.00)[bounces-304600-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,bootlin.com:url,vger.kernel.org:from_smtp,fastmail.im:from_mime,fastmail.im:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 128D77043CF

On Sun, Jun 14, 2026, at 16:19, Paolo Abeni wrote:
> On 6/11/26 9:29 PM, Alice Mikityanska wrote:
>> diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
>> index dcff7fb16ff6..32525a051a6f 100644
>> --- a/net/ipv6/ip6_udp_tunnel.c
>> +++ b/net/ipv6/ip6_udp_tunnel.c
>> @@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
>>  	uh->dest = dst_port;
>>  	uh->source = src_port;
>>  
>> -	udp_set_len_short(uh, skb->len);
>> +	udp_set_len(uh, skb->len);
>
> Both Sashikos noted the above breaks GSO csum, as the following
> udp_set_csum() will use skb->len to compute the csum partial.

I think the existing convention is to actually use skb->len even when
it's bigger than 64k. For example, see [1]. In order to keep this
working, I kept using skb->len for the pseudoheader checksum. I think I
made some fixups in one of previous iterations, because some places
missed using skb->len.

Regarding Sashiko's comment, I've already replied to it when it
commented the same thing on v3. These packets don't do to
__udp_gso_segment, they go to skb_udp_tunnel_segment, which calls
__skb_udp_tunnel_segment and adjusts the checksum with skb->len [1].

Please correct me if I'm missing some cases, but it looks correct
to me as is.

[1]: https://elixir.bootlin.com/linux/v7.1.2/source/net/ipv4/udp_offload.c#L192-L202

> I think it would be useful to consolidate udp_set_len() and
> udp_set_csum() in a single helper - say udp_set_csum_len():
>
> void udp_set_csum_len(bool nocheck, struct sk_buff *skb,
> 		      __be32 saddr, __be32 daddr, int len)
> {
> 	struct udphdr *uh = udp_hdr(skb);
>
>	
> 	uh->len = htons(len);
> 	if (nocheck) {
> 		uh->check = 0;
> 	} else if (skb_is_gso(skb)) {
> 		uh->len = len < GRO_LEGACY_MAX_SIZE ? htons(len) : 0;
> 		uh->check = ~udp_v4_check(len, saddr, daddr, 0);
> 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
> 		uh->check = 0;
> 		uh->check = udp_v4_check(len, saddr, daddr,
> 	// ...
>
> so that csum and len are always consistent, the 'set' logic is symmetric
> with udp_get_len(), and no duplicate checks are needed.
>
> /P

