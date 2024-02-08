Return-Path: <netdev+bounces-70370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F184E8D5
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 20:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FF0B2D418
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 19:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049FC36B1B;
	Thu,  8 Feb 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fju3HZl8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E79A36B0E
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419904; cv=none; b=ARdH5kC9QRsmiIK8lo8nAANA/bGlf40+DA7fbtjCUR/YbiUuQd09/w7nxyMlmHMkfMZPvQRZ8D96KifpRwd420C5gTKRjjy6YpXWsy0OhOs5SkNEQSHmbvV/1xXm/+LXAwdWlmVQTLlYMTAY8EMKSGUbUV02CT2EoMRsWcfKrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419904; c=relaxed/simple;
	bh=IGzQns2cJJtcbDHWdXXO8DdxEoNYsftMwigXt35jHgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lbh1yruUw4JF8BPyJRVow1HJZEi4K1JBHwBd8tr5Jd+9LF4TK/gCqGSnTfGoJGstTIlgRf+4D5si5XSBENBfQ7AFpnOD+KM7W2g9WZuzwF0X/hOExzef+R2RS+iRWK6W4ufn6d2N9UGTzWcXsRtesd0rhyxHP3LYj1UnOxYvNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fju3HZl8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418I2aoS028896;
	Thu, 8 Feb 2024 19:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iwA+X9wBqkmKLXeFDBlFc0iNSnUsCo8CIut4qnpQvmw=;
 b=Fju3HZl8b8351qaGaIZg+py0CwMEUc8lL5wbVZalNcxj+yM7PpkxU6apxL6nrSRYLmQ3
 3lD+hPA5FGaWfupG2MkpPByGpZJypne/3UyaBlK6K0Wcd92ptmnCL5EV5IqPW3STdHSa
 Yw3Kjf07HbI/CjTFTl40HEYPhfhZlfmkQd3nDu0xtQ9MhcRF1UOirRYb+l7AXrC6BFpA
 Zmm5ULlbyoZ5yOSobB6BBxcYBDcaywoPwObzK4ggToRpWxQcDcHKPDXZyq6LE2jP4jGC
 9Da2/QGpKXqSW+tcyZiwcSKWdxxbHpMU6OtMuuDZTuJ1H0IRjGhqvAXurXzjEpVsUoy8 qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w53vw1t68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 19:18:18 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418JC7bM021094;
	Thu, 8 Feb 2024 19:18:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w53vw1t5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 19:18:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418HwGnU005756;
	Thu, 8 Feb 2024 19:18:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akxg1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 19:18:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418JIDBr32375346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 19:18:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9A3D58058;
	Thu,  8 Feb 2024 19:18:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A1C95805D;
	Thu,  8 Feb 2024 19:18:13 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 19:18:13 +0000 (GMT)
Message-ID: <056b4e86-a894-4a4b-a8dd-81f440118106@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2024 13:18:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] net/bnx2x: Prevent access to a freed page in
 page_pool
Content-Language: en-US
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, aelior@marvell.com, davem@davemloft.net,
        manishc@marvell.com, pabeni@redhat.com, skalluru@marvell.com,
        simon.horman@corigine.com, edumazet@google.com,
        VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com
References: <cover.1707414045.git.thinhtr@linux.vnet.ibm.com>
 <90238577e00a7a996767b84769b5e03ef840b13a.1707414045.git.thinhtr@linux.vnet.ibm.com>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
In-Reply-To: <90238577e00a7a996767b84769b5e03ef840b13a.1707414045.git.thinhtr@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q4rSjmmxxfcU5gjwRuja-K4hfpkjfW8I
X-Proofpoint-ORIG-GUID: D8768QgTroqAZjvWKFULiiB7Gra7iZKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=631 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080101

Fixes: 4cace675d687 ("bnx2x: Alloc 4k fragment for each rx ring buffer 
element")

