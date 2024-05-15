Return-Path: <netdev+bounces-96449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C88C5E53
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 02:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942971C20C2B
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 00:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C00B370;
	Wed, 15 May 2024 00:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g4CW806I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95168639
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715733142; cv=none; b=RcQvNElkJsipxr4WhSyZgdxFM1OBLTBR1ZsUmMMIFsDq4vEOdGrG3NsEyNNRdD9zXMDzu1Tx/emrrYDkrZvUh7ImP7b3XZpKnzq8UOx2xdHv4jKpwJlvvdhGdsZUIEJZnGEfxVy+PaSwchM0XcdtHzl0srPZGFEzSgaJqDGVE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715733142; c=relaxed/simple;
	bh=GbiB6FNqy6DZaTQKPR6SwjJeQl1r4mUNqRz7TYiPKII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bakl0VD1LfDF4i7vKeIKtgh5v13jVchFouVlu4tFBcXrikDV5yFy3Vu/kXnsusBgwvBB0SJWR1+nTAqmKtF0GnKw9OjjWNislSSmljAK0EQz7LGB768VH3NTpetyZzSGZKceUU8fsPYkJtuzNBnlVb84dX2AW2ebk5j0f8ToKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=g4CW806I; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715733141; x=1747269141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CX0jeLs8If2rvdiWjLkptGUk6++ql5TnLzzepsDHRvg=;
  b=g4CW806IUpn7ICuiBQDlwOVFVJN5pnWAEGd+qsIEpQkd5JFeb65Rbv2d
   i0/bmIkqm6x7v/Gxa9o8y/PGu6HnccV/sJfxhfhQmiDyYGxX3hibizKpq
   knAxehR2dMMfIBB4aHw7Zfl5eAoWvKHadWh3dxutwtu/QsKKjQMIhtxe6
   8=;
X-IronPort-AV: E=Sophos;i="6.08,160,1712620800"; 
   d="scan'208";a="89197408"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:32:19 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:13314]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.62:2525] with esmtp (Farcaster)
 id c035546d-74f7-4f54-82d4-c5a9ca5be701; Wed, 15 May 2024 00:32:19 +0000 (UTC)
X-Farcaster-Flow-ID: c035546d-74f7-4f54-82d4-c5a9ca5be701
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 May 2024 00:32:19 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.6.43) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 May 2024 00:32:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, Michal Luczaj <mhal@rbox.co>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net 0/2] af_unix: Fix memleak and null-ptr-deref around MSG_OOB and GC.
Date: Wed, 15 May 2024 09:32:02 +0900
Message-ID: <20240515003204.43153-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The patch 1 fixes memleak caused by SCM_RIGHTS OOB skb sent to embryo
socket, and the patch 2 fixes null-ptr-deref caused by OOB data.


Changes:
  v5:
    * Add patch 1

  v4: https://lore.kernel.org/netdev/20240514025250.12604-1-kuniyu@amazon.com/
    * Free oob skb properly (Simon)

  v3: https://lore.kernel.org/all/20240513130628.33641-1-kuniyu@amazon.com/
    * Fix lockdep false-positive by calling kfree_skb outside of
      recvq lock (Michal)

  v2: https://lore.kernel.org/netdev/20240510093905.25510-1-kuniyu@amazon.com/
    * Add recvq locking everywhere we touch oob_skb (Paolo)

  v1: https://lore.kernel.org/netdev/20240507170018.83385-1-kuniyu@amazon.com/


Kuniyuki Iwashima (1):
  af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.

Michal Luczaj (1):
  af_unix: Fix garbage collection of embryos carrying OOB/SCM_RIGHTS.

 net/unix/af_unix.c | 28 ++++++++++++++++++++++------
 net/unix/garbage.c | 21 +++++++++++----------
 2 files changed, 33 insertions(+), 16 deletions(-)

-- 
2.30.2


