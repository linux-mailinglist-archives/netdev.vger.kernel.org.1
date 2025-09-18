Return-Path: <netdev+bounces-224555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB52B8623D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1B23AD71E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C5C25D209;
	Thu, 18 Sep 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WLqsukmL"
X-Original-To: netdev@vger.kernel.org
Received: from sonic312-24.consmr.mail.ne1.yahoo.com (sonic312-24.consmr.mail.ne1.yahoo.com [66.163.191.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA324DCEC
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214786; cv=none; b=u5XP8bAq7hBUoCRwX3u1z/kUMmWm4AeKnC0upjNGkVWbeae7ixFHwzB2HgBCeYQI8BtnVlCcGop7JfZcu5wsS+fYNxbwTZ5QUCkyHYpWYvBW5K8+lIdNZKts+XiJQqYb9vH9jzDhe93m3nUuGp0d8qUvGvVi578sLqTXnUeCVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214786; c=relaxed/simple;
	bh=nOyXjMXNYNtCF0U/Ffm0Nxc/jz04qvCSpyaLmArZpxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFciNVWR7wzC9Oz6KmejnGYYSikGrokjkx5ShBxmvHRgiXdtBMN/AuIk/lGWsRvVo2zmmikqHLZ3q54Tma2e/nwKi3dLdoEc5NBJh7K5IYVW6j75tsZpiM7WrGomgYlEtKjP8i4cJsvCho5CZc2gQShSKyVVEkoul7oPPlBKqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WLqsukmL; arc=none smtp.client-ip=66.163.191.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758214784; bh=k7s+K1NsbUvicPKqCJI7hD7kWbXY5LkUnXt1ZCxF5+0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WLqsukmLH7iFZvS52ME2ZcImOymidSmXXuUU2n46I0z4HyDvujMKknZFmzumr0X33VJv/1Hwg/Bk5+S6GMZ+jge9qw0NY3spZJ/J3iVKJio+8n+CiOHeno64oU9wnB1+pOu6WV670x/IVdmaGSdFTieeff/c8eQGWru1PTYUGOX7edkFnQxjPJEyzmlcuJgChVLmvG/hYXFlOQ0suO1xzHmia8hgnj4ewXgl9i8UWsIt1Ffh58wNRKaXitmU/kqnqv8hbtsNr/Ik+cBTskh7zCYlWiz9x3ZPB4ppRyYo4qIAXLfUWlU5ibU+604HGCY+VCVXSaCha6zkJUEvtWl/QA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758214784; bh=ABntJgOeY5QP30dD8ttwE5muZlHbdSMR8hk58hXclml=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fTGQNMUrgzDAjnx3iDeomHmCjMMTEHb2QZcMz0w7/eMlBe7XmH6hwKUAL4uOA6hbVT7JzQWE4I/JDZ4nRgVmchDO5Sr1L28JUW1JoUOrrp3guV1J0GVcABFFAeAIjcK8bEvRK88vYM28E39GsGVyOHPXLpsyM8nAzM4KvnWycwPianRRm+btVfrCmKtxK06xbRbPKaNtexubu5VK4PGNRD93uq/SRfufmVWtHfV3YdpcchxCAPT+EGY6SIDZQPbhp0JC5aYTMCtjXsUc0gsIlBQY4YRXj32KZFyCQKmVT7VlCRRjGiGFYx42BSbJlFIQh4FwhjUVP0u7HmI46+TIjQ==
X-YMail-OSG: D1JQjHsVM1mVq_Jto3diqn6PGuFmhwzAoJB.IaboTmpKazOFZyyapvvmwZBaDyk
 Agn1zY1w58VaDPWKH3JKbHmuO536bxKfaOCN55hjZ.bVMjbnHvhm76HoouiB1KL1CaeiSSWhReT2
 GKhRZSCcBLkvXC7BNJb0jc6xVDDf0bL9e47TrpHR.iKkIC3D43LtGz.FB839AGi.6CE__9dUGQ.3
 DaZaWZAWhtHbrXNqEgBzd3wDGpyzXftLc.643CsJRfPfxnG2YRddyM13g2XFs4_PzewP_PfzHb88
 JeUuaxbkSsbI4ubP_KDUBqAlzNXmHBrO3jNpQ6bES.Rfc.KFdJTAyKB4Nr6nmkYt1pW4BRkI6MHO
 wGCLI2XezOySPgk7j.b5rmvuospG4Ywy0xjeIdWZmGUFlE.jxjwcINuNedO2lIuXymw4YJBpSElp
 7z2DQ9aAYq702oEfNm0T25l4zOaBXuQ4WhNHVDEr8QmVBfV3nBvqdQb4ZPwnH6X5Qae4WioxD4Eq
 JPO1.Zrk0vZBJLdE2qcUTK8p5NNWN8DSFBKU_elKEYGB.WwUAfO__c9Rgx0n0kQAn5FOpKzgE44E
 ckWRyyxUVPhYRtbVzaNy71Oh_McueSqVaL8PKMGlzweZIY3am4bxZCoub8GpsmFs.dUkqtVKRSR5
 .9uJCBCxTmvznABaIxVa7d4g4OOC_ll1pMdaoBlYBvfdySlXYoMIf3BVpwFx0UX1thilg3wixlgw
 V9AyYvSdYlnEqa21JzyvjAN5uKCOhDwd4fWkkTrjBOIB4oOm5p_s1mQF784I6xSU5jC5YtdIEBxz
 mMoQnsliEmMEQLE91ol7EothJD5PsWxyiteAl1K1DFlA5EYviABJhCDCJqJXPQQleziJCXc.Dyxb
 1p_WKuefyNq4gAas4L2xYFEvYFBZlfkzPzWFvSrmZ6RxuBLP3zH213NcRVTxFNUbe5hQ.Rv8PXZD
 IrwsYtWA9xmUwuAM.8EI66nhpAWD8bZjt6niSuspYebE.7g9Q3mO5nwNL2ia1ahV.AjD9Pkf.2A4
 DhZqZMasexGwKkzuX2iQ2SQ7v7XUZJhqtfy.Qsc0n_T7uMGDYj8mqdhjRli4o_GglmDP_Drpli6A
 wwAukTGxorbVW08XrGeveIJBzBdX8UITO4NkNjuxHIJHXo3WtLAZLvlFQWE4.Nljd_9zU_2_Riol
 Hvh3waAOI1G6AjZ0Kz9G7ROIFu7inBfY.aP9sVxX.Le_sI3osMECqNNTkVOM.d2na0zyBNZZABEr
 ajgHaDE0X11T6H5KhOPbHeeRplobu3P74C8yr4MzC5q3PueuLdmOBnKRLZy2EpHxYtA3G_X2rXbv
 Hv.LHqLRLivfvOBYtvn4gYV9tfXFuf5wrways0LdS5USeBw87m2U4aHrT0yxO.Vpxk8G7_kGTEvE
 zvx06UiOhhD77x0SeQgcZA6wTE7URJAl976_zwu7p0IpGae8fFR8.cvMa70.UYyink1gTthlxkiQ
 lPt2q8f3AyZ3UjAXFSvyo2UlRRjg6ool94Y3wi1_RuegQOd1zi3qHxH2LKN0KBt7o6N0ryKjJYQI
 5042Fn5C3scbj6fPjsumSUA86r.bhJR1IDm94tyLMkmly.XuE8P_1HXiaNb3mngsIq7SWJVfbDMf
 4lLdWCBWPQQ3ts2lIfyn1IeXTXWFFFQY09X9Mf4SuQ44dVnoIRvtGRzIEs5tkAKLixU05hZvzqg.
 xnK.3AtFNJxhemAJ027Vl2zALoX0PWeFhhHcGRbHJMLJkIhSFRIr.Thpy.lsS_0LDh4GCbdOD9BQ
 z9eGw.NsT7g4Z5JVOz7DdT3L5F5XyjBJROnJy..O0sumdJ1HkW6iuNLOwglqRMdPNj91mzZ81ERC
 nj_XKszOijYh9M.HtPg1iysZdvUe4mnNP9S8k7Kj8lZAHaqVy2fzE3HuEm3n73TrW4AYCuWWyjpY
 99aMIsbddfyIhBBPYsrNeIGGC6Q4MnV5bgbadGzqjmQGG7HICOgOyNnMmSNVrFyB3_L9WBaDvKER
 1GOlejmeWB52WOzpYedcgpHJXqMeMODlCqiLITbCml7N8vPPA.v6FpUJtWV.M9MXE4lV7TH9XZki
 U.Yyw7BUXDEGPRFLfkrA5tLhAUOa1fVxTytot2dZ.at9nxh0M2zjVBUJTv8vRiKTZ.irHCd5CteP
 QAyPhsqTHTzUC.2UKZTdG_GBGz85KRnFxB1V_FFU-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 224a8257-2bf2-4270-89fc-84ceecab2f8b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 Sep 2025 16:59:44 +0000
Received: by hermes--production-ir2-74585cff4f-rbvcl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 19d045f9500d33ef1c9bf4d8d8f6a056;
          Thu, 18 Sep 2025 16:29:16 +0000 (UTC)
Message-ID: <cd8193c9-1af8-4182-8e6a-a769acfde340@yahoo.com>
Date: Thu, 18 Sep 2025 18:29:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: ovpn: use new noref xmit flow in
 ovpn_udp4_output
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, antonio@openvpn.net, kuba@kernel.org,
 openvpn-devel@lists.sourceforge.net
References: <20250912112420.4394-1-mmietus97@yahoo.com>
 <20250912112420.4394-4-mmietus97@yahoo.com> <aMlApjuzBJsHVMjN@krikkit>
Content-Language: en-US
From: Marek Mietus <mmietus97@yahoo.com>
In-Reply-To: <aMlApjuzBJsHVMjN@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24425 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

W dniu 9/16/25 o 12:49, Sabrina Dubroca pisze:
> 2025-09-12, 13:24:20 +0200, Marek Mietus wrote:
>> ovpn_udp4_output unnecessarily references the dst_entry from the
>> dst_cache.
> 
> This should probably include a description of why it's safe to skip
> the reference in this context.
> 

Noted, will do.

>> Reduce this overhead by using the newly implemented
>> udp_tunnel_xmit_skb_noref function and dst_cache helpers.
>>
>> Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
>> ---
>>  drivers/net/ovpn/udp.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> index d6a0f7a0b75d..c5d289c23d2b 100644
>> --- a/drivers/net/ovpn/udp.c
>> +++ b/drivers/net/ovpn/udp.c
>> @@ -158,7 +158,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>>  	int ret;
>>  
>>  	local_bh_disable();
>> -	rt = dst_cache_get_ip4(cache, &fl.saddr);
>> +	rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
>>  	if (rt)
>>  		goto transmit;
>>  
>> @@ -194,12 +194,12 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>>  				    ret);
>>  		goto err;
>>  	}
>> -	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
>> +	dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
>>  
>>  transmit:
>> -	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
>> -			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
>> -			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
>> +	udp_tunnel_xmit_skb_noref(rt, sk, skb, fl.saddr, fl.daddr, 0,
>> +				  ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
>> +				  fl.fl4_dport, false, sk->sk_no_check_tx, 0);
>>  	ret = 0;
>>  err:
>>  	local_bh_enable();
>> @@ -269,7 +269,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>>  	 * fragment packets if needed.
>>  	 *
>>  	 * NOTE: this is not needed for IPv4 because we pass df=0 to
>> -	 * udp_tunnel_xmit_skb()
>> +	 * udp_tunnel_xmit_skb_noref()
>>  	 */
>>  	skb->ignore_df = 1;
>>  	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
> 
> Why are you changing only ipv4? Is there something in the ipv6 code
> that prevents this?
> 

I'm not sure. I'm not as acquainted with IPv6 as I am with IPv4. (and thought I'd hold off
until I got a positive response about the series)
IPv4 already has some noref xmit optimizations, so it just felt like the right place to start.

