Return-Path: <netdev+bounces-67605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1BF8443F3
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA171C26546
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5912C530;
	Wed, 31 Jan 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axNKgmdN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB3D12BF09
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717817; cv=none; b=dk/1RMkv8z4wJrtBqQayhhuOPKo/WxWqFWSWMUls6CZFmccGoPvYVWiFXbea3G4nMmZjLGX2SVWbt/2KoFHeME4uc8+drHxKLGKZPrzT8t4Gy0/MCKJMsxMquIJEhTD90QMy2701F66bqdt6C5sjXIacKqTVlJKVzO+L5lz1dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717817; c=relaxed/simple;
	bh=J7hVrpMv22I1W8tKSSreCqNrnsrh/hm84yZ4eaPhkqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKQs2UO6q7HOLTUkDFWn4vFfeeFXKjy8TdpqCByWZMl9/URj1XEj+31XeMGjrhyVwOel0sSmizqUecjaDRR9cE0BWmbaUXrpH5CoMB10ab/8OD77kmdJT8G1Htl/BdJoDPrK6AJwqvYKrXWzmwkpbmSXIc4/56THdMd2ExqGcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axNKgmdN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706717814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8ST0Fq8uUjbpZn2+9FgYLG0h6AslalWOllE8C6rBP5k=;
	b=axNKgmdNRz+Z6/1wEW9fHnNpw91RW3rmtB1e/gTU7Gp4Ry6xtUWesT97P768ZCRKn0AEF3
	uLzN8Uyua3xlSMPvAC1TgJNZ9n+CrkOf8aO18hOgUc5LkQ4mdb6R6L0A14cR75TSBKTEfp
	Woum6XmdQs4G64qhzEUtJ4OkRi1PaIc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-ZmSAJBgzPtqsxVw7j-ocKw-1; Wed,
 31 Jan 2024 11:16:49 -0500
X-MC-Unique: ZmSAJBgzPtqsxVw7j-ocKw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C8541C07F22;
	Wed, 31 Jan 2024 16:16:48 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 05F40492BC6;
	Wed, 31 Jan 2024 16:16:45 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next 0/2] net: allow dissecting/matching tunnel control flags  
Date: Wed, 31 Jan 2024 17:13:23 +0100
Message-ID: <cover.1706714667.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Ilya says: "for correct matching on decapsulated packets, we should match
on not only tunnel id and headers, but also on tunnel configuration flags
like TUNNEL_NO_CSUM and TUNNEL_DONT_FRAGMENT. This is done to distinguish
similar tunnels with slightly different configs. And it is important since
tunnel configuration is flow based, i.e. can be different for every packet,
even though the main tunnel port is the same."

 - patch 1 extends the kernel's flow dissector to extract these flags
   from the packet's tunnel metadata.
 - patch 2 extends TC flower tomatch on any combination of TUNNEL_NO_CSUM,
   TUNNEL_OAM and TUNNEL_DONT_FRAGMENT.

Davide Caratti (2):
  flow_dissector: add support for tunnel control flags
  net/sched: cls_flower: add support for matching tunnel control flags

 include/net/flow_dissector.h | 11 +++++++++
 include/uapi/linux/pkt_cls.h |  3 +++
 net/core/flow_dissector.c    | 13 ++++++++++-
 net/sched/cls_flower.c       | 45 ++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.43.0


