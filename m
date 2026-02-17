Return-Path: <netdev+bounces-259129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIIqM9+1lGlMHQIAu9opvQ
	(envelope-from <netdev+bounces-259129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:39:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08114F410
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 595D33030D2D
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C46372B31;
	Tue, 17 Feb 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XnMxNOFA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LG8eURxm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465182673A5
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353564; cv=none; b=BxuLDP7OqVpDiHQ1DntrjRvAigNbpFUBfoF7u1Vf04YDBqCC5FYkOfhEtvp7V7Pa9GHcSnY06V4eB9gc6hyPIG7njslNImbY4OjCEnAz16yGgqzYGGy/I9Plp3MUysR5zWqdj0gzxsf0SquYkOJYJZJaCSCJ0m79nge6eM03rjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353564; c=relaxed/simple;
	bh=+V7Vl4YLN/CBb36rZ1VGqeTqLId5Ikd74J0lrmVM8sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgnlcOH1KcNwLIWHbhGYBVU6qu0ZUgP8jow2Q1L72Z3wKoq/RRr2ojVzqtxMDYJRNGFDrf8fpIlwe6RBiWwzBrxWpjKVZJOGDaDdq2v1f6SbL7EC9R+lu7nnbvb3rMxpY1cp4iunWMC9SajL4lJB8upAno8GPENAO3TcZaFxqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XnMxNOFA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LG8eURxm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HFRvTW048800
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HrP1EV3T54x1E7EsuxwJ7YEZ
	jkA7SuQSx7N9/VtPaic=; b=XnMxNOFA2nL3bBPtO0tGC9aKa0ddr3/TFFj3lql+
	OLwEaR61vOGo5OobG5tWWGPMXlHRCQ6VbxpjC7juDNVFex8dYWJr9h8fSJMzAqsk
	QfF9nWGB0+y1rq+o6ZpZAt2bHwH6LN5Ne7ZJvwkFIokvr5gpaMUwYI7vWaaMMTzu
	T0PNooiyLyxniBkd5QqjnoTglaHnsauLxybFqkADjbDK9euSUDGfrF8Wqxu7bD1X
	cKdC2BId1DTqMnOP8uFI/RplCaAy4SAbut8RVuXx6Eve3V0WKQ+Ks/EyX6q4NCqS
	sc9nxdPXDaKfhzHSt7IdyaCDsi8cGcOuzA6M4m2PdgGlsw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6d83j6g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:39:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6e78c4aa50so1077062a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771353562; x=1771958362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrP1EV3T54x1E7EsuxwJ7YEZjkA7SuQSx7N9/VtPaic=;
        b=LG8eURxm8/4b3tJgOahu6xUVdi4lAPDTrFQqzVtWVFvGYeh355rd2qlr/U8XGmXU3c
         2DRgcwgupaz3H410o6mnwQTkRgrkgl9DejjlmKx7DNU3gY4+mN67emWAuKtoHX2j9NWM
         N/7+NBsesXOOPAMeRDN/jUuhFW6uf71s26S69oNQtsDUr+uerwFvCgD50ekgjrxW7C4n
         cCAZLvobcd2DGE9I997qzIiivYu/WPsHrd5rdyICbxkVKQDD6qjMv/BoxVp91bSLrYxo
         /Yv64rIGxBjK3qCBXTlam0pYzvEjbiekk0MD+HYxocSCcvgoRyYUGXi57bAov1HtMpG8
         BHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353562; x=1771958362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrP1EV3T54x1E7EsuxwJ7YEZjkA7SuQSx7N9/VtPaic=;
        b=jlJ8xXlF1vA6FK0KIeji8EfopW3EakdXsG4ITMP/6cdLafWlmDjE3webackftwPkHY
         d3906cG+/MNhNNVhXK8S77qtFDHcBF2vFn0u2Vw0pxpxdFqfaQqQY87w5lE5/zjl4f2A
         eu04PAyx8g3kuKh9QY2dt72XI/mTr4f4hbxXfkNTjcIuu8TY8AKhTNpBadkhTZ3b7LzX
         bfAZ4oWw5eUNLogEyd38ytDvvOc4hP0anYetWcj6gimaN0x3uGATpnMHPSGXKcvuXkO2
         Qu7MghiPYwE8yLJjKJP+VQchKOGPNqOgpeMIB8uYgbfptVbYFCVIfr3EWDaoJ7W6w8BG
         NgUA==
X-Forwarded-Encrypted: i=1; AJvYcCWCwiA44/zdaZf2sfGOTBxxURMq1J0yIJV2wAKD2N/ogbaZx5v6NgXyl0JyGgLLrDecFhFvsGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKwNmz7HstdJB77HoZ3LCfaWiRhYqAa3RdsVrrdXZIahg4NKCE
	d0RNJB1JTSVdfFrMjT8f7Xlk2Qifh5BxkPdG8xVt0U7OjvscoSpsJTHm2y9ErhQyS4/Q7u3xvaH
	n1PErnEfnFUWr+77rjyDPzgtT0+xq/JMTBMwL+1p5YKCnTSzt3if3Jez7biA=
X-Gm-Gg: AZuq6aKjljVutczK36HM2+iEM1N50rg2O8jzpMTFnpjW8j4xQHrkZiK3NjcXShXdAMM
	8tMu+jYkaqjMURebnT2HqlwgFGrJeEYTc2R5Tj5/04WgaZ5ing9SV2xD1HKENaCUwWswQpLK89q
	6kGt05mz5bIsKPXRQ1nYmm+mtKW2RVLQLzcyHswHm6wXMdcSgyK2ML0ui2NNl4VM7oWJftcDMa2
	0XzpyJ0QjAFqq364acTdl0kFyswfTr8DnD6tPHS5WwKaZOXGjS91AImznT/GCEq6n4isc4EGWVC
	nlm072ZzecuFqU1dBqsjNKgdcA80sbKLToaKVwrueNHBOFUwyThgK0GpGQDsJ/kM0wEzERDGro6
	noAGBv4cqg7QbCyJZsRk+zm1+tRPCBY+SAGA=
X-Received: by 2002:a05:6a00:600a:b0:824:a0b5:730 with SMTP id d2e1a72fcca58-824c94ed641mr13781193b3a.13.1771353561877;
        Tue, 17 Feb 2026 10:39:21 -0800 (PST)
X-Received: by 2002:a05:6a00:600a:b0:824:a0b5:730 with SMTP id d2e1a72fcca58-824c94ed641mr13781157b3a.13.1771353561363;
        Tue, 17 Feb 2026 10:39:21 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bba008sm13377726b3a.64.2026.02.17.10.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:39:21 -0800 (PST)
Date: Wed, 18 Feb 2026 00:09:14 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
Subject: Re: [PATCH RFC net-next 7/9] net: stmmac: qcom-ethqos: pass phy
 interface mode to configs
Message-ID: <aZS10liDHG0r6UJt@oss.qualcomm.com>
References: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
 <E1vqKPQ-000000093ml-3FLd@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vqKPQ-000000093ml-3FLd@rmk-PC.armlinux.org.uk>
X-Authority-Analysis: v=2.4 cv=bqVBxUai c=1 sm=1 tr=0 ts=6994b5da cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=VKYGXzwvPY_sFHXjFqMA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1MiBTYWx0ZWRfX3mcuECPv1ikw
 LKQujaZTfJb2dkJhH5x6OgevNN7S+sDuRIZf8SuA7JuTPghKqDU8gKsVSKiZHlGBeBsfHxyIvPr
 0b/bXoNY1wbq0bFHrmfNPPd52YkKl3U8It95ABewq/N8r0egbrBfD28uk5/yscPHJpdcStBstoA
 Ha8jNAMxd5Dh4hqT2bGUDxKm9S2Ll0pOdhIIXEYo/wZrlyBPqbheOP23kelDfjhGJ0cnjjQ5mR3
 WvC1WF46v9obp/IOQuwpy7u+moByJHnctk27gGR61jujw0vFNtSLuyAa0BIHUS7wbG5FNrWl4SW
 oHL9tpHpo1W/kxlH2nQMRfY5ne+zGTfc69m8WxbuGaaayO+JvmcWhHvQ28S/bPTm5aXBPf9sMH8
 Qx5qWz7d0ZyiFpBHVP6cLNx0+mU60wJ1ZAe5SqnVWe7seXAQVY1Lszz8lTc/Fvh6qP09HhnRUj4
 jJ5FSbI8hIkrTCFMCYg==
X-Proofpoint-GUID: s7kuWE7IzX8keCV0tvJS1CjQ3E7zbBnS
X-Proofpoint-ORIG-GUID: s7kuWE7IzX8keCV0tvJS1CjQ3E7zbBnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259129-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5F08114F410
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:18:16AM +0000, Russell King (Oracle) wrote:
> Pass the current phylink phy interface mode to the RGMII and "SGMII"
> configuration functions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

