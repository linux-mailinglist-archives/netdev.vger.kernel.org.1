Return-Path: <netdev+bounces-254596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIVoM/cLe2k6AwIAu9opvQ
	(envelope-from <netdev+bounces-254596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:27:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 367FFAC976
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4E67300D442
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F2D37A4B7;
	Thu, 29 Jan 2026 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XQZpLCMl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BqYLAiOw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8E379994
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671638; cv=none; b=gF+nbP9SK7P4yJLoX9jYA+jSarOFmi3GC+hw5Ykp4MfK5zFEewkUZ/NUkukDPAAqdvQATLMw7mu/uAGB+bx4bGzSYAqAgQ8hPJkyjuVw6FF9CDDJu0w1frCniw62orjxr2O331nAQdHifh/u62tX46ysgS04oH4ZgWU3SggokxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671638; c=relaxed/simple;
	bh=fPxOctzySdaLJHMKxRfAzslWn6fnklZSK3zA2PCap2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqLiOemaCiln/Y6uF6ADLq+gWPHRYu23YYekylyTiRvH1uz+LQLdFARJxgDgNsKpZ2h/3axj5g0xBz7nKNNy6rZnfqFyinjnQAtNYbSEf7G3lr0q9TL0lBrXpBTf19yG8bqgPTfa3nyB9ViyWWly8xlEbUVZxZYQ+5fIZT3Jp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XQZpLCMl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BqYLAiOw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2oqtI2060281
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 07:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ySOUOkIINh0fLQ8YNyshi4af
	ZbpfENdrNzzg6IBH0jw=; b=XQZpLCMlWMKYiSGGuigMRDbLlRF0eNdStZr7ltiv
	gFqnqnzIVXMcJpfmQXcT9igO9cgoFpKrpW1Ciy6YYpHIiInuZPpxK2hO1FAwo14n
	shAFYbqkzCoanUMiAwMDcChR6p0K300HUyOPjmLEAqLTUhUNQugKAVdruml6UeTS
	yxErv16vuxLJy9cQ8m2lkHZxIbkvD5TTpPi1ypj7IVaS/y3xcUzFNZ8hpFoFSEUf
	URLd7hVa2JUkOxIT7w9KzfWerTbTpDMCe7pFzbvUFY2vRdUYvu3PRS9YNHL9lgVf
	w+JcU/9v7mIOaO6sg1NFh8Zmxv+rX7KauhHIOQq/00UGZg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bypgrjdnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 07:27:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so1321415b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 23:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769671635; x=1770276435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySOUOkIINh0fLQ8YNyshi4afZbpfENdrNzzg6IBH0jw=;
        b=BqYLAiOwY7jU9BnilUyS83IHQ8hq7b7p8n7K/w15OuchrTEkseq8h60rIuqgPu7u9c
         LsxQhYkoB/Q3aV/2csaO3FIXSDCLpxGTJwwc3kWcaTC/qGSzQANW69soSMQ+v/E8WFNO
         jae+Otj681cYi/gBYrezcYw+6DtRxg93A58LhzUI+Jl/iCcrQON2+a3NVZbZqdEx6FYS
         GruEkl7h7Bo/BqxSO3RIuWo75xgBzln+HMXj0hjrjvs6e3/OGXFGIe10WJDjqQt8DDbL
         3uPwPp4LcNwkJg/DDv0x4AIiWeAOvtiJslP3j19F5Ez1IRD6H9Oj9im2EW9cAN+3OApz
         A9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769671635; x=1770276435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySOUOkIINh0fLQ8YNyshi4afZbpfENdrNzzg6IBH0jw=;
        b=gHWlTpbitBRg7SxMu90JDHcTfJDO4REdVExXyq6PP47Aj5oVjjrSdnyDeTrbvy1aMn
         U1agiSd8meYd6LlOZlYUkIz4dV3m2/MoanCeg8dZ+XNnrfW07N6n+JozF/1RPmCt8+n0
         QIKowQD59HGj1MywGPfBac+AnCqojZc4zLqWJcbvuHed8jqfRqzez/1ZGNRnIQgXD8Ng
         HEZPa+EpdPMCavu56cyjDMUBnxCeA1zRkeQ8HGLln7gHImXXzp8ASDxtfxXgOliDa0i1
         RsTBznr4/vbMPB7tATI6RhUbiBtNctN3sdhYBEJcsAeyUSrypGKf2iGjSavc+dJ9A/zf
         zR1g==
X-Forwarded-Encrypted: i=1; AJvYcCVB3jB8QflE4zUu3AUZ/udZXfZRlNdP8zSqHb/pv+SfNR+u7lTmqd4a+aV6SAGDOWdjgo6oVFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjfwZ9edpbBk9BzZ2pp+7rPSF7MUe6TFsgzA8r/RPgDZu+dZwJ
	U5aiUHBRrdATtXqVUH0XYOjZDR1nsBw3nlbIkUrms/jjoC3mVQTeU/Z+4RI55q7SisALlyg2uOA
	99j3i45JYe67OtR5b10mxiubUCmzvSkSk+CWeKYGrGkX4IW8wEoL2FeU4ev8=
X-Gm-Gg: AZuq6aLelFl+78X1v+OUEuQGv6hwfBDj9yKx2+7PXEfDmmFHD1TCi6mkIUY/ttRjosf
	o/qXMk5kQNSSh+uE/e9q5bEzXpgLwUnN3eRea7A2rKslCRlVaqcgc3fq1EHi2T2nLhYZy3+lOCA
	8ikWIBdK151J6iacDZMqHQxf3+fgMMUzX0KtSyIVc7+i3OZVwL2WNrm/aF5q6LNhhoVs3BLq025
	/tKFkX9N07P4gnc13Gc+54IIDPfrZhZ7Y7Bf5yWgAB0YRHBi4dH8Yv6wv2FZkxqvTr7N20FfPhi
	W5wAGpWPetMq4KV+rVwpkroyYIMzey5rSK6pFlKXIHwJwAP/j0ANrUD4d3XFwvBTXOXIbXJsIjl
	U8QTKjmo2c+cxVLmdE4IVORQ=
X-Received: by 2002:a05:6a00:94ee:b0:823:5745:cfd8 with SMTP id d2e1a72fcca58-823920ddbd2mr2231122b3a.32.1769671634916;
        Wed, 28 Jan 2026 23:27:14 -0800 (PST)
X-Received: by 2002:a05:6a00:94ee:b0:823:5745:cfd8 with SMTP id d2e1a72fcca58-823920ddbd2mr2231101b3a.32.1769671634411;
        Wed, 28 Jan 2026 23:27:14 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b2305fsm5035336b3a.10.2026.01.28.23.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:27:13 -0800 (PST)
Date: Thu, 29 Jan 2026 12:57:05 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next v2 00/14] net: stmmac: SerDes, PCS, BASE-X, and
 inband goodies
Message-ID: <aXsLyb+x76/WaXcs@oss.qualcomm.com>
References: <aXNEwBW3OA1xLEUj@shell.armlinux.org.uk>
 <aXN5BFXMshnhwBQ7@oss.qualcomm.com>
 <aXPo5R1Q-qWG3r3l@shell.armlinux.org.uk>
 <aXjSbu6L6ICYOPiJ@oss.qualcomm.com>
 <aXjdAZeUl2Dsu4mE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXjdAZeUl2Dsu4mE@shell.armlinux.org.uk>
X-Authority-Analysis: v=2.4 cv=d7T4CBjE c=1 sm=1 tr=0 ts=697b0bd3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u3xWUgpTUxrHMWPZussA:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: SJqSWoqS_bHYloNMWjF-AIUrLziTmx3r
X-Proofpoint-ORIG-GUID: SJqSWoqS_bHYloNMWjF-AIUrLziTmx3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA0MiBTYWx0ZWRfX8+UAZdm7w1fB
 8qJW+GHz+tlSnfYyzeNgZ/l1NX316WVl5Y7wPgiXxiMtIWS0p5TAXiMzq80OtxJ1lHBFTgimLBp
 71b2x0pX9UJnFAGopdKKVKYLD0xh5OWha6zdz2j2joGnh25n4rq2tkAF5sf6zsU+Ne9gy2Wy2Qo
 bu3tAkbSkTiqbKbUDxmaSvI6Ki3MmMd7fdMrC1V3lYuqNQ+hNbS0RpPLPHfe2cpa5XwiLa/oGKc
 D5T5YxaruEfd68zAcj8QIFlHlqdDMr1jghHVrx0BdE8UHyYXefAxLLdSTfab1sogLcvsQzdjEr1
 edSaLEmUnL7nws7OVInzfE1WMDSd8/eaSepDTGZh7d/0uuVFvzQA7Ql6vu0qIW87Acl5ESuXVzq
 lNhgVAPRd324+sNpzi+wlFzJKlNdgjVNqRf1lsqaPXR8msk0RQ+dk+jcjKlFZne96OG8Zg8ZLNN
 xitthXPFsEFA3YWW27A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_01,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290042
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,oss.qualcomm.com,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,linaro.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-254596-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 367FFAC976
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:42:57PM +0000, Russell King (Oracle) wrote:
> On Tue, Jan 27, 2026 at 08:27:50PM +0530, Mohd Ayaan Anwar wrote:
> > During pcs_init, BIT(8) of GMAC_AN_STATUS is 0:
> > [    7.985913] [DBG] GMAC_AN_STATUS = 8
> 
> Hmm. This means that your hardware doesn't support TBI or RTBI modes
> (which is what the dwmac core uses for BASE-X) and what it's actually
> offering is an up-clocked Cisco SGMII implementation.
> 
> With AN disabled, this is compatible with 2500BASE-X implementations
> that do not require AN.

Yes, this hardware implements what some vendors call OCSGMII (i.e.
2500BASE-X without in-band signalling).

> > I also tried enabling comma detect during dwmac_integrated_pcs_config,
> > but I am still seeing the Tx timeouts. I remember that when I had
> > tested the patches in October (without the SerDes driver changes),
> > the link state used to flap, but the data path became functional
> > after the link stabilized.
> 
> I wonder whether the SerDes needs to be calibrated after the link has
> come up and the clocks configured. phy_calibdate() will re-invoke the
> programming of the SerDes, so you could try adding that at the bottom
> of ethqos_configure_sgmii():
> 
> 	return phy_calibrate(priv->plat->serdes);
> 
> which will do the calibration after the clocks have been set, and see
> whether that stabilises the link.

Somehow booting up with a 2.5G link is more unstable after adding this.
Behaviour at 1G is pretty similar. I kept comma detection disabled
during these tests.

I was thinking about the "good" sequence (i.e., the current net-next
tree):
	-> phylink_up
	  -> mac_link_up
	    -> fix_mac_speed
	      -> SerDes configured via phy_set_speed
	      -> stmmac_pcs_ctrl_ane(priv, enable/disable, 0)

Please let me know if you want me to try any other experiments.
Maybe I need to do some more testing after playing around with the
sequence followed by this series?

	Ayaan


