Return-Path: <netdev+bounces-197955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B165EADA93C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66C93A35B3
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 07:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B4B1E493C;
	Mon, 16 Jun 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zt65agB/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D5EAFA
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058510; cv=none; b=EspY4pmnpatch6ZYtU0/4Ri1nJRbx6L4Z8vG61XdtcwiLcc4uBkQpqtxDLkRzn7xRlaaTczFTi6nfOVRNxvFnVjzUpUyd6K7iKfkSyHG/VOcMh26lonNLYXkgqIxQR1NKQ38gn9wZR/THm6htlQ8UZGKPZ44SjZLz6Uj+wAE90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058510; c=relaxed/simple;
	bh=lLR1rlU7/ZfTYuRcmuDQ+Q+sSPdhN9PyCuxrNS9n6bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmkF0PLpLUNqv+HuecE3nr3xclWjoY6YYuwqJh118YoEbg6pt5zeINzZ1yeoZqmHm8PFaEMpTLTLx3ciS5DMs3B/H0jOGGM9KqVqtXN6Ifl4XoKsQobZgmYLKaRSs4wy7jVu0SlFLTZaYfsbyoyQHLtaVEaJ8z9jrNO9bGH87yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zt65agB/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G7Ber6030576;
	Mon, 16 Jun 2025 07:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=fHJGOjr17s3sfZmzjOfhOLp3KhzQj
	M09anIGx3lAsQw=; b=Zt65agB/0T9TaxO4I//PTjYeqJXiemYMg2jcYK7vzMHyq
	rZnCJ6o+kYaOb2FEnCj3cEil/F1p5kGIka4SZtgzltMwd1pNyuwFy7kdTKjcTKXK
	jvigHb5Yw8MmwP7Q85UFRuswh8AE55Eut9ekpY2c/pcBKALG3/bEWf2g3vB+zUwd
	75Yox2HA/23ostoH5bwl+H3rIImRQ4TrKH1UAMypt0Br8SAaFyDWlvmE3IrNcirG
	T7EngRjG9mL4g6DK+LibCK5c9E/FyDL/VPGdsbW/NZLkq2GCdf35tLqjJ03HvZ4/
	2vP3oLWyURS/lyjPU+C2cq8FXUXQrMyR0hXcmzlwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r11b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 07:21:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55G6fFB6034454;
	Mon, 16 Jun 2025 07:21:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh7anjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 07:21:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55G7Lbd6007621;
	Mon, 16 Jun 2025 07:21:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh7anjc-1;
	Mon, 16 Jun 2025 07:21:37 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: edumazet@google.com, ncardwell@google.com, kuniyu@amazon.com,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org
Cc: alok.a.tiwari@oracle.com, netdev@vger.kernel.org, darren.kenny@oracle.com
Subject: [QUERY] tcp: remove dubious FIN exception from tcp_cwnd_test()
Date: Mon, 16 Jun 2025 00:21:23 -0700
Message-ID: <20250616072134.1649136-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=667 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160047
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0NyBTYWx0ZWRfX4PdpUs+V9tVc dHBrMUfbXyyjjukv12/Nx2mOxXBulBenUTxhLceBgj2vroLWrjQL5c3Lj5KV4+MLk/gsBPpgnH5 f69EX1KpbAxH2rbpFkeUelFeUzxnFMQAlWJjkY9hJS1dvFyLTLrW81WpdTtEygB2FgM+Bj6qyLR
 bwhQ4G6ctiy8Vz/262rLkXemus6D3jFymqJWVAGu5DO4sCM45U+oa/0OiUNwmIrupe6t34yZuNx QYyFih2Qa1CpppJ4ujl93hFqld0lFwao272yo9ZADSPwzGSG/ASBLSNartIxhsnm36L/syz4KOe zEwgI/Dvp5NDmyWKenAwqjv8aGcQ2Uo1wDDSaw1hb3zyaJdRsdAGqyck8AgUcWsa0JfFwSOXrhA
 HsjPLxRx0HIkfv8rhh5vdB1un2EDKWxjvC+32MsEP1yRWDx1ah418bKFAa6mlgM1ZVNNBevM
X-Proofpoint-GUID: YbYrEcEfx1MrLajJIW8QybNoJgzrc5UP
X-Proofpoint-ORIG-GUID: YbYrEcEfx1MrLajJIW8QybNoJgzrc5UP
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=684fc602 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=Da0N1cG-_SoSr0OD1DEA:9 a=zY0JdQc1-4EAyPf5TuXT:22

Hi Eric,

Thanks for the cleanup and RFC conformance improvements.

However, we've observed a performance regression in our testing with 
Apachebench at higher concurrency levels. Specifically, throughput
and HTTP tail latency in workloads.
It seems the previous exception for FIN packets allowed graceful
tear-down even when CWND was full, which is now delayed or stalled.

We understand the motivation for the cleanup, but the change introduces
practical impact for real-world workloads relying on timely
FIN transmission.

Would you be open to discussing potential mitigations?( not sure like
selective FIN override, other approaches.)

Thanks again for your work on this.

Thanks,
Alok

