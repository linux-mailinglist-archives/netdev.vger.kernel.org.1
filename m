Return-Path: <netdev+bounces-246741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDBCCF0E5C
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 13:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30BBE300795C
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F3B2877CD;
	Sun,  4 Jan 2026 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JkUv73OV"
X-Original-To: netdev@vger.kernel.org
Received: from sonic314-20.consmr.mail.ne1.yahoo.com (sonic314-20.consmr.mail.ne1.yahoo.com [66.163.189.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA845C0B
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767528999; cv=none; b=qjGfaOJmLBu5Da9Xm/rSxeRy0gAz7YJdEdD1Uj7i/KjMcXYRaCaX8OSku0ja7/KSlF0TPoEGrniCn1tZmD6/PiJJltZm9tmCFLYbyksIReQAb92G7le7LeXS7wESlpRCX0fusmaKeVJHZ4srM6uxi6vmuIvlfWxoM07zR7pEiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767528999; c=relaxed/simple;
	bh=3D6yB/tkNqBcd2BIOiIWtHj3FCr7e0QhLcZECDY6Jyg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TR59UTuqOmndsUxYNt64AyUF1NkmpB7W/SNSJ/F6VixinzZxuJs8oCQSZuIVBaMwGCZ2SR2hjTxkeaD50nvJcWonjNc/hnBc3s6LM3vQem89V1ttUDYXvCy7qpNapHWupsrdL3MnkrnmR0rKArV1jDt6iXjplnzLpJQ85nkSIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JkUv73OV; arc=none smtp.client-ip=66.163.189.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767528997; bh=3D6yB/tkNqBcd2BIOiIWtHj3FCr7e0QhLcZECDY6Jyg=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=JkUv73OVe4jVzJyFVulkm2l32wNlLjoFAiETUslPKmHuSn3HS+HiKrXipNmBKjmepCHK1IAUYLqejqEc8oirOa87uk+pmKlPDOg/qSx/phYzeYdgtl+HIoH2ZE7nOrSSwLPad6L4IHH62lmUjxgpb6UQrXo+Bl6mpYcYHmCzpi938e5e+rExW79bYKCq1wagsnOPwe6Yb6Bji3NSdTSRyQ5wkwjlNt5iK9YYk0P4QDr0VMayzzGxFFnHqU7R093orINKcxvG5+rC1CrOiFuSk5r0NyunJD5obAeTIaoAUj2l2LWLWEgwbMRGtcbCKcWoAEQeFVIRpH+vmaCKwc6xMg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767528997; bh=u1Kph8D2nasqXX2J0Jkl7k7BpN6n5HdpWCG0FyU8gEF=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=TJ2Hp7ghRTLOVozQZq8vAMbQWNGiIv/32TQId7JcXLjK4THPgaeF3pZCu7fMEJQQpH1jlVGakcLzFIXcXEjV/awHfFoL9aoJi4HnnwegRZ773hsezL8Sx/i1KRd9XxOYmPJUOVzeC7x1GT8NXblZEUZFmhxFuMbnGDaSajhDajwGCxy5TBwsOR/EZzM0FvsUQFQuyZx/2dgiVrXi2pk4ojIE8rihThmfeKhbFKeUg0uDoVZEa66LUPAx1JFH90H2ZKjTaeH0IbRe9053tTBMirqvP1Uoyd75IrZZ0bYNzNqsZxoHl4A/n49FFiDn7PDwX9q1PQmHcjpyEd4CKx+6Pw==
X-YMail-OSG: vqLiSbwVM1nTK3tC_z3B3bHG2vqT8SrjJMAxO8a6BTTG8WtQxxf3cVNLq60Tj7O
 v_OabmAESA7RZwamxLpUm_iwY0cyFnqPJFVJlClSreMBZL7zUCURguGQjNwIq6vsDeta_GsyiFYS
 BI1XOH83lCMm0ZjPh2mkrfWoxhCRWpfSkHhqxI.CDcQ4BRIfvHAbqpNu6xckkEq7.QgmfAAU.lBm
 vYkA7Z1p4s7Um9WL78yXOhy1LHDYycjc1Eh2ttMoGkv02HbB1pZSHtasIkijcfAwvoqMif4aFdTH
 y0kDjDS0Be2abvx06UbzXg6Q9q4F4iLlPf.O3MtIeRS4cAUifAsKYu4ddn38JguwJ4C.RpWUKGH1
 miLH3HipKHDGckWvHt6buey016f0iyNq7rx78mtOmNgedib2wxh5EM3bRjppwRFuPiSUQkk.xcX8
 79WT5HRsNMjTE3dHfrv_w97FHWcPIUtWNx2s6ZCS1cipS69f7N7CfE3Nr1LipVHHSSxToIsyIcMV
 _1cJRP7IxnodeSjvqU3ALpWPxRCpZT.0sfa42omEx33ERYdITO3Zdfb20mrkmFBRfEEEaLhGTAPC
 gJdSs2s7ugok_RU57dikr7rRE4PcK4VojzsqqVyMOPDTRVnpXMxSvwkhx4gFrY0Gc61DSv1tJrWS
 CfmFhlIJmEgh84iM_pvseKJjqVMnXyLZpgM6yGtLwwDStqypl4Yv3bWy5vytAny1MMVHc3.I5Xs0
 IVXMw7NDF2PIAJ9qEbPHxgDkrryfXw3kY4naeN1F0POgxmFOHFKTBpBlOVLK935gD9T_Io74z4OJ
 JshloRnlaT2hLdMm8I4OZ4ZZOHr8CjCeUUvtMydKkK84HpY4GcdQKVHYqrGlyLuMiEzMLhk3B0qS
 2BWPPU0D4GttTLvg2cOTUYND5Nk9SDvcmPu7ialVAh1pye6ikDC552q1Cx4CNE_9FQcGzr55nios
 bwCVvudv.Z.DvggDxnnM8Krbot12QoUxr6Wnk2iNzAAV4feIKMSTYhZELQq3N8SIsrk24N_xelCF
 XKjkvfgduWkj66yUzlRcbySuxmpWYBJkPv1nlYORtpv3JhVrwJ_oekNkII7U8kXfsdMXZm3ES6ok
 _CIpRPk9Kc5Tmgher.U24j.ZL0yLbGe4WXjRoUnl.TGXgIO54x.3LHIF0CPTdDN8k_npKsqF40m6
 KmVk62JiQpuynS8mxKX_zyxGvRV0xvalxtqVZX1WmXxLDm4xKo6lTNIDbNTsbqAkMgW_N7t2MBb5
 uD80AQz1fE5Qil6E.G6c1TxWZWX5VSDx2Feql1VwIsByHOeVvo.r2Ql_a3vp5_2GL9LvJjzgb4Hn
 z3QSF_eJEnWN277CVGDiGqXkar.ouxYwxrJ5pU3UcQ9FQUTtsDCJyco5roashlHligqwjahEomej
 qJh1mqJH1MGv4cXCpDh7OYbwWyoA1veVbtD1EXzXNPKorqWDWb8KJpIagDb2s.pxh2oTrSbaeCql
 hK_wqT7yA03yDXlD6YrLJ6SebtsVLZdq1HX.ae93UWyO9.u0ud7WBGQTW.UA9k8S_aLbPjanojyI
 4fIDYC2KB2fofFw.RBbVplfru4GqIPEEZ7gvr4qLLFxM9703XO1iT4WnhQR5ljx2b0EIRDcMMFiM
 kLrhXHPB5voedZh.34.7k2kUHkwjW9_8QZm3uQayz9Gg6Ue4VL4xXej3BbpO30VWg3CEbkePwTzJ
 ShRQYkehGzz3Hhfq2wC6mI3I4XYmwRO1ls1cvKoJ9QyPdy04ebUZoaW1d_SlpsOjcRuL3uaC_ZPp
 R63svRsNFMdVoyU85nSYFOY9H_5pu4FV7wPWC9gxOEE9BD2Ag4giFaecQKcSVGezwXJNxUnd9VmW
 cvj5QDDJK5txpfXW6QzjKfD1EEr.2GuPuZBpjAp9BpmC1vdb2TAxRs4Ca28rsKC3ExHzm6kjkC8s
 2sOv51Rw5KS7aail9726rI3IwiO3PEht00utXFc1x8Dq9__Qd1CeyTZa72ckzeorSjRGOvXYU0v7
 0egw8Kz7H61n2Mbzf5Y11fG8OQZHUJmVsl_CZaZ.4Z3fDjU8X3ZxOlKgRH6apEJP1PeqVh5g7PVk
 h0Ydx4Ntc.P7Hcc3Rqe6y7oXFcw0MYyTOwkbecndqWNag5ADM7JmuK4OPZpC5th_CWusXILlkbsC
 yrEMQ7.Y1upTOSpFE3LtgI9qzc2sxCm5U6DfQXeBR0.aStlqxCbOqNDiOu0DY6javSrRBDTSHUj8
 3vap2tM9x4iFEO54ljFwqvcEPJmaYgpLA6UbMVJD0B8PIfORbymtL02fravpOqEvwDKrLeNgc_2j
 FFfqSih_pCHKcYBF5XlEG6iDGba1opo4Tq3E2Zg--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 0bd8863e-00df-45b3-9e56-4b178a26e161
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sun, 4 Jan 2026 12:16:37 +0000
Received: by hermes--production-ir2-7679c5bc-fgcdr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 637d18e6f1fcaf9cb173793a3d3d31e8;
          Sun, 04 Jan 2026 11:25:59 +0000 (UTC)
Message-ID: <97f5fb4a-f71b-4737-b637-321d41b067b6@yahoo.com>
Date: Sun, 4 Jan 2026 12:25:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: fix return value in
 rtl8365mb_phy_ocp_write
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 "olteanv@gmail.com" <olteanv@gmail.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
 <2114795695.8721689.1763312184906@mail.yahoo.com>
 <234545199.8734622.1763313511799@mail.yahoo.com>
Content-Language: pl
In-Reply-To: <234545199.8734622.1763313511799@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

What else can I do to add this patch?


