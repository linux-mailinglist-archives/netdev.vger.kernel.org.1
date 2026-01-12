Return-Path: <netdev+bounces-248969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63414D12288
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B34BF30DC021
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381F355026;
	Mon, 12 Jan 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TGOjZIYe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A7354AEB;
	Mon, 12 Jan 2026 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215656; cv=none; b=sH896oH8/rieRJ/poWp9khwne91HcX2Bn6cankcbwaBp9si3Pz9eGOdYDkdfcWaTrKZoyYzRfXfDvATgPofmqpuBzHT/Egin0FjjO9qchVzYXzUiRIDOaWLD1WKU+XXMjyYREtOz4fsBWqgTsZnhki5kATQFJpkmNlFh+w55Xxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215656; c=relaxed/simple;
	bh=6N0w3HynyaxBFCSLVe4Xx3Rf9r05hgNoJPD8hl0l46U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VEYIVcKVMqS9mr2uDbEokRGIapCPC0iegMb8C93QBeC6TFdVtE7nKk8hVW6mQIViIiGBgf9NCXgCcKfXmEPe7ecgsIkW9YBz7dUhiYJQS847EuZesL/HIPNiueE9mNkzAyF9cFaNiu/tGWcWKI2dPp4TfYCwEiUS2QYRjqb2lLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TGOjZIYe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BLRa0Y019757;
	Mon, 12 Jan 2026 11:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2rGg7enf1xOKVJ1j/wY7QPZf7Sq+0n
	k5rlSbS++b8i8=; b=TGOjZIYe88F1yvH9WKaGzhg+CqbJF/w09gBPr7ECWRyQuo
	gxoY2BRYQ/C2A9gVO0pxT86Qn5QLULC0v8raBIZ20hx/2/L/K3pUK04oBbv5zSC2
	yLwI9msyrTBTgwX312rgM0smwkWPSM9N48e/M7JCfgZQlRXaHpNn76sjO7UVGnwC
	79b+8D6AN3kALwOfyiRU59cBpEMHvcejw3Eu/sl6q/4HsQ3DdtiC51aEzAVGt9fj
	ncmDx7IPBURIZvRaRuECrh+qh1rk2lz5SsN44CQg61a/a39ZELNafPHi5H8EVNl2
	G39i05NWgxPrd6MVURr48jEyMh4UnRtHfaIFOzqQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedspckw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:00:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CB0YWh010584;
	Mon, 12 Jan 2026 11:00:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedspckk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:00:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C9IV8m014274;
	Mon, 12 Jan 2026 11:00:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fxwkcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:00:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CB0VoD40698290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 11:00:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B99662004B;
	Mon, 12 Jan 2026 11:00:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84BB920040;
	Mon, 12 Jan 2026 11:00:31 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Jan 2026 11:00:31 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Richard Cochran
 <richardcochran@gmail.com>,
        "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jakub
 Kicinski <kuba@kernel.org>,
        Dust Li <dust.li@linux.alibaba.com>,
        Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        David Woodhouse <dwmw2@infradead.org>, virtualization@lists.linux.dev,
        Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-clk@vger.kernel.org
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
In-Reply-To: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com> (Wen
	Gu's message of "Fri, 9 Jan 2026 10:56:56 +0800")
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
Date: Mon, 12 Jan 2026 12:00:31 +0100
Message-ID: <yt9decnv6qpc.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4NiBTYWx0ZWRfX2Xhrrn4DjaLy
 XeeMtnuMIJOIXT/lPd5GLgBkTYFzNP7oUgElbQuegcAQTEvN+fsTAKNULiorgNH+7gHwNX2Z24B
 C3c9+eItaGVZrHoYRRAWfTm+ECbLVUT1VJto5g0KL9bvJTt2+49xKVb0pMeJwtyMZO0hIhupQjv
 tCUjsjitwYLanfRlGnzfJAKrtPjRXPuO6puZlLIbwLsUlEvYbifgJaOS0v77CV62JBnz2S4lRA0
 3+aQIYh013niMZV4B7fc1EeSutYsu3XryoDRUkWsoH6Ppf0ynRugK/DU7vkTvblDfH4s2Y3IQgl
 1z8GBnSe86kclucDw6tHpOHwP0SUuBwfzp5ubzjIo7TSQvLBnIjc8+M1hmalu+RyVIHy5IDzYg9
 6jt6phWBN2B1HP8A540Waf+pyhKtbSRH3bXwLQ24u4PvUWBKYrNpwuFia6/fUS3PHHW18ZD6W45
 Wtorx22AZugbF7ocLGQ==
X-Proofpoint-GUID: 2dzlkKuuZGqvKD3iJmn2bayCJY5VE71O
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6964d453 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=SRrdq9N9AAAA:8
 a=3nQEIVoXau97ABBm5YcA:9
X-Proofpoint-ORIG-GUID: DRn0cgi7mHMDldvAvb1qmnSl45Rg90Av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120086

Hi Wen,

Wen Gu <guwen@linux.alibaba.com> writes:

> 1. Reorganize drivers/ptp/ to make the interface/implementation split
>    explicit,
>
>    * drivers/ptp/core      : PTP core infrastructure and API.
>                              (e.g. ptp_chardev.c, ptp_clock.c,
>                               ptp_sysfs.c, etc.)
>
>    * drivers/ptp/pure      : Non-network ("pure clock") implementation,
>                              they are typically platform/architecture/
>                              virtualization-provided time sources.
>                              (e.g. ptp_kvm, ptp_vmw, ptp_vmclock,
>                               ptp_s390, etc.)
>
>    * drivers/ptp/*         : Network timestamping oriented implementation,
>                              they primarily used together with IEEE1588
>                              over the network.
>                              (e.g. ptp_qoriq, ptp_pch, ptp_dp83640,
>                               ptp_idt82p33 etc.)

I'm fine with splitting paths - but I would propose a different naming
scheme as 'pure' is not really a common term in the driver world (at
least in my perception, which might be wrong. How about the following
instead:

drivers/ptp/core    - API as written above
drivers/ptp/virtual - all PtP drivers somehow emulating a PtP clock
                      (like the ptp_s390 driver)
drivers/ptp/net     - all NIC related drivers.


