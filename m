Return-Path: <netdev+bounces-208658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C265B0C995
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 19:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13CA4E787F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF322E11C9;
	Mon, 21 Jul 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8aJhOrS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76EE2DAFCF
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118458; cv=none; b=DRscocVsH1rbaFksGGBR6A4RAWkjOvtQAQWvljJET4PJk82lWKh4/iMcccmxgwZmIgzMbhWbX9qDbcsu/VSPMRXZdN5EyrzBdL9ihmtGuFg6ZsXl8Xsg9e+0QqR2AghAY4ctDQdgWpS2krk0qLAwU68WRR3HY6xfknUYrooH8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118458; c=relaxed/simple;
	bh=Q1waFcdc2OwQD9EOevvdmS3H0MWsnAWT1yAHs06KV+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UxaUqit9GiHi5yy2NqJpwIFKvql4FrEe9ix6cs2yxKVafliIo50WHpY8g6OLmeywsQOyiJD8bVqHK/+9Sf9mfSogtLqU9h2RHOyrFysmeaD6FqPaYra9OpDG5CvpMZ4szcU0a4OA7uhsBoqXc0chFg/am4shYgrDm+jAC8oraH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8aJhOrS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753118455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/uz3bErfMIXrwx2nU/t8b23AtorYfO2+7zEOPIFLkHU=;
	b=G8aJhOrSFRAqGDlNYmaT+n6a1JqwuA3ZGxQQmSlJVgPieaWnyuQ6NBFvPSW4a4+OG6GLb+
	LG0vG/dTn8ABnFVuUHnAmEJDAiZj3qHjtXUz4tWTihKjqZpCkAxj/rd/cD/0BZBhMLwckQ
	ALBJIb2COgJOO31Z3x5cjdgOlZOj7qE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-Hq4-f0XWOoCaK6sxahFVlQ-1; Mon,
 21 Jul 2025 13:20:34 -0400
X-MC-Unique: Hq4-f0XWOoCaK6sxahFVlQ-1
X-Mimecast-MFC-AGG-ID: Hq4-f0XWOoCaK6sxahFVlQ_1753118431
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B39219541A7;
	Mon, 21 Jul 2025 17:20:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E6F918016F9;
	Mon, 21 Jul 2025 17:20:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH v2 net-next 0/2] tcp: a couple of fixes
Date: Mon, 21 Jul 2025 19:20:20 +0200
Message-ID: <cover.1753118029.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series includes a couple of follow-up for the recent tcp receiver
changes, addressing issues outlined by the nipa CI and the mptcp
self-tests.

Note that despite the affected self-tests where MPTCP ones, the issues
are really in the TCP code, see patch 1 for the details.

v1 -> v2:
  - rework patch 1/2
v1: https://lore.kernel.org/netdev/cover.1752859383.git.pabeni@redhat.com

Paolo Abeni (2):
  tcp: do not set a zero size receive buffer
  tcp: do not increment BeyondWindow MIB for old seq

 net/ipv4/tcp_input.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.50.0


