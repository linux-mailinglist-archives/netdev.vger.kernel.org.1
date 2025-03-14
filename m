Return-Path: <netdev+bounces-174881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E6A61203
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798B4882611
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541221F4169;
	Fri, 14 Mar 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8w6BQma"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69018A6D7
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957604; cv=none; b=g07bzfGlJYgmmz9cBICcz/cch43aK0R0g3npQX8+n8brCWw8tv5WEEzaNvAPjsEGUj1Lbbr4k/D3cBwFpZo6QzRo1LWgw9QadNalmlW12a2RdP/HQ7HrHjaLJTzTO6vC0Q8cQcQId5zisinj4/zz+JlxdGlVJu16cJ0hjpiIx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957604; c=relaxed/simple;
	bh=3YGKCK+ewOYcd/DScHQdu/MEE/0P9F2IvrvmwgaLrQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUb7Wu5Aw0LrETgNlODLd2RXWX+6a1uH6khOvW1bG1kZgJejcMZtHZGvCJqWq7rZq0QEQuQfHeed2ER1+rLw44uhFJdGiIR4Nf7eU0JdYJoVDnGeRQKsKe7IfTo9UymK7WO87J83/RDmhKzDmbJPbd9Uv4CwTxAhiw3joxINM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8w6BQma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741957601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H4utzkKvWoAtqOsB4M52os8tk1UzkUsgQBxuoUVE5SM=;
	b=g8w6BQma8Hcac+yKUkbjc60jkBEzNGSHMLoe0pL1ZrCEB3RysHeNl85hGTsubBnLLWdr1G
	vsHQ9o1q+/WxXHSuTKUR1zCtT3ucrJA6bm7+r6NYjduC/EbUXuQFRUfpvSmiblbgWVKZKb
	5Sn3EE82PBb/xJJRNr1q8HMBpkhepvg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-ky7eswvTN0W-PXuNjzT77A-1; Fri,
 14 Mar 2025 09:06:38 -0400
X-MC-Unique: ky7eswvTN0W-PXuNjzT77A-1
X-Mimecast-MFC-AGG-ID: ky7eswvTN0W-PXuNjzT77A_1741957596
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B8EA180025B;
	Fri, 14 Mar 2025 13:06:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4193F1955BCB;
	Fri, 14 Mar 2025 13:06:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH 0/2] net: introduce per netns packet type chains
Date: Fri, 14 Mar 2025 14:04:59 +0100
Message-ID: <cover.1741957452.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The stack uses shared lists between all the network namespace to store
all the packet taps not bound to any device.

As a consequence, creating such taps in any namespace affects the
performances in all the network namespaces.

Patch 1 addresses the issue introducing new per network namespace packet
type chains, while patch 2 try to minimize the impact of such addition.

The hotdata implications are IMHO not trivial ence the RFC tag; I
suspect patch 2 being the most controversial. As such a possible
alternative is also presented.

Any feedback welcome!

Paolo Abeni (2):
  net: introduce per netns packet chains
  net: hotdata optimization for netns ptypes

 .../networking/net_cachelines/net_device.rst  |  2 +
 include/linux/netdevice.h                     |  9 +-
 include/net/hotdata.h                         |  1 -
 include/net/net_namespace.h                   |  3 +
 net/core/dev.c                                | 82 +++++++++++++++----
 net/core/hotdata.c                            |  1 -
 net/core/net-procfs.c                         | 16 ++--
 net/core/net_namespace.c                      |  2 +
 8 files changed, 86 insertions(+), 30 deletions(-)

-- 
2.48.1


