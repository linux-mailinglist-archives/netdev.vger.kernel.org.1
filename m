Return-Path: <netdev+bounces-88597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5C8A7D82
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1A11C2187A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C66BB58;
	Wed, 17 Apr 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T8MzooU/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A133CC2
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340585; cv=none; b=Fhj2wVaBKinAipLtkKgGloSymHLX+cH+3ou5HfUgLiP+7OZRBb/w3TwvJMd0mUdSBRJhDWmzGiZIsedCBZJKEGdAeG4DBErbhsa5DY8beu6LvowqUipQj19ZBRNWPdarmPY9Z/jpxxD0Qzy2PaaKKS0E2GI909vu0DPdu7BeEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340585; c=relaxed/simple;
	bh=YRKz+eaCnGRkkjWwBW2DsvN1uEF9FKwfVnKQlySSOdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWk0OxPMiDPeUM1+zJrtIY3DP3zeavuVUaBIveAay6ieUyQNC0xP6hSeJljvSL6Foj0o/jmFgY3l9BaFaap84mT6a7LfkpWnOzXr7+UfCxAZyadmYjyfkTj1VZF7/4NvJ7l5PdJmsazZKT7xvoxwD766Gz219kauZW5EFqPaLdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T8MzooU/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H7i19s006365;
	Wed, 17 Apr 2024 07:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YRKz+eaCnGRkkjWwBW2DsvN1uEF9FKwfVnKQlySSOdM=;
 b=T8MzooU/9b1LVLq0M5bGe/OQ1G9LUM9f/I44wwnrrhlmx1GOlQ0r1nD0O9gNDYi/Uwie
 m0VM+cXwCAuSRjftwFY7cE69MCD3gdtm4spBfmAXKOKh6hJgCNqANY40eM2f9EAG4uNQ
 SjJBi/1NjpcF2gRNokZgnrrFeab/cPejaIxLSDbAT+b6KY1u5Od0sk7Mda9K3K5SHxQA
 yWqAcLGjyDjXZrWaU0AwnIQiLRIdpGTudEc3lobtu3VTrxZMc+9md2YqsEV0Yfo0v0wR
 Q+SiLtLOh+X4Py1LbEK8T0WesbQ39bsr/0tvhlxeqf/ypoaAajODJipz30idkNiLILLp uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xja9580yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 07:56:03 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43H7u3IQ024814;
	Wed, 17 Apr 2024 07:56:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xja9580yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 07:56:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43H5VHtw023632;
	Wed, 17 Apr 2024 07:56:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cp32et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 07:56:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43H7twi847841582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 07:56:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 937D72004D;
	Wed, 17 Apr 2024 07:55:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 400AF20040;
	Wed, 17 Apr 2024 07:55:58 +0000 (GMT)
Received: from [9.152.224.141] (unknown [9.152.224.141])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Apr 2024 07:55:58 +0000 (GMT)
Message-ID: <584f28ff-597b-4ab5-b363-a5f142905fcd@linux.ibm.com>
Date: Wed, 17 Apr 2024 09:55:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool-next 1/2] update UAPI header copies
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
        Michal Kubecek <mkubecek@suse.cz>
References: <20240416203723.104062-1-rrameshbabu@nvidia.com>
 <20240416203723.104062-2-rrameshbabu@nvidia.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240416203723.104062-2-rrameshbabu@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FLyrrRAHXKitcZVw0TJOcCqKt1sObvhD
X-Proofpoint-ORIG-GUID: IiO_bQXCYxEIv9vBNKsQzFB3aKH4ZbzG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_06,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1011 mlxlogscore=941 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170053



On 16.04.24 22:37, Rahul Rameshbabu wrote:
> Update to kernel commit 3e6d3f6f870e.

Maybe a user error on my side, but I cannot find a kernel commit with this number.

