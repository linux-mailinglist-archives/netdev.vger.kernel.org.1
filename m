Return-Path: <netdev+bounces-119752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2FD956D3A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2771C22C3F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292881741D1;
	Mon, 19 Aug 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kgtr1+9s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BEB173335;
	Mon, 19 Aug 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077749; cv=none; b=oNsatn95AOMRNiAp9pMjjiKhsBT8ZT7oiG8mZ2yQT6fICNv2PR4utbhRqoNakTzoLxqEgCwdIJHvjPBEIJOhN20oBaDL3KF5Z6UzTLm9odaQOOe9sqYcOrFbmvVojkXKFVyriNRhJHIX7ORctQwKrUE8f92oDsbpLm3jE0+pJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077749; c=relaxed/simple;
	bh=RnUGqsHXjmzPtaPPuX71ueTb0berosZ1ANglk0h5gY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OzqKt1u4IeiPkKQqaCX4RF7Rj9K3l+P5AZPFEWqefB2pUBLpvJSOTUaykM9MuxfoJMizs+XgI08WKgaAElEi1r//qm28+Ntd3Mvrr3atqpKtG/9zJE7kp0tiODn8zLGMsWF63xbHeM4N6C+xY53GMtbRBP9lffKefxm2H+QW6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kgtr1+9s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JBVWxJ006603;
	Mon, 19 Aug 2024 14:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RnUGqsHXjmzPtaPPuX71ueTb0berosZ1ANglk0h5gY0=; b=kgtr1+9sCei6+Sci
	zbDjNfv7eGCvb/+lwVPX/ruaO0DMiVRmyDqxG77pXzqDJpjR01/qLUl3GEXn7RY4
	aiSq9buS1cyzJQMQP6jaVQ7zFRdLi9x1/wO4cFjO+ogbJNE2hzuKTSO+Jhg6E8s7
	3Rn35cDEOhefJkpe9RYu1mf7Hw/ecDWPwrj2RsLkysDQhgETiNEDJYqxpqx6wz9F
	hUKrdh2PHiB0KH/U/QzEz78EFNvgKH3NsF8LIJfLZxoB2RwNN1Qmw8X1nz705hqf
	Z7emNcqO/gZ9XC2KU9dnDOVgobXvnLlzOp1D7j8Ly4U8+pIwCB4vstbBeXagqyYx
	aX3WtQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412mmemd4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:28:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47JESsfT014355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:28:54 GMT
Received: from [10.81.24.74] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 07:28:53 -0700
Message-ID: <bbc26eb0-973f-4680-aff1-2be2f598a963@quicinc.com>
Date: Mon, 19 Aug 2024 07:28:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] appletalk: tashtalk: Add LocalTalk line
 discipline driver for AppleTalk using a TashTalk adapter
Content-Language: en-US
To: Rodolfo Zitellini <rwz@xhero.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann
	<arnd@arndb.de>, Doug Brown <doug@schmorgal.com>
References: <20240817093316.9239-1-rwz@xhero.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240817093316.9239-1-rwz@xhero.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IjnG0bMvwOyH1Sk-aXGKU9xGpOvcn6fT
X-Proofpoint-ORIG-GUID: IjnG0bMvwOyH1Sk-aXGKU9xGpOvcn6fT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_12,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190096

On 8/17/24 02:33, Rodolfo Zitellini wrote:
...
> +module_init(tashtalk_init);
> +module_exit(tashtalk_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_LDISC(N_TASHTALK);

missing MODULE_DESCRIPTION()

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
are left, so please don't introduce a new one :)

/jeff

