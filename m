Return-Path: <netdev+bounces-55762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB7C80C2F8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9131F20FBF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B1D20B3D;
	Mon, 11 Dec 2023 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n/U1TyWd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E3CE5;
	Mon, 11 Dec 2023 00:24:47 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB8NB9R019459;
	Mon, 11 Dec 2023 08:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gLoT4EHLyr2L2Ls5BVhuMg9//YLibSwObknd5HM667E=;
 b=n/U1TyWdY84Kp8lzecTr3pt30qOmKtEegHA9d1yt40+BWvAfsgp2BrL7DcEQBdNxLS6N
 bI/o2WWO2dMEYSBorVwgz7mKnygBjxh3CrydHxoCn8Q5u5sdnn9VfzawSJnp2Kh1GQmC
 FhRRT06mNsAc8Vr1Pf5pKAGnK2sWNiyLlKGIa9x/EE01cb09ME8Ssz7qBiZub+T2fruu
 Cth+W4cwJb+Vf+uN1CipMjbFsEdKt9fUQ7/sPZWy/osSZOAuH214ygKJFuwVf7TzHDpK
 P2afq+hDdPuG7dF2C5pak/Ko/zzqHmwv2YzQckEkFPASIQkgvJxtXvAfVbDnouwH2PIS iA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uvtckbcda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 08:24:39 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BB8OcHd025040;
	Mon, 11 Dec 2023 08:24:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uvtckbccv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 08:24:38 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB65Mtc004390;
	Mon, 11 Dec 2023 08:24:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4sjypku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 08:24:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BB8OY6313959900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 08:24:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D84720043;
	Mon, 11 Dec 2023 08:24:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3808420040;
	Mon, 11 Dec 2023 08:24:33 +0000 (GMT)
Received: from [9.171.1.164] (unknown [9.171.1.164])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Dec 2023 08:24:33 +0000 (GMT)
Message-ID: <5094518a-1d60-48fb-aaf2-dd811296e53a@linux.ibm.com>
Date: Mon, 11 Dec 2023 09:24:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/9] net/smc: define a reserved CHID range for
 virtual ISM devices
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
 <1702021259-41504-6-git-send-email-guwen@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1702021259-41504-6-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EVhb4zYMY8FUuDI7Oy5BaxgfZOS-LqyJ
X-Proofpoint-GUID: khub9aJD6MQNoRW7EktZwPl9YHoFkeXJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=714 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312110070



On 08.12.23 08:40, Wen Gu wrote:
> According to virtual ISM support feature defined by SMCv2.1, CHIDs in
> the range 0xFF00 to 0xFFFF are reserved for use by virtual ISM devices.
> 
> And two helpers are introduced to distinguish virtual ISM devices from
> the existing platform firmware ISM devices.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

I've sent you a Reviewed-by for v3 of this patch. Did you lose it?

