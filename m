Return-Path: <netdev+bounces-85449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2397289AC9C
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9C41F21543
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08245957;
	Sat,  6 Apr 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrUUKSfB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2DFBE6C
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712427675; cv=none; b=b9ZE7iA4gCv3lN/nlNdx3qusi5voWrwsNaxN5JITETMCd5OMkfHWh9Va9ZQAk11SNeL6vGEpcIGlrgrWf/RoXkvxyFJoXnGs9WV6darr0z4r0bmN7+VCY7eQ9cKx8B7Qy4uoBD4Iv95GRyBnr1YIA6L6yCOQVYoas0Nff+f/Oxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712427675; c=relaxed/simple;
	bh=2HN3tQxe3PuKEXzLK4IkZG083zQqQF8ph1vEmQE1WSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBHpfffcUZr11rgU4ZpO4moj2+9P0/CayrWOjM+nKiBm5zAuofVQ2tlXXYqzTwQFM5tfORC/GXXB5yJ44jJPnuZ/9RL10VhD+PdTycIvQis8WyZGxM5W49wTQCumwCMHBW6HfBHJGv9llfZcDYB/HBjMcJvupgPCpGT8JPlKl3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrUUKSfB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712427673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+t0KwwMdpKk8Cq1XYQJ4gt6vU14mdmDidKTllvwmDtw=;
	b=YrUUKSfBBtWjH2eiKCzvQPlDwI4tykO8aLRuiAfS4KxPzZbgsmU6mdFM6X8+GF412RAdbZ
	PufltT8mxACVm33SBI6BDCtLOACaL4OMjBAE1rGQHbbhNX5KPRdERfzA7F4u6WPLbKqW12
	gyye1kpdYmORLqK/GTw5rylQUpWTnhE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-jWBbUgjvNLiqodp3T2XG4g-1; Sat, 06 Apr 2024 14:21:09 -0400
X-MC-Unique: jWBbUgjvNLiqodp3T2XG4g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACFB1927A65;
	Sat,  6 Apr 2024 18:21:08 +0000 (UTC)
Received: from fenrir.redhat.com (unknown [10.22.8.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8074D430F56;
	Sat,  6 Apr 2024 18:21:07 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com,
	eric.dumazet@gmail.com,
	edumazet@google.com
Subject: [net-next 0/2] tcp: add support for SO_PEEK_OFF socket option
Date: Sat,  6 Apr 2024 14:21:05 -0400
Message-ID: <20240406182107.261472-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From: Jon Maloy <jmaloy@redhat.com>

We add support for the SO_PEEK_OFF socket option as a new feature in
TCP.

In a separate patch, we fix a bug that was revealed while testing this
feature.

Jon Maloy (2):
  tcp: add support for SO_PEEK_OFF socket option
  tcp: correct handling of extreme menory squeeze

 net/ipv4/af_inet.c    |  1 +
 net/ipv4/tcp.c        | 16 ++++++++++------
 net/ipv4/tcp_output.c | 14 +++++++++-----
 3 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.42.0


