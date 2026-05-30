Return-Path: <netdev+bounces-293344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEsMD/3MGmoh9AgAu9opvQ
	(envelope-from <netdev+bounces-293344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:41:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FCC60C93B
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1FCC3026C04
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D1A3A71BE;
	Sat, 30 May 2026 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UE3/KmiN"
X-Original-To: netdev@vger.kernel.org
Received: from sonic316-22.consmr.mail.ne1.yahoo.com (sonic316-22.consmr.mail.ne1.yahoo.com [66.163.187.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48A3AB283
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141234; cv=none; b=khDLzHruxv1bUMudnVH4bewG+1D0LYaldFBKTdvR0mZEStPXwCgIWLPCp8nBVbCnajL+qR17rsTVsko+bFwzFajvwMm6HvDqy1sSnNlCsbApNkSti7l0FlY22/5bjTPsrwxlhcIYo2GKuxtIJqltrknQftV77leyPGR1LhGeJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141234; c=relaxed/simple;
	bh=2nx/Y0k1J+Kt+Xtj67QQ5iTIoJu6A4ttlVfhdTesMeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4rlImwvXJVoItSmHekn99mn5PKlg600E2ledDxIVHsyybrN3kKO0NmRzizGNKDqYXO3X+L7wpCS8lZ7mA8oVO8xBRYpsL6gvhWW5/biql7eCRvjFICKBNKJ3mjgEuLMTt7fElv+LDH4Ea9FNruvThmRBVPr8JJ0NJbIefvm6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UE3/KmiN; arc=none smtp.client-ip=66.163.187.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1780141232; bh=DXrz57g5Jtjh4H1cOMWyguqfmFWvXrRNMIeNDJLw9Mw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UE3/KmiNcy82ykYz6tBR4c9AROfLvUyZeb/Vr6Z4X9MfaI9zWqgRKos0WS0rmSrt6NTJ8LlQlnhOrfLvs+gm/u7KiOy30VJstzd+CjDLuDlBgG1W07dIv7cESllcnXr2xA1TtC7BsmvrkSRgqf6oeH8pLfCWJ/ULWFGyM0e84bx2EefZJMgzLDOp5hKBsF1nb+42rSI62er1FSvIRWnZRXKNF5MYHlmvlJtGlnMS351mvE7AwNYubARQkYYUYf2y53LDnVgMVH7L0N8NOjt7btIYPlZyXhk6W5F/fiP9S5OyciFB+sgK5Yp4SYYfgBXuPAUKNO0V0+PwqvKESHsVhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1780141232; bh=cA7IDz4EEmMWJmKXGsknae0JtRxm8b+FJ6q66iHpEAf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZCHaYheoa6p4jlekJ7CedJy2e7fwJksurjM8TeY49EhEfbBLEK73iUF23ZYfhs/eVKeObtrSSu0WwKRmF8I/XLwZVpZHBbrd5wqpILRGFIw8WohP9xgNEppxxChHrChsy4Z3gTa7VTiGw58bT42cpqKOws5PYHJi9lwsDv7CNAJw1XzYDuop60E9wUXDXmz3U681HCLgKG+mnGI4BvATgwNuMZzZas3laxq23fIv3gClwpupdRL5Hn3/WJw6u6d29fVGxjwQWRsbdOyq1m7R57Ib2diJty8U1TC/Z4u9wYfI4BBFHxHMMGRflLq/TrAFDMwCH5g5cx5CkyHOB7vHOA==
X-YMail-OSG: PmzEeQ4VM1leDkur12rec2XubHgcZYdrfI1WVfdcTc1qu504hnv23dEIv.Bi4_i
 _IqxgsK4HxC.xoYFfo9lljiYWY31BJxcFxNPkxinR7qbSa0wK1tmffB.8JNMG_lzGl0VQvkhil1s
 ZDBgJcRNsQ8lsGivfBVjIenajalsIX4rqiJkzWTn7xQ0gPZlMnYnhkN8VuBtPZMVY2OgPcyh92T4
 dK1.xJyAz59a45rJu7jsqa8xiJdMwk.7rGy4b0oU3TI0i3CMa4NlWXDIufxImkG1K394qrTaMeKj
 BHZZuohKGD9xLJmpSdaQXYGWBf4OJdWfPB2XA_dayhN.ySp7HkGlA.6NeR89cVQfN8z1bUQzqNuO
 FgYo9dojk5JBpUslPbILztm7kHMVcSb8jlVe6Lj5ZL5SQsmKeipi55dEsyuW6YPUoloSls4UUwMB
 XdFIzPXmnCMgoX8D2FD8bRn1HHKTFZUzwDNU7wICsL9M708lCVLTLToJ3O9.ADVNthqcosJduBTL
 RveS2ezzIEbLdcJGoh.hnrnhOabkvnpLMYeLeKLahUGx85L1H4e5up3ZJSzBJksp_SXlo.MsEMYx
 Kc2n2HK5Rfh.3_CJx32q3TUGmKKsyM8Q8bqd.kpDj6d.xR3Ju.Xc3RXcQ.OKf5qkHIdTDFhQkacP
 lgGnQ2jPyEVLmGlX1w5ZXnfIZtflQyxyXFgL0XmAdP7uHy8MZHTM5n9lxByrmoSRxgU7iuVBFzip
 o0nVSJqumA5u49X7nNYsqDPe91xagpyVpNQ2JgzYqPBJNZyr2g5EMgR95lRidc_JCUiSWleQr_YG
 PchkXmoi1aLIjSqDeiOfxyzA0QcbMo9aX5KKFkUhpAgy0uAzr_a98KhJyFlRoaSL6tXnMZ7J.Ibo
 _wC9eN8bMYjJ5NBdI0XwQCtRxnrIaIIjyGoTmXMwuDLg2AYoTB1kbH5GgfJxGFFjwLFryQxZHhT7
 ZRyGp95KPBaU6uZcCdTJixDE_xPptQgMsjiXbf3TDC6fBX7yFirP6zji.KrHwhvzF3bojdYTktzn
 kf0KRWAR8pVbg2YXZP3QrcJXJLO5oIFsbG_TmQQHfYLNWu6YI0Ogz49WTFBjCIhTvdYuqI65qPNX
 mXzg8_AhuwxFISssTQN3eHfS1feUA6AuIT7NRh1goaLR3jXHRBaK8D4bpbdOot01hDRRvK8saxJN
 HKx1rC7ZdCaCBHm7f8EceNAyw04N.OFDOrW67kJ4V9PBRzSG63Uqz0HyZ8wsXW7wN1v0VEKMoC64
 XJ7v_sdBgwSn.Ab8ZES8Niz3r8V7Dr3s1SJG0A5C7qkhMxN.Ma5F5hgsIHwXe3clDNez97b5SJb8
 NU5lwiqBwyRTB1IiSL3JTvjphoKJNiNxW7A.x3djV2gxJNhy2Ujc4PSKqcj6.LSn9RlMhnBanMt.
 s3H.PYPNgRFMrBqpW3PtAfnGvHSu_mFmPX7NtCn6txeukfiI78kJrejdpz3WSkHtD5qiCoANFRcO
 6mLaNs4sPu7UFitLEb2LxWiKUaBpA.HIL2OwU4E4Yi3cYGGNsQDKaqRTSBmyLHWZHF1LZiivuhtI
 D8CsW_T_QJQJsrOi2cfqGpL6sY3719JCOglZ4t0F1YfUw_5wtZZVhqBABJkRSb9NJFgfF0ncLYPK
 M.y6PFbEkwqONLy7m4zHeOg.S8QRwnHZLYo19.ReFNPY.66G_objjqS0Rjk.ztFQePhwB_euiBs6
 tCAqFo173XDAqV2QbHJS8Mt4eTCZdbMZRCoC29kBCM.1ph.0B8Lgh5cRf3lNOd6l3dOTnYHfudq8
 NpUhqY396yUmq_O4_47Px5xZEuOlGPSwstsAgbuKeKKl4ZD70Vg_Z7C5E1Fa_qe6H8XeeCwjDcjX
 G5SFw4ngbU6Dea2X0ThPwMlXbwRydn9D7QOGXRynlYhQ_3T9ojtAoguJsWD7EZQP0XS7.oVkK8QR
 cVx4Wvm.pFU0hYRBgTklSnMLw29b8Iqc1Zl.wLORaOTGtJN3i.2yM_SklAmRJCTDYOriklUSZ.r9
 NI1x5G2tKDrxZMdIlgFnW1nCDWAYnyTfFFi9mAOXLObWVq1eEODXwRT21V0CVHAr9GHk5FaGKTZY
 YeaLX9pzg0RPPypTsRjEDnQCxJtvJegWTLPaY7iT3aBBCKyQRK6SRW5QnSoVq8OD3LRS6IARJwfX
 95MIgLD.KUAEmr99qDajNFVsWzX1hvOhYbwA1yjFoIav8GJsoE6t7Gl_6Hcufme4yPlCfED_oUcj
 jpRgphFyq7PzDftke9PPLGH8wVuhip5hq_cBZY2XVFw2HiLrr2hBk5GlAhUcmOHMOiTCWoi0FUd4
 Ikl4OCa_r.wsJImtUruPD4CXFesO1JH1EazZzNP0fGPQ-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 8f1d50e1-26f3-422f-8462-b75dd615e144
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sat, 30 May 2026 11:40:32 +0000
Received: by hermes--production-ir2-89844b765-6g7zf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cd90452154153824b45b33acc3f9a747;
          Sat, 30 May 2026 11:19:48 +0000 (UTC)
Message-ID: <777f3f36-f551-42cd-a5b8-4964b26584b6@yahoo.com>
Date: Sat, 30 May 2026 13:19:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
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
References: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com>
 <20260530-realtek_forward-v10-2-d14b51e6a69d@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260530-realtek_forward-v10-2-d14b51e6a69d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293344-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 98FCC60C93B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/30/2026 12:51 PM, Luiz Angelo Daros de Luca wrote:
> Explicitly enforce the presence of a CPU port (-EINVAL) and reject DSA
> cascade links (-EOPNOTSUPP) during setup to prevent silent failures.
> 
> These topologies were already non-functional. Without a CPU port, the
> driver does not activate CPU tagging. Additionally, the switch hardware
> was not designed to be cascaded, and DSA links never worked because
> CPU tagging is not enabled for them.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

