Return-Path: <netdev+bounces-182036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08B4A877A5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8ED16FAFB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C11A2393;
	Mon, 14 Apr 2025 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jw1zYXRT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041728F4;
	Mon, 14 Apr 2025 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610483; cv=none; b=dZ2sAmTmQfmtrYmf4QshwM8vuLcXJyDyZaMzWdF0c3VXpF2gIYCqToOpel7JveUwFPJUp4POkMBbyX7qQ2rRShS6qLEPp7wb95dwcAgfhpVd+SkKS7SNAG7hCsDJLMPxojSbu6yN5igLYCQWXhBdv06XrMEK0HjNUfxVJ2ZEIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610483; c=relaxed/simple;
	bh=oZAK8zrupjjH+O6tNbwe6KbSyiTI2uGDFByDdDSwCXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMjPxwAasROPIq2ZjBAlGyF4elLWP7Wc1qvLFNu+2dzq3XVylU8XVt8QEy5qy/ygFk6ghuosC2NYKdsO3KfMazMstH9HEAWIVaXoqohlMvgaBmReDH5L3ULXtCZF5VY13qC1ZY7mbU8d879pdZTV45n/Y4RL2Q9YcE+GHDcGHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jw1zYXRT; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so38718716d6.2;
        Sun, 13 Apr 2025 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610479; x=1745215279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L0L1XVEs/40Inqn2wXUAx/QRxfMJixUhrq/LYTX7ULk=;
        b=Jw1zYXRTtV0/wsSGoVh8sq4HMOwSuBQIMQjOYVzG5d1Oqk8vkvj4Um9O9fRY7+sU8T
         FHvSfwwhjF7aD78g1n5NmMtd2yR0CzGy6CU4NSR3Cut5cpZDEQRuG1t47V7MC3vNeq1T
         VsxLAaMVYAo/AiXs7JDx8kE2ILgYzqAdORs3nGiKNsNwGjkyVOw5ZwvzarWXeIzrI2sw
         HkMksynIFnQRjg2L6BTQE2y3pQ86KPYsHTLl/ygqLyNWsKB2YjI/WAdHKzReKS7zg7ki
         ixGoYrqLmLd+iYagKUV64fCkNVE0T94d07Z4Qf9IZWCGgTC/8WAcYVP3L4KvKEEa+YFF
         H20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610479; x=1745215279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0L1XVEs/40Inqn2wXUAx/QRxfMJixUhrq/LYTX7ULk=;
        b=FxriTyLu4pk/Et2bvrysMfbkwksMWIojeXrmWTrlqegrMuiyseKo5hTL8w2AzaBu5I
         OBDNTBDOPyjPOqlndK56iziKZ1MK4CKB8krhpoIDMjxwW0yg6tRe11qN9QQvcHJbJ2I9
         SDBygbdAyaAEeRllW23oJMVBVWaHt5ASRKz+cq7sVS22aOu2KeSXCh1ruDaR/kCzoRiD
         UaP7pNcvz4lAiRFBT8OSM7zLLBwPO1Jl260zy7jJ0ice3ZTev0oxp9QaGstxLooB2nQj
         5YHD6aj/PXXtsgnrviXdx+3VX6EiArn5Lig/mU9cu2MhEMwMUKUwaYdPy8KK6MZEE5gB
         bBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkIT8j1Px90jtoRU4Deb0p7urjFWOFaTz3Qu3enDJfm5GF6Sv+1QqZar4n0ELwUH67h8kf4vQvTmDwGOU=@vger.kernel.org, AJvYcCWGEcQNZviBnK0MybyON8RWOLobmOvUzOgN7PJjrQFnmaLX/mxC1sU/cMTbNeVSzJaD+YhrWdRh@vger.kernel.org, AJvYcCXhS97G9LviOKZtbPb52j9dglaJ8+/IecpZ4Nm/7Tr+ycMvYDov8SeqDzaOUYoHulubFoOL@vger.kernel.org
X-Gm-Message-State: AOJu0YxlR+PVzT6RwXm6hOzE9wj8viUKVRyCDI29/6dd4pZv2Bl6hcuk
	2Z3/MeHu7y6lLVW4yraQ6BdpimMYU4IyMO5f0kM9EPH9Ss3IlVzs
X-Gm-Gg: ASbGncvF8VPE8BPDq+0CuPuvHcBte0mGkEox/WjFT24uYdLPLnJUpaPvXfUqLSGzZbP
	snXqHdxbaUo9+zK9TlGCCGEF7JYGJjIBIYAUfEGgOrWGYJU6LhT7GcfKNdV3lDCyHY3GXmVM2H+
	rJ3V8JLOOAxoaa7SzN86SvyeW7W8sqs1GvAWd1uRGLL/WqEXOC7v5n9+vBFQFBg2tl15IxH6ptd
	I0jEtQv0JaGaHjhtu5Iu9ElQxKTxk5zxDrlpNcv5cIMjHT2dk9QAS/7ChAi+mUoIzUSYk2SBnd+
	VNMOAU2jF/t8Mobove/jKaoxe8KjZ1kbOJkKOCGtSSxhncGjifl7esdLsK0/ZtVV6ARI5SYGXI2
	ILBMF4R+akfyZ2FtOT3pOoHAQA2WbhYI=
X-Google-Smtp-Source: AGHT+IETl7E/+bzwq61cS2fWibUseOcyKaw0dAYo3A+plXELvtQoVtUaR+f6mDLalDZp7TNAsX4tEQ==
X-Received: by 2002:ad4:5c64:0:b0:6e8:ef80:bcbc with SMTP id 6a1803df08f44-6f230cb9778mr167100666d6.5.1744610479281;
        Sun, 13 Apr 2025 23:01:19 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0de11sm682145785a.101.2025.04.13.23.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 23:01:18 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 241701200043;
	Mon, 14 Apr 2025 02:01:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Apr 2025 02:01:18 -0400
X-ME-Sender: <xms:rqT8ZyHTy2LBwH2v3_nnp5OCGu6cEzSlURtWJxHEskXZKhcAKl98oA>
    <xme:rqT8ZzWn2rjwaBl9rg7u_4ZvZXLvVyQGM8PYN7FPvLldyPT_oa0sXuO1wjev7Sxz8
    yq_xji3SfaEpfFJBQ>
X-ME-Received: <xmr:rqT8Z8InjznoLs0NWBUPZoHrW4HjnfN722D88fUkDTQBp18iCwIeC1fb7VOogg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeljeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeggeeukeeghfevudektdevjeehhfekffevueef
    udeivdelteeltdekheejgfeiveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhgvihhtrghoseguvggsihgrnhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomh
    dprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhg
    mhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprggvhhesmhgvthgrrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:rqT8Z8GlZ0cHY8lIpgu0dp1X1nZKRXI0VadFbxDCvEdIs7LcRm-C4w>
    <xmx:rqT8Z4W9PO4LnyzNAeAn2XtR96sZpmUdbU1hma1Kc5AlCpIMHnTHUQ>
    <xmx:rqT8Z_PLpI9zz2SASZvNpjoObvWPwjCr3YIRo_uawWVO-gAiAfDLWA>
    <xmx:rqT8Z_25CGlTdI6lgz_yaJSqvwdtLsOzq8t6GMQL5qcS6l4oaNZvzQ>
    <xmx:rqT8Z5VLvXMdMielQ5yr1d1OyMXftwyE5xipADGIHjlEEGi5eZH7pKT5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:01:17 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Breno Leitao <leitao@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: aeh@meta.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC PATCH 0/8] Introduce simple hazard pointers for lockdep
Date: Sun, 13 Apr 2025 23:00:47 -0700
Message-ID: <20250414060055.341516-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This RFC is mostly a follow-up on discussion:

	https://lore.kernel.org/lkml/20250321-lockdep-v1-1-78b732d195fb@debian.org/

I found that using a hazard pointer variant can speed up the
lockdep_unregister_key(), on my system (a 96-cpu VMs), the results of:

	time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq

are

	(without the patchset)
	real    0m1.039s
	user    0m0.001s
	sys     0m0.069s

	(with the patchset)
	real    0m0.053s
	user    0m0.000s
	sys     0m0.051s

i.e. almost 20x speed-up.

Other comparisons between RCU and shazptr, the rcuscale results (using
default configuration from
tools/testing/selftests/rcutorture/bin/kvm.sh):

RCU:

	Average grace-period duration: 7470.02 microseconds
	Minimum grace-period duration: 3981.6
	50th percentile grace-period duration: 6002.73
	90th percentile grace-period duration: 7008.93
	99th percentile grace-period duration: 10015
	Maximum grace-period duration: 142228

shazptr:

	Average grace-period duration: 0.845825 microseconds
	Minimum grace-period duration: 0.199
	50th percentile grace-period duration: 0.585
	90th percentile grace-period duration: 1.656
	99th percentile grace-period duration: 3.872
	Maximum grace-period duration: 3049.05

shazptr (skip_synchronize_self_scan=1, i.e. always let scan kthread to
wakeup):

	Average grace-period duration: 467.861 microseconds
	Minimum grace-period duration: 92.913
	50th percentile grace-period duration: 440.691
	90th percentile grace-period duration: 460.623
	99th percentile grace-period duration: 650.068
	Maximum grace-period duration: 5775.46

shazptr_wildcard (i.e. readers always use SHAZPTR_WILDCARD):

	Average grace-period duration: 599.569 microseconds
	Minimum grace-period duration: 1.432
	50th percentile grace-period duration: 582.631
	90th percentile grace-period duration: 781.704
	99th percentile grace-period duration: 1160.26
	Maximum grace-period duration: 6727.53

shazptr_wildcard (skip_synchronize_self_scan=1):

	Average grace-period duration: 460.466 microseconds
	Minimum grace-period duration: 303.546
	50th percentile grace-period duration: 424.334
	90th percentile grace-period duration: 482.637
	99th percentile grace-period duration: 600.214
	Maximum grace-period duration: 4126.94
	

Overall it looks promising to me, but I would like to see how it
performs in the environment of Breno. Also as Paul always reminds me:
buggy code usually run faster, so please take a look in case I'm missing
something ;-) Thanks!

The patchset is based on v6.15-rc1.

Boqun Feng (8):
  Introduce simple hazard pointers
  shazptr: Add refscale test
  shazptr: Add refscale test for wildcard
  shazptr: Avoid synchronize_shaptr() busy waiting
  shazptr: Allow skip self scan in synchronize_shaptr()
  rcuscale: Allow rcu_scale_ops::get_gp_seq to be NULL
  rcuscale: Add tests for simple hazard pointers
  locking/lockdep: Use shazptr to protect the key hashlist

 include/linux/shazptr.h  |  73 +++++++++
 kernel/locking/Makefile  |   2 +-
 kernel/locking/lockdep.c |  11 +-
 kernel/locking/shazptr.c | 318 +++++++++++++++++++++++++++++++++++++++
 kernel/rcu/rcuscale.c    |  60 +++++++-
 kernel/rcu/refscale.c    |  77 ++++++++++
 6 files changed, 534 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/shazptr.h
 create mode 100644 kernel/locking/shazptr.c

-- 
2.47.1


