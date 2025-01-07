Return-Path: <netdev+bounces-155690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5E1A0357B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FAD7A11BF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E8170810;
	Tue,  7 Jan 2025 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="cZqJeGS4"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03C1CAA4
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218369; cv=none; b=hhldJJclB8sNKLywIwMl1vR7juRtjYqq8DvSf5BTMOfl20XExydPztOhL6W1RlJ02gX2g2+0cYBN+x6J4zBB0kmUkMikp0fCFZ3L8z33kL+0xXGK6qvbJ0oClXU+iWdKyyQ417Lgy9q8r5rDX0WAWDeZNFN3oZb40sd+JUx55TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218369; c=relaxed/simple;
	bh=wrrWZ37XS8COhlFGxNgUNaJypWgNLrALA7jZ0Cl7jFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTuAlS3SJKIhYNFSI/Bpk1r2ObBvh/6enId9ltowXrXLMPKGfc7SENCGXYMJTlRcBLfG06sML+fHrZ0/ArF1eBL2O22FsX6O0+AmzsMpkLCPvQTxH/qLnuSeXLPvvIOQ8CIdT8d7TLm8rOgQg1npPE6wnNspDFD7Z8hSx6s90xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=cZqJeGS4; arc=none smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=431; q=dns/txt; s=iport;
  t=1736218367; x=1737427967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BkvJjESOhq7TXOTiGQhQfEhuOEqFuDKLiSEVy+LP65I=;
  b=cZqJeGS4M5Nyj9SnPHZ5OHzid/gs1BBJ8w1WaV5CzLQlVUtLF1vrna8W
   Z7VBh777Bc+bECy1yWqnXs80ighMv76hqwRZmapqXMzK7jkLOLTSckkBz
   XBnVznYns30QNCjWQiQJfSN43EHDnRi4clJDr/nKl/9FOGmlwAX/1HlNa
   U=;
X-CSE-ConnectionGUID: tibSiTMIQ8SYSISglaj1AA==
X-CSE-MsgGUID: t83WJY5ARV25BoeLsiV0Cw==
X-IPAS-Result: =?us-ascii?q?A0AiAQBllnxnj5EQJK1aHgEBCxIMgggLhBpDjhmnDYF+D?=
 =?us-ascii?q?wEBAQ9EBAEBhQeKdgImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBA?=
 =?us-ascii?q?QIBBwUUAQEBAQEBOQVJhgiGXTYBRoEMMoMTgmUDsECCLIEB3jOBbYFIhWuHX?=
 =?us-ascii?q?3CEdycbgUlEhA5vhRCFdwSDfoNunXRIgSEDWSwBVRMNCgsHBYE5OgMiCwsMC?=
 =?us-ascii?q?xQcFQIVHxIGFQR0RDmCRmlJNwINAjWCHiRYgiuEXIRHhFaCSVWCSIIXfIEag?=
 =?us-ascii?q?m5AAwsYDUgRLDcGDhsGPm4HnxCBDnyBGZN8kh+hA4QlgWOfYxozg3EBpmGYf?=
 =?us-ascii?q?CKkJYRmgWc6gVszGggbFYMjURkPjjq4ECVuAgcLAQEDCZF0AQE?=
IronPort-Data: A9a23:GcfHq6xzj1lyNWjk7e16t+fSxirEfRIJ4+MujC+fZmUNrF6WrkVWm
 mpKUWuPOvfcZTP0f9B/a43n/UoG6pPWnNE3SAtupFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/lH1b+CJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 ImaT/H3Ygf/hmYtajxMsMpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJF03N7YZxsNWODF1x
 Mc5Ez8JZxLarsvjldpXSsE07igiBMDvOIVavjRryivUSK52B5vCWK7No9Rf2V/chOgXQq2YP
 JRfMGQpNUidC/FMEg9/5JYWnuCogHX2dzBwo1OOrq1x6G/WpOB0+OS1boSOIobTHa25mG6E9
 jn53VWkKyskboG1zjeh6XOS3sTQyHaTtIU6T+DgqaUw3zV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVUBq/r3qJ+BUbXrJ4EPAw4SmOx7DS7gLfAXILJhZIbtA8udB1QzE22
 lKXt9f0Azopu739YWqU/LqSrBuoNCQVJHNEbigBJSMD7sXvrZ8bkB3CVJBgHbSzg9mzHiv/q
 w1mtwA3g7EVyMpO3KKh8BWf03Snp4PCSUg+4QC/sn+ZAh1ReI+vXI2UzHnivc1xF6eiQV2Iv
 iEtsp3LhAwRNq2lmCuISeQLObim4feZLTHR6WKD+bF/rlxBHFb9IehtDCFCGat/DioTldbUj
 K7vVeF5ucY70JiCNPMfj2eN5yIClvCI+TPNDau8Uza2SsItHDJrBQk3DaJq40jjkVI3jYY0M
 oqBfMCnAB4yUPs8kmPmF7xFieB7mkjSIF8/o7imkXxLNpLDNRaopUstagDmgh0Rtfnd+VuJo
 76zyePVm00DCoUSnRU7AaZIcAhVdiJkbXwHg8dWbeWEahF3A30sDuSZwLUqPeRYc1d9yI/1E
 oWGchYAkjLX3CSfQS3TMyALQO20B/5X8ylkVRHAyH70gBDPl67zt/9HL/PavNAPqIRe8BKDZ
 6NcIJ/aW6kRFmqvFvZ0RcCVkbGOvS+D3WqmVxdJqhBmF3K8b2QlIuPZQzY=
IronPort-HdrOrdr: A9a23:6g+uDK4l+hCTSz2gxgPXwMPXdLJyesId70hD6qm+c3Nom6uj5q
 WTdZsgtCMc5Ax9ZJhCo6HjBED/exPhHPdOiOF7V4tKNzOJhILHFu1fBPPZsl7d8+mUzJ876U
 +mGJIObOHNMQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AuQCVeWow/q6bdi81PSiIrGDmUdwkeEbc8FLxGh+?=
 =?us-ascii?q?DOF1Ic7KRQF3J0Yoxxg=3D=3D?=
X-Talos-MUID: 9a23:XBQgSwQw/0ACE5BWRXTw1GpdFvY1yp6QUh0nlpgioMi6bQdvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,294,1728950400"; 
   d="scan'208";a="406630210"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Jan 2025 02:51:40 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-08.cisco.com (Postfix) with ESMTP id 957221800022D;
	Tue,  7 Jan 2025 02:51:40 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 5FAF620F2003; Mon,  6 Jan 2025 18:51:40 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>
Subject: [PATCH net-next 0/2] enic: Set link speed only after link up
Date: Mon,  6 Jan 2025 18:51:33 -0800
Message-Id: <20250107025135.15167-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-08.cisco.com

This is a scaled down patch set that only contains the independent
link speed fix which was part of the patch set titled:
    enic: Use Page Pool API for receiving packets

John Daley (2):
  enic: Move RX coalescing set function
  enic: Obtain the Link speed only after the link comes up

 drivers/net/ethernet/cisco/enic/enic_main.c | 64 ++++++++++-----------
 1 file changed, 32 insertions(+), 32 deletions(-)

-- 
2.35.2


