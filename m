Return-Path: <netdev+bounces-126566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AF971DDC
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9CF28147D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672A6BFC0;
	Mon,  9 Sep 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4X04Imsn"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADB745E4
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894962; cv=none; b=nBN6m6Gg7Cv+paNHFHUzA7nOTFdB+vXm6uc5y1FDPfQCsov9kjCWDgspNaH/1OHFi6DpfcV9RIVGf8JZfM2QBBuYiE2MAkiOo37+wS7S9alEfRXsK9YSF9n4Sy/mkvyUMiktczDNsrpa9KXAoh9EsJMOKiKfdjMQOFsTPq8mtjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894962; c=relaxed/simple;
	bh=om2chDJR2aCZRHrBSp15/2LALdsZlv3azFh8EsJZK/A=;
	h=Message-ID:Date:MIME-Version:CC:From:Subject:To:Content-Type; b=f5ICoNHrJ7HqpjdIWmQ7ls1if5IsGfw8k9c8Ye0xUZVTTxu3W8j5ggjCIKk1kvKRzNj7ru5427anctbH064Ger02RsFICePMFw5W2b1bt0TkfpWGOZLNSnyiG6/884wtto+9+bObChJa822rQ2kQw/CFsUXkzT52oW7t6yEVvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4X04Imsn; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489A7SI3022250;
	Mon, 9 Sep 2024 17:15:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=En57K+7R0zKRA5a4bgohzu
	OOSpehZP9qOg7d04p+JPg=; b=4X04Imsns10+9rWZ+V1YBkN85wJ/F2ZYUe1epL
	rtCDrQhoeTTj4c/7LZJngM534azE0wr45EiTnwB9J6hOtpgGD5vNkipkI8G+5ean
	02LLOUzOmLb2A1jT9E3vI7uD299PvJZpkttVqbuXvfZHCpBjSNEodNOxoPeLY+dA
	IMqPJ9ZHhBJdbHZ/8qkRpe1tZwFfX2n+W+/NQYgGtXPSIHK64HybwCjgzzN/NHNY
	xyvpqMJ6c3xzrWUgPytZkgV5BvXLN6ngxB8KfJjXIzwOxAp9H6nDU7qbNfjmTKz0
	uRpZCdWQxIXI3m7jWP+/QC/ehRlEuIoUPuTmv1NWh7LHdxFA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41h0cydpk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 17:15:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C5BCE400A2;
	Mon,  9 Sep 2024 17:14:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6B58127D0E3;
	Mon,  9 Sep 2024 17:13:25 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Sep
 2024 17:13:22 +0200
Message-ID: <8aac51e0-ce2d-4236-b16e-901f18619103@foss.st.com>
Date: Mon, 9 Sep 2024 17:13:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Jakub
 Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Maciek Machnikowski <maciek@machnikowski.net>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
Subject: [BUG] Regression with commit: ptp: Add .getmaxphase callback to
 ptp_clock_info
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Rahul, All,

I'm facing regression using ptp in STM32 platform with kernel v6.6.

When I use ptp4l I have now an error message :

ptp4l[116.627]: config item (null).step_window is 0
PTP_CLOCK_GETCAPS: Inappropriate ioctl for device
ptp4l[116.627]: clock is not adjustable
failed to create a clock

This regression was introduced in kernel v6.3 by commit "ptp: Add 
.getmaxphase callback to ptp_clock_info" SHA1: 
c3b60ab7a4dff6e6e608e685b70ddc3d6b2aca81:

     Author: Rahul Rameshbabu rrameshbabu@nvidia.com  2023-06-12 23:14:56
     Committer: David S. Miller davem@davemloft.net  2023-06-20 10:02:33
     Parent: 3a9a9a6139286584d1199f555fa4f96f592a3217 (testptp: Add 
support for testing ptp_clock_info .adjphase callback)
     Child:  67ac72a599d833ff7d9b210186a66d46c13f0a18 (net/mlx5: Add 
.getmaxphase ptp_clock_info callback)
     Follows: v6.1-rc1
     Precedes: v6.6-rc7

     ptp: Add .getmaxphase callback to ptp_clock_info

     Enables advertisement of the maximum offset supported by the phase 
control
     functionality of PHCs. The callback is used to return an error if 
an offset
     not supported by the PHC is used in ADJ_OFFSET. The ioctls
     PTP_CLOCK_GETCAPS and PTP_CLOCK_GETCAPS2 now advertise the maximum 
offset a
     PHC's phase control functionality is capable of supporting. 
Introduce new
     sysfs node, max_phase_adjustment.

     Cc: Jakub Kicinski kuba@kernel.org
     Cc: Shuah Khan shuah@kernel.org
     Cc: Richard Cochran richardcochran@gmail.com
     Cc: Maciek Machnikowski maciek@machnikowski.net
     Signed-off-by: Rahul Rameshbabu rrameshbabu@nvidia.com
     Acked-by: Richard Cochran richardcochran@gmail.com
     Signed-off-by: David S. Miller davem@davemloft.net

Is it normal behavior ? If yes could you please tell me what we need to 
change/update in stmmac driver to be compliant with your modifications ?

Thanks for your help/feedback.

Regards,
Christophe.


