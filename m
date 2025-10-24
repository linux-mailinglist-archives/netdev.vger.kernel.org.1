Return-Path: <netdev+bounces-232411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758F2C05973
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50AD3B6136
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC5C303A1A;
	Fri, 24 Oct 2025 10:27:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-12.21cn.com [182.42.119.59])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681530F93B
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.119.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301624; cv=none; b=YXAAY8oAUedd6pEwoM0LDuqDLD4upGOsjx4bg/t+DUqlm44c6/gxz2W0A4dc9R4cu5x1GWEw5DnfnQqPb/pC6998IYUbpy1s+KYA/pAIsrYnypCx38xynx3Szhx5Qsrx451HQ+dhnWeTWp9rgUuERzb44H0DlubjhZWaxP+bn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301624; c=relaxed/simple;
	bh=TC38y5vObp8g8JY5GPAgKxhrL5+BEmal02IEG1DOsTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HE8KgxCdnedxf5ugm1xEMISIhqN5GEz1Gee6OPf4m3wcuzDV8IVLNu9CW9njFKDII8XCy8i8MjiYUeSpENBxX2z/R7VfxiTmVo9B3w/5E20BQIVz09/7bLyLLkElmZ8d/Yi9gRXn3UgFmy1Wbcb2NpOunpeosx9vidhnuHGa2Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.119.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.1620297662
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.5 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id D8DA611024D22;
	Fri, 24 Oct 2025 18:20:15 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.5])
	by gateway-ssl-dep-79cdd9d55b-2nzwx with ESMTP id 7b8913783180481faf2fd53d2cbf1048 for netdev@vger.kernel.org;
	Fri, 24 Oct 2025 18:20:20 CST
X-Transaction-ID: 7b8913783180481faf2fd53d2cbf1048
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
Subject: [PATCH net v2 0/2] add drop reason when do fragment
Date: Fri, 24 Oct 2025 18:20:10 +0800
Message-Id: <1761301212-34487-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Add two new drop reasons FRAG_FAILED, FRAG_OUTPUT_FAILED.
And use drop reasons to trace do fragment.


Reasons show up as:

perf record -e skb:kfree_skb -a; perf script

  swapper 0 [005] 154.086537: skb:kfree_skb: ... location=ip6_fragment reason: PKT_TOO_BIG
  swapper 0 [005] 154.086540: skb:kfree_skb: ... location=ip6_fragment reason: PKT_TOO_BIG
  swapper 0 [005] 154.086544: skb:kfree_skb: ... location=ip6_fragment reason: PKT_TOO_BIG

Yonglong Li (2):
  net: ip: add drop reasons when handling ip fragments
  net: ipv6: use drop reasons in ip6_fragment

 include/net/dropreason-core.h |  6 ++++++
 net/ipv4/ip_output.c          | 17 ++++++++++++-----
 net/ipv6/ip6_output.c         | 16 ++++++++++++----
 3 files changed, 30 insertions(+), 9 deletions(-)

-- 
1.8.3.1


