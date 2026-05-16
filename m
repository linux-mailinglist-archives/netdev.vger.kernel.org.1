Return-Path: <netdev+bounces-288591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPreIFwKCGqPWAMAu9opvQ
	(envelope-from <netdev+bounces-288591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:10:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 307D755A714
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AEBA3008995
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 06:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B92D3A93;
	Sat, 16 May 2026 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jBZqf3FL"
X-Original-To: netdev@vger.kernel.org
Received: from sonic315-22.consmr.mail.ne1.yahoo.com (sonic315-22.consmr.mail.ne1.yahoo.com [66.163.190.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338E2F7EFA
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778911834; cv=none; b=b/LJLSY13NpKETPX9u5DgjwWjWnVEzgb/RDN0uraDbwNKO7UbNflZBdN4EZz/uDl5EzQYSHId0XEkuB7rqXL3/DDEqfCtP2AA68TOhGmXdF7X2mgtdMkg53CspXEUzMlWICF82Vc8ZoqYIrIjX/q0nFYXn5h2uKLL9BHK99f1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778911834; c=relaxed/simple;
	bh=bxgc4YTfsJuw3vIFJMf/UYBPu0vmdi58MFXWju67WAU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JZb4m8/JVfbvuxRixIoZmXiWxM8a1GzDeIkYvh45tjhXHlLtX5Ym9oI0SrqZak80UNdVubY2DrnCi9X6OrT+M3ak/R7kLIg+irpHB+RHgvBR3sekyb5jvXKXN/5jPfAzLMA8K+BLuY61nyP46m7M8t+tyN4EpYHgUZQ24/HPnMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jBZqf3FL; arc=none smtp.client-ip=66.163.190.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778911832; bh=jDr9oJom1fw8aQ+wYn/oZVYe9Vm/nYGh+z+rXo/tde0=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=jBZqf3FLfoX2oSP3gtSx7HcQVdnmnINim+U/l5TFxMsmAiJ2xw3TXh6OhYMoNVOsgwbkVZWTARh3HaOxcQvsjYYDqNqOh1B2Eu4s07d8IakwEQwxwuhv2VIJkDiPAV1MH5WL1GCYQElh2UBuvg7GYmJqve6LKL+H3tJ+yz/n4wNHrdkOLdg8R9ctGOm9mMSRY/dACEH7P1+3yfJchctpTlIQJnVwclV+Um7lTDa4RjCtwiT7Dyh1bqCQvSEGGQvE9Nf4I7C8G6RLhB4YI8yR5w7gFkuTzQ1PR8zckXGRwwvnZMQC2DSgM/DNALIyKJMvidglKcArUl50Y5uSmzBAXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778911832; bh=QAtJxjAV/zQw1g5yBwTvtuYBFwJvq09ej4f056m5k3C=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=uEaA+jeiIKZ9B86Max1SZL7CBams4SpgNOtCVGJh21Pi3G4karkKxPSiu2S3/WQkut0VY6mj6y6T+xEzMSHd9ZVLnnRPSAr6BmcE4pVbT7HsqVvO/Z07wq9vNxwTmdI56sHrzEnlLItCiSI7NVUZWqHcmtnjYdn9RtpsdG80tegJ3y3IRdqnEXpb4a85bxXki7uE1I/1omJ+2p2QszArfDjvo2Lcdt9RAlym/IEtjNPAT2vcL5eDUz3vEQO9mb+jScc/x8WiMbqhzWqqVZzx4rjx2X3AisJC5mLgk29DTh6+kQkzJ3lIzc80U0paWtI+afnlGbLuOwl2lqh4Et1ahg==
X-YMail-OSG: tD3gGVcVM1kk64.rVhdreGdwg.MgpVCZgsroE8dnvtiHY_sGUkITiSxE7kooX_l
 uPoArT5XT7ewgXXMUWpwDoJ4_BwSwE_mdteX5gi9N7EolSKsqIA3srz9fc7cQEONyi48MAR614D4
 41OYt4PBAtYIa9OYilossea0dzzvE50L7T7EV2sII2c81_2K.sdftiZh4FDF.zOswVsgjoaHyklQ
 r4pTh3_L2HLUzI_fsB3bFiUx_B0qsWA9WHjaUXV9EoQAYck4SW3b4Xiwp1i.ioS_paG6LCCRSiXU
 AzzTudmr5V0PBPO2WyKRzSdWq1eJZVMsN0.2T905a2FYNfJQU5srl5CUHIiZy.98wCunPHNJUyKY
 t5KiwwO2F2.qwzNiSKZ4bgt6RjOPlL5Hcm97wgA1eBoIu5Q3GJDF2rxNK4Mww4OYRGTpFZoy7EK3
 DIwcr7LhveCp5DSzURfxVPrd2VU7IYFcD.NLgcYic5NaMpQPxsJFeY91VLkn4wjgvNI212MTv9vT
 dMQl4KiK2MXc2dfKbDBv_C6ESB7u8Yo30Xxa2HKZZoDHS_ntkelerymRB13kmd6N0Reka33_FyAd
 BUESur0fJ_Ixl7Fg5j3TA0EX1YnoWmqbNVsAdf41aD5VhNWK0A521v3p0r6euRKbHxkH3NXCb9JP
 u8Sf.414tCo1P0PN8oMwZd2INZON0.MtFlWkx3zzBAURnHSlp.zgHNhdxSp_cEJtDR9NuH7ZFy39
 CoGi80E_ffxpCJZ38JMXNsGJm_VRyxIb0u8kmhYDviJ_4le08H3c6Rk3bTZeoBl9WmXNfbyCaY1U
 5yGmAkjf0Lez_ihzuvYrER.28MGp0WCHhBtY8uAMARKzD9QIMW8.t0yJz519ck31G..OuYAhJPcf
 bcx0CDDnd4gXdUdTyid5440x1oWbI2PryBCVpalvw3AqH2SviW4zE1eu7HJqOwBbNGDZijYQoZJd
 CI5zhA3_W0WYqHkq3zOQL7vWJupRXrFrT43Z3AuUFXLTLUxYfDYzPZom5zmnVbvegQmE83VOr136
 SDlMqBH5GOhP1XWnBmQrBf0T.RI7YpV75Yc9lq_AoXuKBqCw_EsPuA9CtzDteeOqeSJv4h8oeXYI
 rZooDI6QeIiRFsNRJQry1WpKxEfm3xHHpJX3iFSF3SuXfbIWURPmtarmgN0C6WYwzFuBvP_H9xEd
 CjZ8uvwGlR7pbYpRaYUKCyL4h8675vbkATHeXNaWQ5eLPbaLcF5ymRUH6wUXaj6cjLgEguvwAn7z
 zI.PT5AZE2b7N9zaQb0.jOfvehi9RtbxW5bRBVfGyjPkIwEf_eoaHBCFXkwr_LKQXHJkXY7N0haT
 TW3pfTx5q7Pnw5bikRxcH8sKHZ7vv5kad2w2bjI7.mOCnOQbO.WpWthkVp8i6jYGlsSfLQ0M.FMr
 6iwylxbSCe7GztCUj7jMNmKVo_ajWy73Ajk15v8JPkB3.pA9.lw.JG8YS2mGoigmbvRK3BOcKz.Q
 Bf673M7bThsA8s6v9r0r2dBrp9RNYg2XQot0F8GiBdMTgNNpOTu5dXOs7yfp0JejjnQdaf79Nb2X
 E.bFPihy0miGLHVvBFHudEKox4daK0o14yHwKXVOEzO_iXN0VhQGMOyk4LxzSuOk.lqyqEn3grB6
 cbt0yy.usHBMfrnn_fFMrhRhjpqbo1_xaL0jIHWqcNjw2wTYzTvSt1RQ8yQWX8.l8H9dsS_VAR3T
 C8MqL3_o3XRmmNr7YEybjzFpXMHJ1EBxk0PJvYZrC.qfCYTWO34Ncjxw.VntSzYqWOiDMExLdgiu
 PQujO.NlAGqZKyPDmPCJBcFo_WG2V4F084sjmRCzj27oNIy7Y_ownGgXGCX5LDABBkQW3W3WN84d
 xtbc4Ix4uhhthJO07zXlI8Mco.E0I9dRIbhmNiIv56GMr1ERdsfMGsOflMdCWNch7XP_S3zZt26S
 O5LXmAYcLAtFnt_Cb2Co5Ugj_Qw8dziWf7Z6uHTvzoSjDkiB3rA6yd8hcRmQTKAbkOujmlWjoE6z
 1nF8v6wxwuQh3W4a__1fwIhwxRPCSbUNsn883q4BLQJtB1ypaHGDcoZkb2ckKnUxUd.f_TBBKo52
 WGZCzLX0wxaarh6pU2tcEzTaKzT1uHyid.ef420xJrXs2xCHd_s3wJRl6pS1YzN3zR3ku4oAdJ7J
 GUtaDYNN6wWUJG2XkvAClGNa.x5DS2BO9POSRHxLUqbjZkdZPMK969weCSzl6UeUwyK3h_I4hjM4
 X1JuZXq0HMWTAwbMhOvNvQefdZBI1zeBtKk3Sw0SqlR.8d9ekNNwc7SXSunWOyqkMsmznSJeHQeK
 SYLum22nTUoX_5meYFtc2rPCWBx2YrrxL0Oy3GtY-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 49f81ff1-bd5d-4b6f-ab94-0f7450858c13
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 May 2026 06:10:32 +0000
Received: by hermes--production-ir2-89844b765-bdgnn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0d872dc4597e8f29e811ca18b30b5c9b;
          Sat, 16 May 2026 05:48:31 +0000 (UTC)
Message-ID: <03d0fc52-108a-44de-b22a-6bf4a2d9da90@yahoo.com>
Date: Sat, 16 May 2026 07:48:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: Re: [net-next PATCH v4 7/8] net: dsa: realtek: rtl8365mb: add FDB
 support
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
 <20260516-realtek_forward-v4-7-8b6d6a1eefdc@gmail.com>
Content-Language: pl
In-Reply-To: <20260516-realtek_forward-v4-7-8b6d6a1eefdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 307D755A714
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288591-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Action: no action

On 5/16/2026 5:46 AM, Luiz Angelo Daros de Luca wrote:
> From: Alvin Å ipraga <alsi@bang-olufsen.dk>
> 
> Implement support for FDB and MDB management for the RTL8365MB series
> switches.
> 
> The hardware supports IVL by keying the forwarding database with the
> {VID, MAC, EFID} tuple.  The Extended Filtering ID (EFID) is 3 bits
> wide, providing 8 unique filtering domains. This driver reserves EFID 0
> for standalone ports, effectively limiting the hardware offload to a
> maximum of 7 bridges.
> 
> Introduce a mutex lock (l2_lock) to protect concurrent L2 table updates.
> 
> Add support for forwarding database operations, including unicast and
> multicast entry handling as well as fast aging support.
> 
> Set DSA switch flags assisted_learning_on_cpu_port and fdb_isolation.
> 
> Co-developed-by: Alvin Å ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Å ipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
> [ ... ]
> +
> +struct rtl8365mb_l2_mc_key {
> +	u8 mac_addr[ETH_ALEN];
> +	union {
> +		u16 vid; /* IVL */
> +		u16 fid; /* SVL */
> +	};
> +	bool ivl;
> +};
> +
> +struct rtl8365mb_l2_mc {
> +	struct rtl8365mb_l2_mc_key key;
> +	u16 member;
> +	u8 priority;
> +	u8 igmpidx;
> +
> +	bool is_static;
> +	bool fwd_pri;
> +	bool igmp_asic;
> +};
> +
> +static void rtl8365mb_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc)
> +{
> +	u32 val;
> +
> +	uc->key.mac_addr[5] = FIELD_GET(RTL8365MB_L2_UC_D0_MAC5_MSK, data[0]);
> +	uc->key.mac_addr[4] = FIELD_GET(RTL8365MB_L2_UC_D0_MAC4_MSK, data[0]);
> +	uc->key.mac_addr[3] = FIELD_GET(RTL8365MB_L2_UC_D1_MAC3_MSK, data[1]);
> +	uc->key.mac_addr[2] = FIELD_GET(RTL8365MB_L2_UC_D1_MAC2_MSK, data[1]);
> +	uc->key.mac_addr[1] = FIELD_GET(RTL8365MB_L2_UC_D2_MAC1_MSK, data[2]);
> +	uc->key.mac_addr[0] = FIELD_GET(RTL8365MB_L2_UC_D2_MAC0_MSK, data[2]);
> +	uc->key.efid = FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MSK, data[4]);
> +	uc->key.vid = FIELD_GET(RTL8365MB_L2_UC_D3_VID_MSK, data[3]);
> +	uc->key.ivl = FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MSK, data[3]);
> +	uc->key.fid = FIELD_GET(RTL8365MB_L2_UC_D4_FID_MSK, data[4]);
> +	uc->age = FIELD_GET(RTL8365MB_L2_UC_D4_AGE_MSK, data[4]);
> +	uc->auth = FIELD_GET(RTL8365MB_L2_UC_D4_AUTH_MSK, data[4]);
> +

The problem with overwriting uc->key.fid and uc->key.vid values in the union still exists.

