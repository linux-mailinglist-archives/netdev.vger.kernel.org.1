Return-Path: <netdev+bounces-84632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300D6897A65
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 23:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537F31C217F2
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 21:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17C155A46;
	Wed,  3 Apr 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qt0U+NED"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67A314C5B3
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178475; cv=none; b=IA5WyCZ5hIjm3wyrXECSIwzgziMFrt4FnK5WLPPJX9EbBItsnUCF4My/rp58O2urYfT4zWID0p73NZJUDZRb5e/mSEFJOilc0G1Ju1oZEk05n/tPQSRGMVlodOlX9xRHqMrNVEZxf2loBMUzfDCm5rcDqpjnqhfVovGoJ6GUjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178475; c=relaxed/simple;
	bh=NAxXbTXljNe/Y4q6CRTIL8DlcLQmJZ+JPq3gNq41ALY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d497gI5mdsqkQZ1MwpVUB8QrATvraSfLfYTc3Aui0iCQWadqByB5/uXwBZNs2pIA4QsyvyZ+sMRrmv6jfMU3lGyaisyFJClLaaDgTwcChNizpPF7zlZw9lAC0JZfcxaUJp5cT+P1YhSEsGhFGhNj2KHpdIVXIrWfsz3f2J+I3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qt0U+NED; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433L29xh028503;
	Wed, 3 Apr 2024 21:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zu6US5qxrh9nqrNa72Oe1aQZi4GvXffEloGNo21Ijys=; b=Qt
	0U+NED6WBW9JHrh5tCGPGFq93+qmp+/MW3nEvVgCZfJQKRDWQ1kO6p2ngB+KbI19
	IxLMlmBaJSOkkDPdqgyNOSsobLkgcDJ0jdwHAry7nVC+boqTXN3vMUzPyfbbBUVw
	8ZfYSVzs+vlhbB4NLgoODoA6bXi0NWd2AVhN8j9GziNicEzhzobnBaSL3gFyDKzI
	6LQMI0SCDuOk5ldbCx2NIDq9uiEiHGEcA3rjGXH7PeYVCw113kk3lmtNh2srjf1b
	lHicbTxAzofs5rXX0Zs9Pkc6EgEFp0CpgrVI89WYjqr/a2dJefCCThcBgbm3ELvV
	aCPc3hgQTAarsW4xS+VA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9ep3r0b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 21:07:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433L7fuR004834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 21:07:41 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 14:07:41 -0700
Message-ID: <9ec98f94-94e1-4a72-9dbd-31ac95e13f06@quicinc.com>
Date: Wed, 3 Apr 2024 14:07:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 05/15] eth: fbnic: add message parsing for FW
 messages
Content-Language: en-US
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: Alexander Duyck <alexanderduyck@fb.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217492560.1598374.8486151971412546101.stgit@ahduyck-xeon-server.home.arpa>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <171217492560.1598374.8486151971412546101.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pa7OjcD_xFQEiPwb2H4CI2A-CY1psrGh
X-Proofpoint-GUID: pa7OjcD_xFQEiPwb2H4CI2A-CY1psrGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_22,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404030143

On 4/3/2024 1:08 PM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Add FW message formatting and parsing. The TLV format should
> look very familiar to those familiar with netlink.
> Since we don't have to deal with backward compatibility
> we tweaked the format a little to make it easier to deal
> with, and more appropriate for tightly coupled interfaces
> like driver<>FW communication.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  drivers/net/ethernet/meta/fbnic/Makefile    |    3 
>  drivers/net/ethernet/meta/fbnic/fbnic_tlv.c |  529 +++++++++++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_tlv.h |  175 +++++++++
>  3 files changed, 706 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
>  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
[...]
> +/**
> + *  fbnic_tlv_msg_alloc - Allocate page and initialize FW message header
> + *  @msg_id: Identifier for new message we are starting
> + *
> + *  Returns pointer to start of message, or NULL on failure.

should use Return: tag as documented at https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation

(although the kernel-doc script will accept a few variations such as Returns: or @Returns:)

currently scripts/kernel-doc -Wall -Werror -none $files reports:
drivers/net/ethernet/meta/fbnic/fbnic_fw.c:244: warning: No description found for return value of 'fbnic_fw_xmit_simple_msg'
drivers/net/ethernet/meta/fbnic/fbnic_fw.c:273: warning: No description found for return value of 'fbnic_fw_xmit_cap_msg'
drivers/net/ethernet/meta/fbnic/fbnic_fw.c:338: warning: No description found for return value of 'fbnic_fw_xmit_ownership_msg'
drivers/net/ethernet/meta/fbnic/fbnic_fw.c:659: warning: No description found for return value of 'fbnic_fw_xmit_comphy_set_msg'
drivers/net/ethernet/meta/fbnic/fbnic_irq.c:33: warning: No description found for return value of 'fbnic_fw_enable_mbx'
drivers/net/ethernet/meta/fbnic/fbnic_irq.c:111: warning: No description found for return value of 'fbnic_mac_get_link'
drivers/net/ethernet/meta/fbnic/fbnic_irq.c:146: warning: No description found for return value of 'fbnic_mac_enable'
drivers/net/ethernet/meta/fbnic/fbnic_mac.c:1020: warning: No description found for return value of 'fbnic_mac_init'
drivers/net/ethernet/meta/fbnic/fbnic_netdev.c:356: warning: No description found for return value of 'fbnic_netdev_alloc'
drivers/net/ethernet/meta/fbnic/fbnic_netdev.c:449: warning: No description found for return value of 'fbnic_netdev_register'
drivers/net/ethernet/meta/fbnic/fbnic_pci.c:300: warning: No description found for return value of 'fbnic_probe'
drivers/net/ethernet/meta/fbnic/fbnic_pci.c:614: warning: No description found for return value of 'fbnic_init_module'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:24: warning: No description found for return value of 'fbnic_tlv_msg_alloc'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:55: warning: No description found for return value of 'fbnic_tlv_attr_put_flag'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:97: warning: No description found for return value of 'fbnic_tlv_attr_put_value'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:141: warning: No description found for return value of '__fbnic_tlv_attr_put_int'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:161: warning: No description found for return value of 'fbnic_tlv_attr_put_mac_addr'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:178: warning: No description found for return value of 'fbnic_tlv_attr_put_string'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:204: warning: No description found for return value of 'fbnic_tlv_attr_get_unsigned'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:220: warning: No description found for return value of 'fbnic_tlv_attr_get_signed'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:244: warning: No description found for return value of 'fbnic_tlv_attr_get_string'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:264: warning: No description found for return value of 'fbnic_tlv_attr_nest_start'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:387: warning: No description found for return value of 'fbnic_tlv_attr_parse_array'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:439: warning: No description found for return value of 'fbnic_tlv_attr_parse'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:487: warning: No description found for return value of 'fbnic_tlv_msg_parse'
drivers/net/ethernet/meta/fbnic/fbnic_tlv.c:520: warning: No description found for return value of 'fbnic_tlv_parser_error'
26 warnings as Errors

> + *
> + *  Allocates a page and initializes message header at start of page.
> + *  Initial message size is 1 DWORD which is just the header.
> + **/


