Return-Path: <netdev+bounces-258462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLNTGiLpjWkm8gAAu9opvQ
	(envelope-from <netdev+bounces-258462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:52:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D016812E972
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D07F33055617
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052335CB87;
	Thu, 12 Feb 2026 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H41JnhNd"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-56.consmr.mail.ne1.yahoo.com (sonic313-56.consmr.mail.ne1.yahoo.com [66.163.185.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14935C1A9
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907646; cv=none; b=nNyiIsm5rbPaRyiVc9FSKQnokOXUHU+qg7IbT9ZwQQkLCPfOcdpjXm5vcIxYNcr0ccFwy1hSJiW1mC+THKqFisee+e7GIXJk5LznRcYsbQGox7Zvb2Xix99QhU1yxrrNzBKG+6tLwB4jRDfC/G8pnokpEQnZbaaXyVuqALq6ybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907646; c=relaxed/simple;
	bh=h9iFfN7NLoWArbyNqDhe5PWm1RmyFnrZEA5wqjmCM2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9f3RPNnU39xhb+Xl/1DQzxoelhhZADcOE6p2GPlM2bYJhbHQrWQu+hfN0eRpbj73MuoxjPaxviY6JQxH9gpeMa2fnUwI0ZSuec23+/CO+whly0AlNbad06AB9kdViMi+VVcel8g8rZ6ssh1E8Iw3IXgc+mslJF9S2dKA9mHqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=H41JnhNd; arc=none smtp.client-ip=66.163.185.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770907638; bh=wKVV5r2hXsqlMOl3cIm7MXEZwDlfSoJX+Rh1ZPsYvio=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=H41JnhNdu+BusDs8Wze8s3OQFo+NT5Ysg5uUaAbJCFeDsf1I2Hq36Jn4CXp2Q3kUFyGhUFHhgh76/hU9pJgD1GNG6uHy6HJrnmW7EoIlIhdb9DO3nXewgg6mtsYsy5hXkD7dh/EgcdDqIxe/x2msgRRXumhTIRS9nDfamK0LPdFH3i61KGMwL/UchO23YnJU7kNvd99EWPLZBqbbLSkK/caY2PuUt0Xz58FPQEJtNlbv0Q+5DCdbxKPQSSBmXJjSD0fu2zhuQp1R+KrhRZ/K0YA4nni/FA6sijVq77GuUQ1OV5W4zIh0nMc+MS1trURK400AnzfpW6GzQWXvduQ/CQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770907638; bh=1JHa76Mp+BCeI3HtFAeodDaIiIOWGER55yZrJ3wafv6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Ox+qa1qw9gpFiMEG/tgY4uUy+eMKFLg4ZVF574Nh5m34U1C5KG5ak9FFGfP905aUibNCvCU048D5LluaTRJKCHARFA+dOGN9qdCh3Q2ZXgPr03QmvbFHurAGMEzuBPgHIGqvcRojTi8DUqlidQ1A84lBdUQdFMTYekTZOGIVNYElYqtgOBp3mqSFoO4QufBqkJ8cNciqDkCCFf4KRt1P95kzYK5gVsfzlTLR/4ZjswiCOJeTirtsK+pNqS25hiMg6u6LVpGCugjOSYilz9nyBe6NRc+3WpRTKeb05GjyPUV1Vy4HLZXCvKgYxdciZTeGLPJTiJQbzIvPbPnF8Q75Cg==
X-YMail-OSG: 4yL4ztgVM1k7VOt1NoszolkWklTuRwOd2veWinUH3qRsJjQU9VvNuXH1Eqdca3o
 RjSWgRBsebprUDwwPq51z83sMocLksI4LqJICEM.uo.9LMosMj6rbPlVFSKeIZxK..t_39ukb3B0
 WdLmol95MvX3vVEzGv.ERVoVVHjswIS8OS3Kj70JVAY4KRQPaxkVRjOjz0bf.RgUdu2eoFAi2zFd
 86Oy7C9t55V7n1.ZItjW2Bi09NgQvIDjh6OfiluHRzitAbhl4NzNjAHgZrzlo3kV1oypFl6nTJhs
 2jZQVVQwxqqyi0hI_rmFUgUpu7GGtGkdrHL.mTlYtCC2WdGNcq6t7cWp3AekygE6CC9tWzZOszML
 SjTFb0xVD.Vllrh1J0u5O8L9jhPf4ZYJOCrdEqrYB2.I4knKITKtduydN0.HabXbR2XuEWE43Sss
 X8evfcrhAKCLryNxzNlbHcpLrh3RDYj5wqBJfkHFU5nvGfkStUbRhvyrnXu9CNy3yMs8k89tcXi1
 3mZy_OhW0iUFEYh05SZQmASYDsY.yFVthhrMrbd1ZgsTv7W6bMxlJ2orT0MaD.LGeWGtrZDgvmkn
 brlRYZ56ECFN79jGOrLy_ZEp47nCLkUuO0RPfbXZtpLoynasiA0dnEIeHw6cWC6qPwZxxDbhYab3
 bBjbN0469rowSAKP0iSb0pwHS6nv19QJqKcjL3Ns42FYdDfxqMQZvsbKwLwr7HqtF0qSbtWsRR_n
 Fb5XktdZp7R1x.bussqvrMu00ykvYOvVCPDCZD_imO5h2Q66GveZowZQT7J2mYd1NYeIUoV7ldfu
 sJ053ven0vkAscs7qs9yYHewaRMvZyNV46zP025sAGpHC7YGqwjhPEiwewWjSUgwKTa_LGuC_5By
 yRIDgUHVP69JEazKb.0fYLzyBzSvR1fJ2u09Yv09iG6UZr9RwNvPj4fB2ZU8DMnAQnwS2J0kVJyp
 WniP8hajmGmbnZ0Dwle2NCg8ifjhnofeeioTy76ER_oGF7evdfOYiCBRcpzdTolAhhHIiJkoPYNk
 bTG1P72btWY.0Pn4fVXqKHjq9M_Asu1whaHyHHD0C3NJopXrJ0ffzahehM2Zk6fBayDba9aupz3T
 .1mPbZKYKldGO_w_SyNyt0ku0l7qkRNQXL4OkOoLxVWnYh8u3aDZjR3f5V3Nok19etK.zgkdf5WM
 o0_0aWsWmRFXJTeA7uLw0gc.3BN8g6IEKyEaliY7HrMS.UeY044QYI_rMB0ecOmyqxId8rtGEwhc
 ZwHUwjiTsvNNGxLZcs7Xs51AfcNsDz8VEVw.mO3lulpGSTFALnME7Ied5XBAdJ1vYcn0Lqu5bSZo
 pscB1TExagRz6NF3VQ.W7tJSF069Hz7k2YhXkemhBSlLFtaC2wREOZZ2BBOhCrCcVdzcPlwm.3U5
 o4YDqgVzXwi0ch7OKDWZzM1dGTw1IKXzc76sQxy9l7HzKTdMVF3B05PIFZjeMJeZN.nd8SQjjofj
 ljiS_PQ0NiesjaQTfwgq2sIvBgSNQJJ4g1chRduVhcwKS54WZcbhcP_hj7mTsbVFLLCJK6oXJ3cB
 jfes6WrwrnhrlYdBKb.mxqrVuxsaRu5I7OewfmzfYT4PDpI6kL5z_9wgp8c3k1TzW8TZRKVqqxqo
 YlWdK9UTxlCP0DvMZvGLZQq1aPjyIuc7w489Yfmqltn9.YpkJotM5wAKIMCmS2WnySlao2TxfCIA
 v7UEiwPc_r8_qwWnAn32eb9LosIbplfSD.uzOn.UOlpqW0zD4kd6H7T9ORs2unCZn154.5TIw87I
 bq5o2SggWT4FKvyQWOP1HUKkiMUhCqWFrKWOT6HBcqM9FwwhbGI4GN_qPSIyEVwMvQzps6_cHqpg
 7s897GbvaxHAjXHxC6PcUODO6NpBptMh6Kj_.3MVR1YTKiB7.imBYcOuK9xZIoJ2Sl1p.uKRKVfo
 PLF2q4OHiItCxFwWs8PhdYW66N7HRdqBXs6lIqoqm6XC6P7IgxOYJtPeVEhijLxTi76V.PLgoZpo
 Chn4rgJCQwLFBW4YMMmKD0UMmr2IlFz2aeSFOPDEoPmmObGWDt7dAuT_RKZOLrdGA.5Nz4eSBLO5
 8P.jm.iu3W4ooomGvDsvsfD3Pxxkj3rhozOHzgENvvg2gcdfU__pz8aj4hugb62DOtolh226DM.k
 bwmbtr.bYkes3WTpr8eeX0X.ip3YB10QEm0Ag9l1HBNbaI4OKxc_pmA--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: c2649088-8d7c-4a9a-bcfb-b88cbf8dd89c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Feb 2026 14:47:18 +0000
Received: by hermes--production-ir2-bbcfb4457-g4h2c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 486308bf46531f12f76b3234db5205c5;
          Thu, 12 Feb 2026 14:47:13 +0000 (UTC)
Message-ID: <2e651cd7-e6e0-40ed-9e88-4cda9a96185d@yahoo.com>
Date: Thu, 12 Feb 2026 15:47:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 00/11] net: tunnel: introduce noref xmit flows
 for tunnels
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, kuba@kernel.org
Cc: Jason@zx2c4.com
References: <20260127070452.6581-1-mmietus97.ref@yahoo.com>
 <20260127070452.6581-1-mmietus97@yahoo.com>
 <a8ea949a-ac36-4753-b8ab-f9a85004750a@redhat.com>
Content-Language: en-US
From: Marek Mietus <mmietus97@yahoo.com>
In-Reply-To: <a8ea949a-ac36-4753-b8ab-f9a85004750a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25178 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258462-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: D016812E972
X-Rspamd-Action: no action

W dniu 3.02.2026 o 09:32, Paolo Abeni pisze:
> On 1/27/26 8:04 AM, Marek Mietus wrote:
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
>> clean:      71.95 mb/sec, stddev = 1.71
>> patched:    74.92 mb/sec, stddev = 1.35
> 
> Which H/W are you using? I've never seen so low figures in this decade,
> possibly not even in the previous one. Expected tput on not too
> obsoleted H/W is orders of magnitude higher, and we need more relevant
> figures.
> 

Sorry for the late response.

I tested this on my i9-13900. The reason for these low figures is that I
used "iperf3 -l 2 -c <IP>" to measure throughput. I manually lowered the
packet length because I figured there might be some other factors at play
that could add noise to my measurements. I'll measure again without this
limit. From initial testing, it looks like this performance gain is also
achieved with the default packet size.

I'll include new measurements along with v8.

> Thanks,
> 
> Paolo
> 
> 


