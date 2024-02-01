Return-Path: <netdev+bounces-68114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5957845DFE
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1F1B3231A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A9153AE;
	Thu,  1 Feb 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmLlI3ii"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967047E0FD
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806422; cv=none; b=SHzb/PmGob3N02ZMfSmbp8kUsTDmUyRUf+llJb9R+WsjJOyEz773qY//K5OCZYs63ayuhGAiPeHJLqntHe54JAoNeQtzNd+xbd2u/27C0EcB1AeSU2cDMrIX3+HV4YY+Kjzf3G22gZsydwssDRHGp9osWvPMb0GpUIv82x3V1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806422; c=relaxed/simple;
	bh=Z0EiL8rTbtpj+Srs33vaEyBR/q+0IWvfO3k0kCgLqCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tz7yjF+1RZ0kss3fEshyI+txrmp7CWY7+nL4mB/Xd6ya5kjKzYpsaYjVZWb+R/bentk+6swZh78f+Rb+tUN1cZUbPmWI6MurThsLHlkZOVLQQ0gxhv55MJIjLb6zm/yqa5eBTpxFak08XReYF+OAKw4az+rZ5fi5dq35pAscAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmLlI3ii; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706806419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3IvH3mK50SvQqfHcbj4T812S5eHoNhmat3eDxm2vKfw=;
	b=EmLlI3iiYcCKstIgXJipi9lnxNokedYoA5krD3tTOqgKvu5+BTGvxAwLDXVepaxmaPx2f8
	Zc0nI1gezJZ8Dh2Vtfn7d7PDe+7xCs0AlwGlPUtxGqOlHwtRHr9bNZo/Di/r+PFiJYTWJf
	Y9VDAFtfdOGtj9+jbmjEyuOsnzbQkl8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-D2CzUNRPNDimzwqdOyeF8g-1; Thu, 01 Feb 2024 11:53:34 -0500
X-MC-Unique: D2CzUNRPNDimzwqdOyeF8g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D512835381;
	Thu,  1 Feb 2024 16:53:33 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D43B3492BE7;
	Thu,  1 Feb 2024 16:53:30 +0000 (UTC)
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
Subject: [PATCH net-next v2 0/2] net: allow dissecting/matching tunnel control flags  
Date: Thu,  1 Feb 2024 17:51:42 +0100
Message-ID: <cover.1706805548.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Ilya says: "for correct matching on decapsulated packets, we should match
on not only tunnel id and headers, but also on tunnel configuration flags
like TUNNEL_NO_CSUM and TUNNEL_DONT_FRAGMENT. This is done to distinguish
similar tunnels with slightly different configs. And it is important since
tunnel configuration is flow based, i.e. can be different for every packet,
even though the main tunnel port is the same."

 - patch 1 extends the kernel's flow dissector to extract these flags
   from the packet's tunnel metadata.
 - patch 2 extends TC flower to match on any combination of TUNNEL_NO_CSUM,
   TUNNEL_OAM and TUNNEL_DONT_FRAGMENT.

v2:
 - use NL_REQ_ATTR_CHECK() where possible (thanks Jamal)
 - don't overwrite 'ret' in the error path of fl_set_key_flags()

Davide Caratti (2):
  flow_dissector: add support for tunnel control flags
  net/sched: cls_flower: add support for matching tunnel control flags

 include/net/flow_dissector.h | 11 ++++++++
 include/uapi/linux/pkt_cls.h |  3 +++
 net/core/flow_dissector.c    | 13 +++++++++-
 net/sched/cls_flower.c       | 50 +++++++++++++++++++++++++++++++++++-
 4 files changed, 75 insertions(+), 2 deletions(-)

-- 
2.43.0


