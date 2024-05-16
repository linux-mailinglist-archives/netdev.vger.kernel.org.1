Return-Path: <netdev+bounces-96744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD81E8C78C4
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 16:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A2BB21796
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D82E14B968;
	Thu, 16 May 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cF4L4SLH"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0899E14B96A
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871378; cv=none; b=ScsoFC/bKrnBxtvHey5i2pPNssRJTlkfk+ghyRfCa4Ei49f03gRwzJDe2r5uvBL+r0zl/jDHjRBwyeKeXxs9GLRMNlN+oQf5br80BKpGIrKbRy5YKqV+u/AX/egc7YKiYYmJLTGrxviD2lGlY4thgXi5PUad+YeFJmHUO5LnxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871378; c=relaxed/simple;
	bh=VtdBMM1WW+Q3udahX0tztc1juhXswqSHXtkYU2EIaZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUdpNqPjZSX6MlGkwMw3w8/We2fM3dn+/ILTXCEoVaECG0ZGfcCYLzv9eZODveFbiwbvNiBaWwzsNb0A1q8fe0HCJt11B0639UJ7n+TBo5gMRIuumfBXWFBKflS2H/cx1x3HbcASvAOAnffkusf5EPQ2ryzzg8WBErhGJfvNycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cF4L4SLH; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7cWU-002r3P-Cr; Thu, 16 May 2024 16:55:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From; bh=eo95MCl0j9f5NP/EIXzqCCi7OrAR51P7VVqvLgV9gZY=; b=cF4L4SLHcx/EN
	jun54IvaQjD2WxddU0jB+WClvtfNNt1a2f+ivRPTjKvd6b6RQgQpw0T1B9m1OwL6XXOrr2L4abtDG
	pTiKvwDpYLdv0EWUouF38CN2NhG6MH4P8frQ0+OliRfabY/Co6GDGx3AlfGvY43SmIKcGdr34CEIg
	jCriCofTRPioNk9BMvamAVk/YOBvg88XbgeKtn1niMW+AtYbKbKiN9UfrwXIEKsoO+P+xA96Ocoqm
	dCv4VpzhEcm20qn49cP5TW7CnxCq7a3KH5c5U2SLOB9YWyqhcxtAY/LHCzzq+85TX7e9Q3wne5q86
	AcmDmr58etIXQM6JbST0g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7cWT-00067y-KR; Thu, 16 May 2024 16:55:57 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7cWO-000xkA-SV; Thu, 16 May 2024 16:55:52 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	shuah@kernel.org,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v2 0/2] af_unix: Fix GC and improve selftest
Date: Thu, 16 May 2024 16:50:08 +0200
Message-ID: <20240516145457.1206847-1-mhal@rbox.co>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series deals with AF_UNIX garbage collector mishandling some in-flight
graph cycles. Embryos carrying OOB packets with SCM_RIGHTS cause issues.

Patch 1/2 fixes the memory leak.
Patch 2/2 tweaks the selftest for a better OOB coverage.

v2:
  - Patch 1/2: remove WARN_ON_ONCE() (Kuniyuki)
  - Combine both patches into a series (Kuniyuki)

v1: https://lore.kernel.org/netdev/20240516103049.1132040-1-mhal@rbox.co/

Kuniyuki Iwashima (1):
  selftest: af_unix: Make SCM_RIGHTS into OOB data.

Michal Luczaj (1):
  af_unix: Fix garbage collection of embryos carrying OOB with
    SCM_RIGHTS

 net/unix/garbage.c                            | 23 +++++++++++--------
 .../selftests/net/af_unix/scm_rights.c        |  4 ++--
 2 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.45.0


