Return-Path: <netdev+bounces-77039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D63986FE50
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0870128159C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34B036118;
	Mon,  4 Mar 2024 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hmvZ6TPa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97B250FE
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546768; cv=none; b=BTlH9KwS6uHYzriyPLao533ZAY3NUkXlC+an9LAyZjixoWJfkxKVNMD3IgXFKXrWBO9ZAC32c5CYdZAJH06OGEyA8O28R28WezGf4M3iEgGou5pmmA+7cep8IfQvsbGIkmY97sTTfispdUlOBlLNl8YhjE6P1TRXEi/V8Hc8vgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546768; c=relaxed/simple;
	bh=CvpjBivh2L+cZ9LgS2rmHT0sY665oafEk861k+bPFZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt9hdhtR/SREtG2wrByqfj06ONGoxcrtahgmM+t49GWVx5YyhNGZ6exbgNVm3fqS9Szeyuc07UCqAbBVKtG74zQAESTP1Wz8cOeQlZp6ao/82URopfbSVmI1UO+3/9Y5o829hSMyEOFKnA2BSleYR9bc4fpleKJCk1bcGaKmBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hmvZ6TPa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4249S3Rn028226;
	Mon, 4 Mar 2024 10:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GWfSuPdyCPTzSmzoAuyyLC5lbIDcUlDPW1L2P4MjdcA=;
 b=hmvZ6TPayuXBjy+mLdR0pdtHS+qsMvWpQtFwFKkPPbS/toDSsfkH3/BpdOTgo+bZq8Th
 fMf0fc3z30vCUdswxvIb+gwzE/OU7O75BW/4ju2SNAHockx6A+s/aP+dn3zCX9ItTzKx
 M1VgVIN05mbK5J7jlBTz1a8kUU5E9awis9y5dhpKTweJXHc84QUOESMhWID6u1TQaVQl
 d8uxzw3m8wvQbJZ9my+uhhEjdYOptQdC+JDOPneEu7GlJsikPX5agEhCHxrYPx/cRNDo
 wICR1WF3FmzeTRjOCvVpnMDV1uRIPwKUKtK0H8Yl95Ah6qvWcKQt8EDDAXy2xk6Ta1h5 JA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnbph1210-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 10:06:01 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 424A1HN8005738;
	Mon, 4 Mar 2024 10:06:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnbph120h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 10:06:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4248nmIq010886;
	Mon, 4 Mar 2024 10:05:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh51yb69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 10:05:59 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 424A5uks41615804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Mar 2024 10:05:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF075803F;
	Mon,  4 Mar 2024 10:05:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9995F58056;
	Mon,  4 Mar 2024 10:05:54 +0000 (GMT)
Received: from [9.171.31.119] (unknown [9.171.31.119])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Mar 2024 10:05:54 +0000 (GMT)
Message-ID: <5744b473-f655-4de2-a895-105ccd60fa1c@linux.ibm.com>
Date: Mon, 4 Mar 2024 11:05:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: reduce rtnl pressure in
 smc_pnet_create_pnetids_list()
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
References: <20240302100744.3868021-1-edumazet@google.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240302100744.3868021-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: msZgz1o33GRG4hHitm2W5qX_k1AO9ABZ
X-Proofpoint-GUID: yyQdA7qPVEWwHpxuo-42E36dIYb52bBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_06,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040076



On 02.03.24 11:07, Eric Dumazet wrote:
> Many syzbot reports show extreme rtnl pressure, and many of them hint
> that smc acquires rtnl in netns creation for no good reason [1]
> 
> This patch returns early from smc_pnet_net_init()
> if there is no netdevice yet.
> 
> I am not even sure why smc_pnet_create_pnetids_list() even exists,
> because smc_pnet_netdev_event() is also calling
> smc_pnet_add_base_pnetid() when handling NETDEV_UP event.
> 
Hi Eric,

I think that was because of double check. But I do not see the necessary 
of the function. I'll check it later if there is any scenario which 
would need the function. Before we decide if we need some clean up on 
it, the patch looks good to me! Thank you for fixing it!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks,
Wenjia

