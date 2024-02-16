Return-Path: <netdev+bounces-72414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A09857F71
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EA12873D1
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A6712EBC0;
	Fri, 16 Feb 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hlDhumku"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A937140
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094267; cv=none; b=XFvcIvle4bmcoQpdfMD7RbWxHHPuzx4xBHXsH+IHO10WtS/awLPUhtANTAVJiI10WVcNrcgERjc/pDYahYAuIJb92Vzm/LJTla5ePka48dQmGQ74Lwr17eqco68vmmzRIZ/eYDStF5iowRy6pLX4V2pOWVbsV1heMLZ01DZAl5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094267; c=relaxed/simple;
	bh=3oLQfasgVkUQRbZlPZ/HAxNxcRpDLhqxR9WXBwj1I9c=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:CC:From:
	 In-Reply-To:Content-Type; b=RDjtQTJUud3n5dQ9ASat6/ftqH+d3imiv43jK93Kv8s4ofeuRGrR1JRQOjjW7DAk69GkH3UmtWlWyYeL8AFPm7qQ4kJvdXppODfz2eumldMSeJFdGiIMx0sFlirDnmJOZiDJ7/jfEQeiO+d1koQqrZXnJ6NqO3LcnRwS2AFzC3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hlDhumku; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GBkRMV013364;
	Fri, 16 Feb 2024 15:35:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:references:to:cc:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=f7VRNFViKEqX1D/rIWYdwINEB6beA+tUXpbHjzOl3sE=; b=hl
	Dhumkui5LfkrLjdiXykr/iHO/ixh6P+Jx/JTbzUruVgOD/XoKJteCD3e+ndNUn7O
	DDXEH228yDeOQnJR+x/o8MmI0rZNOXoRFsxfeVHBR9v5o24OXngbUe6zxzakxDtV
	F/a8yTwMQQ6Z+LPwqZ1cuIevfjqGIIqSFKcboPzKYAPm96CAU4jLrL+RmwBnUeA0
	uWg1Sk7+xAQ+ZU470SUYMuor9gRq8KoBztL+/e6jtFg3HeuUMfw4LlEdGBzau0FA
	qs37dtbi38r0nw20xbcsksfxTJscd8zr/fvw2gJy4u4m54Vual31zYno5ZhpWq9A
	k+A7vtxsMdzcqSiy6XmQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa1252gu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 15:35:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B0D0140044;
	Fri, 16 Feb 2024 15:35:31 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F032B2688EB;
	Fri, 16 Feb 2024 15:35:16 +0100 (CET)
Received: from [10.252.5.3] (10.252.5.3) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 15:35:14 +0100
Message-ID: <7cfc9562-161d-4d6c-a355-406938b3361e@foss.st.com>
Date: Fri, 16 Feb 2024 15:35:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: VLAN "issue" on STMMAC
References: <20240130160033.685f27c9@kernel.org>
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <netdev@vger.kernel.org>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <20240130160033.685f27c9@kernel.org>
X-Forwarded-Message-Id: <20240130160033.685f27c9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02

Hello,

I've a question concerning following commit:

ed64639bc1e0899d89120b82af52e74fcbeebf6a :

net: stmmac: Add support for VLAN Rx filtering

Add support for VLAN ID-based filtering by the MAC controller for MAC

drivers that support it. Only the 12-bit VID field is used.

Signed-off-by: Chuah Kim Tatt kim.tatt.chuah@intel.com
Signed-off-by: Ong Boon Leong boon.leong.ong@intel.com
Signed-off-by: Wong Vee Khee vee.khee.wong@intel.com
Signed-off-by: David S. Miller davem@davemloft.net

So now with this commit is no more possible to create some VLAN than 
previously (it depends of number of HW Tx queue) (one VLAN max)

root@stm32mp1:~# ip link add link end0 name end0.200 type vlan id 200
[   61.207767] 8021q: 802.1Q VLAN Support v1.8
[   61.210629] 8021q: adding VLAN 0 to HW filter on device end0
[   61.230515] stm32-dwmac 5800a000.ethernet end0: Adding VLAN ID 0 is 
not supported
root@stm32mp1:~# ip link add link end0 name end0.300 type vlan id 300
[   71.403195] stm32-dwmac 5800a000.ethernet end0: Only single VLAN ID 
supported
RTNETLINK answers: Operation not permitted
root@stm32mp1:~#

I've tried to deactivate VLAN filtering with ethtool, but not possible 
("fixed" value)

root@stm32mp1:~# ethtool -k end0 | grep -i vlan
rx-vlan-offload: on [fixed]
tx-vlan-offload: on [fixed]
rx-vlan-filter: on [fixed]
vlan-challenged: off [fixed]
tx-vlan-stag-hw-insert: on [fixed]
rx-vlan-stag-hw-parse: on [fixed]
rx-vlan-stag-filter: on [fixed]
root@stm32mp1:~#
root@stm32mp1:~# ethtool -K end0 rxvlan off
Actual changes:
rx-vlan-hw-parse: on [requested off]
Could not change any device features

Do you know if there are possibility to force creation of VLAN ID (may 
be in full SW ?) and keep the rest of Ethernet Frame processing to GMAC HW.

Thanks for your help/feedback

Regards,

Christophe

