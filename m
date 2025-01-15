Return-Path: <netdev+bounces-158431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66732A11CFD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DC13A2A9D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265021DB125;
	Wed, 15 Jan 2025 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rMtWOAUf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6D246A10
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932172; cv=none; b=EyyOhMVrvnz1TdH+r/Kv9Ko4XwThvX4l1+hkH0yLg042Q3ukoHzwpJJptySvk0o7GJp2IdUAmpozp/H9V+ErLC2OLAPRaW76NTDSdwXhxN+YKIqNwfgULXzx/r10sBaxzHjhSP0SWDVJ1UlmY2lznp7fWza9s3Mri43VG8CNdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932172; c=relaxed/simple;
	bh=YU0yfQjjIqlyZBSzs7O3f88UBOnAvfOk6W9ClBZhAb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUyV6gr7uwsyIOHRBj0gViEzTwCYNMQFtvUsEkDHGFW0BH/+2KayMaUVrjfZyV83x0sENQSRNa/WsGD4FlW5Dn/HSiIGrQ279aTbXvwtKl092bmaxsFYyBpozApX0owqyG5Czl72QCVi3H7n4HnX5E3PbDCxnfr35fukvi+3IRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rMtWOAUf; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736932171; x=1768468171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3cdBxCoRRgx8Fcqd5xvXGD5FcZwUriXa08l62q9YqCg=;
  b=rMtWOAUf+XLMM8VZPUJPm9cbdZhpT3o3S61REo4lX2s5nBCNGjuH2dBs
   ko9aKjGRN+kT53pyBi+Ul+o3SEbMXkXkIMUC/iKGglwct+LlFhD9r4+8q
   v5zf7l57ycLP5EhigcpUODlSPuD1oO1Hymo1E9EfXmC4BlgDRovR5Nbgz
   w=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="464231716"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:09:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:8590]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.28:2525] with esmtp (Farcaster)
 id 70d69e8e-260e-4e94-a805-54a4cb1657b5; Wed, 15 Jan 2025 09:09:24 +0000 (UTC)
X-Farcaster-Flow-ID: 70d69e8e-260e-4e94-a805-54a4cb1657b5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:09:24 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:09:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jdamato@fastly.com>, <leitao@debian.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 08/11] net: protect threaded status of NAPI with netdev_lock()
Date: Wed, 15 Jan 2025 18:09:10 +0900
Message-ID: <20250115090910.45363-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-9-kuba@kernel.org>
References: <20250115035319.559603-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:16 -0800
> Now that NAPI instances can't come and go without holding
> netdev->lock we can trivially switch from rtnl_lock() to
> netdev_lock() for setting netdev->threaded via sysfs.
> 
> Note that since we do not lock netdev_lock around sysfs
> calls in the core we don't have to "trylock" like we do
> with rtnl_lock.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

