Return-Path: <netdev+bounces-299307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VVttLm53L2p0BAUAu9opvQ
	(envelope-from <netdev+bounces-299307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:54:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C2F68327C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:54:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=oD+3sASR;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bnbrHbr4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299307-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299307-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 315353003425
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101329D29F;
	Mon, 15 Jun 2026 03:54:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9355226A1AF
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 03:54:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495658; cv=none; b=FC3OOJSCiHMQAA5yCfuXwJiPPoSVRcYyxUOIcE54jAkAc1PnLzEP5YDwX7WC86OyGKtR6JawqG850xOsEFeN0CodfUNtieNBnfJqCxSbwI4zIZde/kd+7k/K2dJT6N/qY7hFnsWuqA89tAFXxz5Gb1XgZvYgGduRK8xU/mbuEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495658; c=relaxed/simple;
	bh=6y3FsOO+p675zXpE6We/uvGFktDVvW4kbbI0mSbG4yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afoxwVEGKAcVsK+zO/Gg7mXBcHcqodm7YSHW/spk+Ii4TUx91Br4bXWnrWUdvk7ywNCEF1qpGVNFeEAgB1zix3eYFl2ZTNweMIcsw420D6LGflFS4hIx2pOGGQC2s+nqs0wUsSjXoayUUzma4qXrCbG+9ScYUMO6AMtlJYAormY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oD+3sASR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bnbrHbr4; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1iSE82739642
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 03:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Aj28ezwhv4TnokMoW4RbU6QQ
	Lc/XH3Iq3Hlkkr+sF1U=; b=oD+3sASRNbigJz2LV03W9rx8BotwZ+1JfdwAXSh3
	4NIBVpJig6Mb/IcmtFvQAuOs2aEGkmZIHXPOUA8waMIixhnhQW69l1qbGmxCzm4W
	aWqW64mzWU+ZISOaN4fNIehO3fBhtfNCsfXRSNtTX9ZkHOsc6LtJ++nNFKGBtczq
	B+ZudPF5tCQxgCe96CU9aKwnz+rvIm0hV9UWimXzFwdCVqq2WASvxzlCXc+Gehza
	2W6s9fFP88QeirTC4wOayo0Mht/W24kqwYLlVUm1A35YoIeetD9TbYTJjXI3W0aR
	FbKX2DxZy3te03iYfEenoUym0UVN3SzrbaeA4N0uq4Hh8A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery9fdds1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 03:54:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85a2c129b3so1338100a12.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781495656; x=1782100456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aj28ezwhv4TnokMoW4RbU6QQLc/XH3Iq3Hlkkr+sF1U=;
        b=bnbrHbr42Z3U/sZPW80KhSWrJIZqaXstJTrdGXxgOemyEzL1vMGODuoOdk4ncgzFbM
         UhJACj8UtGPVPEWw2vVx39LShBdcsYHDCxlug8KNmYnO6JA0kO86+QzOhKzgCVzsZvFZ
         cHHy6fg1elKdtQW6n4qv/08AIEtAWv7bDDpXk9+qJVIEwEM4NGa7+XAr5CuXPY5OYMs+
         UJUvwogXbCXSITrGYS8VyYEIHJ4xF0lOg0PzJdRtpGNfZDE6nz9TOAWr5EV3y5NWqX2s
         +SdnSd4SAty7uArA/Eb8zC0TtpErsfZuaB9cFEHf6FPH7KMJ4fM/ln3infyzqwgWg0y0
         hmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781495656; x=1782100456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj28ezwhv4TnokMoW4RbU6QQLc/XH3Iq3Hlkkr+sF1U=;
        b=q1WGgHU+EKbCfoFN4qMfGX+8LM6qfUGO2n4n9uaBsuexXS6gxnCP0zsAjsIaYifkUa
         /+N/3RCZ6wbIRMotTScwB1djFmeQSBZvGpJrfcW05ryaaV4aipAFjWP+nPD4MRyjDm1L
         cQJ3/eJ/T6/NaMv0GvWXgnlKvMaPo+/cgSLk9KiFgtiikXLf10LbnCUOFWpGnQFEzfUy
         JITmbCl2RiCPXVFK3PqEf5OYrxEeV73LtSFI9TYPFYAhT30SL3msP3MGDqd8Vd8pL0cO
         g6ZCUXcwiiYW4gbyoJ9+quvviHtC9gAaWRuNptkqSli/BB43h/Ib/SfDNXtFNgtqShFA
         FVdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IGQLIkCfDmz9NbWzDcIysVffYzRq/1PXgT+7qH08wwSyjVxOD4AXf66faBQUPxPMJAyl0FIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+jaoAypnIkBWkf5NKLF6qo5On/VlPvcKGf0/lhTsWB+Zuc3Q
	e9UiiIMIFXOmGMNK+MUBNN1Dku1P70QkT6TqQTOz3w/vdwXFQ0iRq+JuF2xqSOQl2Y0qoe0OKxf
	YCd7y6yyaAzI/2ODr7Oqkmsyz3XrNF4wSXctuOS1V/HelUz6N2O1zGh7C4tM=
X-Gm-Gg: Acq92OHIrkkdd1Qb8TNdxu031xQIkToOuquYAc/FqU5wH2J5GbuWO3H+ie5nQ1Q4Tx1
	DJedKrnLWxNu/r0jXmrtCSkNQMmdV0ccB3dEbpeCiES6gG/0KeBuwOv3JCHXGsvu429Lm40uEhX
	I8GzkEnVLmRFQYVTOYTfv6myGYJR0AqczVUaMTKuxVgW+3/0IAC85Pm2We1JhqfTZxVy5chRGid
	My2b6k8/BgaVWX+E7vIe8Ys/u17vTDDBTIbv6AhKNne7zWR0gik7L0AmJ48TGpMyRoJCJGWD72s
	mNpRnCbPhI5b59nmmhWv7C5JM+6Yw/3bhacFZyiBjtb3fklY5lwBuOt26nI3UxC0pAiL+epZ+oe
	u+w2qAQ90KYhICV8qTu/wk0xMlsa4uQUNYYo=
X-Received: by 2002:a17:90b:5865:b0:36d:b662:708e with SMTP id 98e67ed59e1d1-37a0202ecf3mr13816816a91.9.1781495656111;
        Sun, 14 Jun 2026 20:54:16 -0700 (PDT)
X-Received: by 2002:a17:90b:5865:b0:36d:b662:708e with SMTP id 98e67ed59e1d1-37a0202ecf3mr13816782a91.9.1781495655578;
        Sun, 14 Jun 2026 20:54:15 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a262adbe3sm10477963a91.13.2026.06.14.20.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 20:54:15 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:24:07 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 3/9] net: stmmac: qcom-ethqos: fix RGMII_ID mode to
 use DLL bypass
Message-ID: <ai93X/cNWHtEQsDt@oss.qualcomm.com>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-3-f0f4a1d19929@oss.qualcomm.com>
 <42355330-c22a-4fce-98ab-dc22b321ff16@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42355330-c22a-4fce-98ab-dc22b321ff16@lunn.ch>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDAzNyBTYWx0ZWRfX6rvbPbxP+U5j
 apeniqw3+x8Z2M7QmYZg/bIjmDQSpJp6mYw3K3vVTHEnbUmcXNc48vyM43zM3QHQRh0POOWa3jC
 q+Uft6XPCBaPUhnmEJTrgKqb670or+4lOJz1wJFd4M3xEZGwpRFvwGp9vlluqcc+XABmqfxWXTX
 xc+GTW3aTmJQ1ooZKrJutVeds4bWe121CWNuNGNhfuYOd5/aX8zz3dnx5eTqH52rjydETFqeyM6
 TAzSVF9lyq5oOJ40FLcNawPnItzVyBqqL8gLoEKBTorrCVW3sPHHfouAlAL3FEmEAqkLDeTKQJc
 TgemR/Cvvo8VniS72UkiwtnESg1MI+Iqw/GqVNUYtEvDDtc4REUgqC8Ntrnd1i+Ba7ACZkTIW4X
 OUPsIMFk7qoksUNacBi2GEFKJ898nBt8ohTSdsto4q7V7rMAW/WGJm2+NnAfP6gFOTQEi50hYlP
 mTdCI7jzqJm+O7ZtB6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDAzNyBTYWx0ZWRfXw09XA2BvXsMr
 FRx6yfaiAjIamNfBQdBLnr/h2tlUhICC4Y+BHazyWHZZ67DsJYHvV0ONiFGabZNByVb3iNDJEDo
 2bSIjHxLvSiOr25MJQEwV2Eip1ivH+Y=
X-Proofpoint-GUID: jiyyoJbbLR29pXRhtAjAr2B78gR3C7eQ
X-Proofpoint-ORIG-GUID: jiyyoJbbLR29pXRhtAjAr2B78gR3C7eQ
X-Authority-Analysis: v=2.4 cv=ULvt2ify c=1 sm=1 tr=0 ts=6a2f7768 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=h-cV_6-i1hGX5lmYmEcA:9 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150037
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-299307-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux@armlinux.org.uk,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31C2F68327C

Hello Andrew,
On Thu, Jun 11, 2026 at 10:54:37PM +0200, Andrew Lunn wrote:
> On Fri, Jun 12, 2026 at 12:06:59AM +0530, Mohd Ayaan Anwar wrote:
> > When "rgmii-id" is selected the PHY supplies both TX and RX delays, so
> > the MAC must not add its own.  The driver currently falls through to the
> > generic DLL initialisation path which programs it to add a delay.
> > 
> > Power down the DLL and set DDR bypass mode for RGMII_ID, then program
> > the IO_MACRO via a new ethqos_rgmii_id_macro_init() helper.  Also fix
> > ethqos_set_clk_tx_rate() to not double the clock rate in bypass mode at
> > 100M/10M, and remove RGMII_ID from the phase-shift suppression in
> > ethqos_rgmii_macro_init() since RGMII_ID no longer reaches that path.
> 
> I'm curious how this works at the moment? Do no boards make use of
> RGMII ID? Are all current boards broken?

Searching through the DTS, I found that we have two boards using "rgmii"
(qcs404-evb-4000.dts and sa8155-adp.dts) and another board using
"rgmii-txid" (sa8540p-ride.dts). No board which uses RGMII ID.

I don't think any of these boards have extra long wires which would add
PCB level delay. They are against the netdev definitions for "rgmii" and
"rgmii-txid".

But the first two boards should still be working fine since the current
driver programs the IO_MACRO to add the delay when operating in RGMII
mode. I am not sure about the last board. I went through the different
versions of the ETHQOS programming guide, and it should reliably support
either only MAC side Rx/Tx delay -or- bypass mode (no MAC side delay),
with each having different clock requirements.

	Ayaan

