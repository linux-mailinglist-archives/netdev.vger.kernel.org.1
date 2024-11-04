Return-Path: <netdev+bounces-141678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 949689BC04F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F184B21666
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617B114B94F;
	Mon,  4 Nov 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QgU7/hby"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720E18EB1
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730756989; cv=none; b=BLOXwdbkHzQpLqSYY5PVLQMc9V8SAIYM9jzAZdXBe86zp3R3aCfutE1IpvkM1/40TYzIu0nvgB0chcgfdlM4ZJ9ZmyRETRMJ11bOAtQWvIHpMldlDoSpIZzGujdck3ejX5x2wu3+poNXaygusrcl6ipseJMlNbX9zf1SfCdL9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730756989; c=relaxed/simple;
	bh=PNuive4qDzEH9qPKabI0CrYIrpMPbbsd/6genzF/HEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fhL+Hltbo4m6hNDq37bSoGoaG6Rp9TeQcAKEmgTaX3rHeQDV7SWv30qYfHFlXiAl6sJOKrB8l8oufSXqiaYvD31EnoZv1583m61bFS/11McTjfSFxCE7+73U7PSUXUqiSkfbpXVpHYqKjYpZL0CL4qlRGS+XY4pdflj0c1BKxfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QgU7/hby; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4LIoAM021589;
	Mon, 4 Nov 2024 21:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hdewSeTalDhtOcLJsoqnljsUr3/ztd7Lz3JXE3vL+X0=; b=QgU7/hbyqCQQYFxZ
	4JVW0m6daLV78oA0mqQJJ1Lsf5t+p7xLsOcoQlFwf6gPlex5kBH4ZIXMm2yJlO/o
	UF06dKN983NsXXM0y9ievvPGdNfBXPqU5uKIOBZLOAo+coVCvxeXt2eihf81zW/y
	j8dI45HYfB9Pt67gFRfHF67gy0YJE+fMKgN9VJqdN+ud6YLztE/jzOUkB1jtuA6e
	11cbOEeBInHd4u54muW1kOLfbCtjysIHc0Q0mRy/bTg9tYMy6IXG1ZbNexjaTEpc
	OciLrN1ZJamKIr8SapJtSg0fL0HzgDx6FyDIQD4eW6A52UHvHcD9iiyx1KbpLBSp
	5ZOE9Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ncyxwgyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 21:49:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4LnB35000548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 21:49:11 GMT
Received: from [10.110.8.191] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 13:49:07 -0800
Message-ID: <f2de77a4-d457-40d6-9651-66c2b24af378@quicinc.com>
Date: Mon, 4 Nov 2024 13:49:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: stmmac: Disable PCS Link and AN interrupt
 when PCS AN is disabled
To: Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Serge Semin
	<fancer.lancer@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Simon Horman <horms@kernel.org>, "Jon
 Hunter" <jonathanh@nvidia.com>,
        <kernel@quicinc.com>
References: <20241018222407.1139697-1-quic_abchauha@quicinc.com>
 <60119fa1-e7b1-4074-94ee-7e6100390444@lunn.ch>
 <ZxYc2I9vgVL8i4Dz@shell.armlinux.org.uk>
 <ZxYfmtPYd0yL51C5@shell.armlinux.org.uk>
 <89f188d2-2d4e-43bf-98f3-aae7e9d68cab@quicinc.com>
 <5e5783f0-6949-4d04-a887-e6b873ae42ff@quicinc.com>
 <bc891f4e-4a3a-4664-b52c-871d173b7607@lunn.ch>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <bc891f4e-4a3a-4664-b52c-871d173b7607@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xi3iw7wjqsh69AY8gTh4haDt0C0NFoyi
X-Proofpoint-GUID: Xi3iw7wjqsh69AY8gTh4haDt0C0NFoyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=535
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040174



On 10/25/2024 5:44 AM, Andrew Lunn wrote:
>> Serge can you please respond on the PCS support in stmmac ?
> 
> Unfortunately, Serge has been removed as Maintainer of stmmac as part
> of the Russian  sanctions.
> 
> stmmac currently has no active Maintainer.
> 
> 	Andrew
That's very unfortunate that Serge is removed as Maintainers. 

Andrew, I am not sure if you are the right person to ask this question
How can i proceed with this problem ? I am kind of stuck now. :) 

Please guide me through this.





