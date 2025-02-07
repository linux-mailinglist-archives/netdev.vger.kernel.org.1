Return-Path: <netdev+bounces-164070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1108A2C8A7
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF207A1A96
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2543C18C011;
	Fri,  7 Feb 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf6Lgd/3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15318BC20
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945444; cv=none; b=Ywl+C2rglN22OWiwBuADZKWdCIjh+iQ6f4XStXz2jI5itWSujm1FEhxth7cHdwIQNHZKRSXe4+SE6K3uQzSXhiYFoIazBWVNYV0vEWMU6nfS1ef6uDMFIoAAETjp74TtoHME8F5Zp4w0FsRnK9C0J2iXRYXlMz/2OOvDkavTKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945444; c=relaxed/simple;
	bh=Ox5W3ffP49QkVRBatBUHI4UBtnsWkrH8rb1s5s+0ZG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7k0TGkToP1COyqKU8YnmM3buVT2GAJ+B2x/uUu/O12zWW3JYI4yjIAVmNxIuj6VEt7NrLEg/dtqtr6RKGIy0dWRQzFMfZ5Bkde3lLoLsOND9GoHcgKhCN6ZVyrBN2b4DV7lpHVJWFN1O6l3kgCB6sor5g2URxtDVa9P+3G1/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rf6Lgd/3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738945441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KcejRWFXt8y3EGkctWx5b5ewE7cAJ1eySkO4ECRFqMU=;
	b=Rf6Lgd/3FkT6kDOJ9YFXlg/2SOR05RypQILYZ+Mxawi8d1QPE/i1uTiPFX5Bc55c8T8BV0
	7FtQ+Eh+rsCIVAejro8l2hMwRblAtz2A+Hpqsj3nROVycKvJSxfF6EkcxzWjtwzcLdoNm6
	6zX4yiKks0P3ldAt4KrwD8nLjMSDupQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-sgQA0b1XOuuFjMC6vhB4uQ-1; Fri,
 07 Feb 2025 11:23:57 -0500
X-MC-Unique: sgQA0b1XOuuFjMC6vhB4uQ-1
X-Mimecast-MFC-AGG-ID: sgQA0b1XOuuFjMC6vhB4uQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 971BF195604F;
	Fri,  7 Feb 2025 16:23:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.205])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BF1A30001AB;
	Fri,  7 Feb 2025 16:23:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
Date: Fri,  7 Feb 2025 17:23:43 +0100
Message-ID: <cover.1738940816.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

While benchmarking the recently shared page frag revert, I observed a
lot of cache misses in the UDP RX path due to false sharing between the
sk_tsflags and the sk_forward_alloc sk fields.

Here comes a solution attempt for such a problem, inspired by commit
f796feabb9f5 ("udp: add local "peek offset enabled" flag").

The first patch adds a new proto op allowing protocol specific operation
on tsflags updates, and the 2nd one leverages such operation to cache
the problematic field in a cache friendly manner.

The need for a new operation is possibly suboptimal, hence the RFC tag,
but I could not find other good solutions. I considered:
- moving the sk_tsflags just before 'sk_policy', in the 'sock_read_rxtx'
  group. It arguably belongs to such group, but the change would create
  a couple of holes, increasing the 'struct sock' size and would have 
  side effects on other protocols
- moving the sk_tsflags just before 'sk_stamp'; similar to the above,
  would possibly reduce the side effects, as most of 'struct sock'
  layout will be unchanged. Could increase the number of cacheline
  accessed in the TX path.

I opted for the present solution as it should minimize the side effects
to other protocols.

Paolo Abeni (2):
  sock: introduce set_tsflags operation
  udp: avoid false sharing via protocol specific set_tsflags

 include/linux/udp.h | 12 ++++++++++++
 include/net/sock.h  | 15 +++++++++++----
 include/net/tcp.h   |  1 +
 net/core/sock.c     | 24 +++++++++---------------
 net/ipv4/tcp.c      | 16 ++++++++++++++++
 net/ipv4/tcp_ipv4.c |  1 +
 net/ipv4/udp.c      |  3 ++-
 net/ipv6/tcp_ipv6.c |  1 +
 net/ipv6/udp.c      |  3 ++-
 9 files changed, 55 insertions(+), 21 deletions(-)

-- 
2.48.1


