Return-Path: <netdev+bounces-54800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 481FD8084B5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17B21F22712
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 09:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20C7341BB;
	Thu,  7 Dec 2023 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iZmOAy4s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885F410C6
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 01:30:16 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B79PGOV032074;
	Thu, 7 Dec 2023 01:30:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=+qPNSczPgt2Ff288JWIjNavkZrtmWGKZuOHOjuynf30=;
 b=iZmOAy4s5ANNBRH1I1hbX37G88gQSGXiBHqIZHLuJkF3RPfAb6DpG/+cnY1ddsauK8CV
 zMISIYKK/bs62diOIO0vO8FF6glskmorCDd9rVw+mIVif0/qfvlhR2nGeuLcGT70ONKy
 89rZ2OJryY+AzfpQMQTjzQEcxi2mpeYzMRneBUdPVXvt6M7tsaBwXSuMPIUQ9oIO+UvN
 rLBVwMA3Fu5lvr6QavLZfYY/btA9nebCBbvcdXQLLEPS+TCmKW49oTkfdQXOlfTyMSoO
 hZA2UmmmqVFbjmzNLuZPnpECPdm5UuNB+hdgfzcg1gwbcCBOAmwh6m8wzY6EjTWATPgp Pg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uubdd80r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 01:30:10 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Dec
 2023 01:30:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 7 Dec 2023 01:30:08 -0800
Received: from [10.9.8.90] (OBi302.marvell.com [10.9.8.90])
	by maili.marvell.com (Postfix) with ESMTP id D2AA03F70A5;
	Thu,  7 Dec 2023 01:30:04 -0800 (PST)
Message-ID: <1d592ded-a702-5be0-6617-ecfcb4c41f92@marvell.com>
Date: Thu, 7 Dec 2023 10:29:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH] net: atlantic: fixed double free when
 constrained memory conditions
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Linus
 Torvalds <torvalds@linux-foundation.org>
References: <20231204162040.923-1-irusskikh@marvell.com>
 <20231205193326.3fb93009@kernel.org>
Content-Language: en-US
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <20231205193326.3fb93009@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oRzAZHgx28abgReqvb29swFzQa_TWPxB
X-Proofpoint-GUID: oRzAZHgx28abgReqvb29swFzQa_TWPxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_07,2023-12-06_01,2023-05-22_02


>>
>> Fixed by explicitly clearing pointers to NULL, also eliminate two
>> levels of aq_ring_free invocation.
> 
> The change of the return type plays no functional role in the fix,
> right?
> 
> I think it'd make the change far more readable if that was a separate
> patch. And if it's a separate, non-functional patch, it should go
> to net-next, rather than with the fix to net.

Makes sense, will split the patch.

Thanks
  Igor

