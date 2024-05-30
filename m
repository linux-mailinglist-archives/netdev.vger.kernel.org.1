Return-Path: <netdev+bounces-99488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB4C8D50A7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112B1281B63
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69FC48CE0;
	Thu, 30 May 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTgCUgcT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28753482EE
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089085; cv=none; b=AYZ+0ZBJT59rVbuWWBk5DJA05vQx5QvTgnGlXD1JZkOnhqZIKZOxxuaUbNycQS94EtU50fHcD8JGGM9YBgGhRTPu9kOLE5237qvugGVlKV88nx3F6wOeXzCHqBtrhjK2KoGFCP6egVkoAn11WMNXCPrEPFI41OWtOwHVZ43wdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089085; c=relaxed/simple;
	bh=LIXtZQphs9mxVwajqEmSWNZc75sITt1oNOAJDrFHrXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogXTye/y0kBVnfa+12O2g3HE8GZ1F1RNPXEQnjQ8VCEuSWCMr5D/WREIL5Y5Ss4isZJlv3R24PLojtT0RSXUdaaTVVTeemnYYuIJsbip58B0tliBJME15EzvMQvsP8qLpdjy1t2ZF2RxofT/PV3E0LbiUMDZMBL1mCsTu1+CdXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTgCUgcT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717089083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cv5d5Gb1calqIdib3D5m6mYnbrwZaj0Jc+HFG0a9II0=;
	b=eTgCUgcTPTcENC6B28t2jtMvFXnuTP4qTtjWkp2zA99+yrRvLADHPYuoTuNTqc7xWwxmHg
	q3QDJ928qtml4UljURaImYW14Hk1pTpCPepvu2pFoc00422yLKlFzER4h2IdZM6EVTNBuH
	uiaIvolyF7WcUpTwKLzdifRXi2IohM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-FzDlJbJYPzaazLhTZAem2A-1; Thu, 30 May 2024 13:11:17 -0400
X-MC-Unique: FzDlJbJYPzaazLhTZAem2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6D9F8029E2;
	Thu, 30 May 2024 17:11:16 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8028E2026D37;
	Thu, 30 May 2024 17:11:13 +0000 (UTC)
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
Subject: [PATCH net-next v4 0/2] net: allow dissecting/matching tunnel control flags 
Date: Thu, 30 May 2024 19:08:33 +0200
Message-ID: <cover.1717088241.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

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

v4:
 - fix kernel-doc warning in flow_dissector.h (thanks Jakub)

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


