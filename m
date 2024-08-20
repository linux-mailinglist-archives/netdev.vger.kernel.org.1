Return-Path: <netdev+bounces-119978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5739957C16
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1396288159
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3453A1A8;
	Tue, 20 Aug 2024 03:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="D4w2njLQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43239AD6
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125797; cv=none; b=lPRJWjKophqbZNBSRNWl0HPEx/1sox1AtVaMZOmVfcWDcYQ652n4nIF/bxYlot+6Jpwi2lUA+aaBo3zTthcrHgis+xBvXkkTRA9KUidsuitP8IbSFB+/VAGksiQdmLi1+UQ1ZhhYtbOnTZqMtVLad0sn9udCWnnPFkTI70XIMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125797; c=relaxed/simple;
	bh=8gc7NlTbEHQ07w9LUuK27bkXdCsBrOboh3100oBGQb4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c6JNXuqSjovNqfKupmJV/nYFmyLMWV7js7y48E8ytpLhd8NPnx6BDj6lOBGCGuOGo4l7nwfKxLmM2HhNyvmOOjdMLE61PyBc7812VqS2Z1AvTTEYHvA7F098NOewQcfUWTVrtnnneZLUl7LJ/m3kkBR8VTUpDu03Qs+9bW4gslk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=D4w2njLQ; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1724125796; x=1755661796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=svP4Mk5ziG98htISWJk8ObMOnFEATEHojI2Ea/zO/7M=;
  b=D4w2njLQg7ADbtLKA6Nuolz75ytnnBsa1Wv7z3z2QATYRsoc7q8g45pR
   YMUYURwUwYuYt0Smfz81x7Kt2Bu/TyHqSL8uIYyFNqqCiewhoAz7l43sX
   KcTWCM6Khbqul3FVRFWg8UqgbAFg1sM0sS0VhR13QKUehLugVzUiX5UEC
   w=;
X-IronPort-AV: E=Sophos;i="6.10,160,1719878400"; 
   d="scan'208";a="322433682"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:49:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:48446]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.153:2525] with esmtp (Farcaster)
 id ab171bba-21f0-42b2-83fb-0aab02a83534; Tue, 20 Aug 2024 03:49:55 +0000 (UTC)
X-Farcaster-Flow-ID: ab171bba-21f0-42b2-83fb-0aab02a83534
Received: from EX19D005ANA004.ant.amazon.com (10.37.240.178) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 20 Aug 2024 03:49:54 +0000
Received: from 682f678c4465.ant.amazon.com (10.119.0.197) by
 EX19D005ANA004.ant.amazon.com (10.37.240.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 20 Aug 2024 03:49:51 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Takamitsu Iwai
	<takamitz@amazon.co.jp>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/2] tcp: Fix bugs of OOB handling in TCP.
Date: Tue, 20 Aug 2024 12:49:18 +0900
Message-ID: <20240820034920.77419-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D005ANA004.ant.amazon.com (10.37.240.178)

These patches fix bugs of OOB handling in TCP.

Patch 1 fixes an issue where a head OOB is dropped when queuing new
OOB, and Patch 2 fixes an issue where OOB is recv()ed twice.

Takamitsu Iwai (2):
  tcp: Don't drop head OOB when queuing new OOB.
  tcp: Don't recv() OOB twice.

 include/linux/tcp.h                           |  1 +
 include/net/tcp.h                             |  3 +-
 net/ipv4/tcp.c                                | 15 +++--
 net/ipv4/tcp_input.c                          | 30 ++-------
 tools/testing/selftests/net/af_unix/msg_oob.c | 65 +++++++------------
 5 files changed, 42 insertions(+), 72 deletions(-)

-- 
2.39.3 (Apple Git-145)


