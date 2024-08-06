Return-Path: <netdev+bounces-116012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10E1948C8F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B97F1C2273F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F751BD51B;
	Tue,  6 Aug 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TRBQw3cG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D6166F21;
	Tue,  6 Aug 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938692; cv=none; b=FW3vdPVqszLtcCEOu0SiNYAY5ECqFg6aVqL+uQVFy5RqJJMLKqHtA3Uo5/BfJ+HVPvKyvGm9QtxPQ5YfA8S7Q3BfxLJ3Bl4Ya7jqDKaM1vgAaIsFJ6eL1oP3HrXr5zGFnKU663tiwJPumChyoWswT53zIznK7wQX8yWIeWfq0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938692; c=relaxed/simple;
	bh=CHbBbDInhI9vxwv7ajOuUGTdkhQnZ6srl1aXJqEvsf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=okHqaS78nOYfDUissrIDizlKg9PcwHqBdf3q31ns2DDDonehs+DiuIeyXZBEhwxjR/yzcRfYEEeRK02+eMUVdEggNNRdRLJrjhHrDVuz2kp0DYasyzF2yAb/s+ruchyvQmsmvQgCZSw6+7hqh+2dpCD6g4d0NyCGs9nEISP31pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TRBQw3cG; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4763frEC016897;
	Tue, 6 Aug 2024 03:04:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
	q52b0RqkoMwoJM2pZd1yPQFArILO0Z6Xi+RWOWg51w=; b=TRBQw3cGgfQumRl4x
	33GiTg4w+EPBPs0vtPINAvAJLzLVXEd7Rol6TBtCvzeB1LHamOQb0ktTlCjzaHSz
	Qz2y/bltINH73P6is9wSM3NnL8nJGJ+ygbcpDuTnAhNsplULq5Rh2sVGx7iAvWbr
	tgbIYSgRU3G8dZXse+WVowlXTCcnxf4eVMVtyIszWgK+PMdD/V/Ph1lCV8uufi3Z
	B4M59TFSILD49rf5WTkyYyzwh2Dj6NNyCkt+8RWJ5wRbQYNQdpind7ftWAOWAn/w
	ePQpKGT/otgJ72NtqZbDq+wifLGc6GxyDiBePHxJx0dxQt1kcr4pwrdr9NYBqHp1
	0sCqA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40uc5f14hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 03:04:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 03:04:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 03:04:46 -0700
Received: from [10.9.8.37] (EL-LT0043.marvell.com [10.9.8.37])
	by maili.marvell.com (Postfix) with ESMTP id D0CC75B695A;
	Tue,  6 Aug 2024 03:04:44 -0700 (PDT)
Message-ID: <c6863fe5-a1f6-7bba-3f26-a1bda9141914@marvell.com>
Date: Tue, 6 Aug 2024 12:04:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] net: atlantic: PHC time jumps ~4 seconds there and
 back on AQC107
Content-Language: en-US
To: Martin Pecka <peckama2@fel.cvut.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dmitrii Bezrukov
	<dbezrukov@marvell.com>,
        Jackson Pooyappadam <jpooyappadam@marvell.com>
References: <def1073b-8997-48cd-adf3-e834662881de@fel.cvut.cz>
 <CO1PR18MB4713F904116EA5127017A3C0B7AE2@CO1PR18MB4713.namprd18.prod.outlook.com>
 <57f07825-b838-4f1a-b91c-1fd944ac928c@fel.cvut.cz>
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <57f07825-b838-4f1a-b91c-1fd944ac928c@fel.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Tqn1LhoEZB0vw-quaS8RMO_ajEJyZ-bj
X-Proofpoint-GUID: Tqn1LhoEZB0vw-quaS8RMO_ajEJyZ-bj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_08,2024-08-02_01,2024-05-17_01


Hi Martin,

Sorry was on vacation so dropped out a bit.

On 7/21/2024 3:11 PM, Martin Pecka wrote:
> Thanks for the quick response, Igor.
> 
>> AQC107 is now in low maintenance mode in Marvell, and you are right this are of FW is not well documented.
> Off-topic: Interesting, given the number of devices out there using AQC107...
>> One suggestion. Have you tried playing with -R (slave update rate)? Increasing it?
> Tried it now and it seems it has no clear influence. I tested with -R 10 and -R 0.1 and in neither case were the time jumps more or less frequent.
>> I have a feeling the fact it happens periodically and then restores has something to do with "rounding" or NS calculations. Surprisingly uint32 fits 4 Billions of NS which is around 4 seconds...
> 
> I was also wondering whether the ~4B value could be some overflow. But the following investigation shows it is most probably not the case.

Thank you very much for the logs and the analysis.
I will try to investigate more with the data I have why this may happen.

The complex thing is that parts of ptp alignment calculations are happening in driver, and then some logic goes into the firmware/hardware.

Short term, I would say, your workaround with cutting negative mac_adj may have sense, until the real root cause is known.

Regards,
  Igor

