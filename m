Return-Path: <netdev+bounces-91383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A25C8B2664
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 18:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3D61C22643
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2DA14D2B2;
	Thu, 25 Apr 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GM6HP9G4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF814D2B8
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062387; cv=none; b=KUYG5r0vugKF2296wqGFvVjRwJqyIUNfbKPxrCwA+IbnZCJ/PIWPCdPjV7BYvMAJTCxTRkLGiZmEmdWo0wuCgzSU1Kkemep3IuP5uLJknkxrWs2Bn8sRmPI8u/AegvU2cKC+TxiMmc8H0OtoeQz5hxcXLy8urHLqlt9nMJe/VKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062387; c=relaxed/simple;
	bh=3Uku4TZ5/KNDcJc2wT46oHmkmk3mE3Mxl+WtmNFjizY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eme/LzctsbOrm75JvEYCndVZTW9sojnvGSpcvtaxl3QhzoFCP+bB2jXmaJp9FCToo6+ZCXd3Ta/w0essYzUce4go5pkS1Nqh0jePVvb7fu5p23mAHTedx/9Ufdr+V9Ret8qg3OXPS2dH3GCaImPH5HFAoufnLcaWjB0tiMQy7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GM6HP9G4; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714062387; x=1745598387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mg+cZ6DeGKSrRLdb9zY/0LmHodQLa+dc+HEOgL3dhPE=;
  b=GM6HP9G4oWA2Z4WsPwOR+9y91cD+XCPlynO5W9XjrBwKfLNuVxxfPUz1
   6lAApftui6J4qG1Fxb0SbNMYrzKrl3KGUa9kgesljhPiY6kk1uBE7lahu
   JzjgUh7Ov8LLB9uYE1DFm/ly7apO04TUdwCO0vpMitQcM2eYL8QkpiqrH
   8=;
X-IronPort-AV: E=Sophos;i="6.07,229,1708387200"; 
   d="scan'208";a="402894006"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 16:26:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:55009]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.242:2525] with esmtp (Farcaster)
 id dde806a3-db0b-45fe-981d-ba0a8d357b6c; Thu, 25 Apr 2024 16:26:22 +0000 (UTC)
X-Farcaster-Flow-ID: dde806a3-db0b-45fe-981d-ba0a8d357b6c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 16:26:20 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 16:26:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dan.carpenter@linaro.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <lkp@intel.com>,
	<netdev@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
	<oe-kbuild@lists.linux.dev>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 5/6] arp: Get dev after calling arp_req_(delete|set|get)().
Date: Thu, 25 Apr 2024 09:26:09 -0700
Message-ID: <20240425162609.63388-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <047e4452-c694-4dea-9273-74ebc3a2892c@moroto.mountain>
References: <047e4452-c694-4dea-9273-74ebc3a2892c@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 25 Apr 2024 08:32:22 +0300
> Hi Kuniyuki,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/arp-Move-ATF_COM-setting-in-arp_req_set/20240423-035458
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240422194755.4221-6-kuniyu%40amazon.com
> patch subject: [PATCH v1 net-next 5/6] arp: Get dev after calling arp_req_(delete|set|get)().
> config: i386-randconfig-141-20240424 (https://download.01.org/0day-ci/archive/20240425/202404251215.QHgck00A-lkp@intel.com/config)
> compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202404251215.QHgck00A-lkp@intel.com/
> 
> smatch warnings:
> net/ipv4/arp.c:1242 arp_req_delete() warn: passing zero to 'PTR_ERR'
> 
> vim +/PTR_ERR +1242 net/ipv4/arp.c
> 
> 8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1235  static int arp_req_delete(struct net *net, struct arpreq *r)
> 46479b432989d6 Pavel Emelyanov   2007-12-05  1236  {
> 8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1237  	struct net_device *dev;
> 46479b432989d6 Pavel Emelyanov   2007-12-05  1238  	__be32 ip;
> 46479b432989d6 Pavel Emelyanov   2007-12-05  1239  
> 8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1240  	dev = arp_req_dev(net, r);
> 8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1241  	if (!IS_ERR(dev))
> 
> The ! is not supposed to be there.

Oh, I don't know why I added it :S
Will fix it, thank you!


> 
> 8f4429edb1b716 Kuniyuki Iwashima 2024-04-22 @1242  		return PTR_ERR(dev);
> 8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1243  
> 46479b432989d6 Pavel Emelyanov   2007-12-05  1244  	if (r->arp_flags & ATF_PUBL)
> 32e569b7277f13 Pavel Emelyanov   2007-12-16  1245  		return arp_req_delete_public(net, r, dev);
> 46479b432989d6 Pavel Emelyanov   2007-12-05  1246  
> 46479b432989d6 Pavel Emelyanov   2007-12-05  1247  	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
> 8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1248  
> 0c51e12e218f20 Ido Schimmel      2022-02-19  1249  	return arp_invalidate(dev, ip, true);
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  1250  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

