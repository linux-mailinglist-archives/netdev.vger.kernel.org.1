Return-Path: <netdev+bounces-197970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B06BADAA39
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9960165DC7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4C72063F3;
	Mon, 16 Jun 2025 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eFCbuYCR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE321F3B8A;
	Mon, 16 Jun 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061156; cv=none; b=UowKmIdLFxf0Dm9P1KlqeGfZhcpDxzpXRz6MIO5aUX5F92jxhtAQA5V3cO8gkfYmIwPl3MjO2ubHK6IPmXQkZTbN+uTR+hFqYbq8tUmi1DL6pG1ThWR6zsJF17581oB6HK3x6V2A47MXiZTpqn0yf2HumgzFBi9tswNocoOq4kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061156; c=relaxed/simple;
	bh=/ap91qCTSfqwZt+drR99+M7HfL8Z013gvOOenkeMFwU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d1uFgIR+e6yfU1CkDUYdvviQx84fgE5rR1YGZJubYjJlnpLpR9//YwUKDpzO6P8xjc3uByF7TW4ICvYh5shbGv3zOpe5I30fj3isDsGvf3yFkXGri9+zXPeh69uBBc69h8u+rycOv5lKxZ6zL60eGU8LLYk70fkxXfUN+B49b2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eFCbuYCR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNVcqN028273;
	Mon, 16 Jun 2025 01:05:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=JnrOOoAgr5uNgKTUzkhibZVApJlrnyyUF1e4XdpSyao=; b=eFC
	buYCRPfa2gde9tw2PhlHtrV6Qi1V6PDTXPj2x6QNH/ByPlUT6+qZHukqC/a64kbl
	Zmhl+5idPdqLZWRdHa2lmfkb9GJeYKR/tT42zXQOwMQFfvbrNbvwgP/G5RQ8UljX
	eAnuTFBRVQdwQCcE5toAhd6YZFj3djwxcWYt5YRUYRldcucu9nGsLxDFftqpm/fX
	9J4dOx/GkPOL/dFMRK3deSP6SKNh2b+EJ/y8SdFYHjYlS9KtHg7Ws2gF9XE49/we
	FdR6ujUKtQoetyNMSfF5MMFY0iMFOpFRMETMcFKUR7U+QEeRrJueBk3qD+gZDIOd
	1ZVASmzcW25ZJ5yiA0A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47a7w70rrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 01:05:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Jun 2025 01:05:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Jun 2025 01:05:34 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 771285E6875;
	Mon, 16 Jun 2025 01:05:31 -0700 (PDT)
Date: Mon, 16 Jun 2025 13:35:30 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linyunsheng@huawei.com>
Subject: [RFC]Page pool buffers stuck in App's socket queue
Message-ID: <20250616080530.GA279797@maili.marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Authority-Analysis: v=2.4 cv=BIyzrEQG c=1 sm=1 tr=0 ts=684fd04f cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=TaUrKhdEcyyTM7VkM04A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA1MiBTYWx0ZWRfXwcB+8evqSl3f l1wUn1/nMgc6KwVcPWJWV8zMRgN6N/3k7kUxF4fXTXhDnSYie99co95TWKwaNa0ty0YVfnYHvFG zcW3se4AkDBamy7KPMU8zLOKEraAUxUU7v36IDONA1QIq+0lbGLJkanSMCNwj/hibeFmQWXgnFO
 wf4bi5GCRlweYSpnt38LbOpgZ58xyr8O5jwrDAwXtMaiGBHwQZ5AU+fRdx06bgpr40R46LrEZEo AL1xpgOuVwdufhSyTIKjFMU3oYgqW8S7g5iKWAIqIP41vIrQFTVY6KJNcFlFkOwnycovieSsrJA JfiYC8q1S0ExjKPIZPgXeKcPBlsM+l07ZKVPKxStrQgZukYUGUJN6xsVQwyRPNcbHaiB7Vr/Fc3
 p1zly/ow/s+wRJM7IK7uDigXpBFCeMIcHhrE5x2bqmsCrrkEnr+OAFPkBeRhHVo5x1Wz5jor
X-Proofpoint-ORIG-GUID: rBFx7aqOJrr7i_B4GdzvNCM9-blkZE8w
X-Proofpoint-GUID: rBFx7aqOJrr7i_B4GdzvNCM9-blkZE8w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_03,2025-06-13_01,2025-03-28_01

Hi,

Recently customer faced a page pool leak issue And keeps on gettting following message in
console.
"page_pool_release_retry() stalled pool shutdown 1 inflight 60 sec"

Customer runs "ping" process in background and then does a interface down/up thru "ip" command.

Marvell octeotx2 driver does destroy all resources (including page pool allocated for each queue of
net device) during interface down event. This page pool destruction will wait for all page pool buffers
allocated by that instance to return to the pool, hence the above message (if some buffers
are stuck).

In the customer scenario, ping App opens both RAW and RAW6 sockets. Even though Customer ping
only ipv4 address, this RAW6 socket receives some IPV6 Router Advertisement messages which gets generated
in their network.

[   41.643448]  raw6_local_deliver+0xc0/0x1d8
[   41.647539]  ip6_protocol_deliver_rcu+0x60/0x490
[   41.652149]  ip6_input_finish+0x48/0x70
[   41.655976]  ip6_input+0x44/0xcc
[   41.659196]  ip6_sublist_rcv_finish+0x48/0x68
[   41.663546]  ip6_sublist_rcv+0x16c/0x22c
[   41.667460]  ipv6_list_rcv+0xf4/0x12c

Those packets will never gets processed. And if customer does a interface down/up, page pool
warnings will be shown in the console.

Customer was asking us for a mechanism to drain these sockets, as they dont want to kill their Apps.
The proposal is to have debugfs which shows "pid  last_processed_skb_time  number_of_packets  socket_fd/inode_number"
for each raw6/raw4 sockets created in the system. and
any write to the debugfs (any specific command) will drain the socket.

1. Could you please comment on the proposal ?
2. Could you suggest a better way ?

-Ratheesh

