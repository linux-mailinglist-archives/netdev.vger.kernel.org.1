Return-Path: <netdev+bounces-78112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B648741D0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5505B1C21276
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716218EAF;
	Wed,  6 Mar 2024 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tfHsvGsG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B311AADA
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759815; cv=none; b=npGCsViqageISwIi9AK7SK2wtn7PwnYzSISdxxpVF71bXdEDoKqCmgqd+aodaAavmRhm1RGOh9+WDpXXbSxIBUWmPc4CfG+/m3enqbwftXZy4PUpsvwqkB6ZbHdwC28EGZEzX2dHFSzAWzYM6ruaT9ADEmT6e5AamqNBQ33Zh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759815; c=relaxed/simple;
	bh=OnZ5vyu4vN5BkfM/wtWxr6WhPsmkIv9N7GEky9YFOsY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NfZ6lZ4SQUSxgsLNdPg5Z3/yYNK/yWKwOvrSa4gokvZfaHAUSC2+/J3Pri6Sw0eSRienScwEF5LrgZKIcm6aLhkOd/vY0GvnzWuyyTx6dE88cPZDCf/tlfQE8GL/oF5MSzK8pAH+YA6l7FUNlZwvbQtx9KrYP7c9OklWKhwPsQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tfHsvGsG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426LGY8f022450;
	Wed, 6 Mar 2024 21:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : reply-to : to : cc : references :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=iMTun2mhR9AIqLoXd57RQbF9tDcu/+1ybQzUhfdqYnM=;
 b=tfHsvGsGXxUXfz3sdATkO1EiO79diiZRJXZQ16G+HRIY9/xLC912ITK5mdwGmUANDX58
 JwEvOj0nKIB8Js60C4Ar/rMhDB2/kufFaIcss2JHg3LI242lKiH3Zb2hHjk3H2IIe02F
 w191NbmBO9+fcIH+BIZuWy6h9YXHfGjd/Eebx8z0dlE98tZ7SW01neRAfXYlrsYqcGaF
 IWGX5HS64/E7dho8clgt1nIMTGi7XJ+e/zDkT32ZUwR/osYX3VaS5dPoN/vMCv+DckYe
 2hNyRFCTWjNMe1vRkHBVwcBn9ytiyshjnp6Xg0WZ1FGh8obQcVOTmzAqW3NvQHRxHFGi 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq016rbnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 21:16:43 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426LGb8J022618;
	Wed, 6 Mar 2024 21:16:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq016rbjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 21:16:41 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426KsujQ006063;
	Wed, 6 Mar 2024 21:13:15 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeet9kkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 21:13:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426LDBvB26083928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 21:13:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9D4658064;
	Wed,  6 Mar 2024 21:13:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A15AF58057;
	Wed,  6 Mar 2024 21:13:10 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 21:13:10 +0000 (GMT)
Message-ID: <917ccece-42f3-40a7-b3c7-fc30a3f9bc84@linux.ibm.com>
Date: Wed, 6 Mar 2024 15:13:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thinh Tran <thinhtr@linux.ibm.com>
Subject: Re: [PATCH v10 1/2] net/bnx2x: Prevent access to a freed page in
 page_pool
Reply-To: e3bdd081-8c81-4c23-b822-091d3f122afa@intel.com
To: jacob.e.keller@intel.com
Cc: VENKATA.SAI.DUGGI@ibm.com, abdhalee@in.ibm.com, davem@davemloft.net,
        drc@linux.vnet.ibm.com, edumazet@google.com, kuba@kernel.org,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        simon.horman@corigine.com, skalluru@marvell.com,
        thinhtr@linux.vnet.ibm.com
References: <e3bdd081-8c81-4c23-b822-091d3f122afa@intel.com>
Content-Language: en-US
In-Reply-To: <e3bdd081-8c81-4c23-b822-091d3f122afa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zPryqBis9l3FJrfOZqoQkVLCI4V4gNcD
X-Proofpoint-GUID: nt4EwD2C7bTcI-Fo89Ic3kxmhk-RQMW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=911 spamscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060172

Apologies for the delayed response. I did not receive this email and 
some others in my mailbox.


> Doesn't this still leave a race window where put_page was already called
> but page hasn't yet been set NULL? I think you either need to assign
> NULL first (and possibly WRITE_ONCE or a barrier depending on platform?)
> or some other serialization mechanism to ensure only one thread runs here?
 >
> I guess the issue you're seeing is that bnx2x_free_rx_sge_range calls
> bnx2x_free_rx_sge even if the page was already removed? Does that mean

yes

> you already have some other serialization ensuring that you can't have
> both threads call put_page simultaneously?

The callers to bnx2x_free_rx_sge_range() are under rtnl_lock(), which 
should handle the serialization.

The crash occurs in the bnx2x_free_rx_sge() function due to accessing a 
NULL pointer.

799  static inline void bnx2x_free_rx_sge(struct bnx2x *bp,
800				struct bnx2x_fastpath *fp, u16 index)
801  {
802	struct sw_rx_page *sw_buf = &fp->rx_page_ring[index];
803     struct page *page = sw_buf->page;
804	struct eth_rx_sge *sge = &fp->rx_sge_ring[index];
.....
810	/* Since many fragments can share the same page, make sure to
811	 * only unmap and free the page once.
812	 */
813	dma_unmap_page(&bp->pdev->dev, dma_unmap_addr(sw_buf, mapping),
814		       SGE_PAGE_SIZE, DMA_FROM_DEVICE);
815
816	put_page(page);
...
}

This happens because sw_buf was set to NULL after the call to 
dma_unmap_page(), called by the preceding thread.
The patch checking if that page in the pool is already freed, there is 
nothing else to do.

Thinh Tran


