Return-Path: <netdev+bounces-85806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F989C662
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF86FB2483C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770CE7E0F3;
	Mon,  8 Apr 2024 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="HMCYOtqq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C57EF00
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584987; cv=none; b=Rv4bgnj0/toxMWDrJAlkB8IdyA54it2d96nLAJtWmhNw21zDXUO8iPMi7+K+x+TFTliJNvq0c6eFKirUTms5c/gYEVMPelHMQlR8OQpq8dDUSTJBh8LNAiI+tZ0nAAJAzIMFDGSht7I11yg7vperyJIuUeGczaNwrSBu4O8QjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584987; c=relaxed/simple;
	bh=SPL/RuvreFBIc/hq3vmehwJw4v8MdeWHZWJE2rTdQoo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OYXU8YJzzPqstnGtMZUTZCzgFZUjtQ/fO3E77KmjVd6UL2SGWfzvPUjme9qXaqxyK+rtVuUGYankswbwwRGtQEFDqqM5XmZfrdBG7+rIe1aMfDHc/YU7gpL2IEBWve3WblwTPDi3+H2yiRfJ6KBvgqnuDH9wCy/0qQVtBRMMfB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=HMCYOtqq; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.17.1.24/8.17.1.24) with ESMTP id 438A2BLP006821;
	Mon, 8 Apr 2024 14:41:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	message-id:date:mime-version:to:cc:from:subject:content-type
	:content-transfer-encoding; s=jan2016.eng; bh=7Eyxfg+2r+IWAkIgnb
	0AmbwmBnq1a+2n+rNJjprl1WE=; b=HMCYOtqqv67HVD732JKUGa6uaQJizTj0c2
	LMeIV1PuGDrqqGDEVsXD7DesoOdDFUGqgCfYTLEPUq6oqi40J9UYUWGgRP0Kpro5
	JQR4EnbiQSEpz2WamMp4dfSKAQTdHkHItLq+l7RLA/iSG87k3f9IkaInRoqToyQB
	4kGhkFfUu5F0HDQEWInb1sd4N/NqFsIyGg+qaHGYQaUob23GhTsJIsQEi6544as8
	wbL5x2Cx69aiv+2R3dh7prGAEnHv3jZ9lrBXG2a3b/ZGpWVZKL1se+B/lRIGSU0I
	mKboCiD/hVrrvz3HclmGy6Giq2+vXlRg3ZpNoWGtoOR0pDKwVVEw==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 3xcef5ju4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 14:41:38 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 438CvNm9031128;
	Mon, 8 Apr 2024 09:41:37 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 3xb1qxcyds-1;
	Mon, 08 Apr 2024 09:41:37 -0400
Received: from [172.19.45.83] (bos-lpa4700a.bos01.corp.akamai.com [172.19.45.83])
	by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 1EE1664BD6;
	Mon,  8 Apr 2024 13:41:37 +0000 (GMT)
Message-ID: <c42961cb-50b9-4a9a-bd43-87fe48d88d29@akamai.com>
Date: Mon, 8 Apr 2024 09:41:36 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: saeedm@nvidia.com
Cc: netdev@vger.kernel.org
From: Jason Baron <jbaron@akamai.com>
Subject: mlx5 and gre tunneling
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_11,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=872 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404080104
X-Proofpoint-GUID: oCrdEsPpMRiCoUSof0yUFhbvdDf9Vdoa
X-Proofpoint-ORIG-GUID: oCrdEsPpMRiCoUSof0yUFhbvdDf9Vdoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_12,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0
 mlxlogscore=700 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404080105

Hi,

I recently found an issue where if I send udp traffic in a GRE tunnel 
over a mellanox 5 NIC where tx-gre-segmentation is enbalbed on the NIC, 
then packets on the receive side are corrupted to a point that they are 
never passed up to the user receive socket. I took a look at the 
received traffic and the inner ip headers appear corrupted as well as 
the payloads. This reproduces every time for me on both AMD and Intel 
based x86 systems.

The reproducer is quite simple. For example something like this will work:

https://github.com/rom1v/udp-segmentation

It just needs to be modified to actually pass the traffic through the 
NIC (ie not localhost). As long as the original UDP packet needs to be 
segmented I see the corruption. That is if it all fits in one packet, I 
don't see the corruption. Turning off tx-gre-segmentation on the 
mellanox NIC makes the problem go away (as it gets segmented first in 
software). Also, I've successfully run this test with other NICs. So 
this appears to be something specific to the Mellanox NIC.

Here's an example one that fails, with the latest upstream (6.8) kernel, 
for example:

driver: mlx5_core
version: 6.8.0+
firmware-version: 16.35.3502 (MT_0000000242)

Let me know if I can fill in any more details.

Thanks!

-Jason

