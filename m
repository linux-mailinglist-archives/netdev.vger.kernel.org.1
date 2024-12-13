Return-Path: <netdev+bounces-151699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40719F0A70
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E821E16A512
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7088F1CDA02;
	Fri, 13 Dec 2024 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WL8TPRmM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE831CF5EA
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088143; cv=none; b=XbDqJj3+EOLt+rfX7aXWb603yC/Pu7xltmcF5ToLnu7l3j5vlS8L4G0tC3qFxAmSCbRIMayvsDITgI4bgCfbLyZDBXVCEfN48NNwNfrxT/MJPLq4YLdvYFg6p1S36fm+Fupiyt0ufWPi5+hf3lM3XfG70hqDzauK1+huuOpesY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088143; c=relaxed/simple;
	bh=bw6k5z9FAbbxXWs0lf9dPQoru/gItGvjkBzON19QCI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I/K/8wVVWE/Nk2EHDzQRrfsqjlv9xck8wP2zIFnW6RGvVGa/JV8wKx/GUgQtZ/spRRlQylHI4mtvC3b58yFlXBCJF3+4nI+lTLq+qNfPlgNbAm9EYiOqdkWf9/dfiopN3AqqatPHVKc4boA3Xp/OPULmQdQcQUo7BuNfMx8+cLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WL8TPRmM; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088063; x=1765624063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HCGqrW3R0LQrNuYU1RUpaLaAr8MWrosJ6yp/Z+S0z60=;
  b=WL8TPRmMnDTNRXCOD4HhC/gkB1FrvQRXSw1QndcqeKsx68BYM0LqbPJB
   MxDmYf7wG71J9GuB38rgep2PQGxbYqvMfwqJcmwnfu5cGI7xBbcQGtih1
   iV33X73+nKuYnmLE+nS0i/+5znNcILcpLh2OnLMvCL6ILxq9RpEq8F1R2
   c=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="5700142"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:07:42 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:60020]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.5:2525] with esmtp (Farcaster)
 id 35e4a6a5-dee2-48e2-a12b-e11eb69fd282; Fri, 13 Dec 2024 11:08:59 +0000 (UTC)
X-Farcaster-Flow-ID: 35e4a6a5-dee2-48e2-a12b-e11eb69fd282
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:08:59 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:08:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/12] af_unix: Prepare for skb drop reason.
Date: Fri, 13 Dec 2024 20:08:38 +0900
Message-ID: <20241213110850.25453-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a prep series and cleans up error paths in the following
functions

  * unix_stream_connect()
  * unix_stream_sendmsg()
  * unix_dgram_sendmsg()

to make it easy to add skb drop reason for AF_UNIX, which seems to
have a potential user.

https://lore.kernel.org/netdev/CAAf2ycmZHti95WaBR3s+L5Epm1q7sXmvZ-EqCK=-oZj=45tOwQ@mail.gmail.com/


Changes:
  v2:
    * Drop previous patch 4, 7, 14
    * Patch 4
      * Move send_sig() after SEND_SHUTDOWN check before goto

  v1: https://lore.kernel.org/netdev/20241206052607.1197-1-kuniyu@amazon.com/


Kuniyuki Iwashima (12):
  af_unix: Set error only when needed in unix_stream_connect().
  af_unix: Clean up error paths in unix_stream_connect().
  af_unix: Set error only when needed in unix_stream_sendmsg().
  af_unix: Clean up error paths in unix_stream_sendmsg().
  af_unix: Set error only when needed in unix_dgram_sendmsg().
  af_unix: Move !sunaddr case in unix_dgram_sendmsg().
  af_unix: Use msg->{msg_name,msg_namelen} in unix_dgram_sendmsg().
  af_unix: Split restart label in unix_dgram_sendmsg().
  af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().
  af_unix: Clean up SOCK_DEAD error paths in unix_dgram_sendmsg().
  af_unix: Clean up error paths in unix_dgram_sendmsg().
  af_unix: Remove unix_our_peer().

 net/unix/af_unix.c | 196 ++++++++++++++++++++++-----------------------
 1 file changed, 96 insertions(+), 100 deletions(-)

-- 
2.39.5 (Apple Git-154)


