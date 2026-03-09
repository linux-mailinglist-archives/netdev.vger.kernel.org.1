Return-Path: <netdev+bounces-265482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBAYF9CqrmntHQIAu9opvQ
	(envelope-from <netdev+bounces-265482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:11:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDA237A78
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F159301CC90
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02097396B94;
	Mon,  9 Mar 2026 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JeyvWL9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i4KvBN9/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60E396D01
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054665; cv=none; b=cA8FETWiUZ7WYg7hPJOFxxytCqm+8riesSMhvN3R7BxmAZCb6Mr/uqFkKBmvInFBEJqF7F88cqtQdtpVnch6pnK4aZuPNvcxvk/vguuZ/lX7oqewDCkzux9TcVArYVCn2bmGB5iEUFpqLvQYrMMqwjO3RtCNC+eUHCaN1lFpzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054665; c=relaxed/simple;
	bh=jRloghjBa1pGeGfZukYYZ2zI6AVLcOq1y96jm/iQ/U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCQUwITUNZ/DJf2jDYRDKDA13reb7iu48PO7xruOJ984ghHSChZkMyllgX8F4xRMS/OSSOuu/55DHyjywibgeJOwgmHV+6NF4tUFNUMqP2vK1N7rFOF3SyyeoxKTwRsptz8aO6B/xU6G4j2ZGddHIUDOfVBJZnm4Kv8CEYmQwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JeyvWL9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i4KvBN9/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298WPew3774286
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 11:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2vcqntBHnJ9jNcmMCrhjcICJ
	WTC4/uHfcjNc+otCaEk=; b=JeyvWL9CvFdqMvYH4Uwf5YXE6DfuYFJRKgNHwPFY
	j4P2q15t+EjR4zrgqEgCtY6mhfSEZVxpWD8Ja4EEbbJDJoOAyAd77b3YHrktAGR8
	sNrWbQJZhKLG1cyMMGplh0w41UKXhpoPf2MeJiOuhVMxrIJl8FxS0tnYn5yh/K3i
	tdp2qiAEg51gDf7PkG3fG37g1BIo+w6nyF3PQFjASzyrU9UmTqeePxxdNJ8YcKQo
	GTlIlhBM6cKjrIZ9Et6Uc7EyRo5Ofl5HTG3DK13vijuu2TQ48ylv3nf2LEd7a8DA
	ca2Whh2J67xeuowrAUHuoD5nRjBWvj1EenFqV0oJlTNgbg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsa8j73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:11:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8298b363fb6so10651686b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 04:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773054662; x=1773659462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vcqntBHnJ9jNcmMCrhjcICJWTC4/uHfcjNc+otCaEk=;
        b=i4KvBN9/bL4dM718TCiVDn/BTBIEPVu7pa+NLIOsfr94o8cjVyzKZAc9tSJzh8t3ei
         WbepxWQ50/8UF9GAhIRRUsPUX8M4hpV67vDkYHOvSiZOdQfnoDJNaQAtzQsMXXAh2KDe
         Z/IHgQANKfB9+iqR+zyofwP+MAEnjHIlJJ9XNEQS2sWkmzIUl0N4OHiItNcf+ed5NU6L
         s4ialrziWkmI+2H51qayp7mBByBGHImCKHfAaSNXmGrL9cNW/OwGBlnGX4pcdFuoG9yI
         b7hhCY9N7y4ypKSbOcWqZN6LW14Z91oPzOykhOkKlSolgbDhnYq+IBQQv5HzCNTsxXE0
         7ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054662; x=1773659462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vcqntBHnJ9jNcmMCrhjcICJWTC4/uHfcjNc+otCaEk=;
        b=FM1inuNRYjw42yIhHI0E4XqLT5i8xX2xvrepLmFKuVOa26gu5YXaloqT8B+z+jy5u+
         avTiUis3VboAcXVqSo06V+oEvrCE1fAy6sGvpcRdQemM2ZCSqCsEPSDXRPY8Z0fogn3Y
         bb1IP5MSIp/P7hOV1Pxpk74Ri29Of684aGE4aJUmh28Q6zEogHLnuHu3rfZhB+xh0+46
         EqyBUfg16CJz42pU6PN0JEpitbtjiKWnnl5r9pPuSSgcB/mGcuKtGMpg47J4UkVi6SSc
         9U7MaT1W3pCSvIQP8REzBLYokDVXK4SfVlY3pmqNuQr4vyX98NWtvfEug2QYQ7UtMLto
         H0nw==
X-Forwarded-Encrypted: i=1; AJvYcCU5SfSs8sbAt1+6AmqGKNG6E8bxcxRgoAiVsDM6WtqC33c/ItietakJN3ToxmRTeoRr20ceiTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6MD9E5FOyEInuxR3ORA7XYvbcC6iL2z3/SrWJ0N/t4ysXJi6E
	Si3Rh5qsvcUdkhwLhVkRGNlrKcZvehzlreRZYDKtA5Zgtrt2MbOJ6o/GFLq/7UJCtuNTTpxKSSF
	OmC0swSsIYcQRoVwewpKOvnW0HG4grzWtaiwthAqnLH87yfu/MTWgdJ8kORo=
X-Gm-Gg: ATEYQzxJChLeNAbGnNJ9vF9tSG3yjSqP5lbk3h9EfiH0Ey0v3T5N+Qq/Q8ama7+QNX+
	4MAF7dRaYKkVLR8NPihv0nxnvr2o++LsobqlmJ2uhGcMdgleXLRO/IVWQvGuBLXzkf8HEzUwZNh
	0KwBWO8WG2kKk6SpcPvzsniB/tFd/O1cOh37ZfKYzHI2mXLRMysKjGswd5u0PlvsNhU7P+z7SA8
	XhzFI1NbsCk39J2pygE3n1CP6M1rCMMphnYSpURJmQQGUlvzjl3MK/8euFibHLMg7AVdwp6ovb0
	JQzWANHnFBGvGvqtkNvhYcgsUykfIeucleb2cY9MYumdKPx343FSZx+AGvt9Vc9BEI7kkXK9/PX
	/VO/+257ynZNZcu/akJSBd/bUhUxvkFFm6os=
X-Received: by 2002:a05:6a00:2309:b0:828:f1d9:22cc with SMTP id d2e1a72fcca58-829a2d85103mr8988601b3a.20.1773054662320;
        Mon, 09 Mar 2026 04:11:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:2309:b0:828:f1d9:22cc with SMTP id d2e1a72fcca58-829a2d85103mr8988581b3a.20.1773054661861;
        Mon, 09 Mar 2026 04:11:01 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48676besm9478833b3a.40.2026.03.09.04.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:11:01 -0700 (PDT)
Date: Mon, 9 Mar 2026 16:40:51 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>,
        imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Jan Petrous <jan.petrous@oss.nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
        Samuel Holland <samuel@sholland.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH net-next v2 5/7] net: stmmac: use u8 for host_dma_width
 and similar struct members
Message-ID: <aa6qu7oWLeB0Dpeu@oss.qualcomm.com>
References: <aa6VEsmBK-S9eNYU@shell.armlinux.org.uk>
 <E1vzX5P-0000000CVsK-0iwX@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vzX5P-0000000CVsK-0iwX@rmk-PC.armlinux.org.uk>
X-Proofpoint-GUID: VYJJa2BNVwyZTtyqsbfFlC6IK3qsM9nd
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69aeaac7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=nXI6kmJP-DpmoF2jiF4A:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEwMiBTYWx0ZWRfX4uBcArFNHJwy
 XFUj3bvSv9fHvnCY/OjAUqbvHyMzMuVPznA3nLboGlc//zEr02nRSW14/RB0VnmeRJAiyshO7Fa
 ULsozq42Gki1s84tlXcy+9NCOX4PLofIWKXcUkxrqXjP8Ct23hNq/FAp+pOQ72FkKuDCZz8YyO9
 hgjGhOhgUgjaA+jPCZXYE4pqQbg+tuW7m5lFoKWBpKx/rWyJr5hcy/RV2uQXKdZwJOSkmQJsjWG
 NC7sJXvhsK8NQyacwRD2jbf8IDMbIJNG+lf82ED+iVCMaAN/97tpOG7yGZLQ8fQgO3zNP3VJU6n
 ELH51FM7N7tgaCTAjbR2bZK2Ld5BLQ4JegZ4THi2hDtHJ/QE6zzRyl4kY4S7KCW28MZohG+CRYx
 pLmGrxW79pgjqx9R5s1vuwWI5Hs7zcFr9ela0EiXmLYvdz2eiGe/zUr3iu5yygBKaCvWk4TsIF0
 bt8wvHDdo0jW/in0IMA==
X-Proofpoint-ORIG-GUID: VYJJa2BNVwyZTtyqsbfFlC6IK3qsM9nd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090102
X-Rspamd-Queue-Id: F3DDA237A78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265482-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:39:39AM +0000, Russell King (Oracle) wrote:
> We aren't going to see >= 256-bit address busses soon, so reduce
> host_dma_width and associated other struct members that initialise
> this from u32 to u8.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c         | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c    | 6 +++---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
>  include/linux/stmmac.h                                  | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 

Acked-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com> # qcom-ethqos

