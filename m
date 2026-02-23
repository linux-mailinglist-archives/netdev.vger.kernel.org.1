Return-Path: <netdev+bounces-259969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGpzE8cinGn4/wMAu9opvQ
	(envelope-from <netdev+bounces-259969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:49:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E812B174339
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B2253015128
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81434EF15;
	Mon, 23 Feb 2026 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MCroSxMv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SRu0o6Zt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB91643B
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840195; cv=none; b=P0NdC3OlO0H2cKQgtfEJa980koPQVTdxdFD3U5cKkzrVAM43eVe2WLnng0A2WTQZ9shCZQtIyajr+Q1bj5Pon/eS2Ew/o71lxNUpX2nGvZ2bNE+1u29i2zRuSJEAvAgNk0PkPx74uiyLKCkzuPDjTiQmGSLZvcLflG0DK6whlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840195; c=relaxed/simple;
	bh=yyDkIDQ61djzixGblWHgmbeEGy2m2r6OjvBOtRq4sqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urX/UudAnfFgvG87ZnjDX79ffhn4ESbQ9FDQJO5kMWwGU8yAS7bYHqfeu64rmbp/S3oVF6Yv3bU/KJBY1ACDguuARVOFhArkGJ7fxk8A9E+Vznlk/DJui2qe3JQsy2z5kDXgO7M9SQ+03SSFfV7mxyKlmqcfAH36h59bMQnWbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MCroSxMv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SRu0o6Zt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8M3Zx331517
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rkJsbjgrPmHKuVtyeITCWuo6
	Qs6gxTemZ0gXWydw0S4=; b=MCroSxMvREUglMMehsXfDVNamKc0VZ2SKpcGWJ0E
	KtIeAX+q39tjNd4AxG8zfLt9aSVvhKXjUMeriw+of3z3bKy8KMHwJ5ONzmMkdZF+
	viYUPm3k+rHg4g3UnEFe1heRxC6sAMYwsdUp6JN7iEOZHXZBflhIaU7/Mb7MN3Ay
	IvnDpZz9UVH+J6N+9hv2fnsUKL6ELzl//e7qYElVE1Dxnn1GT+Nzv0Lg9JOzhAWz
	pVQv2fLokAUCp3WPaIIE0Ma6lnuxR1Ufrsarf0OKt4tWTu4br/A4fVert1QvQOsj
	4+8mcBHgYqY573DG4sdZVwiYgpG6xKVlWWGN43WC4PIJew==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf603m8e6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:49:53 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8244932b122so14367225b3a.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 01:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771840193; x=1772444993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rkJsbjgrPmHKuVtyeITCWuo6Qs6gxTemZ0gXWydw0S4=;
        b=SRu0o6Zt8WNLh/GyH+3JhxUl6Y11D4q4aCUGexvHPdZZmeGejV2OFeoqaLsr/h/8mk
         TR+2XjMhucjbneVJ/cknCrQSjBc+W9a/5mO5giR2I9o4m1jSV/A76vNGUl/Sd+dtnBFS
         Kqa5yD/Swum9v7dIE7wBYH656iXLvh4GSZuIpjFpETUpW9X6V29uwTYuGcoO+b8rGYSQ
         6NAtYeyFHYyW3nBiaFdR2gy/SMuOiqQLRuCyWEOcI6LTLsUToQlmHMX7/LGqs5Q/0S6i
         RkfkyyMydvarEDcdtViEnO6doJBjG6HdW5u7DYGcchGJTGR72vwaYjK38kuOvREnA+Ua
         YJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771840193; x=1772444993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkJsbjgrPmHKuVtyeITCWuo6Qs6gxTemZ0gXWydw0S4=;
        b=Q07upHVRVPt4g4m6UvAoaFd8tvLZrJc0r+f7SQZW7ROOiyofCObsHoSIuPOSL1kDNR
         D/sunQv6nQbIyJFnSDzRouLkmv7gds/zyfyo0FyC/PSVkKfZhyPgLFp8A1Oiea96ZtwV
         cr1xjzxJempgBOG1yb1emr4HSdgfq5pyzGj+w7lpL02h0vvmo63HNyqakUV7J2CA2W6D
         RSj6mdsBOiiM5SYupsTIqg68Y0FNyRabXGVLOd9Mqr/QDg4vOtGxsEYvarIWL/AroY5c
         xhb3NqpQd1UI9qNdcxTJ47c7y0o1+fmWBkW0w9omxVvxg4EmpG2SpFVzj1FOpSMbQIN4
         KbpA==
X-Forwarded-Encrypted: i=1; AJvYcCX9bq+Sr413Ep+yOLZLxzrrvS8ilJ81qZ6g4Olrz+ihwAQR6jZVaQJIDxzV2cWhxqMwkYCy5RA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yq4PtHoIscs2pvKt3s4S4aJf+BXVThXTAZkuAEBmVitdu4Bl
	XwBohoeMYLcq9y8a4WEy9vvfm0CX32oJJdJqU8GqiLz8RgN2N4cSbPEbJShxJMqcZMA5J8psHBC
	LrvsRT6/2atEATLATXlu3p2d48WKd6k4toUOqFEsTWhku9Smw8MMxiDTmkHA=
X-Gm-Gg: AZuq6aKLou5A/DnKJqQNiGA+wN7RfB+SCe07Ut1DWhRAbNU/QpLXTQQAyFfMCTTQXqP
	6/y/IrWknpHjkGca+eRb3Xp7L3445DMC20IP/lWg20m6cyDBkYL2TECzfn1PKKXs7eAEO6QcoQ0
	oOjCt/mQh2nskniF4AAz7dYmY5Fy/lqydaqKT6B2sBS4wH+d8fSGYN9dQHzdOWLBckeZpVrnOon
	MnD1eayp+cMEGrgm1EqFl3QLP92+gzD+znwdNeWx81CRK75GamU1kAAVKjVL77Hwp+w+hrQ3pua
	/bBumXFdpv3INeuTG4FI7zlrNajIZCIifJ7sKfBl2YsjlvNLo+z6XN4wBHNOr737q53A2Ly9UB0
	KtPBSFFBcae23rJfqzzogyUAPHTFFfrpkL9Q=
X-Received: by 2002:a05:6a00:4b4f:b0:81f:52d9:5f5 with SMTP id d2e1a72fcca58-826da8bdbc3mr6321632b3a.10.1771840193155;
        Mon, 23 Feb 2026 01:49:53 -0800 (PST)
X-Received: by 2002:a05:6a00:4b4f:b0:81f:52d9:5f5 with SMTP id d2e1a72fcca58-826da8bdbc3mr6321581b3a.10.1771840191756;
        Mon, 23 Feb 2026 01:49:51 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8baa34sm7795039b3a.51.2026.02.23.01.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:49:51 -0800 (PST)
Date: Mon, 23 Feb 2026 15:19:45 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next+previous 0/9] net: stmmac: qcom-ethqos:
 further updates
Message-ID: <aZwiuVeEAcuEnP8F@oss.qualcomm.com>
References: <aZcGxDBwfMXHbo_O@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZcGxDBwfMXHbo_O@shell.armlinux.org.uk>
X-Authority-Analysis: v=2.4 cv=XbWEDY55 c=1 sm=1 tr=0 ts=699c22c1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=M31p6wNruv26cYMHQocA:9
 a=CjuIK1q_8ugA:10 a=OpyuDcXvxspvyRM73sMx:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4NCBTYWx0ZWRfXy3buMMmbONGH
 XEuxz7/V9WZDbtRqvyZgZeKT4pJHNbNiwZFUxpKLum3wYdfLRJ9pKpxTwG750QqrnQ+1wk4wahQ
 RuJaLHS4Hu3U4UZPjL4CnKUL4mxvhciQy27s1y4XgqNELxqDsnB17c/b75wE1em8UMKoQvDHKx0
 upJhe5Q5Zz+Yj0+WJEU0nAxGau8/1CkiUU6Zy1PsOeFpNyyvQcGknGOBAppfHhQJRLeKyUvxYWz
 3qJj5WVkvrXt39jz/U+jITiqhwWXxEsVND0N0qVO/2QGiLKH1V3ya8NJbSg10RNHUBiy1Gv6vUf
 HPr7t8hnJWeiNYq8nqP1sBpewC/o6WVUK+oDCFAFrn3x5lctiY543a0BJ4Ng1xUpxqaEkR9znfQ
 ILWw3mNzlfYfJxfaR2WuR0WXnMUbA0Vclk7JItdqA4g+a4gqZ+j0tFXpU92Khp7SYpFAQqHMHrS
 lBU0Fi6npMvZ3caffqw==
X-Proofpoint-ORIG-GUID: ckEZ43n3yciOx7bmgjtbYUieh1lTkvbr
X-Proofpoint-GUID: ckEZ43n3yciOx7bmgjtbYUieh1lTkvbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259969-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E812B174339
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 12:49:08PM +0000, Russell King (Oracle) wrote:
> This is part 2 of the qcom-ethqos series, building on the previous
> series which can be found at
> https://lore.kernel.org/r/aY0aJppQWUC52OUq@shell.armlinux.org.uk
> 
> This part of the series focuses on the generic PHY driver, but these
> changes have dependencies on the ethernet driver, hence why
> it will need to go via net-next. Furthermore, subsequent changes
> depend on these patches.
> 
> The underlying ideas here are:
> 
> - get rid of the driver using phy_set_speed() with SPEED_1000 and
>   SPEED_2500 which makes no sense for an ethernet SerDes due to the
>   PCS 8B10B data encoding, which inflates the data rate at the SerDes
>   compared to the MAC.
> - allow phy_power_on() / phy_set_mode*() to be called in any order.
> 
> I've included the set_clk_tx_rate() patch as that was tested, which
> would make applying this series awkward to apply without it.
> 
> Mohd, please could you test this series - I'm hoping it will pass with
> flying colours as there should be no change to the order in which we
> program the hardware. Thanks.
> 
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 52 +++++++-----------
>  drivers/phy/qualcomm/phy-qcom-sgmii-eth.c          | 62 +++++++++++++++++-----
>  2 files changed, 68 insertions(+), 46 deletions(-)
> 

After changing phy_set_mode() to phy_set_mode_ext() in
dwmac-qcom-ethqos.c, no issues found on:

  - QCS9100 Ride R3 (AQR115C PHY, 2500BASE-X) - 2.5G/1G/100M
  - IQ9 EVK (QCA8081 PHY, 2500BASE-X) - 2.5G

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan


