Return-Path: <netdev+bounces-200908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 780B9AE751D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169621922372
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027821D63F8;
	Wed, 25 Jun 2025 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/2/ozm5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6753D76;
	Wed, 25 Jun 2025 03:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750821087; cv=none; b=EtOb0MDSTQ4qhmBWRj6VpQ7KRk9A3bfOgIQaI3/B10r2zDiihepDx81PIyez9xfnxRT1fjIl6Uz6tBZrQWuEBXsA36nwmTEQeud4G+WjOIfvY/4ixqbl6mJp15RfVW5DTjJ0BYGBNtfeA5sd0klKl7wTY8iipL9UGzrtVWMB+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750821087; c=relaxed/simple;
	bh=dmJlZNkGnYr4lMKNh/KeJpM+mdF8w7szhNRQjOFxOSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pI+iF9r0iTbn++D7P73xi7cDI4j36zvWDNeuHKlLzYLj9xlQ5xBJge7nx1d7O7kmzh5CjjQsnigDDAqS7/JXXugdv1AHAoLRU4y7IVaSOUziDXPolnjoNzMglPQy/LWjJxh9j9lmtD3YdaNx1zXEuTRU9WlVmReWZAIwAGqw0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/2/ozm5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso5338696d6.1;
        Tue, 24 Jun 2025 20:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750821085; x=1751425885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=37wLyUOFnEhvbHdZdl11U23f9N/UOWSnFyRj6lojqvw=;
        b=J/2/ozm5KrTcAYJSKEs35JdF9evp2dk7cR5TNUppb0f0pXC3bzo4A1PTKThd9YREi5
         kkYzKJ/r02MeRO7WuutRc+5HYnu8enhRgwfjvcWCirvj1sJqQyzTWHGkBE21kqZXnJA6
         WuXkWXd6b4gOa05ZN8fuXDGYht4uTGqGA+hJMu1/Lo2DR9ENtH4qA5GQowLErAC8kAmr
         NcbsPLgBMZdvUpSUHpXQG1MBX1eO6Llr3TEWw7b72ToJLCd48ycBQmRCT4SXK402bP1W
         CgmjX5uiLJFel9qxV/6LvSkF5ZyPIoCaLafXHW/JFPqT1vyBEziHzU0b5b0vbbZc2nJm
         jPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750821085; x=1751425885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37wLyUOFnEhvbHdZdl11U23f9N/UOWSnFyRj6lojqvw=;
        b=Hn//Zu4EtaMfcBPd0ofpCU3TjCKEcq89mx8i19stPGTAjsYTgLHR09rFd1snrgeytO
         UQj5qanPmVOyCwxnCc7dv0jJVgDqeJ0HUUpxMBaSym8mtbf0hvJbZU++SEOPUO5poHf+
         iy5KYqg72+qilHlvHRrYRyCrqUlqT8BQEci9hQuIjMVpOkgOxTDA+Wd8cIjaXT6q+l4L
         tDH/r8KFDwrRDjYpMkPJrPaexUth78sOtuj7VR9kyB3mj4IYHIfGT2Uu+GogvemDz8iT
         q/J0CSUJWJj7qEOFyxNIDpgDFVVTnw0vjt+iyVt85JKdmJa0zUzU63ZLWh57WOCTFm+X
         bd+w==
X-Forwarded-Encrypted: i=1; AJvYcCWBXIrBnWZaWvVaUfz1DKl5mE7BUGeSroUzHUiMwQTj2MYXWyYtTzUjaxcU/lMYPRdD9JU1@vger.kernel.org, AJvYcCX6ZnJMJ8gm/yxcRirLtKSa023g0ZEH8O6n8oRl0YUsf0UgU4YCcVCw+tf71I+L1wbZZ9EgT9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/33UaszWA4dHrWS3DZFpETyN4SP+iGsXJ5MHnZBqRybGnnb4
	UIapSLQ0r2VNKk6kona4I1y0fLz7xqmCgzc6B1qS/s4lgQqmnT68sQej
X-Gm-Gg: ASbGncvB7x/QphMk2e/iOpTRQi68T9I6igVPZ0upnCxUYouSaUGEEJ0zhWfMY0zRfg/
	xbLEPAqpi+S9wGlf9/ZNq5Wwpvj1Ug1zpU1vZ6xWeB82ALYDVEPIJTBmj2N0uGU81dLU7CVKeG6
	XSQsdEuwmms9UQjzebzJI7084kGVBLRsi3KXWguFydiCxv48wvC6WucheHS7KGBQO+NASaak5cQ
	emFhWqqN5sj1LyySpu69scYvtGbREK/ajmnnRpY4dRld5I4yIZt3V37E+hXEPaTRaU9tSB3Ujal
	daAsY2aokfDZ2ApZmCMG+nl78pq2ELA8WH5pxZzUh0sinHtYQYjxr+KybXF2YwKHGY7vltArOCf
	7YFDICOdS1T4y/lup4pEQMYCa9b2LhdLDzM4pyPutemE3VHAPkHJh
X-Google-Smtp-Source: AGHT+IEaKhNkzW0FbV9f70GZpEk7DuWFP3tTqujTO5SU7v0JJSU26+B+8T1tUhbIvgQO9vAEkRQw4A==
X-Received: by 2002:a05:6214:4f14:b0:6fa:edb8:b343 with SMTP id 6a1803df08f44-6fd387ec5b8mr75990336d6.2.1750821085027;
        Tue, 24 Jun 2025 20:11:25 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99efaa9sm567189785a.58.2025.06.24.20.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:11:24 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9CE32F40066;
	Tue, 24 Jun 2025 23:11:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Jun 2025 23:11:23 -0400
X-ME-Sender: <xms:22hbaLUxtLizeeFIafMYrMGPO6_IUUROpxUeMU-9dXMgPpLVSv5-JQ>
    <xme:22hbaDnkM5oDjL7Fb72WmIxb1SAadqxuznNCFtw914xf2mbBqY4QqpIX-VBMDJXL5
    RbwiyXW6PFZNs0l8Q>
X-ME-Received: <xmr:22hbaHa6DxExEPIbPJ2_uMAz2a_Hw4xJHrsLKy0mV-dtHV6UMLmrzSfTAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghn
    ghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epgeegueekgefhvedukedtveejhefhkeffveeufeduiedvleetledtkeehjefgieevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    mhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvg
    esshhtghholhgrsghsrdhnvght
X-ME-Proxy: <xmx:22hbaGXU4-JtYzfbe7cuBsHYKmE_1xV7XkWwHwwfiJ0JVw1rA7CSlA>
    <xmx:22hbaFnxM-vxVdj0pYO1Kgig0ovL9XbDKLHawDGt-k70AQw5LeYj1w>
    <xmx:22hbaDdV5vwCEe1RFQ5s0JQ_isQr0qpXEQmLRbcmtb5U3JJRmKoazQ>
    <xmx:22hbaPFD81Gef9jXtG6HTgG6fTqC8h8qsh_iZkeVYp6rvJyOD83f1Q>
    <xmx:22hbaHlAexzm1mL7loKjEe67Ld19d_IzmXP54NmhEH7thDh5YDmL9ehm>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 23:11:23 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	aeh@meta.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: [PATCH 0/8] Introduce simple hazard pointers for lockdep
Date: Tue, 24 Jun 2025 20:10:53 -0700
Message-Id: <20250625031101.12555-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is the official first version of simple hazard pointers following
the RFC:

	https://lore.kernel.org/lkml/20250414060055.341516-1-boqun.feng@gmail.com/

I rebase it onto v6.16-rc3 and hope to get more feedback this time.

Thanks a lot for Breno Leitao to try the RFC out and share the numbers.

I did an extra comparison this time, between the shazptr solution and
the synchronize_rcu_expedited() solution. In my test, during a 100 times
"tc qdisc replace" run:

* IPI rate with the shazptr solution: ~14 per second per core.
* IPI rate with synchronize_rcu_expedited(): ~140 per second per core.

(IPI results were from the 'CAL' line in /proc/interrupt)

This shows that while both solutions have the similar speedup, shazptr
solution avoids the introduce of high IPI rate compared to
synchronize_rcu_expedited().

Feedback is welcome and please let know if there is any concern or
suggestion. Thanks!

Regards,
Boqun

--------------------------------------
Please find the old performance below:

On my system (a 96-cpu VMs), the results of:

	time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq

are (with lockdep enabled):

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
2.39.5 (Apple Git-154)


