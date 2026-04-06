Return-Path: <netdev+bounces-275547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPPwOOp102mjiQcAu9opvQ
	(envelope-from <netdev+bounces-275547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 10:59:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 552C33A2654
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BCF2300B560
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A64C30DED1;
	Mon,  6 Apr 2026 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ckRG+exl"
X-Original-To: netdev@vger.kernel.org
Received: from sonic305-20.consmr.mail.ne1.yahoo.com (sonic305-20.consmr.mail.ne1.yahoo.com [66.163.185.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34411EF09B
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775465958; cv=none; b=JHQ1LalplezurHNR8S26ZSnR+xqsBPo6ONSLkSLCDPd6pBKGgmtG0fiV/QsHCosmXsj89Uhr5wBxWFwFXZXm/U/fFDwPhyv7g8pFyS2hXWAj5cKsG9pqeltJI5YB16pc4FWxaxviYqXGwkkVX0LMeHwZvcwlcV9lqXtGOpiPWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775465958; c=relaxed/simple;
	bh=kWyi34GyqAWRyv65MTicIjaTypjKCzY0okVuuNFGmok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quPDXEcBOyPz+dKDjGd6Tf7j6w9/vlaetGNQKFbgop+p0N8F/iqce8vssz5BcXz6VHP90Q9HpMERifMIDjPShU5NbPWOUtkhMz8bYAyHKmnfx+AiC4XW7h2fBRK5UZ5he2JRoHj1vs5ztBg/RIARFb5t6pTjePWoU0za9g1VUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ckRG+exl; arc=none smtp.client-ip=66.163.185.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1775465956; bh=DJzmVVr3DuEi2GbNmKSD0ZrZWywa8BGq7wZI8w1Gm/s=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ckRG+exl7HKEHjV6KFwCQ5dpY/JZYyWrMdxw08fLAaKH8RFB28r6bIGMbUMTef/ilnVsVdjEN0uoWWHtw5vOkj0Zkx98dcBG7+Bw/JYUWJnl67ES9L5cqKqrsupxK+XwrVfpvmsPMfhtGzkzVyhGwPlvCXWQOxhR1CHRJgdahuJNPGjObp81YllJfHb1HZKD0M7aRMm4LgYz41yoOWNAC8ZdXTPgypxjAWwd2lQxhRCNeOMuDFRYeUxelR1mBtZ+RnHuH+vPclNGajavMHoJgwqT9DdYyPGewZQBAb3qwyZjTocDgbQNKmH66OnDk7jpEU20F3b3DM0H/ax1Bd/ArA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1775465956; bh=HfhPzs9upheY/y2JirNm5z2N4vMx4CE0wweqe6jw7Qf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZVvuMiWjscJgWfzstkmQgyac8SB5mW47CMOtM0enVGtt1jV7QMXhVHCfGmHAg3lfTfVxQK0gBqB1E9/wcqWgX4EjfenBVB0UtitWXxn1GrZwBlkthq9BxB56yH/EuIJaBZ3yQyBTv1HIIh4kgOID8N9NqqKPuWy/X73z5Vf8f0Ge2bLNpgKv0I1cI+Kbds1xD1jpojT24usC0E+RoGoDIxrx+7cTj5V13y8QOCIZbhVkZ/VjpNtT4WD67qBY4ySfCcEGK4lOK+5LeUFBcbTx7WVZgjwyR9vGVpnip6plz+SyXq2rchaQn9t9/8pwoQBQIem10CxFgWTSid20Luvcdw==
X-YMail-OSG: YCJVs7cVM1mO2sZqskkosWEeUV0f7rtoXzjO6oQu1ikRdb45LIsG0xwIU7Qjy45
 j5IkkkOCDEw_5HsrFfosFGdDoWLHIU3180fNjPr9rylUTqm7A8f.oIM6yatlfDxO1Gi7CUowl_UF
 nYT.BEto0362VmanM0s6ntTiMVF9oCvYk2nVq53OfbFV0feipCqdgZAcL_.sQ9sUHv9xZ12AQbKC
 7b8zl0.7pIjJhQgftA9iik9wPDuOl5wSmQ4DI39dMfwByZV_P6ALn8NbumQsNupEtL_f_e8GfY2t
 tkMkwi6EUYMqM1QbvBiuhmDMicpnSRx.FizHFlNgAuwxGU2yqtEe2VvVYniTxsd9Tab7fDgYr7xX
 fPOdyJXVbyrfMtFK90w1QcV0mXFTeY6a_B3puhTkOTaT5npgtZCg1YHGhMdFn3LO501M_5sQ961E
 Ov0IteoMJp2KbCf0OJjvlm3Nu9mpd6PurPaVMPqUdWD8l0lPoX2i7iYvnDw_WZaoMNF8Ahj4hrgh
 yk4l0wPjsXK1VmTP15pTow8CNX6WTyUsdtfZVIofdYT0u1yABWPTyVZ1NDuijICK7npjvS5uKiUG
 fo9zHdQC_D1x3yBNPldO5H6PPCW7RQaaou5hGxUStslw_cfvFkdP5TcdsSwjEHn13JCsGWn4Rl1x
 fQam6FLjTSxcFYfqsixIO8TFfyyUJKMueXi5FAhhypSFobgJRLFrhWR4R6mztZI6yXdFgGf_q3KY
 ZekEC5hZXYF0348rlWXqb_0Qnysgw3xNuVaJo..R5D83TGNmXllj0zS43lvPKImeFUGBywIKM521
 Bjb3Do.uHJxTXg4RLBOLzZSvBDVSvN6CSOqBxx8VJkChxBth6mZJgzUilbGjQGE18c_8yK8EOWa4
 kQndl3xoW9alKqKgQ5n7AwzL9Bj6v3xULOyEAza6hYIRXDMngy1hVEtB2JDEp1nH3z.iw2dj1NcS
 S8jy_lf_EmhdRmEmqupDaZLeeVNipBnLPy4gFeqyP6MPVovHaFdHUmg5nPgE77NdcdYRZ4hYiZlC
 Lom.ya9Yqz7TdvKuVQ1QqKZogoCcSddt5PjjdpMR0vLG1sFuBpBK7_grbDsoVKjryRktoqC20OQG
 BItipLSxmtlZguttjIqs6l8sE.dj_5ZvY1DopaLDXR7v2DdKWwaIlzvZdR.qGC1K4IcIpQJ3sf67
 GPJvgUjn1IMRBajlbTO9X9HC_POMcAA24k.Pbtn4XmtI9JSIrGF1vHwXemRVS_2ISPplbWo.8KJX
 xwcrg.DE0cTtz0NqSY15vT6d5sZnV2QMK4X.afm71JjRTt4baVte_BHmAmXLNE010Jc_sbla.rUq
 nWJxu8SrAhsyRt3o7hmb6v1tcF401_YqQ88JEA_edRb4DapLhOc.snFe7JS2g0aZAn9.3PKRdbDf
 UJdXyAY3xSwhJ7UIZoxQvPjpUxVB2fIz9VnEyMZr3VUJCmIv0AILORSvhhV4myPpoS4Uf8_QlsKn
 o50N74nvS6GNnmQMSb_3PbWKmg4fGhD0yTEDqd_5R72lFqQH006nTw7ZiFePVcP9ZNxWcIZnxeyl
 x0hpDO3QNFUbY717SjtS6.fowrX5Bs76IBb6fOwg59aezCKSmwlJnkHCOeqIVMpSao6M5IfXj8_H
 goHLPzlMZQgHI42SI38OWmfA3Vd4kT6vkS7NWnKAIDZEct4RBn2M7fOq2h80b8gHilnA_z_6RwQJ
 4pMkJS7H3Aw82kAlWzKzKKLKmy2KwLMagJeCaQQ1Sy95FAHfEz6wfGzJt99XIAwWTrn1HI2NLAWl
 5qDHtZOTEV6bGbLltrJRhx8n.mWxirj4PA.G1HLhQoFp0piUPVUEp2nB_4Qe50G82UEdWXdjclg5
 vG2Td9VRmUMmstcriyI2Mb5PpkimoIyp3M1yiQeHEv7B6rnkbWGbsIZDRyb3eHqPA84xpTQhwD1O
 yDiZi4Ne3ir.JUGCI5sWSKi_Ohau4d8dRg.A_E2HwRBYDyvfJyngvZC3nrv5ZyufEyFS7Y3d9ffO
 vTOKl9uV.FHqSBWlqFRaebpGjBsrDyT.LuZDj2vaNcVTd.0P7PqJuKi3hxztl0_cef_M_JVpd.5G
 GdHwFX6M20qVoMqFMMjVF6bHyn4VcMt9BMxqVcyGZtk.u7v75ALKYn_2BqCZw4yR_Qx76p79wWH2
 cLRwjCFsI_gYYk4nnO_uDu.oOphJCUXDJHP0sSsHsrzLRUulIYfsdcz.1
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 0a32bf98-2a0e-4e36-86e9-51f75e93f809
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2026 08:59:16 +0000
Received: by hermes--production-ir2-bbcfb4457-sdst2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 659144cf4e3f782bde76ce13dad45cc9;
          Mon, 06 Apr 2026 07:58:31 +0000 (UTC)
Message-ID: <bbb2b833-a9a9-4558-8d4b-1b041f6706d7@yahoo.com>
Date: Mon, 6 Apr 2026 09:58:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 00/11] net: tunnel: introduce noref xmit flows
 for tunnels
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, kuba@kernel.org
Cc: Jason@zx2c4.com
References: <20260312155657.25676-1-mmietus97.ref@yahoo.com>
 <20260312155657.25676-1-mmietus97@yahoo.com>
 <726e1d40-6a29-4e6f-964c-1a4d0cf7d4eb@redhat.com>
From: Marek Mietus <mmietus97@yahoo.com>
In-Reply-To: <726e1d40-6a29-4e6f-964c-1a4d0cf7d4eb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275547-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yahoo.com:+];
	FREEMAIL_FROM(0.00)[yahoo.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 552C33A2654
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

W dniu 17.03.2026 o 12:37, Paolo Abeni pisze:
> On 3/12/26 4:56 PM, Marek Mietus wrote:
>> Currently, tunnel xmit flows always take a reference on the dst_entry
>> for each xmitted packet. These atomic operations are redundant in some
>> flows.
>>
>> This patchset introduces the infrastructure required for converting
>> the tunnel xmit flows to noref, and converts them where possible.
>>
>> These changes improve tunnel performance, since less atomic operations
>> are used.
>>
>> There are already noref optimizations in both ipv4 and ip6.
>> (See __ip_queue_xmit, inet6_csk_xmit)
>> This patchset implements similar optimizations in ip and udp tunnels.
>>
>> Benchmarks:
>> I used a vxlan tunnel over a pair of veth peers and measured the average
>> throughput over multiple samples.
>>
>> I ran 100 samples on a clean build, and another 100 on a patched
>> build. Each sample ran for 120 seconds. These were my results:
>>
>> clean:      72.52 gb/sec, stddev = 1.39
>> patched:    75.39 gb/sec, stddev = 0.94
>>
>> TL;DR - This patchset results in a 4% improvement in throughput for
>> vxlan. It's safe to assume that we might see similar results when testing
>> other tunnels.
> 
> Sabrina noted I wrongly replied on an old revision. Reporting my
> statements here for completeness.
> 
> IMHO this performance delta is not enough to justify this amount of changes.
> 
> Additionally, the measured impact of removing the dst_hold/dst_release
> does not fit with my direct experience on the same matter: it should be
> below noise level in practice, as dst are per-cpu and and no
> contention/false sharing is expected in a good setup.
> 
> I think you are observing larger impact because in the veth test
> dst_release can happen on a remote CPU. Note that this setup (vxlan over
> veth) is not very relevant in practice.
> 
> I'm sorry I'm not applying this series.
> 
> Side note: if you are interested into improving (UDP) tunnel
> performances have a look to big TCP support work from Alice Mikityanska:
> 
> https://lore.kernel.org/netdev/20260226201600.222044-1-alice.kernel@fastmail.im/
> 
> /P
> 
> 

Hi Paolo,

Could you clarify what would be a more realistic test setup? I'm assuming using physical interfaces would yield more realistic results.
Also, what performance benefit would be worth this kind of "code churn"? What kind of margins were you looking for?

I got mixed signals from you and Sabrina, so these clarifications would go a long way.

P.S - I'll take a closer look at Alice Mikityanska's "big TCP" works.

