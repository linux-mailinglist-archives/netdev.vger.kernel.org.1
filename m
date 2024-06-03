Return-Path: <netdev+bounces-100101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3628D7DF0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AD71F21802
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829174420;
	Mon,  3 Jun 2024 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZlEqWokF"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A173D551;
	Mon,  3 Jun 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405009; cv=none; b=PQuPgSPiK7JeCdPcHycZ2El3R9toNqXtStPfOoj+G1ogb2O8P8LKkDHFscrhw6cnZSmlomd8nen1Ws23WiivF7P7pclXCyDUXsVH7XYk1i/eRIuIS/hh0HDAOchERdfq6Uja2bQyHRDcv8lubm/Lt4ESFpS/w8tsPfvAzPt3SM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405009; c=relaxed/simple;
	bh=qPv/cEP/vC7Xp9sj78T3IAAe2pBZWrQMyGqGzvu0UrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AO8AI5Hv9qjGwAikHyE4R827vRobcz7ecPg+tEPDLoEHQqYrl1z+prOz0jyOu5D4KKNv1QhpdWYxhu4IcMj2tF1gbHFGOmYWbzWKyxXQX72M6EWFiNNvvfQdeP5hWBRkh3duLR5Kcd+ZUcon2ZvEJW5DGndJq+/bUJH1rFdI+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZlEqWokF; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4538uCjB074645;
	Mon, 3 Jun 2024 03:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717404972;
	bh=wdbjoTHSawI6Tn+qhwT2MEWyALxrqW5kNljLvx5stJ0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZlEqWokFn7gEi/NF8SbERRhzJBKESgTGoI0Xqckew0Z52xeE2wPJLt55vcgsPmixK
	 gPTMia+o4vuLHC/JTPF2J4jmAwMNYQZSFI9s4By8o6vQXykSQL+rLZ1mGqcKTSKyHv
	 /roKPT+UrkAoMkIPXqwaZ9PU7JXtr8ppX62RruUE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4538uCXp115250
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 03:56:12 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 03:56:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 03:56:12 -0500
Received: from [172.24.227.57] (linux-team-01.dhcp.ti.com [172.24.227.57])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4538u6eF011006;
	Mon, 3 Jun 2024 03:56:07 -0500
Message-ID: <319616d8-533e-48c6-b97e-6285d284ac9e@ti.com>
Date: Mon, 3 Jun 2024 14:26:06 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: ethernet: ti: RPMsg based shared
 memory ethernet driver
To: Andrew Lunn <andrew@lunn.ch>
CC: <schnelle@linux.ibm.com>, <wsa+renesas@sang-engineering.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
        <vigneshr@ti.com>, <rogerq@ti.com>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-2-y-mallik@ti.com>
 <389e1f57-1666-4298-a970-74f730740e4c@lunn.ch>
Content-Language: en-US
From: Yojana Mallik <y-mallik@ti.com>
In-Reply-To: <389e1f57-1666-4298-a970-74f730740e4c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 6/2/24 21:51, Andrew Lunn wrote:
>> +struct request_message {
>> +	u32 type; /* Request Type */
>> +	u32 id;	  /* Request ID */
>> +} __packed;
>> +
>> +struct response_message {
>> +	u32 type;	/* Response Type */
>> +	u32 id;		/* Response ID */
>> +} __packed;
>> +
>> +struct notify_message {
>> +	u32 type;	/* Notify Type */
>> +	u32 id;		/* Notify ID */
>> +} __packed;
> 
> These are basically identical.
> 

The first patch introduces only the RPMsg-based driver.
The RPMsg driver is registered as a network device in the second patch.
struct icve_mac_addr mac_addr is added as a member to
struct request_message in the second patch. Similarly struct icve_shm shm_info
is added as a member to struct response_message in the second patch. From
second patch onward struct request_message and struct response_message are not
identical. These members are used for the network device driver. As this patch
introduces only RPMsg-based ethernet driver these members were not used in this
patch and hence not mentioned in this patch. I understand this has led to the
confusion of the structures looking similar in this patch. Kindly suggest if I
should add these members in this patch itself instead of introducing them in
the next patch.

> The packed should not be needed, since these structures are naturally
> aligned. The compiler will do the right thing without the
> __packet. And there is a general dislike for __packed. It is better to
> layout your structures correctly so they are not needed.
> 

>> +struct message_header {
>> +	u32 src_id;
>> +	u32 msg_type; /* Do not use enum type, as enum size is compiler dependent */
>> +} __packed;
>> +
>> +struct message {
>> +	struct message_header msg_hdr;
>> +	union {
>> +		struct request_message req_msg;
>> +		struct response_message resp_msg;
>> +		struct notify_message notify_msg;
>> +	};
> 
> Since they are identical, why bother with a union?  It could be argued
> it allows future extensions, but i don't see any sort of protocol
> version here so you can tell if extra fields have been added.
> 

struct icve_mac_addr mac_addr is added as a member to
struct request_message in the second patch. Similarly struct icve_shm shm_info
is added as a member to struct response_message in the second patch. So sizes
of the structures are different. Hence union is used. I had moved those newly
added members to second patch because they are not used in the first patch. I
understand this has led to the confusion of the structures looking identical in
this patch. If you suggest I will move the newly added members of the
structures from the second patch to the first patch and then the structures
will not look identical in this patch.

>> +static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
>> +			 void *priv, u32 src)
>> +{
>> +	struct icve_common *common = dev_get_drvdata(&rpdev->dev);
>> +	struct message *msg = (struct message *)data;
>> +	u32 msg_type = msg->msg_hdr.msg_type;
>> +	u32 rpmsg_type;
>> +
>> +	switch (msg_type) {
>> +	case ICVE_REQUEST_MSG:
>> +		rpmsg_type = msg->req_msg.type;
>> +		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
>> +			msg_type, rpmsg_type);
>> +		break;
>> +	case ICVE_RESPONSE_MSG:
>> +		rpmsg_type = msg->resp_msg.type;
>> +		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
>> +			msg_type, rpmsg_type);
>> +		break;
>> +	case ICVE_NOTIFY_MSG:
>> +		rpmsg_type = msg->notify_msg.type;
>> +		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
>> +			msg_type, rpmsg_type);
> 
> This can be flattened to:
> 
>> +	case ICVE_REQUEST_MSG:
>> +	case ICVE_RESPONSE_MSG:
>> +	case ICVE_NOTIFY_MSG:
>> +		rpmsg_type = msg->notify_msg.type;
>> +		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
>> +			msg_type, rpmsg_type);
> 

New switch case statements have been added in the second patch for rpmsg_type
under under the case ICVE_RESPONSE_MSG. This makes case ICVE_REQUEST_MSG, case
ICVE_RESPONSE_MSG and case ICVE_NOTIFY_MSG different in the second patch. I
have kept icve_rpmsg_cb simple in this patch as it is called by the .callback.
Do you suggest to flatten these switch cases only for this patch?

> which makes me wounder about the value of this. Yes, later patches are
> going to flesh this out, but what value is there in printing the
> numerical value of msg_type, when you could easily have the text
> "Request", "Response", and "Notify". And why not include src_id and id
> in this debug output? If you are going to add debug output, please
> make it complete, otherwise it is often not useful.
> 

I will modify the debug output by including texts like "Request", "Response",
and "Notify" instead of the numerical value of msg_type. I will include src_id
and id and try to make this debug output complete and meaningful.

>> +		break;
>> +	default:
>> +		dev_err(common->dev, "Invalid msg type\n");
>> +		break;

> That is a potential way for the other end to DoS you. It also makes
> changes to the protocol difficult, since you cannot add new messages
> without DoS a machine using the old protocol. It would be better to
> just increment a counter and keep going.
> 

I will modify default case to return -EINVAL.

>> +static void icve_rpmsg_remove(struct rpmsg_device *rpdev)
>> +{
>> +	dev_info(&rpdev->dev, "icve rpmsg client driver is removed\n");
> 
> Please don't spam the logs. dev_dbg(), or nothing at all.
> 
> 	Andrew

I will remove the dev_info from icve_rpmsg_remove.

Thanks for your feedback.

