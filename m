Return-Path: <netdev+bounces-290916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IImpOf+3EGqzcwYAu9opvQ
	(envelope-from <netdev+bounces-290916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 22:09:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1895B9E95
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 22:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC4B7301038C
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B56379C5D;
	Fri, 22 May 2026 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EbgztTsE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gEnWvWbh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0035CB6F
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480563; cv=pass; b=rGYwLAjx4PGSh0GeygJnsNs5ZK+NyNpDfNeszFuMs3d5MuE68LoJGaTHPVBipnQPKG0jUMgJwkCPRAziSXLFgroHCVwIPLRxJgRl0ZzEq/1h/NI37TeDZ+UQLHv3riYqeuU4Jjk8pUFrmShDfK0H8U/el3cxDZyLUeC33y0WbKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480563; c=relaxed/simple;
	bh=BYenqKReshgy7WMYk3vXJQUj0YK+MP2HizGUmGHcwiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHuRUTXupzTUPMXIYmGlEk39kxPpAsXOfJbFBSCYM8cppokxrCXhBo9/BDTZx9fc6zKVmdf/O6wN4rtFQpuylZkLCcL9IFgWAzaInhyIw8J05ASwOmOY3dH4aaHnvfGCG2MYTSoTT77yuCRUc1gj3uM9M2tQbvSD87Cqjk0irdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EbgztTsE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gEnWvWbh; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MHYQ6H3947428
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 20:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4mgJ5edVM+mqGwYghHMz4APWCN08GCaqEMyrnNrUOWY=; b=EbgztTsE1C9CerSE
	ANTpW3uvn5Il5z/EcdPUowP+j1DovIhpYLkshTBQcFSp04zrMrdGzt9VrEDdhC4u
	/OS8jPtLzIIC64gNN8r1/jWRO1QKY7ePcVrH1lXNsJdefWwgMAsp1OkdSnzgxz2A
	RmeUVsDokIDB0hnA0AhEfhHrMWZiz+A/5xNfbXHXQ2JjFfmAuTexFDG4uSh9GBE4
	Uj7Hhq2m1Z1Dkp6h7E7qH5ORpxVxb0PHRo1f9A+gQd3r8tvMFo7+/vT88LSzxMd0
	CYtP3evhGCD5OxWn9UeuQY1sqK6HwmFMAEMNY2/FH5RrzV0e0fIlG8WG6aFtaO5Z
	vTsYIQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean2nj9ms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 20:09:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-910304978f3so1550881185a.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 13:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779480560; cv=none;
        d=google.com; s=arc-20240605;
        b=fJ0wL0UcDLjZqBM/u9G50AaRP4wep3VCOYsM9aHn4j5WmxRAYS8U7cD2/VVaII6n7N
         y50vxv2gkX9DGb3VnTbqPRw+NAymG1TIoWUfoXOusbXTx3dZ1axmK63D5ETJ/VU3dlxn
         HNH0wl16AhumgepBXDQYnmeeJNkuiUFLLVa9lJHz/o0hnKDAAQPLexC9+FU7FKhEVWDv
         ysIQX0rxu4EDrcA3WfBcI8E127ge02S5ESVaZMm7ogJW/K52R3wuRNhdQUIVFQzcrfPr
         pT7Ig5cLRxsXTZxZM4gDJyRZnHurOQOQYfP2v5oP7KFkM4b7v8Ly6gE8zffnPF6oMoCc
         aDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4mgJ5edVM+mqGwYghHMz4APWCN08GCaqEMyrnNrUOWY=;
        fh=qVBzFBeGeizUVUrvdfvdHhPC3boCCmJa04MUmgIKmIM=;
        b=LN1heGSErVC3ZxBXN61KOxG9o3TlHJg6hobmOrfDM+4SQ4iVuiX8+QgddibTe6wO7e
         mnEihyMc5hhYPosezXNW3RTTnk7PJAGgQPL2PZ+56zAirVLRpjbCOXkDHpKxGiByAATe
         Cu5UgvDbHB94E8XbY2XWXR9XDTSDXqjC26vZ4jN7Tun1esUZ+Ct3qjfPcwkQSFgZKV9z
         VjgILHUzye36UsgRhwlc5b9w/kEWdfoDN6qZHXdvOLhqZEk/Lax6sKv+Y0IGrO+kjzHb
         jTqjOAZLaIgNuEX5KgKG40N5gVhe38Bjr/DxjGPHzDJRsI3wbjer6M0iEWXVz4V8aVTs
         bvkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779480560; x=1780085360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mgJ5edVM+mqGwYghHMz4APWCN08GCaqEMyrnNrUOWY=;
        b=gEnWvWbhvP0+e6LYTrWsbs3M/By180X7joJLIy4G7R1DWU4m/8cj1rAnGMnluHIE1P
         Fw+WSudfAqe9Dfdh/nGbPNX8BTcQz7+0XSst2n7XzpU5SdFspXvzqSfiduK2u9PKJKOy
         uletSv8F+H/t/Nyvg0VEHGnud9pDORrgqyA+eb/1zkC4pmc3TJmaB7f9P/Q9PL4vHkSP
         IzKTr7crAYdi1pS/NkT3miojCZLXR3uLhm0AUsq5OCorx/BWtGzsJ8Oj3Hqvx90LlZo0
         nBTgkIIsatOI5JDP5IzvlomB8GRyDteSzeo+tQzDLPa5b9AhqadO9439KBaU0+fYCkQm
         sktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779480560; x=1780085360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mgJ5edVM+mqGwYghHMz4APWCN08GCaqEMyrnNrUOWY=;
        b=B8ree+lJaEQKHKMm9+tVrITPruPdHkN1nS13F5kEseVqPhQpXv3B5vnUOKDyBFlbl9
         tu1VeHkTHmdp/Bk0+N+wjPFs9jeAOp0ETheBqNcExDHqZ2+gzhgnZ+fUJ/Y3XWJQDUvi
         zTDIriVv+rTwhKvb+K2Z2Csu54T6H4TKy+tSv/7DGL8BsmfZglsvunbsvayONXvitfnD
         9gIwPVbn7qQQi42/LW4HyG+ayNJIa/aBgsAninPkedcZyfYxnWmhcBblcKw29RdaGEGZ
         R+P1zpz/qAJEP8Ih1OpqF7QOf2BiWzQi1ikCt86q1h6PQYT2Ubt7jY+eu8O6nq9QwsX9
         Sw5w==
X-Forwarded-Encrypted: i=1; AFNElJ8dZSsLijJWkViQIeFla5XWUk5UcACQXEZF2m4EGtdGEzRlaSn4xuWkJoqXtFghC4H+Rk8lnO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzv6ye58Tl/21cefUssFXV544L6lq7mYqgUDWQAwepJPQCASk
	AMLJXv3kQQ9oeUTXSkuiTRvKfVso2eDMUMIs7z8LtwVkDt7g2kBBElMS2blMdBqmEK8rWgnzSsz
	286b9NpxkCfgRYkjckWlD8qufaxMxft7Rvo4BJP3akEjZm7TdC+Jnrv7+VMRb9L0dqyzSXmP0m2
	GopFDcoeTQ6ZW1TQ3ew5KE2s7WY68CsbpDOA==
X-Gm-Gg: Acq92OFTrQ/y6+pj/RuG3fnDIR6BRbGwSZXNK0eGLjBN6il2xo6fGLgECvm/cSiOY+v
	nQRmEqds43+49S38aYhmlBRl3TeuD0LxYVmnz8spgoUhKYVbi5C5JhURCCbqVUDgS13Im2B5rJo
	H8YoifuxE0hBRXgzWQWfr3QrdHfHGQTXvgJAU7xnDGOeicgc+msqx4ZmhbHEpRt7EZXnC1XCoZi
	tE+/kHE3u6PirYA/q4MkN8LXEB8EqNy8yVCVJKvcibmEew+ZbIMo2ws2F5wvV6RoliP
X-Received: by 2002:a05:620a:28c7:b0:8cd:aa61:ad8f with SMTP id af79cd13be357-914b50cab94mr617031285a.14.1779480560369;
        Fri, 22 May 2026 13:09:20 -0700 (PDT)
X-Received: by 2002:a05:620a:28c7:b0:8cd:aa61:ad8f with SMTP id
 af79cd13be357-914b50cab94mr617022585a.14.1779480559708; Fri, 22 May 2026
 13:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com> <20260522-mhi_runtimepm-v2-3-fbebf41a82bb@oss.qualcomm.com>
In-Reply-To: <20260522-mhi_runtimepm-v2-3-fbebf41a82bb@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 22 May 2026 22:09:08 +0200
X-Gm-Features: AVHnY4J-9F8AAJuD_tJW6-iaDPIYDcwXI9s5goDnYZwmGPWaSdjsV19cBJfwNa0
Message-ID: <CAFEp6-1sdQn11NKom6cfwtJvZX-CnPRpJeVzQ+99Sb4A4L-qaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] net: mhi_net: Hold runtime PM during active data
 path operations
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        netdev@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, vivek.pernamitta@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=XvDK/1F9 c=1 sm=1 tr=0 ts=6a10b7f1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=omgbQWz8Cy1bZfrwG_oA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: v_lIbDwzhArlW4bpiZ-Z8OBZ7FOU9jhc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwMCBTYWx0ZWRfXxIcJogGn0t71
 SsPqtvrbbReZrlGCR98AlwardvVwHG56zW+dYjQ8ylc6jOVtFK9JZ6MXC9DwzKLGZe3qfpUjYE5
 I9mqiqx8CRIe0yAB8S1FYLL+mwkKMkBb0TohkXelSibXPnW++lx3MWj4BT8Zk746C8ryDfbbYn0
 zS2z4gHDsqEbrv5RmQ99tmJKgnnaxifQOToupk+7wxNgHhOgNC9SCg/PmpOC58HJcmmpnd8ea8b
 TXGdYFItDcxzocJIKlQEUyy37K2OD7b/Z7x6YjBzAZMkKnzqjOqrRovbkZJifkzNBQCQ9xlANol
 Iq7k6wRtQZlN44UxgiPdl66Q+JA/TfLmRQX1CZEKGqMv17Vqg/XrpwNbcCzHoujFhe6F0Qy+BEH
 0lE6jfrycwKSKbsKhcpKYaGvpwhBftbHHYsOThwhbhg7HgKybQEPnka6r4Zsbj124ItsD/NU+6f
 aPvzUMB23M6CKCDN4EA==
X-Proofpoint-ORIG-GUID: v_lIbDwzhArlW4bpiZ-Z8OBZ7FOU9jhc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220200
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290916-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,sipsolutions.net,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,quicinc.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,mail.gmail.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4A1895B9E95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Krishna,

On Fri, May 22, 2026 at 12:01=E2=80=AFPM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> The mhi_net driver does not coordinate with runtime PM, which allows the
> underlying MHI controller to be runtime-suspended while transmit, receive=
,
> or RX buffer refill operations are in progress. This can lead to stalled
> transfers or failed queueing once runtime PM is enabled in the MHI core.
>
> Add runtime PM reference counting to the mhi_net data path to keep the
> controller active for the duration of TX, RX, and buffer management
> operations. Enable runtime PM during probe and take/release references
> explicitly around these critical paths.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  drivers/net/mhi_net.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> index ae169929a9d8..5d7f9ccdb17b 100644
> --- a/drivers/net/mhi_net.c
> +++ b/drivers/net/mhi_net.c
> @@ -9,6 +9,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/skbuff.h>
>  #include <linux/u64_stats_sync.h>
>
> @@ -76,11 +77,19 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, =
struct net_device *ndev)
>         struct mhi_device *mdev =3D mhi_netdev->mdev;
>         int err;
>
> +       err =3D pm_runtime_get(&mdev->dev);
> +       if (err < 0 && err !=3D -EINPROGRESS) {
> +               dev_err(&mdev->dev, "pm_runtime_get failed %d\n", err);
> +               pm_runtime_put_noidle(&mdev->dev);
> +               goto exit_drop;
> +       }
> +

I am wondering what the value is in pushing this PM responsibility to
each individual MHI client driver and requiring every MHI operation to
be bracketed with runtime PM handling.

What does the client driver know here that the MHI core itself cannot
handle centrally? It feels like ensuring the controller is
runtime-active during transfer could be handled generically in the
framework instead of duplicating the same logic in every client.

>         err =3D mhi_queue_skb(mdev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT=
);
>         if (unlikely(err)) {
>                 net_err_ratelimited("%s: Failed to queue TX buf (%d)\n",
>                                     ndev->name, err);
>                 dev_kfree_skb_any(skb);
> +               pm_runtime_put(&mdev->dev);
>                 goto exit_drop;
>         }
>
> @@ -251,6 +260,7 @@ static void mhi_net_ul_callback(struct mhi_device *mh=
i_dev,
>                 /* MHI layer stopping/resetting the UL channel */
>                 if (mhi_res->transaction_status =3D=3D -ENOTCONN) {
>                         u64_stats_update_end(&mhi_netdev->stats.tx_syncp)=
;
> +                       pm_runtime_put(&mdev->dev);
>                         return;
>                 }
>
> @@ -261,6 +271,7 @@ static void mhi_net_ul_callback(struct mhi_device *mh=
i_dev,
>         }
>         u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
>
> +       pm_runtime_put(&mdev->dev);
>         if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mdev, DMA_TO_=
DEVICE))
>                 netif_wake_queue(ndev);
>  }
> @@ -277,6 +288,12 @@ static void mhi_net_rx_refill_work(struct work_struc=
t *work)
>
>         size =3D mhi_netdev->mru ? mhi_netdev->mru : READ_ONCE(ndev->mtu)=
;
>
> +       err =3D pm_runtime_resume_and_get(&mdev->dev);
> +       if (err) {
> +               dev_err(&mdev->dev, "pm_runtime_resume_and_get failed %d\=
n", err);
> +               return;
> +       }
> +
>         while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
>                 skb =3D netdev_alloc_skb(ndev, size);
>                 if (unlikely(!skb))
> @@ -296,6 +313,7 @@ static void mhi_net_rx_refill_work(struct work_struct=
 *work)
>                 cond_resched();
>         }
>
> +       pm_runtime_put(&mdev->dev);
>         /* If we're still starved of rx buffers, reschedule later */
>         if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) =3D=3D mhi_net=
dev->rx_queue_sz)
>                 schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
> @@ -362,20 +380,41 @@ static int mhi_net_probe(struct mhi_device *mhi_dev=
,
>
>         SET_NETDEV_DEV(ndev, &mhi_dev->dev);
>
> +       pm_runtime_no_callbacks(&mhi_dev->dev);
> +       err =3D devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
> +       if (err)
> +               return err;
> +
> +       err =3D pm_runtime_resume_and_get(&mhi_dev->dev);
> +       if (err) {
> +               dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed =
%d\n", err);
> +               return err;
> +       }
> +
>         err =3D mhi_net_newlink(mhi_dev, ndev);
>         if (err) {
>                 free_netdev(ndev);
> +               pm_runtime_put(&mhi_dev->dev);
>                 return err;
>         }
>
> +       pm_runtime_put(&mhi_dev->dev);
>         return 0;
>  }
>
>  static void mhi_net_remove(struct mhi_device *mhi_dev)
>  {
>         struct mhi_net_dev *mhi_netdev =3D dev_get_drvdata(&mhi_dev->dev)=
;
> +       int err;
> +
> +       err =3D pm_runtime_resume_and_get(&mhi_dev->dev);
> +       if (err)
> +               dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed =
%d\n", err);
>
>         mhi_net_dellink(mhi_dev, mhi_netdev->ndev);
> +
> +       if (!err)
> +               pm_runtime_put(&mhi_dev->dev);
>  }
>
>  static const struct mhi_device_info mhi_hwip0 =3D {
>
> --
> 2.34.1
>

