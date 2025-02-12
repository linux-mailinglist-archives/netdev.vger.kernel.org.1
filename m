Return-Path: <netdev+bounces-165624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC8A32DB8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365BD18864F8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6F025D527;
	Wed, 12 Feb 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq+Hgnow"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4B25D521;
	Wed, 12 Feb 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382217; cv=none; b=a2WjSugjJz5H+c4U7u4zdHH8kD2i4IaMLLjCBgN4TSDbiTcRAZos3QsmUrJt/WhimsR0jrxm1H5DblJcmiTbUOuKEfrT94C5S1/qzhfXJoigpmkLb4ys+x5jBFGBMMSjjsN/dpvrYslXlBFuyMuSmNo02E9RZwwNz0j3MRb7WAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382217; c=relaxed/simple;
	bh=wjUh0aGtZGC658fQISI3gzZ3TUnM9+r45/0wT2A9N9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ik8m4dFapDaH4asDhFAE3ryabZ/bkbWpEdYgRsQAJV13Ph6Yut2fH/Hpaf5F8mkTJgAVTM3KTaq2zzJp+0YdzlDGEjnBNKDGNMRN7/Mx1yGcivkFVLLz7OqCR1uBr/xcZb/wmKRu718bZZyZfeLsbsowYav95KpzK/18PQjWt80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq+Hgnow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5E5C4CEDF;
	Wed, 12 Feb 2025 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739382217;
	bh=wjUh0aGtZGC658fQISI3gzZ3TUnM9+r45/0wT2A9N9E=;
	h=From:To:Cc:Subject:Date:From;
	b=Dq+HgnowmmIsMIS5JXJ1nZg5gJpqMExrlM9FA44v0pWSWi17Zi5XT7maw4NypLwSk
	 hrbq9f4LtAMC4Ie6Thg4BF38SEP8Vc4I62hEZJayL8daRMI3G2dNCQOY2oPatVXjlp
	 5EirleKComNs29R7vKb42sXCQZCQIDQO4II+cLD37Zxinb2fZjvsc/4ipFYzKReFAC
	 oJPoZaRbfUu47L4+lEPvUmV7Mlo5XlXc8Qy0j3n5WCeMnCD3CPCRdz9DFp6VZ81+wL
	 hdy2p2hO6OwAYb3f5N1WakXKYzdx2OB7OGck8VVPsnE+mQU/4AVaUiiOJcLrYIjGqx
	 P6HSF6YM8KcKg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/2] net: Fix/prevent napi_schedule() call from bare task context
Date: Wed, 12 Feb 2025 18:43:27 +0100
Message-ID: <20250212174329.53793-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here is a fix to a bad context calling napi_schedule() and a lockdep
assertion to prevent from that in the future. I've tried to produce
a relevant Fixes tag but I'm not confident enough with this codebase.
This call is there for many years and yet the issue got reported only
recently, so I may be missing something in the history of this driver
or in net/usb infrastructure...

Thanks.

Frederic Weisbecker (2):
  net: Assert proper context while calling napi_schedule()
  r8152: Call napi_schedule() from proper context

 drivers/net/usb/r8152.c |  5 ++++-
 include/linux/lockdep.h | 12 ++++++++++++
 net/core/dev.c          |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.46.0


