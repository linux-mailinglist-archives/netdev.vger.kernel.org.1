Return-Path: <netdev+bounces-296420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +Zv4IhZ/JmrvXQIAu9opvQ
	(envelope-from <netdev+bounces-296420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:36:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D816541EF
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:36:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ep0Gdwqn;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=asSosIyv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296420-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296420-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7D5F3027334
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6BA3AFD16;
	Mon,  8 Jun 2026 08:33:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204523C503
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:33:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907635; cv=pass; b=a68Hc4STUleto+JMqvZYPoU0ZQtp9u+yoeYETkVK9yojDoRQJAHLWZGqu3AaYHFOll3mlcaHP+LSIQe7Nn+pz5AONTyGIdZQzdXEVeG0mdNHx6nbJLdtGzLTTFPfe+mBSlDvKP/Futn4Ba2L5kBFYspVHzF+VZifRJh+MwQ0WeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907635; c=relaxed/simple;
	bh=0nqiI2Oz72uZYe6JVkcY4ic3RbUdI4EVsLX8KyD7tys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2+y8GA30wnSP/Yrhzc0vba7kYuSNqUnSgVADe1Yt6EaZ/KUjVHm+SxT35qtzBQdp7EHLwSEYDbDyzelzefP+rqGXXnenwldhtocxkb1yh/Ke5gd9CCs9cuBrLv0/0qF5MzeMbCrljrWdAkdBYAQh9VRNM5U1BCgL0dr9pD60bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ep0Gdwqn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=asSosIyv; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PTPu2808213
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 08:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IBRH/L0+ykNXBtnHZ57xnJnQx1o5G/ly+oNHE8zUpZs=; b=ep0Gdwqnbabxu8K6
	vqLpXcuMXTQsfH9/Sm2fdeCHBdBaTN4s7RU12o9n39I0g2fbmvRbTy5xD1YXkQNF
	lKbsHb+7kKTBjpRr3pYVlMx/4PT0fJoTeon78XNOrHQSse9ibHz8k9QByq0gzGPm
	bP7gbhtPXoQxoaf3e1g2CItSUNa6LLRiRBXV6xdX14ffl0CxsucYQX9163SE1uoQ
	NkLSxDjyRbWGnqyEdB+q/Vf7MT8JggAJDj7KS+64P6HQImb+z1DMBSk5Sb5jKZNq
	ImS8lV20Ldwz7zjWB1zXaShBAm+/nyDIiazudxq5oiCOLxHCt1wkJbbW3ntRE0eX
	lUG+iQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w6vae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:33:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-91579011fd1so595744385a.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 01:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780907631; cv=none;
        d=google.com; s=arc-20240605;
        b=YHDbqIWsDmF3XMBs+9ZA0H3nNEOhxCe70kuFSDssTDQ3w2jZmCmZh3LnxdSrbfm0m2
         xvfk+Ums3VbvQqX2dq+fQl8/xZ0FDnLuP3XDJkgXw2CUaIey7cttQOB+RMjCkurZxY+m
         8L143hh195lKm7WXujrSBTvKPOK/cDnj5RfV74r1BTdQs0IukTgrbhiJ9YRDEf8oUia1
         gyV9PNRQGfUyVDgrqHFyWBSbZutReSWklb+iYIq4pDIXXI3cbjpgsyWL+ikpBVEz7NhH
         Jn06+4m7THvUQpOJ7aoN9DjHLj3xO07aqg2woVzCvYdYFvlSul6Cfh9GeXl/SIAd/Qb3
         3t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IBRH/L0+ykNXBtnHZ57xnJnQx1o5G/ly+oNHE8zUpZs=;
        fh=+U+wOP7WiTv8Ptfzga7iPb2mwP6CPiD0vkjCPr9fUL0=;
        b=gmcNqfSS8znm1k3QQhBtknX7AwtwIOPxAfZiy5fXSbM2zrrzh/qaI9dIfkPtuZtflR
         zDieMb5C6PgpLbirzJBhmv1idgZgz2UWv0/WTRQEKjold6B45w9A0zOYckewhJEPCKTq
         iH42uQzQMVJoKRom9kbzp15F3q27pzf7+0lCTN9wLHrYLGz7twKDariVuYkQcfPWZuLB
         9cZu19lUYthzf3U+sIn5fgkd+/lGE/2xWTy2R9Xe+fpgRXzeUhMgCjkV/A3yOF/UJGNT
         jN2Hz8JP9Jc/C456NTjKVFtlSkYmh75icDRosiD9M0lIKdS6HbvrWrPRG7R1RLgM9N1G
         HWjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780907631; x=1781512431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBRH/L0+ykNXBtnHZ57xnJnQx1o5G/ly+oNHE8zUpZs=;
        b=asSosIyv+vefY4nP3g+Pcywiu25HkjLyxLdl8p5LP8l3vbQEAzHH6kB/OmeMuDTPow
         ZLVH+AAA7R3x6f3/8P5JhwPeHvUqTZpGYWp273ezpnr3vyFpFz6u1oa0FfqxZSGbUsqU
         De7y9cWO+OkGqgcRSm1rskep1rV4fGGAiMNpHO6Nf7eZg2kZjZ3vwIBuDNMCthsq3Kp2
         3hueSm17bx36TJa517yJudcaQsRehJcTJagrXwYBY1s5sYtWFx9XLNm769UQ38qE4dCt
         hoC35MG/c1dzWVhzoEgr+iHD1zGQHCP9vQeX7JeMT7h8ciJ12NZHYz5F77hcC+4r4RJn
         ONmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907631; x=1781512431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IBRH/L0+ykNXBtnHZ57xnJnQx1o5G/ly+oNHE8zUpZs=;
        b=cL/i4DucTIjSj4kXuAZ9UMgT1SpcpebtrfWKVEb5am87HU9nO1mhCEd7UKd05FqaQP
         7Jp2x5SKQrtRKTAKQ6IzDMXnElYhoHfqq4ew9w6s7CPnNG2VTgjvwsoIY3tP7cmBR7B+
         NNcFMZZs+Yhn/H+xOPIJaNyouEteSPwY8lZo2mML7C1Zda41kvdbN5lRMENy/kw8/vjs
         kNXxJ3XGv24Wf77XP9AbaKEveMktBVIm2J7JSo8ghIVEjBVigdNGvvJ9sT3Ed3D+eDwq
         CsjYcaPk36aeYdqHRQfHVmsOhgbhNqe6LyaGqRQAo/GUgxxn/7+Y4eIW07sGZ0uLNVQv
         cuYA==
X-Forwarded-Encrypted: i=1; AFNElJ96Z2+d4gb4LhViwG4LjTm6RIuvEBeUAkEw4tv+Tc1iXiNjfhGhWXNMdZkQxtT9ThAspIWuV7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4815+5eU3x1uOuHePXGka+TsZy4VSxo5wsrpZPn3uLDoIIiXN
	fxLsl4LuI2waTrYL7aCavOJkkzIPnVlqPebhE+lEB+ZBLD97iZOgX55DGI9QKls2ZpVl4z8krk3
	XSPGbaHnMQLaS7VNvMzMIyqOC3F4iVm5QMdGUI2K2n95blEffVklO17D5MBZXJiKps8ovavcfRw
	avQ/ZQTnouOSKj+gH2NF1q/KT0GR2uuFCXNw==
X-Gm-Gg: Acq92OFTWTd/eJ1kneYeNO5O9UUzPzq7ly++DV87MIOKSngVHjwDR6cGfhBkOGYJXze
	71hpbnNWXeDB59jqHQraGo5Pko2oa+YwogKewjnfVkvtJoTEsPE5Y/1EQfYaZrMrPhIYVv9ZTRH
	bNo9jhz7ZTHld5rTVPkXSqoeqZiGHWnsRJ8edaHZ8Ub/qThYMHcmuKgcZg8e756V8ukVpLz2Gzg
	1+kfLg7CHXwDvi5S1QGATGExGz9pvPqnXdIZFRSWLzvi3R2FaPEBBmZrDjwbTOCei9phoeupqKR
	xJUU+OgUsdx51ZsQX5y2V2xBlVRKZqKJ
X-Received: by 2002:a05:620a:17a6:b0:914:ac45:a98 with SMTP id af79cd13be357-915a9c6e32bmr2219545685a.17.1780907631601;
        Mon, 08 Jun 2026 01:33:51 -0700 (PDT)
X-Received: by 2002:a05:620a:17a6:b0:914:ac45:a98 with SMTP id
 af79cd13be357-915a9c6e32bmr2219542685a.17.1780907631140; Mon, 08 Jun 2026
 01:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607093515.3-1-ruoyuw560@gmail.com>
In-Reply-To: <20260607093515.3-1-ruoyuw560@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:33:39 +0200
X-Gm-Features: AVVi8Cdq2uS19grkU7T_vTFKEi0vYOKZPB1VB4gwshQzMf-1oB1BAdaKfXY16LM
Message-ID: <CAFEp6-15U_PbgKf7zEtsMaN9JEA80fFPCc=mqmhtW4EXj8E-Jg@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: t7xx: check skb_clone in control TX
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: LCoRGEc9pNcq04qEo2lM5lGvpo0ofayo
X-Proofpoint-GUID: LCoRGEc9pNcq04qEo2lM5lGvpo0ofayo
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a267e70 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=jP0pG5YJDZCNrw5WLJEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3OSBTYWx0ZWRfX1JwfGu4iWNAh
 lNfv2qxifL+iWbd9SHC7uouMq+HMIxa/+h9L11gzGYs1w9sKxjl9JyvAlcyfdRCqP9x1lK4/7Z9
 S2GWxHIx3ee5QYz+Pg+tO7fExf0sxS4NhurEMD7gq2fIBYkH12Qf+/C0xFuc9D5w2lPsVVvxou+
 r15T9WYj/qlV9OFNG4/kQCSxfYbz77HhcfIX3dgc/j3kz/CsJ2neGdyJOYvgT0Rw8ie94QnylZY
 eQ/drVyQGyGhFzj8R35R2y2WCMBt90k089zSHobhE4ESgDHjUAx0PVB9vOzpGtWIUrDFrg65IpG
 BVSKWqy6ag0R7m/dJnJzpAM6f8zvlg7oRR5wZvrjvNuXque+FLcVPLnp4j9EGyLZXZNCgQDqxfg
 xuOtD0PRzeOqkX9S2uQUvZAYBU9OwUibHr5x/mwZ0+5RksbpbXkBOgVCJIkN0MgPmYjllFEKFx4
 UwZBjZTDWQZ+Rvr90dA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080079
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:chandrashekar.devegowda@intel.com,m:haijun.liu@mediatek.com,m:ricardo.martinez@linux.intel.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28D816541EF

On Sun, Jun 7, 2026 at 11:35=E2=80=AFAM Ruoyu Wang <ruoyuw560@gmail.com> wr=
ote:
>
> t7xx_port_ctrl_tx() clones each skb fragment before passing it to the
> port transmit path. The clone is used immediately to set cloned->len, so
> an skb_clone() failure results in a NULL pointer dereference.
>
> Check the clone before using it. If previous fragments were already
> queued, preserve the driver's existing partial-write behavior by
> returning the number of bytes submitted so far. Keep the existing byte
> accounting unchanged so this patch only handles the allocation failure.
>

Looks like it deserves a 'Fixes' tag.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/net/wwan/t7xx/t7xx_port_wwan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7=
xx/t7xx_port_wwan.c
> index 7fc569565..d2529df75 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
> @@ -106,6 +106,8 @@ static int t7xx_port_ctrl_tx(struct t7xx_port *port, =
struct sk_buff *skb)
>
>         while (cur) {
>                 cloned =3D skb_clone(cur, GFP_KERNEL);
> +               if (!cloned)
> +                       return cnt ? cnt : -ENOMEM;

This feels a bit inconsistent as the return value depends on where the
clone fails in the loop.
Wouldn=E2=80=99t it be clearer to either return 0 (indicating no submission=
)
or unconditionally return -ENOMEM on failure?

>                 cloned->len =3D skb_headlen(cur);
>                 ret =3D t7xx_port_send_skb(port, cloned, 0, 0);
>                 if (ret) {
> --
> 2.51.0
>

