Return-Path: <netdev+bounces-273743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NGxC9w2zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:04:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F63371539
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B603040760
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70A3DEAE5;
	Tue, 31 Mar 2026 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nfMp43Ov";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XcKyJHaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D23DE426
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990736; cv=none; b=ppwfa1QBHXhrlKoSD7lceVRSym0oWkdZE3OanNK0/2HD3VDPHWlB5GiopR0rwIZiyg9216LgfLBt0hAcaJnI0ryxMsy7B4Nn0pp+E7bQxqZOKkNxsFzm7/fZonuIvKVAsxsmRw2PTNIl2axa4OmP7Bjzgp+FIYlS2tzybGdC6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990736; c=relaxed/simple;
	bh=4pw//0aMVpVC79RUN/bCK1yLIUNfqEnOpV6nZbaH04E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTV9ydZtOTOLTkaaIkrFe4UervwSdm2lksStYUw+23xuk2aVT3FjRYeHgg6HwCJTn1J+VQf/SpZUuXLzGAiF+nKo4BQadpGKmeSxhCnYIjRlUmn8s1xRKFE3+YGIeqzpCzBr/KKoferF0KIPn5HTyRKqdIlpU9m6vP7vIRiZm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nfMp43Ov; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XcKyJHaZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VIGsRO3081367
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 20:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HddPcSAbUNS8veYlTx2o5Se9
	1feKqDMffrj4xcj/ilE=; b=nfMp43OvPKg9eH1vcdrAPIcAYlhRnyjwneuIP46G
	95nmc/u5yohrbiDrFUCHs6ZXEnG5EYXm/spSAwdxyXOkNvaHJ99r/HtY+iZHzEn/
	3fKvEOb+JWTFsKJpS92+tez1J2hGKS2ej7F00zGeKqCtTHM+7bnyz20x4k/2EgyJ
	EIrLrDC1ONnIwrzo1Q7H/ljKWZjcN0DIDydUF3RvLlpn/fi240m/I+QVmzv0Tgvz
	mjndNVO19zI2XiJVyfemN9TiyOeibZfO6gxfohI0Dn2eRQb61gfZ6hVcBmULUZ/S
	SqLtMmQMPufxo/jv5e5PRFf1Wjl/+1Oy5FYxWBOrXavc8w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kdkrny2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 20:58:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82a855dc82aso4532002b3a.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774990733; x=1775595533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HddPcSAbUNS8veYlTx2o5Se91feKqDMffrj4xcj/ilE=;
        b=XcKyJHaZMkfrwD8wDAL2YoBzRKl2XW9fLwAwI4gt15BxRyIlVjpv8DrRYSEONrz4de
         hF1iAxngYm3BeuYwBeYd0cpq2cnlRPQbaOc5z4NbR24N64l6Oc+FMr9T4MX+RcYpgrgP
         XtZdzZpdqrIifSJQLIrVXw3SE7WSwCRcJ89yWWtHeSws1y3RyWclUgt8v8xMBjrRpDa+
         2fvr1H8mOts9fxtwK8YeIUOfcyyk3GRqW+Whpz1JR71OgvM8UB2XG8tk+SSfwZqYeoYE
         sFm/zmHP6fjKcbyEWcEce7jXojH4BE2z+B1QjCRWbUw5/F7YXJ/KHzCXPec7BWpSiJB/
         8wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774990733; x=1775595533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HddPcSAbUNS8veYlTx2o5Se91feKqDMffrj4xcj/ilE=;
        b=VWCEikQCQ1r0Y5wA56quW875jr0jTBCfW/6A/j6FmGWnUijFiVKzkF30fHNwjBq+5Z
         kwNh1yOjV1mJhe9VV08FzqRmYpHKai1XCgTOp6bPfdAhBdsfghP4/s9cJR0jx9RNXObt
         0SNT/ByxI/aQyuU4BMRRTwvwOqtvzorpCmMG3NJYpLQC515v2DzKoyJaXzrEejvdEXmY
         kZv8fwg1Zm/Nj7QxndD7LGwGv9ilAm8SZdtamo/7QdGvOWaqhuCWlISUniohMaPxHCyH
         nR8U2H7WdhzbKP29ZPnp+PjWt+94FgRc931kTs2FD7/H7+mqm4zYKzpkKTKK7UygbZGI
         0bDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJnBoWaAhnUNm8PQBM6RJJYcoViUJAJhos/DCeTsoK/D/z1jq70dzWwrB4ygwbCv0Ne2WpGGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxurq7YYftGOI7a8uDxvBf8GQpV3vj4qDDndqI8r3j/QFFom3ve
	uYADhFvQnS6lDkEK6sbSG+1E83+iv2erdBXO/51zKfiSxRcCS0n8E5hbrZc14OOt1IS5ZWZTPZH
	h7g/4VfRO36vTXw6Wxhq0NRqTbXBEaIGhnoE0uaUlyizCjK4kRjdEVQ3LuQ0=
X-Gm-Gg: ATEYQzyVEwl3lgcTcTFhYlwiDWgJY0Xi4kMVJ9R5vifb0B6wFFzDM9jkGe1hoNFpOGE
	qMZW6l73dGqySd0luJYPHTGAqHCydCvmnLrxiROwVssbRRxgC23n3rqHULA4ms2iP3sdd8zALGU
	V2iU4Gj1jMg6woqudGzDB+ufDVqpbS1N17JqYJiZZRGL5dQlMkHGfFKvBOryRL49LOBcYrRDim8
	5dLsYKeCX4MdSQNP8Tu74igqEX3EuZiTrMRnjT0nWz/8RrePR3sP0B2ZofEbGPj1QikXAPP+sEr
	KJHC7OMml1qlQZzX4X4y+kFWmgzda6bk4dkiA9WLgEM/XQfbjH/QM+CwhRlymLgwtHZY+H69Y8z
	WHxbrLhJQlnmwN+k9TxIRihiY7G1goAfL2Rg=
X-Received: by 2002:a05:6a00:84d:b0:82a:60ad:874 with SMTP id d2e1a72fcca58-82ce8957d6dmr1039519b3a.19.1774990733360;
        Tue, 31 Mar 2026 13:58:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:84d:b0:82a:60ad:874 with SMTP id d2e1a72fcca58-82ce8957d6dmr1039494b3a.19.1774990732800;
        Tue, 31 Mar 2026 13:58:52 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf97abfesm10359545b3a.1.2026.03.31.13.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 13:58:52 -0700 (PDT)
Date: Wed, 1 Apr 2026 02:28:45 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next] net: stmmac: qcom-ethqos: set clk_csr
Message-ID: <acw1habUsiSqlrky@oss.qualcomm.com>
References: <E1w6AZm-0000000E54W-1F6E@rmk-PC.armlinux.org.uk>
 <9d0a529a-d065-4f46-a93b-23195a4f9727@oss.qualcomm.com>
 <acpqgpCsbo3lJs3l@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acpqgpCsbo3lJs3l@shell.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDIwMiBTYWx0ZWRfX1oaDmLTIyJch
 UggMVTkyirr696Fm/63ShB6J91l+s0WVfFf0/y77ikeYMavWWFBSqHAqjhTk6b7QxJey0RngJcV
 bVPAu5MTo32FYJzbBSnrc++gE3TNL+sZdKj1eGhvbsMq4YDgwv+ByPIFzXWf4hcQ7a99l74X8nU
 HqX6EyTbNVVZbWRJY1nqT8oY5Q+QBjsSL/PLd5+h9qiwHNZvHJ2aUwdPTkhMfdZT2mH0KKYRx0h
 kI70Y0srMNvyhl6YxwSc/N2aaZA0IL2kisPHrVUmdwLGa0ItCe0PEFSaTcCFibTtp9bi4VsUoFt
 LHBDRQSzoxyoI+a7jeQ+lrPKll1yv4uI7o/J1mkO43eCEYKTq2A+wfr+3DGLxcTfNnElyudRqfz
 4YApDONsW/j3RQS47M0h3dy7T/YFBuzDtsumbQ1bB5AI+d3AlmWAcPlF5JfJv6rhiW1wW++StpG
 mNiWOxjpi+Jg+KoaZ6A==
X-Proofpoint-GUID: 1Fez1elSMsv_Ucp7nJELSeUNMd_berT_
X-Authority-Analysis: v=2.4 cv=YsQChoYX c=1 sm=1 tr=0 ts=69cc358e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=9WimFISaW_B1XMulNl8A:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 1Fez1elSMsv_Ucp7nJELSeUNMd_berT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_05,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310202
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273743-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 83F63371539
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 01:20:18PM +0100, Russell King (Oracle) wrote:
> On Mon, Mar 30, 2026 at 01:18:56PM +0200, Konrad Dybcio wrote:
> > On 3/27/26 6:02 PM, Russell King (Oracle) wrote:
> > > The clocks for qcom-ethqos return a rate of zero as firmware manages
> > > their rate. According to hardware documentation, the clock which is
> > > fed to the slave AHB interface can crange between 50 and 100MHz.
> > 
> > FWIW this __may__ possibly differ between platforms, but I'm not sure
> > to what degree. Will there be visible impact if we e.g. have a 200 or
> > 300 MHz clock somewhere?
> 

While I had made an identical change while retesting the PCS series,
I was holding off on posting this patch for the same concern - what
if some boards fall outside the 50 - 100 MHz range.

After some digging, the AHB clock appears to operate within:
 - 50 to 100 MHz for lemans/monaco derivative boards (2500BASE-X
   interface)
 - 30 to 75 MHz for boards with an RGMII interface.

This is not exhaustive, but it covers all boards I have access to
which actually boot with the upstream kernel.

Therefore, I think using the /42 divisor should be fine as it will
ensure that MDC never goes beyond 2.5 MHz.

If a future platform exceeds this range, we could switch to something
like: plat_dat->clk_csr = data->clk_csr, with each EMAC version
selecting the appropriate divisor.

Due to some urgent work tasks, I am still finishing PCS series
testing. I will provide a t-b once done.

In the meanwhile, please feel free to add:

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan


