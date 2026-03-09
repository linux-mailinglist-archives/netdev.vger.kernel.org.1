Return-Path: <netdev+bounces-265531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL1MO4W/rmlEIgIAu9opvQ
	(envelope-from <netdev+bounces-265531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:39:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E005E238FBC
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F3B4300D0DB
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59360396B73;
	Mon,  9 Mar 2026 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXZi76l3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IwFscSDk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162523A4F50
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059221; cv=none; b=AnFkDY9ah+vf0iuThoFaAyqFyv9kjeMEa1uM9O3t7Lt0nz+9p+L/HvCndoyQxH4SHNBl16YqGeb21dAKSLw2R9znsHltoRKfMwgez65Cyx6qDmWfLc3W4S19WIuksbNcwTLwVCJy83+YRNznT/pBOagvYsVtrv3tTmW8cvqDdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059221; c=relaxed/simple;
	bh=F5D/T0I45Z8bAKRvKImty7SNyckVvmv0OAJZmQG5f5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPNddNIm7ztBEMwv5antgANsJCDifqhDhecrnjDefNXkmRH3aN4zg1w5CKdgTZ/6mpMIz3zJ/Dy3HCXlNe1WyWj4NmFWpaFv5suQ4sZWUkBlhGlm8JAJxX6XtRoPXmBP3EFjjROpNYJvqq0ffg2mYOTjnrxv2jIoLEDdDGpvrVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXZi76l3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IwFscSDk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62981msA201091
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 12:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rTeDok56LaLfDQuOKEeyhxvT
	asa4vMf5dB210aMR+zw=; b=oXZi76l39P4j9Nrm28AcHNcmVO6jQ/URLpNfbsky
	RDe4ewVm0fu1BfayaHIlA7XjnRvmDP5OqdUbkNM/cC+OTKMfwbUPFt6KlWtfUZcw
	CMqooEO8u9zzOZLY7b5YzVDv90S68eqzO2vSBYVBm7dt5V/tB+lg/nO9q5g8QPO4
	t3DUq29qFjDwbLA1mZOjZruhEG9LajgCo4l/I5cmPxNKk4RCNGO27jIfxbeWvdre
	M7SSYEewtsVtmDXOZ9xKrbfkqjbZ0mU5eCoUv0kuPUvuh/a1b/riTQQ/MA9WyV1t
	vIgJVxx9G30zXya+Fu2uBfKAxP/SSeAIPVtpBNyc8SJCag==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crc3vdbvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 12:26:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae3badc00dso96366285ad.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773059218; x=1773664018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTeDok56LaLfDQuOKEeyhxvTasa4vMf5dB210aMR+zw=;
        b=IwFscSDkhEXHFvIc1VbLESwTzVige4PlEWgtb6lc59iBBPMWQzcX1Od6O2T+VlZvDm
         WRnTOOY5oXF9D/NBVsQe50cCpwZQqoC8jVDvQ23nhVFbWTgFKbb2mCfnhz34X6XsZu0Z
         Ggl7VkHZSE0nVUCQOoCNpdy9mjaIejCICO7BBl8rVqv0N6F3l1uudt2aOthx/PYAV7j6
         0uX39vVz6AcYtTcWFeMy923Nyav/uRivgAQ2NLRysSxiW86JzcRBLVPYyd4C4eCiVkMb
         UPibNdwLrxsVaFPPldPOoQnK6FlO2pBnfKqvqPEkcvShhPizalhCVup5zEvYunBGt/Q4
         KD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773059218; x=1773664018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTeDok56LaLfDQuOKEeyhxvTasa4vMf5dB210aMR+zw=;
        b=EG6Q1jyW0V93nItGOnLkGMQgdc6iUXIK7q5sBm9TUz8ZG1brp9cTFImBWuiQlnu//J
         jPH03YCNYzdby7zLKGQaoxfnc1CnUxdCmHvGpA028ECqom93YUn6j+IaKS/eq49KDXZ6
         LS3DzuKSawLytSe5KSjShnK3mxELhAKZZkKmvjiJ7WAUKBiLlqaxhPIIffE81i23aLa2
         aiR8CX56H3XgThLgog5leQwwxImybr2sJgRKeEm/NfnkTN9WZGMq4k1sWgYQobij610w
         w6sO3jNzoVHQ/sNIgVkBrTNDP8pCGcwZv5bgcOwiugCtLtp+rzYqNbdqxV5aZ0EMymFA
         Myig==
X-Forwarded-Encrypted: i=1; AJvYcCVjRuQE74C7/o+Rjn2sXqQDu+e1NwdZ7/7crOZewyBQLtwzY5DLDo8QqlxG+7DI+VqyvuG/t0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUT48DEwo5NnSu7Tk+n1FHQfKOhH5FDpr4TUknawHf20HgasN
	OsjR+5AP9g9aplqkoEY8r4W5UBOuR0hW+eDimaz4gI2XgGDequaXjQi2p3G5jMV2WDDoMUi8M52
	0n/c/ojBGWALu9ixP9GJnAvH9eN4YTKdKV5VmBUrvSP3W/N1DZ7eX1ckAln0=
X-Gm-Gg: ATEYQzxm959p6ShHX4ELkyREdZG9p+PiOAHyB9HklHwU0nENKnUuRq9pCzsufsLZpQY
	tGJbNc8fBMgpY+Fs/twtjf037z7XJWRGOt67LDc2T7Gp0J80In8O5wsPJLp0ZGGQ3gEwJ2hyyJA
	gvtqBUqiNQI6W75k2FU9h+iCHAFd3QL6lQryc88oPfys4RZ+djUAA62d0VeYfFhDHasBjuFPrQG
	nMr2s4gwrnf3AjT5MgVUX1qXzRty2kaGAiu411VYw1+HF0uU065q24bWs/xNCYFvsvDe3dnlqp7
	EmsgTlAlar44wlyGvQkzjj4SGz+UlwtIvCVU7MV/2gGzcuRzTbDSNNa7i6jeJ/9A3+KW7ucqp1F
	niL1+VYDAVplFclI6L8hWN5e1Rmp96wwgSJQ=
X-Received: by 2002:a17:902:f68f:b0:2ae:42ce:1e5a with SMTP id d9443c01a7336-2ae824b8437mr105759775ad.54.1773059217735;
        Mon, 09 Mar 2026 05:26:57 -0700 (PDT)
X-Received: by 2002:a17:902:f68f:b0:2ae:42ce:1e5a with SMTP id d9443c01a7336-2ae824b8437mr105759455ad.54.1773059217193;
        Mon, 09 Mar 2026 05:26:57 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f751edsm154196825ad.50.2026.03.09.05.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:26:56 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:56:50 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next v2 0/7] net: stmmac: improve PCS support
Message-ID: <aa68itP3mXx0WUNJ@oss.qualcomm.com>
References: <aafxqCvJ_XY4YbWw@shell.armlinux.org.uk>
 <aandp3FYSJbwoZxo@oss.qualcomm.com>
 <aatLjarGu_qdRkP2@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aatLjarGu_qdRkP2@shell.armlinux.org.uk>
X-Proofpoint-ORIG-GUID: 2k08uVpeKZUY9J2XcTlutMRLIwJ9bh0d
X-Proofpoint-GUID: 2k08uVpeKZUY9J2XcTlutMRLIwJ9bh0d
X-Authority-Analysis: v=2.4 cv=OOQqHCaB c=1 sm=1 tr=0 ts=69aebc92 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=GKVA2r4k85XJU_JwPvIA:9 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExMyBTYWx0ZWRfX9GMLQNjaH3+4
 2J2iYkJuUz19b5gEB8+gPlO/LRZY3ZuCSe2LylF7Ya32dPMHT1Acr/SivsaXTXFKDSGV60ZV7lE
 wn+XbuHDAkGTX3Y8VI5hiJAC6IrdoLNAykUzAuEdtOB288sd1c+gGofdr5RkSTU6Isvvxm3fZCm
 sWkGZ7Y/iXzgSDVle64XQaNl83een7/yTs8f5+StGVMKz9oWYMA0BBXIK9buXwaepPV6ct9/AMf
 PbCYHuTarlwMtOPKKwUaULskGJ9APkSDqRoX6IZJ7ELTCGgqw1soqbDTE+3AnbXiloBQ648L0Ff
 mrQKoenKatYEubfcc4rAbQTfDNqcyts4hfyTUvcucsONFCyE8BRQD4BOu9ErYTRIqISQXI5LhCw
 EnkQsc/jWgmFhTVJZmEJBbfvXoNGfPiPV/g7SUOloTxrMMSCpTEXz4CFFxcz+4ovXmu8DH5FHcl
 ZMvflLzCuStErps/a0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090113
X-Rspamd-Queue-Id: E005E238FBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265531-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 09:47:57PM +0000, Russell King (Oracle) wrote:
> Has it always taken a moment to stabilise? Note that the ANE changes
> will trigger a re-exchange of SGMII in-band, which is why you see
> the PCS link go down and back up after the "ANE 0->1" message.
> 
> I do notice:
> 
> 	qcom-ethqos 23040000.ethernet eth1: Timeout accessing MAC_VLAN_Tag_Filter
> 
> which is a symptom that a clock is missing. There's been some recent
> patches merged into net-next which changes this:
> 
> 2cd70e3968f5 net: stmmac: Defer VLAN HW configuration when interface is down
> bd7ad51253a7 net: stmmac: Fix VLAN HW state restore
> e38200e361cb net: stmmac: Improve double VLAN handling
> 35dfedce442c net: stmmac: Fix error handling in VLAN add and delete paths
> 
> please indicate whether you have these applied.

I don't have these applied. I was running these tests with my tree which
had the serdes patches. I will move to net-next now since those are
merged.

I should have done a better job of cleaning up the logs, the VLAN filter
timeout has been there since forever.

> That's currently expected, because phylink thinks we're using PHY
> mode (where it's in charge of reading the PHY and telling the MAC
> what's going on) rather than using inband. This is something that
> will need to be addressed later.

Understood.

> I think you added some debug between the logs that you've provided
> below, which I'll take as not significant.

Yes, please ignore them. I forgot to clean them up.

> This reprograms the vendor provisioning so that we use 2500BASE-X
> for 2.5G and SGMII for 1G and below with AN enabled. Note placing
> the PHY into low-power mode while doing this - this causes firmware
> to re-read when exiting low-power mode. I wonder if that's required
> in aqr_gen2_config_inband() - but that will cause the link to go
> down.
> 
> Note that VEND1_GLOBAL_CFG_AUTONEG_ENA enables inband signalling on
> the link.
> 
> With the above, you should be able to test various scenarios with
> the PHY - and changing your provisioned 10M configuration will likely
> get 10M speeds working.

I will pick up v3 and try this out if needed.
I am also going to test these changes on IQ9 with the QCA8081 PHY which
shouldn't have this issue.

Thanks!

	Ayaan

