Return-Path: <netdev+bounces-301151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tMPgK/FWOWpXqwcAu9opvQ
	(envelope-from <netdev+bounces-301151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:38:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BE06B0CD3
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:38:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=aP273yfU;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Jki8TXYG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301151-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301151-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68E7A300A509
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0F738331D;
	Mon, 22 Jun 2026 15:38:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458473B7B8E
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:38:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142699; cv=pass; b=UMUhp9rGKvJZUkeLB70iV9AgARIKK4pLACLW6vq033i/9de195dzkytMjlSi8vWZJnAy61U/uqo1oNqPkrekePLwgEKFN/mMy2AdLdJF2pqGiqBooFabctRXqUjBbIzI+AHjT+6HyabGUPO6KPN925brXHj0ohC19qfUpmFSjTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142699; c=relaxed/simple;
	bh=hsLLWXDPYnII7EGfTlxit4Rg/kAtzSQMN5XKHVCFFWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oq4USuymUtYlf6sy19WYADU6yngrwKztxpLqp2NU0xkpVniZwGEz0bCmc2miM4xQ8ufV4sAznb8BJTrJS9xuo+w59oXj/DU3yFW7QWgsYMCfxsjASjrmULktNqFf7PnnhRaTE72/uBXetbf9HdHauhc1ojSuWkaLrzFDNQETS2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aP273yfU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jki8TXYG; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFXVBq1647501
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R7jZDkKbepLuvBAxJzyiRImSFmJRJwj4PLgZC+NfnDM=; b=aP273yfU2S3Flrhi
	BZiiYHILPxXKY8/vnBiAKAK+cXRXFMQhgmM46XBK/rdiaRsy10aAX3iVjG9nUqbX
	aG4gB7DV5pjv0LkugjJlKOokccXdqFmCoTWSGS7/kKPMDY2/cQrvYhnCcchyY/bQ
	7tJHrIhTTDt0AjTeKZ2lWRmfo4Zmk2/Wa7cJKfxQWCAcARI6mxO5DGRLBUJxHPqD
	PvFM/TnCvAZPW3cXSffJJQvVzhmdd3r6bQJ3i6hhAZUWFPd6TXOEDoRLEjp/mmud
	kjOTk7fu6glrmEJFMiRUQGnm9TGdCaDTC/oA4Y3gcK4IqL7UWTEaaFjcsJMMPWxm
	mJ1jrg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37h94cd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:38:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9158f2c4b55so737583585a.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 08:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782142697; cv=none;
        d=google.com; s=arc-20240605;
        b=gT0upBB1NdcEv9CUzzMewAaIuC/ssZUKnUM6P9PBCeRDsrYQWdH5Br7meY1vWJO2fi
         mF9aC4+gLPjtziX8rBIKYHOQ2zzJOE1h4x4CfsbDFOPu1K+ztSz1wE0+sQenQb671kaJ
         eEF6bvJbgNT8jEuCzmu3jzEkIE5NfUcIdxhc8DVUMkSiPrVqAhFr+g0UjqLD8af/CnUo
         eDUAthBd8WBazj67+T3lF88DK3YTej6EW8SkEYgL6JNsQ9gPQxjFn5vAzgS1laZ/yC/3
         R3wHqHZme9V32PR6S87lT0kPiv8LPZfrXTXFWFdBrFgk334IQ04IcbuDfZRvWEz0jlQe
         Lsfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R7jZDkKbepLuvBAxJzyiRImSFmJRJwj4PLgZC+NfnDM=;
        fh=0eGoDZo0lU4aDCMoHzozKfLhHMuDOjzMDsTCkBSd2lA=;
        b=DqRXbQHrjK62CCzGpHQwt6wj7I4STYXglSzJGU6xNsz9+t0YPL1XQsI9FxrBfIkssV
         1ZdJ7vplE511RbOcmEwEQtw65ufyfk8LbHmA34pYM7MzSp6JdR5wRNNl9oWiRuxzboAT
         fwb1KuJBamlWDEV4iUgMcBxNccB0CdBo5cj3OnjE6T6UC0T4iG3VReORHjgJngnX36yR
         qe6xMqOAd2nlSO9yRJQmWNlmxj/BMzqpaFqGedSMFME/Tebjg2z8DuGFNqz0XbCWP+Ft
         O3P+2973xmVsF1J1xIKwNyOof7YXDw1OLix41/NrDLO8R5H4qeZNggY8cdC9bqRLSZDG
         WjCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782142697; x=1782747497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7jZDkKbepLuvBAxJzyiRImSFmJRJwj4PLgZC+NfnDM=;
        b=Jki8TXYGTx1VVEODW/E6eZP6RrUij0Ue9C1UyVkPLMH8awlTnNdp2M+SkSVfzBX7oK
         +BivjnONeIaktX5LTUyq89jh18AFIUlqd8xW9Re/dlud6LZ9uDZ6d1rYMs48LIFBMRrm
         SF5wJoKzNzviVjnxEwwVTfgQEoeJgxAiAhlr4KwOqwun8Nlu5cpPN4yzPWEo/Ss6Hku4
         TxyC9BfL5/uqwqYnXkO2rWa8TXkwmCHO1/CzUHVIfbFU5c9uCrjTEI812DvArSL6piCi
         AvDAg87d7CENDFtAGXwrYS6k2oM39TvQrGud4sf0Cgvods9DxZKd/rK79ZhN7r2vkPy9
         M8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142697; x=1782747497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7jZDkKbepLuvBAxJzyiRImSFmJRJwj4PLgZC+NfnDM=;
        b=iOfjmrkftGOfI23ZrT/MgG7QRCazhB5ZdEGIZ8tOKP7KTu/oAuibcknO+TgEK+KEi6
         sL37fglA5AjmhrcssZ6YwxUeDZ2z7cY4rHj79AZTdoHt9XIuNIu9i9joSf+7apFSvh9z
         aTUmInv004O15/jQuKqOBAP7co+SKKgL2XUXQEaj8y2W91qmf5yflCtiYY4vFX2kY7lQ
         bcU/Bk7tydXj1jnl8NS9FPkCX941ncKHF0g0GlwgzV+F1wpBTff3p442iNIYQwP7gWe6
         x0JSbIbwBOV6PW6Fns7WpevBNApxK4daS25766/5oiYXPqkmn5cmKadNq/yWJxPTPiQw
         A/og==
X-Forwarded-Encrypted: i=1; AFNElJ/3PDowsahhv8nEGw8TW2xYpajdRXq6jqWr1YoNsqeH0aFnRfwNqZ8uriKV8PL1iGJNA1k1do0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxUuvCL/ZMKt0XI57zFd7rVtMrRFUzuiqno59XYWxsWC8x/32p
	C78fOhMrfmiKLuCV9InGYpAhQNs3Ygca7gWCHseoP2M95/Pw9stxTAlhoSo75haAUiP0swcAteg
	CWwjEiY31cJhE88Zu4741V7plk8wPLQysi0BxVkLX3t8kSoIx6XXT1o0ctS0vzXpV2z1RvCDTFU
	KEeSALY9U8h1xMq1wa4Uecq/vhQyGQhdcnCQ==
X-Gm-Gg: AfdE7cmAiEpd8HJ6mRN5W64dXiq8vDUkgF/wPICx3u+8BChd4/BCEpabGfQ/mFE1z1F
	RNWh3qB7GKZTo+COz+ozSLROUFpUDaGi6sQvy8GbDh2A/QszeOmOtL7IajwdaAxxbI1+4J2MoX6
	ERHmoAgaPg6RDIKK6IpKMd2nSo9tbqiSRVMEW2r0hCZx30oOFvqjpPMzIAcyhx14mIv0XqkRSaI
	jnt8MVs9iLLRzhaV7CGnIwa3Ydbnnz6vf2POKxuf0O1DSPZEJCUTlpQUom7hoWPTBgHH1G/HUbZ
	iJX1k5pofA==
X-Received: by 2002:a05:620a:46a3:b0:8cf:f1d9:ba20 with SMTP id af79cd13be357-921d0b35b15mr1561317485a.8.1782142696606;
        Mon, 22 Jun 2026 08:38:16 -0700 (PDT)
X-Received: by 2002:a05:620a:46a3:b0:8cf:f1d9:ba20 with SMTP id
 af79cd13be357-921d0b35b15mr1561311885a.8.1782142696144; Mon, 22 Jun 2026
 08:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621031714.3605022-1-haoxiang_li2024@163.com>
In-Reply-To: <20260621031714.3605022-1-haoxiang_li2024@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 17:38:05 +0200
X-Gm-Features: AVVi8CdKM5BtyFUhGptDdvhmqBVs3rFZUOjukCIu32xzQ0rj1ie-ccUzXGrjH6w
Message-ID: <CAFEp6-1FJNOxoFUTjXWPPBQ-PC2UJst3Zz3LnnopRCg923PZSQ@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: t7xx: destroy DMA pool on CLDMA late init failure
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
        ricardo.martinez@linux.intel.com, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ilpo.jarvinen@linux.intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 2gfPlpprc023GEtskfHI7A-oON2etWvl
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a3956e9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QCaUasooE-QjBHq4A6EA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NCBTYWx0ZWRfX/7epnrhnfGxc
 wJi+7tu4nIkbQtUDtqA5GR4BSXb6jR9k/IWoPsTZa4OuY+c+mPIU/BGkQw8crzQmAeI2fcZo1ow
 6AR5jlflqN0QAxiWM5kxrfB+GJ05ipg=
X-Proofpoint-GUID: 2gfPlpprc023GEtskfHI7A-oON2etWvl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NCBTYWx0ZWRfXxc8nmpltpBz6
 Fa5vnMvq4tn8Ol5pmwhQYas2yinXeWO8pgyBk4CD1yls83K9GmAORCznfSsxP1nvco/Dk3V8KIu
 vSwrSVfsU3gqD2eYpnEmWnAJCbloIDCJjQ6jca6MFBCMOj92YBWrsBqwMIT1e7x48arrIJrl317
 t4DKrLPi2Up9oze4YKu9fop99FdEIATsL/Gl9JC9YJP5vq3rBo7UhcsYxndKcjLKvwA0EyQPGg3
 wIKzAwIe0k0uOtZNZYO2czIWrsu4m3hDZT64SDhkRK3vlqLsfakWO+rMNdu6ULJCw6rR6XJRpMH
 mEzjPV5G5v1lvTtfE4MZo17cvjpWUMoW/zhq1bk9RF+WaAPRj7Yi7QtSE7WffES6S4sOUcZHKch
 rgQMzT9pHOopPYZSUaJFhfrEIRsV0I47aas/HIBbfkBVqJGlc0PE6hReazbbEyxikInI+rpYkz8
 D7DOKe5a+aw+V3hIiUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220154
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:chandrashekar.devegowda@intel.com,m:haijun.liu@mediatek.com,m:ricardo.martinez@linux.intel.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ilpo.jarvinen@linux.intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,mediatek.com,linux.intel.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20BE06B0CD3

On Sun, Jun 21, 2026 at 5:18=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.co=
m> wrote:
>
> t7xx_cldma_late_init() creates md_ctrl->gpd_dmapool before
> initializing the TX and RX rings. If any ring initialization
> fails, the error path frees the already initialized rings but
> leaves the DMA pool allocated.
>
> Destroy md_ctrl->gpd_dmapool on the late-init failure path
> to avoid leaking the DMA pool.
>
> Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/t7xx/t7xx_hif_cldma.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7=
xx/t7xx_hif_cldma.c
> index e10cb4f9104e..2917cee9b802 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> @@ -1063,6 +1063,9 @@ static int t7xx_cldma_late_init(struct cldma_ctrl *=
md_ctrl)
>         while (i--)
>                 t7xx_cldma_ring_free(md_ctrl, &md_ctrl->tx_ring[i], DMA_T=
O_DEVICE);
>
> +       dma_pool_destroy(md_ctrl->gpd_dmapool);
> +       md_ctrl->gpd_dmapool =3D NULL;
> +
>         return ret;
>  }
>
> --
> 2.25.1
>

