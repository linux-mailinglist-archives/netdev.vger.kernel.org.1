Return-Path: <netdev+bounces-181732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A538A8650E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE893AE139
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD012586C1;
	Fri, 11 Apr 2025 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C+16/jDC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952D2586EA
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393769; cv=none; b=lb03IJ31PJwp1KlQZVaCwEbiGgVxgc83gq5U729wPNpo/FACzqThd0s3saTzRgsBojxKy+Z11O3v0awfEZbv1LSBjMwh7IR1MuSZWgY30wTlJioOJEt0tGB6q9mEgdWRYcWxs4optW2sHlca1s7uY4b0mC2PQ7N58SdZ99hRVAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393769; c=relaxed/simple;
	bh=35SGMHWMMrB68/1LDj49IdaFMJ3O6JRnRSZ9u8/v2w4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tiILIH/dRWE9ymfJ6TPJ92uchlc/E5bl6O0hEhc0EDRGvRPouABLvWKZ53bQLrzeltTjPUPECA/iaTpGJiRC7pSvsteM3KA/2nieY9jyJuusU5y+54kct7cm3mziGkC9p3rGfO9awYcIb0fate3yI0GJgs+OwHIqp6OCfpI3Z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C+16/jDC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGjLd4006633;
	Fri, 11 Apr 2025 17:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KqwMdZwPKGuQvrulpglZGHPjpbmNPLOOtsDDmOzsh
	dw=; b=C+16/jDCEtLkpitly7b5qFFQ/p0Dw5yZxJLpoal8tGCRkARLLlxEjz3HL
	65Yi0dbT/Tthqm9dHrHIQu4CKTicU+ML3fhjLm1CyLRnbXIRJzRBKX6cNAfD4Guv
	vFxAkrRg0dPNceHKKeBA8JkOfRJKTVoa2LG9Hmucxba8yblTpllkBr1sPKbB2a+n
	bINrH2cj4rzl6gPXk2u6UbYLzEcsayQ5BKE+HBgoVhPFwjJ25XmZW4IMyctIo7ur
	am2/LsdMPdriD1SLWOVhPvy3J9HPAtXNBIRSGeo3N+msra7oLE3n9VfIl17Q3Pti
	PbTu1rPwl0mHgiOzpt4BjuRsP4yoA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y4gqh40j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 17:49:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BF3jHB025525;
	Fri, 11 Apr 2025 17:49:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbmc1ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 17:49:23 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BHnJug28574364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 17:49:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A237358043;
	Fri, 11 Apr 2025 17:49:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6621D58055;
	Fri, 11 Apr 2025 17:49:21 +0000 (GMT)
Received: from localhost (unknown [9.61.62.58])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 17:49:21 +0000 (GMT)
From: David J Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com
Subject: [PATCH net-next v1 0/1] bonding: Adding limited support for ARP monitoring with ovs
Date: Fri, 11 Apr 2025 10:48:14 -0700
Message-ID: <20250411174906.21022-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DjFa_eQIQtHrEnpEexSN1ItoacMn9PyR
X-Proofpoint-ORIG-GUID: DjFa_eQIQtHrEnpEexSN1ItoacMn9PyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=918 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110110

Configurations with the bonding driver and openvswitch are unable to use the
bond's "ARP Monitor" feature. If an ovs bridge sits above the bonding driver
use of ARP Monitoring results in the bond flapping between slaves.
bond_verify_device_path() gathers all vlan tags between the bond and the
interface the arp is to be routed by walking the list of adjacent net_device's.
When OVS is in the stack, this process breaks since ports on OVS bridge are not
linked as they are with other configurations.
   
This patch adds limited support for the ARP Monitoring feature when OVS is
configured above the bond. When no vlan tags are configured or when the tag
is added between the bond interface and the OVS bridge arp monitoring will
function correctly. The use of tags between the OVS bridge and the routed
interfaces are not supported.
   
For example:
bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supported.
bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not supported.
   
We recognize that some other advance network configurations (with-out
OVS) may encounter the same issue. This is not an attempt to provide a
generic solution, it will provide a solution for known use cases with OVS
and the bonding driver as used by OpenShift with OVN-Kubernetes.

OVS bonding with BFD was evaluated as a possible solution. There are some 
limitations to adopting it.

In our environment the hypervisor manages SR-IOV interfaces. OVS bonding
requires that all slave interfaces have promiscuous mode enabled. However, for
promiscuous mode to function the hypervisor must also enable promiscuous mode
on the VF. Unfortunately, the hypervisor allows only a single VF per PF to have
promiscuous mode enabled.

This is a real customer problem, and they have expressed a strong desire to
continue to use the bonding driver to maintain backward compatibility with
their existing setup.

