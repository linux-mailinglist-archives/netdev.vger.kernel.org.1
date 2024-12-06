Return-Path: <netdev+bounces-149856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67679E7C5A
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 00:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A06168418
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707F1206276;
	Fri,  6 Dec 2024 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mllllqPx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46BB1F4706
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733527319; cv=none; b=uhPFuG1Wc9MP21sFeyQPsrIRok2x71ptHqr/7cF42ZY29cOAnjkCBsfsBnUrAvykue4VBpNMKl9ege1jDE8FFoGTx5PnYysUxge3YvGV21DF6ghuyAEtF7g6R/uYL3w1n9vjQ6RjeeDe9QMEi6bPOv/PRKvx+p70CdEJxQTogQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733527319; c=relaxed/simple;
	bh=0bonyb2+WJRzjBdxD+ZrsHEC9us5V65tUoSXK7qfKFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3Cp01GGg3N8R7WhwwH/T2UhhEiF/m/eMpDGykFaoIrmw3XHwUno+BCtN0jhjQFzRNDBIWiRdmcU6ZWMVDR/6X29PlSS2zkmwXEQsasLRU6ijhv/j4WQHHK1Gt5kUmDmlIpVFfi+cuIsuHFkEzB8Wso4uaK5cxlPZ4zZeiqsa1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mllllqPx; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733527318; x=1765063318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qe2zMDToM7P32e1KJBNnMK8z2CPgdPUI6k6n83QfRYc=;
  b=mllllqPxnuM3/uY9dsMtH8sP2HzCBK6vZBmKL6lFWt0P10ArgDON/lo8
   UckBc4r5nbTrAydlCRBud+fW3Moqy7yW9VFtao+WAIWa9/m20qucRdxDL
   ki38aUesT31u2sTO72URmjWVykQU2IMnQI3l92x+0KWlZyf0Md5tS4g0j
   g=;
X-IronPort-AV: E=Sophos;i="6.12,214,1728950400"; 
   d="scan'208";a="781518021"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 23:21:53 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:2904]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.2:2525] with esmtp (Farcaster)
 id a77bb2d8-1215-4311-ab59-6edaaeb0ce36; Fri, 6 Dec 2024 23:21:52 +0000 (UTC)
X-Farcaster-Flow-ID: a77bb2d8-1215-4311-ab59-6edaaeb0ce36
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 23:21:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.240.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 23:21:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lkp@intel.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <llvm@lists.linux.dev>, <netdev@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 08/15] socket: Pass hold_net to sk_alloc().
Date: Sat, 7 Dec 2024 08:21:45 +0900
Message-ID: <20241206232145.37548-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <202412070526.FhqWmbBo-lkp@intel.com>
References: <202412070526.FhqWmbBo-lkp@intel.com>
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

From: kernel test robot <lkp@intel.com>
Date: Sat, 7 Dec 2024 05:43:05 +0800
> >> net/iucv/af_iucv.c:455:59: error: too few arguments to function call, expected 6, have 5
>      455 |         sk = sk_alloc(&init_net, PF_IUCV, prio, &iucv_proto, kern);
>          |              ~~~~~~~~

Oh, PF_IUCV depends on CONFIG_S390, that's why I couldn't catch it
with allmodconfig and allyesconfig :/

---8<---
config AFIUCV
        depends on S390
---8<---

