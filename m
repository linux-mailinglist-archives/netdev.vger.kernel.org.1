Return-Path: <netdev+bounces-195354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54105ACFD66
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 09:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC36189606A
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E0D2040B6;
	Fri,  6 Jun 2025 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PRp10qEB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF91EF0B9;
	Fri,  6 Jun 2025 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194487; cv=none; b=jgwK7na+hGLurq/VCFJq96P85xHYVhSjyBuewQL9Ix8zL6gBW5rttjvC2PvrKqbJAdF5xbAX6vPjWfcxLj9+k03cxaRmcLJGZBLojTyaPVmZj0lbbOsmw7G8ONLoftFsT+NX/soWtiW122WJo+K+PdXBXmKHia56i1bpI7U/2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194487; c=relaxed/simple;
	bh=ChjZONmvwHIQgHEoxS2hbayUZ7YTKLK86GqYEJ9vb8w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdTWpvqTdfKXZ8OuUXuJuVSKFa6r0d5huON0HPTubrqhnOnli9kKS+PpCq6h9to2Ntsp66gqum+f8JnC1QValjKwclkaJAGVCGpiQ/bzgF9aC5G8ZJw70gzN25amj5aYyIawtqDh9m/kpcBJTjBUBsKbrMzKXFoHnVRX0QLbKvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PRp10qEB; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555H0UpP024603;
	Fri, 6 Jun 2025 00:20:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=78vuFN+FTuBzAdllm1AMLckzj
	iwjwEP6iKxOkB7ETO8=; b=PRp10qEBEI9/KmMIIszcRTvtEgWZDg11o43L9G5Vs
	3RK8/YkI7bwMDFjWy7w/IMjeaW9QIGGgeOZyOsdpPksvkq0hTRYzmzkeKwOkwhsk
	4dBGQyf73+k1zamqCP5CaUMbW4YRuWiod+DVgvawFp3NCLeGEHdDPnVdFgp1eQh9
	f5B9671WGYd2+8hs9DV2fAwMinyjJos5PmugXUHZsMznjpvdi+F3F0qUEwKMuxnI
	5fCrQ0vCg8K+51Kp9t5ksfvI2iG1D3g3JbdoLknEp1FC+lhlWVkY5hIkPepq/0j7
	nXkAd6svC3l0sBO16u30zhUBFz4LwNzhdMacWw+J0BUdA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 473f8s9fn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 00:20:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 6 Jun 2025 00:20:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 6 Jun 2025 00:20:55 -0700
Received: from 7f70c4b51185 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 1DE233F7085;
	Fri,  6 Jun 2025 00:20:51 -0700 (PDT)
Date: Fri, 6 Jun 2025 07:20:50 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hannes
 Frederic Sowa <hannes@stressinduktion.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] macsec: MACsec SCI assignment for ES = 0
Message-ID: <aEKW0nDwvkfMy-_c@7f70c4b51185>
References: <20250604123407.2795263-1-carlos.fernandez@technica-engineering.de>
 <20250605132110.3922404-1-carlos.fernandez@technica-engineering.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250605132110.3922404-1-carlos.fernandez@technica-engineering.de>
X-Proofpoint-ORIG-GUID: lY8RMgbu4n9SVZRdOylOt15s4GEHAAwl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA2NyBTYWx0ZWRfX4NVX3mV6ewBh jz3dzTPIN2pXMVgt/dQ13c2eSqvIc4lwfg7dmiZgcYdgivNzGZM3M7+nOGpL/ykCMSjS1ripwNR vbvWXRG7K+CIifNIu591iBSrY3gZFj+2PPHyL/9v7J881/Z0bj8j27iQvK9fuUrlWgn6aEryZaM
 NPsdGD1YWamDFDG2+FGHNZx/3qSnrUB3uY9GWIgZIgO18cZp9MkdzNi0/AYgc9YdC4XmTZRygsZ KbRPSeAQPVlPWlKsoWD2B2UI9/C8wDYC4Rssi50r9DJK/u3g37nBslSMWpy2MF/9SB5I5ckPNjq krQQDoZq16FlK4Hu7ZE6sTQcybAcrzk501qPjY7wtWTlqJPG3oAM36Zk6k25hCBOSYAAH58yJPF
 RnXIbUat5Ui3HfU2THnrRcKyewYKWjjDemfHTieeqgitkhy86Yauc035NGFO8iWFLLoAZR9w
X-Authority-Analysis: v=2.4 cv=RKizH5i+ c=1 sm=1 tr=0 ts=684296d8 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=yWhXGdImo7ep3bz_Ny0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: lY8RMgbu4n9SVZRdOylOt15s4GEHAAwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_02,2025-06-05_01,2025-03-28_01

On 2025-06-05 at 13:21:04, Carlos Fernandez (carlos.fernandez@technica-engineering.de) wrote:
> Hi Sundeep, 
> 
> In order to test this scenario, ES and SC flags must be 0 and 
> port identifier should be different than 1.
> 
> In order to test it, I runned the following commands that configure
> two network interfaces on qemu over different namespaces.
> 
> After applying this configuration, MACsec ping works in the patched version 
> but fails with the original code.
> 
> I'll paste the script commands here. Hope it helps your testing.
> 
> PORT=11
> SEND_SCI="off"
> ETH1_MAC="52:54:00:12:34:57"
> ETH0_MAC="52:54:00:12:34:56"
> ENCRYPT="on"
> 
> ip netns add macsec1
> ip netns add macsec0
> ip link set eth0 netns macsec0
> ip link set eth1 netns macsec1
>   
> ip netns exec macsec0 ip link add link eth0 macsec0 type macsec port $PORT send_sci $SEND_SCI end_station off encrypt $ENCRYPT
> ip netns exec macsec0 ip macsec add macsec0 tx sa 0 pn 2 on key 01 12345678901234567890123456789012
> ip netns exec macsec0 ip macsec add macsec0 rx port $PORT address $ETH1_MAC 
> ip netns exec macsec0 ip macsec add macsec0 rx port $PORT address $ETH1_MAC sa 0 pn 2 on key 02 09876543210987654321098765432109
> ip netns exec macsec0 ip link set dev macsec0 up
> ip netns exec macsec0 ip addr add 10.10.12.1/24 dev macsec0
> 
> ip netns exec macsec1 ip link add link eth1 macsec1 type macsec port $PORT send_sci $SEND_SCI end_station off encrypt $ENCRYPT
> ip netns exec macsec1 ip macsec add macsec1 tx sa 0 pn 2 on key 02 09876543210987654321098765432109
> ip netns exec macsec1 ip macsec add macsec1 rx port $PORT address $ETH0_MAC 
> ip netns exec macsec1 ip macsec add macsec1 rx port $PORT address $ETH0_MAC sa 0 pn 2 on key 01 12345678901234567890123456789012
> ip netns exec macsec1 ip link set dev macsec1 up
> ip netns exec macsec1 ip addr add 10.10.12.2/24 dev macsec1
> 
> ip netns exec macsec1 ping 10.10.12.1 #Ping works on patched version.
> 
> Thanks, 
> Carlos

Clear for me now. Thanks for the steps.

Sundeep

