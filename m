Return-Path: <netdev+bounces-258664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I9DD7p5j2mWRAEAu9opvQ
	(envelope-from <netdev+bounces-258664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:21:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4C2139255
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 107F83010925
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CFD28C2DD;
	Fri, 13 Feb 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6Jpo9CH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvUc/hKI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E65281358
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010485; cv=none; b=sSlVHZmikQz9n1SnkYJryEn0PU9077bg/3NXV9Vj7TU9yngchNSEIoECUOcUcXyGZEb1jmUACnQ5/odDZwQs2rYebExC+Q4yFgbJGd3MzHg/NZnOAEw5h75zMe9TZQJcjvsSrTY7YdAyIaM182H4oCBEqwhUMgPoOdwFjvzoFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010485; c=relaxed/simple;
	bh=LBhP1N70laMxAtabFHUh0SPSyW/npkn2TmBtw510or8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcJjVz1ZWQEexqaPRa6y+qnhKLqLb9C7np+WSj6kg4nH0RA8F9JaNSS6eDXFC2gG62bDdX+J0UD6eGI2PEgUMmSVj6Kfvua0Kn2ws8G3mmEgSggcclGwhkp56nM5ah02UYe4W+8CRd57rRn/vWVSYgEQS/al9e1IxlJ3X2zRrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6Jpo9CH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvUc/hKI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DFL6bu3891101
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 19:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/j+c1dsKAqHBdFM+Jul/RdoFeeY+gCzkUvQYQD74pFQ=; b=n6Jpo9CHKdqjFPx7
	v5EaF8vVhX2l082qisnceDw76JfYyuBwc6L9g1w4yVqlFMNWW+77QDBsi0b7372K
	+S9LsOh9lh4EhGHWcLlUSXL1ZlmBcX1kbd5uNJqC7Kg/Fmi496jZEkJXjGsOWufh
	juv38KO6kgtRk1KTohNdRF3wQuzpnB0cBkPNi5UkDvfn0LhkabUfLFxuKPnAjLnZ
	gZJh0ap9UNNJfjyQNpivsLTgmzY4vpQ2AV6HOKKWDSlVPMu3vAERkLjC0Re8Qfw4
	YbH1nE+Owm7rr8tFYkNi51LG1delweknJC1MCdM+lOQcbsLTK8S5f07uEuBiu26b
	UfGh4g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ca6h7ryk4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 19:21:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-824bbce0a44so4418995b3a.2
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771010482; x=1771615282; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/j+c1dsKAqHBdFM+Jul/RdoFeeY+gCzkUvQYQD74pFQ=;
        b=kvUc/hKI/Uzhb33akxlDEY1XVDnZjqHViFZEW9gnfWlBP0sR7PKDutmrq9QyxyVwDS
         pcpnh2prFE1ynZKJkSS59sMZnSyP3YIiJmrOmGyrB/O44m1ZjyvOOC4Hvgu2W5tUVx3e
         9zxzVeJoIlX3EAKBa0w4rUFVrp9jgOWZ/CHC885yUMDhumyi/OV3O+KbDpfKAaibNyou
         XD38BOvtYZDIjLyYp2pQTvKAHIRwsv149dkchaoEl4k9ILg60Bn9xR7KPQVX0ienZ0kj
         opZ8WxrEZ21tt/mTsIMByiOVFWf9vhG9sSRWMPiYQWVt//sW078dP82DlxlpU9pT5027
         TEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771010482; x=1771615282;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/j+c1dsKAqHBdFM+Jul/RdoFeeY+gCzkUvQYQD74pFQ=;
        b=I9TXAJfMnVvrfMJu6u/oAV8vJNlSRgAabaaFuqC33GpMQIDnQcFg9VXHr6ATuenWcZ
         VPK7hOox3jQLYtHRR/zfKkSZzM1zQ3by4MXx0mU++MRypiQwvGWKM0aXGZ8zzngRWKd6
         5Txg+hEirdQ47k6aB2DwstucG/bo8kuEAHX6ozEQl/VdyME0cvnVhzXowIBACD7OOYCM
         jGBe/UD3dqXpp3q1v1XlIjbhggsady+iLudQNssFPLswdu7E7PTE+Pc01azAr2xVng2F
         uNrv2VchAukpl8pMxlLmKt0jnFQlByPBLFYqgBBoikzFZBXeoajo+ILtT0eFzIX4uQkh
         JPCA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0m9f3heqLM5lfym3O1N7EsLyy6tA47dBAMWCfh/b83UAQMtqAz2wVMyzA6M8tWQM9Egwox8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXotedQLd0Ur867LE3g92Ct7CT6raPOUwicYpLzpzMMKiHpwKV
	1wmoNz+ZpR3eWZ+wJVTVq0w2POFDKX2FuvYBR6mtyqLJoCklpU7CLwWy1/hku1Pw4iVDreRB5Ef
	deBQuBo2VwJodUvHrVRtxbuEleWqxgiu7fhNvRz+V8aEMg6BKUXy2Th0Zpj2q5OTriq4=
X-Gm-Gg: AZuq6aJE0SMdc410MM4SNZO1rFNgH7b3EJELu0qY9FOJj4yqrfvf6FOGP05mGDjlOD5
	Vd4VJcbXZAXJDaardXEeoaxv+OE2K4sLT9N/P7n0PVG7jQ9J5ijsF8P5xNNmohjxrqAjUuO8vSS
	wfTCc76DdVUrtDdzgUAbkp7q7EBMSPrtaLqLwT007S4Q7iFo8eq6cve5JKJQ9gftMD5ebBQIrBM
	2DfkT6XJ+xHkou2ulEpNrB0UZj9PpSLLEXE0oPzeQfar9NNFPCWsH4i468HTpqblzSmLU1p+aMc
	QDRMU+E7fu2K7P5AX1QC2mKdIDwPiOw6uFzObXPjjUxAdr4VJ2dzhrgi4RYxMqVWUKeYzw0Unl4
	zqmW13ycTgwnTWLCdG8k1EajfFu5zEJSw1Rk=
X-Received: by 2002:a05:6a00:3996:b0:81f:4675:c2a9 with SMTP id d2e1a72fcca58-824c9310c16mr2776898b3a.0.1771010482236;
        Fri, 13 Feb 2026 11:21:22 -0800 (PST)
X-Received: by 2002:a05:6a00:3996:b0:81f:4675:c2a9 with SMTP id d2e1a72fcca58-824c9310c16mr2776865b3a.0.1771010481623;
        Fri, 13 Feb 2026 11:21:21 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb55adsm3238949b3a.62.2026.02.13.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:21:21 -0800 (PST)
Date: Sat, 14 Feb 2026 00:51:13 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>,
        imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next 0/9] net: stmmac: qcom-ethqos: cleanups and
 re-organise SerDes handling
Message-ID: <aY95qbcG2BLGVzHy@oss.qualcomm.com>
References: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDE0OSBTYWx0ZWRfX/pI7n/Pvd8kQ
 E/sfv9D6NSQ3aUulgI0ZFr0WRxo56SWCU0gse7IKXRJXfpbOtFeuvEsX5FjMfn23Gx1wjjKeBAY
 kecqHDbnPE5zP+v46o4P2tMhld41PezO8KR4cOoKPGRCHfNtsqhoArpSbiyfOTASGaNIX1dBokU
 8uuTq2alQYykfWOX4pdK3Z5Nckn06bDcby85dgJ8j/HqUM+9s3kQBb1Rh2DSUDn9WJFtyLjFHMW
 36ZqdMAIGBgR3KRPKvL5GTH66l1/rbWDYDgNHMi4lO6Kdi8+sDrbuPBiHG58A6iaUREkBSV2Dee
 aUIXzMnGvM2dD5eEo2pMgt8WvOd+VvRMrFLCwYMkJgw+eyP2U5RC3rDv79AJ/Cp7RPmyz8bSDhP
 cD+nsFggl1xAnst37OO9y8TSHTA3DAadtpR5paER64aAo9bdKQj2m7kA45CrGYQn0EO3jrx/wFX
 n/EOyc3mRAcE306zPOw==
X-Authority-Analysis: v=2.4 cv=IaKKmGqa c=1 sm=1 tr=0 ts=698f79b3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=D3qBBfOVRyNl_mCGRPIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: irZtSf7FKIC0sumzSW1gAC9UaWIh3HCq
X-Proofpoint-ORIG-GUID: irZtSf7FKIC0sumzSW1gAC9UaWIh3HCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258664-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5C4C2139255
X-Rspamd-Action: no action

Hello Russell,

On Thu, Feb 12, 2026 at 12:09:10AM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> As the last series had issues with stability, I've changed the approach
> in this series to concentrate on keeping much of the SerDes related
> code within the qcom-ethqos driver rather than trying to move it out at
> this stage. This means it should be possible to bisect these patches and
> pinpoint exactly the code movement that causes any instability.
> 
> This series starts with various cleanups to qcom-ethqos (the first four
> patches) before beginning to move code, passing phylink's phy interface
> (which will change) to the fix_mac_speed() method, and then using that
> to configure the serdes and inband setting before moving the SerDes
> code.
> 
> Please test this patch set, and let me know whether this works, or
> where it breaks.
> 
> Thanks.
> 
>  .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |  11 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   3 +-
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 114 ++++++++++++---------
>  .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |  11 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +-
>  include/linux/stmmac.h                             |   3 +-
>  8 files changed, 90 insertions(+), 61 deletions(-)
> 

Things look pretty stable on the QCS9100 Ride R3 board (with the AQR115C
PHY). I would like to test a bit more and should be happy to provide a
Tested-by once that's complete.

I may also get access to a board with an RGMII PHY on Monday, so I’m
hoping to verify the changes to ethqos_rgmii_macro_init as well as your
patch from the previous series (“net: stmmac: qcom-ethqos: convert to
set_clk_tx_rate() method”) soon.

	Ayaan

