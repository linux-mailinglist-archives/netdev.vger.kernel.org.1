Return-Path: <netdev+bounces-96925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD0B8C839A
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D03A1F215EB
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFB2561F;
	Fri, 17 May 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="e6Vm9Xf9"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812A2260A
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938331; cv=none; b=Y6eKOKc0vorYalaKSwLYLkUuwR2rN2u3gCFAMSpuzuOs6J/9V9Hs6gcNrh9RciXWq+2YrVQWovC5C0cRHl2zIet1LFajdKl4FcM6PZ8F4SWHQrF86tYBlnnUfxXtjlaLVUjtvdbgaWwsMV4rByooMpWvVO5IcltQIzQ/VgU75Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938331; c=relaxed/simple;
	bh=0VSs6s25YpDWA8+PUcSMIIAWEqznkx6FwMCqso2TSqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcpBuXslMBY8iilqZVxbFYxkPjztbjNS0kK/XRr3h9iNjPCxhAMtDKnA4ND901l8GD68UIII4RuROzT6WuwYzVxQRoK7sPJpfoScUgUE66A1mRhgVmYY+O6FTKZLS36KKlJr6Fk7+K+lqHgFnSYyYolafqUjb9ult2aPTRV3D18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=e6Vm9Xf9; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7twb-005Aq9-A2; Fri, 17 May 2024 11:32:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From; bh=pdLij7cy7oNK5VAHF4tDtz6YtUMerokbo3fN/MwLl5M=; b=e6Vm9Xf9D6u1D
	8zvQZS692G9IbyBnbs86JV+12l8Wd6rRix6lKyjJPC2Z9qVKHe4+gLf2xAcrl7eUn82rU9HP0uU9j
	03BFfKsE8EOswNUCb9a1ErFBQw/Izdb3pk80ij1sFIvOPquWEoCDCQTU4CalFnaT7RkjKBvKD4QBZ
	mH1CGjJqxj5D88V+/kPUZSiQXrwd9rfU992jgeoHGbEWMffxrLLzKD3W59QuzrxRMobUTP8zbH9ZQ
	x961FtSnNWIbY1c60g89+nQ1RRD1iS66Gy8J0e/AaBkuNbxkwdXtHCGz2ZlZmnGO3YiUpS6Dvb30z
	a43j+ErijXgv7kA6F6WnA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7twW-0002B7-TR; Fri, 17 May 2024 11:32:05 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7twP-0042Jz-IW; Fri, 17 May 2024 11:31:53 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	shuah@kernel.org,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH v3 net 0/2] af_unix: Fix GC and improve selftest
Date: Fri, 17 May 2024 11:27:00 +0200
Message-ID: <20240517093138.1436323-1-mhal@rbox.co>
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

v3:
  - Patch 1/2: correct the commit message (Kuniyuki)

v2: https://lore.kernel.org/netdev/20240516145457.1206847-1-mhal@rbox.co/
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


