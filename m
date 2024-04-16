Return-Path: <netdev+bounces-88480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3253C8A75EF
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10CD2830DB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEED43AC5;
	Tue, 16 Apr 2024 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oPxjcyhl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA954206F
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300711; cv=none; b=k1YoBxdDF8Fwup/AD364Hq4MYCTin+Jy6pOSqZqDmqHuCIu0Yk3O5Gys7J6aoKL1kxfJVJ2MNsmiuiI590DLqGyqH6VEViatpK8O8zScqYgGy0oS/a05m8UfO0l7/K6ez5PNufpfkgCJp0V5HlLSzs/tIeUG0EQnvyeSFKyXeJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300711; c=relaxed/simple;
	bh=2fVxELkYj4lK4DBDxCL78FXrpBwhFrh6thNtD36U0bA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AY+6Gv8dFPzibJU5uIheTEV0KLWxgjjJlSxyXzfjHBlSOyYifIpEN1jNPyrV812ighyVpkJqNER9Uc2Jb7PiBztKGQbkFsZ/qZNTc9r5ceDg0EO5dsnm8D5+EdyuBvuNzbY15htvltl1vnvrr4TW4tffTQOTJcVnst9wfJSULIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oPxjcyhl; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713300710; x=1744836710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w0NIEz9U6LLqor5JfVsXFzsWVSFoTmEetuo62R13FJk=;
  b=oPxjcyhlnodZELxCddVB8T4coVHb8WWTsPX5en00syHYV91B04qTc0I0
   QyZqkqDjYlXM/LhKFAuTczeABVszX+h6VG4smT66a/SwJbhGYe41Byygb
   qtVcOO1U9Sdtndy8/1/vxZa6FWuDQcIcB0De7NooHtnwDJ3zJQ3W71vA+
   E=;
X-IronPort-AV: E=Sophos;i="6.07,207,1708387200"; 
   d="scan'208";a="626925440"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 20:51:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:37553]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.136:2525] with esmtp (Farcaster)
 id a73803e4-7151-47b2-9dbb-dce0cd40c54b; Tue, 16 Apr 2024 20:51:41 +0000 (UTC)
X-Farcaster-Flow-ID: a73803e4-7151-47b2-9dbb-dce0cd40c54b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 20:51:36 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 20:51:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net 2/2] af_unix: Don't peek OOB data without MSG_OOB.
Date: Tue, 16 Apr 2024 13:51:25 -0700
Message-ID: <20240416205125.13919-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <3e4ba1b4-ded8-4dd9-9112-a4fb354e1f55@oracle.com>
References: <3e4ba1b4-ded8-4dd9-9112-a4fb354e1f55@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <rao.shoaib@oracle.com>
Date: Tue, 16 Apr 2024 13:11:09 -0700
> The proposed fix is not the correct fix as among other things it does 
> not allow going pass the OOB if data is present. TCP allows that.

Ugh, exactly.

But the behaviour was broken initially, so the tag is

Fixes: 314001f0bf92 ("af_unix: Add OOB support")


TCP:
---8<---
>>> from socket import *
>>> s = socket()
>>> s.listen()
>>> c1 = socket()
>>> c1.connect(s.getsockname())
>>> c2, _ = s.accept()
>>> 
>>> c1.send(b'h', MSG_OOB)
1
>>> c1.send(b'ello')
4
>>> c2.recv(5, MSG_PEEK)
b'ello'
---8<---

Latest net.git
---8<---
>>> from socket import *
>>> c1, c2 = socketpair(AF_UNIX)
>>> c1.send(b'h', MSG_OOB)
1
>>> c1.send(b'ello')
4
>>> 
>>> c2.recv(5, MSG_PEEK)
^C
---8<---

314001f0bf92:
---8<---
>>> from socket import *
>>> c1, c2 = socketpair(AF_UNIX)
>>> c1.send(b'h', MSG_OOB)
1
>>> c1.send(b'ello')
4
>>> c2.recv(5, MSG_PEEK)
b'hello'
---8<---


> 
> I have attached a patch that fixes this issue and other issues that I 
> encountered in my testing. I compared TCP.

Could you post patches formally on top of the latest net.git ?
It seems one of my patch is squashed.

Also, please note that one patch should fix one issue.
The change in queue_oob() should be another patch.

Thanks!

