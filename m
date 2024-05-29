Return-Path: <netdev+bounces-98893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A88D319A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C601C23F4C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E7167DA8;
	Wed, 29 May 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fU4ypv5Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60E29406
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971573; cv=none; b=JwdGoOMTqSLd+J5NHVVR6LpS+pDkDEVD8rCcpDsMx+SUks2M5V+x0vd4J62UpNkFK7OskuD6iOUXnkwLUHX6X7DcEno4Y6BsPQRMfPD9bVjnwrPe/jif5iucV9aSF7Wi8UFfrgTUsgKqn03YtWZ/G88VdTYHpbI/9qvEfh238tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971573; c=relaxed/simple;
	bh=doE102eee93dTKFSYm06OjlShT2oVxJ4CBXfAZ0TeTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgtFtN8vmrI/1IZBTO+6a0k7zCf7SFwDpFiv37Wqb6H1aIUoPRo4EPQjGqgCTBq5ffvmkiGe7goxWMO4MS44KOB1JPh6WyRBja6xBkz85QMJBJQCMJHYbHiScdI3yU5TgtY34PzPKj5y3VX3M3jBAJnEMY5DBQYkCo8kI81gWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fU4ypv5Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716971571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fg+nbr/kOpDoW5B9akO94qua/7omfkMQIWHz5MzRyj8=;
	b=fU4ypv5ZqoVgMbG5wTTezLfSxAIXCY+TlydjqgGxKHas7sVgf5o8D0D07G42G32yaTMyEB
	9T72enxprtp17+uOJ1OkKhMQgDmgHgdGkufIeD4D2qySgjFl8OUmoqhZBdEDREDVx5Se+c
	E9XzweM+TNdV4sVDMPwATlwyn65CDw0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-jIv1LAudP_6yPakNXZL4EQ-1; Wed,
 29 May 2024 04:32:47 -0400
X-MC-Unique: jIv1LAudP_6yPakNXZL4EQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D052F29AA384;
	Wed, 29 May 2024 08:32:46 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E12C5200A6E7;
	Wed, 29 May 2024 08:32:43 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: dcaratti@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	i.maximets@ovn.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	echaudro@redhat.com
Subject: [PATCH net-next v3 0/2] net: allow dissecting/matching tunnel control flags 
Date: Wed, 29 May 2024 10:31:56 +0200
Message-ID: <cover.1716911277.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Ilya says: "for correct matching on decapsulated packets, we should match
on not only tunnel id and headers, but also on tunnel configuration flags
like TUNNEL_NO_CSUM and TUNNEL_DONT_FRAGMENT. This is done to distinguish
similar tunnels with slightly different configs. And it is important since
tunnel configuration is flow based, i.e. can be different for every packet,
even though the main tunnel port is the same."

 - patch 1 extends the kernel's flow dissector to extract these flags
   from the packet's tunnel metadata.
 - patch 2 extends TC flower to match on any combination of TUNNEL_NO_CSUM,
   TUNNEL_DONT_FRAGMENT, TUNNEL_OAM, TUNNEL_CRIT_OPT

v3:
 - rebase on top of new uAPI bits and internals after commit 5832c4a77d69
   ("ip_tunnel: convert __be16 tunnel flags to bitmaps"). Use of network
   byte order is no more needed, since these bits match on metadata: convert
   netlink attributes to be u32.
 - also include TUNNEL_CRIT_OPT

v2:
 - use NL_REQ_ATTR_CHECK() where possible (thanks Jamal)
 - don't overwrite 'ret' in the error path of fl_set_key_flags()

Davide Caratti (2):
  flow_dissector: add support for tunnel control flags
  net/sched: cls_flower: add support for matching tunnel control flags

 include/net/flow_dissector.h |  9 ++++++
 include/net/ip_tunnels.h     | 12 ++++++++
 include/uapi/linux/pkt_cls.h |  3 ++
 net/core/flow_dissector.c    | 16 ++++++++++-
 net/sched/cls_flower.c       | 56 +++++++++++++++++++++++++++++++++++-
 5 files changed, 94 insertions(+), 2 deletions(-)

-- 
2.44.0


