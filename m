Return-Path: <netdev+bounces-126450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6936A9712E2
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26591281633
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F271B29C7;
	Mon,  9 Sep 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="gaAmFmo0"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09090102.me.com (ci74p00im-qukt09090102.me.com [17.57.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380C1B141B
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872653; cv=none; b=X/Pn7dbwAoReIp3z4r5bZNKHdUw16PbKQzMCJpjywlzU8AUwiDpQmmPOUU91tU9Bl91WNiDL/EYaujGbyO0DacCpowQ87uWXGo1ipIx018hok+E1GS7w32IZkwBbvB5AU5qHGFl17MgZxzE8dlomkIf48ClQJMjxbQLeqbz1fV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872653; c=relaxed/simple;
	bh=HuAzle0O7gPg0QJV7m8XVn3tTr3qju6NtHIJRuZAFHw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=hfsD8nH2AFTExDKI9+/KmWziXZPcqOEjEwVL7o9HrqkpCK9Ely5KZIc11Ob6lTuJ50nuEVrF1gZbCUBIkJhizBJRIFs8uz313JWJAUF4uYy2megSmKxcMtRFbdTsfhfB8dgMjuj+3OGmkyOZ2t/biUOkKYJDZ2lEYDrb/6LyOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=gaAmFmo0; arc=none smtp.client-ip=17.57.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1725872650; bh=0N+YcGX5JKTj2RFBVjEnYi3cAnTw2iTZC8ytorLbQmY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	b=gaAmFmo0PsERLGDN5hRdyGOw6SwzbNEMcf75EP2rgjpVBTKNMfnHHb1wye+tQozaN
	 AtaqR7MQTb7LpzOHk91QmroYD6syooqtxZwByDlt6kprxR43p0DsVA0Jgm+cMzOSL9
	 NDyTApyt6hDEMzy2WPPHSgADdxpGmBQk4czj7ttCfDspcM+1dhC0bplvhpEEgFsHlY
	 pCj1SR+eg789+6FPDTctnzJQg1FhXlCcTRo7XwZ8gvummDW1XjSXodEIdJfpNdz5mm
	 CuSrHO/3w6Prcd39gzmIsj6tmZPFTTnGNSRnmsQvYPNgmJzOzEcn0oEE8F5whgpgoO
	 /XWKWxSoTIsRA==
Received: from [192.168.40.3] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090102.me.com (Postfix) with ESMTPSA id 638CA3C001C2;
	Mon,  9 Sep 2024 09:04:08 +0000 (UTC)
Message-ID: <4be673c9-b06a-4c2d-8b27-a1e91150df94@pen.gy>
Date: Mon, 9 Sep 2024 11:04:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
To: Oliver Neukum <oneukum@suse.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240907230108.978355-1-forst@pen.gy>
 <mJ-iCj-W_ES_nck94l7PueyUQpXxmgDdxq78OHP889JitvF0zcid_IBg1HhgEDh-YKlYjtmXt-xwqrZRDACrJA==@protonmail.internalid>
 <8510a98e-f950-4349-99bc-9d36febe94d3@suse.com>
Content-Language: en-GB
From: Foster Snowhill <forst@pen.gy>
Autocrypt: addr=forst@pen.gy; keydata=
 xjMEYB86GRYJKwYBBAHaRw8BAQdAx9dMHkOUP+X9nop8IPJ1RNiEzf20Tw4HQCV4bFSITB7N
 G2ZvcnN0QHBlbi5neSA8Zm9yc3RAcGVuLmd5PsKPBBAWCgAgBQJgHzoZBgsJBwgDAgQVCAoC
 BBYCAQACGQECGwMCHgEAIQkQfZTG0T8MQtgWIQTYzKaDAhzR7WvpGD59lMbRPwxC2EQWAP9M
 XyO82yS1VO/DWKLlwOH4I87JE1wyUoNuYSLdATuWvwD8DRbeVIaCiSPZtnwDKmqMLC5sAddw
 1kDc4FtMJ5R88w7OOARgHzoZEgorBgEEAZdVAQUBAQdARX7DpC/YwQVQLTUGBaN0QuMwx9/W
 0WFYWmLGrrm6CioDAQgHwngEGBYIAAkFAmAfOhkCGwwAIQkQfZTG0T8MQtgWIQTYzKaDAhzR
 7WvpGD59lMbRPwxC2BqxAQDWMSnhYyJTji9Twic7n+vnady9mQIy3hdB8Dy1yDj0MgEA0DZf
 OsjaMQ1hmGPmss4e3lOGsmfmJ49io6ornUzJTQ0=
Subject: Re: [PATCH net-next] usbnet: ipheth: prevent OoB reads of NDP16
In-Reply-To: <8510a98e-f950-4349-99bc-9d36febe94d3@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Umu5cJ4NhBlO-Xdz4YTs_es9mDh_faV8
X-Proofpoint-GUID: Umu5cJ4NhBlO-Xdz4YTs_es9mDh_faV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_02,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=296
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1030 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409090071

Hello Oliver,

Thank you for the feedback.

>> To address the above issues without reimplementing more of CDC NCM,
>> rely on and check for a specific fixed format of incoming URBs
>> expected from an iOS device:
>>
>> * 12-byte NTH16
>> * 96-byte NDP16, allowing up to 22 DPEs (up to 21 datagrams + trailer)
> 
> I am afraid this is an approach we must not take. We cannot rely on
> a specific device's behavior in a class driver.
> 
> This is a NACK.

The `ipheth` driver, that the patch is for, is designed specifically for
interacting with iPhones. iPhones' "NCM" implementation for regular
tethering (sharing mobile/cellular internet with an attached Linux system)
is _not_ compliant with the CDC NCM spec:

* Does not have the required CDC NCM descriptors
* TX (computer->phone) is not NCM-encapsulated at all

Thus the `ipheth` driver does not aim to be a CDC NCM-compliant
implementation and, in fact, can't be one because of the points above.

For a complete spec-compliant CDC NCM implementation, there is already
the `cdc_ncm` driver. This driver is used for reverse tethering (sharing
computer's internet connection with an attached phone) on iPhones. This
patch does not in any way change `cdc_ncm`.

With all of the above, does your NACK still stand? Thanks!


