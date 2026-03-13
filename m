Return-Path: <netdev+bounces-267530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE2bJlo7tGmDjQAAu9opvQ
	(envelope-from <netdev+bounces-267530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:29:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 030D4287071
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D53C831D1D6D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10D3C140C;
	Fri, 13 Mar 2026 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DwVw2moL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="igrTUUzL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922D3B3C02
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419034; cv=none; b=aNq3+KswOHuEezwi3xk9/eQf4GbNhac3pXPCrLVgTvFoSrVjiBFaShIVdpr7X+KjHCRV8cL+D85OE7loRXqBC8MiInWgeiDtKDOtJVCi4hzh+zA4dkcz6QdSRyaYgZtVIkkvcvAkkN0cg3NvY/iwpG1ApXypEozjY91jFNOhtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419034; c=relaxed/simple;
	bh=muDlhZyro/n0dYw1NM2HBqw6mbIJO6udMqpPCjwU5C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV4QsIfmYLsgsMHwGIeKUVwXMBUOfnu0S6XCzst/jIXZmhygY1g9ejp0NOGd46bgBWsjgTZOlNkShj7aa4dQgQa9pd5ZAiym3Ii+tTAriFOUoVUk81mncHvYdUq0Ip9o8nSwCYv5JucMUWJ6/vc/XHqkzRWmySwgMYz6MzeylWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DwVw2moL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=igrTUUzL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DDnRvc238441
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Bm2VZJzabmRS6BLmEtwZ6MFH
	HA4bRNlULfqd1XMWDgs=; b=DwVw2moLdnj6dZS2klJZOp98DkCExLjHotxLhTah
	NQ/Z/MGObke0S14uQcCwHX55FJGomiR4cRLP2/hmPbqmdyaVSr/FvFXazqVhkvm4
	bB5+P+6AswMzHK7lR7Lye1t6DifXuZhndJK8+uWSO3pdoEPB66bIjIzUu//uYg4y
	4BDTeCWcrE3m61hvWy+SwMp7E/RUI/7/Di2UabCsfWHtcePXJ6PvS/Cnn4B4a5kb
	Ui3RhuY1weLYiIaRX5JN4ctzP5fzpWzrdxDCRUTPMw/gstaK0lrHwvM8aqTYlbTi
	7Blr642ZXprqyNEQ3WoIVSiANMELaGNimsDupRTnCs1Xlw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cve3d9wb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:23:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd81c571a5so1384073385a.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773419031; x=1774023831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm2VZJzabmRS6BLmEtwZ6MFHHA4bRNlULfqd1XMWDgs=;
        b=igrTUUzL85374xyHCjg7UaIehe7MLt9s0hIAhVbJsrnQCQgk0a4QuwLtWlgkg7e6sm
         7fWE3JGvEDA8yc9bx6AeOS36kKLepEmf6C7KTbznXrWptX+hekMT31082xd7kSYjKBX/
         PJuZ6O8JTd+cRScG4lxjttVga5lON2vekwEUwds1Ne7ImvYgWCJwx03gt3rno7+ntlCd
         ChndZtk8JzpUJyP6DlP+jVq/p/s75938omoT3MFAWGWNK4L+NtSS1vs/1ZI6ZTwtFkxg
         euWLIZFPumlxZm3D6vDj/ovVWllPkMEPi2MFZ+SqJ6GuxaNYjdAXuEJM/NcCsxyfHeu6
         cpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773419031; x=1774023831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm2VZJzabmRS6BLmEtwZ6MFHHA4bRNlULfqd1XMWDgs=;
        b=fP0RxUD8wu/LdsnBPmCK3alBb+UIPo0q4Rkk9kGJEHXaE1QKqNz8qGeuyBCJUdM39k
         +LT2Fgffy3o22VCDokngH+FfGzQJZwHkAgxyqXXJqLspbvCW3hD0NODmMuwPobC3xiV6
         J4vuh+cKD7p6Px9EbQNcPnvTM/bZY+mGqirIDYQ0B3zaREHGLJZQ8CvWBON/xcf4Gsu2
         F6bv0exbPyX6pxmXzMsaA3SGZ39tWZw1F5QjVNu9Vmvd4OS+8dC80E25D22zkl/jt3gM
         /B7hg+Ubw4X8zwZMoa5Ym4xZkG3nhKjfblOq1vjuHdJHlpe/LMxS+XwK3oMVl2CLSYvc
         +tiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtmB5ZUsLY8+kBvg+EpuUHKONOQ6PUNWDpQzX4bdZhmbf8uddE+dcwH7vR/3aOHPJw7sfzdIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQOX2xnJUjfQxaMBTAcbbKLHDN4pL9/aZUWTrathp21CMq0xl
	HNdoRDTvNwaG74uQ4JkznHwCgKdY3xIa/VEI86q5NQfWFHGNfTh2Qgo5Z3/UTao/DP9lT3VR4wx
	nooxe9eYpQNZpTp6hswDlK9j5T3+T+Es7fW950GKo1myP32y6wzNf1fkYEVc=
X-Gm-Gg: ATEYQzzNd3o0I/f5JCxMLmJxo9QtgZL97iBVZMUHZh6WS+iUtfOcQ91DBNdcdzc9DOg
	ct/D9UWIYxCf5MLuG+S1vW3nLeq2tNclEq/Wdn5rv7yb0b55ol8Cg2158mVze0F3kuVhuFcADSA
	ShuSHWXPatn9raw+nGHDgqviIDxoG7SfYYDSgoxQTvvuQ0VpUQ3meulzHJ76GefQjSuOvkAnEnw
	vU/4o57eNGnnclobMb8LB2dh9szXa7QbzqEMV8HQQUqv4IC4kUcqsn7oQ8R5R/08VGfoLZsHRjj
	vhOGdiUTSVQrZU4GPvdh/uRA/GzDfA8xe7R/z16MpT4Oim5qPnU2l1axCgaDcxb7zP6XP61Sg6A
	70TEgrKRL0JjF6/nZVrxWZ3pfnsQZrjkhRe4tr7DCW3DibChIw4prwGlF5BDAT7h8PRuZi9jUfT
	zNLJawxEj6NsQ65yO2BqyC9/V7UhssL6FVqsM=
X-Received: by 2002:a05:620a:460e:b0:8cd:923a:8798 with SMTP id af79cd13be357-8cdb5a70ff7mr523291085a.20.1773419031338;
        Fri, 13 Mar 2026 09:23:51 -0700 (PDT)
X-Received: by 2002:a05:620a:460e:b0:8cd:923a:8798 with SMTP id af79cd13be357-8cdb5a70ff7mr523285285a.20.1773419030798;
        Fri, 13 Mar 2026 09:23:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f353e1sm1574765e87.10.2026.03.13.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:23:49 -0700 (PDT)
Date: Fri, 13 Mar 2026 18:23:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
        r.mereu@arduino.cc, m.facchin@arduino.cc, geert+renesas@glider.be,
        arnd@arndb.de, ebiggers@kernel.org, michal.simek@amd.com,
        luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: Add Monaco Monza SoM
Message-ID: <erzhoze5gzxlrffzgaxnyt2lx2s7hicvxg2bxy4ydvo24b3g5r@hbdqospl4c2l>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260313103824.2634519-5-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313103824.2634519-5-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: rG01i7Q2dZWxN63szaCZVqKyOPeqHwQH
X-Authority-Analysis: v=2.4 cv=FLwWBuos c=1 sm=1 tr=0 ts=69b43a18 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=PhgHo22kut4TJJxNvVMA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMSBTYWx0ZWRfX2PXfSV3nOnkX
 CaRjAscmTX9jwW2LP0y9OdG6QOMYZp1dKLGjNrbRmuD/QtZ8H9GAgccCsDO5vN5VCBUeLuD83c/
 jK5beCSnw/Ax6feTllx78CvcZjGVaOJW1jvvkv51sLcL8/+JPcJiOfVa/fP2HptcoKvXi/NHKPl
 94yIcxj21f/zOoum0Ud8TnDUtwcdtn+47U99q8QuIrp28O2cdG669tOHQ4oDsdj9pWc7Vp73dOZ
 Fc3kaGFf8BQv/YGdt4KUaR7vca26kvzf/cKy41yj7p0BGiKyZIAwCT8jC8eOVXlQtcdW9mzJ7zL
 dT/O2iCgnHzRAPb1GXqdIakzv6jH074Lnsz/3u+IxuZdmshAMJQZcZhpQIzHbDbfgv2Jq+ljUx9
 IrH7yULTCn32lqduwI0LTVaueIsx/MfhbOOqvS37Ub5XxPmA65A2MtyZdICBjP9lzYO/qDs5alw
 sZ8PM3+yOUuPG8QUWcA==
X-Proofpoint-GUID: rG01i7Q2dZWxN63szaCZVqKyOPeqHwQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130131
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267530-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arduino.cc,glider.be,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 030D4287071
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:38:19AM +0000, Srinivas Kandagatla wrote:
> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> The Monaco Monza SoM is a compact computing module that integrates a
> Monaco/QCS8300 System on Chip (SoC), along with essential components
> optimized for IoT applications. It is designed to be mounted on
> carrier boards, enabling the development of complete embedded systems.
> 
> The following components are described:
> - Fixed S2S 1.8V rail
> - PMM8654AU RPMh regulators (PMIC A and PMIC C)
> - Display subsystem/phy supplies (DSI, DP)
> - Enable GPU, GPI DMA, IRIS
> - PCIe Gen4 for both controllers and PHY supply hookups
> - QUPv3 firmware declarations
> - REFGEN always-on workaround for USB2 HS PHY
> - Remoteproc firmware names for ADSP, CDSP and GPDSP
> - Ethernet SERDES supplies
> - USB HS/SS PHY regulators
> - On-SoM eMMC
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  .../arm64/boot/dts/qcom/monaco-monza-som.dtsi | 323 ++++++++++++++++++
>  1 file changed, 323 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/monaco-monza-som.dtsi
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

