Return-Path: <netdev+bounces-233061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F4CC0BB3A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799693AE3AB
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888412D3228;
	Mon, 27 Oct 2025 02:44:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-05.21cn.com [182.42.157.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07A52D29CF
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.157.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533043; cv=none; b=gM4ikmtSGdBHgikELtCFiJMbSirQFoZASOiJpfsTXFeC0e0TAAjupJsc6At3VcKyv6uki0z2rsehLhO8twPrfafgxvxb54cExouO9tcf7praw7AKC1dfGrFeZtqUFS6sFoxXzhVnpTTSNmBtj+FSYuSu0W0X6XAessKRfdenpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533043; c=relaxed/simple;
	bh=TC38y5vObp8g8JY5GPAgKxhrL5+BEmal02IEG1DOsTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bab8QS0sNV06htoTqpPdTbgzo51Ps9vouAVDZ6qzZobTJoUn6GcSHZ7Lz4S/0Sh06iKZXezusc25HglC5APK4M94+EDbBlvsKHkPsgGEf72Pmht0llba+vxoELPxvIZGqPi4pqT2N7nJCkbj/qbrBWz9yUp+DNZAYERxCJAaZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.157.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.1314971392
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.5 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id 901BC8F77B;
	Mon, 27 Oct 2025 10:32:48 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.5])
	by gateway-ssl-dep-79cdd9d55b-z742x with ESMTP id daad852e3f96426c83485e18ca0d2f77 for netdev@vger.kernel.org;
	Mon, 27 Oct 2025 10:32:54 CST
X-Transaction-ID: daad852e3f96426c83485e18ca0d2f77
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
Date: Mon, 27 Oct 2025 10:32:43 +0800
Message-Id: <1761532365-10202-1-git-send-email-liyonglong@chinatelecom.cn>
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


