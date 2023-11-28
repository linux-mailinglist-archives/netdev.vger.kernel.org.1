Return-Path: <netdev+bounces-51807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DA7FC422
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AA51C20B17
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3002946BA5;
	Tue, 28 Nov 2023 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CVzIkbW8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DF410EC
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 11:18:59 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASFjL4h019454;
	Tue, 28 Nov 2023 11:18:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=kMFp97RzjQhufj56WtcUPJlGyUuOsiaQ8ftBz5LtOIk=;
 b=CVzIkbW81x6hLp7RU9D6u6Dfipr32kMbwXznnIau7J3MNwRMV6idlwZfj2iz/mKh7cnv
 bAhXTBAnLctJQwWM7W3Cs8VOWA6yJdHgfTZ4ov/kjFOxdfZBEXe62dpJcgQYvwkaIrqp
 6aHfIEbbkTm0VycXSVFefgMcZ2fgQzmY0YPZVcenkPFoEvAJSJQIfdGHXRt0Luzf+y4F
 BEoMKMJXhWlqpveOt/1ELW0a2IDEbj1tzWcf88NaxC2h0gR9rmtHvZiWTJnl2EJ7qtrd
 oqaohJlfg5uUjD3rPuOAGgr6AsdFe06SOdGy/f9MFp8k7+uVM6+EKuzwpZEXXD1TRFDj vw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3una4djqej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 11:18:53 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 Nov
 2023 11:18:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 28 Nov 2023 11:18:51 -0800
Received: from [10.193.38.189] (unknown [10.193.38.189])
	by maili.marvell.com (Postfix) with ESMTP id 35E313F705F;
	Tue, 28 Nov 2023 11:18:50 -0800 (PST)
Message-ID: <9852ab3e-52ce-d55a-8227-c22f6294c61a@marvell.com>
Date: Tue, 28 Nov 2023 20:18:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Netdev
	<netdev@vger.kernel.org>
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
 <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
 <20231127145945.0d8120fb@kernel.org>
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <20231127145945.0d8120fb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cEHFraV7Wn1NNHL7S9tqQKUnHu5db4IY
X-Proofpoint-ORIG-GUID: cEHFraV7Wn1NNHL7S9tqQKUnHu5db4IY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_21,2023-11-27_01,2023-05-22_02


On 11/27/2023 11:59 PM, Jakub Kicinski wrote:

> Another option you can consider is lowering the default ring size.
> If I'm looking right you default to 4k descriptors for Tx.
> Is it based on real life experience?

Probably reducing default will help - but again not 100%.

I remember these numbers where chosen mainly to show up good 10Gbps
line speed in tests, like iperf udp/tcp flood. But these of course
artificial.

For sure "normal" user can survive even with lower digits.

Thanks
  Igor

