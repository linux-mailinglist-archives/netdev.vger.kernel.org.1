Return-Path: <netdev+bounces-165303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9CEA3186F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91269168122
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19C267B06;
	Tue, 11 Feb 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="DyGxtyAG"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E8267714
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312201; cv=none; b=JDdtGUqf/LF9N8ZaXdUhTk+rMcYLxhaxzTT+zPhWlA5fq+Dgqp1GlwSPY6JynX5sh+U3J5Qw3Zql9/2/PVzFgWkCIEgEVAUc8AYfJYLp1atBGMyf2pPJgyHLTf+pxLnG1Wsd5DcKq/HyZOr+SDdUy9KcMEgovAuxrAhMzH6g0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312201; c=relaxed/simple;
	bh=OG27+obk7Mjdpt+XIqdFLTqkEl4qsaB/Otwq9xwzGj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EeZvRLoEZ2/U4Ro1WMI8vytXrxevPRuf4cFwIPT2nD38w1BxpHnhO7VLRLqBuaY74AWe+iUocl4J30Ac4Eeu0nv9GaZxS0u12sTE/9AIfN4BaH0Am8WELNk/bHka3MLxN8Qi7i2f60mfCGqA6G822AFaUtqOP5PfkTBJxIE0dwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=DyGxtyAG; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [10.29.255.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 73062200DB94;
	Tue, 11 Feb 2025 23:16:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 73062200DB94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739312190;
	bh=B1Z6VYuV+ODATtF33UFNuqVUd4HOp8oFU0XmHiWVoqo=;
	h=From:To:Cc:Subject:Date:From;
	b=DyGxtyAGYz0d+dK6g1lQCVwPnRECVJKuzuNB7vzUbFXfbLx9/vXZrJihej1I7TwXA
	 w14zAzHDfuLkIvKPS+KwOZl9nYOjinlpLSMpDu4LNMyMGvchjwZZmC/bXhaWpKoSYZ
	 6POrhJnXIlHviHSevcc9fYhbipBec1qLu6/ajjXoTUeq6Nuw7L1uK53ISTVyIaf4Qk
	 /nRda0rOIpPxQmb0iqmjQYnTopMmjOC42G3TsQ4DSEZxgJklg5IJZF/p8e0aCgfs5C
	 gQdPfV2aphKInLnOqyrJijQYTHEvvVxZ/bJbQHnuz8ImCtXWaZgMUXSa6Ymez7O5rt
	 BlQ3befAyhhew==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net v2 0/3] several fixes for ioam6, rpl and seg6 lwtunnels
Date: Tue, 11 Feb 2025 23:16:21 +0100
Message-Id: <20250211221624.18435-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- address warnings/errors reported by checkpatch

v1:
- https://lore.kernel.org/netdev/20250209193840.20509-1-justin.iurman@uliege.be/

This series provides fixes to prevent loops in ioam6_iptunnel,
rpl_iptunnel and seg6_iptunnel.

Justin Iurman (3):
  net: ipv6: fix dst ref loops on input in rpl and seg6 lwtunnels
  net: ipv6: fix lwtunnel loops in ioam6, rpl and seg6
  net: ipv6: fix consecutive input and output transformation in
    lwtunnels

 net/ipv6/ioam6_iptunnel.c |  6 ++---
 net/ipv6/rpl_iptunnel.c   | 34 +++++++++++++++++++++--
 net/ipv6/seg6_iptunnel.c  | 57 +++++++++++++++++++++++++++++++++------
 3 files changed, 83 insertions(+), 14 deletions(-)

-- 
2.34.1


