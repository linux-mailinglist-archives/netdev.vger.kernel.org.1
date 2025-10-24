Return-Path: <netdev+bounces-232351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D05C047EE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C63084E9B28
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 06:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1751DFE09;
	Fri, 24 Oct 2025 06:31:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-04.21cn.com [182.42.158.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160501DFFD
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.158.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287466; cv=none; b=Kv9s+Mffa8RPzzkIbzCiG+/lw3Cd1QUSZ7YsGRDoLPWQYn4SeR1SLcYz9Z6nb8W8N86h4BlsoPovAyNnftNgj/TmvqF9Mn9GAJaFNNBeseMyBgNLNpxX9WSuOSNg254LkswL+lkfAtDYxwlAepxL2cBC6b4xYwvKIvDmwNuAdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287466; c=relaxed/simple;
	bh=CtSACjDjKJBonRprA68ECigErE1PpXuNTdVwtgAjBwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PQwqyETvhYRplCe8MM6jvkr41NvxCHggChlFJ/I1CVG01i6+FENn7fFkqoWyeDaJSTZt9oyyaa6HyTeyWJa5AlYNFkzYkveXvMvM3MEwsYzpsqAjWj5VLtc1M1Xkdq+KDVSLP90uFwGrCn7PNZnI+lqBJDwEINiTDIv4xnrfuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.158.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.1801105929
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.5 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id 98CE54F0C;
	Fri, 24 Oct 2025 14:23:26 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.5])
	by gateway-ssl-dep-79cdd9d55b-2nzwx with ESMTP id 9db5dce5f5db441e97be6a32ce5a16e0 for netdev@vger.kernel.org;
	Fri, 24 Oct 2025 14:23:33 CST
X-Transaction-ID: 9db5dce5f5db441e97be6a32ce5a16e0
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 36.111.140.5
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	horms@kernel.org,
	liyonglong@chinatelecom.cn
Subject: [PATH net 0/2] add drop reason when do fragment
Date: Fri, 24 Oct 2025 14:23:14 +0800
Message-Id: <1761286996-39440-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Add a new drop reason FRAG_FAILED to trace do fragment failed.
And use drop reasons PKT_TOO_BIG when pkt too big.

Reasons show up as:

perf record -e skb:kfree_skb -a; perf script

  swapper 0 [005] 154.086537: skb:kfree_skb: ... location=ip6_fragment reason: PKT_TOO_BIG
  swapper 0 [005] 154.086540: skb:kfree_skb: ... location=ip6_fragment reason: PKT_TOO_BIG
  swapper 0 [005] 154.086544: skb:kfree_skb: ... location=ip6_fragment reason: PKT_TOO_BIG

Yonglong Li (2):
  net: ip: add drop reasons when handling ip fragments
  net: ipv6: use drop reasons in ip6_fragment

 include/net/dropreason-core.h | 3 +++
 net/ipv4/ip_output.c          | 6 +++---
 net/ipv6/ip6_output.c         | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
1.8.3.1


