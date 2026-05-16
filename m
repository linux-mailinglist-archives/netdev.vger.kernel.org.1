Return-Path: <netdev+bounces-288648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLWeFwuOCGr4uwMAu9opvQ
	(envelope-from <netdev+bounces-288648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:32:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F311355C693
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA33A300C331
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141B3E3DB9;
	Sat, 16 May 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HF6z8rvF"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-21.consmr.mail.ne1.yahoo.com (sonic304-21.consmr.mail.ne1.yahoo.com [66.163.191.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725D823ABA7
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945534; cv=none; b=V59aRJjlEHv3hznAIDCxPK2z73ejuGNrJFLs82uKCXlx9potqTX6qRTMDAwqkZJJlzZM/iCEd+GGSsQg3aBB9Ud7Zy/XmGcmyvyAE8AkShNjmncMZRkkzeXUOHZym7LqCoFTgzhV8cjEtMuxpNeF9RGfjLY/qts3+WJm+M66UrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945534; c=relaxed/simple;
	bh=w6HF1tGiXqGr3pKc81gRJmQOwvACaxh55dTgeeXM49g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u038OzGjjZVpgdIOu8WUOCw4LNwy/r6KbKius75AOF7gM/4reBj2Fszs3eJxyTxmniH2w7dRZ0HUkL1OMOlqRQ6zi/mEmGmKOvj5YcWUOsoRnJwPwlJVMcXA2qbkcsaG0Z2eeRwD46q6gYrKp4jln45jsQJkVa9vJKkWlq5kAbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HF6z8rvF; arc=none smtp.client-ip=66.163.191.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778945524; bh=HnOsrR7Ov1vN7kfVeSnsIl1qh9ZYOQ04F9Rg6wQtUEA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=HF6z8rvFFy9f4v5o73b+xDYRoDUCOYQ55ACMlFF5Tuecnk584sOu5vdXCrQUd5+Pz385kvcv/bCZtpJK3Bgin6Q4AIGB9JneOPrLan0s5SWWD0R0fPiGT3a/uroZSk/m0CdumR4lV//oHbbMtGQUhdW6R87/p99lNcDXfsOa68mR0tcJ5E1gHYM7mmi0NbiConVtt/hlsyMIb5/rXd+CMIIkpccSAf814CxzmcpONA+t+auB1csdIeXF9IIbB36FFCyOfMtrRl3sXaVPtd3+sbkkuKOBn+HWvAWR3Eb2Cwv0KGqw8ZWrVBwNOy8SUy+fQbpxqVUJ4A8pASpGTOC0MA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778945524; bh=UrOlFUOnWQxu5jSM2izwUYIohRtbpjvfrQ4upHaJ6eg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SOc8T0uc/FreO5Vk+Xp8tb7tWIzDEQ77/RHobob1ki2T9L5KZJTfuHev7xgFMRapf96uiiGuj8FrCiun1Lh8gdZEwwb25vHL5h7zd99B/IDrOBVWgoM1/CO4z9vcLEVvcLlzL6rx/LPW4dKqVs82+tUZh09ifKHu90fDugOKUCedBoNm3cVhJQelO2UGel7G9Bid1GnJazYJv1i6O/KV/LP2mI+peEtf842bo/whMWfvhU5JqUJT0qutZQ1yZ185GB3P3iw7GlUCHRdyNRKmHiZWBxtBZqH4XD/1H060qG90iswhH0q1hqMV+GWPZV8d62qXkCbaVi8/add8PKejtw==
X-YMail-OSG: h1W12L4VM1ltDgAE5R9PDd0i76uV_aSKZsrBmSc__e3hA8rbtekvSIL5YGkTByM
 x2czNk6IgcuG7dwEWUqHR_bPzzUVQqfL_tsSqJrfemsxMqWIAxRKUw9eFhG_Q45kYzvIxvP_G4WD
 1hTzn8WFmFtC6OwEUsO2DVFExM0L3u6HhgjJjp2FuTKbKBzu15rMMJiPbfmq7uC5.YnMIOlN1ay0
 XKbsEctUeiKdKzOFi0rLuyFBoK0J1.689tJAcBFmaTM4sOb0cOVlITbEOQCYw2AxbwLTatbZCNtJ
 W4xbeyo4kyiNtJuwpXvM2tMyoQsyOHCKKa2rv1XzebuX7o3kbPvdZPqo5c3Nh4.nbwsXDj26ABql
 .HunfshWXAFPJDUOQoB7pNmv9BZuGCeKW_TGAe8y4gaDxCpWK9Jsn0Kw1yiShxHFZtqHA0zmkvEm
 xFQRRJkKv.9Q83QHwED_8NvqQ8WmOBumeYerMejyHTSq7_AvcsId7TlqqOrmLc07Ibmr6Dcy41k6
 3wKSJ5iIU135UfGXqkr.15uE8nTr0H2aMlLKZgktikS6SvTKwlGIt_YOoX9nepn2cEQ2_4IARQr1
 vEKHHOaxRWL1GFgjO1XIBT5xZM15FxNSAlgS_D.1CWEEoatSk7TfqM.iDxUXrvc89ByKG_xMay1v
 64cUJfSnTHn5Frm3jyHHJYOKliaG4dbYTG.l.tSRXOKtfHCeXC.bihcsLUBzHZme.nboNK5IBzz0
 FeH63UpUd8qIDjr_CXGRh4MqRT5Sb0lk_dEnTcMi4SfwjVNG_qm3_Y2D0f9uaQmwRjnj15TEJ_j8
 BBj.nCgrevAa8yO7tZzsFbm.A2gVOP94n3TFamzH0iMamGZcYanaNbW02N2yx9JZ.Ivhi4Fq8A2D
 XjsUJz_GNUYEV2LpmVfIIJUJaTEZCvtjZFX1emyJdOwPcZANaAMTVx5ITmSKGizTIpVrvx7al2Xw
 Qj.3Xy4VPN8VWCr7oB9ZDZcy.uxHrwyVdKJZmyRlxpOOKqDd89WoMfhK9s7e9baBLOv3I6yoNCtN
 2z59wdzB7MvCE9CJM2bnE_Jezszt0GI6dxo5yF5pduG14Z8.s76EvkXNMJugg84ZY4b7BOxuF0Gk
 qjymmr7k5BsxeLmzVOP.xYw2Jq5bruNbX03R.NFJLaUSnC_iBAGhAbHY4KfhHKwWWZ7MQY2OsGY4
 HSX.KOYr0giiUDhuOy8l20El2XszPtKabpDlDWfK8V7EoJvxIcBFTJCJdB2U.PZL79PYIIoPXglr
 mO_Kb.pzPORlT.kAVaBY.d4HltMaVPYs9YuzNKjWuBm0cR8NwIqhxqGncvnSe_GitzzUEaocCKa1
 DXZNd0.zPWrN3c2Us2AUsYX3fq9f6p0xECMLzBUyFQ5fTY_SzP_I_0yZ52RZqMjJRlvwcfubHQHS
 dsEaO38MiFOIZhHrZKSIe1AEuSL2Iv.nGXQiAn47S4sfiJIdS0rJajlDahtPJqbwlMhpQL.EqWaT
 k7vVXbUyRoJHWG8apXKJOtlQp6ZiHOmFDnZuYYGH_zlCAMYi_3jVxFX.L3W2hmjtqf2neRZFj4VZ
 ZTSCfwoa_MXPZPLV0pi82unYj8VD2jHuiL6yst.VQPbtmTK4shnVmzS5ZTW9mR4nLabDd.mV7CSZ
 aujMTeNEZAc.dSEGdToYwavYi0l6hRvUhIohRzgShIj0PVb9pUqiBIk4OhKlCgGTzWhThYbIXOqI
 L0c4LSnO4QCKvLSC9aXE27X2sTETnv9myBDI1n4xiOw1_qc6WwCHfQrAIv2tP6eEPr43GvKRwbmY
 VLicQu2Cw0ho35koQz6k3aeWu7qtKMlUg31z08gz6GbMYmQ.q.H0sgrddYV_RLBthiEwbRIayKma
 vYR.J7JeuNuhZqvKPE1PvmM6SIg2pjKXrrI1Na9mVTclMdv2IHtVKPfcv8.E03Toq2bmP2OgvZxB
 YKZjqTGpUpPEX_vOPVJ24npG90tCJlXKOkcDyH5uB_pfb9r2VCSNkK8cFDcGx5gMQ0hPPwvE8.eN
 tLhBrHWoOsy6tRSBMG1VLLwuEiMHKFjuoTS9ILop49fDeGiV0wF18R5TI3FnhDp6CNOUyldNuQi1
 MMheTpVayVoLwp6v5cBEcjG8CbZWJaiqD8Fu99rKhWHrPVeWBiyL5BE2H5jFl.5Cabwj.dmXTj0i
 2k6jDMeQhBfoTiIWe0vpIZ_lBemEn8_..IH1B1Ych1ENJadI6Z9pXjtc7ZMFtyKS.USC6HNeYCJQ
 L2FhB2rjaEspU347EcYHhnad52nmZv6N5zlaknuRXzh09GDOH5GoKpzdM47rSfCjTMkN3TF64jjK
 .pDQj7AY744NWTvWRRZkNgGH7kGKAS44rwUashRupth9AxQ--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9d80aa64-657e-4b48-941e-eddd7663dd35
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 May 2026 15:32:04 +0000
Received: by hermes--production-ir2-89844b765-4dkpr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c74aaa6258d9a3a4af93477304ecdd52;
          Sat, 16 May 2026 15:31:59 +0000 (UTC)
Message-ID: <f24089d6-5d38-445a-9697-ec722273bf58@yahoo.com>
Date: Sat, 16 May 2026 17:31:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 4/8] net: dsa: realtek: rtl8365mb: add table
 lookup interface
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
 <20260516-realtek_forward-v4-4-8b6d6a1eefdc@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260516-realtek_forward-v4-4-8b6d6a1eefdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: F311355C693
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288648-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Action: no action

On 5/16/2026 5:46 AM, Luiz Angelo Daros de Luca wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Add a generic table lookup interface to centralize access to
> the RTL8365MB internal tables.
> 
> This interface abstracts the low-level table access logic and
> will be used by subsequent commits to implement FDB and VLAN
> operations.
> 
> Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

