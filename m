Return-Path: <netdev+bounces-286707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBYCOI30AWoFmwEAu9opvQ
	(envelope-from <netdev+bounces-286707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:23:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0B51116D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC1003036E3E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63B34D90D;
	Mon, 11 May 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XSRk4jRo"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-21.consmr.mail.ne1.yahoo.com (sonic306-21.consmr.mail.ne1.yahoo.com [66.163.189.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69230B50D
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512271; cv=none; b=r4hpOLw96WqZb8Om3+PBP07Ib4qdygG2kCb1jlnoJRAgBktavQAV+qAiN2kLhM53uA9jmtbJpX5ELrrtrIHM5eAo1UbVbT/Z6Nmx7m08HodwFZYHylXZaqb2BQ29Rp4ewW1nfDzkAv8jtQ2bvqX6c/azEDBaNfJonJ5KC/oRka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512271; c=relaxed/simple;
	bh=UTpLUWY0PLHVyggN74BH3lvH1mcBQEdwDe35SUee7oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2yLWuAjnVXwAcf06U7AhcozKUkXxPm9bBwVaNv2CgCW91tw/5AKXJK6V9VZVpVsn1MAz5OGh00p7B+FQoI30nM0HDook5LqPz1ZOIUL8UwrSFpczF3gjeJ898ezt/XFSAK2tIlM/tF3evEUcPxYSD2TbEj8guTUX140U+VAHcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XSRk4jRo; arc=none smtp.client-ip=66.163.189.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778512268; bh=GwV/Pp981p3PZ2NEIrad3TZrrjEUsmOviWa7paVVMdA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XSRk4jRoTvcvxnLK9FDTi+2am4YLEiL1guGAFk7ZZvcjp1WNxDo7S1Cq1sjBNHSqdsnrNgVGc+2a6VaGS2T1tJR84x1/T2z8kdIxrQ8t4dnv/cuZvYjhag8T8K3fveQ5N82Urtjw40luERnGCdI6Xx4+mkM0BfqenWLGeAUcTei4T93b9fBi+sUOxyQq0O2AgsrizwY8FsmDlmbSgSHjgfyMWmS+e4CEQ9Rv9ShC4+ITkldaAjWV0haWWmO84tMkC59DlksZxO6eFgBYRU1iE82U4oQ2orIzr3QUfbr+HEi6Y87DJeBPi+R2B1myzo5wUvwtj9K2h/tnf73140Nqgw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778512268; bh=NcSuvGU1iea043sjs5l6SsSjgW69Ajb16EOVwTFPCfT=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IsLdbU/5IIAZtk6X7PkTstPzn30in63n4CxiHZtmjM9jLpP8PR9zs6KIXpzLRJ2OXGNo+JMEBSg5EZ4bpuEw9cSaAd2CukjL8fRvsCxvuBsUeqdfn+4pJ3Qvi1YyswELo5IztlNSLE7VkbBac13T92LsFFal/ByASP+/GYsDM6Y2ACiRwSAY5f0DeRdJ0bvQuSPjrsyrpBQz1odlcjKX1qpiizolI8e2piAOS8RpnNz8qgmWC4Mzwduqf/xYi1P8EodjAIJzHyJsEQpN71pJ1Tady3g8Pnux6e3d6i1GHiLvmrvsTXFT3m1sdn4L6S/AYqFnDT1JEgQhggcf3Ow8uw==
X-YMail-OSG: XIpPMAcVM1l3jVYf9PNBpA1VzjJEj7C4ojG2jdvHh6fLH.YJMw9GsdJx8Y.vdXB
 0XEOoSMvX_vrbiS506MwjF4DijsupBZ.djp.gowcfJep2Okj9jOeMULR1y2Z.YkB.W9SgFDHx5Pt
 uxbT8bcZ81vDrIE47_0ITytho7d_QbG88wUyiW.r5UBxXskvazpS1uFaTqL7KycJatkPS3ievwmz
 In3EQc27ZRj2wxWSX15Bi.tJZxPHWaTRI9lwyh0rcqVY5PNqonDy08dXKT8ARNw9SJDNeBx0vt4z
 esFRoAKNAWw9JPe2Z3ek7GjYImpZVBxLUFq.E9hL7JYB3gEhjbKTbQmbG4wtSpP4hsQgY1xL9u8p
 WodZarDLo._CAPwFmC9Aa.QldywUD1JOwGJ9fUW9rNeQuyhD_YAZc9f_fIFV4vE_SMwjCiCbrPv0
 Z6.GWJbkqbL1TZhxdW17zUOMz.s3JZhA44DGFkDTHdETJSKBn7eSw7EGTVk0WQ8H6fLHmdExIIWq
 kYYPZDx5kWX3KGeqwb1c5Ghoscoog0vyJ8tzh.pxm2iw7.R7YGbnGqi4VrOe.64tT6rQpRsAXiIj
 Xm7d38qnbA.K930LjemquGQUJJDJ4oMZyJnBgwgzZ6GlKso2bV4Ejmc1BXDLaULFCxWGR5v88z8s
 W_AA5UlKrN7_rx1jfPFuQWblvBL_0nz54XEQSUiTI1aJ3_hL7RUIwML.PfqTtUuVMfiGb9czTl08
 DardHCGO7vSEZ4oF7aAXseovV5R1l5fEnjkwbV6yNjap5TCH9Qx2qsx0m79oAC_fBlEYnweralk3
 Lcx4UF6Lh6k_nQrF4quuIigK6.5__8klkTK45Omh8rH24RTpATI_e500qiLFKQETw6dicEJqGtUc
 HToCa_7Or.kB0exHiSKC9QjornPY_AgnipsVufXsQHxc.xrHktUdHMPR3v8RaUhXIg7WMQkImFBK
 sJ7jTkov0yMf.rVM8ctfgrCQYoeR0UCSycvVlIr0Sq4GlJn8WgY.bo4kdx3D1cKpRcj5hhRUes8C
 qbdwvkfc4LqB4CLBx6UqI4VGG2nE5KaXeQjppzxTPP6_foJjv95j1cniW0QEkIblQ5afZZR7Qahx
 0cFsYF9l_AouQeDWxQFLlMwppBY3yIBaJGW.lzH.sLxtak5_7tJBlzyOZ48uzKGO4pPbTm7X9XWg
 58aYGMQs6fRxkIWbCrcVwZOQKxA_TZZ3CsraST6tGsP_zJ.lfET.EprCdoH8_Hw2KP35TmTnLT7s
 pxDeUEmdv_gEFgFFPkrMpmIQpHzHysGjj59pP5qpDta3jXlqLcIb1ZcQofRwhch.uauzVp0Y8inW
 OKTlEgty9.Ie0FrU60lz6LW6KSYFgrke4Mv.Aa2Owdo8H76nxgINNWbOwwIgegph1azhPTnSZFf3
 k_pssPaxaRWS_mdW_EJQVr5z3GlHmPQ1DuGKQvqvaOwWfXD.jP6AXRG9B_a1whto704ZP4pBtDXG
 KZfwKEPeeX57laoLIckbp6XGa0d2UbFuFl7cKbtOSVKhwipmENSi.kYGcMH7Do5a9dW.nJUhoUcU
 mvokYwOcVCltBPqSmN_qLzsrH8xp4Tk2zvEfNdCDhsIiAhqaqctevS24RjZV9ULZGZAT_2TLD4wW
 hnATWR_x5fwMVsMDu8dkDcKGldMrRLVVslnyeBDI10iNzgqt6l15HlNWDDFl7ZUkHkX6sKEOYalN
 A3.A6xpN2Blh6dcb29E.Vpdg3YsNRUgx4cVoAYitIvpRL74Ev25GM5dIZfvwq_QULzki4w2xZF8b
 9eFuPRXz8.ma0rHicCD0H_iqBTzT3hBT4Z4XCINMtlb_F8pTOPAAX5EnThTFmB10yOU8rdjB.x3A
 TBQU3FVXxsTRr3ruVGyyphtKOtsEH1ris0HPS_KvwifsV7.5NDUi7jpsQXKbPYYPwFAJtROmGsme
 9AhI_bO7718BBvd9Mk02U52D8RNmaVOs6r9JsN.dqGba1tXhDNnPTB7gQl2gLa0AunZWsiLSVD_1
 pJjmHekk1HaPAtDI1rMtUrcE0JuWhMHqb6iEvYg0o6bQsoeWJUswCwovvWFUvRjMd7QSXgi3vNEi
 DVYzZE.7rMnu7XtLFbyhr00oEWxXymhFhCMiQmtufXT2_zR9xjERNlVlaasoPZIS3Sa3dJ6KDNlb
 mQoZcYtdSa2hD1q__HhfiQaxo_zzQ.k0cmH6M7XssTtWx0PEB4v0ER2HfXsqsNMv0oGusxxXNSix
 KczH4VFNtvM0UpWGtH_7QQMQKoIKcqUto2zydrI9bJxtkY.LmlqoCTDpf46vgfLdV68UFW2mTtjC
 n1o4s1OBh6tSjCgtlDEQ_oTFrNwKUkZKEhE4DBxm15D6cZAH3zw--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 129feaf2-177d-4616-909f-380f16e48d43
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 11 May 2026 15:11:08 +0000
Received: by hermes--production-ir2-89844b765-8tm6q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2caded2bb5d43f9c57b866e116ac8033;
          Mon, 11 May 2026 15:00:51 +0000 (UTC)
Message-ID: <0cbce7f4-e7e5-4a03-bde8-4a62556c3b12@yahoo.com>
Date: Mon, 11 May 2026 17:00:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 7/8] net: dsa: realtek: rtl8365mb: add FDB
 support
To: luizluca@gmail.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, linusw@kernel.org,
 alsi@bang-olufsen.dk, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <20260506-realtek_forward-v3-7-1d87c5f85a3b@gmail.com>
 <20260510173516.3920093-1-kuba@kernel.org>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260510173516.3920093-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 9DB0B51116D
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
	TAGGED_FROM(0.00)[bounces-286707-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/10/2026 7:35 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: realtek: rtl8365mb: add FDB support
> 
> Implement support for FDB and MDB management for the RTL8365MB series
> switches. Introduce a mutex lock (l2_lock) to protect concurrent L2 table
> updates. Add support for forwarding database operations, including unicast
> and multicast entry handling as well as fast aging support.
> 
>> diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
>> --- /dev/null
>> +++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c
> 
> [ ... ]
> 
>> +static void rtl8365mb_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc)
>> +{
> 
> [ ... ]
> 
>> +	uc->key.efid = FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MASK, data[4]);
>> +	uc->key.vid = FIELD_GET(RTL8365MB_L2_UC_D3_VID_MASK, data[3]);
>> +	uc->key.ivl = FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MASK, data[3]);
>> +	uc->key.fid = FIELD_GET(RTL8365MB_L2_UC_D4_FID_MASK, data[4]);
> 
> Because vid and fid share the same union memory in struct rtl8365mb_l2_uc_key,
> does setting fid immediately after vid overwrite the 12-bit vid value with
> the 4-bit fid value?

Change code to:

uc->key.efid = FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MASK, data[4]);
uc->key.ivl  = FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MASK, data[3]);

if (uc->key.ivl)
	uc->key.vid = FIELD_GET(RTL8365MB_L2_UC_D3_VID_MASK, data[3]);
else
	uc->key.fid = FIELD_GET(RTL8365MB_L2_UC_D4_FID_MASK, data[4]);


