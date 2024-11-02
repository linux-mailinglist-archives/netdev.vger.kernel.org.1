Return-Path: <netdev+bounces-141187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E97909B9E17
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 10:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190281C20EF6
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642A3158A31;
	Sat,  2 Nov 2024 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="L8IYWAW+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884AB8614E
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730538699; cv=none; b=C4EcXky53iWkG5ks+1qZAWMNB+iauv3RZvPMngcYKAmVTnmNzVcs14DMoDQTimRlu8cU1Lte67WpxcY6cOSTJ3JqR7Q/eTqdjomfwPnY9nLHrZdVS3RiaEQhQ6wFDp5zzw5aIuClxLj/voVbN2FgdpFW5lPf66/A5eztI5xjkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730538699; c=relaxed/simple;
	bh=bAe8A4UDSj3ltyR1j4PM548CHB9jYzN+fO+LZmZVoF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CVzA/RC9uc4atESG0aBcSuKcJhOx5kk/sPZMcJ2vpKDlPD+fYxm58YP4JEhLE8GBBUxG0h7x2R6iL8Sm7/3INN4/YyH8oJSdbh+c8pkzQtoz2whIyOlMIdl3MXm9L6vRQ89Vmas1su3WCb/GngdPQOtPhwo0NugQKlJ7wW72Hoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=L8IYWAW+; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
	by m0050102.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 4A298sCN012700;
	Sat, 2 Nov 2024 09:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=bAe8A4UDSj3ltyR1j4PM548CHB9jYzN+fO+LZmZVoF8=; b=L8IYWAW+KzVt
	tOIFCLXiGLGyeFIemKNv+7zGLEnzSYRONRqiLd+EgJo6sYLVNacGLeDD+yQnaS6s
	XnHlao0IUKmNaAl+bTTTGI+WOOO1zvrln8Ml3s9O1cUUXtc3c7i2AWW8io7CzMtR
	I2xeLb2LXeD8pgWEZIBxDDhy4jjBmpz+TdD6XcPk1Hkkrx7/rWXg9Y0I5+iyG6mA
	1UZe3s6WBgEID2w2GgyTzcJRl5Do6KMYlvvbFG7ntF6Y0b5B1+i9GBZJKl5pp2hs
	83S0nrorteibcVCn4N2OWkuG6OzI4fV8QTmJbsRFFEPo/Dn/89mP2SlFqpZmWpF2
	RsIWE0/1kg==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 42nd239r5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Nov 2024 09:11:32 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 4A2982GK011932;
	Sat, 2 Nov 2024 05:11:32 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.207])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 42nfdv8nxb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Nov 2024 05:11:32 -0400
Received: from ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) by
 ustx2ex-dag4mb8.msg.corp.akamai.com (172.27.50.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 2 Nov 2024 02:11:31 -0700
Received: from ustx2ex-dag4mb2.msg.corp.akamai.com ([172.27.50.201]) by
 ustx2ex-dag4mb2.msg.corp.akamai.com ([172.27.50.201]) with mapi id
 15.02.1544.011; Sat, 2 Nov 2024 02:11:31 -0700
From: "Mortensen, Christian" <cworm@akamai.com>
To: "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Stackoverflow when using seg6 routes
Thread-Topic: Stackoverflow when using seg6 routes
Thread-Index: AQHbLHgGBbzTarS88E2nQjLK/Exe5LKjtDFU
Date: Sat, 2 Nov 2024 09:11:31 +0000
Message-ID: <fcd2798f213a4eae982db78cf3019197@akamai.com>
References: <2bc9e2079e864a9290561894d2a602d6@akamai.com>
In-Reply-To: <2bc9e2079e864a9290561894d2a602d6@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=384 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411020080
X-Proofpoint-ORIG-GUID: sfQkBUMMq065EBHn2c1GmFIvR1iwD9rw
X-Proofpoint-GUID: sfQkBUMMq065EBHn2c1GmFIvR1iwD9rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 malwarescore=0 priorityscore=1501
 mlxscore=1 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 mlxlogscore=212 spamscore=1 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411020081

>=A0The following script consistently reproduces the problem for me. It is =
probably not minimal:

I was able to trim down the script somewhat:

# Setup host1 with strange routing.
ip netns add host1
ip netns exec host1 ip link set dev lo up
ip netns exec host1 sysctl net.ipv4.ip_forward=3D1
ip netns exec host1 sysctl net.vrf.strict_mode=3D1
ip netns exec host1 ip link add vrf9 type vrf table 1009
ip netns exec host1 ip link set vrf9 up
ip netns exec host1 ip route add fc00:0:0:1:7:: encap seg6local action End.=
DT4 vrftable 1009 dev vrf9
ip netns exec host1 ip route add 192.168.2.1 encap seg6 mode encap segs fc0=
0:0:0:1:7:: via inet6 fe80::2 dev lo vrf vrf9

# Send a ping to vrf9 to crash the kernel:
ip netns add host1_1
ip netns exec host1 ip link add vm1 type veth peer eth0 netns host1_1
ip netns exec host1 ip link set vm1 master vrf9
ip netns exec host1 ip link set vm1 up
ip netns exec host1 sysctl net.ipv4.conf.vm1.proxy_arp=3D1
ip netns exec host1 ip route add 192.168.1.1/32 dev vm1 vrf vrf9
ip netns exec host1_1 ip link set eth0 up
ip netns exec host1_1 ip addr add dev eth0 192.168.1.1/16
ip netns exec host1_1 ping 192.168.2.1

