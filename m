Return-Path: <netdev+bounces-72462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8143385832E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3686E1F240DE
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39458130AFE;
	Fri, 16 Feb 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gqnPFHeJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B01E86B
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102727; cv=none; b=owptPUVnJiliDwez0MvcVi511YSDdd1JTkkOsdz1at0e3o2fkqVD1B4ihFX18z3tsFBZSQJhv3RiVsW0VMtLECOMFM4Bh4iTB/pTsAkEc8xIDMkQ4vcw5KtqBjxREfEXtEMPVD39/SsBBd+m0grk9jUaw6PZXdfMqQhJ7Xei79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102727; c=relaxed/simple;
	bh=cpUEa6ai1cFG09U3vUgDslnNrsuDM9ngSB7aEUEiGHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YVb6GDjwh2aVjmJxRdHj9cY4lwjp/BnomzoeqBFi0QdX9+xuwwtaHqorgOwBBBkwfL3WmZnf5aleR+wD8YBcxhpofWjhnzoBe6SxKECPujZ/zo5UksLnRpZFSi6EbKw1WEyS0aBRZrqotC7g26++CQJIWWyC3Abdpv8UlvaUe74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gqnPFHeJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GF9gHW017298;
	Fri, 16 Feb 2024 16:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=alkTJLisXLDxeGDV1uSdCeVm1bbXDIbArtc02zk+hkM=; b=gq
	nPFHeJR2JpRLv9Ldbfbk61Ydva/tJEM9e4oN4JSiHs5AxdffgDSUWxi26Dz/Wb2k
	7KJ0+4G9hPFCdJMbNCv9tGFIVJfNlEFCy+mBMSQCoe2pLegqq4uIBJmppJvEert4
	Ve0MCd1SqQis5z2rEt+8v+FWZZmyfCk1nFKwHf+e7x5jOKfhP01iR1b79GHnQ16v
	9t1J/KqL73VmT7/RIuUorV2NlhwAkXhtxKReAj9DtR7GfNHKQO5M6xZW7zUDONgw
	+xvTks4TR+LHSRMsRYeeapJ9A6gv4pJnX0iM92iLpDUFCdZAXvc4T8HcuaYTdH7M
	hn1Px9B7n9clOOCw3bLQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9yta9dha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:58:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GGwcAa021248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:58:38 GMT
Received: from [10.110.53.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 08:58:38 -0800
Message-ID: <4cad6137-ac69-4253-9f45-ce51e90c081f@quicinc.com>
Date: Fri, 16 Feb 2024 08:58:37 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool] move variable-sized members to the end of structs
Content-Language: en-US
To: Michal Kubecek <mkubecek@suse.cz>, Denis Kirjanov <kirjanov@gmail.com>
CC: <netdev@vger.kernel.org>, Denis Kirjanov <dkirjanov@suse.de>
References: <20240216140853.5213-1-dkirjanov@suse.de>
 <20240216145752.aihdclrz6o53tgl2@lion.mk-sys.cz>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240216145752.aihdclrz6o53tgl2@lion.mk-sys.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e7TJDGQ89GovCRqocrURNf9DPcZILUCB
X-Proofpoint-ORIG-GUID: e7TJDGQ89GovCRqocrURNf9DPcZILUCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 clxscore=1011 mlxscore=0 malwarescore=0 mlxlogscore=378
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160135

On 2/16/2024 6:57 AM, Michal Kubecek wrote:
> On Fri, Feb 16, 2024 at 09:08:53AM -0500, Denis Kirjanov wrote:
>> The patch fixes the following clang warnings:
>>
>> warning: field 'xxx' with variable sized type 'xxx' not at the end of a struct
>>  or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>>
>> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> 
> Have you checked if this does not break the ioctl interface? Many of
> these structures (maybe even all of them) are directly passed to kernel
> via ioctl so that rearranging them would break the data block format
> expected by kernel.
> 
> AFAICS at least in the cases that I checked, the outer struct member is
> exactly the data expected as variable part of the inner struct.
> 
> Michal

Yes, it seems the correct solution is to just remove from struct
ethtool_link_settings:
	__u32	link_mode_masks[];

This is unused in the driver, and the mask-handing command creates an
ecmd which appends the masks

However this is a UAPI struct, so this potentially breaks userspace
compilation (but not the UABI).

/jeff


