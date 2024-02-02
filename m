Return-Path: <netdev+bounces-68430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C75B846E13
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E6D283C70
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856E4128808;
	Fri,  2 Feb 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="k/Utnrfc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB637D3F2
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870149; cv=none; b=bcivSeXitxsUIpC3eMMEGhp8AGaBkVRwUFEyLWpzUC9/fH5G9T/cpHG1iJVaR/ByDSjZ290GKUo6EdFVm6yAh+UzaoyX1kW9EFKUdkP7yppbzz9uWcTWYu4IAUiU5ZpW82ov4rd14Aj0n1O61QfqQDCunR3Mr5GoJCFisTVdfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870149; c=relaxed/simple;
	bh=XEpjcEhzA4eb5qPn9/+aqYaql/x0knaC8EPd3FUMS08=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lr4d5KCjmuuIjcEc6pBz8EoVXu6+Hg6y7TWHf7y/eGh+INLrfoN2lwrV1bA2zqFt/c/Q8Bt0UuDDmdldXZWkzHIJBkZF4Gf1qWr2S2tsgLbkekn+pxqDNdB39mjkY9RqDhgFm9mjrRlKn830M5F2D3Kg0gJtrz4RhLL+AhYmEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=k/Utnrfc; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121WCcc011487;
	Fri, 2 Feb 2024 02:35:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pfpt0220;
	 bh=5Wz5mjtQYM/Vf0bD1vylL78L3b94yc8bwYnXfFIApM4=; b=k/Utnrfc0jsa
	/goh04ewBTlnB10JoyVtTPnHis0Y15vUTbsx8LVyJehiOO2T7tQ2OocnYlPiXYgd
	jxxJONtZ81U7UpPz1unJPhq6gpSpkHOfT7pJMIJJH8w3LY30af0shyNG8u5XGJn5
	ocCM87ac4mNEoW1E3M1A2j36LAAkI/ijIXYa4hnhoiXtlVuSHE6ju5fOBSM6RqPB
	1aYPgOyOW/KNKcGYx5KzgQmxKtedDQymdbPpzZziWmi+ot+8xx+ZVna6xQYnwWwu
	C1KpM5JwVROX0SqOQ2H5rdpQDuFvQQUdxsTCKjvaBBljEpNrwJPh4tNon5g2rpcE
	q1Jj4ypEIw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w0ptnh9p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 02:35:21 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 2 Feb
 2024 02:35:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 2 Feb 2024 02:35:19 -0800
Received: from [10.193.38.189] (unknown [10.193.38.189])
	by maili.marvell.com (Postfix) with ESMTP id 065463F7084;
	Fri,  2 Feb 2024 02:35:16 -0800 (PST)
Message-ID: <b0cf8d1b-1bd6-b7ab-006b-896285c65167@marvell.com>
Date: Fri, 2 Feb 2024 11:35:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
To: Peter Waller <p@pwaller.net>, Jakub Kicinski <kuba@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Netdev
	<netdev@vger.kernel.org>
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
 <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
 <20231127145945.0d8120fb@kernel.org>
 <9852ab3e-52ce-d55a-8227-c22f6294c61a@marvell.com>
 <20231128130951.577af80b@kernel.org>
 <262161b7-9ba9-a68c-845e-2373f58293be@marvell.com>
 <e98f7617-b0fe-4d2a-be68-f41fb371ba36@pwaller.net>
 <3b607ba8-ef5a-56b3-c907-694c0bde437c@marvell.com>
 <e8739692-89ea-40e7-b966-bbb4ea5826af@pwaller.net>
Content-Language: en-US
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <e8739692-89ea-40e7-b966-bbb4ea5826af@pwaller.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S5-HK7imYfB6IfQl-0-RjeBOG2J4j5LD
X-Proofpoint-GUID: S5-HK7imYfB6IfQl-0-RjeBOG2J4j5LD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_04,2024-01-31_01,2023-05-22_02

Hi Peter,

> I've been running with this for a day or two, and had a panic on resume 
> today, dmesg below.
> 
> - Peter
> 
> [65525.454687] atlantic: Boot code hanged
> [65525.561024] ------------[ cut here ]------------
> [65525.561026] hw_atl2_shared_buffer_finish_ack
> [65525.561042] WARNING: CPU: 8 PID: 797385 at 
> drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c:112 
> aq_a2_fw_deinit+0xcd/0xe0 [atlantic]

Unfortunately this seems to be a different issue, HW related. I suspect you have ASUS labeled NIC or MB?

Driver is reporting here it can't not activate device and firmware is not responsive.

There exists a BZ:
https://bugzilla.kernel.org/show_bug.cgi?id=217260

exploring a similar problem. It has some workaround patch proposal, but its questionable.

Igor

