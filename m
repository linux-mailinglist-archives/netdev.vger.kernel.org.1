Return-Path: <netdev+bounces-251503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lo0Bt+jb2l7DgAAu9opvQ
	(envelope-from <netdev+bounces-251503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:48:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9568646B05
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97C9D74486E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18E438FE7;
	Tue, 20 Jan 2026 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FUORbiRh"
X-Original-To: netdev@vger.kernel.org
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390CD3A9631
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917944; cv=none; b=ElNJL+M/mN5cib07/14Fqsx4B9NaHU186cFyuIDFJmO7MOkErl6z8NhU3vaFXRY0BRs8Hof0DpK6/Pa/uNgDCNSpCVZdztREJaBMaxkWNqNhBTkmQ+47uhjOnt+PSm3raADiihshBJoTs7EOCvqK3qkx6Gldm+bpb02HvbShlkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917944; c=relaxed/simple;
	bh=Skepg5gQkMhyPFpPszY7wpclI79O5hsgClCpFGNUXS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yh4MPZ9SrPsD53Esxp5zM5MsgSQf4Y9W+gUt/soQ9mARG4mVbEvOBYTKjlJ5YESvroz6o4dIP7huLllrQuADyZpuf/6FmEXt78jFZl93hp727LbNCbP5zM6Tfptl9menOWrodeJ2rNK3h7Fs1EGuUzPugZ03iRXXfsL9dnFf8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FUORbiRh; arc=none smtp.client-ip=66.163.184.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768917942; bh=26jEdWlJBlRxKIFL3LQfgVEP+B3ScL55uRMFUfQbvyg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FUORbiRh04a7AckruIDLjYvHTWWFO2QrcxEM0dmObE2aYMvqu3dlGJS2wJej+uywyq+vKev+hjqvcIhWAbSCAow5/WsAy4noutUNGH1f5hR0Uvpw2DFgWaZHhNgFfeohDII5Qa2AoznSqpv2zQ/JeglYok6JPxrNsVVI/uj+HYnVmsQ1e0TO3OWOuB1nKD9Z9FnJJsxSILuiZUtumQtyTHkIu6L7Wvn2R9pTMfK5uAsXi3ZejbONKYl1SbGBBvszMeKg58gcnu7FgSfGH6cB1ruR3B+EAsK+RYwVyl2eDPtdetHfS6yr39CU3sb+367OlsaH8eeMmnlk7rQPBYSQIg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768917942; bh=Sk4t+1Mym7kN/oXv2t5P+NwjCLHzUIkGRRY/wDktqr2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tJwPEmIVzRnvd0hbaCuhsiQfwM3zHkftV4fK3wgbOVVhI7hsEoSk7XHzwTtTkWbQ9Xfa+LLU3km9JPfPYnFbvUliG1eMEsPkL5JENoU/s93fIVReThUCvkKloNaZA06r+Qe9WqJgJ+zhLPdspUQ1l3pW8BBozAH2rBFzlBhuERVA7m5JJvLOQFsoawkzea7z5eM7EWwhxOdQjQN3NvxUKPTcpvRoFi4DBjHOfkl7PS5HAlFz0gEbBprX9/Odh48kU4dnGmw7/CLr+/6qbVsBBPR3LwAexBO8dVdk1Sm9C5fPrQ46v/AlDovUDDmZ0TgfziUDk2m6pEG3S+4DrCm0iQ==
X-YMail-OSG: doV8aZwVM1lOKrBvr.hzA9qUAL_r7rIjn9Okf6A77o4dzHz4SLSN_.mEEjxJ1Fk
 nlubxp52kuPoWBOuQGskMm.mR_TYAadRiuuVckO2g6pDn6onfox4QORLrR.BpWGOApakoqQvGmb0
 frp2jU3MMN_03Mk3u3oj7MP.o5OxGR4oHPKFZV4f.VHaBIIbDWkuNuyl9CTV5XhaG4_Jn9yuK342
 KpATu6bVZ6gVy4.THKgXWehSEoDnyEkjr2MqDg2tRSXvmc80XhuUXXsqsQjoVaMdnM1J0_Efj_GB
 Y9x3hsjXUlaoSxt04nyseEcB3Fr4NM3uAE8uyd5FQyYgiRyWGeehhWHgA00SwK.dQ.I4ZzAlJLyB
 snVXaafPHMsbTA0Cm__DBJPiCYmW.3mv50UYFnPCIIuaPHKmNXESTjEE1OS8nCKbjW6bnysWZllW
 9Gy54vFic4x4XYsEXOlj9O1vTwnAF6fBWSmxnw9ZLKypdLQtEviauJf6y7j.UvL6gCIGtWotxoLr
 tzzun28MfxB2a1AAx5oXpmm__XLU4yX0s2F1Ms_QOWBZBUKprskrKqlBsFxIQG7YcsHJ6E4Pi7LP
 wZ0VvCw1m0f6cxOOlS7w7RykMz5ZwzeXGscjv36cJpZOPTtghj0uifSBiL0sGs1082fdAdeFwV6A
 Q_9fw4V4ClKAifhsvufW0yZekX7lBIm38ge8z_82NDO4pCgDF.WqIa2CpfOxcYBzXTfkynVbUZqr
 HPjLjPVhLjH.KiW_xRz6Rl64YpW0s7wjK3KPevSJE0rWDdLUmP1aFBVrUV_ns1M5wyCCyaFH1Ha2
 hoPvruyG0a50NrXA2cMS2Z3ambxyrPkwVDa_ieByt4NcgRk9xG1ubga3eKA4R.0TpHeC3Otd3_NB
 dseb85PpC0dS0W04mu9g.ikaAlSHqpAbrcD7FN7DZ_ZdIzMK84jSC7jg.rkYrSCab9OWvXoj0_ph
 3jqp_IFzr7hFlJIsjrHYys1liZ9G5g3c3V_No0G33s4PefUbrWO4sgPc6u_0oeavPKRbj74DU0fd
 oN58rW74wO0WBkqbOImaUlgjK0sEjDq9LLHSVXSYadXVfZiBd7hE_EmKEE4BDPOgpiBJ32t43Y9d
 SvPscpn7Rz.e1mw4uUkW3AqBYrhJ0K_F0QSoTxfIRBGay1C_ainAWnePUNL8_aWfAZ.Se9Pei0Mw
 xm67XUi.1S2PmWgeAMz0W4Bjnr1Gd3ifXxXbEmeecfxgQRKxalXv41vZjGAQv6HKY.9YqJQZAAxk
 Yb4hnOn4klVQ.7eF.m969xoHKQ.R4dgbBj2Ijarfc0tXRfv1Tso1TypAa2ejU0v9e.Oyq9pxfZej
 a1C0g4tqmMbJUV6jJCTkEJFFV6ctDqaMWJCDBY7jLiqj3fOueysh_NAQTgD2CdjDYJSmu4Sxm5Qq
 4Ss6yrdaWxRtcNM_307jqYfrH96EfIDpNk.Ofb89lwOthz5Ux7MicQ2klx4EoCCZtt902jn5pDln
 mkoOvjAmgieFklp0bsZz2Vmv4mFAts16rVb6e9ie5kr8KQx.5nnT30pjPLSAFJp9Rfs9rMi.LBbW
 kBKo0pU9tCL23IGkJM_BNwDipkVXE9eEJMjR098jm2Y7kOtVj8fsbu1k8uskHYF3V.0pcdd7opic
 k.4FK43UF0qUYrqWQ0Ae_1vzwgHtekp0iB7IECidv7iLsFdOaf_x43eXVP8og4sFFfMAz9wRlb1W
 lzXtuf0dfawG1ITP5l_C1wGEPupBSZdREgj9e4J.YwgfFWsJZCfTq8nHeQvq_q9G4DK3jIWibcAp
 3DoQ4jeggKahFCd69OkJUMgN_ic4heud4RKxka91uLWsxatMvKIxsGo5yTZtVn81evOcSZmWpMsp
 VvjnSbpj7wDtq0uZIx.i02ycfyKjSCiPR0DwhdkwGNUA46p9I_e3S22bwLWOZh2z6FV2APgm66yB
 xF0ZJ.Z_eqwMV8FiU61ZKAlyQ5bniuNrTAIYC_s.AYgBnW4cEE03bJ2tgs82hE39h7vxFE1pUXX6
 Y2DN1AW13I9TtAHvs4YAokN45IQ2HdiNuunkualExamaP4HnGAbP3aq1aSFs0nMtkljpjes0OyDh
 4pL6knbL0o79XZ3n_aBgrxE8yCR92I66ePU8Hw8sBXMzbCe0LvX8kQr7wvMFpIcc29cBsx2XwK47
 N6uKe5taia5iRw5dUojnDLUGY4tZyTeBDidgo0fte
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: bb1c067f-d1e3-44c6-bb19-3f9daa543adb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 14:05:42 +0000
Received: by hermes--production-ir2-6fcf857f6f-42swv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e96ad789ca791dd80b0fc002f0c2b597;
          Tue, 20 Jan 2026 13:25:11 +0000 (UTC)
Message-ID: <5151a1c6-1ed7-4433-8675-c3486cc29cad@yahoo.com>
Date: Tue, 20 Jan 2026 14:25:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v5,03/11] net: tunnel: convert udp_tunnel{6,}_xmit_skb
 to noref
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, Jason@zx2c4.com
References: <20260113162954.5948-4-mmietus97@yahoo.com>
 <20260118003609.1042309-1-kuba@kernel.org>
Content-Language: en-US
From: Marek Mietus <mmietus97@yahoo.com>
In-Reply-To: <20260118003609.1042309-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24987 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[yahoo.com,reject];
	TAGGED_FROM(0.00)[bounces-251503-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FREEMAIL_FROM(0.00)[yahoo.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 9568646B05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

W dniu 1/18/26 o 01:36, Jakub Kicinski pisze:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: tunnel: convert udp_tunnel{6,}_xmit_skb to noref
> 
> This commit changes udp_tunnel{6,}_xmit_skb to use noref dst handling,
> removing the requirement that callers take a reference on the dst.
> The key change is replacing skb_dst_set() with skb_dst_set_noref() in
> udp_tunnel6_xmit_skb().
> 
>> diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
>> index cef3e0210744..d58815db8182 100644
>> --- a/net/ipv6/ip6_udp_tunnel.c
>> +++ b/net/ipv6/ip6_udp_tunnel.c
>> @@ -95,7 +95,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
>>
>>  	uh->len = htons(skb->len);
>>
>> -	skb_dst_set(skb, dst);
>> +	skb_dst_set_noref(skb, dst);
> 
> skb_dst_set_noref() contains a WARN_ON check:
> 
>     WARN_ON(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
> 
> Does this create an issue for the SCTP UDP encapsulation path?
> 
> Looking at sctp_v6_xmit() in net/sctp/ipv6.c, when SCTP sends via UDP
> encapsulation, it calls:
> 
>     udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
>                          tclass, ip6_dst_hoplimit(dst), label,
>                          sctp_sk(sk)->udp_port, t->encap_port, false, 0);
> 
> This call path can originate from user context via sendmsg():
> 
>     sctp_sendmsg()
>       -> sctp_primitive_SEND()  [uses GFP_KERNEL - process context]
>            -> sctp_do_sm()
>                 -> sctp_packet_transmit()
>                      -> sctp_v6_xmit()
> 
> Unlike the network device transmit path (which runs under rcu_read_lock_bh()
> from __dev_queue_xmit()), SCTP's control plane transmit path runs in process
> context without RCU-BH protection.
> 
> Will this trigger the WARN_ON in skb_dst_set_noref() when SCTP sends UDP
> encapsulated packets from process context?
> 
>>
>>  	udp6_set_csum(nocheck, skb, saddr, daddr, skb->len);
> 
> [ ... ]

Thanks for reviewing my submission, I'll address all of your comments in v6 shortly.


